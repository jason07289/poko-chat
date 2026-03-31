# 데이터 모델 · 시드 · alias (Phase 0)

`PRD.md` §4~§5와 `WBS.md` 1.1·1.3·1.4·1.6에 대응한다. DDL 원본은 `supabase/migrations/20260331000000_init.sql` 이다.

## 1. 엔터티와 관계

| 테이블 | 역할 |
| --- | --- |
| `materials` | 재료 마스터 |
| `locations` | 지역·바이옴 |
| `pokemon` | 포켓몬 |
| `habitats` | 서식지 (이벤트 플래그·기간 포함) |
| `habitat_requirements` | 서식지 ↔ 재료 (수량·qualifier) |
| `habitat_spawn_rules` | 서식지 ↔ 포켓몬 (시간·날씨·바이옴·희귀도; 비어 있으면 UI에서 ‘정보 없음’) |
| `aliases` | 별칭·오타·다국어 → `entity_kind` + `target_id` |
| `source_records` | 출처·검증일·confidence |

관계 요약: `locations` 1 — N `habitats`; `habitats` N — M `pokemon` (`habitat_spawn_rules`); `habitats` N — M `materials` (`habitat_requirements`).

## 2. 서식지 카운팅 (WBS 1.3)

| 개념 | 규칙 |
| --- | --- |
| 일반 서식지 | 209종 (가이드·OP.GG 등과 정합) |
| 이벤트 서식지 | 3종 별도 분류 |
| 합계 | 212 = 209 + 3 (`PRD` §4.2) |

DB 표현: `habitats.is_event`, `event_code`, `active_from` / `active_to` (이벤트 기간). `habitat_no` 는 프로젝트에서 부여하는 표준 번호(양의 정수, unique)로 두고, 209/212 집계는 `is_event` 로 구분한다.

## 3. 시드 CSV (스테이징용 스펙, WBS 1.4)

대량 시드는 CSV → 스테이징 테이블 → 정규화 매핑 후 본 테이블 승격 흐름을 권장한다. 컬럼 예시는 아래와 같다.

**staging_pokemon.csv**

| 컬럼 | 설명 |
| --- | --- |
| `name_ko` | 표준 한국어 명 |
| `name_en` | 영문 |
| `ideal_habitat` | 선택 |
| `rarity` | 선택 |

**staging_habitat.csv**

| 컬럼 | 설명 |
| --- | --- |
| `habitat_no` | 표준 번호 |
| `name_ko`, `name_en` | 명칭 |
| `location_name_ko` | 지역명 (locations 와 매핑) |
| `is_event` | true/false |
| `event_code`, `active_from`, `active_to` | 이벤트용 |

**staging_spawn.csv**

| 컬럼 | 설명 |
| --- | --- |
| `habitat_no` 또는 `habitat_name_ko` | 서식지 키 |
| `pokemon_name_ko` | 포켓몬 키 |
| `time_condition`, `weather_condition`, `biome_condition`, `rarity` | 없으면 빈 칸 |

**staging_requirement.csv**

| 컬럼 | 설명 |
| --- | --- |
| `habitat_no` | 서식지 |
| `material_name_ko` | 재료 |
| `quantity`, `qualifier`, `sort_order` | |

실제 파일명·추가 컬럼은 수집 파이프라인에 맞게 조정한다.

## 4. alias 정책 (WBS 1.6)

| 항목 | 규칙 |
| --- | --- |
| `normalized_text` | 검색·유일성용. 예: NFKC 정규화 후 소문자(한글은 그대로), 공백 트림 |
| 유일성 | `(entity_kind, normalized_text)` 당 하나의 `target_id` |
| 오타·별칭 | 동일 엔터티에 여러 행 허용 (다른 `alias_text`) |
| fuzzy | DB는 exact + `normalized_text` 우선; 추가로 앱/쿼리에서 `pg_trgm` 또는 유사도 검색을 붙일 수 있음 |

## 5. 적용 순서

1. `supabase/migrations/20260331000000_init.sql` 실행  
2. (선택) `supabase/seed.sql` 실행  

자세한 절차는 `supabase/README.md` 를 본다.
