/**
 * game8-habitats.json 에 한글을 붙인다.
 * - 서식지명 name_ko: OP.GG 목록에서 habitat 번호(이미지 URL)와 img alt 매칭
 * - description_ko: OP.GG 목록의 한글 설명 문단 (재료 개수 등이 문장으로 들어감). Game8 conditions_en 과 문장 형식은 다름
 * - 포켓몬 한글명 pokemon_ko: PokeAPI
 *
 * 사용: node enrich-game8-ko.mjs [입력.json] [출력.json]
 */

import fs from "node:fs";
import path from "node:path";

const OPGG_HABITATS_KO =
  "https://op.gg/ko/pokemon-pokopia/habitats";
const POKEAPI_BASE = "https://pokeapi.co/api/v2/pokemon-species";
const UA =
  "Mozilla/5.0 (compatible; poko-chat-tier2-fetch/0.1; +https://github.com/)";

/** PokeAPI species slug로 안 될 때 수동 대응 (영문 표기 → slug) */
const POKEMON_SLUG_OVERRIDES = {
  "Nidoran♀": "nidoran-f",
  "Nidoran♂": "nidoran-m",
  "Mr. Mime": "mr-mime",
  "Mime Jr.": "mime-jr",
  "Mr. Rime": "mr-rime",
  "Type: Null": "type-null",
  "Porygon-Z": "porygon-z",
  "Ho-Oh": "ho-oh",
  "Jangmo-o": "jangmo-o",
  "Hakamo-o": "hakamo-o",
  "Kommo-o": "kommo-o",
  "Flabébé": "flabebe",
  "Farfetch'd": "farfetchd",
  "Sirfetch'd": "sirfetchd",
  "Tapu Koko": "tapu-koko",
  "Tapu Lele": "tapu-lele",
  "Tapu Bulu": "tapu-bulu",
  "Tapu Fini": "tapu-fini",
  "Great Tusk": "great-tusk",
  "Brute Bonnet": "brute-bonnet",
  "Sandy Shocks": "sandy-shocks",
  "Scream Tail": "scream-tail",
  "Flutter Mane": "flutter-mane",
  "Slither Wing": "slither-wing",
  "Iron Treads": "iron-treads",
  "Iron Bundle": "iron-bundle",
  "Iron Hands": "iron-hands",
  "Iron Jugulis": "iron-jugulis",
  "Iron Moth": "iron-moth",
  "Iron Thorns": "iron-thorns",
  "Roaring Moon": "roaring-moon",
  "Iron Valiant": "iron-valiant",
  "Walking Wake": "walking-wake",
  "Iron Leaves": "iron-leaves",
  "Wo-Chien": "wo-chien",
  "Chien-Pao": "chien-pao",
  "Ting-Lu": "ting-lu",
  "Chi-Yu": "chi-yu",
  // 게임8 표기·폼/별칭 → PokeAPI species slug
  "West Sea Shellos": "shellos",
  "East Sea Shellos": "shellos",
  "West Sea Gastrodon": "gastrodon",
  "East Sea Gastrodon": "gastrodon",
  "Paldean Wooper": "wooper",
  "Curly Form Tatsugiri": "tatsugiri",
  "Droopy Form Tatsugiri": "tatsugiri",
  "Stretchy Form Tatsugiri": "tatsugiri",
  "Amped Form Toxtricity": "toxtricity",
  "Low Key Form Toxtricity": "toxtricity",
  "Farfetch": "farfetchd",
  "Tangrowth (Professor Tangrowth)": "tangrowth",
  "Pikachu (Peakychu)": "pikachu",
  "Smeargle (Smearguru)": "smeargle",
  "Snorlax (Mosslax)": "snorlax",
  "Rotom (DJ Rotom)": "rotom",
  "Greedent (Chef Dente)": "greedent",
  "Tinkaton (Tinkmaster)": "tinkaton",
};

function toPokemonSlug(en) {
  if (POKEMON_SLUG_OVERRIDES[en]) return POKEMON_SLUG_OVERRIDES[en];
  return en
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/♀/g, "-f")
    .replace(/♂/g, "-m")
    .replace(/'/g, "")
    .replace(/\./g, "")
    .replace(/:/g, "")
    .trim()
    .toLowerCase()
    .replace(/\s+/g, "-")
    .replace(/-+/g, "-");
}

async function fetchText(url) {
  const res = await fetch(url, {
    headers: { "User-Agent": UA, Accept: "text/html,application/json" },
  });
  if (!res.ok) throw new Error(`${url} → HTTP ${res.status}`);
  return res.text();
}

/** OP.GG 목록 HTML에서 habitat 번호 → 한글 서식지명 (img alt) */
function parseOpggHabitatKo(html) {
  const map = new Map();
  const re = /alt="([^"]+)"[^>]*src="[^"]*habitats\/(\d+)\.png/g;
  let m;
  while ((m = re.exec(html))) {
    const num = parseInt(m[2], 10);
    const nameKo = m[1].trim();
    if (!map.has(num)) map.set(num, nameKo);
  }
  return map;
}

/**
 * OP.GG 목록 HTML에서 habitat 번호 → 한글 설명 (조건·분위기 문장).
 * Game8 conditions_en 의 직역이 아니라 OP.GG 카드 본문이다.
 */
function parseOpggDescriptionKo(html) {
  const map = new Map();
  const re =
    /habitats\/(\d+)\.png[^>]*>[\s\S]*?<p class="text-muted-foreground line-clamp-2 text-xs">([^<]+)<\/p>/g;
  let m;
  while ((m = re.exec(html))) {
    const num = parseInt(m[1], 10);
    const text = m[2].trim();
    if (!map.has(num)) map.set(num, text);
  }
  return map;
}

const koNameCache = new Map();

async function fetchPokemonKo(en) {
  if (koNameCache.has(en)) return koNameCache.get(en);
  const slug = toPokemonSlug(en);
  const url = `${POKEAPI_BASE}/${encodeURIComponent(slug)}`;
  await new Promise((r) => setTimeout(r, 80));
  const res = await fetch(url, {
    headers: { "User-Agent": UA, Accept: "application/json" },
  });
  if (!res.ok) {
    console.warn(`PokeAPI ${res.status}: ${en} (${slug})`);
    koNameCache.set(en, null);
    return null;
  }
  const data = await res.json();
  const ko = data.names?.find((n) => n.language.name === "ko");
  const name = ko?.name ?? null;
  koNameCache.set(en, name);
  return name;
}

async function main() {
  const inFile =
    process.argv[2] ||
    path.join(import.meta.dirname, "out", "game8-habitats.json");
  const outFile =
    process.argv[3] ||
    path.join(import.meta.dirname, "out", "game8-habitats.enriched.json");

  const raw = JSON.parse(fs.readFileSync(inFile, "utf8"));
  console.log("Fetching OP.GG (KO habitats)…");
  const opggHtml = await fetchText(OPGG_HABITATS_KO);
  const habitatKoByNo = parseOpggHabitatKo(opggHtml);
  const descriptionKoByNo = parseOpggDescriptionKo(opggHtml);
  console.log(
    `OP.GG: ${habitatKoByNo.size} names, ${descriptionKoByNo.size} descriptions (KO)`,
  );

  const uniquePokemon = new Set();
  for (const h of raw.habitats) {
    for (const p of h.pokemon_en) uniquePokemon.add(p);
  }
  console.log(`PokeAPI: ${uniquePokemon.size} unique Pokémon (KO names)…`);

  let fail = 0;
  for (const name of uniquePokemon) {
    const ko = await fetchPokemonKo(name);
    if (ko == null) fail++;
  }
  console.log(`PokeAPI done. Missing KO: ${fail}`);

  const habitats = raw.habitats.map((h) => {
    const num = h.habitat_no;
    const name_ko =
      num != null && habitatKoByNo.has(num)
        ? habitatKoByNo.get(num)
        : null;
    const description_ko =
      num != null && descriptionKoByNo.has(num)
        ? descriptionKoByNo.get(num)
        : null;
    const pokemon_ko = h.pokemon_en.map((en) => koNameCache.get(en) ?? null);
    return {
      ...h,
      name_ko,
      name_ko_source: name_ko ? "OP.GG" : null,
      description_ko,
      description_ko_source: description_ko ? "OP.GG" : null,
      pokemon_ko,
      pokemon_ko_source: "PokeAPI",
    };
  });

  const out = {
    ...raw,
    enrichedAt: new Date().toISOString(),
    sources: {
      habitats_ko: OPGG_HABITATS_KO,
      pokemon_ko: "https://pokeapi.co/",
    },
    habitats,
  };

  fs.mkdirSync(path.dirname(outFile), { recursive: true });
  fs.writeFileSync(outFile, JSON.stringify(out, null, 2), "utf8");
  console.log(`Wrote → ${outFile}`);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
