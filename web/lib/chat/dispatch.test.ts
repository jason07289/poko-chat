import { describe, expect, it, vi } from "vitest";

import { executeHabitatTool } from "./dispatch";
import type { SupabaseClient } from "@supabase/supabase-js";

describe("executeHabitatTool", () => {
  it("returns error for invalid JSON arguments", async () => {
    const sb = {} as SupabaseClient;
    await expect(
      executeHabitatTool(sb, "search_entity", "not-json"),
    ).resolves.toEqual({ error: "invalid_json_arguments" });
  });

  it("returns unknown_tool for unsupported name", async () => {
    const sb = {} as SupabaseClient;
    await expect(
      executeHabitatTool(sb, "not_a_real_tool", "{}"),
    ).resolves.toEqual({ error: "unknown_tool", name: "not_a_real_tool" });
  });

  it("dispatches search_entity to searchEntity", async () => {
    const limit = vi.fn().mockResolvedValue({ data: [], error: null });
    const sb = {
      from: vi.fn(() => ({
        select: vi.fn().mockReturnValue({
          ilike: vi.fn().mockReturnValue({ limit }),
          or: vi.fn().mockReturnValue({ limit }),
        }),
      })),
    } as unknown as SupabaseClient;

    await executeHabitatTool(sb, "search_entity", JSON.stringify({ query: "x" }));

    expect(sb.from).toHaveBeenCalled();
  });
});
