-- poko-chat: 초기 스키마 (PRD §5, WBS 1.2)
-- Supabase SQL Editor 또는 `supabase db push` 로 적용

begin;

create extension if not exists pgcrypto;

-- ---------------------------------------------------------------------------
-- 공통: 엔터티 종류 (alias / source_record 다형 참조)
-- ---------------------------------------------------------------------------
create type public.entity_kind as enum (
  'pokemon',
  'habitat',
  'location',
  'material'
);

-- ---------------------------------------------------------------------------
-- materials: 서식지 제작 재료
-- ---------------------------------------------------------------------------
create table public.materials (
  id uuid primary key default gen_random_uuid(),
  name_ko text not null,
  name_en text,
  created_at timestamptz not null default now()
);

create index materials_name_ko_lower on public.materials (lower(name_ko));

-- ---------------------------------------------------------------------------
-- locations: 지역·바이옴 단위
-- ---------------------------------------------------------------------------
create table public.locations (
  id uuid primary key default gen_random_uuid(),
  name_ko text not null,
  name_en text,
  biome text,
  unlock_rule text,
  created_at timestamptz not null default now()
);

create index locations_name_ko_lower on public.locations (lower(name_ko));

-- ---------------------------------------------------------------------------
-- pokemon
-- ---------------------------------------------------------------------------
create table public.pokemon (
  id uuid primary key default gen_random_uuid(),
  name_ko text not null,
  name_en text,
  ideal_habitat text,
  rarity text,
  notes text,
  created_at timestamptz not null default now()
);

create index pokemon_name_ko_lower on public.pokemon (lower(name_ko));

-- ---------------------------------------------------------------------------
-- habitats: 209 일반 + 3 이벤트 = 212 관리 (PRD §4.2)
-- habitat_no 는 게임/가이드 기준 표준 번호 (1..n)
-- ---------------------------------------------------------------------------
create table public.habitats (
  id uuid primary key default gen_random_uuid(),
  habitat_no int not null unique,
  name_ko text not null,
  name_en text,
  location_id uuid references public.locations (id) on delete set null,
  is_event boolean not null default false,
  event_code text,
  active_from date,
  active_to date,
  image_policy text,
  description text,
  created_at timestamptz not null default now(),
  constraint habitats_habitat_no_positive check (habitat_no > 0)
);

create index habitats_location_id on public.habitats (location_id);
create index habitats_name_ko_lower on public.habitats (lower(name_ko));
create index habitats_is_event on public.habitats (is_event);

-- ---------------------------------------------------------------------------
-- habitat_requirements: 서식지별 필요 재료
-- ---------------------------------------------------------------------------
create table public.habitat_requirements (
  id uuid primary key default gen_random_uuid(),
  habitat_id uuid not null references public.habitats (id) on delete cascade,
  material_id uuid not null references public.materials (id) on delete restrict,
  quantity int not null default 1,
  qualifier text,
  sort_order int not null default 0,
  constraint habitat_requirements_quantity_non_negative check (quantity >= 0)
);

create index habitat_requirements_habitat_id on public.habitat_requirements (habitat_id);

-- ---------------------------------------------------------------------------
-- habitat_spawn_rules: 서식지별 출현 포켓몬·조건
-- 조건 필드가 비어 있으면 앱에서 ‘정보 없음’ 처리 (FR-03)
-- ---------------------------------------------------------------------------
create table public.habitat_spawn_rules (
  id uuid primary key default gen_random_uuid(),
  habitat_id uuid not null references public.habitats (id) on delete cascade,
  pokemon_id uuid not null references public.pokemon (id) on delete cascade,
  time_condition text,
  weather_condition text,
  biome_condition text,
  rarity text,
  unique (habitat_id, pokemon_id)
);

create index habitat_spawn_rules_habitat_id on public.habitat_spawn_rules (habitat_id);
create index habitat_spawn_rules_pokemon_id on public.habitat_spawn_rules (pokemon_id);

-- ---------------------------------------------------------------------------
-- aliases: 한국어 별칭·영문·오타 → 엔터티 (FR-04)
-- ---------------------------------------------------------------------------
create table public.aliases (
  id uuid primary key default gen_random_uuid(),
  entity_kind public.entity_kind not null,
  target_id uuid not null,
  alias_text text not null,
  normalized_text text not null,
  unique (entity_kind, normalized_text)
);

create index aliases_normalized_text on public.aliases (normalized_text);

-- ---------------------------------------------------------------------------
-- source_records: 출처·검증 메타 (FR-05, PRD P3)
-- ---------------------------------------------------------------------------
create table public.source_records (
  id uuid primary key default gen_random_uuid(),
  entity_kind public.entity_kind not null,
  entity_id uuid not null,
  source_name text not null,
  source_url text,
  verified_at timestamptz,
  confidence numeric(4, 3),
  notes text,
  created_at timestamptz not null default now(),
  constraint source_records_confidence_range check (
    confidence is null
    or (confidence >= 0 and confidence <= 1)
  )
);

create index source_records_entity on public.source_records (entity_kind, entity_id);

-- ---------------------------------------------------------------------------
-- RLS: 읽기는 공개(anon), 쓰기는 API·관리자(service_role)에서만
-- service_role 은 RLS 우회 — 서버 전용 키로 import·배치 작업
-- ---------------------------------------------------------------------------
alter table public.materials enable row level security;
alter table public.locations enable row level security;
alter table public.pokemon enable row level security;
alter table public.habitats enable row level security;
alter table public.habitat_requirements enable row level security;
alter table public.habitat_spawn_rules enable row level security;
alter table public.aliases enable row level security;
alter table public.source_records enable row level security;

create policy "materials_select_public"
  on public.materials for select using (true);

create policy "locations_select_public"
  on public.locations for select using (true);

create policy "pokemon_select_public"
  on public.pokemon for select using (true);

create policy "habitats_select_public"
  on public.habitats for select using (true);

create policy "habitat_requirements_select_public"
  on public.habitat_requirements for select using (true);

create policy "habitat_spawn_rules_select_public"
  on public.habitat_spawn_rules for select using (true);

create policy "aliases_select_public"
  on public.aliases for select using (true);

create policy "source_records_select_public"
  on public.source_records for select using (true);

commit;
