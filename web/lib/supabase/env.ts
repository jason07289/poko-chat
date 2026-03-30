/**
 * Supabase 대시보드는 Legacy JWT 키와 새 API 키(sb_publishable_ / sb_secret_)를 병행한다.
 * 둘 중 하나만 채우면 된다. (@supabase/supabase-js 는 동일하게 createClient(url, key) 사용)
 */
export function getSupabaseUrl(): string {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL?.trim();
  if (!url) {
    throw new Error("Missing NEXT_PUBLIC_SUPABASE_URL");
  }
  return url;
}

/** 공개용: 브라우저에 노출 가능. Publishable(권장) 또는 Legacy anon 중 하나 */
export function getSupabasePublicKey(): string {
  const key =
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY?.trim() ||
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim();
  if (!key) {
    throw new Error(
      "Set NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY (new) or NEXT_PUBLIC_SUPABASE_ANON_KEY (legacy)",
    );
  }
  return key;
}

/** 서버 전용: Secret(권장) 또는 Legacy service_role 중 하나 */
export function getSupabaseServiceKey(): string {
  const key =
    process.env.SUPABASE_SECRET_KEY?.trim() ||
    process.env.SUPABASE_SERVICE_ROLE_KEY?.trim();
  if (!key) {
    throw new Error(
      "Set SUPABASE_SECRET_KEY (new) or SUPABASE_SERVICE_ROLE_KEY (legacy)",
    );
  }
  return key;
}

export function hasSupabasePublicKey(): boolean {
  return Boolean(
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY?.trim() ||
      process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim(),
  );
}

export function hasSupabaseServiceKey(): boolean {
  return Boolean(
    process.env.SUPABASE_SECRET_KEY?.trim() ||
      process.env.SUPABASE_SERVICE_ROLE_KEY?.trim(),
  );
}
