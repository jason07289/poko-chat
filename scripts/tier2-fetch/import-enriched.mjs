/**
 * game8-habitats.enriched.json → Supabase (pokemon, habitats, habitat_spawn_rules, source_records)
 *
 * 필요: web/.env.local 에 NEXT_PUBLIC_SUPABASE_URL, SUPABASE_SECRET_KEY(또는 SUPABASE_SERVICE_ROLE_KEY)
 * RLS 우회를 위해 서버 전용 키 필수.
 *
 * 사용:
 *   node import-enriched.mjs [경로/game8-habitats.enriched.json]
 *
 * 기존 pokemon / habitats / habitat_spawn_rules / habitat_requirements / aliases / source_records 는
 * 비우고 다시 채운다. public.locations 는 건드리지 않는다.
 */

import dotenv from "dotenv";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

import { createClient } from "@supabase/supabase-js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

dotenv.config({ path: path.join(__dirname, "../../web/.env.local") });

function getServiceClient() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL?.trim();
  const key =
    process.env.SUPABASE_SECRET_KEY?.trim() ||
    process.env.SUPABASE_SERVICE_ROLE_KEY?.trim();
  if (!url || !key) {
    console.error(
      "NEXT_PUBLIC_SUPABASE_URL 와 SUPABASE_SECRET_KEY(또는 SUPABASE_SERVICE_ROLE_KEY)를 web/.env.local 에 설정하세요.",
    );
    process.exit(1);
  }
  return createClient(url, key);
}

/** 모든 행 삭제 (UUID 컬럼 id 가정) */
async function clearTable(sb, table) {
  const dummy = "00000000-0000-0000-0000-000000000000";
  const { error } = await sb.from(table).delete().neq("id", dummy);
  if (error) throw new Error(`${table}: ${error.message}`);
}

function buildDescription(h) {
  const parts = [];
  if (h.description_ko) parts.push(h.description_ko);
  if (h.conditions_en) parts.push(`[Game8] ${h.conditions_en}`);
  return parts.length ? parts.join("\n\n") : null;
}

async function main() {
  const jsonPath =
    process.argv[2] ||
    path.join(__dirname, "out", "game8-habitats.enriched.json");

  if (!fs.existsSync(jsonPath)) {
    console.error(`파일 없음: ${jsonPath}`);
    process.exit(1);
  }

  const raw = JSON.parse(fs.readFileSync(jsonPath, "utf8"));
  const list = raw.habitats;

  /** Game8 이벤트 행(habitat_no null)에 부여할 번호 (210~) */
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

  /** name_en → { name_ko, name_en } */
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

  const sb = getServiceClient();

  console.log("기존 데이터 삭제 중…");
  for (const t of [
    "habitat_spawn_rules",
    "habitat_requirements",
    "aliases",
    "source_records",
    "habitats",
    "pokemon",
  ]) {
    await clearTable(sb, t);
  }

  const pokemonRows = [...pokemonByEn.values()].sort((a, b) =>
    a.name_en.localeCompare(b.name_en),
  );
  console.log(`pokemon 삽입 ${pokemonRows.length}행…`);
  const { data: insertedPokemon, error: pe } = await sb
    .from("pokemon")
    .insert(pokemonRows)
    .select("id, name_en");
  if (pe) throw pe;
  const pokemonIdByEn = new Map(
    (insertedPokemon ?? []).map((r) => [r.name_en, r.id]),
  );

  const habitatRows = normalized.map((h) => ({
    habitat_no: h._habitat_no,
    name_ko: h.name_ko?.trim() || h.name_en,
    name_en: h.name_en,
    is_event: h._is_event,
    description: buildDescription(h),
  }));

  console.log(`habitats 삽입 ${habitatRows.length}행…`);
  const { data: insertedHab, error: he } = await sb
    .from("habitats")
    .insert(habitatRows)
    .select("id, habitat_no");
  if (he) throw he;
  const habitatIdByNo = new Map(
    (insertedHab ?? []).map((r) => [r.habitat_no, r.id]),
  );

  const spawnRows = [];
  const spawnSeen = new Set();
  for (const h of normalized) {
    const hid = habitatIdByNo.get(h._habitat_no);
    if (!hid) continue;
    for (const en of h.pokemon_en) {
      const pid = pokemonIdByEn.get(en);
      if (!pid) continue;
      const key = `${hid}:${pid}`;
      if (spawnSeen.has(key)) continue;
      spawnSeen.add(key);
      spawnRows.push({
        habitat_id: hid,
        pokemon_id: pid,
        time_condition: null,
        weather_condition: null,
      });
    }
  }

  console.log(`habitat_spawn_rules 삽입 ${spawnRows.length}행…`);
  const chunk = 400;
  for (let i = 0; i < spawnRows.length; i += chunk) {
    const { error: se } = await sb
      .from("habitat_spawn_rules")
      .insert(spawnRows.slice(i, i + chunk));
    if (se) throw se;
  }

  const sourceRows = [];
  const now = new Date().toISOString();
  for (const h of normalized) {
    const hid = habitatIdByNo.get(h._habitat_no);
    if (!hid) continue;
    sourceRows.push({
      entity_kind: "habitat",
      entity_id: hid,
      source_name: "Game8+OP.GG+PokeAPI",
      source_url: h.source_url ?? raw.url,
      verified_at: now,
      confidence: 0.85,
      notes: "import-enriched.mjs 배치 적재",
    });
  }

  console.log(`source_records 삽입 ${sourceRows.length}행…`);
  for (let i = 0; i < sourceRows.length; i += chunk) {
    const { error: sr } = await sb
      .from("source_records")
      .insert(sourceRows.slice(i, i + chunk));
    if (sr) throw sr;
  }

  console.log("완료.");
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
