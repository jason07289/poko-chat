/**
 * GameWith (Tier 2) — 생息地図鑑 페이지는 Vue 위젯(pocoa-habitat-list-tool)으로
 * 클라이언트 렌더링되어, 단순 HTML에는 212종 전체 테이블이 포함되지 않는다.
 *
 * 대안:
 * - Playwright 등으로 페이지 로드 후 DOM 스냅샷 (별도 의존성)
 * - Game8 fetch 결과를 1차 소스로 쓰고, 일본어 명은 수동/별도 소스로 보강
 *
 * 이 스크립트는 URL·메타만 기록해 두고, 추후 DOM/API 역공학 시 확장한다.
 */

import fs from "node:fs";
import path from "node:path";

const PAGE_URL = "https://gamewith.jp/pocoapokemon/545406";

const UA =
  "Mozilla/5.0 (compatible; poko-chat-tier2-fetch/0.1; +https://github.com/)";

async function main() {
  const res = await fetch(PAGE_URL, {
    headers: { "User-Agent": UA, Accept: "text/html" },
  });
  const html = await res.text();
  const titleMatch = html.match(/<title>([^<]+)<\/title>/);
  const title = titleMatch ? titleMatch[1].trim() : "";

  const outDir = path.join(import.meta.dirname, "out");
  fs.mkdirSync(outDir, { recursive: true });
  const outFile = path.join(outDir, "gamewith-meta.json");
  const payload = {
    fetchedAt: new Date().toISOString(),
    url: PAGE_URL,
    httpStatus: res.status,
    title,
    note:
      "Full habitat table is injected by pocoa-habitat-list-tool.min.js (client-side). Use headless browser or Game8 JSON for batch import.",
  };
  fs.writeFileSync(outFile, JSON.stringify(payload, null, 2), "utf8");
  console.log(`Wrote meta → ${outFile}`);
  console.log(payload.note);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
