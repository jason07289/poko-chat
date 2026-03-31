# Supabase 스키마

## 적용 방법

1. [Supabase](https://supabase.com) 프로젝트 → **SQL Editor**.
2. `migrations/20260331000000_init.sql` 내용을 붙여 넣고 실행한다.
3. (선택) 개발용 최소 데이터가 필요하면 `seed.sql` 을 이어서 실행한다.

Supabase CLI를 쓰는 경우 저장소 루트에서 `supabase link` 후 `supabase db push` 로 동일 마이그레이션을 적용할 수 있다.

## 파일

| 파일 | 설명 |
| --- | --- |
| `migrations/20260331000000_init.sql` | 테이블·인덱스·RLS(읽기 공개) |
| `seed.sql` | 예시 지역·포켓몬·서식지·spawn·alias·source 한 세트 |

스키마 상세·카운팅·CSV 스펙은 `docs/data-model.md` 를 본다.
