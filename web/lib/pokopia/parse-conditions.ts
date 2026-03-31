/**
 * habitats.description 에 포함된 `[Game8] …` 조건 문자열 파싱 (영문 재료 × 개수).
 */

import { translateMaterialNameEnToKo } from "./material-en-to-ko";

export type ParsedMaterialLine = {
  item_en: string;
  item_ko: string;
  quantity: string;
};

/** description 에서 `[Game8]` 이후 조건 한 줄 추출 */
export function extractGame8ConditionsFromDescription(
  description: string | null | undefined,
): string | null {
  if (!description?.trim()) return null;
  const idx = description.indexOf("[Game8]");
  if (idx === -1) return null;
  return description.slice(idx + "[Game8]".length).trim() || null;
}

/** `food x1` → `food x 1` 등 Game8 표기 정규화 */
function normalizeConditionTokens(conditionsEn: string): string {
  return conditionsEn.replace(/(\S)\s*x\s*(\d+)(?=\s|,|$)/g, "$1 x $2");
}

/**
 * "Tall Grass x 4 …" 또는 "Castform Weather Charm x 2, (Rain) Plated food x1" 형태 파싱.
 */
export function parseGame8ConditionItems(conditionsEn: string): ParsedMaterialLine[] {
  const normalized = normalizeConditionTokens(conditionsEn.trim());
  if (!normalized) return [];

  const re = /(.+?)\s+x\s*(\d+)/g;
  const out: ParsedMaterialLine[] = [];
  let m: RegExpExecArray | null;
  while ((m = re.exec(normalized)) !== null) {
    const item_en = m[1].trim().replace(/^[,;\s]+/, "");
    if (!item_en) continue;
    out.push({
      item_en,
      item_ko: translateMaterialNameEnToKo(item_en),
      quantity: m[2],
    });
  }

  return out;
}

export function getParsedMaterialSummary(description: string | null | undefined): {
  conditions_en: string | null;
  materials: ParsedMaterialLine[];
  /** `Tall Grass x 4, High-up location x 1` → 한글 쉼표 한 줄 */
  requirements_line_ko: string;
  /** 사용자/모델용 한글 블록 */
  formatted_materials_ko: string;
} {
  const conditions_en = extractGame8ConditionsFromDescription(description);
  const materials = conditions_en
    ? parseGame8ConditionItems(conditions_en)
    : [];

  const requirements_line_ko = materials
    .map((m) => `${m.item_ko} × ${m.quantity}`)
    .join(", ");

  const lines = materials.map(
    (m) => `- ${m.item_ko} × ${m.quantity}`,
  );
  const formatted_materials_ko =
    lines.length > 0
      ? `필요한 재료:\n${lines.join("\n")}`
      : "";

  return {
    conditions_en,
    materials,
    requirements_line_ko,
    formatted_materials_ko,
  };
}

/**
 * 도구 응답용: `description`에서 `[Game8] …` 영문 블록을 빼고,
 * 파싱된 한글 재료 줄만 붙인다 (모델이 영문을 인용하지 않도록).
 */
export function buildHabitatDescriptionForChat(
  description: string | null | undefined,
  parsed: Pick<ReturnType<typeof getParsedMaterialSummary>, "requirements_line_ko">,
): string | null {
  if (!description?.trim()) return null;
  const idx = description.indexOf("[Game8]");
  if (idx === -1) return description;
  const before = description.slice(0, idx).trim();
  const line = parsed.requirements_line_ko;
  if (!line) {
    return before || null;
  }
  if (!before) {
    return `필요한 재료: ${line}`;
  }
  return `${before}\n\n필요한 재료: ${line}`;
}

/** 목록 조회용: 서식지 행의 description 에서 `[Game8]` 영문을 한글 재료 줄로 바꾼다. */
export function applyChatDescriptionToHabitat<T extends { description: string | null }>(
  habitat: T,
): T {
  const parsed = getParsedMaterialSummary(habitat.description);
  return {
    ...habitat,
    description: buildHabitatDescriptionForChat(habitat.description, parsed),
  };
}
