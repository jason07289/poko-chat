/**
 * game8-habitats.enriched.json → supabase/seed_game8.sql (SQL Editor에서 실행)
 */

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

function escSql(s) {
  if (s == null || s === undefined) return "NULL";
  return `'${String(s).replace(/'/g, "''")}'`;
}

async function main() {
  const jsonPath =
    process.argv[2] ||
    path.join(__dirname, "out", "game8-habitats.enriched.json");
  const outPath =
    process.argv[3] ||
    path.join(__dirname, "..", "..", "supabase", "seed_game8.sql");

  if (!fs.existsSync(jsonPath)) {
    console.error(`파일 없음: ${jsonPath}`);
    process.exit(1);
  }

  const raw = JSON.parse(fs.readFileSync(jsonPath, "utf8"));
  const list = raw.habitats;

  let eventSeq = 210;
  const normalized = list.map((h) => {
    let no = h.habitat_no;
    let isEvent = false;
    if (no == null) {
      no = eventSeq++;
      isEvent = true;
    }
    return { ...h, _habitat_no: no, _is_event: isEvent };
  });

  const pokemonByEn = new Map();
  for (const h of normalized) {
    for (let i = 0; i < h.pokemon_en.length; i++) {
      const en = h.pokemon_en[i];
      const ko = h.pokemon_ko?.[i] ?? null;
      if (!pokemonByEn.has(en)) {
        pokemonByEn.set(en, {
          name_en: en,
          name_ko: ko && ko.trim() ? ko : en,
        });
      }
    }
  }

  const lines = [];
  lines.push("-- game8-habitats.enriched.json → 일괄 시드 (기존 포켓몬·서식지·스폰·별칭·출처 비움)");
  lines.push("-- SQL Editor에서 실행 (postgres 권한). locations는 유지하되 누락 지역은 추가.");
  lines.push("");
  lines.push("begin;");
  lines.push("");
  lines.push("delete from public.habitat_spawn_rules;");
  lines.push("delete from public.habitat_requirements;");
  lines.push("delete from public.aliases;");
  lines.push("delete from public.source_records;");
  lines.push("delete from public.habitats;");
  lines.push("delete from public.pokemon;");
  lines.push("");

  const pokemonRows = [...pokemonByEn.values()].sort((a, b) =>
    a.name_en.localeCompare(b.name_en),
  );
  lines.push("insert into public.pokemon (name_ko, name_en) values");
  lines.push(
    pokemonRows
      .map(
        (r) =>
          `  (${escSql(r.name_ko)}, ${escSql(r.name_en)})`,
      )
      .join(",\n") + ";",
  );
  lines.push("");

  // locations: 유지 + 누락만 추가
  const locationRows = [];
  const locationSeen = new Set();
  for (const h of normalized) {
    const ko = h.location_name_ko?.trim() || null;
    const en = h.location_name_en?.trim() || null;
    const key = (ko || en || "").toLowerCase();
    if (!key || locationSeen.has(key)) continue;
    locationSeen.add(key);
    locationRows.push({ name_ko: ko || en, name_en: en });
  }
  if (locationRows.length > 0) {
    lines.push("-- locations upsert-like insert");
    for (const r of locationRows) {
      lines.push(
        `insert into public.locations (name_ko, name_en, biome, unlock_rule)
select ${escSql(r.name_ko)}, ${escSql(r.name_en)}, null, null
where not exists (
  select 1 from public.locations where lower(name_ko) = lower(${escSql(r.name_ko)})
);`,
      );
    }
    lines.push("");
  }

  lines.push(
    "insert into public.habitats (habitat_no, name_ko, name_en, location_id, is_event, description) values",
  );
  lines.push(
    normalized
      .map((h) => {
        const descParts = [];
        if (h.description_ko) descParts.push(h.description_ko);
        if (h.conditions_en) descParts.push(`[Game8] ${h.conditions_en}`);
        const desc = descParts.length ? descParts.join("\n\n") : null;
        const locationKo = h.location_name_ko?.trim() || null;
        const locationEn = h.location_name_en?.trim() || null;
        return `  (${h._habitat_no}, ${escSql(h.name_ko?.trim() || h.name_en)}, ${escSql(h.name_en)}, (select id from public.locations where lower(name_ko) = lower(${escSql(locationKo || locationEn || "")}) limit 1), ${h._is_event}, ${escSql(desc)})`;
      })
      .join(",\n") + ";",
  );
  lines.push("");

  const spawnParts = [];
  const spawnSeen = new Set();
  for (const h of normalized) {
    const no = h._habitat_no;
    for (const en of h.pokemon_en) {
      const key = `${no}:${en}`;
      if (spawnSeen.has(key)) continue;
      spawnSeen.add(key);
      spawnParts.push(
        `((select id from public.habitats where habitat_no = ${no}), (select id from public.pokemon where name_en = ${escSql(en)}), ${escSql(h.time_condition_key && h.time_condition_key !== "unknown" ? h.time_condition_key : null)}, ${escSql(h.weather_condition_key && h.weather_condition_key !== "unknown" ? h.weather_condition_key : null)}, null)`,
      );
    }
  }
  lines.push(
    "insert into public.habitat_spawn_rules (habitat_id, pokemon_id, time_condition, weather_condition, biome_condition) values",
  );
  lines.push(spawnParts.join(",\n") + ";");
  lines.push("");

  const now = new Date().toISOString();
  lines.push("insert into public.source_records (entity_kind, entity_id, source_name, source_url, verified_at, confidence, notes)");
  lines.push(
    normalized
      .map((h) => {
        const url = escSql(h.source_url ?? raw.url ?? "");
        return `select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = ${h._habitat_no}), ${escSql("Game8+OP.GG+PokeAPI")}, ${url}, ${escSql(now)}::timestamptz, 0.85::numeric, ${escSql("build-sql-seed.mjs / import 배치")}`;
      })
      .join("\nunion all\n"),
  );
  lines.push(";");
  lines.push("");
  lines.push("commit;");
  lines.push("");

  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, lines.join("\n"), "utf8");
  console.log(`Wrote ${outPath} (${spawnParts.length} spawn rows)`);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
