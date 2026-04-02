/**
 * game8-habitats.enriched.json 기반 location-map 템플릿 생성
 *
 * 사용:
 *   node build-location-map-template.mjs [inJson] [outJson]
 */

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function main() {
  const inFile =
    process.argv[2] ||
    path.join(__dirname, "out", "game8-habitats.enriched.json");
  const outFile =
    process.argv[3] || path.join(__dirname, "location-map.template.json");

  if (!fs.existsSync(inFile)) {
    throw new Error(`입력 파일 없음: ${inFile}`);
  }
  const raw = JSON.parse(fs.readFileSync(inFile, "utf8"));
  const habitats = Array.isArray(raw.habitats) ? raw.habitats : [];

  const records = habitats
    .filter((h) => typeof h.habitat_no === "number")
    .map((h) => ({
      habitat_no: h.habitat_no,
      name_en: h.name_en ?? null,
      location_name_ko: h.location_name_ko ?? null,
      location_name_en: h.location_name_en ?? null,
      note: "TODO: fill location names",
    }));

  const out = {
    description:
      "habitat_no 또는 name_en 기준 지역 매핑 템플릿. location_name_ko/en을 채운 뒤 location-map.json으로 복사하세요.",
    records,
  };

  fs.writeFileSync(outFile, JSON.stringify(out, null, 2), "utf8");
  console.log(`Wrote ${outFile} (${records.length} rows)`);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
