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
