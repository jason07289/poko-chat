import type { SupabaseClient } from "@supabase/supabase-js";

import {
  getHabitatDetail,
  getHabitatsByLocation,
  getHabitatsByPokemon,
  getPokemonByHabitat,
  getRelatedHabitats,
  searchEntity,
  summarizeProvenanceForEntity,
} from "@/lib/db/queries";

type DataCoverage = {
  hasLocations: boolean;
  hasMappedHabitatLocations: boolean;
  hasTimeConditions: boolean;
  hasWeatherConditions: boolean;
};

async function getDataCoverage(supabase: SupabaseClient): Promise<DataCoverage> {
  const [locations, mappedLocations, timeRows, weatherRows] = await Promise.all([
    supabase.from("locations").select("id", { count: "exact", head: true }),
    supabase
      .from("habitats")
      .select("id", { count: "exact", head: true })
      .not("location_id", "is", null),
    supabase
      .from("habitat_spawn_rules")
      .select("id", { count: "exact", head: true })
      .not("time_condition", "is", null),
    supabase
      .from("habitat_spawn_rules")
      .select("id", { count: "exact", head: true })
      .not("weather_condition", "is", null),
  ]);
  return {
    hasLocations: (locations.count ?? 0) > 0,
    hasMappedHabitatLocations: (mappedLocations.count ?? 0) > 0,
    hasTimeConditions: (timeRows.count ?? 0) > 0,
    hasWeatherConditions: (weatherRows.count ?? 0) > 0,
  };
}

function buildCoverageNotice(
  coverage: DataCoverage,
  opts: { needsLocation?: boolean; needsTime?: boolean; needsWeather?: boolean },
): string | null {
  const missing: string[] = [];
  if (opts.needsLocation && !coverage.hasMappedHabitatLocations) missing.push("지역");
  if (opts.needsTime && !coverage.hasTimeConditions) missing.push("시간");
  if (opts.needsWeather && !coverage.hasWeatherConditions) missing.push("날씨");
  if (missing.length === 0) return null;
  return `현재 데이터셋에는 ${missing.join(", ")} 조건 데이터가 충분히 적재되어 있지 않아 정확한 필터 결과를 제공하기 어렵습니다.`;
}

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
      return Promise.all(
        (
          await getHabitatsByPokemon(supabase, String(args.pokemon_name ?? ""))
        ).map(async (row) => ({
          ...row,
          habitat_provenance: await summarizeProvenanceForEntity(
            supabase,
            "habitat",
            row.habitat.id,
          ),
        })),
      );
    case "get_pokemon_by_habitat":
      return Promise.all(
        (
          await getPokemonByHabitat(supabase, String(args.habitat_name ?? ""))
        ).map(async (row) => ({
          ...row,
          pokemon_provenance: await summarizeProvenanceForEntity(
            supabase,
            "pokemon",
            row.pokemon.id,
          ),
        })),
      );
    case "get_habitat_detail":
      return (async () => {
        const detail = await getHabitatDetail(
          supabase,
          String(args.habitat_name ?? ""),
        );
        if (!detail) return null;
        return {
          ...detail,
          habitat_provenance: await summarizeProvenanceForEntity(
            supabase,
            "habitat",
            detail.habitat.id,
          ),
        };
      })();
    case "get_habitats_by_location":
      return (async () => {
        const coverage = await getDataCoverage(supabase);
        const rows = await Promise.all(
          (
            await getHabitatsByLocation(supabase, String(args.location_name ?? ""))
          ).map(async (habitat) => ({
            ...habitat,
            habitat_provenance: await summarizeProvenanceForEntity(
              supabase,
              "habitat",
              habitat.id,
            ),
          })),
        );
        const notice = buildCoverageNotice(coverage, { needsLocation: true });
        if (!notice) return rows;
        return {
          rows,
          data_notice: notice,
        };
      })();
    case "get_related_habitats":
      return (async () => {
        const locationName =
          args.location_name != null ? String(args.location_name) : undefined;
        const weather = args.weather != null ? String(args.weather) : undefined;
        const time = args.time != null ? String(args.time) : undefined;
        const biome = args.biome != null ? String(args.biome) : undefined;
        const materialName =
          args.material_name != null ? String(args.material_name) : undefined;
        const coverage = await getDataCoverage(supabase);
        const rows = await Promise.all(
          (
            await getRelatedHabitats(supabase, {
              materialName,
              weather,
              time,
              biome,
              locationName,
            })
          ).map(async (row) => ({
            ...row,
            habitat_provenance: await summarizeProvenanceForEntity(
              supabase,
              "habitat",
              row.habitat.id,
            ),
          })),
        );
        const notice = buildCoverageNotice(coverage, {
          needsLocation: Boolean(locationName),
          needsTime: Boolean(time),
          needsWeather: Boolean(weather),
        });
        if (!notice) return rows;
        return {
          rows,
          data_notice: notice,
        };
      })();
    default:
      return { error: "unknown_tool", name };
  }
}
