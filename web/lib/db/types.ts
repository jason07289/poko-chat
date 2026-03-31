/**
 * Supabase `public` 스키마와 맞춘 타입 (supabase/migrations 참고).
 * 생성 컬럼은 조회 시 선택적으로 채운다.
 */

export type EntityKind = "pokemon" | "habitat" | "location" | "material";

export type MaterialRow = {
  id: string;
  name_ko: string;
  name_en: string | null;
  created_at: string;
};

export type LocationRow = {
  id: string;
  name_ko: string;
  name_en: string | null;
  biome: string | null;
  unlock_rule: string | null;
  created_at: string;
};

export type PokemonRow = {
  id: string;
  name_ko: string;
  name_en: string | null;
  ideal_habitat: string | null;
  rarity: string | null;
  notes: string | null;
  created_at: string;
};

export type HabitatRow = {
  id: string;
  habitat_no: number;
  name_ko: string;
  name_en: string | null;
  location_id: string | null;
  is_event: boolean;
  event_code: string | null;
  active_from: string | null;
  active_to: string | null;
  image_policy: string | null;
  description: string | null;
  created_at: string;
};

export type HabitatRequirementRow = {
  id: string;
  habitat_id: string;
  material_id: string;
  quantity: number;
  qualifier: string | null;
  sort_order: number;
};

export type HabitatSpawnRuleRow = {
  id: string;
  habitat_id: string;
  pokemon_id: string;
  time_condition: string | null;
  weather_condition: string | null;
  biome_condition: string | null;
  rarity: string | null;
};

export type AliasRow = {
  id: string;
  entity_kind: EntityKind;
  target_id: string;
  alias_text: string;
  normalized_text: string;
};

export type SourceRecordRow = {
  id: string;
  entity_kind: EntityKind;
  entity_id: string;
  source_name: string;
  source_url: string | null;
  verified_at: string | null;
  confidence: number | null;
  notes: string | null;
  created_at: string;
};
