# WBS | 포코피아 서식지 대화형 앱

작업분해구조(Work Breakdown Structure). 요구사항은 `PRD.md`를 따른다. 구현·배포 절차는 `AGENTS.md`를 따른다.

| 항목 | 내용 |
| --- | --- |
| 문서 버전 | v0.1 |
| 기준 문서 | PRD v0.1 Draft |
| 앱 경로 | `web/` (Next.js) |

## 0. 표기 규칙

| 표기 | 의미 |
| --- | --- |
| **선행** | 이 작업이 끝나야 착수 가능한 WBS ID |
| **산출물** | 완료 시 남는 결과물 |
| **FR** | `PRD.md` §6 기능 요구사항 ID |

---

## 1. Phase 0 — 스키마·시드·QA 기준

| ID | 작업 | 산출물 | 선행 | FR 매핑 |
| --- | --- | --- | --- | — |
| 1.1 | 엔터티·관계 확정 (`pokemon`, `habitat`, `location`, `material`, `habitat_requirement`, `habitat_spawn_rule`, `alias`, `source_record` 등) | ERD 또는 스키마 문서 초안 | — | FR-03~05 |
| 1.2 | Supabase(PostgreSQL) DDL·마이그레이션 경로 확정 | SQL 파일 또는 대시보드 마이그레이션 로그 | 1.1 | — |
| 1.3 | 209 일반 / 212(이벤트 3) 카운팅·`is_event`·이벤트 기간 필드 규칙 문서화 | 데이터 사전 일부 | 1.1 | FR-02 |
| 1.4 | 시드 CSV 컬럼 정의·스테이징 테이블(선택) 설계 | 시드 스펙 문서 | 1.1 | — |
| 1.5 | 1차 시드 수집·입력(Game8/GameWith 등, PRD Tier 정책 준수) | 시드 데이터셋 | 1.2, 1.4 | FR-01, FR-02 |
| 1.6 | `alias` 규칙·정규화·fuzzy 매칭 전략 초안 | alias 정책 문서 | 1.1 | FR-04 |
| 1.7 | 골드셋 질의 목록·QA 체크리스트 | 평가용 질의 세트 | — | PRD §8 정확도 |

---

## 2. Phase 1 — 데이터 계층·내부 조회

| ID | 작업 | 산출물 | 선행 | FR 매핑 |
| --- | --- | --- | --- | — |
| 2.1 | Supabase RLS·역할(anon / service) 정책 초안 | 정책 메모 또는 SQL | 1.2 | — |
| 2.2 | 서버 전용 DB 접근 패턴 정리 (`web/lib/supabase/service.ts` 등 활용) | 코드·환경 변수 정합 | 2.1 | — |
| 2.3 | 엔티티 조회·alias 해석 모듈 (TypeScript) | `web/lib/db/` 등 | 1.5, 1.6, 2.2 | FR-04 |
| 2.4 | Tool용 순수 함수: `search_entity`, `get_habitats_by_pokemon`, `get_pokemon_by_habitat`, `get_habitat_detail`, `get_habitats_by_location`, `get_related_habitats` | 구현 + 단위/통합 테스트(선택) | 2.3 | FR-01~03, FR-07 |
| 2.5 | 출처·검증 메타 집계 (`verified_at`, confidence, source 요약) | 공통 응답 형태 | 2.3 | FR-05 |

---

## 3. Phase 2 — 대화 API·UI (MVP 테스트 배포)

| ID | 작업 | 산출물 | 선행 | FR 매핑 |
| --- | --- | --- | --- | — |
| 3.1 | OpenAI Responses API 라우트: 세션/메시지 수신, tool 정의 연결 | `web/app/api/.../route.ts` | 2.4 | FR-07 |
| 3.2 | Tool 호출 → 2.4 함수 실행 → 모델에 근거 반환 루프 | 스트리밍 또는 동기 응답 | 3.1 | FR-01~03 |
| 3.3 | 모델/도구 실패 시 구조화 결과만 노출하는 fallback | UI 또는 API 분기 | 3.2 | PRD §8 안정성 |
| 3.4 | 채팅 UI (메시지 목록, 입력, 로딩·에러) | 페이지/컴포넌트 | 3.1 | — |
| 3.5 | 결과 카드: 서식지·포켓몬·재료·지역·이벤트 + 메타데이터 표시 | 컴포넌트 | 3.4, 2.5 | FR-05 |
| 3.6 | 모호한 질의: 후보 나열 또는 confidence 우선 응답 | 프롬프트 + 2.4 연동 | 3.2 | FR-08 |
| 3.7 | Vercel 배포 검증 (Root `web`, 환경 변수) | 프리뷰/프로덕션 동작 | 3.1~3.4 | AGENTS.md |

---

## 4. Phase 3 — 운영·품질·확장

| ID | 작업 | 산출물 | 선행 | 비고 |
| --- | --- | --- | --- | --- |
| 4.1 | 골드셋 자동/반자동 평가 (정확도·Unhandled Rate) | 스크립트 또는 체크리스트 | 1.7, 3.2 | PRD §8 |
| 4.2 | 관측: 로깅, 기본 rate limit, 지연 모니터링 | 설정·대시보드(선택) | 3.7 | — |
| 4.3 | 캐싱·핫 쿼리 최적화 | 구현 | 4.2 | — |
| 4.4 | 운영자 CSV import·diff·승인 워크플로 (FR-06) | 관리 UI 또는 CLI | 1.4, 2.1 | P1 |
| 4.5 | ChatGPT 연동 후보 (Custom GPT / Apps SDK) 검토 | 결정 메모 | 3.7 | PRD §6~7 |

---

## 5. 의존성 요약 (한 줄)

```
1.* (스키마·시드) → 2.* (조회·tools) → 3.* (Responses·UI·배포) → 4.* (지표·운영·확장)
```

---

## 6. 현재 레포 기준 상태 (참고)

| 구간 | 상태 |
| --- | --- |
| `web/` Next.js·헬스·Supabase/OpenAI 클라이언트 뼈대 | 존재 |
| Phase 0 DDL (`supabase/migrations/20260331000000_init.sql`)·시드 (`supabase/seed.sql`)·문서 (`docs/data-model.md`, `docs/qa-goldset.md`) | 추가됨 |
| Phase 1 RLS·조회 모듈·툴 함수 (`search_entity`, `get_*` 6종, `summarizeProvenanceForEntity`) | `web/lib/db/queries.ts` |
| 실제 Supabase 프로젝트에 마이그레이션·시드 적용 | 대시보드에서 수동 실행 필요 (`supabase/README.md`) |
| Responses API (`/api/chat`)·홈 채팅 UI | `web/app/api/chat/route.ts`, `web/app/chat-panel.tsx` |
| 결과 카드·출처 UI 고도화·모호 질의 프롬프트 튜닝 | 부분적 (후속) |

이 표는 구현이 진행될 때마다 갱신하는 것을 권장한다.
