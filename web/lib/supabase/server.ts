import { createClient, type SupabaseClient } from "@supabase/supabase-js";

import { getSupabasePublicKey, getSupabaseUrl } from "./env";

/**
 * 서버(Route Handler, Server Component)에서 사용하는 공개 권한 클라이언트.
 * RLS가 허용하는 범위에서만 조회·변경한다.
 */
export function createSupabaseAnonClient(): SupabaseClient {
  return createClient(getSupabaseUrl(), getSupabasePublicKey());
}
