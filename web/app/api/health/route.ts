import { NextResponse } from "next/server";

import {
  hasSupabasePublicKey,
  hasSupabaseServiceKey,
} from "@/lib/supabase/env";

/**
 * 배포·모니터링용. 비밀 값은 노출하지 않는다.
 */
export function GET() {
  const hasSupabaseUrl = Boolean(process.env.NEXT_PUBLIC_SUPABASE_URL?.trim());
  const hasOpenAI = Boolean(process.env.OPENAI_API_KEY?.trim());

  return NextResponse.json({
    ok: true,
    env: {
      supabaseUrl: hasSupabaseUrl,
      supabasePublicKey: hasSupabasePublicKey(),
      supabaseServiceKey: hasSupabaseServiceKey(),
      openai: hasOpenAI,
    },
  });
}
