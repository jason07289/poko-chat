/**
 * Game8 (Tier 2) — Habitat Dex 영문 페이지에서 서식지·제작 조건·출현 포켓몬(영문) 추출
 * URL: https://game8.co/games/Pokemon-Pokopia/archives/582463
 *
 * robots.txt·이용약관을 확인한 뒤 배치로 실행할 것. 과도한 요청 금지.
 */

import * as cheerio from "cheerio";
import fs from "node:fs";
import path from "node:path";

const DEFAULT_URL =
  "https://game8.co/games/Pokemon-Pokopia/archives/582463";

const UA =
  "Mozilla/5.0 (compatible; poko-chat-tier2-fetch/0.1; +https://github.com/)";

export function parseGame8HabitatDex(html, sourceUrl) {
  const $ = cheerio.load(html);
  const table = $("table.a-table").first();
  const rows = table.find("tbody tr").toArray();
  const habitats = [];

  for (let i = 0; i < rows.length; i += 2) {
    const condRow = $(rows[i]);
    const nameRow = $(rows[i + 1]);
    if (!nameRow.length) break;

    const cell = condRow.find("td").last();
    const fullText = cell.text();
    const condMatch = fullText.match(
      /Conditions:\s*([\s\S]*?)\s*Pokemon Available/i,
    );
    const conditions_en = condMatch
      ? condMatch[1].replace(/\s+/g, " ").trim()
      : "";

    const pokemon_en = [];
    cell.find("img.a-img").each((_, img) => {
      const alt = $(img).attr("alt");
      if (alt) pokemon_en.push(alt);
    });

    const nameText = nameRow
      .find("td")
      .first()
      .text()
      .replace(/\s+/g, " ")
      .trim();
    const nameMatch = nameText.match(/^(.+?)\s*\(#(\d+)\)\s*$/);
    const name_en = nameMatch ? nameMatch[1].trim() : nameText;
    const habitat_no = nameMatch ? parseInt(nameMatch[2], 10) : null;

    habitats.push({
      habitat_no,
      name_en,
      conditions_en,
      pokemon_en,
      source_name: "Game8",
      source_url: sourceUrl,
    });
  }

  return habitats;
}

async function main() {
  const url = process.argv[2] || DEFAULT_URL;
  const res = await fetch(url, {
    headers: { "User-Agent": UA, Accept: "text/html" },
  });
  if (!res.ok) {
    console.error(`HTTP ${res.status} ${url}`);
    process.exit(1);
  }
  const html = await res.text();
  const habitats = parseGame8HabitatDex(html, url);

  const outDir = path.join(import.meta.dirname, "out");
  fs.mkdirSync(outDir, { recursive: true });
  const outFile = path.join(outDir, "game8-habitats.json");
  fs.writeFileSync(
    outFile,
    JSON.stringify({ fetchedAt: new Date().toISOString(), url, habitats }, null, 2),
    "utf8",
  );

  console.log(`Wrote ${habitats.length} habitats → ${outFile}`);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
