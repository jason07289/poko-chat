# 데이터 수집 스키마 확장 설계 (지역·시간·날씨)

목적: Game8 기반 시드에서 현재 비어 있는 `location_id`, `time_condition`, `weather_condition`을 채워
질의 `지역 + 시간 + 날씨` 필터 정확도를 높인다.

## 1) 현재 문제 요약

- `habitats.location_id`가 대부분 null
- `habitat_spawn_rules.time_condition`, `weather_condition`가 null
- 따라서 자연어 질의 "바싹바싹 황야 마을에서 밤이고 비일 때"가 빈 결과로 떨어짐

## 2) 확장 방향

### 2.1 locations 보강

- 수집 JSON에 `location_name_ko`, `location_name_en` 추가
- 적재 시 `locations` upsert 후 `habitats.location_id` 연결
- alias도 함께 생성:
  - `바싹바싹 황야`
  - `바싹바싹 황야 마을`
  - 영어명 별칭

### 2.2 spawn 조건 보강

- 수집 JSON에 `time_condition`, `weather_condition`, `biome_condition` 추가
- `habitat_spawn_rules` 적재 시 null 대신 실제 문자열 저장
- 정규화 사전 예시:
  - time: `night`, `day`, `all`
  - weather: `rain`, `sun`, `cloudy`, `all`

## 3) DB 스키마 변경 필요 여부

기존 컬럼으로 수용 가능하므로 **DDL 변경 없이** 우선 진행 가능:

- `habitats.location_id` (기존)
- `habitat_spawn_rules.time_condition` (기존)
- `habitat_spawn_rules.weather_condition` (기존)
- `habitat_spawn_rules.biome_condition` (기존)

추후 품질 강화를 위해 권장되는 확장:

- `habitat_spawn_rules.time_key` (enum/text, 정규화 키)
- `habitat_spawn_rules.weather_key` (enum/text, 정규화 키)
- `source_records.notes`에 정규화 근거 기록

## 4) 파이프라인 변경 포인트

- `scripts/tier2-fetch/fetch-game8.mjs`
  - location/time/weather 원본 필드 수집
- `scripts/tier2-fetch/enrich-game8-ko.mjs`
  - 한국어 매핑/정규화 규칙 적용
- `scripts/tier2-fetch/import-enriched.mjs`
  - `locations` upsert + `location_id` 연결
  - `habitat_spawn_rules`에 조건 필드 삽입
- `scripts/tier2-fetch/build-sql-seed.mjs`
  - 동일 로직으로 SQL seed 생성

## 5) 검증 항목 (QA)

- 지역 질의: `바싹바싹 황야 마을의 서식지 알려줘` 결과 > 0
- 시간 질의: `밤 서식지` 결과 > 0
- 날씨 질의: `비 오는 날 서식지` 결과 > 0
- 복합 질의: 지역+시간+날씨 결과가 빈 경우, 데이터 부족 안내가 아닌 실제 필터 결과 반환

## 6) 롤아웃 전략

1. 수집 스크립트 수정
2. 테스트 JSON 20건으로 dry-run
3. Supabase 스테이징에 적재
4. 골드셋 GS-06~GS-10 재실행
5. 본 시드 재생성 및 반영

## 7) 실행 티켓 (파일 단위)

아래 티켓 순서대로 진행하면 병목 없이 구현 가능하다.

### T1. 조건 정규화 사전 정의

- 대상: `scripts/tier2-fetch/enrich-game8-ko.mjs`
- 작업:
  - time/weather 원문을 정규화 키로 매핑하는 사전 추가
  - 미매핑 값은 `unknown`으로 저장
- 완료 기준:
  - `time_condition_key`, `weather_condition_key` 필드가 enriched JSON에 존재

### T2. 지역명 파싱/매핑 로직 추가

- 대상: `scripts/tier2-fetch/fetch-game8.mjs`, `scripts/tier2-fetch/enrich-game8-ko.mjs`
- 작업:
  - 서식지별 지역명 원문 추출
  - `location_name_ko`, `location_name_en` 채우기
- 완료 기준:
  - 표본 20건에서 지역명 누락률 10% 이하

### T3. enriched JSON 스키마 확장

- 대상: `scripts/tier2-fetch/out/*.json` 생성 경로
- 작업:
  - 신규 필드 반영:
    - `location_name_ko`, `location_name_en`
    - `time_condition_raw`, `weather_condition_raw`
    - `time_condition_key`, `weather_condition_key`
- 완료 기준:
  - 샘플 파일 구조 검증 통과(필드 존재/타입 일치)

### T4. DB import 로직 확장 (REST import)

- 대상: `scripts/tier2-fetch/import-enriched.mjs`
- 작업:
  - `locations` upsert 구현
  - `habitats.location_id` 연결
  - `habitat_spawn_rules.time_condition`, `weather_condition` 저장
- 완료 기준:
  - import 후 location_id null 비율, 조건 null 비율이 유의미하게 감소

### T5. SQL seed 생성 로직 확장

- 대상: `scripts/tier2-fetch/build-sql-seed.mjs`
- 작업:
  - T4와 동일 규칙을 SQL 생성에도 반영
  - `seed_game8.sql`이 REST import와 동일 결과를 내도록 동기화
- 완료 기준:
  - SQL Editor 적용 결과가 REST import 결과와 핵심 지표 일치

### T6. alias 보강 (지역 질의 대응)

- 대상: `scripts/tier2-fetch/import-enriched.mjs` (또는 별도 alias 빌더)
- 작업:
  - 지역 alias 자동 생성:
    - `~마을`, 조사 제거형(`~에서`, `~의`) 대응 가능한 기본형
- 완료 기준:
  - `resolveLocationId`가 대표 자연어 표현 3종 이상 매칭

### T7. 데이터 품질 점검 스크립트

- 대상: `scripts/tier2-fetch/` 신규 스크립트(예: `verify-coverage.mjs`)
- 작업:
  - 아래 지표 출력:
    - `habitats.location_id` 채움률
    - spawn `time_condition` 채움률
    - spawn `weather_condition` 채움률
- 완료 기준:
  - CI/수동 실행에서 지표 확인 가능

### T8. QA 재검증 및 기록

- 대상: `docs/qa-goldset.md`
- 작업:
  - `GS-06-R`~`GS-10-R` 재검증
  - P/F 및 D/R/U/M/S 태깅 기록
- 완료 기준:
  - 4개 전부 P 또는 실패 원인/수정 계획 명확화
