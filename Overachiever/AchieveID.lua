
local WOW_BFA = select(4, GetBuildInfo()) >= 80000


local IsAlliance = UnitFactionGroup("player") == "Alliance"

OVERACHIEVER_ACHID = {
	WorldExplorer = 46,		-- "World Explorer"
	LoveCritters = 1206,	-- "To All The Squirrels I've Loved Before"
	LoveCritters2 = 2557,	-- "To All The Squirrels Who Shared My Life"
	LoveCritters3 = 5548,	-- "To All the Squirrels Who Cared for Me"
	LoveCritters4 = 6350,	-- "To All the Squirrels I Once Caressed?"
	LoveCritters5 = 14728,	-- "To All the Squirrels Through Time and Space"
	LoveCritters6 = 14729,	-- "To All the Squirrels I Love Despite Their Scars"
	LoveCritters7 = 14730,	-- "To All the Squirrels I Set Sail to See"
	LoveCritters8 = 14731,	-- "To All the Squirrels I've Love and Lost"
	PestControl = 2556,		-- "Pest Control"
	WellRead = 1244,		-- "Well Read"
	HigherLearning = 1956,	-- "Higher Learning"
	EatYourGreens = 12588,	-- "Eat Your Greens"

	TastesLikeChicken = 1832,	-- "Takes Like Chicken"
	HappyHour = 1833,		-- "It's Happy Hour Somewhere"
	CataclysmicallyDelicious = 5753,-- "Cataclysmically Delicious"
	DrownYourSorrows = 5754,	-- "Drown Your Sorrows"
	PandarenCuisine = 7329,		-- "Pandaren Cuisine"
	PandarenDelicacies = 7330,	-- "Pandaren Delicacies"
	DraenorCuisine = 9502,		-- "Draenor Cuisine"
	BrewfestDiet = 1185,		-- "The Brewfest Diet"
	DarkmoonFaireFeast = 6026,	-- "Fairegoer's Feast"

	RightAsRain = 5779,		-- "You'll Feel Right as Rain"

	Scavenger = 1257,			-- "The Scavenger"
	OutlandAngler = 1225,		-- "Outland Angler"
	NorthrendAngler = 1517,		-- "Northrend Angler"
	Limnologist = 5478,			-- "The Limnologist"
	Oceanographer = 5479,		-- "The Oceanographer"
	PandarianAngler = 7611,		-- "Pandarian Angler"
	DraenorAngler = 9462,		-- "Draenor Angler"

	GourmetOutland = 1800,		-- "The Outland Gourmet"
	GourmetNorthrend = 1779,	-- "The Northrend Gourmet" (last part)
	GourmetCataclysm = 5473,	-- "The Cataclysmic Gourmet" (last part)
	GourmetPandaren = 7327,		-- "The Pandaren Gourmet" (last part)
	--GourmetWinter = 1688,		-- "The Winter Veil Gourmet" -- requires proper season; waiting on season detection feature?
	GourmetDraenor = 9501,		-- "The Draenor Gourmet"
	LegionMenu = 10762,			-- "The Legion Menu"
	BattleMenu = IsAlliance and 12744 or 12746,		-- "The Kul Tiran Menu" / "The Zandalari Menu"

	ThreeSheetsToTheWind = 13061,	-- "Three Sheets to the Wind"

	MediumRare = 1311,			-- "Medium Rare"
	BloodyRare = 1312,			-- "Bloody Rare"
	NorthernExposure = 2256,	-- "Northern Exposure"
	Frostbitten = 2257,			-- "Frostbitten"
	Glorious = 7439,			-- "Glorious!"
	BattleMonsters = 12587,		-- "Unbound Monstrosities"

	StoodInTheFire = 5518,		-- "Stood in the Fire"
	SurveyingTheDamage = 4827,	-- "Surveying the Damage"
	WhaleShark = 4975,			-- "From Hell's Heart I Stab at Thee"

	LetItSnow = 1687,		-- "Let It Snow"
	FistfulOfLove = 1699,	-- "Fistful of Love"
	BunnyMaker = 2422,		-- "Shake Your Bunny-Maker"
	CheckYourHead = 291,	-- "Check Your Head"
	TurkeyLurkey = 3559,	-- "Turkey Lurkey"

	MissionBarrens = IsAlliance and 12896 or 12867, -- Azeroth at War: The Barrens
	MissionLordaeron = IsAlliance and 12898 or 12869, -- Azeroth at War: After Lordaeron
	MissionKalimdor = IsAlliance and 12899 or 12870, -- Azeroth at War: Kalimdor on Fire

	--WhatWeRideInTheShadows = 14770,	-- "What We Ride in the Shadows"
	AfterlifeExpress = 14771,				-- "The Afterlife Express"

	-- Statistics:
	Stat_ConsumeDrinks = 346,	-- "Beverages consumed"
	Stat_ConsumeFood = 347,		-- "Food eaten"
	--1774 "Different beverages consumed"
	--1775 "Different foods eaten"
};

OVERACHIEVER_MOB_CRIT = {
	-- For achievements where Overachiever's "kill" criteria lookup doesn't work, e.g. due to the asset ID being for quests instead of NPCs for some
	-- reason. Format: [<mob ID>] = { <achievement ID>, <ach's criteria index>[, <2nd achievement ID>, <2nd ach's criteria index>[, ...]] }  ()

	-- LEGION:

	-- Adventurer of Azsuna:
	[90244] = { 11261, 10 }, -- Unbound Rift (start w/object)
	[90505] = { 11261, 11 }, -- Syphonus & Leodrath
	[90803] = { 11261, 12 }, -- Cache of Infernals (start w/object)
	[91115] = { 11261, 14 }, -- Tide Behemoth
	[91100] = { 11261, 16 }, -- Marius & Tehd versus a Fel Lord
	[91579] = { 11261, 17 }, -- Marius & Tehd versus a Doomlord
	[105938] = { 11261, 18 }, -- Marius & Tehd versus Felbats
	[112637] = { 11261, 22 }, -- Treacherous Stallions (1/2)
	[112636] = { 11261, 22 }, -- Treacherous Stallions (2/2)
	[107657] = { 11261, 23 }, -- Arcanist Shal'iman
	[107113] = { 11261, 24 }, -- Vorthax
	[107269] = { 11261, 25 }, -- Inquisitor Tivos (mark portal object?)
	[89016] = { 11261, 26 }, -- Ravyn-Drath
	-- Adventurer of Val'sharah:
	[93654] = { 11262, 7 }, -- Elindya Featherlight (start w/friendly NPC)
	--[] = { 11262, 8 }, -- Antydas Nightcaller
	[94414] = { 11262, 9 }, -- Haunted Manor (start w/object)
	[94485] = { 11262, 10 }, -- Purging the River (start w/friendly NPC? though I usually just see it wandering)
	[95123] = { 11262, 11 }, -- Grelda the Hag
	[95221] = { 11262, 12 }, -- Old Bear Trap (start w/object (or NPC-thing?))
	[95318] = { 11262, 13 }, -- Perrexx the Corruptor
	[97504] = { 11262, 14 }, -- Wraithtalon
	[97517] = { 11262, 15 }, -- Dreadbog
	[98241] = { 11262, 16 }, -- Lyrath Moonfeather
	[109708] = { 11262, 17 }, -- Undgrell Attack
	[110562] = { 11262, 18 }, -- Bahagar
	[92104] = { 11262, 19 }, -- Unguarded Thistleleaf Treasure (start w/object, end w/object)
	[93679] = { 11262, 20 }, -- Marius & Tehd versus a Satyr
	-- Adventurer of Highmountain:
	[101077] = { 11264, 1 }, -- Sekhan
	[97653] = { 11264, 2 }, -- The Beastly Boxer
	[97933] = { 11264, 3 }, -- Crab Rider Grmlrml
	[97345] = { 11264, 4 }, -- Crawshuk the Hungry
	[96590] = { 11264, 5 }, -- Gurbog da Basher
	[97326] = { 11264, 6 }, -- Hartli the Snatcher
	[95872] = { 11264, 7 }, -- Skywhisker Taskmaster
	[100302] = { 11264, 8 }, -- Unethical Adventurers (1/5)
	[109498] = { 11264, 8 }, -- Unethical Adventurers (2/5)
	[100303] = { 11264, 8 }, -- Unethical Adventurers (3/5)
	[109501] = { 11264, 8 }, -- Unethical Adventurers (4/5)
	[109500] = { 11264, 8 }, -- Unethical Adventurers (5/5)
	[97203] = { 11264, 9 }, -- The Exiled Shaman
	--[] = { 11264, 10 }, -- Beastmaster Pao'lek (friendly NPC starts: 97215)
	[96410] = { 11264, 11 }, -- Majestic Elderhorn
	[97449] = { 11264, 12 }, -- Bristlemaul
	[97593] = { 11264, 13 }, -- Scout Harefoot (start w/friendly NPC)
	[95204] = { 11264, 14 }, -- Oubdob da Smasher
	[98299] = { 11264, 15 }, -- Bodash the Hoarder
	[100232] = { 11264, 16 }, -- Amateur Hunters (1/3)
	[100230] = { 11264, 16 }, -- Amateur Hunters (2/3)
	[100231] = { 11264, 16 }, -- Amateur Hunters (3/3)
	[97102] = { 11264, 17 }, -- Totally Safe Treasure Chest (start w/object)
	[100495] = { 11264, 18 }, -- Devouring Darkness (start w/object)
	[96621] = { 11264, 19 }, -- Mellok, Son of Torok
	[98024] = { 11264, 20 }, -- Luggut the Eggeater
	[97093] = { 11264, 21 }, -- Shara Felbreath
	[98890] = { 11264, 22 }, -- Slumbering Bear
	[98311] = { 11264, 23 }, -- Captured Survivor (start w/friendly NPC)
	-- Adventurer of Stormheim:
	[91529] = { 11263, 1 }, -- Glimar Ironfist
	[91795] = { 11263, 2 }, -- Stormwing Matriarch
	[98225] = { 11263, 3 }, -- Fathnyr
	[91874] = { 11263, 4 }, -- Bladesquall
	[91895] = { 11263, 5 }, -- Thane's Mead Hall (1/4)
	[91893] = { 11263, 5 }, -- Thane's Mead Hall (2/4)
	[91894] = { 11263, 5 }, -- Thane's Mead Hall (3/4)
	[91892] = { 11263, 5 }, -- Thane's Mead Hall (4/4)
	[92040] = { 11263, 6 }, -- Fenri
	[92152] = { 11263, 7 },	-- Whitewater Typhoon
	[92599] = { 11263, 8 }, -- Worg Pack
	[IsAlliance and 92631 or 92604] = { 11263, 9 }, -- Worgen Stalkers or Forsaken Deathsquad (1/4)
	[IsAlliance and 92634 or 92613] = { 11263, 9 }, -- Worgen Stalkers or Forsaken Deathsquad (2/4)
	[IsAlliance and 92626 or 92609] = { 11263, 9 }, -- Worgen Stalkers or Forsaken Deathsquad (3/4)
	[IsAlliance and 92633 or 92611] = { 11263, 9 }, -- Worgen Stalkers or Forsaken Deathsquad (4/4)
	[92685] = { 11263, 10 }, -- Helmouth Raiders (start w/object)
	[92751] = { 11263, 11 }, -- Ivory Sentinel
	[92763] = { 11263, 12 }, -- The Nameless King (start w/object)
	[93166] = { 11263, 13 }, -- Lost Ettin
	[93371] = { 11263, 14 }, -- Mordvigbjorn
	[93401] = { 11263, 15 }, -- Urgev the Flayer
	[94413] = { 11263, 16 }, -- Isel the Hammer
	[97630] = { 11263, 17 }, -- Soulthirster
	[98188] = { 11263, 18 }, -- Egyl the Enduring
	[98268] = { 11263, 19 }, -- Tarben
	[98421] = { 11263, 20 }, -- Kottr Vondyr
	[98503] = { 11263, 21 }, -- Grrvrgull the Conquerer
	[107926] = { 11263, 22 }, -- Hannval the Butcher
	[110363] = { 11263, 23 }, -- Roteye
	[90139] = { 11263, 24 }, -- Marius & Tehd versus an Inquisitor
	-- Adventurer of Suramar:
	[99610] = { 11265, 1 }, -- Garvulg
	[99792] = { 11265, 2 }, -- Elfbane
	[100864] = { 11265, 3 }, -- Cora'kar
	[103183] = { 11265, 4 }, -- Rok'nash
	[103214] = { 11265, 5 }, -- Har'kess the Insatiable
	[103223] = { 11265, 6 }, -- Hertha Grimdottir
	[103575] = { 11265, 7 }, -- Reef Lord Raj'his
	[103841] = { 11265, 8 }, -- Shadowquil
	[105547] = { 11265, 9 }, -- Rauren
	[106351] = { 11265, 10 }, -- Artificer Lothaire
	[107846] = { 11265, 11 }, -- Pinchshank
	[109054] = { 11265, 12 }, -- Shal'an
	[109954] = { 11265, 13 }, -- Magister Phaedris
	[110024] = { 11265, 14 }, -- Mal'Dreth the Corrupter
	[110340] = { 11265, 15 }, -- Myonix
	[110438] = { 11265, 16 }, -- Seigemaster Aedrin
	[110577] = { 11265, 17 }, -- Oreth the Vile
	[110656] = { 11265, 18 }, -- Arcanist Lylandre
	[110726] = { 11265, 19 }, -- Cadraeus
	[110824] = { 11265, 20 }, -- Tideclaw
	[110832] = { 11265, 21 }, -- Gorgroth (summoned by an item?)
	[110870] = { 11265, 22 }, -- Apothecary Faldren
	[110944] = { 11265, 23 }, -- Guardian Thor'el
	[111063] = { 11265, 24 }, -- Randril
	[111197] = { 11265, 25 }, -- Anax
	[111329] = { 11265, 26 }, -- Matron Hagatha
	[111649] = { 11265, 27 }, -- Ambassador D'vwinn
	[111651] = { 11265, 28 }, -- Degren
	[111653] = { 11265, 29 }, -- Miasu
	[112497] = { 11265, 30 }, -- Maia the White
	[112802] = { 11265, 31 }, -- Mar'tura
	[102303] = { 11265, 32 }, -- Lieutenant Strathmar
	-- Adventurer of Argus:
	--   lookup not needed; all are kill type

	-- BATTLE FOR AZEROTH:

	-- Adventurer of Nazmir:
	[125250] = { 12942, 1 }, -- Ancient Jawbreaker
	[134298] = { 12942, 2 }, -- Azerite Infused Elemental
	[134293] = { 12942, 3 }, -- Azerite Infused Slag
	[126635] = { 12942, 4 }, -- Blood Priest Xak'lar
	[128965] = { 12942, 5 }, -- Uroku the Bound
	[129005] = { 12942, 6 }, -- King Kooba
	[134296] = { 12942, 7 }, -- Chag's Challenge (first speak with 134297?)
	[126187] = { 12942, 8 }, -- Corpse Bringer Yal'kar
	[125232] = { 12942, 9 }, -- Cursed Chest (summoned from object)
	[127001] = { 12942, 10 }, -- Gwugnug the Cursed
	[121242] = { 12942, 11 }, -- Glompmaw
	[128426] = { 12942, 12 }, -- Gutrip the Hungry
	[128974] = { 12942, 13 }, -- Queen Tzxi'kik
	[124399] = { 12942, 14 }, -- Infected Direhorn
	[133373] = { 12942, 15 }, -- Jax'teb the Reanimated
	[133527] = { 12942, 16 }, -- Juba the Scarred
	[124397] = { 12942, 17 }, -- Kal'draxa
	[125214] = { 12942, 18 }, -- Krubbs
	[134295] = { 12942, 19 }, -- Lost Scroll --!!
	[126142] = { 12942, 20 }, -- Bajiatha
	[127820] = { 12942, 21 }, -- Scout Skrasniss
	[127873] = { 12942, 22 }, -- Scrounger Patriarch
	[126460] = { 12942, 23 }, -- Tainted Guardian
	[126056] = { 12942, 24 }, -- Totem Maker Jash'ga
	--[] = { 12942, 25 }, -- Urn of Agussu (object)
	[126926] = { 12942, 26 }, -- Venomjaw
	[126907] = { 12942, 27 }, -- Wardrummer Zurula
	[133531] = { 12942, 28 }, -- Xu'ba the Bone Collector
	[129657] = { 12942, 29 }, -- Za'amar the Queen's Blade
	[133812] = { 12942, 30 }, -- Zanxib the Engorged
	[133539] = { 12942, 31 }, -- Lo'kuno
	[128935] = { 12942, 32 }, -- Mala'kili and Rohnkor (Mala'kili)
	[128930] = { 12942, 32 }, -- Mala'kili and Rohnkor (Rohnkor)
	-- Adventurer of Zuldazar:
	[129961] = { 12944, 1 }, -- Atal'zul Gotaka
	[129954] = { 12944, 2 }, -- Gahz'ralka
	[136428] = { 12944, 3 }, -- Dark Chronicler
	[136413] = { 12944, 4 }, -- Syrawon the Dominus
	[131476] = { 12944, 5 }, -- Zayoos
	[131233] = { 12944, 6 }, -- Lei-Zhi
	[129343] = { 12944, 7 }, -- Avatar of Xolotal
	[128699] = { 12944, 8 }, -- Bloodbulge
	[127939] = { 12944, 9 }, -- Torraske the Eternal
	[126637] = { 12944, 10 }, -- Kandak
	[120899] = { 12944, 11 }, -- Kul'krazahn
	[124185] = { 12944, 12 }, -- Golrakahn
	[134760] = { 12944, 14 }, -- Darkspeaker Jo'la
	[134738] = { 12944, 15 }, -- Hakbi the Risen
	[134048] = { 12944, 16 }, -- Vukuba
	[133842] = { 12944, 17 }, -- Warcrawler Karkithiss
	[134782] = { 12944, 18 }, -- Murderbeak
	[133190] = { 12944, 19 }, -- Daggerjaw
	[133155] = { 12944, 20 }, -- G'Naat
	[132244] = { 12944, 21 }, -- Kiboku
	[131718] = { 12944, 22 }, -- Bramblewing
	[131687] = { 12944, 23 }, -- Tambano
	-- Adventurer of Vol'dun:
	--   lookup not needed; all are kill type
	-- Adventurer of Drustvar:
	[124548] = { 12941, 1 }, -- Betsy
	[125453] = { 12941, 2 }, -- Quillrat Matriarch
	[127333] = { 12941, 3 }, -- Barbthorn Queen
	[127651] = { 12941, 4 }, -- Vicemaul
	[126621] = { 12941, 5 }, -- Bonesquall
	[127844] = { 12941, 6 }, -- Gluttonous Yeti
	[127877] = { 12941, 7 }, -- Longfang (Longfang)
	[127901] = { 12941, 7 }, -- Longfang (Henry Breakwater)
	--[] = { 12941, 8 }, -- Ancient Sarcophagus
	[129904] = { 12941, 9 }, -- Beastly Ritual Skull (Cottontail Matron !! need confirmation this is the right mob for this objective)
	[128707] = { 12941, 10 }, -- Rimestone
	[128973] = { 12941, 11 }, -- Whargarble the Ill-Tempered
	--[] = { 12941, 12 }, -- Seething Cache
	[127129] = { 12941, 13 }, -- Grozgore
	[129835] = { 12941, 14 }, -- Gorehorn
	[129805] = { 12941, 15 }, -- Beshol
	[129950] = { 12941, 16 }, -- Talon
	[129995] = { 12941, 17 }, -- Emily Mayville
	[130138] = { 12941, 18 }, -- Nevermore
	[130143] = { 12941, 19 }, -- Balethorn
	[132319] = { 12941, 20 }, -- Bilefang Mother
	[134213] = { 12941, 21 }, -- Executioner Blackwell
	[134706] = { 12941, 22 }, -- Deathcap
	[134754] = { 12941, 23 }, -- Hyo'gi
	[135796] = { 12941, 24 }, -- Captain Leadfist
	[137529] = { 12941, 25 }, -- Arvon the Betrayed
	[137824] = { 12941, 26 }, -- Arclight
	[137825] = { 12941, 27 }, -- Avalanche
	[138618] = { 12941, 28 }, -- Haywire Golem
	[138675] = { 12941, 29 }, -- Gorged Boar
	[138863] = { 12941, 30 }, -- Sister Martha
	[138871] = { 12941, 31 }, -- Fungi Trio (Ernie)
	[138870] = { 12941, 31 }, -- Fungi Trio (Mick)
	[138866] = { 12941, 31 }, -- Fungi Trio (Mack)
	[139321] = { 12941, 32 }, -- Braedan Whitewall
	[139322] = { 12941, 33 }, -- Hexed Hunter
	-- Adventurer of Tiragarde Sound:
	--   lookup not needed; all are kill type
	-- Adventurer of Stormsong Valley:
	[141175] = { 12940, 1 }, -- Song Mistress Dadalea
	[140997] = { 12940, 2 }, -- Severus the Outcast
	[138938] = { 12940, 3 }, -- Seabreaker Skoloth
	[139328] = { 12940, 4 }, -- Sabertron
	[136189] = { 12940, 5 }, -- The Lichen King
	[134884] = { 12940, 6 }, -- Ragna
	[139319] = { 12940, 7 }, -- Slickspill
	[137025] = { 12940, 8 }, -- Broodmother
	[132007] = { 12940, 9 }, -- Galestorm
	[142088] = { 12940, 10 }, -- Whirlwing
	[141029] = { 12940, 11 }, -- Kickers
	[131404] = { 12940, 12 }, -- Foreman Scripps
	[141286] = { 12940, 13 }, -- Poacher Zane
	[139298] = { 12940, 14 }, -- Pinku'shon
	[141059] = { 12940, 15 }, -- Grimscowl the Harebrained
	[139385] = { 12940, 16 }, -- Deepfang
	[140938] = { 12940, 17 }, -- Croaker
	[139968] = { 12940, 18 }, -- Corrupted Pod (Corrupted Tideskipper; also have to kill others in the pod?)
	[136183] = { 12940, 19 }, -- Crushtacean
	[134897] = { 12940, 20 }, -- Dagrus the Scorned
	[135939] = { 12940, 21 }, -- Vinespeaker Ratha
	[135947] = { 12940, 22 }, -- Strange Mushroom Ring
	[141226] = { 12940, 23 }, -- Haegol the Hammer
	[141088] = { 12940, 24 }, -- Squall
	[141039] = { 12940, 25 }, -- Ice Sickle
	[130897] = { 12940, 26 }, -- Captain Razorspine
	[129803] = { 12940, 27 }, -- Whiplash
	[141143] = { 12940, 28 }, -- Sister Absinthe
	[130079] = { 12940, 29 }, -- Wagga Snarltusk
	[138963] = { 12940, 30 }, -- Nestmother Acada
	[141239] = { 12940, 31 }, -- Osca the Bloodied
	[139988] = { 12940, 32 }, -- Sandfang
	[139980] = { 12940, 33 }, -- Taja the Tidehowler
	[IsAlliance and 141043 or 140925] = { 12940, 34 }, -- Doc Marrtens or Jakala the Cruel (kill type but asset ID 0)
	
	-- SHADOWLANDS
	
	-- Adventurer of Bastion:
	--!!
	-- Adventurer of Maldraxxus:
	--   lookup not needed; all are kill type
};

--[[
function Overachiever.Debug_WHICHCRIT(id)
	print("Examining "..id..".")
	local c, c2, name, crittype = 0, 0
	local _, assetID
	local s = ""
	local num = GetAchievementNumCriteria(id)
	for i=1,num do
		name, crittype, _, _, _, _, _, assetID = GetAchievementCriteriaInfo(id, i)
		if (crittype == 27) then
			print("- quest type:|cff7eff00", id, i, name)
			c = c + 1
			s = s.."\n  [NPC_ID] = { "..id..", "..i.." }, -- "..name --.." (quest "..assetID..")"
		elseif (crittype == 0) then
			if (assetID and assetID ~= 0) then
				print("- kill type:|cff7f7f7f", id, i, name);
			else
				print("- kill type with MISSING asset ID:|cffff1919", id, i, name);
				c2 = c2 + 1
				s = s.."\n  [] = { "..id..", "..i.." }, -- "..name .. " (kill type but asset ID 0)"
			end
		else
			print("|cffff1919! unexpected type ("..crittype.."):", id, i, name);
		end
	end
	print("Done.",c,"out of",num,"are quest type.")
	print(c2,"out of",num,"are kill type with missing asset ID.")
	return s
end
--/run error(Overachiever.Debug_WHICHCRIT(11261)) -- Adventurer of Azsuna
--/run error(Overachiever.Debug_WHICHCRIT(11262)) -- Adventurer of Val'sharah
--/run error(Overachiever.Debug_WHICHCRIT(11264)) -- Adventurer of Highmountain
--/run error(Overachiever.Debug_WHICHCRIT(11263)) -- Adventurer of Stormheim
--/run error(Overachiever.Debug_WHICHCRIT(11265)) -- Adventurer of Suramar
--/run error(Overachiever.Debug_WHICHCRIT(12077)) -- Adventurer of Argus

--/run error(Overachiever.Debug_WHICHCRIT(12942)) -- Adventurer of Nazmir
--/run error(Overachiever.Debug_WHICHCRIT(12944)) -- Adventurer of Zuldazar
--/run error(Overachiever.Debug_WHICHCRIT(12943)) -- Adventurer of Vol'dun
--/run error(Overachiever.Debug_WHICHCRIT(12941)) -- Adventurer of Drustvar
--/run error(Overachiever.Debug_WHICHCRIT(12939)) -- Adventurer of Tiragarde Sound
--/run error(Overachiever.Debug_WHICHCRIT(12940)) -- Adventurer of Stormsong Valley

--/run error(Overachiever.Debug_WHICHCRIT(14307)) -- Adventurer of Bastion
--/run error(Overachiever.Debug_WHICHCRIT(14308)) -- Adventurer of Maldraxxus
--]]


-- Timed battleground achievements:
OVERACHIEVER_BGTIMERID = {
	-- Format: [<Achievement ID>] = <Instance Map ID> or true or false. See: http://wow.gamepedia.com/InstanceMapID#Battlegrounds
	-- If true, we aren't worried about the instance map ID. (Ideally, that would always be the case, but there is/was a bug where WoW reported a timer started
	-- when it shouldn't be, resulting in improper auto-tracking.)
	-- If false, we don't auto-track it despite WoW telling us the timer started.
	[201] = 489, -- Warsong Expedience (Warsong Gulch) [working around bug]
	[159] = 529, -- Let's Get This Done (Arathi Basin) [working around bug]
	[214] = 566, -- Flurry (Eye of the Storm)
	[226] = 30, -- The Alterac Blitz (Alterac Valley) -- worked when not present (but needs to be present bc separate option now)
	-- none for Isle of Conquest
	[1310] = 607, -- Storm the Beach (Strand of the Ancients) -- this is for the attack round only, not whole match
	[5254] = 761, -- Newbs to Plowshares (Battle for Gilneas) [working around bug]
	[5216] = 726, -- Peak Speed (Twin Peaks) [working around bug]
	-- none for Silvershard Mines
	-- none for Temple of Kotmogu
	-- none for Deepwind Gorge
	-- not instanced: [1755] = -1, -- Within Our Grasp (Wintergrasp)
	-- none for Tol Barad
	-- none for Ashran
	[12404] = 1803, -- Claim Jumper (Seething Shore) -- for doing something shortly after landing, not timed from start of match
	[12405] = 1803, -- Death From Above (Seething Shore) -- for doing something shortly after landing, not timed from start of match

	-- Quick Cap (Warsong Gulch):
	[202] = IsAlliance and 489 or false,
	[1502] = not IsAlliance and 489 or false,
	-- Fire, Walk With Me (Twin Peaks):
	[5221] = IsAlliance and 726 or false,
	[5222] = not IsAlliance and 726 or false,
}
OVERACHIEVER_BGTIMERID_RATED = {
-- !! check for more rated-specific ones. last check: before Seething Shore
	[214] = 968, -- Flurry (Eye of the Storm)
}

-- Look up the achievement ID of the given zone's exploration achievement, whatever the localization.
-- Using zone names alone isn't reliable because the achievement names don't always use the zone's name as given by
-- functions like GetRealZoneText() with some localizations.

OVERACHIEVER_EXPLOREZONEID = {
-- Kalimdor:
	["Ashenvale"] = 845,
	["Azshara"] = 852,
	["Darkshore"] = 844,
	["Desolace"] = 848,
	["Durotar"] = 728,
	["Dustwallow Marsh"] = 850,
	["Felwood"] = 853,
	["Feralas"] = 849,
	["Moonglade"] = 855,
	["Mulgore"] = 736,
	["Northern Barrens"] = 750,
	["Silithus"] = 856,
	["Southern Barrens"] = 4996,
	["Stonetalon Mountains"] = 847,
	["Tanaris"] = 851,
	["Teldrassil"] = 842,
	["Thousand Needles"] = 846,
	["Un'Goro Crater"] = 854,
	["Winterspring"] = 857,
   -- Burning Crusade:
	["Azuremyst Isle"] = 860,
	["Bloodmyst Isle"] = 861,
   -- Cataclysm:
	["Mount Hyjal"] = 4863,
	["Uldum"] = 4865,
-- Eastern Kingdoms:
	["Arathi Highlands"] = 761,
	["Badlands"] = 765,
	["Blasted Lands"] = 766,
	["Burning Steppes"] = 775,
	["The Cape of Stranglethorn"] = 4995,
	["Deadwind Pass"] = 777,
	["Dun Morogh"] = 627,
	["Duskwood"] = 778,
	["Eastern Plaguelands"] = 771,
	["Elwynn Forest"] = 776,
	["Hillsbrad Foothills"] = 772,
	["The Hinterlands"] = 773,
	["Loch Modan"] = 779,
	["Northern Stranglethorn"] = 781,
	["Redridge Mountains"] = 780,
	["Searing Gorge"] = 774,
	["Silverpine Forest"] = 769,
	["Swamp of Sorrows"] = 782,
	["Tirisfal Glades"] = 768,
	["Western Plaguelands"] = 770,
	["Westfall"] = 802,
	["Wetlands"] = 841,
	-- Zone removed: ["Alterac Mountains"] = 760,
   -- Burning Crusade:
	["Eversong Woods"] = 859,
	["Ghostlands"] = 858,
	["Isle of Quel'Danas"] = 868,
   -- Cataclysm:
	--["Tol Barad"] = 4867,           -- This achievement ("Explore Tol Barad") was removed from the game
	--["Tol Barad Peninsula"] = 4867, -- due to it being buggy. Note that it may return in a future patch.
	["Twilight Highlands"] = 4866,
	-- Vashj'ir:
	["Vashj'ir"] = 4825,
	["Kelp'thar Forest"] = 4825,
	["Shimmering Expanse"] = 4825,
	["Abyssal Depths"] = 4825,
-- Outland:
	["Blade's Edge Mountains"] = 865,
	["Hellfire Peninsula"] = 862,
	["Nagrand (Outland)"] = 866, -- RENAMED ZONE
	["Netherstorm"] = 843,
	["Shadowmoon Valley (Outland)"] = 864, -- RENAMED ZONE
	["Terokkar Forest"] = 867,
	["Zangarmarsh"] = 863,
-- Northrend:
	["Borean Tundra"] = 1264,
	["Crystalsong Forest"] = 1457,
	["Dragonblight"] = 1265,
	["Grizzly Hills"] = 1266,
	["Howling Fjord"] = 1263,
	["Icecrown"] = 1270,
	["Sholazar Basin"] = 1268,
	["The Storm Peaks"] = 1269,
	["Zul'Drak"] = 1267,
-- Other Cataclysm-related:
	["Deepholm"] = 4864,
-- Pandaria:
	["The Jade Forest"] = 6351,
	["Krasarang Wilds"] = 6975,
	["Kun-Lai Summit"] = 6976,
	["Valley of the Four Winds"] = 6969,
	["Townlong Steppes"] = 6977,
	["Dread Wastes"] = 6978,
	["Vale of Eternal Blossoms"] = 6979,
-- Draenor
	["Frostfire Ridge"] = 8937,
	["Shadowmoon Valley (Draenor)"] = 8938,
	["Gorgrond"] = 8939,
	["Talador"] = 8940,
	["Spires of Arak"] = 8941,
	["Nagrand (Draenor)"] = 8942,
	["Tanaan Jungle"] = 10260,
-- Legion
	["Azsuna"] = 10665,
	["Val'sharah"] = 10666,
	["Highmountain"] = 10667,
	["Stormheim"] = 10668,
	["Suramar"] = 10669,
	["Broken Shore"] = 11543,
	-- Explore Argus:
	["Krokuun"] = 12069,
	["Mac'Aree"] = 12069,
	["Antoran Wastes"] = 12069,
-- Battle for Azeroth
	["Drustvar"] = 12557,
	["Nazmir"] = 12561,
	["Stormsong Valley"] = 12558,
	["Tiragarde Sound"] = 12556,
	["Vol'dun"] = 12560,
	["Zuldazar"] = 12559,
	["Nazjatar"] = 13712,
	["Mechagon Island"] = 13776,
-- Shadowlands
	["Bastion"] = 14303,
	["Maldraxxus"] = 14305,
	["Ardenweald"] = 14304,
	["Revendreth"] = 14306,
	["The Maw"] = 14663,
};
OVERACHIEVER_EXPLOREZONEID["Thunder Totem"] = OVERACHIEVER_EXPLOREZONEID["Highmountain"]
-- "Explore Cataclysm": 4868


local LBZ = LibStub("LibBabble-SubZone-3.0");
LBZ = LBZ:GetReverseLookupTable()

function Overachiever.ExploreZoneIDLookup(zoneName)
  local z = LBZ[zoneName] or zoneName
  z = Overachiever.GetZoneKey(z)
  return OVERACHIEVER_EXPLOREZONEID[z]
end


--[[ These categories no longer exist!:
OVERACHIEVER_CATEGORY_HEROIC = {
	[14921] = true, -- Lich King Dungeon
	[14923] = true, -- Lich King 25-Player Raid
};
OVERACHIEVER_CATEGORY_25 = {
	[14923] = true,			-- Lich King 25-Player Raid
	[14962] = true,			-- Secrets of Ulduar 25-Player Raid
	[15002] = true,			-- Call of the Crusade 25-Player Raid
	[15042] = true,			-- Fall of the Lich King 25-Player Raid
};
--]]

OVERACHIEVER_HEROIC_CRITERIA = {
	[1658] =			-- "Champion of the Frozen Wastes"
		{ [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true,
		  [12] = true, [13] = true, [14] = true, [15] = true },
--[[ this data seems wrong. was this achievement changed at some point or has it always been wrong?
		{ [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true,
		  [13] = true, [14] = true, [15] = true },
--]]
};

OVERACHIEVER_MYTHIC_CRITERIA = {} -- Unused for now, but checked in GameTip.lua



-- ZONE RENAMES AND LOOKUP BY MAP ID (helps handle issues where a zone name is used multiple times)
-- To find a zone's map ID, open the map to it and use: /dump GetCurrentMapAreaID()
if (WOW_BFA) then
	Overachiever.ZONE_RENAME = {
	--[[
		["name from GetRealZoneText()"] = {
			[one of the map IDs] = "The key we're using for this zone",
		},
	--]]
	}
	Overachiever.INSTANCE_RENAME = {
	--[[
		["name from GetRealZoneText()"] = {
			[the InstanceMapID (NOT the map ID)] = "The key we're using for this zone",
		},
	--]]
		["Shadowmoon Valley"] = {
			[530] = "Shadowmoon Valley (Outland)", -- 530 = Outland
			[1116] = "Shadowmoon Valley (Draenor)", -- 1116 = Draenor
		},
		["Nagrand"] = {
			[530] = "Nagrand (Outland)",
			[1116] = "Nagrand (Draenor)",
		},
		["Dalaran"] = {
			[571] = "Dalaran (Northrend)",
			[1220] = "Dalaran (Broken Isles)", -- 1220 = Broken Isles
		},
		["Karazhan"] = { -- !! double check this is the zone name
			[1651] = "Return to Karazhan", -- !! confirm this works in both Upper and Lower
		},
		-- !! need to confirm these next two work:
		["Warfronts Arathi - Alliance"] = {
			[1943] = "Battle for Stromgarde",
		},
		["Warfronts Arathi - Horde"] = {
			[1943] = "Battle for Stromgarde", -- !! need the ID for Horde version
		},
	}
else
	Overachiever.ZONE_RENAME = {
	--[[
		["Zone's real name"] = {
			[one of the map IDs] = "The key we're using for this zone",
		},
	--]]
		["Dalaran"] = {
			[504] = "Dalaran (Northrend)",
			[1014] = "Dalaran (Broken Isles)",
		},
		["Shadowmoon Valley"] = {
			[473] = "Shadowmoon Valley (Outland)",
			[947] = "Shadowmoon Valley (Draenor)",
		}
		,
		["Nagrand"] = {
			[477] = "Nagrand (Outland)",
			[950] = "Nagrand (Draenor)",
		},
		["Karazhan"] = { -- !! double check
			[1115] = "Return to Karazhan",
		},
	}
	Overachiever.INSTANCE_RENAME = {}
end
-- If adding to this, don't forget to add to ZONE_RENAME_REV in Overachiever_Tabs\Suggestions.lua as well.

local ZONE_RENAME = Overachiever.ZONE_RENAME
local INSTANCE_RENAME = Overachiever.INSTANCE_RENAME

if (WOW_BFA) then
----- BFA:

function Overachiever.GetZoneKey(zoneName) -- zoneName here is expected to be in English
	if (ZONE_RENAME[zoneName]) then
		local mapID = C_Map.GetBestMapForUnit("player")
		if (mapID and ZONE_RENAME[zoneName][mapID]) then
			--Overachiever.chatprint(zoneName .. " got renamed to " .. ZONE_RENAME[zoneName][mapID])
			return ZONE_RENAME[zoneName][mapID]
		end
	end
	if (INSTANCE_RENAME[zoneName]) then
		local _, insType, insMapID
		_, insType, _, _, _, _, _, insMapID = GetInstanceInfo()
		--if (insType ~= "none" and insMapID and INSTANCE_RENAME[zoneName][insMapID]) then
		if (insMapID and INSTANCE_RENAME[zoneName][insMapID]) then
			--Overachiever.chatprint(zoneName .. " (instance) got renamed to " .. INSTANCE_RENAME[zoneName][insMapID])
			return INSTANCE_RENAME[zoneName][insMapID]
		end
	end
	return zoneName
end

----- :BFA
else
----- Legion:

function Overachiever.GetZoneKey(zoneName) -- zoneName here is expected to be in English
  if (ZONE_RENAME[zoneName]) then
    local mapID = Overachiever.GetCurrentMapID()
    if (mapID and ZONE_RENAME[zoneName][mapID]) then
      --Overachiever.chatprint(zoneName .. " got renamed to " .. ZONE_RENAME[zoneName][mapID])
      return ZONE_RENAME[zoneName][mapID]
    end
  end
  return zoneName
end

function Overachiever.GetCurrentMapID()
  local prevContinent
  local prevMap, isContinent = GetCurrentMapAreaID()
  local prevLevel = GetCurrentMapDungeonLevel()
  if (not prevMap or prevMap < 0 or isContinent) then
    prevContinent = GetCurrentMapContinent()
  end

  SetMapToCurrentZone()
  local id = GetCurrentMapAreaID()

  if (prevContinent) then
    SetMapZoom(prevContinent)
  else
    local level = GetCurrentMapDungeonLevel()
    if (prevMap and (prevMap ~= id or (prevLevel ~= level and prevLevel == 0))) then
      SetMapByID(prevMap)
    end
    if (prevLevel and prevLevel > 0) then
      SetDungeonMapLevel(prevLevel)
    end
  end
  return id
end

----- :Legion
end
