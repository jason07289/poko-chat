import { describe, expect, it } from "vitest";

import {
  buildHabitatDescriptionForChat,
  extractGame8ConditionsFromDescription,
  getParsedMaterialSummary,
  parseGame8ConditionItems,
} from "./parse-conditions";

describe("extractGame8ConditionsFromDescription", () => {
  it("returns substring after [Game8]", () => {
    expect(
      extractGame8ConditionsFromDescription("한글 설명 [Game8] Tall Grass x 4"),
    ).toBe("Tall Grass x 4");
  });

  it("returns null when marker missing", () => {
    expect(extractGame8ConditionsFromDescription("plain")).toBeNull();
  });
});

describe("parseGame8ConditionItems", () => {
  it("parses Tall Grass and High-up location with quantities", () => {
    const items = parseGame8ConditionItems("Tall Grass x 4, High-up location x 1");
    expect(items).toHaveLength(2);
    expect(items[0]).toMatchObject({
      item_en: "Tall Grass",
      quantity: "4",
    });
    expect(items[0].item_ko).toBe("초록 풀");
    expect(items[1]).toMatchObject({
      item_en: "High-up location",
      quantity: "1",
    });
    expect(items[1].item_ko).toBe("고지대");
  });

  it("parses Game8 seed style (x1 without space after x)", () => {
    const items = parseGame8ConditionItems("Tall Grass x 4 High-up location x1");
    expect(items).toHaveLength(2);
    expect(items[1].item_ko).toBe("고지대");
    expect(items[1].quantity).toBe("1");
  });
});

describe("getParsedMaterialSummary", () => {
  it("builds formatted_materials_ko and requirements_line_ko", () => {
    const s = getParsedMaterialSummary(
      "설명 [Game8] Tall Grass x 4, High-up location x 1",
    );
    expect(s.requirements_line_ko).toBe("초록 풀 × 4, 고지대 × 1");
    expect(s.formatted_materials_ko).toBe(
      "필요한 재료:\n- 초록 풀 × 4\n- 고지대 × 1",
    );
  });
});

describe("buildHabitatDescriptionForChat", () => {
  it("replaces [Game8] English with Korean requirements line", () => {
    const parsed = getParsedMaterialSummary(
      "한글 본문 [Game8] Tall Grass x 4, High-up location x 1",
    );
    expect(
      buildHabitatDescriptionForChat(
        "한글 본문 [Game8] Tall Grass x 4, High-up location x 1",
        parsed,
      ),
    ).toBe("한글 본문\n\n필요한 재료: 초록 풀 × 4, 고지대 × 1");
  });
});
