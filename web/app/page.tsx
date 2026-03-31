import Link from "next/link";

import { ChatPanel } from "./chat-panel";

export default function Home() {
  return (
    <div className="flex min-h-full flex-1 flex-col bg-zinc-50 text-zinc-900 dark:bg-zinc-950 dark:text-zinc-50">
      <main className="mx-auto flex w-full max-w-2xl flex-1 flex-col gap-10 px-6 py-16">
        <div className="space-y-3">
          <p className="text-sm font-medium text-emerald-700 dark:text-emerald-400">
            poko-chat · MVP
          </p>
          <h1 className="text-3xl font-semibold tracking-tight sm:text-4xl">
            포코피아 서식지 대화형 앱
          </h1>
          <p className="text-lg leading-relaxed text-zinc-600 dark:text-zinc-400">
            구조화 DB로 조회하고, OpenAI Responses API로 자연어를 도구 호출로
            연결합니다. Supabase에 스키마·시드를 적용한 뒤 질문해 보세요.
          </p>
        </div>

        <ChatPanel />

        <ul className="list-inside list-disc space-y-2 text-sm text-zinc-600 dark:text-zinc-400">
          <li>
            환경·키 확인:{" "}
            <Link
              href="/api/health"
              className="font-medium text-emerald-700 underline underline-offset-2 hover:text-emerald-700 dark:text-emerald-400"
            >
              /api/health
            </Link>
          </li>
          <li>
            DB 스키마는 레포의 <code className="text-zinc-800 dark:text-zinc-200">supabase/migrations/</code>{" "}
            를 Supabase SQL Editor에 실행합니다.
          </li>
        </ul>
      </main>
    </div>
  );
}
