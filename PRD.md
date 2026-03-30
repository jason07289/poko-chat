PRODUCT REQUIREMENTS DOCUMENT

# PRD | 포코피아 서식지 대화형 어플리케이션

> 자체 구조화 데이터베이스 + OpenAI 대화 계층 기반 제품 요구사항 문서

| 항목 | 내용 |
| --- | --- |
| 문서 버전 | v0.1 Draft |
| 작성일 | 2026-03-30 |
| 문서 상태 | Draft |
| 권장 구현 | 자체 웹앱 + 내부 DB + OpenAI Responses API/function calling |
| 대상 범위 | MVP ~ v1 |
| 문서 오너 | TBD |

> 권장 의사결정
> • 정답의 원천(source of truth)은 자체 구조화 DB로 둔다.
> • OpenAI는 자연어 질의 해석·도구 호출·응답 생성 계층으로 사용한다.
> • 초기 데이터는 Game8/GameWith로 시드(seed) 구축, Serebii로 교차 검증, OP.GG는 한국어 라벨링·QA 보조로 사용한다.
> • OP.GG는 정책 해석이 엇갈릴 수 있으므로 1차 자동수집 원천으로 삼지 않는다. [R7][R8][R9]

본 문서는 현재 공개 자료와 공식/OpenAI 문서를 2026-03-30 기준으로 재검토하여 작성한 초안이다. 법률 검토가 필요한 항목은 별도 검토를 권장한다.

# 1. 문서 개요

본 제품은 사용자가 포켓몬 이름 또는 서식지 이름을 자연어로 입력하면, 관련 서식지·등장 포켓몬·필요 재료·지역·조건을 대화형으로 조회할 수 있게 하는 한국어 중심의 어플리케이션이다. 예: “부우부가 사는 모든 서식지”, “은은한 빛과 꿈나라로에는 누가 사나?”, “바싹바싹 황야 마을에서 만들 수 있는 야행성 서식지 보여줘”.

핵심 전략은 문서 검색형 RAG가 아니라, 포켓몬·서식지·재료·지역 간 관계를 정규화한 구조화 데이터베이스를 구축하고, OpenAI Responses API와 function calling으로 질의를 적절한 조회 함수로 변환하는 것이다. OpenAI 공식 문서는 Responses API가 도구 확장과 function calling을 지원하는 주 인터페이스라고 설명한다. [R10][R11]

## 문제 정의

- 현재 포코피아의 서식지 정보는 공식 사이트, 게임 내 도감, Game8/GameWith, Serebii, OP.GG 등 여러 소스에 흩어져 있다.

- 유저는 포켓몬 → 서식지, 서식지 → 포켓몬, 지역 → 서식지처럼 양방향/다대다 조회를 빠르게 하고 싶지만, 기존 사이트는 필터·페이지 이동 비용이 크다.

- 정확도와 유지보수성을 위해서는 LLM이 임의 생성한 답이 아니라, 구조화 DB가 반환한 결과를 근거로 응답해야 한다.

## 제품 목표

| ID | 목표 | 설명 |
| --- | --- | --- |
| G1 | 정확한 양방향 조회 | 포켓몬 ↔ 서식지, 서식지 ↔ 포켓몬, 지역 ↔ 서식지 조회를 한 턴 안에 제공 |
| G2 | 조건 정보의 구조화 | 재료, 시간대, 날씨, 바이옴/지역, 이벤트 여부를 표준 필드로 노출 |
| G3 | 한국어 우선 UX | 한국어 명칭·별칭·오타를 흡수하고 자연어로 답변 |
| G4 | 운영 가능한 데이터 체계 | 외부 사이트 의존도가 낮고, 출처와 검증 상태를 추적 가능한 데이터 운영 체계 구축 |

## 비목표

| ID | 비목표 | 설명 |
| --- | --- | --- |
| NG1 | 포코피아 전체 공략 위키 구축 | 스토리, 전체 아이템 공략, 전투 메타 등은 MVP 범위 밖 |
| NG2 | 런타임 웹 스크래핑 기반 응답 | 유저 질문이 들어올 때마다 외부 페이지를 긁어 답하는 구조는 채택하지 않음 |
| NG3 | 제3자 이미지 재호스팅 | MVP에서는 허용된 자체 자산 또는 원본 링크/출처 표시에 한정 |

# 2. 사용자 및 핵심 시나리오

| 사용자 | 니즈 | 대표 시나리오 |
| --- | --- | --- |
| 캐주얼 플레이어 | 특정 포켓몬을 빠르게 만나고 싶다 | “부우부 어디서 나와?”에 대해 서식지·재료·지역을 한 번에 확인 |
| 도감 완성형 유저 | 누락 없는 전수 수집을 원한다 | 특정 지역/시간/날씨 조건이 필요한 서식지까지 좁혀 탐색 |
| 운영자/콘텐츠 관리자 | 데이터 정확도와 변경점을 관리한다 | 새 이벤트/패치 후 변경된 서식지·출현 포켓몬을 diff로 검수 |

## 대표 질의 예시

| 유형 | 예시 질의 | 기대 응답 |
| --- | --- | --- |
| 포켓몬 기반 | 부우부가 사는 모든 서식지 보여줘 | 서식지 목록 + 지역 + 재료 + 검증일 |
| 서식지 기반 | 은은한 빛과 꿈나라로에는 어떤 포켓몬이 살아? | 포켓몬 목록 + 지역 + 재료 |
| 지역/필터 기반 | 바싹바싹 황야 마을에서 밤에 유리한 서식지 추천 | 해당 조건에 맞는 서식지 후보와 이유 |
| 모호한 질의 | 야부엉 나오는 어두운 침대 서식지 | 후보 랭킹 + 바로 결과 또는 최소한의 disambiguation |

# 3. 제품 전략 및 구현 방향

권장 구현은 “완전 수작업 개발”과 “ChatGPT 기능만으로 구현”의 절충이 아니라, 자체 데이터와 백엔드를 소유하면서 OpenAI를 대화 레이어로 활용하는 방식이다. 이 접근은 정확도·확장성·운영 통제 측면에서 가장 균형이 좋다. [R10][R11]

| 옵션 | 장점 | 한계 | 권고 |
| --- | --- | --- | --- |
| A. 자체 앱 + OpenAI API | 정확도·제어권·확장성 우수 / 제품화 적합 | 백엔드와 데이터 모델 구축 필요 | 추천 |
| B. Custom GPT + GPT Actions | 빠른 프로토타입 / ChatGPT 내부 실험 적합 | 빌드는 웹/유료 사용자 전제, 제품 분석·배포 제약 | 보조 |
| C. Apps SDK (ChatGPT 앱) | ChatGPT 안 배포 가능 | MCP 기반 앱 구조 필요, 독립 서비스보단 ChatGPT 생태계 친화적 | 조건부 |

> 권장 결론
> • 1차 출시는 웹 기반 MVP로 시작한다.
> • 대화 계층은 OpenAI Responses API + function calling으로 구현한다. [R10][R11]
> • 채팅 UI는 자체 프런트엔드 또는 ChatKit으로 빠르게 구축할 수 있다. [R12]
> • ChatGPT 안에서의 체험판은 추후 Custom GPT + GPT Actions 또는 Apps SDK로 확장한다. [R13][R14]

# 4. 데이터 수집·검증 전략

포코피아 서식지 데이터는 단계별 신뢰도 체계로 수집한다. Game8은 Habitat Dex 전체와 각 서식지의 제작 조건·등장 포켓몬을 제공하고, GameWith는 출현 포켓몬·필요 아이템·시간/날씨 조건을 포함한 212개 생식지 목록을 제공한다. OP.GG는 209개 서식지와 한국어 명칭·필터 UX를 제공하며, 스스로 공개 인터넷 자료(Serebii 포함) 기반 수동 큐레이션이라고 밝힌다. [R2][R4][R6][R7]

## 4.1 소스 우선순위

| 우선순위 | 소스 | 역할 | 운영 메모 |
| --- | --- | --- | --- |
| Tier 1 | 게임 내 Habitat Dex + 공식 Pokémon 사이트/뉴스 | 정답 원천 / 패치·이벤트 변경 감지 | 가장 신뢰도 높음. 공식 뉴스와 게임 내 검수를 최종 판정에 사용. [R1] |
| Tier 2 | Game8 / GameWith | 초기 시드 데이터 구축 | 서식지·재료·출현 포켓몬·시간/날씨 조건을 대량 수집하기 좋음. [R2][R4] |
| Tier 3 | Serebii | 교차 검증 | 서식지·환경 레벨·포켓몬 정보를 대조하는 보조 기준. [R5] |
| Tier 4 | OP.GG | 한국어 명칭/QA/운영 검수 | 한국어 라벨링과 빠른 대조에 유용하지만 1차 자동수집 원천으로는 비권장. [R6][R7][R8][R9] |

## 4.2 카운팅 규칙

- 표준 서식지는 209개로 관리한다. OP.GG와 일부 가이드는 209 Habitats로 표시한다. [R6]

- 이벤트 서식지 3개를 별도 분류하여 total_habitats = 212로 관리한다. GameWith는 212종(209 일반 + 3 이벤트)으로 명시한다. [R4]

- DB에는 is_event, event_code, active_from, active_to 같은 필드를 별도로 둔다.

## 4.3 수집 파이프라인

| 단계 | 프로세스 | 산출물 |
| --- | --- | --- |
| 1 | 시드 수집 | Game8/GameWith에서 서식지·재료·출현 포켓몬을 CSV 스테이징 테이블로 입력 |
| 2 | 정규화 | 포켓몬명/서식지명/재료명/지역명을 표준 스키마에 맞춰 ID 매핑 |
| 3 | 교차 검증 | Serebii 및 공식/게임 내 정보와 불일치 항목을 표기 |
| 4 | 한국어 보정 | OP.GG 기준 명칭을 참고하되, 자체 표준명을 최종 결정 |
| 5 | QA 승인 | 검증 통과 항목만 production DB 승격; source_record와 verified_at 저장 |

## 4.4 정책/컴플라이언스 원칙

| ID | 원칙 | 설명 |
| --- | --- | --- |
| P1 | OP.GG 자동수집 최소화 | 헬프센터는 일반적 크롤링을 금지하지 않는다고 하나, 약관은 scraping/data mining과 copying을 금지한다. 해석 충돌이 있어 상업 서비스 기준으론 보수적으로 접근. [R8][R9] |
| P2 | 런타임 외부 조회 금지 | 유저 질의 시 외부 웹사이트를 긁지 않고, 사전에 검수한 내부 DB만 조회 |
| P3 | 출처 추적 | 모든 생산 데이터 행에 source_url, source_name, verified_at, confidence_score 저장 |
| P4 | 이미지 정책 분리 | 서식지 이미지 사용은 라이선스 검토 전까지 링크/출처 표기 또는 자체 촬영/자체 제작 자산만 허용 |

# 5. 데이터 모델 초안

| 엔터티 | 핵심 필드 |
| --- | --- |
| pokemon | pokemon_id, name_ko, name_en, ideal_habitat, rarity, notes |
| habitat | habitat_id, habitat_no, name_ko, name_en, location_id, is_event, image_policy, description |
| location | location_id, name_ko, name_en, biome, unlock_rule |
| habitat_requirement | habitat_id, material_id, quantity, qualifier(any 등), sort_order |
| habitat_spawn_rule | habitat_id, pokemon_id, time_condition, weather_condition, biome_condition, rarity |
| alias | entity_type, alias_text, normalized_text, target_id |
| source_record | entity_type, entity_id, source_name, source_url, verified_at, confidence, notes |

설계 원칙: 프롬프트가 아니라 DB가 정답을 가진다. LLM은 질의를 구조화 조회 함수로 연결하는 역할만 수행한다.

# 6. 기능 요구사항 (MVP 중심)

| ID | 요구사항 | 우선순위 | 수용 기준 |
| --- | --- | --- | --- |
| FR-01 | 포켓몬명 입력 시 해당 포켓몬이 등장하는 모든 서식지를 반환 | P0 | 응답에 서식지명·지역·재료·검증일 포함 |
| FR-02 | 서식지명 입력 시 해당 서식지에 등장하는 포켓몬 목록 반환 | P0 | 한 턴 안에 결과 반환; 이벤트 여부 표시 |
| FR-03 | 지역/재료/시간/날씨 조건 필터 지원 | P0 | 조건 필드가 비어있으면 명시적으로 ‘정보 없음’ 처리 |
| FR-04 | 한국어 별칭·오타·영문명 매핑 | P0 | 대표 별칭 세트와 fuzzy matching 동작 |
| FR-05 | 모든 결과에 출처/검증 메타데이터 표시 | P0 | source_count, verified_at, confidence를 UI에서 확인 가능 |
| FR-06 | 운영자 CSV import 및 diff QA | P1 | 신규/수정/삭제 내역을 승인 후 반영 |
| FR-07 | API 함수(tool) 계층 제공 | P0 | get_habitats_by_pokemon 등 최소 5개 함수 노출 |
| FR-08 | 모호한 질의 처리 | P1 | entity 후보를 제시하거나 가장 높은 confidence 결과 우선 제공 |

## 추천 툴 함수

| 함수명 | 역할 |
| --- | --- |
| search_entity(query) | 포켓몬/서식지/지역 후보 식별 |
| get_habitats_by_pokemon(name) | 포켓몬 기반 서식지 조회 |
| get_pokemon_by_habitat(name) | 서식지 기반 포켓몬 조회 |
| get_habitat_detail(name) | 재료, 지역, 시간/날씨, 이벤트 여부 반환 |
| get_habitats_by_location(location) | 지역 기반 서식지 조회 |
| get_related_habitats(filters) | 재료/날씨/시간/바이옴 등 조건 검색 |

# 7. 시스템 아키텍처

> 권장 아키텍처 흐름
> • 클라이언트(Web / Mobile Web / ChatKit)
> • → 애플리케이션 서버(API Gateway, auth, caching, analytics)
> • → OpenAI Responses API (natural language understanding + tool selection)
> • → 내부 조회 함수
> • → PostgreSQL/SQLite + source_record + alias index

| 레이어 | 책임 |
| --- | --- |
| Client | 채팅 UI, 결과 카드, 소스/검증 메타데이터 표시 |
| App Server | 세션 관리, rate limiting, observability, tool orchestration |
| LLM Layer | 질의 해석, 도구 호출 결정, 응답 서술 |
| Data Layer | 정규화된 엔터티 조회, alias/fuzzy match, source provenance |
| Admin Pipeline | CSV import, diff QA, manual verification workflow |

## MVP 배포(테스트용 2단계)

| 항목 | 선택 |
| --- | --- |
| 웹 앱 | Next.js (`web/` 디렉터리) |
| 호스팅 | Vercel |
| DB | Supabase(PostgreSQL) |

환경 변수·로컬 실행·Vercel Root Directory 설정은 `AGENTS.md`를 따른다.

## OpenAI 적용 원칙

- Responses API를 기본 인터페이스로 사용한다. Responses는 stateful interaction과 built-in/custom tools를 지원한다. [R10]

- Function calling으로 내부 DB 조회 함수만 호출하게 하여 응답 근거를 통제한다. [R11]

- 빠른 웹 MVP가 필요하면 ChatKit을 UI 후보로 검토한다. [R12]

- ChatGPT 내부 배포가 필요하면 Apps SDK 또는 GPT Actions를 후속 옵션으로 검토한다. [R13][R14]

# 8. 비기능 요구사항 및 성공 지표

| 영역 | 목표 |
| --- | --- |
| 정확도 | 골드셋 기준 상위 50개 대표 질의 정확도 95% 이상 |
| 지연시간 | DB 직조회 응답 p95 1.5초 이하 / LLM 포함 전체 응답 p95 6초 이하 |
| 감사 가능성 | 응답 100%에 verified_at 또는 source summary 노출 |
| 안정성 | 모델 실패 시에도 구조화 API 결과를 직접 렌더링할 fallback 제공 |
| 운영성 | 데이터 변경 이력과 diff QA 로그를 100% 보존 |

## 핵심 KPI

| KPI | 정의 | 목표 |
| --- | --- | --- |
| Resolved Query Rate | 추가 확인 없이 해결된 질의 비율 | 80%+ |
| Unhandled Query Rate | 결과 없음/모호함으로 종료된 질의 비율 | < 5% |
| Source Coverage | 출처 메타데이터가 연결된 프로덕션 행 비율 | 100% |
| Admin Update SLA | 패치/이벤트 후 데이터 반영까지 걸리는 시간 | 48시간 이내 |

# 9. 출시 단계, 리스크, 오픈 이슈

## 단계별 범위

| 단계 | 범위 |
| --- | --- |
| Phase 0 | 스키마 확정, 시드 CSV 작성, alias 규칙 정의, QA 체크리스트 수립 |
| Phase 1 | DB + 내부 API + 관리자 import/diff 도구 |
| Phase 2 | 대화 UI + OpenAI function calling + 대표 질의 셋 검증 |
| Phase 3 | 운영 지표, 캐싱, 검색 품질 개선, 후속 채널(ChatGPT/모바일) 검토 |

## 주요 리스크 및 대응

| 리스크 | 영향 | 대응 |
| --- | --- | --- |
| 외부 사이트 정책 해석 충돌 | 자동수집/상업화 시 법적 리스크 | 공식/가이드 중심 시드 + 법률 검토 + 내부 DB 운영 [R8][R9] |
| 데이터 드리프트 | 패치·이벤트 후 정보 불일치 | 공식 뉴스 모니터링 + verified_at 기반 재검수 [R1] |
| 한국어 명칭 불일치 | 검색 누락/중복 | alias 테이블과 운영자 교정 워크플로우 |
| LLM 과생성 | 근거 없는 답변 | tool-only grounded response, fallback renderer |
| 이미지/IP | 자산 재사용 리스크 | 라이선스 검토 전까지 링크/자체 자산만 사용 |

## 오픈 이슈

- MVP에서 이미지까지 저장·표시할지, 아니면 source page 링크만 제공할지 결정 필요

- 웹 우선 출시 후 ChatGPT 내부 체험판(Custom GPT 또는 Apps SDK)을 병행할지 결정 필요

- 시간/날씨/희귀도 데이터가 출처 간 상충할 때의 승격 규칙(official > in-game > guide) 명문화 필요

- 상업화 전 third-party data usage 및 상표/이미지 사용 정책 검토 필요

# 10. 참고 자료

아래 자료는 본 PRD의 데이터 전략 및 구현 방향을 검토하기 위해 확인한 주요 외부 문서다.

R1. Pokémon Pokopia official site / news (pokemon.com) — 공식 사이트 및 최신 뉴스.

R2. Game8 — Habitat Dex: How to Build All Habitats — 서식지, 재료, 등장 포켓몬.

R3. Game8 — List of Areas and Biomes — 바이옴/지역 조건 설명.

R4. GameWith — Habitat list (212 total) — 209 일반 + 3 이벤트 명시.

R5. Serebii — Habitats / Environment Level — 교차 검증용.

R6. OP.GG — Pokopia Habitats — 209개 서식지와 한국어 라벨링.

R7. OP.GG — Pokopia Locations footer — 공개 자료 기반 수동 큐레이션 명시.

R8. OP.GG Help Center — Can I use OP.GG data? — 일반적 크롤링 관련 안내.

R9. OP.GG Terms of Use — scraping/data mining 및 copying 제한.

R10. OpenAI — Responses Overview — tool/function calling 지원.

R11. OpenAI — Function Calling — 외부 시스템과 데이터 연결.

R12. OpenAI — ChatKit — 빠른 웹 챗 UI 후보.

R13. OpenAI — Apps SDK — ChatGPT 확장 앱용.

R14. OpenAI — GPT Actions / Creating GPTs — Custom GPT + API 연결.
