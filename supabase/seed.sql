-- 최소 시드 (WBS 1.5): 마이그레이션 적용 후 SQL Editor에서 실행
-- 이름 기준으로 없을 때만 넣어 재실행해도 대체로 안전하다.

begin;

insert into public.locations (name_ko, name_en, biome)
select '예시 지역', 'Example Area', null
where not exists (
  select 1 from public.locations where name_ko = '예시 지역'
);

insert into public.pokemon (name_ko, name_en, rarity)
select '부우부', 'Hoothoot', null
where not exists (
  select 1 from public.pokemon where name_ko = '부우부'
);

insert into public.habitats (
  habitat_no,
  name_ko,
  name_en,
  location_id,
  is_event,
  description
)
select
  1,
  '예시 서식지',
  'Example Habitat',
  l.id,
  false,
  '개발·연동 테스트용 더미 서식지입니다.'
from public.locations l
where l.name_ko = '예시 지역'
  and not exists (
    select 1 from public.habitats where habitat_no = 1
  );

insert into public.habitat_spawn_rules (
  habitat_id,
  pokemon_id,
  time_condition,
  weather_condition
)
select h.id, p.id, null, null
from public.habitats h
cross join public.pokemon p
where h.habitat_no = 1
  and p.name_ko = '부우부'
  and not exists (
    select 1
    from public.habitat_spawn_rules r
    where r.habitat_id = h.id
      and r.pokemon_id = p.id
  );

insert into public.aliases (entity_kind, target_id, alias_text, normalized_text)
select 'pokemon'::public.entity_kind, p.id, '부엉이', '부엉이'
from public.pokemon p
where p.name_ko = '부우부'
on conflict (entity_kind, normalized_text) do nothing;

insert into public.aliases (entity_kind, target_id, alias_text, normalized_text)
select 'habitat'::public.entity_kind, h.id, '예시 서식지', '예시 서식지'
from public.habitats h
where h.habitat_no = 1
on conflict (entity_kind, normalized_text) do nothing;

insert into public.source_records (
  entity_kind,
  entity_id,
  source_name,
  source_url,
  verified_at,
  confidence,
  notes
)
select
  'habitat'::public.entity_kind,
  h.id,
  'local_seed',
  null,
  now(),
  0.5,
  'seed.sql 더미'
from public.habitats h
where h.habitat_no = 1
  and not exists (
    select 1
    from public.source_records s
    where s.entity_kind = 'habitat'
      and s.entity_id = h.id
      and s.source_name = 'local_seed'
  );

commit;
