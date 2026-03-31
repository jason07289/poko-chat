import type { SupabaseClient } from "@supabase/supabase-js";

import type {
  EntityKind,
  HabitatRow,
  LocationRow,
  MaterialRow,
  PokemonRow,
  SourceRecordRow,
} from "./types";

function oneOrNull<T>(value: T | T[] | null | undefined): T | null {
  if (value == null) return null;
  return Array.isArray(value) ? (value[0] ?? null) : value;
}

/** DB `aliases.normalized_text` 와 맞추기 위한 입력 정규화 (FR-04) */
export function normalizeAliasInput(input: string): string {
  return input.trim().normalize("NFKC").toLowerCase();
}

export type SearchEntityHit = {
  kind: EntityKind;
  id: string;
  label: string;
};

/** 포켓몬·서식지·지역·재료 후보 (툴 search_entity) */
export async function searchEntity(
  supabase: SupabaseClient,
  query: string,
  limit = 12,
): Promise<SearchEntityHit[]> {
  const q = query.trim();
  if (!q) return [];

  const normalized = normalizeAliasInput(q);
  const hits: SearchEntityHit[] = [];
  const seen = new Set<string>();

  const push = (kind: EntityKind, id: string, label: string) => {
    const key = `${kind}:${id}`;
    if (seen.has(key)) return;
    seen.add(key);
    hits.push({ kind, id, label });
  };

  const { data: aliasRows } = await supabase
    .from("aliases")
    .select("entity_kind, target_id, alias_text")
    .ilike("normalized_text", `%${normalized}%`)
    .limit(limit);

  for (const row of aliasRows ?? []) {
    const kind = row.entity_kind as EntityKind;
    if (!row.target_id) continue;
    push(kind, row.target_id, row.alias_text);
  }

  const like = `%${q}%`;
  const orName = `name_ko.ilike.${like},name_en.ilike.${like}`;

  const pushRows = (kind: EntityKind, rows: { id: string; name_ko: string }[]) => {
    for (const row of rows) {
      if (hits.length >= limit) return;
      push(kind, row.id, row.name_ko);
    }
  };

  if (hits.length < limit) {
    const { data: rows } = await supabase
      .from("pokemon")
      .select("id, name_ko")
      .or(orName)
      .limit(limit);
    pushRows("pokemon", (rows ?? []) as { id: string; name_ko: string }[]);
  }
  if (hits.length < limit) {
    const { data: rows } = await supabase
      .from("habitats")
      .select("id, name_ko")
      .or(orName)
      .limit(limit);
    pushRows("habitat", (rows ?? []) as { id: string; name_ko: string }[]);
  }
  if (hits.length < limit) {
    const { data: rows } = await supabase
      .from("locations")
      .select("id, name_ko")
      .or(orName)
      .limit(limit);
    pushRows("location", (rows ?? []) as { id: string; name_ko: string }[]);
  }
  if (hits.length < limit) {
    const { data: rows } = await supabase
      .from("materials")
      .select("id, name_ko")
      .or(orName)
      .limit(limit);
    pushRows("material", (rows ?? []) as { id: string; name_ko: string }[]);
  }

  return hits.slice(0, limit);
}

async function resolvePokemonId(
  supabase: SupabaseClient,
  name: string,
): Promise<string | null> {
  const normalized = normalizeAliasInput(name);
  const { data: alias } = await supabase
    .from("aliases")
    .select("target_id")
    .eq("entity_kind", "pokemon")
    .eq("normalized_text", normalized)
    .maybeSingle();
  if (alias?.target_id) return alias.target_id;

  const { data: direct } = await supabase
    .from("pokemon")
    .select("id")
    .ilike("name_ko", name.trim())
    .limit(1)
    .maybeSingle();
  if (direct?.id) return direct.id;

  const { data: en } = await supabase
    .from("pokemon")
    .select("id")
    .ilike("name_en", name.trim())
    .limit(1)
    .maybeSingle();
  return en?.id ?? null;
}

async function resolveHabitatId(
  supabase: SupabaseClient,
  name: string,
): Promise<string | null> {
  const normalized = normalizeAliasInput(name);
  const { data: alias } = await supabase
    .from("aliases")
    .select("target_id")
    .eq("entity_kind", "habitat")
    .eq("normalized_text", normalized)
    .maybeSingle();
  if (alias?.target_id) return alias.target_id;

  const { data: direct } = await supabase
    .from("habitats")
    .select("id")
    .ilike("name_ko", name.trim())
    .limit(1)
    .maybeSingle();
  if (direct?.id) return direct.id;

  const { data: en } = await supabase
    .from("habitats")
    .select("id")
    .ilike("name_en", name.trim())
    .limit(1)
    .maybeSingle();
  return en?.id ?? null;
}

async function resolveLocationId(
  supabase: SupabaseClient,
  name: string,
): Promise<string | null> {
  const normalized = normalizeAliasInput(name);
  const { data: alias } = await supabase
    .from("aliases")
    .select("target_id")
    .eq("entity_kind", "location")
    .eq("normalized_text", normalized)
    .maybeSingle();
  if (alias?.target_id) return alias.target_id;

  const { data: direct } = await supabase
    .from("locations")
    .select("id")
    .ilike("name_ko", name.trim())
    .limit(1)
    .maybeSingle();
  if (direct?.id) return direct.id;

  const { data: en } = await supabase
    .from("locations")
    .select("id")
    .ilike("name_en", name.trim())
    .limit(1)
    .maybeSingle();
  return en?.id ?? null;
}

/** embed 로드 후 `locations` 는 단일 행으로 정규화해 사용 */
export type HabitatWithLocation = HabitatRow & {
  locations: LocationRow | null;
};

export type HabitatByPokemonRow = {
  habitat: HabitatWithLocation;
  spawn: {
    time_condition: string | null;
    weather_condition: string | null;
    biome_condition: string | null;
    rarity: string | null;
  };
};

/** 포켓몬 이름/별칭 → 서식지 목록 (툴 get_habitats_by_pokemon, FR-01) */
export async function getHabitatsByPokemon(
  supabase: SupabaseClient,
  pokemonName: string,
): Promise<HabitatByPokemonRow[]> {
  const pid = await resolvePokemonId(supabase, pokemonName);
  if (!pid) return [];

  const { data: rules, error } = await supabase
    .from("habitat_spawn_rules")
    .select(
      `
      time_condition,
      weather_condition,
      biome_condition,
      rarity,
      habitats (
        id,
        habitat_no,
        name_ko,
        name_en,
        location_id,
        is_event,
        event_code,
        active_from,
        active_to,
        image_policy,
        description,
        created_at,
        locations (
          id,
          name_ko,
          name_en,
          biome,
          unlock_rule,
          created_at
        )
      )
    `,
    )
    .eq("pokemon_id", pid);

  if (error) throw error;

  const out: HabitatByPokemonRow[] = [];
  for (const row of rules ?? []) {
    const r = row as unknown as {
      time_condition: string | null;
      weather_condition: string | null;
      biome_condition: string | null;
      rarity: string | null;
      habitats: HabitatWithLocation | HabitatWithLocation[] | null;
    };
    const raw = oneOrNull(r.habitats);
    if (!raw) continue;
    const h: HabitatWithLocation = {
      ...raw,
      locations: oneOrNull(raw.locations),
    };
    out.push({
      habitat: h,
      spawn: {
        time_condition: r.time_condition,
        weather_condition: r.weather_condition,
        biome_condition: r.biome_condition,
        rarity: r.rarity,
      },
    });
  }
  return out;
}

export type PokemonInHabitatRow = {
  pokemon: PokemonRow;
  spawn: {
    time_condition: string | null;
    weather_condition: string | null;
    biome_condition: string | null;
    rarity: string | null;
  };
};

/** 서식지 이름/별칭 → 포켓몬 목록 (툴 get_pokemon_by_habitat, FR-02) */
export async function getPokemonByHabitat(
  supabase: SupabaseClient,
  habitatName: string,
): Promise<PokemonInHabitatRow[]> {
  const hid = await resolveHabitatId(supabase, habitatName);
  if (!hid) return [];

  const { data: rules, error } = await supabase
    .from("habitat_spawn_rules")
    .select(
      `
      time_condition,
      weather_condition,
      biome_condition,
      rarity,
      pokemon (
        id,
        name_ko,
        name_en,
        ideal_habitat,
        rarity,
        notes,
        created_at
      )
    `,
    )
    .eq("habitat_id", hid);

  if (error) throw error;

  const out: PokemonInHabitatRow[] = [];
  for (const row of rules ?? []) {
    const r = row as unknown as {
      time_condition: string | null;
      weather_condition: string | null;
      biome_condition: string | null;
      rarity: string | null;
      pokemon: PokemonRow | PokemonRow[] | null;
    };
    const p = oneOrNull(r.pokemon);
    if (!p) continue;
    out.push({
      pokemon: p,
      spawn: {
        time_condition: r.time_condition,
        weather_condition: r.weather_condition,
        biome_condition: r.biome_condition,
        rarity: r.rarity,
      },
    });
  }
  return out;
}

export type HabitatDetail = {
  habitat: HabitatWithLocation;
  requirements: Array<{
    quantity: number;
    qualifier: string | null;
    sort_order: number;
    material: MaterialRow | null;
  }>;
};

/** 서식지 상세: 재료·지역·이벤트 (툴 get_habitat_detail) */
export async function getHabitatDetail(
  supabase: SupabaseClient,
  habitatName: string,
): Promise<HabitatDetail | null> {
  const hid = await resolveHabitatId(supabase, habitatName);
  if (!hid) return null;

  const { data: hrow, error: he } = await supabase
    .from("habitats")
    .select(
      `
      id,
      habitat_no,
      name_ko,
      name_en,
      location_id,
      is_event,
      event_code,
      active_from,
      active_to,
      image_policy,
      description,
      created_at,
      locations (
        id,
        name_ko,
        name_en,
        biome,
        unlock_rule,
        created_at
      )
    `,
    )
    .eq("id", hid)
    .maybeSingle();

  if (he) throw he;
  if (!hrow) return null;

  const raw = hrow as unknown as HabitatWithLocation;
  const habitat: HabitatWithLocation = {
    ...raw,
    locations: oneOrNull(raw.locations),
  };

  const { data: reqRows, error: re } = await supabase
    .from("habitat_requirements")
    .select(
      `
      quantity,
      qualifier,
      sort_order,
      materials (
        id,
        name_ko,
        name_en,
        created_at
      )
    `,
    )
    .eq("habitat_id", hid)
    .order("sort_order", { ascending: true });

  if (re) throw re;

  const requirements =
    reqRows?.map((row) => {
      const r = row as unknown as {
        quantity: number;
        qualifier: string | null;
        sort_order: number;
        materials: MaterialRow | MaterialRow[] | null;
      };
      const m = oneOrNull(r.materials);
      return {
        quantity: r.quantity,
        qualifier: r.qualifier,
        sort_order: r.sort_order,
        material: m ?? null,
      };
    }) ?? [];

  return { habitat, requirements };
}

/** 지역명 → 서식지 (툴 get_habitats_by_location) */
export async function getHabitatsByLocation(
  supabase: SupabaseClient,
  locationName: string,
): Promise<HabitatWithLocation[]> {
  const lid = await resolveLocationId(supabase, locationName);
  if (!lid) return [];

  const { data, error } = await supabase
    .from("habitats")
    .select(
      `
      id,
      habitat_no,
      name_ko,
      name_en,
      location_id,
      is_event,
      event_code,
      active_from,
      active_to,
      image_policy,
      description,
      created_at,
      locations (
        id,
        name_ko,
        name_en,
        biome,
        unlock_rule,
        created_at
      )
    `,
    )
    .eq("location_id", lid)
    .order("habitat_no", { ascending: true });

  if (error) throw error;
  return ((data ?? []) as unknown as HabitatWithLocation[]).map((h) => ({
    ...h,
    locations: oneOrNull(h.locations),
  }));
}

export type RelatedHabitatFilters = {
  materialName?: string;
  weather?: string;
  time?: string;
  biome?: string;
  locationName?: string;
};

/** 조건 검색 (툴 get_related_habitats, FR-03) — 부분 일치 */
export async function getRelatedHabitats(
  supabase: SupabaseClient,
  filters: RelatedHabitatFilters,
): Promise<HabitatByPokemonRow[]> {
  const hasAny =
    Boolean(filters.materialName?.trim()) ||
    Boolean(filters.weather?.trim()) ||
    Boolean(filters.time?.trim()) ||
    Boolean(filters.biome?.trim()) ||
    Boolean(filters.locationName?.trim());
  if (!hasAny) return [];

  let query = supabase.from("habitat_spawn_rules").select(
    `
      time_condition,
      weather_condition,
      biome_condition,
      rarity,
      habitats (
        id,
        habitat_no,
        name_ko,
        name_en,
        location_id,
        is_event,
        event_code,
        active_from,
        active_to,
        image_policy,
        description,
        created_at,
        locations (
          id,
          name_ko,
          name_en,
          biome,
          unlock_rule,
          created_at
        )
      )
    `,
  );

  if (filters.weather?.trim()) {
    query = query.ilike(
      "weather_condition",
      `%${filters.weather.trim()}%`,
    );
  }
  if (filters.time?.trim()) {
    query = query.ilike("time_condition", `%${filters.time.trim()}%`);
  }
  if (filters.biome?.trim()) {
    query = query.ilike("biome_condition", `%${filters.biome.trim()}%`);
  }

  const { data: rules, error } = await query;
  if (error) throw error;

  let rows = rules ?? [];

  if (filters.locationName?.trim()) {
    const lid = await resolveLocationId(supabase, filters.locationName);
    rows = rows.filter((row) => {
      const r = row as unknown as {
        habitats: HabitatWithLocation | HabitatWithLocation[] | null;
      };
      const h = oneOrNull(r.habitats);
      return h?.location_id === lid;
    });
  }

  if (filters.materialName?.trim()) {
    const { data: mats } = await supabase
      .from("materials")
      .select("id")
      .ilike("name_ko", `%${filters.materialName.trim()}%`);
    const ids = new Set((mats ?? []).map((m) => m.id));
    if (ids.size === 0) return [];

    const { data: reqHids } = await supabase
      .from("habitat_requirements")
      .select("habitat_id")
      .in("material_id", [...ids]);

    const allowed = new Set((reqHids ?? []).map((r) => r.habitat_id));
    rows = rows.filter((row) => {
      const r = row as unknown as {
        habitats: HabitatWithLocation | HabitatWithLocation[] | null;
      };
      const h = oneOrNull(r.habitats);
      return h && allowed.has(h.id);
    });
  }

  const out: HabitatByPokemonRow[] = [];
  for (const row of rows) {
    const r = row as unknown as {
      time_condition: string | null;
      weather_condition: string | null;
      biome_condition: string | null;
      rarity: string | null;
      habitats: HabitatWithLocation | HabitatWithLocation[] | null;
    };
    const raw = oneOrNull(r.habitats);
    if (!raw) continue;
    const h: HabitatWithLocation = {
      ...raw,
      locations: oneOrNull(raw.locations),
    };
    out.push({
      habitat: h,
      spawn: {
        time_condition: r.time_condition,
        weather_condition: r.weather_condition,
        biome_condition: r.biome_condition,
        rarity: r.rarity,
      },
    });
  }
  return out;
}

export type ProvenanceSummary = {
  sourceCount: number;
  verifiedAt: string | null;
  maxConfidence: number | null;
};

/** 출처·검증 메타 집계 (FR-05) */
export async function summarizeProvenanceForEntity(
  supabase: SupabaseClient,
  kind: EntityKind,
  entityId: string,
): Promise<ProvenanceSummary> {
  const { data, error } = await supabase
    .from("source_records")
    .select("verified_at, confidence")
    .eq("entity_kind", kind)
    .eq("entity_id", entityId);

  if (error) throw error;
  const rows = (data ?? []) as Pick<
    SourceRecordRow,
    "verified_at" | "confidence"
  >[];

  let maxConfidence: number | null = null;
  let verifiedAt: string | null = null;

  for (const r of rows) {
    if (r.confidence != null) {
      if (maxConfidence == null || r.confidence > maxConfidence) {
        maxConfidence = r.confidence;
      }
    }
    if (r.verified_at) {
      if (!verifiedAt || r.verified_at > verifiedAt) {
        verifiedAt = r.verified_at;
      }
    }
  }

  return {
    sourceCount: rows.length,
    verifiedAt,
    maxConfidence,
  };
}
