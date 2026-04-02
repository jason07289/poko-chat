"use client";

export type ToolTrace = {
  toolName: string;
  args: string;
  result: unknown;
};

function isObject(v: unknown): v is Record<string, unknown> {
  return typeof v === "object" && v !== null;
}

function asString(v: unknown): string {
  return typeof v === "string" ? v : "";
}

function asBool(v: unknown): boolean {
  return v === true;
}

function parseArgs(argsJson: string): Record<string, unknown> {
  try {
    const obj = JSON.parse(argsJson);
    return isObject(obj) ? obj : {};
  } catch {
    return {};
  }
}

function formatSource(v: unknown): string {
  if (!isObject(v)) return "정보 없음";
  const count = typeof v.sourceCount === "number" ? v.sourceCount : 0;
  const verified = asString(v.verifiedAt);
  const confidence =
    typeof v.maxConfidence === "number"
      ? `${Math.round(v.maxConfidence * 100)}%`
      : "정보 없음";
  if (!count && !verified) return "정보 없음";
  return `건수 ${count} / 검증 ${verified || "-"} / 신뢰도 ${confidence}`;
}

export function renderTraceCard(trace: ToolTrace, i: number) {
  const rawResult = trace.result;
  const result =
    isObject(rawResult) &&
    Array.isArray(rawResult.rows) &&
    (trace.toolName === "get_related_habitats" ||
      trace.toolName === "get_habitats_by_location")
      ? rawResult.rows
      : rawResult;
  if (!isObject(result) && !Array.isArray(result)) return null;

  if (trace.toolName === "get_habitat_detail" && isObject(result)) {
    const habitat = isObject(result.habitat) ? result.habitat : {};
    const location = isObject(habitat.locations) ? habitat.locations : {};
    const materials = Array.isArray(result.game8_material_lines)
      ? result.game8_material_lines
      : [];
    return (
      <div
        key={`${trace.toolName}-${i}`}
        className="mt-2 rounded-lg border border-zinc-200 bg-white p-3 text-xs dark:border-zinc-700 dark:bg-zinc-900"
      >
        <p className="font-semibold text-emerald-700 dark:text-emerald-400">
          서식지 카드
        </p>
        <p>서식지: {asString(habitat.name_ko) || asString(habitat.name_en)}</p>
        <p>지역: {asString(location.name_ko) || "정보 없음"}</p>
        <p>이벤트: {asBool(habitat.is_event) ? "예" : "아니오"}</p>
        <p>재료:</p>
        <ul className="list-disc pl-4">
          {materials.length > 0 ? (
            materials.slice(0, 8).map((m, idx) => {
              const row = isObject(m) ? m : {};
              return (
                <li key={idx}>
                  {asString(row.item_ko)} x {asString(row.quantity)}
                </li>
              );
            })
          ) : (
            <li>정보 없음</li>
          )}
        </ul>
        <p>출처: {formatSource(result.habitat_provenance)}</p>
      </div>
    );
  }

  if (trace.toolName === "get_habitats_by_pokemon" && Array.isArray(result)) {
    const rows = result.slice(0, 6);
    return (
      <div
        key={`${trace.toolName}-${i}`}
        className="mt-2 rounded-lg border border-zinc-200 bg-white p-3 text-xs dark:border-zinc-700 dark:bg-zinc-900"
      >
        <p className="font-semibold text-emerald-700 dark:text-emerald-400">
          서식지 목록 카드
        </p>
        <ul className="list-disc pl-4">
          {rows.map((r, idx) => {
            const row = isObject(r) ? r : {};
            const habitat = isObject(row.habitat) ? row.habitat : {};
            const location = isObject(habitat.locations) ? habitat.locations : {};
            return (
              <li key={idx}>
                {asString(habitat.name_ko)} ({asString(location.name_ko) || "지역 없음"})
                <span className="ml-1 text-zinc-500 dark:text-zinc-400">
                  - {formatSource(row.habitat_provenance)}
                </span>
              </li>
            );
          })}
        </ul>
      </div>
    );
  }

  if (trace.toolName === "get_pokemon_by_habitat" && Array.isArray(result)) {
    const rows = result.slice(0, 8);
    return (
      <div
        key={`${trace.toolName}-${i}`}
        className="mt-2 rounded-lg border border-zinc-200 bg-white p-3 text-xs dark:border-zinc-700 dark:bg-zinc-900"
      >
        <p className="font-semibold text-emerald-700 dark:text-emerald-400">
          포켓몬 목록 카드
        </p>
        <ul className="list-disc pl-4">
          {rows.map((r, idx) => {
            const row = isObject(r) ? r : {};
            const pokemon = isObject(row.pokemon) ? row.pokemon : {};
            return (
              <li key={idx}>
                {asString(pokemon.name_ko) || asString(pokemon.name_en)}
                <span className="ml-1 text-zinc-500 dark:text-zinc-400">
                  - {formatSource(row.pokemon_provenance)}
                </span>
              </li>
            );
          })}
        </ul>
      </div>
    );
  }

  if (trace.toolName === "get_habitats_by_location" && Array.isArray(result)) {
    const rows = result.slice(0, 6);
    const notice =
      isObject(rawResult) && typeof rawResult.data_notice === "string"
        ? rawResult.data_notice
        : "";
    return (
      <div
        key={`${trace.toolName}-${i}`}
        className="mt-2 rounded-lg border border-zinc-200 bg-white p-3 text-xs dark:border-zinc-700 dark:bg-zinc-900"
      >
        <p className="font-semibold text-emerald-700 dark:text-emerald-400">
          지역 기반 서식지 카드
        </p>
        {notice ? (
          <p className="mb-2 text-[11px] text-amber-700 dark:text-amber-300">
            {notice}
          </p>
        ) : null}
        <ul className="list-disc pl-4">
          {rows.map((r, idx) => {
            const row = isObject(r) ? r : {};
            return (
              <li key={idx}>
                {asString(row.name_ko) || asString(row.name_en)}
                <span className="ml-1 text-zinc-500 dark:text-zinc-400">
                  - {formatSource(row.habitat_provenance)}
                </span>
              </li>
            );
          })}
        </ul>
      </div>
    );
  }

  if (trace.toolName === "get_related_habitats" && Array.isArray(result)) {
    const rows = result.slice(0, 6);
    const notice =
      isObject(rawResult) && typeof rawResult.data_notice === "string"
        ? rawResult.data_notice
        : "";
    const args = parseArgs(trace.args);
    const chips = [
      asString(args.material_name) && `재료:${asString(args.material_name)}`,
      asString(args.weather) && `날씨:${asString(args.weather)}`,
      asString(args.time) && `시간:${asString(args.time)}`,
      asString(args.biome) && `바이옴:${asString(args.biome)}`,
      asString(args.location_name) && `지역:${asString(args.location_name)}`,
    ].filter(Boolean) as string[];
    return (
      <div
        key={`${trace.toolName}-${i}`}
        className="mt-2 rounded-lg border border-zinc-200 bg-white p-3 text-xs dark:border-zinc-700 dark:bg-zinc-900"
      >
        <p className="font-semibold text-emerald-700 dark:text-emerald-400">
          조건 기반 서식지 카드
        </p>
        {notice ? (
          <p className="mb-2 text-[11px] text-amber-700 dark:text-amber-300">
            {notice}
          </p>
        ) : null}
        <div className="mb-2 flex flex-wrap gap-1">
          {chips.length > 0 ? (
            chips.map((chip) => (
              <span
                key={chip}
                className="rounded-full bg-emerald-100 px-2 py-0.5 text-[11px] text-emerald-800 dark:bg-emerald-900/50 dark:text-emerald-300"
              >
                {chip}
              </span>
            ))
          ) : (
            <span className="text-zinc-500 dark:text-zinc-400">조건 없음</span>
          )}
        </div>
        <ul className="list-disc pl-4">
          {rows.map((r, idx) => {
            const row = isObject(r) ? r : {};
            const habitat = isObject(row.habitat) ? row.habitat : {};
            const location = isObject(habitat.locations) ? habitat.locations : {};
            return (
              <li key={idx}>
                {asString(habitat.name_ko) || asString(habitat.name_en)} (
                {asString(location.name_ko) || "지역 없음"})
                <span className="ml-1 text-zinc-500 dark:text-zinc-400">
                  - {formatSource(row.habitat_provenance)}
                </span>
              </li>
            );
          })}
        </ul>
      </div>
    );
  }

  if (trace.toolName === "search_entity" && Array.isArray(result)) {
    const rows = result.slice(0, 8);
    const args = parseArgs(trace.args);
    return (
      <div
        key={`${trace.toolName}-${i}`}
        className="mt-2 rounded-lg border border-zinc-200 bg-white p-3 text-xs dark:border-zinc-700 dark:bg-zinc-900"
      >
        <p className="font-semibold text-emerald-700 dark:text-emerald-400">
          검색 후보 카드
        </p>
        <p className="mb-1 text-zinc-600 dark:text-zinc-300">
          검색어: {asString(args.query) || "-"}
        </p>
        <ul className="list-disc pl-4">
          {rows.map((r, idx) => {
            const row = isObject(r) ? r : {};
            return (
              <li key={idx}>
                {asString(row.label)}{" "}
                <span className="text-zinc-500 dark:text-zinc-400">
                  ({asString(row.kind)})
                </span>
              </li>
            );
          })}
        </ul>
      </div>
    );
  }

  return null;
}
