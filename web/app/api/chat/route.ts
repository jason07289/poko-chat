import { NextResponse } from "next/server";

import { runHabitatChat, type ChatTurn } from "@/lib/chat/run-response";
import { getOpenAI } from "@/lib/openai";
import { hasSupabasePublicKey } from "@/lib/supabase/env";
import { createSupabaseAnonClient } from "@/lib/supabase/server";

export const runtime = "nodejs";

export async function POST(request: Request) {
  if (!hasSupabasePublicKey()) {
    return NextResponse.json(
      { error: "NEXT_PUBLIC_SUPABASE_* 키가 설정되지 않았습니다." },
      { status: 503 },
    );
  }

  let body: unknown;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: "Invalid JSON" }, { status: 400 });
  }

  const messages = (body as { messages?: ChatTurn[] }).messages;
  if (!Array.isArray(messages) || messages.length === 0) {
    return NextResponse.json(
      { error: "messages 배열이 필요합니다." },
      { status: 400 },
    );
  }

  const last = messages[messages.length - 1];
  if (last.role !== "user") {
    return NextResponse.json(
      { error: "마지막 메시지는 user 여야 합니다." },
      { status: 400 },
    );
  }

  try {
    const openai = getOpenAI();
    const supabase = createSupabaseAnonClient();
    const { reply, responseId } = await runHabitatChat(
      openai,
      supabase,
      messages,
    );
    return NextResponse.json({ reply, responseId });
  } catch (e) {
    const message = e instanceof Error ? e.message : "chat failed";
    return NextResponse.json({ error: message }, { status: 502 });
  }
}
