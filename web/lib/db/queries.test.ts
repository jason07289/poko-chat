import { describe, expect, it } from "vitest";

import {
  getRelatedHabitats,
  normalizeAliasInput,
  searchEntity,
  summarizeProvenanceForEntity,
} from "./queries";
import {
  createSearchEntityMock,
  createSourceRecordsMock,
} from "../test/supabase-mocks";

describe("normalizeAliasInput", () => {
  it("trims and lowercases ASCII", () => {
    expect(normalizeAliasInput("  Pikachu  ")).toBe("pikachu");
  });

  it("applies NFKC (compatibility decomposition)", () => {
    const s = "\uFF21"; // fullwidth A
    expect(normalizeAliasInput(s)).toBe("a");
  });

  it("handles Korean without changing case semantics", () => {
    expect(normalizeAliasInput(" 부우부 ")).toBe("부우부");
  });
});

describe("searchEntity", () => {
  it("returns empty array for blank query", async () => {
    const sb = createSearchEntityMock({});
    await expect(searchEntity(sb, "   ")).resolves.toEqual([]);
    await expect(searchEntity(sb, "")).resolves.toEqual([]);
  });

  it("merges alias hits and dedupes same kind+id", async () => {
    const sb = createSearchEntityMock({
      aliases: [
        {
          entity_kind: "pokemon",
          target_id: "uuid-1",
          alias_text: "별칭",
        },
      ],
      pokemon: [{ id: "uuid-1", name_ko: "부우부" }],
    });
    const hits = await searchEntity(sb, "부우부");
    const pokemonHits = hits.filter((h) => h.kind === "pokemon" && h.id === "uuid-1");
    expect(pokemonHits).toHaveLength(1);
    expect(pokemonHits[0].label).toBe("별칭");
  });

  it("respects limit", async () => {
    const aliases = Array.from({ length: 20 }, (_, i) => ({
      entity_kind: "pokemon",
      target_id: `id-${i}`,
      alias_text: `a${i}`,
    }));
    const sb = createSearchEntityMock({ aliases });
    const hits = await searchEntity(sb, "x", 5);
    expect(hits.length).toBeLessThanOrEqual(5);
  });
});

describe("getRelatedHabitats", () => {
  it("returns empty when no filter is set", async () => {
    const sb = createSearchEntityMock({});
    await expect(getRelatedHabitats(sb, {})).resolves.toEqual([]);
  });
});

describe("summarizeProvenanceForEntity", () => {
  it("aggregates max confidence and latest verified_at", async () => {
    const sb = createSourceRecordsMock([
      { verified_at: "2024-01-01T00:00:00.000Z", confidence: 0.5 },
      { verified_at: "2025-01-01T00:00:00.000Z", confidence: 0.9 },
    ]);
    const s = await summarizeProvenanceForEntity(
      sb,
      "habitat",
      "hab-1",
    );
    expect(s.sourceCount).toBe(2);
    expect(s.maxConfidence).toBe(0.9);
    expect(s.verifiedAt).toBe("2025-01-01T00:00:00.000Z");
  });

  it("handles empty rows", async () => {
    const sb = createSourceRecordsMock([]);
    const s = await summarizeProvenanceForEntity(sb, "pokemon", "p-1");
    expect(s).toEqual({
      sourceCount: 0,
      verifiedAt: null,
      maxConfidence: null,
    });
  });
});
