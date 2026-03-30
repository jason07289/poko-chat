import Link from "next/link";

export default function Home() {
  return (
    <div className="flex min-h-full flex-1 flex-col bg-zinc-50 text-zinc-900 dark:bg-zinc-950 dark:text-zinc-50">
      <main className="mx-auto flex w-full max-w-2xl flex-1 flex-col justify-center gap-10 px-6 py-16">
        <div className="space-y-3">
          <p className="text-sm font-medium text-emerald-700 dark:text-emerald-400">
            poko-chat · MVP
          </p>
          <h1 className="text-3xl font-semibold tracking-tight sm:text-4xl">
            포코피아 서식지 대화형 앱
          </h1>
          <p className="text-lg leading-relaxed text-zinc-600 dark:text-zinc-400">
            구조화 DB로 정확한 정보를 조회하고, OpenAI로 자연어 질의를 해석하는
            제품을 만들고 있습니다. 여기는 지금 홈 화면 자리입니다.
          </p>
        </div>

        <ul className="list-inside list-disc space-y-2 text-sm text-zinc-600 dark:text-zinc-400">
          <li>채팅 UI·API 연동은 다음 작업에서 붙입니다.</li>
          <li>
            로컬 연결 확인:{" "}
            <Link
              href="/api/health"
              className="font-medium text-emerald-700 underline underline-offset-2 hover:text-emerald-700 dark:text-emerald-400"
            >
              /api/health
            </Link>
          </li>
        </ul>
      </main>
    </div>
  );
}
