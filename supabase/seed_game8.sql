-- game8-habitats.enriched.json → 일괄 시드 (기존 포켓몬·서식지·스폰·별칭·출처 비움)
-- SQL Editor에서 실행 (postgres 권한). locations는 유지.

begin;

delete from public.habitat_spawn_rules;
delete from public.habitat_requirements;
delete from public.aliases;
delete from public.source_records;
delete from public.habitats;
delete from public.pokemon;

insert into public.pokemon (name_ko, name_en) values
  ('캐이시', 'Abra'),
  ('앱솔', 'Absol'),
  ('프테라', 'Aerodactyl'),
  ('후딘', 'Alakazam'),
  ('파비코리', 'Altaria'),
  ('아마루스', 'Amaura'),
  ('스트린더', 'Amped Form Toxtricity'),
  ('전룡', 'Ampharos'),
  ('아보크', 'Arbok'),
  ('윈디', 'Arcanine'),
  ('아리아도스', 'Ariados'),
  ('카디나르마', 'Armarouge'),
  ('다부니', 'Audino'),
  ('아마루르가', 'Aurorus'),
  ('터검니', 'Axew'),
  ('마릴리', 'Azumarill'),
  ('루리리', 'Azurill'),
  ('바리톱스', 'Bastiodon'),
  ('메탕', 'Beldum'),
  ('아르코', 'Bellossom'),
  ('모다피', 'Bellsprout'),
  ('거북왕', 'Blastoise'),
  ('번치코', 'Blaziken'),
  ('해피너스', 'Blissey'),
  ('꼬지지', 'Bonsly'),
  ('이상해씨', 'Bulbasaur'),
  ('선인왕', 'Cacnea'),
  ('밤선인', 'Cacturne'),
  ('탄차곤', 'Carkol'),
  ('파라블레이즈', 'Ceruledge'),
  ('샹델라', 'Chandelure'),
  ('럭키', 'Chansey'),
  ('카르본', 'Charcadet'),
  ('리자몽', 'Charizard'),
  ('전지충이', 'Charjabug'),
  ('파이리', 'Charmander'),
  ('리자드', 'Charmeleon'),
  ('페라페', 'Chatot'),
  ('치라치노', 'Cinccino'),
  ('에이스번', 'Cinderace'),
  ('픽시', 'Clefable'),
  ('삐삐', 'Clefairy'),
  ('삐', 'Cleffa'),
  ('토오', 'Clodsire'),
  ('석탄산', 'Coalossal'),
  ('세꿀버리', 'Combee'),
  ('영치코', 'Combusken'),
  ('노보청', 'Conkeldurr'),
  ('아머까오', 'Corviknight'),
  ('파크로우', 'Corvisquire'),
  ('윽우지', 'Cramorant'),
  ('두개도스', 'Cranidos'),
  ('크로뱃', 'Crobat'),
  ('탕구리', 'Cubone'),
  ('싸리용', 'Curly Form Tatsugiri'),
  ('브케인', 'Cyndaquil'),
  ('바우첼', 'Dachsbun'),
  ('빼미스로우', 'Dartrix'),
  ('모크나이퍼', 'Decidueye'),
  ('데덴네', 'Dedenne'),
  ('디그다', 'Diglett'),
  ('드래펄트', 'Dragapult'),
  ('신뇽', 'Dragonair'),
  ('망나뇽', 'Dragonite'),
  ('드래런치', 'Drakloak'),
  ('미뇽', 'Dratini'),
  ('드라꼰', 'Dreepy'),
  ('둥실라이드', 'Drifblim'),
  ('흔들풍손', 'Drifloon'),
  ('두더류', 'Drilbur'),
  ('싸리용', 'Droopy Form Tatsugiri'),
  ('닥트리오', 'Dugtrio'),
  ('미라몽', 'Dusclops'),
  ('야느와르몽', 'Dusknoir'),
  ('해골몽', 'Duskull'),
  ('트리토돈', 'East Sea Gastrodon'),
  ('깝질무', 'East Sea Shellos'),
  ('이브이', 'Eevee'),
  ('아보', 'Ekans'),
  ('에레브', 'Electabuzz'),
  ('에레키블', 'Electivire'),
  ('붐볼', 'Electrode'),
  ('에레키드', 'Elekid'),
  ('엠페르트', 'Empoleon'),
  ('에브이', 'Espeon'),
  ('몰드류', 'Excadrill'),
  ('아라리', 'Exeggcute'),
  ('나시', 'Exeggutor'),
  ('파오리', 'Farfetch'),
  ('키키링', 'Farigiraf'),
  ('쫀도기', 'Fidough'),
  ('보송송', 'Flaaffy'),
  ('부스터', 'Flareon'),
  ('나로테', 'Floragato'),
  ('플라이곤', 'Flygon'),
  ('액슨도', 'Fraxure'),
  ('개구마르', 'Froakie'),
  ('개굴반장', 'Frogadier'),
  ('엘레이드', 'Gallade'),
  ('더스트나', 'Garbodor'),
  ('가디안', 'Gardevoir'),
  ('고오스', 'Gastly'),
  ('팬텀', 'Gengar'),
  ('꼬마돌', 'Geodude'),
  ('타부자고', 'Gholdengo'),
  ('키링키', 'Girafarig'),
  ('글레이시아', 'Glaceon'),
  ('초롱순', 'Glimmet'),
  ('킬라플로르', 'Glimmora'),
  ('냄새꼬', 'Gloom'),
  ('골뱃', 'Golbat'),
  ('골덕', 'Golduck'),
  ('딱구리', 'Golem'),
  ('미끄래곤', 'Goodra'),
  ('미끄메라', 'Goomy'),
  ('데구리', 'Graveler'),
  ('요씽리스', 'Greedent (Chef Dente)'),
  ('개굴닌자', 'Greninja'),
  ('질퍽이', 'Grimer'),
  ('가디', 'Growlithe'),
  ('턱지충이', 'Grubbin'),
  ('꼴깍몬', 'Gulpin'),
  ('토쇠골', 'Gurdurr'),
  ('갸라도스', 'Gyarados'),
  ('핑복', 'Happiny'),
  ('하리뭉', 'Hariyama'),
  ('고우스트', 'Haunter'),
  ('액스라이즈', 'Haxorus'),
  ('헤라크로스', 'Heracross'),
  ('홍수몬', 'Hitmonchan'),
  ('시라소몬', 'Hitmonlee'),
  ('카포에라', 'Hitmontop'),
  ('돈크로우', 'Honchkrow'),
  ('부우부', 'Hoothoot'),
  ('통통코', 'Hoppip'),
  ('푸푸린', 'Igglybuff'),
  ('네오비트', 'Illumise'),
  ('이상해풀', 'Ivysaur'),
  ('푸린', 'Jigglypuff'),
  ('쥬피썬더', 'Jolteon'),
  ('솜솜코', 'Jumpluff'),
  ('윤겔라', 'Kadabra'),
  ('찌리비크', 'Kilowattrel'),
  ('킬리아', 'Kirlia'),
  ('또가스', 'Koffing'),
  ('귀뚤뚜기', 'Kricketot'),
  ('귀뚤톡크', 'Kricketune'),
  ('램프라', 'Lampent'),
  ('라프라스', 'Lapras'),
  ('활화르바', 'Larvesta'),
  ('애버라스', 'Larvitar'),
  ('리피아', 'Leafeon'),
  ('불켜미', 'Litwick'),
  ('로토스', 'Lombre'),
  ('연꽃몬', 'Lotad'),
  ('스트린더', 'Low Key Form Toxtricity'),
  ('루카리오', 'Lucario'),
  ('로파파', 'Ludicolo'),
  ('괴력몬', 'Machamp'),
  ('근육몬', 'Machoke'),
  ('알통몬', 'Machop'),
  ('마그비', 'Magby'),
  ('잉어킹', 'Magikarp'),
  ('마그마', 'Magmar'),
  ('마그마번', 'Magmortar'),
  ('코일', 'Magnemite'),
  ('레어코일', 'Magneton'),
  ('자포코일', 'Magnezone'),
  ('마크탕', 'Makuhita'),
  ('메리프', 'Mareep'),
  ('마릴', 'Marill'),
  ('텅구리', 'Marowak'),
  ('입치트', 'Mawile'),
  ('마스카나', 'Meowscarada'),
  ('나옹', 'Meowth'),
  ('메타그로스', 'Metagross'),
  ('메탕구', 'Metang'),
  ('흉내내', 'Mime Jr.'),
  ('따라큐', 'Mimikyu'),
  ('치라미', 'Minccino'),
  ('마이농', 'Minun'),
  ('무우마', 'Misdreavus'),
  ('무우마직', 'Mismagius'),
  ('마임맨', 'Mr. Mime'),
  ('질뻐기', 'Muk'),
  ('먹고자', 'Munchlax'),
  ('니로우', 'Murkrow'),
  ('나인테일', 'Ninetales'),
  ('야부엉', 'Noctowl'),
  ('음뱃', 'Noibat'),
  ('음번', 'Noivern'),
  ('뚜벅쵸', 'Oddish'),
  ('롱스톤', 'Onix'),
  ('우파', 'Paldean Wooper'),
  ('파라스', 'Paras'),
  ('파라섹트', 'Parasect'),
  ('빠모', 'Pawmi'),
  ('빠모트', 'Pawmo'),
  ('패리퍼', 'Pelipper'),
  ('페르시온', 'Persian'),
  ('피츄', 'Pichu'),
  ('피죤투', 'Pidgeot'),
  ('피죤', 'Pidgeotto'),
  ('구구', 'Pidgey'),
  ('피카츄', 'Pikachu'),
  ('피카츄', 'Pikachu (Peakychu)'),
  ('쁘사이저', 'Pinsir'),
  ('팽도리', 'Piplup'),
  ('플러시', 'Plusle'),
  ('왕구리', 'Politoed'),
  ('발챙이', 'Poliwag'),
  ('슈륙챙이', 'Poliwhirl'),
  ('강챙이', 'Poliwrath'),
  ('폴리곤', 'Porygon'),
  ('폴리곤Z', 'Porygon-Z'),
  ('폴리곤2', 'Porygon2'),
  ('팽태자', 'Prinplup'),
  ('고라파덕', 'Psyduck'),
  ('데기라스', 'Pupitar'),
  ('마그케인', 'Quilava'),
  ('래비풋', 'Raboot'),
  ('라이츄', 'Raichu'),
  ('랄토스', 'Ralts'),
  ('램펄드', 'Rampardos'),
  ('리오르', 'Riolu'),
  ('탄동', 'Rolycoly'),
  ('파라꼬', 'Rookidee'),
  ('로토무', 'Rotom (DJ Rotom)'),
  ('깜까미', 'Sableye'),
  ('핫삼', 'Scizor'),
  ('염버니', 'Scorbunny'),
  ('스라크', 'Scyther'),
  ('샤로다', 'Serperior'),
  ('샤비', 'Servine'),
  ('방패톱스', 'Shieldon'),
  ('두코', 'Skiploom'),
  ('미끄네일', 'Sliggoo'),
  ('야도란', 'Slowbro'),
  ('야도킹', 'Slowking'),
  ('야돈', 'Slowpoke'),
  ('루브도', 'Smeargle (Smearguru)'),
  ('주리비얀', 'Snivy'),
  ('잠만보', 'Snorlax'),
  ('잠만보', 'Snorlax (Mosslax)'),
  ('페이검', 'Spinarak'),
  ('나오하', 'Sprigatito'),
  ('꼬부기', 'Squirtle'),
  ('강철톤', 'Steelix'),
  ('싸리용', 'Stretchy Form Tatsugiri'),
  ('꼬지모', 'Sudowoodo'),
  ('파비코', 'Swablu'),
  ('꿀꺽몬', 'Swalot'),
  ('님피아', 'Sylveon'),
  ('덩쿠리', 'Tangela'),
  ('덩쿠림보', 'Tangrowth'),
  ('덩쿠림보', 'Tangrowth (Professor Tangrowth)'),
  ('으랏차', 'Timburr'),
  ('어리짱', 'Tinkatink'),
  ('두드리짱', 'Tinkaton (Tinkmaster)'),
  ('벼리짱', 'Tinkatuff'),
  ('아차모', 'Torchic'),
  ('코터스', 'Torkoal'),
  ('일레즌', 'Toxel'),
  ('톱치', 'Trapinch'),
  ('깨봉이', 'Trubbish'),
  ('블레이범', 'Typhlosion'),
  ('마기라스', 'Tyranitar'),
  ('견고라스', 'Tyrantrum'),
  ('배루키', 'Tyrogue'),
  ('티고라스', 'Tyrunt'),
  ('블래키', 'Umbreon'),
  ('샤미드', 'Vaporeon'),
  ('도나리', 'Venomoth'),
  ('콘팡', 'Venonat'),
  ('이상해꽃', 'Venusaur'),
  ('비퀸', 'Vespiquen'),
  ('비브라바', 'Vibrava'),
  ('우츠보트', 'Victreebel'),
  ('투구뿌논', 'Vikavolt'),
  ('라플레시아', 'Vileplume'),
  ('볼비트', 'Volbeat'),
  ('불카모스', 'Volcarona'),
  ('찌리리공', 'Voltorb'),
  ('식스테일', 'Vulpix'),
  ('어니부기', 'Wartortle'),
  ('찌리비', 'Wattrel'),
  ('우츠동', 'Weepinbell'),
  ('또도가스', 'Weezing'),
  ('트리토돈', 'West Sea Gastrodon'),
  ('깝질무', 'West Sea Shellos'),
  ('푸크린', 'Wigglytuff'),
  ('갈모매', 'Wingull'),
  ('조로아크', 'Zoroark'),
  ('조로아', 'Zorua'),
  ('주뱃', 'Zubat');

insert into public.habitats (habitat_no, name_ko, name_en, is_event, description) values
  (1, '초록 풀숲', 'Tall grass', false, '초록 풀 4개를 붙여서 만든 풀숲. 몸집이 작은 포켓몬이 숨기 좋다.

[Game8] Tall Grass x 4'),
  (2, '나무 그늘의 풀숲', 'Tree-shaded tall grass', false, '낮에도 선선한 나무 그늘의 풀숲. 포켓몬이 잠깐 쉬러 올지도 모른다.

[Game8] Tall Grass x 4 Large Tree (any) x 1'),
  (3, '바위 그늘의 풀숲', 'Boulder-shaded tall grass', false, '큰 바위에 숨겨진 풀숲. 숨바꼭질하기 좋다.

[Game8] Tall Grass x 4 Large boulder x1'),
  (4, '촉촉한 풀숲', 'Hydrated tall grass', false, '물가의 작은 풀숲. 언제나 물이 풍부해서 싱싱하다.

[Game8] Tall Grass x 4 Water x2'),
  (5, '파도치는 풀숲', 'Seaside tall grass', false, '소금기가 있는 물에도 지지 않고 자라난 풀숲. 해안의 더위를 누그러뜨려 준다.

[Game8] Tall Grass x 4 Ocean Water x2'),
  (6, '고지대의 풀숲', 'Elevated tall grass', false, '높은 곳에 자라 있어 매우 시원하다. 풀숲 안쪽까지 바람이 솔솔 분다.

[Game8] Tall Grass x 4 High-up location x1'),
  (7, '빛이 비치는 풀숲', 'Illuminated tall grass', false, '희미하게 빛이 비치는 풀숲. 온화한 빛에 포켓몬이 이끌려 온다.

[Game8] Lighting (any) x 1 Tall Grass (any) x 4'),
  (8, '예쁜 꽃밭', 'Pretty flower bed', false, '들판의 꽃이 모인 예쁜 꽃밭. 달콤한 향기가 은은하게 주위를 감돈다.

[Game8] Wildflowers x 4'),
  (9, '나무 그늘의 꽃밭', 'Tree-shaded flower bed', false, '나무 그늘에서도 아름답고 화려하게 피어난 꽃. 촉촉한 향기에 포켓몬이 모여든다.

[Game8] Wildflowers x 4 Berry Tree (any) x 1'),
  (10, '촉촉한 꽃밭', 'Hydrated flower bed', false, '물가에 피어난 꽃밭. 깨끗한 물과 향기에 이끌려 포켓몬들이 찾아올 것 같다.

[Game8] Wildflowers x 4 Water x2'),
  (11, '꽃이 가득한 풍경', 'Field of flowers', false, '넓게 펼쳐진 꽃밭. 화사한 향기가 일대에 퍼진다.

[Game8] Wildflowers x 8'),
  (12, '고지대의 꽃밭', 'Elevated flower bed', false, '높은 곳에 피어난 꽃들. 달콤한 향기가 바람에 실려 주위에 퍼진다.

[Game8] Wildflowers x 4 High-up location x1'),
  (13, '꽃밭 속의 무덤', 'Grave with flowers', false, '부드럽고 화사한 느낌. 무덤에 잠들어 있는 포켓몬도 좋아할 것 같다.

[Game8] Wildflowers x 4 Gravestone x 1'),
  (14, '플라워 가든', 'Flower garden', false, '만개한 꽃밭에 수풀을 놓으면 작은 가든으로 순식간에 변모한다.

[Game8] Wildflowers x 4 Hedge (any) x 4'),
  (15, '신선한 채소밭', 'Fresh veggie field', false, '광활한 밭에서 채소를 재배하자. 밭일을 좋아하는 포켓몬이 찾아올 것 같다.

[Game8] Vegetable field (any) x8'),
  (16, '따뜻한 바람을 타고', 'Riding warm updrafts', false, '3개의 모닥불이 데워 준 공기가 둥실둥실 높은 곳까지 올라간다.

[Game8] Campfire x 3'),
  (17, '캠핑 세트', 'Campsite', false, '자연물을 활용한 캠핑 세트. 포켓몬들도 모닥불 앞에서 몸을 녹인다.

[Game8] Campfire x 1 Straw Stool x 1 Straw Table x 1'),
  (18, '수행의 폭포', 'Training waterfall', false, '폭포수를 맞으면 몸에 힘이 바짝 들어간다. 단련을 좋아하는 포켓몬이 찾아올 것 같다.

[Game8] Seat (any) x 1 Water x2 Waterfall x1'),
  (19, '꼬르륵 다이닝', 'Tantalizing dining set', false, '의자와 테이블, 그리고 그 위에 놓인 접시. 배고픈 포켓몬이 찾아올지도 모른다.

[Game8] Seat (any) x 1 Table (any) x 1 Plated food x1'),
  (20, '피크닉 식탁', 'Picnic set', false, '테이블에 바구니를 놓으면 살짝 피크닉을 하는 듯한 기분이 든다.

[Game8] Picnic Basket x 1 Seat (any) x 2 Table (any) x 1'),
  (21, '화사한 테이블', 'Flowery table', false, '테이블 위에 꽃병이 놓여 있다. 포켓몬도 의자에 앉아 꽃을 바라볼지도 모른다.

[Game8] Small Vase x 1 Seat (any) x 1 Table (any) x 1'),
  (22, '초록 벤치', 'Bench with greenery', false, '수풀 옆에 놓인 벤치. 포켓몬도 자연을 느끼며 잠시 휴식을 취한다.

[Game8] Hedge (any) x 2 Seat (wide) x 1'),
  (23, '빛이 비치는 벤치', 'Illuminated bench', false, '부드러운 빛이 비치는 벤치. 빛에 이끌려 포켓몬이 찾아올 것 같다.

[Game8] Streetlight (any) x 1 Seat (wide) x 1'),
  (24, '체육관의 휴식처', 'Exercise resting spot', false, '포켓몬들도 격렬한 트레이닝 후에는 의자에 앉아 휴식한다.

[Game8] Punching Bag x 1 Seat (any) x 1'),
  (25, '응급 처치소', 'Urgent care', false, '부상을 입었을 때는 즉시 응급 처치를 해야 한다. 응급 처치에 능한 포켓몬이 찾아올 것 같다.

[Game8] First Aid Kit x 1 Seat (any) x 1 Table (any) x 1'),
  (26, '체육관 응급 처치소', 'Gym first aid', false, '운동으로 부상을 입었을 때는 포켓몬들도 구급상자로 응급 처치한다.

[Game8] First Aid Kit x 1 Punching Bag x 1 Table (any) x 1'),
  (27, '길 안내 간판', 'Road sign', false, '길 한가운데에 덩그러니 세워진 간판. 포켓몬이 화살표가 가리키는 방향으로 걸어갈 수도 있다.

[Game8] Wooden Path x 3 Arrow Sign x 1'),
  (28, '큰 짐을 싣고', 'Large luggage carrier', false, '폭이 넓은 달구지에는 커다란 나무 상자를 2개나 실을 수 있다.

[Game8] Cart x 1 Wooden Crate x 2'),
  (29, '벌목 작업장', 'Lumberjack''s workplace', false, '달구지로 운반한 통나무를 그루터기 위에 놓고 장작을 패자. 피곤하면 의자에 앉아서 쉬자.

[Game8] Log Chair x 1 Cart x 1 Log Table x 1 Tree stump (any) x1'),
  (30, '인형과 꿈나라로', 'Bed with a plush', false, '귀여운 봉제 인형이 놓여 있는 침대. 작은 포켓몬이 안심하고 잠들 수 있을 것 같다.

[Game8] Doll (any) x Bed (any) x 1'),
  (31, '은은한 빛과 꿈나라로', 'Gently lit bed', false, '은은한 빛이 비치는 침대. 포켓몬들이 편안하게 잠들 수 있을 것 같다.

[Game8] Slender Candle x 1 Table (any) x 1 Bed (any) x 1'),
  (32, '무덤과 공물', 'Grave offering', false, '고요히 세워진 무덤 앞에는 양초와 접시가 있다. 약간 기이한 느낌이 난다.

[Game8] Gravestone x 1 Slender Candle x 2 Plated food x1'),
  (33, '기이한 무덤의 공물', 'Creepy grave offering', false, '무덤가의 양초에 불을 붙이면 푸른 불꽃이 일렁이며 기이함이 두 배가 된다.

[Game8] Eerie Candle x 2 Gravestone x 1 Plated food x1'),
  (34, '럭키 휴식처', 'Chansey resting area', false, '럭키가 지켜봐 주는 동안 잠시 쉬자. 기분을 전환할 수 있는 치유의 공간.

[Game8] Hedge (any) x 6 Seat (wide) x 1 Chansey Plant x 1 Hedge (any) x6'),
  (35, '불빛과 향기의 유혹', 'Irresistible scent and glow', false, '버섯의 빛과 꽃병의 향기에 이끌린 포켓몬이 찾아올지도 모른다.

[Game8] Pitcher-Plant Pot x 1 Mushroom Lamp x 1 Plated food x1'),
  (36, '그늘에서 둥실둥실 물놀이', 'Floating in the shade', false, '고무보트를 타고 놀다가 지치면 파라솔 아래에서 잠시 쉬자.

[Game8] Inflatable Boat x 1 Beach Parasol x 1 Water x2'),
  (37, '보송보송한 풀숲', 'Smooth tall grass', false, '보송보송하고 신비한 바위의 힘으로 생기가 없어진 풀숲.

[Game8] Smooth Rock x 1 Dry tall grass x4'),
  (38, '공장의 보관소', 'Factory storage', false, '커다란 머신에 코드를 연결하고 조작해 봐도 작동하지 않는다...

[Game8] Metal Drum x 1 Control Unit x 1 Jumbled Cords x 1 Streetlight (any) x 1'),
  (39, '호화로운 짹짹 푸드', 'Luxury chirp-chirp meal', false, '새포켓몬이 나무열매를 이것저것 맛보면서 새집 안에서 뒹굴거리고 있을 것만 같다.

[Game8] Wooden Birdhouse x 1 Berry Basket x 1 Berry basket x1'),
  (40, '진수성찬 나무열매 캠프', 'Berry-feast campsite', false, '맑은 하늘 아래에서 캠프파이어. 맛있는 음식도 잔뜩 준비해서 즐기자.

[Game8] Castform Weather Charm x 2, (Sun) Bonfire x 1 Berry Basket x 1 Berry basket x1 High-up location x1'),
  (41, '비바라기 스폿', 'Rain Dance site', false, '음식을 올려놓을 수 있는 접시와 비를 연상시키는 물건을 함께 갖춰 놓은 장소.

[Game8] Castform Weather Charm x 2, (Rain) Plated food x1'),
  (42, '쾌청 스폿', 'Sunny Day site', false, '음식을 올려놓을 수 있는 접시와 맑은 날씨를 연상시키는 물건을 함께 갖춰 놓은 장소.

[Game8] Castform Weather Charm x 2, (Sun) Plated food x1'),
  (43, '박사의 보물', 'Professor''s treasure trove', false, '잡동사니로 보이지만 박사에게는 모두 연구 대상이다.

[Game8] Bed (any) x 1 Professor''s Treasure Trove x 1 Lost relic (large) x4'),
  (44, '통나무의 온기', 'Cozy log handicrafts', false, '나무를 활용한 가구가 가득하다. 산속 오두막에 있는 듯한 기분이 들 것 같다.

[Game8] Log Chair x 1 Log Bed x 1 Log Table x 1'),
  (45, '나무열매 총집합', 'Very-berry space', false, '테이블도 침대도 전부 나무열매 무늬다. 바라보고 있으면 배가 고파질 것 같다.

[Game8] Berry Chair x 1 Berry Bed x 1 Berry Table x 1 Berry Table Lamp x 1'),
  (46, '가든 테라스', 'Garden terrace', false, '부드러운 빛이 비치는 꽃을 보며 가든 체어에 앉아 잠시 쉬자.

[Game8] Wildflowers x 4 Garden Chair x 1 Garden Light x 1 Garden Table x 1'),
  (47, '나무 그늘에서 푹 자는 잠만보', 'Tree-shaded snoozing Snorlax', false, '잠만보가 자고 있다고 착각해서 다른 포켓몬이 다가올지도 모른다.

[Game8] Large Tree (any) x 1 Naptime Bed x 1'),
  (48, '예스러운 멋의 앤티크', 'Good old-fashioned antiques', false, '앤티크 가구에 둘러싸여 레트로한 느낌을 맛보자.

[Game8] Antique Dresser x 1 Antique Chair x 1 Antique Closet x 1 Antique Bed x 1'),
  (49, '몬스터볼투성이', 'Nothin'' but Poke Balls', false, '전부 몬스터볼인가 싶었지만 신기하게도 쾌적하게 지낼 수 있는 공간.

[Game8] Poke Ball Sofa x 1 Poke Ball Bed x 1 Poke Ball Table x 1 Poke Ball Light x 1'),
  (50, '노란 풀숲', 'Yellow tall grass', false, '노란 풀이 모여 만들어진 작은 풀숲. 항구 마을에서 자주 볼 수 있다.

[Game8] Yellow Tall Grass x 4'),
  (51, '나무 그늘의 노란 풀숲', 'Tree-shaded yellow tall grass', false, '나무 그늘에 자라난 노란 풀숲. 해 질 녘의 느낌을 만끽할 수 있다.

[Game8] Yellow Tall Grass x 4 Large Tree (any) x 1'),
  (52, '고지대의 노란 풀숲', 'Elevated yellow tall grass', false, '높은 곳에 자란 노란 풀숲. 바닷바람에 흔들리고 있다.

[Game8] Yellow Tall Grass x 4'),
  (53, '축축한 노란 풀숲', 'Hydrated yellow tall grass', false, '물가 근처에 자란 노란 풀숲. 물에서 올라온 포켓몬이 잠시 휴식을 취한다.

[Game8] Yellow Tall Grass x 4 Water x2'),
  (54, '늪지의 풀숲', 'Marshy tall grass', false, '늪지에 자란 작은 풀숲. 묻은 진흙을 풀로 닦아 내는 포켓몬도 있다.

[Game8] Yellow Tall Grass x 4 Muddy Water x2'),
  (55, '풀숲의 자판기', 'Overgrowth vending machine', false, '노란 풀숲에 덩그러니 서 있는 자판기. 자연 속에서도 수분 보충은 걱정 없다.

[Game8] Yellow Tall Grass x 4 Vending Machine x 1'),
  (56, '선선한 꽃밭', 'Breezy flower bed', false, '해안의 꽃들이 모여 있는 선선한 꽃밭. 트로피컬한 향기로 포켓몬을 불러 모은다.

[Game8] Seashore Flowers x 4'),
  (57, '트로피컬 느낌', 'Tropical vibes', false, '야자나무 아래에 핀 해안의 꽃. 트로피컬한 향기가 주위를 감돈다.

[Game8] Seashore Flowers x 4 Large palm tree x1'),
  (58, '바람의 꽃밭', 'Windy flower bed', false, '바람이 솔솔 불어 선선한 꽃밭. 풍차가 꽃향기를 먼 곳까지 실어 나른다.

[Game8] Seashore Flowers x 4 Windmill Kit x 1'),
  (59, '해변의 나무 그늘', 'Shaded beach', false, '야자나무가 파라솔을 대신한다. 포켓몬도 비치 체어에서 잠시 휴식을 취한다.

[Game8] Beach Chair x 1 Large palm tree x1'),
  (60, '트로피컬 해변가', 'Tropical seaside', false, '야자나무 곁에서 바닷바람을 느끼며 여유를 즐기면 트로피컬한 느낌이 난다.

[Game8] Hedge (any) x 4 Large palm tree x1 Ocean water x2'),
  (61, '휴식 장소', 'Resting spot', false, '빈 골판지 상자와 폭신폭신한 건초 침대. 어느 쪽에서 잘지 취향이 갈릴 것 같다.

[Game8] Cardboard Boxes x 1 Straw Bed x 1'),
  (62, '정리정돈 시간', 'Perpetual mess', false, '흩어진 장난감과 골판지 상자. 정리하자마자 다시 어질러진다.

[Game8] Cardboard Boxes x 1 Toy (any) x 2'),
  (63, '쓰레기 집적소', 'Trash collection site', false, '모두의 쓰레기를 모으는 장소이다. 쓰레기를 찾으러 오는 포켓몬도 있을지도 모른다.

[Game8] Garbage Bags x 1 Waste Bin (any) x 1 Sign (any) x 1'),
  (64, '수많은 쓰레기통', 'Trash can central', false, '무단 투기를 방지하기 위해 잔뜩 놓아둔 쓰레기통. 포켓몬이 안에 들어가 있기도 한다.

[Game8] Garbage Bin x 4'),
  (65, '쓰레기장', 'Trash disposal site', false, '전봇대 밑에 쓰레기가 버려져 있다. 주변에서는 아주 조금 악취가 난다.

[Game8] Garbage Bags x 1 Utility Pole x 1'),
  (66, '공원 벤치', 'Park bench', false, '간식을 먹은 뒤에 쓰레기는 쓰레기통에. 포켓몬들도 할 수 있을까?

[Game8] Garbage Bin x 1 Seat (wide) x 1'),
  (67, '꼬르륵 레스토랑', 'Tantalizing restaurant', false, '테이블 위에 식사용 접시가 놓여 있다. 메뉴판도 있어 마치 레스토랑 같다.

[Game8] Menu Board x 1 Seat (any) x 1 Table (any) x 1 Plated food x1'),
  (68, '요리 서빙', 'Tableside delivery cart', false, '트롤리로 요리를 차분히 서빙하자. 테이블에 올리면 식사가 시작된다.

[Game8] Chic Chair x 2 Chic Table x 1 Small Vase x 1 Push Cart x 1 Plated food x1'),
  (69, '짹짹 푸드', 'Chirp-chirp meal', false, '새포켓몬이 접시 위에 놓인 음식에 이끌려 찾아온다.

[Game8] Wooden Birdhouse x 1 Table (any) x 1 Plated food x1'),
  (70, '카페 공간', 'Cafe space', false, '식물을 바라보며 티타임. 포켓몬들도 기분 전환을 할 수 있을 것 같다.

[Game8] Mug x 1 Counter x 2 Menu Board x 1 Seat (any) x 2 Potted Plant (any) x 1'),
  (71, '해변 세트', 'Beach set', false, '파라솔 아래에서 트로피컬한 느낌을 즐겨 보자. 포켓몬들도 뒹굴거릴 것 같다.

[Game8] Beach Chair x 1 Beach Parasol x 1 Side Table x 1'),
  (72, '라이트업 스테이지', 'Light-up stage', false, '눈 부신 빛이 비치는 무대. 주목받고 싶어 하는 포켓몬이 나타날 것이다.

[Game8] Spotlight x 2 Small Stage x 1'),
  (73, '함정 조심', 'Surprise in store', false, '풍선에 둘러싸인 팝한 상자. 안에 무엇이 들어 있는지는 직접 열어서 확인해 보자.

[Game8] Balloons x 2 Boo-In-The-Box x 1'),
  (74, '밤의 축제 회장', 'Night festival venue', false, '축제의 입구는 밤이 되어도 컬러풀한 네온 조명으로 반짝반짝.

[Game8] Raichu Sign x 1 Balloons x 2'),
  (75, '피팅 공간', 'Changing area', false, '옷을 갈아입으면 거울 앞에서 체크해 보자. 원하는 모습으로 변할 수 있는 장소.

[Game8] Closet (any) x 1 Mirror (Large) x 1'),
  (76, '치장 중에는 쳐다보기 금지', 'Private makeup stand', false, '치장 중에는 보이지 않도록 칸막이로 시선을 가리자.

[Game8] Partition (any) x 2 Dresser (any) x 1 Closet (any) x 1'),
  (77, '털실로 뜨개질', 'Knitting station', false, '폭신폭신한 털실로 만든 수예품에 포켓몬들도 눈을 떼지 못한다.

[Game8] Seat (any) x 1 Table (any) x 1 x 1'),
  (78, '몸을 씻고 온천으로', 'Hot-spring shower', false, '샤워기로 몸을 잘 씻고 난 다음 들어가자. 온천에 몸을 담근 포켓몬들이 있을지도 모른다.

[Game8] Shower x 1 Seat (any) x 1 Hot-spring water x2'),
  (79, '리조트에서 식사 준비', 'Resort meal prep', false, '야자나무 아래에서 모닥불을 쬐며 차근차근 식사를 준비하자.

[Game8] Campfire x 1 Seat (any) x 1 Large palm tree x1 Plated food x1'),
  (80, '짐 싸기 완료', 'All packed up', false, '빈 골판지 상자에 물건을 가득 채워서 달구지에 싣자.

[Game8] Cart x 1 Cardboard Boxes x 2'),
  (81, '완치될 때까지 꿈나라로', 'Full recovery', false, '병이 나으려면 자는 것이 가장 좋다. 돌보는 것을 좋아하는 포켓몬이 찾아올지도 모른다.

[Game8] Plain Chest x 1 First Aid Kit x 1 Bed (any) x 1'),
  (82, '알람 시계와 침대 공간', 'Alarm clock sleep zone', false, '침대맡에 알람 시계를 맞춰 두면 못 일어날 걱정은 없다.

[Game8] Alarm clock x 1 Table (any) x 1 Bed (any) x 1'),
  (83, '자판기 옆에서 휴식', 'Vending machine break area', false, '자판기 옆에 놓인 긴 벤치. 포켓몬들도 잠시 휴식하러 올지도 모른다.

[Game8] Vending Machine x 1 Seat (wide) x 1'),
  (84, '자판기 세트', 'Vending machine set', false, '자판기 옆에는 쓰레기통이 놓여 있다. 빈 캔은 들어 있지 않은 듯하다.

[Game8] Vending Machine x 1 Waste Bin (any) x 1'),
  (85, '미니 게임코너', 'Mini Game Corner', false, '아케이드 게임을 즐긴 뒤에는 펀치 머신으로 몸을 움직이자.

[Game8] Seat (any) x 1 Arcade Machine x 1 Punching Game x 1'),
  (86, '수력 발전소', 'Waterwheel spot', false, '위에서 떨어지는 폭포수로 전기를 생산하는 굉장한 시설.

[Game8] Waterwheel Kit x 1 Water x1 Waterfall x1'),
  (87, '화력 발전소', 'Furnace spot', false, '연료를 넣으면 불꽃의 힘으로 전기를 생산하는 굉장한 시설.

[Game8] Metal Drum x 1 Furnace Kit x 1'),
  (88, '선착장', 'Dock', false, '해안에 있는 아담한 선착장. 헤엄치는 포켓몬들도 잠시 들를 것 같다.

[Game8] Walkway x 4 Streetlight (any) x 1 Ocean water x2'),
  (89, '괴상한 서재', 'Spooky study', false, '촛불을 켜고 책을 읽자. 밤이 되면 괴상한 느낌이 난다.

[Game8] Bookcase x 1 Chic Sofa x 1 Plain Table x 1 Slender Candle x 1'),
  (90, '선원 놀이', 'Playing pirate', false, '핸들 앞이나 대포 뒤에 서면 마치 선원이 된 기분이 든다.

[Game8] Barrel x 2 Ship''s Wheel x 1 Cannon x 2'),
  (91, '어서 오세요 계산대', 'Working the register', false, '테이블에 계산대를 놓고 전기를 흘려 보내면 순식간에 가게 완성!

[Game8] Cash Register x 1 Table (any) x 2'),
  (92, '작은 아틀리에', 'Tiny atelier', false, '의자에 앉아 캔버스를 바라보면 영감이 솟아오를 것 같다.

[Game8] Seat (any) x 1 Canvas x 1'),
  (93, '맛있는 공물', 'Gourmet''s altar', false, '접시 위에 음식을 올려 두면 대식가 포켓몬이 좋아할 것 같다.

[Game8] Offering dish x1'),
  (94, '피카츄 공간', 'Pikachu space', false, '소파도 인형도 모두 피카츄. 진짜로 착각한 포켓몬이 찾아올지도 모른다.

[Game8] Pikachu Sofa x 1 Pikachu Doll x 1'),
  (95, '너무 깜찍한 공간', 'Cuteness overload', false, '깜찍한 것들에 둘러싸여 마치 공주가 된 듯한 기분이 든다.

[Game8] Cute Sofa x 1 Cute Table x 1 Cute Lamp x 1 Cute Bed x 1 Cute Dresser x 1'),
  (96, '리조트에 어서 오세요', 'Welcoming resort', false, '소파나 해먹에 누워 뒹굴거리면 마치 유명 인사가 된 기분이 든다.

[Game8] Resort Sofa x 1 Resort Table x 1 Resort Hammock x 1 Resort Light x 1'),
  (97, '내추럴한 생활', 'Plain life', false, '심플하지만 아늑한 공간. 포켓몬들에게도 쾌적할 것 같다.

[Game8] Plain Bed x 1 Plain Sofa x 1 Plain Table x 1 Plain Lamp x 1'),
  (98, '빨간 풀숲', 'Red tall grass', false, '빨간 풀이 모여 만들어진 작은 풀숲. 산간 지역에서 자주 볼 수 있다.

[Game8] Red Tall Grass x 4'),
  (99, '나무 그늘의 빨간 풀숲', 'Tree-shaded red tall grass', false, '촉촉한 빨간 풀의 향기에 이끌려 포켓몬들이 찾아온다.

[Game8] Red Tall Grass x 4 Large Tree (any) x 1'),
  (100, '세모 나무 그늘의 바위와 풀숲', 'Pointy tree-shaded rocky tall grass', false, '키 큰 세모난 나무를 바라보며 풀숲에서 바위에 기대어 잠시 휴식을 취하자.

[Game8] Red Tall Grass x 4 Pointy tree x1 Large boulder x1'),
  (101, '촉촉한 빨간 풀숲', 'Hydrated red tall grass', false, '빨간 풀은 보통 산간 지역에서 자라지만 물가에서도 문제없이 자라난다.

[Game8] Red Tall Grass x 4 Water x2'),
  (102, '고지대의 빨간 풀숲', 'Elevated red tall grass', false, '산 정상처럼 높은 곳에서도 빨간 풀은 잔뜩 자라 있다.

[Game8] Red Tall Grass x 4'),
  (103, '풀숲 트레이닝장', 'Grassy training field', false, '모래를 채운 주머니는 덤벨의 대체품이다. 트레이닝을 좋아하는 포켓몬이 올 것 같다.

[Game8] Red Tall Grass x 4 Sandbags x 2'),
  (104, '우아한 꽃밭', 'Graceful flower bed', false, '바위 지대의 꽃이 많이 피어 있는 우아하고 아름다운 꽃밭.

[Game8] Mountain Flowers x 4'),
  (105, '나무 그늘의 우아한 꽃밭', 'Tree-shaded graceful flower bed', false, '바위 지대의 꽃의 고상한 향기가 주위에 차분히 퍼진다.

[Game8] Mountain Flowers x 4'),
  (106, '촉촉한 우아한 꽃밭', 'Hydrated graceful flower bed', false, '바위 지대의 꽃은 물가에서도 꿋꿋하고 아름답게 피어 있다.

[Game8] Mountain Flowers x 4 Water x2'),
  (107, '꽃밭의 그루터기 스테이지', 'Flower garden stump stage', false, '꽃밭 안에 만들어진 스테이지. 그루터기에 올라 빛을 받으면 스타가 된 기분이 든다.

[Game8] Mountain Flowers x 4 Mushroom Lamp x 2 Tree stump (any) x1'),
  (108, '밭일로 땅이 뻘뻘', 'Toil in the soil', false, '밭의 채소는 건강하게 성장 중이다. 때로는 흙을 갈아엎어서 영양을 보충시켜 주자.

[Game8] Wheelbarrow x 1 Vegetable field (any) x4'),
  (109, '둥둥 웅덩이', 'Uplifting duckweed', false, '개구리밥 위를 걷는 것도 좋고 함께 둥실둥실 떠 있어도 좋다.

[Game8] Duckweed x4 Water x2'),
  (110, '이끼투성이', 'Mossy rest spot', false, '축축하고 이끼가 빽빽하다. 습한 장소를 좋아하는 포켓몬에게 딱 맞는다.

[Game8] Moss x 4'),
  (111, '이끼투성이 바위', 'Mossy boulder', false, '고요하고 차분한 느낌이 난다. 포켓몬들도 여유롭게 지낼 수 있을 것 같다.

[Game8] Moss x 4 Mossy boulder x1'),
  (112, '이끼 낀 온천', 'Mossy hot spring', false, '푸른 이끼에 둘러싸인 온천. 고즈넉한 정취를 느끼며 여유를 만끽할 수 있다.

[Game8] Moss x 4 Hot-spring water x2'),
  (113, '노천탕', 'Open-air bath', false, '포켓몬들도 온천에 몸을 담그면서 아름다운 경치를 즐긴다.

[Game8] Hot-Spring Spout x 1 Hot-spring water x2'),
  (114, '번갈아 온천', 'Harmonious hot spring', false, '뜨거운 온천과 차가운 냉탕에 번갈아 들어가면 몸이 가벼워져서 개운하다.

[Game8] Hot-Spring Spout x 1 Water Basin x 1 Hot-spring water x2'),
  (115, '이글이글 마그마', 'Piping-hot lava', false, '뜨거운 마그마만 가득하다. 불꽃타입 포켓몬에게는 최고의 공간이다.

[Game8] Molten rock x1 Lava x2'),
  (116, '땅 파고 태우고', 'Digging and burning', false, '작업 도구 옆에는 커다란 화로가 있다. 누군가가 불을 붙이러 올지도 모르겠다.

[Game8] Wheelbarrow x 1 Excavation Tools x 1 Smelting Furnace x 1'),
  (117, '덜컹덜컹 철골 공사', 'Clink-clang iron construction', false, '철골 공사가 한창 진행 중이다. 힘이 센 포켓몬이 도와주러 올 것 같다.

[Game8] Wheelbarrow x 1 Excavation Tools x 1 Sandbags x 1 Iron beam or column x3'),
  (118, '기이한 하얀 바위', 'Creepy white rocks', false, '키 큰 바위 주변에는 이끼가 빽빽하게 덮여 있다. 랜턴 빛으로 약간 기이한 느낌이 감돈다.

[Game8] Moss x 4 Wooden Crate x 1 Lantern x 1 Stalagmites x1'),
  (119, '짐 보관소에서 몰래 꿀꺽', 'Container snacking', false, '짐 보관소에서 몰래 꿀꺽 집어 먹어 보자. 포켓몬들도 슬쩍 다가올 것 같다.

[Game8] Barrel x 1 Wooden Crate x 1 Lantern x 1 Plated food x1'),
  (120, '두근두근 식탁', 'Dinner table surprise', false, '오늘의 메인 요리는 뚜껑을 열어서 직접 확인해 보자.

[Game8] Party Platter x 4 Table (large) x 1 Seat (wide) x 2'),
  (121, '와구와구 빵 공방', 'Best bread bakery', false, '빵이 구워지기를 기다리면서 곁들여 먹을 음식을 준비하자.

[Game8] Bread Oven x 1 Counter x 2 Plated food x1'),
  (122, '미니 키친', 'Mini kitchen', false, '식재료와 접시를 깨끗하게 씻고 가스레인지에서 요리하자. 오늘의 메뉴는 과연?

[Game8] Kitchen Table x 1 Cooking Stove x 1 Modern Sink x 1 Frying Pan x 1 Frying pan x1'),
  (123, '다 함께 파티', 'House party', false, '음식과 음료는 셀프서비스. 모두와 함께 신나게 즐기자.

[Game8] Food Counter x 1 Paper Party Cups x 1 Plated food x1'),
  (124, '느긋하게 사진을 돌아보며', 'Lazy photo-album scrolling', false, '느긋하게 한 손에 음료를 들고 태블릿 화면으로 사진을 다시 보자.

[Game8] Tablet x 1 Paper Party Cups x 1'),
  (125, '지저귀는 리사이틀', 'Chirping recital', false, '새포켓몬이 마이크 앞에서 아름다운 노랫소리를 들려줄지도 모른다.

[Game8] Perch x 1 Standing Mic x 1'),
  (126, '리사이틀 스테이지', 'Recital stage', false, '전용 스테이지에 올라가서 Let&#x27;s sing!

[Game8] Speaker x 2 Standing Mic x 1 Small Stage x 1'),
  (127, '리듬에 맞춰 원투', 'Box to the rhythm', false, '포켓몬들도 리듬에 맞춰 신나게 트레이닝.

[Game8] Punching Bag x 1 CD Player x 1 Table (any) x 1'),
  (128, '음악과 독서', 'Music and magazines', false, 'BGM을 들으면서 책을 읽으면 평소보다 기분 전환이 될 것 같다.

[Game8] CD Rack x 1 CD Player x 1 Magazine Rack x 1'),
  (129, '쁘띠 박물관', 'Mini museum', false, '전시대 위에 딱 올려두면 무엇이든 명품으로 보인다.

[Game8] Exhibition Stand x 1 Post (any) x 3 Lost relic (large) x1'),
  (130, '산뜻한 라커 룸', 'Refreshing locker room', false, '심플한 라커 룸도 관엽식물을 놓으면 산뜻한 느낌이 난다.

[Game8] Punching Game x 1 Seat (wide) x 1 Potted Plant (any) x 1 Office Locker x 2'),
  (131, '동상 관광 스폿', 'Bronze landmark', false, '사진 찍기 좋아 보이는 동상. 3마리의 귀여움에 모두 헤롱헤롱해진다.

[Game8] Sign x 1 Moonlight Dance Statue Kit x 1 Hedge (any) x 4'),
  (132, '건널목', 'Railroad crossing', false, '차단기가 내려와 있는 동안은 통행금지. 포켓몬들도 멈춰 설지도...?

[Game8] Railway Track x 1 Crossing Gate x 1'),
  (133, '셰프의 부엌', 'Chef''s kitchen', false, '가스레인지와 싱크대, 조리 도구까지 모두 셰프가 마음에 들어 할 것 같은 장소.

[Game8] Cooking Stove x 1 Plain Table x 1 Cutting Board x 1 Modern Sink x 1 Stylish Cooking Pot x 1 Plated food x1'),
  (134, '최고급 럭셔리', 'Absolute luxury', false, '놓여 있는 가구는 모두 최고급이다. 최고로 럭셔리한 공간.

[Game8] Luxury Lamp x 1 Luxury Bed x 1 Luxury Sofa x 1 Luxury Table x 1'),
  (135, '묵직한 아이언', 'Heavy iron', false, '중후함이 느껴지는 모노톤 공간. 랜턴을 켜면 더 차분한 느낌의 공간이 된다.

[Game8] Iron Bed x 1 Iron Table x 1 Iron Chair x 1 Lantern x 1'),
  (136, '모던 라이프', 'Modern living', false, '심플하고 스타일리시하다. 모던한 디자인이 어딘가 멋지다.

[Game8] Industrial Bed x 1 Industrial Desk x 1 Industrial Chair x 1'),
  (137, '분홍 풀숲', 'Pink tall grass', false, '분홍 풀이 모여 만들어진 작은 풀숲. 부유섬에서 자주 볼 수 있다.

[Game8] Pink Tall Grass x 4'),
  (138, '나무 그늘의 분홍 풀숲', 'Tree-shaded pink tall grass', false, '나무 그늘에 자라난 분홍 풀은 약간 축축하다.

[Game8] Pink Tall Grass x 4 Large Tree (any) x 1'),
  (139, '촉촉한 분홍 풀숲', 'Hydrated pink tall grass', false, '분홍 풀과 푸른 물의 대비가 아름다운 풀숲.

[Game8] Pink Tall Grass x 4 Water x2'),
  (140, '고지대의 분홍 풀숲', 'Elevated pink tall grass', false, '구름보다 더 높은 장소에 있는 분홍 풀숲. 불어오는 바람에도 지지 않고 자라 있다.

[Game8] Pink Tall Grass x 4 High-up location x1'),
  (141, '토관 비밀기지', 'Concrete pipe secret base', false, '오랜 시간 사용되지 않은 토관. 안이 비어 있어 비밀기지로 삼기 좋다.

[Game8] Concrete Pipe x 3 Tall Grass (any) x 4'),
  (142, '폭신폭신 꽃밭', 'Fluffy flower bed', false, '보송보송 부유섬의 꽃이 가득한 귀여운 꽃밭.

[Game8] Skyland Flowers x 4'),
  (143, '나무 그늘의 폭신폭신 꽃밭', 'Tree-shaded fluffy flower bed', false, '시원한 나무 그늘에서도 부유섬의 꽃은 폭신폭신 깜찍하게 피어 있다.

[Game8] Skyland Flowers x 4 Large Tree (any) x 1'),
  (144, '촉촉한 폭신폭신 꽃밭', 'Hydrated fluffy flower bed', false, '물속에서도 부유섬의 꽃의 온화한 향기가 부드럽게 퍼진다.

[Game8] Skyland Flowers x 4 Water x2'),
  (145, '물가의 작은 배', 'Waterside dinghy', false, '잔잔하게 시간이 흐르는 물가. 카누를 타고 여유롭게 즐기자.

[Game8] Canoe x 1 Duckweed x2 Water x2 High-up Location x1'),
  (146, '빛이 비치는 폭포', 'Illuminated waterfall', false, '불을 켜서 폭포까지 길을 밝히자. 포켓몬들도 폭포를 구경하러 올지도 모른다.

[Game8] Stepping Stones x 3 Torch x 2 Water x3 Waterfall x1'),
  (147, '지저귀는 가든', 'Birdsong garden', false, '쾌적한 새집과 정돈된 수풀. 어디선가 지저귀는 소리가 들리는 것 같다.

[Game8] Stylish Hedge x 1 Wooden Birdhouse x 1'),
  (148, '심플한 욕실', 'Simple bathroom', false, '평범한 욕실. 포켓몬들도 몸을 씻으러 올지도 모른다.

[Game8] Shower x 1 Bathtub x 1'),
  (149, '사이클링 도중의 휴식', 'Cycling rest stop', false, '자전거를 세우고 잠깐 휴식을 취하자. 자판기 뒤에 포켓몬이 숨어 있을 때도 있다.

[Game8] Bike x 1 Vending Machine x 1'),
  (150, '벽난로 곁에서 꾸벅꾸벅', 'Fireplace nap spot', false, '벽난로 곁에 있으면 차가워진 몸도 서서히 따뜻해진다.

[Game8] Stone Fireplace x 1 Seat (wide) x 1'),
  (151, '넘치는 사이코 파워', 'Surging psychic power', false, '수정을 앞에 두고 강하게 염원하면 보이지 않는 힘을 다룰 수 있을지도... 모른다.

[Game8] Simple Cushion x 1 Crystal Ball x 1'),
  (152, '수정 구슬 점', 'Fortune-teller''s table', false, '사이코 파워로 수정을 들여다보면 미래의 일을 알 수 있을지도?

[Game8] Crystal Ball x 1 Seat (any) x 2 Table (any) x 1'),
  (153, '쓰레기장의 TV', 'Trash site TV', false, '쓰레기장에 덩그러니 놓여 있는 TV. 아직 전원은 켜지는 것 같다.

[Game8] Garbage Bags x 2 Television x 1'),
  (154, '대형 쓰레기 수거장', 'Oversized dumping ground', false, '큰 물건도 버릴 수 있는 쓰레기장. 필요 없는 가전제품을 놓아두자.

[Game8] Tires x 1 Waste Bin (any) x 1 Microwave Oven x 1 Iron beam or column x3'),
  (155, '파트너와 취조 시간', 'Interrogation desk', false, '윈디와 한창 취조 중이다. 주변 공기는 팽팽하게 긴장되어 있다.

[Game8] Arcanine Doll x 1 Folding Chair x 2 Industrial Desk x 1 Desk Light x 1'),
  (156, '맨홀 점검 중', 'Sewer-hole inspection', false, '맨홀 수리 점검 중. 관계자 외 출입 금지.

[Game8] Iron Pipes x 1 Sewer-Hole Cover x 1 Excavation Tools x 1 Traffic Cone x 1'),
  (157, '반짝반짝 세면장', 'Spotless washing station', false, '세수하고 수건으로 닦으면 상쾌하다. 거울로 몸가짐도 확인해 보자.

[Game8] Towel Rack x 1 Sink x 1 Wall Mirror x 1'),
  (158, '홈 시어터', 'Home theater', false, '큰 스피커와 TV를 놓으면 마치 영화관 같은 느낌이 난다.

[Game8] Speaker x 2 Television x 1 Stand (any) x 1'),
  (159, '공부 공간', 'Study area', false, '연필을 들고 책상에 앉기만 해도 조금 똑똑해진 기분이 든다.

[Game8] Bookcase x 1 Pencil Holder x 1 Seat (any) x 1 Table (any) x 1'),
  (160, '리드미컬한 거실', 'Rhythmic living room', false, '큰 TV로 리듬 게임을 즐길 수 있다. 리듬에 맞춰 매트 위를 걸어 보자.

[Game8] Speaker x 2 Television x 2 Music Mat (any) x 4'),
  (161, '청소를 뽀득뽀득', 'Squeaky clean', false, '메리프 스펀지에 세제를 듬뿍 묻혀서 물때를 박박 닦자.

[Game8] Bathtub x 1 Cleaning Supplies x 1'),
  (162, '함초롬한 화장대', 'Moisturizing makeup stand', false, '피부를 촉촉하게 보습하면 평소보다 메이크업이 잘 먹힐 것 같다.

[Game8] Seat (any) x 1 Dresser (any) x 1 Humidifier x 1'),
  (163, '쁘띠 도서관', 'Mini library', false, '램프의 불을 켜면 밤에도 찬찬히 책을 찾을 수 있다.

[Game8] Bookcase x 2 Step Stool x 1 Lighting (any) x 1 Table (any) x 1'),
  (164, '게임코너에서 대전', 'Game Corner battle zone', false, '나란히 앉으면 대전 게임이 시작된다. 포켓몬들도 놀러 올지도 모른다.

[Game8] Arcade Machine x 2 Seat (any) x 2'),
  (165, '놀이 공간', 'Playland', false, '큰 미끄럼틀을 탈지 장난감으로 놀지 망설여진다.

[Game8] Slide x 1 Toy (any) x 1'),
  (166, '업무 데스크', 'Work desk', false, '사무실 의자에 앉아 타자를 타닥타닥. 지치면 음료수를 마시며 잠시 휴식을 취하자.

[Game8] Mug x 1 Office Desk x 1 Laptop x 1 Office Chair x 1'),
  (167, '사무실 뒤편', 'Office storeroom', false, '옛 자료나 사용하지 않는 비품 등이 놓인 장소. 포켓몬이 잘못 들어와 헤매기도 한다.

[Game8] Office Shelf x 1 Cardboard Boxes x 1 Step Stool x 1'),
  (168, '실험 공간', 'Experiment space', false, '많은 실험을 할 수 있는 공간. 누군가의 연구 기록이 남아 있을지도 모른다.

[Game8] Science Experiment x 1 Paper x 1 Microscope x 1'),
  (169, '박사를 목표로 연구 중', 'Professor''s apprentice program', false, '연구를 계속하다 보면 덩쿠림보 박사처럼 아는 것이 많아질지도 모른다.

[Game8] Whiteboard x 1 Jumbled Cords x 1 Laptop x 1 Table (any) x 1'),
  (170, '연구자의 데스크', 'Researcher''s desk', false, '연구 테마는 포켓몬과 과학. 데이터는 컴퓨터에 입력되어 있다.

[Game8] Science Experiment x 1 Table (any) x 1 Computer x 1'),
  (171, '자유롭게 읽어 주세요', 'Public reading material', false, '비치된 신문과 잡지는 누구나 자유롭게 가져가도 된다.

[Game8] Magazine Rack x 1 Newspaper x 1'),
  (172, '두근두근 깜짝 상자', 'Heart-pounding surprise box', false, '스포트라이트와 북의 리듬에 따라 깜짝 상자가 열린다. 두근거리는 긴장감은 최고!

[Game8] Spotlight x 2 Boo-In-The-Box x 1 Big Drum x 1'),
  (173, '장난 스위치', 'Prank button', false, '깜짝 상자 곁의 노골적인 스위치. 누르거나 말거나 당신 마음대로.

[Game8] Floor Switch x 1 Boo-In-The-Box x 1'),
  (174, '경치 좋은 포토존', 'Picturesque photo cutout board', false, '높은 곳에 오른 기념으로 패널의 구멍에 얼굴을 맞추고 찰칵!

[Game8] Photo Cutout Board x 1 Spotlight x 2 High-up location x1'),
  (175, '타이어 놀이터', 'Tire park', false, '어째서인지 큰 미끄럼틀보다도 타이어가 시선을 끈다. 다양한 타이어를 가지고 놀자.

[Game8] Slide x 1 Tire Toy x 2 Tires x 1'),
  (176, '자연 속 마켓', 'Nature''s market', false, '계산대에 전기를 흘려 보내면 자연 속에서도 모두와 거래할 수 있다.

[Game8] Cash Register x 1 Large Tree (any) x 1 Table (any) x 1 Large boulder x1'),
  (177, '공사 현장의 발전소', 'Construction-site generator', false, '공사 현장에도 전기가 많이 필요하다. 남은 목재를 연료로 사용해 버리자.

[Game8] Furnace Kit x 1 Iron Scaffold x 2 Iron Pipes x 1'),
  (178, '도장에서 트레이닝', 'Dojo training', false, '무도의 정신을 익히면 무거운 바위도 움직일 수 있을지도 모른다.

[Game8] Strength rock x2'),
  (179, '악의 조직 아지트', 'Evil organization HQ', false, '조직의 마크를 배경으로 폭신한 의자에 앉으면 마치 보스가 된 기분이 든다.

[Game8] Team Rocket Wall Hanging x 1 Luxury Sofa x 1 Potted Plant (any) x 2'),
  (180, '아홉 개의 불길', 'Nine flames', false, '아홉 개의 화톳불이 일렁일렁. 주위가 어쩐지 신비로운 느낌이 난다.

[Game8] Firepit x 9'),
  (181, '봉제 인형 천국', 'Plush central', false, '놓여 있는 것은 전부 봉제 인형이지만 진짜와 착각하는 포켓몬이 있을지도 모른다.

[Game8] Arcanine Doll x 1 Dragonite Doll x 1 Pikachu Doll x 1 Eevee Doll x 1'),
  (182, '최고의 게임 환경', 'Gamer''s paradise', false, '게임을 하기에 아주 쾌적한 공간. 의자에 앉아 게임 세계에 몰입해 보자.

[Game8] Gaming Bed x 1 Gaming Pc x 1 Gaming Chair x 1 Gaming Fridge x 1 Table (any) x 1'),
  (183, '팝 오브 팝', 'Top pop', false, '팝하고 컬러풀한 가구에 둘러싸여 있으면 절로 신이 날 것만 같다.

[Game8] Pop Art Bed x 1 Pop Art Sofa x 1 Pop Art Table x 1'),
  (184, '낚시터', 'Fishing pond', false, '낚싯줄을 드리우고 조용히 기다리면 물타입 포켓몬이 찾아올 수도 있다.

[Game8] Fishing Rod x 1 Seat (any) x 1 Water x1'),
  (185, '바다낚시', 'Ocean fishing spot', false, '바다에서도 낚시를 즐기자. 강이나 호수와는 다른 포켓몬이 찾아올지도 모른다.

[Game8] Fishing Rod x 1 Seat (any) x 1 Ocean water x1'),
  (186, '늪 낚시', 'Marsh fishing spot', false, '늪지에도 포켓몬이 살고 있다. 진흙 근처에 낚싯줄을 드리우자.

[Game8] Fishing Rod x 1 Seat (any) x 1 Muddy Water x1'),
  (187, '온천 낚시', 'Hot-spring fishing spot', false, '온천에 들어가 있는 포켓몬이 낚시 미끼에 이끌려 다가올지도 모른다.

[Game8] Fishing Rod x 1 Seat (any) x 1 Hot-spring water x1'),
  (188, '마그마 낚시', 'Magma fishing spot', false, '마그마 속에도 낚싯줄을 드리우면 포켓몬을 낚을 수 있을까...?

[Game8] Seat (any) x 1 Fishing Rod x 1 Lava x1'),
  (189, '하이한 록 스테이지', 'Amped rock stage', false, '기타를 &#x27;쟈가쟝&#x27;하고 울리면 하이 텐션의 퍼포먼스가 시작된다.

[Game8] Speaker x 2 Cool Electric Guitar x 1 Small Stage x 1 Standing Mic x 1'),
  (190, '로우한 록 스테이지', 'Low-key rock stage', false, '베이스를 &#x27;베엥&#x27;하고 울리면 로우 텐션의 퍼포먼스가 시작된다.

[Game8] Speaker x 1 Small Stage x 1 Standing Mic x 1 Cool Bass Guitar x 1'),
  (191, '원념의 기사 제단', 'Malicious knight''s shrine', false, '수상한 의식이 행해질 것 같은 조금 어두운 공간.

[Game8] Exhibition Stand x 1 Malicious Armor x 1 Stepping Stones x 2 Firepit x 2'),
  (192, '충성의 기사 제단', 'Auspicious knight''s shrine', false, '수상한 의식이 행해질 것 같은 조금 미스터리한 공간.

[Game8] Exhibition Stand x 1 Stepping Stones x 2 Firepit x 2 Auspicious Armor x 1'),
  (193, '날개화석 전시대', 'Wing Fossil display', false, '고대 포켓몬의 화석을 전시하고 있다. 하늘의 왕의 훌륭한 골격이다.

[Game8] Exhibition Stand x 1 Wing Fossil (Head) x 1 Wing Fossil (Right Wing) x 1 Wing Fossil (Left Wing) x 1 Wing Fossil (Body) x 1 Wing Fossil (Tail) x 1'),
  (194, '두개의화석 전시대', 'Skull Fossil display', false, '고대 포켓몬의 화석을 전시하고 있다. 철처럼 단단한 두개골이다.

[Game8] Exhibition Stand x 1 Skull Fossil x 1'),
  (195, '박치기화석 전시대', 'Headbutt Fossil display', false, '고대 포켓몬의 화석을 전시하고 있다. 강철보다도 단단한 두개골이다.

[Game8] Exhibition Stand x 1 Headbutt Fossil (Head) x 1 Headbutt Fossil (Body) x 1 Headbutt Fossil (Tail) x 1'),
  (196, '방패의화석 전시대', 'Armor Fossil display', false, '고대 포켓몬의 화석을 전시하고 있다. 방패처럼 튼튼한 프릴이다.

[Game8] Exhibition Stand x 1 Armor Fossil x 1'),
  (197, '실드화석 전시대', 'Shield Fossil display', false, '고대 포켓몬의 화석을 전시하고 있다. 방벽처럼 크고 튼튼한 프릴이다.

[Game8] Exhibition Stand x 2 Shield Fossil (Head) x 1 Shield Fossil (Body) x 1 Shield Fossil (Tail) x 1'),
  (198, '턱화석 전시대', 'Jaw Fossil display', false, '고대 포켓몬의 화석을 전시하고 있다. 무엇이든 깨물어 부수는 턱의 일부다.

[Game8] Exhibition Stand x 1 Jaw Fossil x 1'),
  (199, '폭군화석 전시대', 'Despot Fossil display', false, '고대 포켓몬의 화석을 전시하고 있다. 대지의 왕의 훌륭한 골격이다.

[Game8] Exhibition Stand x 1 Despot Fossil (Head) x 1 Despot Fossil (Body) x 1 Despot Fossil (Legs) x 1 Despot Fossil (Tail) x 1'),
  (200, '지느러미화석 전시대', 'Sail Fossil display', false, '고대 포켓몬의 화석을 전시하고 있다. 얼어붙어 있던 목지느러미의 일부다.

[Game8] Exhibition Stand x 1 Sail Fossil x 1'),
  (201, '툰드라화석 전시대', 'Tundra Fossil display', false, '고대 포켓몬의 화석을 전시하고 있다. 오로라처럼 아름다운 목지느러미다.

[Game8] Exhibition Stand x 1 Tundra Fossil (Head) x 1 Tundra Fossil (Body) x 1 Tundra Fossil (Tail) x 1'),
  (202, '팝핑 블루', 'Boundless blue beverage', false, '투명한 파란색 크림소다. 바닷속을 보는 것 같다.

[Game8] Soda Float x 1 Seat (any) x 1 Table (any) x 1'),
  (203, '짜릿한 감자튀김', 'Electrifying potatoes', false, '바삭하게 튀긴 별 모양 감자튀김. 먹으면 짜릿할 만큼 맛있다.

[Game8] Fried Potatoes x 1 Seat (any) x 1 Table (any) x 1'),
  (204, '불탈 만큼 매콤한 맛', 'Burning-hot spice', false, '매콤한 소스를 뿌린 동그란 피자. 불을 뿜을 정도로 맵다.

[Game8] Pizza x 1 Seat (any) x 1 Table (any) x 1'),
  (205, '엘레강트한 오후', 'Elegant daytime treats', false, '오후의 애프터눈 티. 의자에 앉아서 먹으면 우아한 기분이 든다.

[Game8] Afternoon Tea Set x 1 Seat (any) x 1 Table (any) x 1'),
  (206, '다크한 맛', 'Dark-chocolate cookies', false, '다크 초콜릿으로 만든 쿠키. 달지는 않지만 어딘가 부드러운 맛이 난다.

[Game8] Chocolate Cookies x 1 Seat (any) x 1 Table (any) x 1'),
  (207, '채소 듬뿍 샌드위치', 'Leafy greens sandwich', false, '채소가 듬뿍 들어간 샌드위치를 먹으면 왠지 기운이 날 것 같다.

[Game8] Sandwiches x 1 Seat (any) x 1 Table (any) x 1'),
  (208, '시원한 빙수', 'Chilly shaved ice', false, '얼음덩어리를 곁들인 빙수. 먹으면 온몸이 싸늘해져 얼어 버릴 것 같다.

[Game8] Shaved Ice x 1 Seat (any) x 1 Table (any) x 1'),
  (209, '러블리한 케이크', 'Lovely ribbon cake', false, '큰 리본과 하트 데코레이션으로 꾸며 무척 러블리하다. 맛은 매우 달콤하다.

[Game8] Ribbon Cake x 1 Seat (any) x 1 Table (any) x 1'),
  (210, 'Yellow carpet (#E-001)', 'Yellow carpet (#E-001)', true, '[Game8] Dandy Flowers x 4'),
  (211, 'Field-trip friends (#E-002)', 'Field-trip friends (#E-002)', true, '[Game8] Flower Backpack x 1 Lunch Box x 1 Hoppip Water Bottle x 1'),
  (212, 'Dandelion lunchtime (#E-003)', 'Dandelion lunchtime (#E-003)', true, '[Game8] Dandy Flowers x 1 Lunch Box x 1 Flower Cushion x 1 Flowery Table Setting x 1'),
  (213, 'Treasure-hunting set (#E-004)', 'Treasure-hunting set (#E-004)', true, '[Game8] Adventure Kit x 1 Treasure x 1 Map And Compass x 1');

insert into public.habitat_spawn_rules (habitat_id, pokemon_id, time_condition, weather_condition) values
((select id from public.habitats where habitat_no = 1), (select id from public.pokemon where name_en = 'Bulbasaur'), null, null),
((select id from public.habitats where habitat_no = 1), (select id from public.pokemon where name_en = 'Charmander'), null, null),
((select id from public.habitats where habitat_no = 1), (select id from public.pokemon where name_en = 'Charizard'), null, null),
((select id from public.habitats where habitat_no = 1), (select id from public.pokemon where name_en = 'Squirtle'), null, null),
((select id from public.habitats where habitat_no = 1), (select id from public.pokemon where name_en = 'Oddish'), null, null),
((select id from public.habitats where habitat_no = 1), (select id from public.pokemon where name_en = 'Geodude'), null, null),
((select id from public.habitats where habitat_no = 2), (select id from public.pokemon where name_en = 'Bellsprout'), null, null),
((select id from public.habitats where habitat_no = 2), (select id from public.pokemon where name_en = 'Scyther'), null, null),
((select id from public.habitats where habitat_no = 2), (select id from public.pokemon where name_en = 'Scizor'), null, null),
((select id from public.habitats where habitat_no = 2), (select id from public.pokemon where name_en = 'Pinsir'), null, null),
((select id from public.habitats where habitat_no = 2), (select id from public.pokemon where name_en = 'Heracross'), null, null),
((select id from public.habitats where habitat_no = 3), (select id from public.pokemon where name_en = 'Timburr'), null, null),
((select id from public.habitats where habitat_no = 3), (select id from public.pokemon where name_en = 'Gurdurr'), null, null),
((select id from public.habitats where habitat_no = 3), (select id from public.pokemon where name_en = 'Machop'), null, null),
((select id from public.habitats where habitat_no = 4), (select id from public.pokemon where name_en = 'Squirtle'), null, null),
((select id from public.habitats where habitat_no = 4), (select id from public.pokemon where name_en = 'Wartortle'), null, null),
((select id from public.habitats where habitat_no = 4), (select id from public.pokemon where name_en = 'Blastoise'), null, null),
((select id from public.habitats where habitat_no = 4), (select id from public.pokemon where name_en = 'Sliggoo'), null, null),
((select id from public.habitats where habitat_no = 4), (select id from public.pokemon where name_en = 'Cramorant'), null, null),
((select id from public.habitats where habitat_no = 5), (select id from public.pokemon where name_en = 'Slowpoke'), null, null),
((select id from public.habitats where habitat_no = 5), (select id from public.pokemon where name_en = 'Slowbro'), null, null),
((select id from public.habitats where habitat_no = 5), (select id from public.pokemon where name_en = 'Slowking'), null, null),
((select id from public.habitats where habitat_no = 6), (select id from public.pokemon where name_en = 'Pidgey'), null, null),
((select id from public.habitats where habitat_no = 6), (select id from public.pokemon where name_en = 'Pidgeotto'), null, null),
((select id from public.habitats where habitat_no = 6), (select id from public.pokemon where name_en = 'Hoothoot'), null, null),
((select id from public.habitats where habitat_no = 6), (select id from public.pokemon where name_en = 'Noctowl'), null, null),
((select id from public.habitats where habitat_no = 7), (select id from public.pokemon where name_en = 'Venonat'), null, null),
((select id from public.habitats where habitat_no = 7), (select id from public.pokemon where name_en = 'Venomoth'), null, null),
((select id from public.habitats where habitat_no = 8), (select id from public.pokemon where name_en = 'Pidgey'), null, null),
((select id from public.habitats where habitat_no = 8), (select id from public.pokemon where name_en = 'Pidgeotto'), null, null),
((select id from public.habitats where habitat_no = 8), (select id from public.pokemon where name_en = 'Hoothoot'), null, null),
((select id from public.habitats where habitat_no = 8), (select id from public.pokemon where name_en = 'Combee'), null, null),
((select id from public.habitats where habitat_no = 8), (select id from public.pokemon where name_en = 'Magby'), null, null),
((select id from public.habitats where habitat_no = 8), (select id from public.pokemon where name_en = 'Eevee'), null, null),
((select id from public.habitats where habitat_no = 9), (select id from public.pokemon where name_en = 'Cacturne'), null, null),
((select id from public.habitats where habitat_no = 9), (select id from public.pokemon where name_en = 'Goomy'), null, null),
((select id from public.habitats where habitat_no = 9), (select id from public.pokemon where name_en = 'Vikavolt'), null, null),
((select id from public.habitats where habitat_no = 10), (select id from public.pokemon where name_en = 'Volbeat'), null, null),
((select id from public.habitats where habitat_no = 10), (select id from public.pokemon where name_en = 'Illumise'), null, null),
((select id from public.habitats where habitat_no = 11), (select id from public.pokemon where name_en = 'Ivysaur'), null, null),
((select id from public.habitats where habitat_no = 11), (select id from public.pokemon where name_en = 'Venusaur'), null, null),
((select id from public.habitats where habitat_no = 11), (select id from public.pokemon where name_en = 'Vespiquen'), null, null),
((select id from public.habitats where habitat_no = 12), (select id from public.pokemon where name_en = 'Paras'), null, null),
((select id from public.habitats where habitat_no = 12), (select id from public.pokemon where name_en = 'Parasect'), null, null),
((select id from public.habitats where habitat_no = 13), (select id from public.pokemon where name_en = 'Cubone'), null, null),
((select id from public.habitats where habitat_no = 13), (select id from public.pokemon where name_en = 'Marowak'), null, null),
((select id from public.habitats where habitat_no = 14), (select id from public.pokemon where name_en = 'Paras'), null, null),
((select id from public.habitats where habitat_no = 14), (select id from public.pokemon where name_en = 'Parasect'), null, null),
((select id from public.habitats where habitat_no = 15), (select id from public.pokemon where name_en = 'Drilbur'), null, null),
((select id from public.habitats where habitat_no = 15), (select id from public.pokemon where name_en = 'Excadrill'), null, null),
((select id from public.habitats where habitat_no = 16), (select id from public.pokemon where name_en = 'Drifloon'), null, null),
((select id from public.habitats where habitat_no = 17), (select id from public.pokemon where name_en = 'Charmeleon'), null, null),
((select id from public.habitats where habitat_no = 18), (select id from public.pokemon where name_en = 'Tyrogue'), null, null),
((select id from public.habitats where habitat_no = 19), (select id from public.pokemon where name_en = 'Gulpin'), null, null),
((select id from public.habitats where habitat_no = 20), (select id from public.pokemon where name_en = 'Pichu'), null, null),
((select id from public.habitats where habitat_no = 20), (select id from public.pokemon where name_en = 'Pikachu'), null, null),
((select id from public.habitats where habitat_no = 21), (select id from public.pokemon where name_en = 'Weepinbell'), null, null),
((select id from public.habitats where habitat_no = 21), (select id from public.pokemon where name_en = 'Victreebel'), null, null),
((select id from public.habitats where habitat_no = 22), (select id from public.pokemon where name_en = 'Bulbasaur'), null, null),
((select id from public.habitats where habitat_no = 22), (select id from public.pokemon where name_en = 'Ivysaur'), null, null),
((select id from public.habitats where habitat_no = 22), (select id from public.pokemon where name_en = 'Tangrowth'), null, null),
((select id from public.habitats where habitat_no = 23), (select id from public.pokemon where name_en = 'Venonat'), null, null),
((select id from public.habitats where habitat_no = 23), (select id from public.pokemon where name_en = 'Venomoth'), null, null),
((select id from public.habitats where habitat_no = 24), (select id from public.pokemon where name_en = 'Hitmonchan'), null, null),
((select id from public.habitats where habitat_no = 25), (select id from public.pokemon where name_en = 'Hitmonlee'), null, null),
((select id from public.habitats where habitat_no = 26), (select id from public.pokemon where name_en = 'Hitmontop'), null, null),
((select id from public.habitats where habitat_no = 27), (select id from public.pokemon where name_en = 'West Sea Shellos'), null, null),
((select id from public.habitats where habitat_no = 27), (select id from public.pokemon where name_en = 'East Sea Shellos'), null, null),
((select id from public.habitats where habitat_no = 28), (select id from public.pokemon where name_en = 'Gurdurr'), null, null),
((select id from public.habitats where habitat_no = 28), (select id from public.pokemon where name_en = 'Tinkatink'), null, null),
((select id from public.habitats where habitat_no = 28), (select id from public.pokemon where name_en = 'Tinkatuff'), null, null),
((select id from public.habitats where habitat_no = 29), (select id from public.pokemon where name_en = 'Axew'), null, null),
((select id from public.habitats where habitat_no = 29), (select id from public.pokemon where name_en = 'Fraxure'), null, null),
((select id from public.habitats where habitat_no = 29), (select id from public.pokemon where name_en = 'Haxorus'), null, null),
((select id from public.habitats where habitat_no = 30), (select id from public.pokemon where name_en = 'Slowbro'), null, null),
((select id from public.habitats where habitat_no = 30), (select id from public.pokemon where name_en = 'Slowking'), null, null),
((select id from public.habitats where habitat_no = 30), (select id from public.pokemon where name_en = 'Drifloon'), null, null),
((select id from public.habitats where habitat_no = 30), (select id from public.pokemon where name_en = 'Munchlax'), null, null),
((select id from public.habitats where habitat_no = 31), (select id from public.pokemon where name_en = 'Hoothoot'), null, null),
((select id from public.habitats where habitat_no = 31), (select id from public.pokemon where name_en = 'Noctowl'), null, null),
((select id from public.habitats where habitat_no = 32), (select id from public.pokemon where name_en = 'Litwick'), null, null),
((select id from public.habitats where habitat_no = 32), (select id from public.pokemon where name_en = 'Lampent'), null, null),
((select id from public.habitats where habitat_no = 33), (select id from public.pokemon where name_en = 'Litwick'), null, null),
((select id from public.habitats where habitat_no = 33), (select id from public.pokemon where name_en = 'Lampent'), null, null),
((select id from public.habitats where habitat_no = 33), (select id from public.pokemon where name_en = 'Chandelure'), null, null),
((select id from public.habitats where habitat_no = 34), (select id from public.pokemon where name_en = 'Vileplume'), null, null),
((select id from public.habitats where habitat_no = 34), (select id from public.pokemon where name_en = 'Bellossom'), null, null),
((select id from public.habitats where habitat_no = 35), (select id from public.pokemon where name_en = 'Weepinbell'), null, null),
((select id from public.habitats where habitat_no = 35), (select id from public.pokemon where name_en = 'Victreebel'), null, null),
((select id from public.habitats where habitat_no = 36), (select id from public.pokemon where name_en = 'Blastoise'), null, null),
((select id from public.habitats where habitat_no = 37), (select id from public.pokemon where name_en = 'Onix'), null, null),
((select id from public.habitats where habitat_no = 38), (select id from public.pokemon where name_en = 'Magnemite'), null, null),
((select id from public.habitats where habitat_no = 39), (select id from public.pokemon where name_en = 'Pidgeot'), null, null),
((select id from public.habitats where habitat_no = 40), (select id from public.pokemon where name_en = 'Charizard'), null, null),
((select id from public.habitats where habitat_no = 41), (select id from public.pokemon where name_en = 'Goomy'), null, null),
((select id from public.habitats where habitat_no = 42), (select id from public.pokemon where name_en = 'Cacnea'), null, null),
((select id from public.habitats where habitat_no = 43), (select id from public.pokemon where name_en = 'Tangrowth (Professor Tangrowth)'), null, null),
((select id from public.habitats where habitat_no = 44), (select id from public.pokemon where name_en = 'Axew'), null, null),
((select id from public.habitats where habitat_no = 44), (select id from public.pokemon where name_en = 'Fraxure'), null, null),
((select id from public.habitats where habitat_no = 44), (select id from public.pokemon where name_en = 'Haxorus'), null, null),
((select id from public.habitats where habitat_no = 45), (select id from public.pokemon where name_en = 'Goodra'), null, null),
((select id from public.habitats where habitat_no = 46), (select id from public.pokemon where name_en = 'Venusaur'), null, null),
((select id from public.habitats where habitat_no = 47), (select id from public.pokemon where name_en = 'Munchlax'), null, null),
((select id from public.habitats where habitat_no = 47), (select id from public.pokemon where name_en = 'Snorlax'), null, null),
((select id from public.habitats where habitat_no = 48), (select id from public.pokemon where name_en = 'Weezing'), null, null),
((select id from public.habitats where habitat_no = 48), (select id from public.pokemon where name_en = 'Snorlax'), null, null),
((select id from public.habitats where habitat_no = 49), (select id from public.pokemon where name_en = 'Tangela'), null, null),
((select id from public.habitats where habitat_no = 50), (select id from public.pokemon where name_en = 'Spinarak'), null, null),
((select id from public.habitats where habitat_no = 50), (select id from public.pokemon where name_en = 'Ariados'), null, null),
((select id from public.habitats where habitat_no = 50), (select id from public.pokemon where name_en = 'Grubbin'), null, null),
((select id from public.habitats where habitat_no = 51), (select id from public.pokemon where name_en = 'Zubat'), null, null),
((select id from public.habitats where habitat_no = 51), (select id from public.pokemon where name_en = 'Golbat'), null, null),
((select id from public.habitats where habitat_no = 51), (select id from public.pokemon where name_en = 'Makuhita'), null, null),
((select id from public.habitats where habitat_no = 51), (select id from public.pokemon where name_en = 'Hariyama'), null, null),
((select id from public.habitats where habitat_no = 52), (select id from public.pokemon where name_en = 'Crobat'), null, null),
((select id from public.habitats where habitat_no = 52), (select id from public.pokemon where name_en = 'Wingull'), null, null),
((select id from public.habitats where habitat_no = 52), (select id from public.pokemon where name_en = 'Pelipper'), null, null),
((select id from public.habitats where habitat_no = 53), (select id from public.pokemon where name_en = 'Azurill'), null, null),
((select id from public.habitats where habitat_no = 53), (select id from public.pokemon where name_en = 'Marill'), null, null),
((select id from public.habitats where habitat_no = 53), (select id from public.pokemon where name_en = 'Piplup'), null, null),
((select id from public.habitats where habitat_no = 53), (select id from public.pokemon where name_en = 'Prinplup'), null, null),
((select id from public.habitats where habitat_no = 54), (select id from public.pokemon where name_en = 'Paldean Wooper'), null, null),
((select id from public.habitats where habitat_no = 54), (select id from public.pokemon where name_en = 'Clodsire'), null, null),
((select id from public.habitats where habitat_no = 55), (select id from public.pokemon where name_en = 'Mareep'), null, null),
((select id from public.habitats where habitat_no = 56), (select id from public.pokemon where name_en = 'Zorua'), null, null),
((select id from public.habitats where habitat_no = 56), (select id from public.pokemon where name_en = 'Zoroark'), null, null),
((select id from public.habitats where habitat_no = 56), (select id from public.pokemon where name_en = 'Pawmi'), null, null),
((select id from public.habitats where habitat_no = 57), (select id from public.pokemon where name_en = 'Gloom'), null, null),
((select id from public.habitats where habitat_no = 57), (select id from public.pokemon where name_en = 'Exeggcute'), null, null),
((select id from public.habitats where habitat_no = 57), (select id from public.pokemon where name_en = 'Exeggutor'), null, null),
((select id from public.habitats where habitat_no = 58), (select id from public.pokemon where name_en = 'Wingull'), null, null),
((select id from public.habitats where habitat_no = 58), (select id from public.pokemon where name_en = 'Pelipper'), null, null),
((select id from public.habitats where habitat_no = 59), (select id from public.pokemon where name_en = 'Exeggcute'), null, null),
((select id from public.habitats where habitat_no = 59), (select id from public.pokemon where name_en = 'Exeggutor'), null, null),
((select id from public.habitats where habitat_no = 60), (select id from public.pokemon where name_en = 'Lapras'), null, null),
((select id from public.habitats where habitat_no = 61), (select id from public.pokemon where name_en = 'Meowth'), null, null),
((select id from public.habitats where habitat_no = 62), (select id from public.pokemon where name_en = 'Growlithe'), null, null),
((select id from public.habitats where habitat_no = 62), (select id from public.pokemon where name_en = 'Azurill'), null, null),
((select id from public.habitats where habitat_no = 63), (select id from public.pokemon where name_en = 'Koffing'), null, null),
((select id from public.habitats where habitat_no = 63), (select id from public.pokemon where name_en = 'Weezing'), null, null),
((select id from public.habitats where habitat_no = 63), (select id from public.pokemon where name_en = 'Trubbish'), null, null),
((select id from public.habitats where habitat_no = 63), (select id from public.pokemon where name_en = 'Garbodor'), null, null),
((select id from public.habitats where habitat_no = 64), (select id from public.pokemon where name_en = 'Magneton'), null, null),
((select id from public.habitats where habitat_no = 64), (select id from public.pokemon where name_en = 'Magnezone'), null, null),
((select id from public.habitats where habitat_no = 64), (select id from public.pokemon where name_en = 'Electabuzz'), null, null),
((select id from public.habitats where habitat_no = 65), (select id from public.pokemon where name_en = 'Crobat'), null, null),
((select id from public.habitats where habitat_no = 66), (select id from public.pokemon where name_en = 'Zubat'), null, null),
((select id from public.habitats where habitat_no = 66), (select id from public.pokemon where name_en = 'Voltorb'), null, null),
((select id from public.habitats where habitat_no = 66), (select id from public.pokemon where name_en = 'Electrode'), null, null),
((select id from public.habitats where habitat_no = 67), (select id from public.pokemon where name_en = 'Pawmi'), null, null),
((select id from public.habitats where habitat_no = 67), (select id from public.pokemon where name_en = 'Pawmo'), null, null),
((select id from public.habitats where habitat_no = 68), (select id from public.pokemon where name_en = 'Empoleon'), null, null),
((select id from public.habitats where habitat_no = 69), (select id from public.pokemon where name_en = 'Torchic'), null, null),
((select id from public.habitats where habitat_no = 69), (select id from public.pokemon where name_en = 'Blaziken'), null, null),
((select id from public.habitats where habitat_no = 70), (select id from public.pokemon where name_en = 'Pawmi'), null, null),
((select id from public.habitats where habitat_no = 70), (select id from public.pokemon where name_en = 'Pawmo'), null, null),
((select id from public.habitats where habitat_no = 71), (select id from public.pokemon where name_en = 'Curly Form Tatsugiri'), null, null),
((select id from public.habitats where habitat_no = 71), (select id from public.pokemon where name_en = 'Droopy Form Tatsugiri'), null, null),
((select id from public.habitats where habitat_no = 71), (select id from public.pokemon where name_en = 'Stretchy Form Tatsugiri'), null, null),
((select id from public.habitats where habitat_no = 72), (select id from public.pokemon where name_en = 'Electabuzz'), null, null),
((select id from public.habitats where habitat_no = 73), (select id from public.pokemon where name_en = 'Haunter'), null, null),
((select id from public.habitats where habitat_no = 73), (select id from public.pokemon where name_en = 'Gengar'), null, null),
((select id from public.habitats where habitat_no = 73), (select id from public.pokemon where name_en = 'Zoroark'), null, null),
((select id from public.habitats where habitat_no = 74), (select id from public.pokemon where name_en = 'Flaaffy'), null, null),
((select id from public.habitats where habitat_no = 75), (select id from public.pokemon where name_en = 'Minccino'), null, null),
((select id from public.habitats where habitat_no = 76), (select id from public.pokemon where name_en = 'Minccino'), null, null),
((select id from public.habitats where habitat_no = 76), (select id from public.pokemon where name_en = 'Cinccino'), null, null),
((select id from public.habitats where habitat_no = 77), (select id from public.pokemon where name_en = 'Mareep'), null, null),
((select id from public.habitats where habitat_no = 77), (select id from public.pokemon where name_en = 'Flaaffy'), null, null),
((select id from public.habitats where habitat_no = 78), (select id from public.pokemon where name_en = 'Psyduck'), null, null),
((select id from public.habitats where habitat_no = 78), (select id from public.pokemon where name_en = 'Golduck'), null, null),
((select id from public.habitats where habitat_no = 79), (select id from public.pokemon where name_en = 'Growlithe'), null, null),
((select id from public.habitats where habitat_no = 79), (select id from public.pokemon where name_en = 'Torchic'), null, null),
((select id from public.habitats where habitat_no = 79), (select id from public.pokemon where name_en = 'Combusken'), null, null),
((select id from public.habitats where habitat_no = 80), (select id from public.pokemon where name_en = 'Farfetch'), null, null),
((select id from public.habitats where habitat_no = 80), (select id from public.pokemon where name_en = 'Makuhita'), null, null),
((select id from public.habitats where habitat_no = 80), (select id from public.pokemon where name_en = 'Hariyama'), null, null),
((select id from public.habitats where habitat_no = 81), (select id from public.pokemon where name_en = 'Pikachu (Peakychu)'), null, null),
((select id from public.habitats where habitat_no = 81), (select id from public.pokemon where name_en = 'Chansey'), null, null),
((select id from public.habitats where habitat_no = 82), (select id from public.pokemon where name_en = 'Happiny'), null, null),
((select id from public.habitats where habitat_no = 83), (select id from public.pokemon where name_en = 'Grubbin'), null, null),
((select id from public.habitats where habitat_no = 83), (select id from public.pokemon where name_en = 'Charjabug'), null, null),
((select id from public.habitats where habitat_no = 84), (select id from public.pokemon where name_en = 'Elekid'), null, null),
((select id from public.habitats where habitat_no = 84), (select id from public.pokemon where name_en = 'Electivire'), null, null),
((select id from public.habitats where habitat_no = 85), (select id from public.pokemon where name_en = 'Magneton'), null, null),
((select id from public.habitats where habitat_no = 85), (select id from public.pokemon where name_en = 'Magnezone'), null, null),
((select id from public.habitats where habitat_no = 86), (select id from public.pokemon where name_en = 'Prinplup'), null, null),
((select id from public.habitats where habitat_no = 86), (select id from public.pokemon where name_en = 'Empoleon'), null, null),
((select id from public.habitats where habitat_no = 87), (select id from public.pokemon where name_en = 'Combusken'), null, null),
((select id from public.habitats where habitat_no = 87), (select id from public.pokemon where name_en = 'Blaziken'), null, null),
((select id from public.habitats where habitat_no = 88), (select id from public.pokemon where name_en = 'Marill'), null, null),
((select id from public.habitats where habitat_no = 88), (select id from public.pokemon where name_en = 'Azumarill'), null, null),
((select id from public.habitats where habitat_no = 89), (select id from public.pokemon where name_en = 'Gastly'), null, null),
((select id from public.habitats where habitat_no = 89), (select id from public.pokemon where name_en = 'Haunter'), null, null),
((select id from public.habitats where habitat_no = 90), (select id from public.pokemon where name_en = 'Voltorb'), null, null),
((select id from public.habitats where habitat_no = 90), (select id from public.pokemon where name_en = 'Electrode'), null, null),
((select id from public.habitats where habitat_no = 91), (select id from public.pokemon where name_en = 'Meowth'), null, null),
((select id from public.habitats where habitat_no = 91), (select id from public.pokemon where name_en = 'Happiny'), null, null),
((select id from public.habitats where habitat_no = 91), (select id from public.pokemon where name_en = 'Audino'), null, null),
((select id from public.habitats where habitat_no = 91), (select id from public.pokemon where name_en = 'Mawile'), null, null),
((select id from public.habitats where habitat_no = 92), (select id from public.pokemon where name_en = 'Smeargle (Smearguru)'), null, null),
((select id from public.habitats where habitat_no = 93), (select id from public.pokemon where name_en = 'Snorlax (Mosslax)'), null, null),
((select id from public.habitats where habitat_no = 94), (select id from public.pokemon where name_en = 'Mimikyu'), null, null),
((select id from public.habitats where habitat_no = 95), (select id from public.pokemon where name_en = 'Blissey'), null, null),
((select id from public.habitats where habitat_no = 96), (select id from public.pokemon where name_en = 'Absol'), null, null),
((select id from public.habitats where habitat_no = 97), (select id from public.pokemon where name_en = 'Ampharos'), null, null),
((select id from public.habitats where habitat_no = 98), (select id from public.pokemon where name_en = 'Kricketot'), null, null),
((select id from public.habitats where habitat_no = 98), (select id from public.pokemon where name_en = 'Kricketune'), null, null),
((select id from public.habitats where habitat_no = 98), (select id from public.pokemon where name_en = 'Riolu'), null, null),
((select id from public.habitats where habitat_no = 98), (select id from public.pokemon where name_en = 'Scorbunny'), null, null),
((select id from public.habitats where habitat_no = 98), (select id from public.pokemon where name_en = 'Cinderace'), null, null),
((select id from public.habitats where habitat_no = 99), (select id from public.pokemon where name_en = 'Diglett'), null, null),
((select id from public.habitats where habitat_no = 99), (select id from public.pokemon where name_en = 'Dugtrio'), null, null),
((select id from public.habitats where habitat_no = 99), (select id from public.pokemon where name_en = 'Bonsly'), null, null),
((select id from public.habitats where habitat_no = 99), (select id from public.pokemon where name_en = 'Sudowoodo'), null, null),
((select id from public.habitats where habitat_no = 100), (select id from public.pokemon where name_en = 'Dartrix'), null, null),
((select id from public.habitats where habitat_no = 100), (select id from public.pokemon where name_en = 'Decidueye'), null, null),
((select id from public.habitats where habitat_no = 101), (select id from public.pokemon where name_en = 'Lotad'), null, null),
((select id from public.habitats where habitat_no = 101), (select id from public.pokemon where name_en = 'Lombre'), null, null),
((select id from public.habitats where habitat_no = 102), (select id from public.pokemon where name_en = 'Murkrow'), null, null),
((select id from public.habitats where habitat_no = 102), (select id from public.pokemon where name_en = 'Honchkrow'), null, null),
((select id from public.habitats where habitat_no = 102), (select id from public.pokemon where name_en = 'Chatot'), null, null),
((select id from public.habitats where habitat_no = 103), (select id from public.pokemon where name_en = 'Machoke'), null, null),
((select id from public.habitats where habitat_no = 103), (select id from public.pokemon where name_en = 'Machamp'), null, null),
((select id from public.habitats where habitat_no = 104), (select id from public.pokemon where name_en = 'Cleffa'), null, null),
((select id from public.habitats where habitat_no = 104), (select id from public.pokemon where name_en = 'Clefairy'), null, null),
((select id from public.habitats where habitat_no = 104), (select id from public.pokemon where name_en = 'Clefable'), null, null),
((select id from public.habitats where habitat_no = 104), (select id from public.pokemon where name_en = 'Fidough'), null, null),
((select id from public.habitats where habitat_no = 104), (select id from public.pokemon where name_en = 'Dachsbun'), null, null),
((select id from public.habitats where habitat_no = 105), (select id from public.pokemon where name_en = 'Murkrow'), null, null),
((select id from public.habitats where habitat_no = 105), (select id from public.pokemon where name_en = 'Larvesta'), null, null),
((select id from public.habitats where habitat_no = 105), (select id from public.pokemon where name_en = 'Volcarona'), null, null),
((select id from public.habitats where habitat_no = 106), (select id from public.pokemon where name_en = 'Ekans'), null, null),
((select id from public.habitats where habitat_no = 106), (select id from public.pokemon where name_en = 'Arbok'), null, null),
((select id from public.habitats where habitat_no = 106), (select id from public.pokemon where name_en = 'Politoed'), null, null),
((select id from public.habitats where habitat_no = 107), (select id from public.pokemon where name_en = 'Igglybuff'), null, null),
((select id from public.habitats where habitat_no = 107), (select id from public.pokemon where name_en = 'Jigglypuff'), null, null),
((select id from public.habitats where habitat_no = 107), (select id from public.pokemon where name_en = 'Politoed'), null, null),
((select id from public.habitats where habitat_no = 108), (select id from public.pokemon where name_en = 'Tyranitar'), null, null),
((select id from public.habitats where habitat_no = 109), (select id from public.pokemon where name_en = 'Lotad'), null, null),
((select id from public.habitats where habitat_no = 109), (select id from public.pokemon where name_en = 'Ludicolo'), null, null),
((select id from public.habitats where habitat_no = 110), (select id from public.pokemon where name_en = 'Larvitar'), null, null),
((select id from public.habitats where habitat_no = 110), (select id from public.pokemon where name_en = 'Tyranitar'), null, null),
((select id from public.habitats where habitat_no = 111), (select id from public.pokemon where name_en = 'Graveler'), null, null),
((select id from public.habitats where habitat_no = 111), (select id from public.pokemon where name_en = 'Golem'), null, null),
((select id from public.habitats where habitat_no = 112), (select id from public.pokemon where name_en = 'Torkoal'), null, null),
((select id from public.habitats where habitat_no = 113), (select id from public.pokemon where name_en = 'Raboot'), null, null),
((select id from public.habitats where habitat_no = 114), (select id from public.pokemon where name_en = 'Politoed'), null, null),
((select id from public.habitats where habitat_no = 115), (select id from public.pokemon where name_en = 'Volcarona'), null, null),
((select id from public.habitats where habitat_no = 115), (select id from public.pokemon where name_en = 'Charcadet'), null, null),
((select id from public.habitats where habitat_no = 116), (select id from public.pokemon where name_en = 'Magmar'), null, null),
((select id from public.habitats where habitat_no = 117), (select id from public.pokemon where name_en = 'Steelix'), null, null),
((select id from public.habitats where habitat_no = 117), (select id from public.pokemon where name_en = 'Machamp'), null, null),
((select id from public.habitats where habitat_no = 118), (select id from public.pokemon where name_en = 'Glimmet'), null, null),
((select id from public.habitats where habitat_no = 118), (select id from public.pokemon where name_en = 'Glimmora'), null, null),
((select id from public.habitats where habitat_no = 119), (select id from public.pokemon where name_en = 'Diglett'), null, null),
((select id from public.habitats where habitat_no = 119), (select id from public.pokemon where name_en = 'Glimmet'), null, null),
((select id from public.habitats where habitat_no = 119), (select id from public.pokemon where name_en = 'Glimmora'), null, null),
((select id from public.habitats where habitat_no = 120), (select id from public.pokemon where name_en = 'Swalot'), null, null),
((select id from public.habitats where habitat_no = 121), (select id from public.pokemon where name_en = 'Fidough'), null, null),
((select id from public.habitats where habitat_no = 121), (select id from public.pokemon where name_en = 'Dachsbun'), null, null),
((select id from public.habitats where habitat_no = 122), (select id from public.pokemon where name_en = 'Magmortar'), null, null),
((select id from public.habitats where habitat_no = 123), (select id from public.pokemon where name_en = 'Dugtrio'), null, null),
((select id from public.habitats where habitat_no = 123), (select id from public.pokemon where name_en = 'Sudowoodo'), null, null),
((select id from public.habitats where habitat_no = 124), (select id from public.pokemon where name_en = 'Toxel'), null, null),
((select id from public.habitats where habitat_no = 125), (select id from public.pokemon where name_en = 'Honchkrow'), null, null),
((select id from public.habitats where habitat_no = 125), (select id from public.pokemon where name_en = 'Chatot'), null, null),
((select id from public.habitats where habitat_no = 126), (select id from public.pokemon where name_en = 'Jigglypuff'), null, null),
((select id from public.habitats where habitat_no = 126), (select id from public.pokemon where name_en = 'Wigglytuff'), null, null),
((select id from public.habitats where habitat_no = 127), (select id from public.pokemon where name_en = 'Machoke'), null, null),
((select id from public.habitats where habitat_no = 127), (select id from public.pokemon where name_en = 'Riolu'), null, null),
((select id from public.habitats where habitat_no = 127), (select id from public.pokemon where name_en = 'Lucario'), null, null),
((select id from public.habitats where habitat_no = 128), (select id from public.pokemon where name_en = 'Kricketot'), null, null),
((select id from public.habitats where habitat_no = 128), (select id from public.pokemon where name_en = 'Kricketune'), null, null),
((select id from public.habitats where habitat_no = 128), (select id from public.pokemon where name_en = 'Rotom (DJ Rotom)'), null, null),
((select id from public.habitats where habitat_no = 129), (select id from public.pokemon where name_en = 'Arcanine'), null, null),
((select id from public.habitats where habitat_no = 130), (select id from public.pokemon where name_en = 'Raboot'), null, null),
((select id from public.habitats where habitat_no = 130), (select id from public.pokemon where name_en = 'Cinderace'), null, null),
((select id from public.habitats where habitat_no = 131), (select id from public.pokemon where name_en = 'Clefairy'), null, null),
((select id from public.habitats where habitat_no = 131), (select id from public.pokemon where name_en = 'Clefable'), null, null),
((select id from public.habitats where habitat_no = 132), (select id from public.pokemon where name_en = 'Rolycoly'), null, null),
((select id from public.habitats where habitat_no = 132), (select id from public.pokemon where name_en = 'Carkol'), null, null),
((select id from public.habitats where habitat_no = 132), (select id from public.pokemon where name_en = 'Coalossal'), null, null),
((select id from public.habitats where habitat_no = 133), (select id from public.pokemon where name_en = 'Greedent (Chef Dente)'), null, null),
((select id from public.habitats where habitat_no = 134), (select id from public.pokemon where name_en = 'Gholdengo'), null, null),
((select id from public.habitats where habitat_no = 135), (select id from public.pokemon where name_en = 'Coalossal'), null, null),
((select id from public.habitats where habitat_no = 136), (select id from public.pokemon where name_en = 'Decidueye'), null, null),
((select id from public.habitats where habitat_no = 137), (select id from public.pokemon where name_en = 'Trapinch'), null, null),
((select id from public.habitats where habitat_no = 137), (select id from public.pokemon where name_en = 'Vibrava'), null, null),
((select id from public.habitats where habitat_no = 137), (select id from public.pokemon where name_en = 'Flygon'), null, null),
((select id from public.habitats where habitat_no = 137), (select id from public.pokemon where name_en = 'Swablu'), null, null),
((select id from public.habitats where habitat_no = 137), (select id from public.pokemon where name_en = 'Duskull'), null, null),
((select id from public.habitats where habitat_no = 138), (select id from public.pokemon where name_en = 'Pupitar'), null, null),
((select id from public.habitats where habitat_no = 138), (select id from public.pokemon where name_en = 'Dreepy'), null, null),
((select id from public.habitats where habitat_no = 138), (select id from public.pokemon where name_en = 'Drakloak'), null, null),
((select id from public.habitats where habitat_no = 138), (select id from public.pokemon where name_en = 'Sprigatito'), null, null),
((select id from public.habitats where habitat_no = 139), (select id from public.pokemon where name_en = 'Froakie'), null, null),
((select id from public.habitats where habitat_no = 139), (select id from public.pokemon where name_en = 'Frogadier'), null, null),
((select id from public.habitats where habitat_no = 139), (select id from public.pokemon where name_en = 'Greninja'), null, null),
((select id from public.habitats where habitat_no = 140), (select id from public.pokemon where name_en = 'Corvisquire'), null, null),
((select id from public.habitats where habitat_no = 140), (select id from public.pokemon where name_en = 'Corviknight'), null, null),
((select id from public.habitats where habitat_no = 140), (select id from public.pokemon where name_en = 'Wattrel'), null, null),
((select id from public.habitats where habitat_no = 140), (select id from public.pokemon where name_en = 'Kilowattrel'), null, null),
((select id from public.habitats where habitat_no = 141), (select id from public.pokemon where name_en = 'Cyndaquil'), null, null),
((select id from public.habitats where habitat_no = 141), (select id from public.pokemon where name_en = 'Quilava'), null, null),
((select id from public.habitats where habitat_no = 142), (select id from public.pokemon where name_en = 'Vulpix'), null, null),
((select id from public.habitats where habitat_no = 142), (select id from public.pokemon where name_en = 'Ninetales'), null, null),
((select id from public.habitats where habitat_no = 142), (select id from public.pokemon where name_en = 'Misdreavus'), null, null),
((select id from public.habitats where habitat_no = 142), (select id from public.pokemon where name_en = 'Mismagius'), null, null),
((select id from public.habitats where habitat_no = 142), (select id from public.pokemon where name_en = 'Rookidee'), null, null),
((select id from public.habitats where habitat_no = 143), (select id from public.pokemon where name_en = 'Girafarig'), null, null),
((select id from public.habitats where habitat_no = 143), (select id from public.pokemon where name_en = 'Farigiraf'), null, null),
((select id from public.habitats where habitat_no = 143), (select id from public.pokemon where name_en = 'Servine'), null, null),
((select id from public.habitats where habitat_no = 143), (select id from public.pokemon where name_en = 'Serperior'), null, null),
((select id from public.habitats where habitat_no = 144), (select id from public.pokemon where name_en = 'Poliwhirl'), null, null),
((select id from public.habitats where habitat_no = 144), (select id from public.pokemon where name_en = 'Dratini'), null, null),
((select id from public.habitats where habitat_no = 144), (select id from public.pokemon where name_en = 'Dragonair'), null, null),
((select id from public.habitats where habitat_no = 145), (select id from public.pokemon where name_en = 'Dragonite'), null, null),
((select id from public.habitats where habitat_no = 146), (select id from public.pokemon where name_en = 'Gyarados'), null, null),
((select id from public.habitats where habitat_no = 147), (select id from public.pokemon where name_en = 'Altaria'), null, null),
((select id from public.habitats where habitat_no = 148), (select id from public.pokemon where name_en = 'Dratini'), null, null),
((select id from public.habitats where habitat_no = 148), (select id from public.pokemon where name_en = 'Dragonair'), null, null),
((select id from public.habitats where habitat_no = 149), (select id from public.pokemon where name_en = 'Beldum'), null, null),
((select id from public.habitats where habitat_no = 150), (select id from public.pokemon where name_en = 'Quilava'), null, null),
((select id from public.habitats where habitat_no = 150), (select id from public.pokemon where name_en = 'Typhlosion'), null, null),
((select id from public.habitats where habitat_no = 151), (select id from public.pokemon where name_en = 'Abra'), null, null),
((select id from public.habitats where habitat_no = 151), (select id from public.pokemon where name_en = 'Alakazam'), null, null),
((select id from public.habitats where habitat_no = 152), (select id from public.pokemon where name_en = 'Abra'), null, null),
((select id from public.habitats where habitat_no = 152), (select id from public.pokemon where name_en = 'Kadabra'), null, null),
((select id from public.habitats where habitat_no = 153), (select id from public.pokemon where name_en = 'Dusclops'), null, null),
((select id from public.habitats where habitat_no = 153), (select id from public.pokemon where name_en = 'Dusknoir'), null, null),
((select id from public.habitats where habitat_no = 154), (select id from public.pokemon where name_en = 'Tinkatink'), null, null),
((select id from public.habitats where habitat_no = 154), (select id from public.pokemon where name_en = 'Tinkaton (Tinkmaster)'), null, null),
((select id from public.habitats where habitat_no = 155), (select id from public.pokemon where name_en = 'Sprigatito'), null, null),
((select id from public.habitats where habitat_no = 155), (select id from public.pokemon where name_en = 'Floragato'), null, null),
((select id from public.habitats where habitat_no = 156), (select id from public.pokemon where name_en = 'Poliwrath'), null, null),
((select id from public.habitats where habitat_no = 156), (select id from public.pokemon where name_en = 'Corviknight'), null, null),
((select id from public.habitats where habitat_no = 156), (select id from public.pokemon where name_en = 'Tinkatuff'), null, null),
((select id from public.habitats where habitat_no = 157), (select id from public.pokemon where name_en = 'Mime Jr.'), null, null),
((select id from public.habitats where habitat_no = 157), (select id from public.pokemon where name_en = 'Mr. Mime'), null, null),
((select id from public.habitats where habitat_no = 158), (select id from public.pokemon where name_en = 'Mismagius'), null, null),
((select id from public.habitats where habitat_no = 159), (select id from public.pokemon where name_en = 'Ralts'), null, null),
((select id from public.habitats where habitat_no = 159), (select id from public.pokemon where name_en = 'Kirlia'), null, null),
((select id from public.habitats where habitat_no = 160), (select id from public.pokemon where name_en = 'Noibat'), null, null),
((select id from public.habitats where habitat_no = 160), (select id from public.pokemon where name_en = 'Noivern'), null, null),
((select id from public.habitats where habitat_no = 161), (select id from public.pokemon where name_en = 'Poliwag'), null, null),
((select id from public.habitats where habitat_no = 162), (select id from public.pokemon where name_en = 'Kirlia'), null, null),
((select id from public.habitats where habitat_no = 162), (select id from public.pokemon where name_en = 'Gardevoir'), null, null),
((select id from public.habitats where habitat_no = 163), (select id from public.pokemon where name_en = 'Gardevoir'), null, null),
((select id from public.habitats where habitat_no = 164), (select id from public.pokemon where name_en = 'Porygon-Z'), null, null),
((select id from public.habitats where habitat_no = 165), (select id from public.pokemon where name_en = 'Snivy'), null, null),
((select id from public.habitats where habitat_no = 166), (select id from public.pokemon where name_en = 'Porygon2'), null, null),
((select id from public.habitats where habitat_no = 167), (select id from public.pokemon where name_en = 'Misdreavus'), null, null),
((select id from public.habitats where habitat_no = 167), (select id from public.pokemon where name_en = 'Mismagius'), null, null),
((select id from public.habitats where habitat_no = 167), (select id from public.pokemon where name_en = 'Drakloak'), null, null),
((select id from public.habitats where habitat_no = 167), (select id from public.pokemon where name_en = 'Dragapult'), null, null),
((select id from public.habitats where habitat_no = 168), (select id from public.pokemon where name_en = 'Alakazam'), null, null),
((select id from public.habitats where habitat_no = 169), (select id from public.pokemon where name_en = 'Metang'), null, null),
((select id from public.habitats where habitat_no = 170), (select id from public.pokemon where name_en = 'Porygon'), null, null),
((select id from public.habitats where habitat_no = 171), (select id from public.pokemon where name_en = 'Mime Jr.'), null, null),
((select id from public.habitats where habitat_no = 171), (select id from public.pokemon where name_en = 'Serperior'), null, null),
((select id from public.habitats where habitat_no = 172), (select id from public.pokemon where name_en = 'Meowscarada'), null, null),
((select id from public.habitats where habitat_no = 173), (select id from public.pokemon where name_en = 'Greninja'), null, null),
((select id from public.habitats where habitat_no = 174), (select id from public.pokemon where name_en = 'Plusle'), null, null),
((select id from public.habitats where habitat_no = 174), (select id from public.pokemon where name_en = 'Minun'), null, null),
((select id from public.habitats where habitat_no = 175), (select id from public.pokemon where name_en = 'Dedenne'), null, null),
((select id from public.habitats where habitat_no = 176), (select id from public.pokemon where name_en = 'Raichu'), null, null),
((select id from public.habitats where habitat_no = 177), (select id from public.pokemon where name_en = 'Conkeldurr'), null, null),
((select id from public.habitats where habitat_no = 178), (select id from public.pokemon where name_en = 'Poliwrath'), null, null),
((select id from public.habitats where habitat_no = 178), (select id from public.pokemon where name_en = 'Gallade'), null, null),
((select id from public.habitats where habitat_no = 179), (select id from public.pokemon where name_en = 'Persian'), null, null),
((select id from public.habitats where habitat_no = 180), (select id from public.pokemon where name_en = 'Ninetales'), null, null),
((select id from public.habitats where habitat_no = 181), (select id from public.pokemon where name_en = 'Drifloon'), null, null),
((select id from public.habitats where habitat_no = 181), (select id from public.pokemon where name_en = 'Drifblim'), null, null),
((select id from public.habitats where habitat_no = 182), (select id from public.pokemon where name_en = 'Metagross'), null, null),
((select id from public.habitats where habitat_no = 183), (select id from public.pokemon where name_en = 'Typhlosion'), null, null),
((select id from public.habitats where habitat_no = 184), (select id from public.pokemon where name_en = 'Slowbro'), null, null),
((select id from public.habitats where habitat_no = 184), (select id from public.pokemon where name_en = 'Slowking'), null, null),
((select id from public.habitats where habitat_no = 185), (select id from public.pokemon where name_en = 'Magikarp'), null, null),
((select id from public.habitats where habitat_no = 185), (select id from public.pokemon where name_en = 'West Sea Gastrodon'), null, null),
((select id from public.habitats where habitat_no = 185), (select id from public.pokemon where name_en = 'East Sea Gastrodon'), null, null),
((select id from public.habitats where habitat_no = 186), (select id from public.pokemon where name_en = 'Grimer'), null, null),
((select id from public.habitats where habitat_no = 186), (select id from public.pokemon where name_en = 'Muk'), null, null),
((select id from public.habitats where habitat_no = 186), (select id from public.pokemon where name_en = 'Clodsire'), null, null),
((select id from public.habitats where habitat_no = 187), (select id from public.pokemon where name_en = 'Lotad'), null, null),
((select id from public.habitats where habitat_no = 187), (select id from public.pokemon where name_en = 'Lombre'), null, null),
((select id from public.habitats where habitat_no = 188), (select id from public.pokemon where name_en = 'Arcanine'), null, null),
((select id from public.habitats where habitat_no = 189), (select id from public.pokemon where name_en = 'Amped Form Toxtricity'), null, null),
((select id from public.habitats where habitat_no = 190), (select id from public.pokemon where name_en = 'Low Key Form Toxtricity'), null, null),
((select id from public.habitats where habitat_no = 191), (select id from public.pokemon where name_en = 'Ceruledge'), null, null),
((select id from public.habitats where habitat_no = 192), (select id from public.pokemon where name_en = 'Armarouge'), null, null),
((select id from public.habitats where habitat_no = 193), (select id from public.pokemon where name_en = 'Aerodactyl'), null, null),
((select id from public.habitats where habitat_no = 194), (select id from public.pokemon where name_en = 'Cranidos'), null, null),
((select id from public.habitats where habitat_no = 195), (select id from public.pokemon where name_en = 'Rampardos'), null, null),
((select id from public.habitats where habitat_no = 196), (select id from public.pokemon where name_en = 'Shieldon'), null, null),
((select id from public.habitats where habitat_no = 197), (select id from public.pokemon where name_en = 'Bastiodon'), null, null),
((select id from public.habitats where habitat_no = 198), (select id from public.pokemon where name_en = 'Tyrunt'), null, null),
((select id from public.habitats where habitat_no = 199), (select id from public.pokemon where name_en = 'Tyrantrum'), null, null),
((select id from public.habitats where habitat_no = 200), (select id from public.pokemon where name_en = 'Amaura'), null, null),
((select id from public.habitats where habitat_no = 201), (select id from public.pokemon where name_en = 'Aurorus'), null, null),
((select id from public.habitats where habitat_no = 202), (select id from public.pokemon where name_en = 'Vaporeon'), null, null),
((select id from public.habitats where habitat_no = 203), (select id from public.pokemon where name_en = 'Jolteon'), null, null),
((select id from public.habitats where habitat_no = 204), (select id from public.pokemon where name_en = 'Flareon'), null, null),
((select id from public.habitats where habitat_no = 205), (select id from public.pokemon where name_en = 'Espeon'), null, null),
((select id from public.habitats where habitat_no = 206), (select id from public.pokemon where name_en = 'Umbreon'), null, null),
((select id from public.habitats where habitat_no = 207), (select id from public.pokemon where name_en = 'Leafeon'), null, null),
((select id from public.habitats where habitat_no = 208), (select id from public.pokemon where name_en = 'Glaceon'), null, null),
((select id from public.habitats where habitat_no = 209), (select id from public.pokemon where name_en = 'Sylveon'), null, null),
((select id from public.habitats where habitat_no = 210), (select id from public.pokemon where name_en = 'Hoppip'), null, null),
((select id from public.habitats where habitat_no = 210), (select id from public.pokemon where name_en = 'Skiploom'), null, null),
((select id from public.habitats where habitat_no = 210), (select id from public.pokemon where name_en = 'Jumpluff'), null, null),
((select id from public.habitats where habitat_no = 211), (select id from public.pokemon where name_en = 'Skiploom'), null, null),
((select id from public.habitats where habitat_no = 212), (select id from public.pokemon where name_en = 'Jumpluff'), null, null),
((select id from public.habitats where habitat_no = 213), (select id from public.pokemon where name_en = 'Sableye'), null, null);

insert into public.source_records (entity_kind, entity_id, source_name, source_url, verified_at, confidence, notes)
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 1), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 2), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 3), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 4), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 5), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 6), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 7), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 8), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 9), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 10), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 11), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 12), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 13), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 14), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 15), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 16), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 17), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 18), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 19), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 20), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 21), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 22), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 23), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 24), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 25), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 26), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 27), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 28), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 29), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 30), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 31), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 32), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 33), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 34), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 35), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 36), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 37), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 38), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 39), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 40), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 41), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 42), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 43), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 44), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 45), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 46), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 47), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 48), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 49), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 50), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 51), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 52), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 53), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 54), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 55), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 56), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 57), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 58), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 59), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 60), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 61), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 62), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 63), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 64), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 65), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 66), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 67), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 68), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 69), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 70), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 71), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 72), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 73), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 74), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 75), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 76), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 77), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 78), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 79), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 80), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 81), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 82), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 83), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 84), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 85), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 86), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 87), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 88), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 89), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 90), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 91), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 92), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 93), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 94), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 95), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 96), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 97), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 98), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 99), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 100), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 101), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 102), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 103), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 104), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 105), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 106), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 107), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 108), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 109), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 110), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 111), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 112), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 113), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 114), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 115), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 116), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 117), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 118), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 119), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 120), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 121), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 122), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 123), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 124), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 125), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 126), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 127), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 128), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 129), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 130), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 131), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 132), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 133), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 134), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 135), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 136), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 137), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 138), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 139), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 140), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 141), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 142), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 143), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 144), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 145), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 146), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 147), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 148), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 149), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 150), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 151), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 152), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 153), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 154), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 155), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 156), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 157), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 158), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 159), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 160), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 161), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 162), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 163), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 164), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 165), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 166), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 167), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 168), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 169), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 170), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 171), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 172), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 173), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 174), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 175), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 176), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 177), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 178), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 179), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 180), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 181), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 182), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 183), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 184), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 185), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 186), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 187), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 188), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 189), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 190), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 191), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 192), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 193), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 194), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 195), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 196), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 197), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 198), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 199), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 200), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 201), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 202), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 203), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 204), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 205), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 206), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 207), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 208), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 209), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 210), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 211), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 212), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
union all
select 'habitat'::public.entity_kind, (select id from public.habitats where habitat_no = 213), 'Game8+OP.GG+PokeAPI', 'https://game8.co/games/Pokemon-Pokopia/archives/582463', '2026-03-31T01:55:34.091Z'::timestamptz, 0.85::numeric, 'build-sql-seed.mjs / import 배치'
;

commit;
