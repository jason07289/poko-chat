import "server-only";

import { createClient, type SupabaseClient } from "@supabase/supabase-js";

import { getSupabaseServiceKey, getSupabaseUrl } from "./env";

/**
 * 서버 전용. Secret / service_role 은 브라우저·클라이언트 번들에 넣지 않는다.
 * 관리자 import·마이그레이션 보정 등 신뢰된 서버 코드에서만 사용.
 */
export function createSupabaseServiceClient(): SupabaseClient {
  return createClient(getSupabaseUrl(), getSupabaseServiceKey());
}
