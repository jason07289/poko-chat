# Tier 2 데이터 수집 (Game8 / GameWith)

PRD Tier 2 소스에서 **배치로** 데이터를 뽑아 `out/`에 JSON을 쌓는 스크립트다. 앱 런타임이 아니라 로컬·CI에서만 실행한다.

## 준비

```bash
cd scripts/tier2-fetch
npm install
```

## Game8 — 서식지 덱스 (권장)

영문 [Habitat Dex: How to Build All Habitats](https://game8.co/games/Pokemon-Pokopia/archives/582463) 페이지의 `table.a-table`에서 다음을 추출한다.

- `habitat_no`, `name_en` (예: `Tall grass (#001)`)
- `conditions_en` (제작 조건 텍스트)
- `pokemon_en[]` (출현 포켓몬 영문명, 아이콘 `alt`)

```bash
npm run fetch:game8
# → out/game8-habitats.json
```

다른 Game8 아카이브 URL을 쓰려면:

```bash
node fetch-game8.mjs "https://game8.co/games/Pokemon-Pokopia/archives/582463"
```

## GameWith — 메타만 (전체 표는 HTML에 없음)

[生息地図鑑一覧（全212種）](https://gamewith.jp/pocoapokemon/545406)는 `pocoa-habitat-list-tool` 위젯으로 **클라이언트에서** 표를 그린다. 단순 `fetch` HTML에는 212종 전체가 없으므로, 이 레포에서는 제목·수신 메타만 `out/gamewith-meta.json`에 남긴다.

전체를 자동으로 가져오려면 Playwright 등으로 페이지 로드 후 DOM을 스크랩하거나, 위젯이 호출하는 API를 별도로 조사해야 한다.

```bash
npm run fetch:gamewith
```

## 한글 보강 (OP.GG + PokeAPI)

`game8-habitats.json`은 영문 위주이므로, 아래로 **서식지 한글명**과 **포켓몬 한글명**을 붙인다.

| 필드 | 출처 | 설명 |
| --- | --- | --- |
| `name_ko` | [OP.GG 한국어 서식지 목록](https://op.gg/ko/pokemon-pokopia/habitats) | 이미지 URL `habitats/{번호}.png`와 `img alt`로 1~209 매칭 |
| `description_ko` | 동일 OP.GG 목록 | 카드 본문 한글 문장(재료·분위기 설명). `conditions_en`(Game8 기계식 영문)과 **문장 형식은 다름** — 한국어로 조건을 보여 줄 때는 이 필드 또는 `conditions_en` 병기 |
| `pokemon_ko` | [PokeAPI](https://pokeapi.co/) `pokemon-species` | 종별 공식 한글명 (`names`, language `ko`) |
| (없음) | 이벤트 등 | Game8에서 `habitat_no`가 비어 있거나 209 초과인 항목은 OP.GG 목록에 없을 수 있어 `name_ko` / `description_ko`가 `null`일 수 있다. 수동 보정 |

```bash
npm run enrich:ko
# 입력: out/game8-habitats.json → 출력: out/game8-habitats.enriched.json
```

게임8에만 있는 NPC/별칭 포켓몬 표기(예: `Pikachu (Peakychu)`)는 `enrich-game8-ko.mjs`의 `POKEMON_SLUG_OVERRIDES`로 일반 종 이름에 매핑한다.

## Supabase에 일괄 적재

`out/game8-habitats.enriched.json`을 `pokemon` / `habitats` / `habitat_spawn_rules` / `source_records`에 넣는다. **서버 전용 키**가 필요하다 (`web/.env.local`에 `SUPABASE_SECRET_KEY` 또는 `SUPABASE_SERVICE_ROLE_KEY`).

```bash
npm run import:db
# 또는: node import-enriched.mjs /절대경로/game8-habitats.enriched.json
```

- 기존 `pokemon`, `habitats`, `habitat_spawn_rules`, `habitat_requirements`, `aliases`, `source_records` 행은 **전부 삭제**한 뒤 다시 넣는다. `locations`는 유지.
- Game8에서 `habitat_no`가 없는 이벤트 서식지 4종은 DB에서 `habitat_no` **210~213**, `is_event = true`로 넣는다.
- `habitats.description`에는 `description_ko`와 `[Game8] conditions_en`을 줄바꿈으로 합친다.

## 다음 단계 (수동·추가)

1. `materials`·`habitat_requirements`는 `conditions_en` 파싱 또는 별도 소스

## 정책

사이트별 이용약관·robots.txt를 준수하고, 요청 간격을 두며 상업 서비스에서는 보수적으로 사용한다 (PRD §4.4). OP.GG는 **한글 라벨 참고** 용도로 두고, 포켓몬 한글명은 PokeAPI 등 공개 API를 우선한다.
