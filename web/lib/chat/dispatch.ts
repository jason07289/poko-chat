import type { SupabaseClient } from "@supabase/supabase-js";

import {
  getHabitatDetail,
  getHabitatsByLocation,
  getHabitatsByPokemon,
  getPokemonByHabitat,
  getRelatedHabitats,
  searchEntity,
} from "@/lib/db/queries";

export async function executeHabitatTool(
  supabase: SupabaseClient,
  name: string,
  argsJson: string,
): Promise<unknown> {
  let args: Record<string, unknown>;
  try {
    args = JSON.parse(argsJson) as Record<string, unknown>;
  } catch {
    return { error: "invalid_json_arguments" };
  }

  switch (name) {
    case "search_entity":
      return searchEntity(supabase, String(args.query ?? ""));
    case "get_habitats_by_pokemon":
      return getHabitatsByPokemon(supabase, String(args.pokemon_name ?? ""));
    case "get_pokemon_by_habitat":
      return getPokemonByHabitat(supabase, String(args.habitat_name ?? ""));
    case "get_habitat_detail":
      return getHabitatDetail(supabase, String(args.habitat_name ?? ""));
    case "get_habitats_by_location":
      return getHabitatsByLocation(supabase, String(args.location_name ?? ""));
    case "get_related_habitats":
      return getRelatedHabitats(supabase, {
        materialName:
          args.material_name != null ? String(args.material_name) : undefined,
        weather: args.weather != null ? String(args.weather) : undefined,
        time: args.time != null ? String(args.time) : undefined,
        biome: args.biome != null ? String(args.biome) : undefined,
        locationName:
          args.location_name != null ? String(args.location_name) : undefined,
      });
    default:
      return { error: "unknown_tool", name };
  }
}
