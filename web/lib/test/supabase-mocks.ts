import type { SupabaseClient } from "@supabase/supabase-js";

/** searchEntity 가 순서대로 조회하는 테이블에 맞춘 최소 목 클라이언트 */
export function createSearchEntityMock(opts: {
  aliases?: Array<{
    entity_kind: string;
    target_id: string;
    alias_text: string;
  }>;
  pokemon?: Array<{ id: string; name_ko: string }>;
  habitats?: Array<{ id: string; name_ko: string }>;
  locations?: Array<{ id: string; name_ko: string }>;
  materials?: Array<{ id: string; name_ko: string }>;
}): SupabaseClient {
  const aliasData = opts.aliases ?? [];
  const pokemonData = opts.pokemon ?? [];
  const habitatData = opts.habitats ?? [];
  const locationData = opts.locations ?? [];
  const materialData = opts.materials ?? [];

  const ok = <T>(data: T) => Promise.resolve({ data, error: null });

  return {
    from: (table: string) => {
      if (table === "aliases") {
        return {
          select: () => ({
            ilike: () => ({
              limit: () => ok(aliasData),
            }),
          }),
        };
      }
      if (table === "pokemon") {
        return {
          select: () => ({
            or: () => ({
              limit: () => ok(pokemonData),
            }),
          }),
        };
      }
      if (table === "habitats") {
        return {
          select: () => ({
            or: () => ({
              limit: () => ok(habitatData),
            }),
          }),
        };
      }
      if (table === "locations") {
        return {
          select: () => ({
            or: () => ({
              limit: () => ok(locationData),
            }),
          }),
        };
      }
      if (table === "materials") {
        return {
          select: () => ({
            or: () => ({
              limit: () => ok(materialData),
            }),
          }),
        };
      }
      throw new Error(`unexpected table: ${table}`);
    },
  } as unknown as SupabaseClient;
}

export function createSourceRecordsMock(
  rows: Array<{ verified_at: string | null; confidence: number | null }>,
): SupabaseClient {
  return {
    from: () => ({
      select: () => ({
        eq: () => ({
          eq: () => Promise.resolve({ data: rows, error: null }),
        }),
      }),
    }),
  } as unknown as SupabaseClient;
}
