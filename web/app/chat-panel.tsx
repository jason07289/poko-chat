"use client";

import { useState } from "react";
import { renderTraceCard, type ToolTrace } from "./components/chat-trace-cards";

type Msg = {
  role: "user" | "assistant";
  content: string;
  traces?: ToolTrace[];
};

export function ChatPanel() {
  const [messages, setMessages] = useState<Msg[]>([]);
  const [input, setInput] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function send() {
    const text = input.trim();
    if (!text || loading) return;
    setInput("");
    setError(null);
    const next: Msg[] = [...messages, { role: "user", content: text }];
    setMessages(next);
    setLoading(true);
    try {
      const res = await fetch("/api/chat", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ messages: next }),
      });
      const data = (await res.json()) as {
        reply?: string;
        error?: string;
        traces?: ToolTrace[];
      };
      if (!res.ok) {
        setError(data.error ?? "요청 실패");
        return;
      }
      setMessages([
        ...next,
        {
          role: "assistant",
          content: data.reply ?? "",
          traces: Array.isArray(data.traces) ? data.traces : [],
        },
      ]);
    } catch {
      setError("네트워크 오류");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="flex w-full flex-col gap-4 rounded-xl border border-zinc-200 bg-white p-4 shadow-sm dark:border-zinc-800 dark:bg-zinc-900">
      <div className="min-h-[240px] max-h-[min(50vh,420px)] space-y-3 overflow-y-auto text-sm">
        {messages.length === 0 ? (
          <p className="text-zinc-500 dark:text-zinc-400">
            포켓몬·서식지에 대해 한국어로 질문해 보세요. (DB에 시드가 있어야
            답이 나옵니다.)
          </p>
        ) : (
          messages.map((m, i) => (
            <div
              key={`${i}-${m.role}`}
              className={
                m.role === "user"
                  ? "ml-8 rounded-lg bg-emerald-50 px-3 py-2 text-zinc-900 dark:bg-emerald-950/40 dark:text-zinc-100"
                  : "mr-8 rounded-lg bg-zinc-100 px-3 py-2 text-zinc-900 dark:bg-zinc-800 dark:text-zinc-100"
              }
            >
              <p className="text-xs font-medium text-zinc-500 dark:text-zinc-400">
                {m.role === "user" ? "나" : "어시스턴트"}
              </p>
              <p className="whitespace-pre-wrap leading-relaxed">{m.content}</p>
              {m.role === "assistant" && (m.traces?.length ?? 0) > 0 ? (
                <div>
                  {m.traces?.map((trace, idx) => renderTraceCard(trace, idx))}
                </div>
              ) : null}
            </div>
          ))
        )}
      </div>
      {error ? (
        <p className="text-sm text-red-600 dark:text-red-400">{error}</p>
      ) : null}
      <div className="flex gap-2">
        <input
          type="text"
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === "Enter" && !e.shiftKey) {
              e.preventDefault();
              void send();
            }
          }}
          placeholder="예: 부우부가 나오는 서식지 알려줘"
          className="min-w-0 flex-1 rounded-lg border border-zinc-300 bg-white px-3 py-2 text-zinc-900 placeholder:text-zinc-400 focus:border-emerald-600 focus:outline-none focus:ring-1 focus:ring-emerald-600 dark:border-zinc-600 dark:bg-zinc-950 dark:text-zinc-50"
          disabled={loading}
        />
        <button
          type="button"
          onClick={() => void send()}
          disabled={loading || !input.trim()}
          className="shrink-0 rounded-lg bg-emerald-700 px-4 py-2 text-sm font-medium text-white hover:bg-emerald-800 disabled:opacity-50 dark:bg-emerald-600 dark:hover:bg-emerald-500"
        >
          {loading ? "…" : "보내기"}
        </button>
      </div>
    </div>
  );
}
