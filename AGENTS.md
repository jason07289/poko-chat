# poko-chat — 에이전트·개발자 온보딩

PRD는 `PRD.md`를 따른다. 이 문서는 **2단계(MVP 테스트 배포)** 기준으로 로컬 실행·Vercel·Supabase 연결 방법을 정리한다.

## 레포 구조

| 경로 | 역할 |
| --- | --- |
| `PRD.md` | 제품 요구사항 |
| `WBS.md` | 작업분해구조 |
| `docs/data-model.md` | 스키마·시드·alias 요약 |
| `supabase/migrations/` | PostgreSQL DDL (대시보드 또는 CLI 적용) |
| `web/` | Next.js 앱 (App Router) |
| `web/.env.local` | 로컬 비밀 (Git에 넣지 않음) |
| `web/.env.example` | 필요한 환경 변수 이름만 |

## 로컬 실행

```bash
cd web
cp .env.example .env.local
# .env.local 에 Supabase·OpenAI 값 채우기
npm install
npm run dev
# 단위 테스트: npm test  (Vitest, `web/` 기준)
```

- 앱: http://localhost:3000  
- 헬스(환경 변수 존재 여부만): http://localhost:3000/api/health  

## Supabase

1. [Supabase](https://supabase.com)에서 프로젝트 생성 (PostgreSQL).
2. **Project Settings → API Keys** (`/settings/api-keys`): 아래 중 **한 세트**만 채우면 된다.
   - **권장(새 키):** `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY`(Publishable) + 필요 시 `SUPABASE_SECRET_KEY`(Secret).
   - **Legacy:** `NEXT_PUBLIC_SUPABASE_ANON_KEY`(anon public) + 필요 시 `SUPABASE_SERVICE_ROLE_KEY`(service_role).
3. 항상 `NEXT_PUBLIC_SUPABASE_URL`은 Project URL과 동일하게 넣는다.
4. Secret / service_role 은 서버 전용이다. RLS를 우회하므로 클라이언트·공개 저장소에 노출하지 않는다. DB를 대시보드 SQL로만 다루면 로컬에서 Secret 을 비워 둘 수 있다.

스키마·마이그레이션은 `supabase/migrations/` 의 SQL을 대시보드 SQL Editor에 붙여 실행하거나, Supabase CLI로 적용한다. 절차는 `supabase/README.md` 를 본다.

## Vercel 배포

1. GitHub 등에 레포를 올린 뒤 [Vercel](https://vercel.com)에서 Import.
2. **Root Directory**를 `web`로 설정한다.
3. Environment Variables에 `web/.env.example`에 나온 이름과 동일하게 값을 넣는다 (Production·Preview 모두 필요 시 복제).

`OPENAI_API_KEY`, `SUPABASE_SECRET_KEY`, `SUPABASE_SERVICE_ROLE_KEY`는 **서버 전용**이다. `NEXT_PUBLIC_*`만 브라우저에 노출된다.

## 코드 위치 (확장 시)

| 용도 | 파일 |
| --- | --- |
| Supabase 환경 변수 해석 | `web/lib/supabase/env.ts` |
| Supabase (공개 권한, 서버) | `web/lib/supabase/server.ts` |
| Supabase (Secret/service_role, 서버만) | `web/lib/supabase/service.ts` |
| OpenAI 클라이언트 | `web/lib/openai.ts` |
| 채팅(Responses·도구) | `web/lib/chat/`, `web/app/api/chat/route.ts` |
| 헬스 체크 | `web/app/api/health/route.ts` |
| DB 타입·조회·툴 함수 | `web/lib/db/` (`types.ts`, `queries.ts`) |

대화·Responses API·function calling·DB 조회 API는 `web/app/api/` 아래 Route Handler로 추가하는 것을 권장한다.
