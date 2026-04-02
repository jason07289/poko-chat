/**
 * Supabase 적재 결과의 커버리지를 점검한다.
 *
 * 사용:
 *   node verify-coverage.mjs
 *
 * 필요:
 *   web/.env.local
 *   - NEXT_PUBLIC_SUPABASE_URL
 *   - SUPABASE_SECRET_KEY 또는 SUPABASE_SERVICE_ROLE_KEY
 */

import dotenv from "dotenv";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { createClient } from "@supabase/supabase-js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: path.join(__dirname, "../../web/.env.local") });

function percent(part, total) {
  if (!total) return "0.0%";
  return `${((part / total) * 100).toFixed(1)}%`;
}

function getServiceClient() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL?.trim();
  const key =
    process.env.SUPABASE_SECRET_KEY?.trim() ||
    process.env.SUPABASE_SERVICE_ROLE_KEY?.trim();
  if (!url || !key) {
    throw new Error(
      "NEXT_PUBLIC_SUPABASE_URL + SUPABASE_SECRET_KEY(또는 SUPABASE_SERVICE_ROLE_KEY) 필요",
    );
  }
  return createClient(url, key);
}

async function count(table, predicate) {
  let q = getServiceClient().from(table).select("id", { count: "exact", head: true });
  q = predicate(q);
  const { count: c, error } = await q;
  if (error) throw error;
  return c ?? 0;
}

async function main() {
  const totalHabitats = await count("habitats", (q) => q);
  const habitatsWithLocation = await count("habitats", (q) =>
    q.not("location_id", "is", null),
  );
  const totalSpawn = await count("habitat_spawn_rules", (q) => q);
  const spawnWithTime = await count("habitat_spawn_rules", (q) =>
    q.not("time_condition", "is", null),
  );
  const spawnWithWeather = await count("habitat_spawn_rules", (q) =>
    q.not("weather_condition", "is", null),
  );

  console.log("=== Coverage Report ===");
  console.log(
    `habitats.location_id: ${habitatsWithLocation}/${totalHabitats} (${percent(
      habitatsWithLocation,
      totalHabitats,
    )})`,
  );
  console.log(
    `spawn.time_condition: ${spawnWithTime}/${totalSpawn} (${percent(
      spawnWithTime,
      totalSpawn,
    )})`,
  );
  console.log(
    `spawn.weather_condition: ${spawnWithWeather}/${totalSpawn} (${percent(
      spawnWithWeather,
      totalSpawn,
    )})`,
  );
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
