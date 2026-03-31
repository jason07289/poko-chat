# Supabase 스키마

## 적용 방법

1. [Supabase](https://supabase.com) 프로젝트 → **SQL Editor**.
2. `migrations/20260331000000_init.sql` 내용을 붙여 넣고 실행한다.
3. (선택) 개발용 최소 데이터가 필요하면 `seed.sql` 을 이어서 실행한다.

**Game8 보강 데이터 일괄 넣기**

1. `scripts/tier2-fetch`에서 `npm run enrich:ko` → `out/game8-habitats.enriched.json`
2. **방법 A:** `npm run build:sql` → 루트에 `supabase/seed_game8.sql` 생성 → Supabase **SQL Editor**에서 파일 내용 실행 (서비스 키 불필요).
3. **방법 B:** `web/.env.local`에 `SUPABASE_SECRET_KEY`(또는 `SUPABASE_SERVICE_ROLE_KEY`) 설정 후 `npm run import:db` (REST로 직접 삽입).

`import:db` / `seed_game8.sql` 모두 기존 `pokemon`·`habitats`·`habitat_spawn_rules`·`habitat_requirements`·`aliases`·`source_records`를 비우고 덮어쓴다.

Supabase CLI를 쓰는 경우 저장소 루트에서 `supabase link` 후 `supabase db push` 로 동일 마이그레이션을 적용할 수 있다.

## 파일

| 파일 | 설명 |
| --- | --- |
| `migrations/20260331000000_init.sql` | 테이블·인덱스·RLS(읽기 공개) |
| `seed.sql` | 예시 지역·포켓몬·서식지·spawn·alias·source 한 세트 |

스키마 상세·카운팅·CSV 스펙은 `docs/data-model.md` 를 본다.
