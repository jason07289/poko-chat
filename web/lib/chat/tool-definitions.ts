import type { FunctionTool } from "openai/resources/responses/responses";

/** OpenAI Responses API function tools (PRD §6 추천 툴) */
export const HABITAT_FUNCTION_TOOLS: FunctionTool[] = [
  {
    type: "function",
    name: "search_entity",
    description:
      "포켓몬·서식지·지역·재료 이름 또는 별칭으로 후보를 찾는다. 모호할 때 먼저 호출한다.",
    strict: true,
    parameters: {
      type: "object",
      additionalProperties: false,
      properties: {
        query: { type: "string", description: "검색어 (한국어·영문)" },
      },
      required: ["query"],
    },
  },
  {
    type: "function",
    name: "get_habitats_by_pokemon",
    description:
      "특정 포켓몬이 등장하는 서식지 목록을 조회한다. 지역·이벤트 여부·스폰 조건 필드가 포함될 수 있다.",
    strict: true,
    parameters: {
      type: "object",
      additionalProperties: false,
      properties: {
        pokemon_name: { type: "string", description: "포켓몬 이름 또는 별칭" },
      },
      required: ["pokemon_name"],
    },
  },
  {
    type: "function",
    name: "get_pokemon_by_habitat",
    description: "특정 서식지에 등장하는 포켓몬 목록을 조회한다.",
    strict: true,
    parameters: {
      type: "object",
      additionalProperties: false,
      properties: {
        habitat_name: { type: "string", description: "서식지 이름 또는 별칭" },
      },
      required: ["habitat_name"],
    },
  },
  {
    type: "function",
    name: "get_habitat_detail",
    description:
      "서식지 상세: 필요 재료, 지역, 이벤트 여부·기간, 설명 등을 조회한다.",
    strict: true,
    parameters: {
      type: "object",
      additionalProperties: false,
      properties: {
        habitat_name: { type: "string", description: "서식지 이름 또는 별칭" },
      },
      required: ["habitat_name"],
    },
  },
  {
    type: "function",
    name: "get_habitats_by_location",
    description: "지역(장소) 이름으로 그 지역에 속한 서식지를 조회한다.",
    strict: true,
    parameters: {
      type: "object",
      additionalProperties: false,
      properties: {
        location_name: { type: "string", description: "지역 이름" },
      },
      required: ["location_name"],
    },
  },
  {
    type: "function",
    name: "get_related_habitats",
    description:
      "재료명, 날씨, 시간대, 바이옴, 지역명 등 조건으로 서식지를 좁힌다. 최소 한 가지 조건을 채운다.",
    strict: false,
    parameters: {
      type: "object",
      properties: {
        material_name: { type: "string", description: "재료 이름 (선택)" },
        weather: { type: "string", description: "날씨 조건 부분 문자열 (선택)" },
        time: { type: "string", description: "시간 조건 부분 문자열 (선택)" },
        biome: { type: "string", description: "바이옴 조건 부분 문자열 (선택)" },
        location_name: { type: "string", description: "지역 이름 (선택)" },
      },
    },
  },
];
