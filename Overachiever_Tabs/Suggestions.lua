
--
--  Overachiever - Tabs: Suggestions.lua
--    by Tuhljin
--
--  If you don't wish to use the suggestions tab, feel free to delete this file or rename it (e.g. to
--  Suggestions_unused.lua). The addon's other features will work regardless.
--

local L = OVERACHIEVER_STRINGS
local GetAchievementInfo = GetAchievementInfo
local GetAchievementCriteriaInfo = Overachiever.GetAchievementCriteriaInfo

-- BFA
local WOW_BFA = select(4, GetBuildInfo()) >= 80000

local LBZ = LibStub("LibBabble-SubZone-3.0"):GetUnstrictLookupTable()
local LBZR = LibStub("LibBabble-SubZone-3.0"):GetReverseLookupTable()
local LBI = LibStub:GetLibrary("LibBabble-Inventory-3.0"):GetLookupTable()
local LBIR = LibStub:GetLibrary("LibBabble-Inventory-3.0"):GetReverseLookupTable()

local RecentReminders = Overachiever.RecentReminders

local suggested = {}
local showHidden, numHidden = false, 0


local function copytab(from, to)
  for k,v in pairs(from) do
    if(type(v) == "table") then
      to[k] = {}
      copytab(v, to[k]);
    else
      to[k] = v;
    end
  end
end


local IsAlliance = UnitFactionGroup("player") == "Alliance"

local COVENANT_IDS = {
}
for i,id in ipairs(C_Covenants.GetCovenantIDs()) do
	local data = C_Covenants.GetCovenantData(id)
	-- We're assuming data.name is localized but data.textureKit is not, so the latter can be used for looking things up.
	COVENANT_IDS[id] = { key = data.textureKit, name = data.name }
	-- Possible textureKit values: "Kyrian", "Venthyr", "NightFae" (note the lack of a space!), or "Necrolord"
end

local function getPlayerCovenant()
  local covID = C_Covenants.GetActiveCovenantID()
	if (covID and covID ~= 0) then
		local cov = COVENANT_IDS[covID]
		assert(cov, "Shadowlands Covenant not found.")
		return cov.key, cov.name
	end
	return false
end

local function isPlayerCovenant(key)
	local covKey, covName = getPlayerCovenant()
	if (covKey == key) then
		return true, covName
	end
	return false
end


local ZONE_RENAME_REV = { -- lookup table so localizations can use their own renames
--	["What we're calling this zone (localized)"] = "The key we're using for this zone",
	[L.SUGGESTIONS_ZONERENAME_DALARAN_NORTHREND] = "Dalaran (Northrend)",
	[L.SUGGESTIONS_ZONERENAME_DALARAN_BROKENISLES] = "Dalaran (Broken Isles)",
	[L.SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_OUTLAND] = "Shadowmoon Valley (Outland)",
	[L.SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_DRAENOR] = "Shadowmoon Valley (Draenor)",
	[L.SUGGESTIONS_ZONERENAME_NAGRAND_OUTLAND] = "Nagrand (Outland)",
	[L.SUGGESTIONS_ZONERENAME_NAGRAND_DRAENOR] = "Nagrand (Draenor)",
	[L.SUGGESTIONS_ZONERENAME_KARAZHAN_LEGION] = "Return to Karazhan",
  [L.SUGGESTIONS_ZONERENAME_COVENANT] = "Covenant",
	[L.SUGGESTIONS_ZONERENAME_COVENANT_KYRIAN] = "Covenant (Kyrian)",
	[L.SUGGESTIONS_ZONERENAME_COVENANT_NECROLORD] = "Covenant (Necrolord)",
	[L.SUGGESTIONS_ZONERENAME_COVENANT_NIGHTFAE] = "Covenant (Night Fae)",
	[L.SUGGESTIONS_ZONERENAME_COVENANT_VENTHYR] = "Covenant (Venthyr)",
}

local ZONE_SPECIAL_REDIR = {
	-- WoD Garrison:
  function(zone, subzone)
		if (C_Garrison.IsOnGarrisonMap()) then
			-- Not perfect (returns false when the map opens to garrison but player is on the very outskirts) but good enough.
			-- Consider combining with using e.g. "Lunarfall" for zone name lookup. (TODO: !! Not sure if that is needed any more. Test.)
			return "Garrison"
		end
	end,
	-- Shadowlands Covenant:
	function(zone, subzone)
		if (zone == "Bastion") then
			local mapID = C_Map.GetBestMapForUnit("player")
			if ((mapID == 1707 or mapID == 1708) and isPlayerCovenant("Kyrian")) then
				return "Covenant (Kyrian)"
			end
    elseif (zone == "Maldraxxus") then
			local mapID = C_Map.GetBestMapForUnit("player")
			if ((mapID == 1698) and isPlayerCovenant("Necrolord")) then -- !! confirm map IDs
				return "Covenant (Necrolord)"
			end
		elseif (zone == "Ardenweald") then
			local mapID = C_Map.GetBestMapForUnit("player")
			if ((mapID == 1701 or mapID == 1702 or mapID == 1703) and isPlayerCovenant("NightFae")) then -- !! confirm map IDs
				return "Covenant (Night Fae)"
			end
    elseif (zone == "Revendreth") then
      local mapID = C_Map.GetBestMapForUnit("player")
      if ((mapID == 1699 or mapID == 1700) and isPlayerCovenant("Venthyr")) then -- !! confirm map IDs
        return "Covenant (Venthyr)"
      end
		end
	end,
}

local function GetZoneSpecialOverride(zone, subzone)
	-- zone and subzone should be the Overachiever Key versions. See ZoneLookup().
  for i,func in ipairs(ZONE_SPECIAL_REDIR) do
		local z, s = func(zone, subzone)
    if (z) then
			if (s) then  return z, s;  end
			return z, subzone
		end
  end
  return zone, subzone
end

local function getFirstAchievementOfSeriesInCategory(id, category)
	local cat
	local ach, last = id, id
	if (not category) then  category = GetAchievementCategory(id);  end
	while (ach) do
		ach = GetPreviousAchievement(ach)
		if (ach) then
			cat = GetAchievementCategory(ach)
			if (cat == category) then  last = ach;  end
		end
	end
	return last
end

local function getSuggestionsFromCategory(category)
	-- Intelligently suggested achievements from a category. Omit those in a series if an earlier achievement in the series is in the same category.
	-- TODO: Make it omit achievements that are requirements for a meta-achievement that's in the same category.
	local tab = {}
	for i=1,GetCategoryNumAchievements(category) do
		local id = GetAchievementInfo(category, i)
		if (not id) then
			-- Absurdly, GetCategoryNumAchievements now seems to be giving the WRONG NUMBER for at least some categories. (Confirmed in WoW 6.2.2. Might have started earlier.)
			-- Consequently, we need to watch for nil IDs and skip them.
		else
			local first = getFirstAchievementOfSeriesInCategory(id, category)
			if (first) then  tab[first] = true;  end
		end
	end
	local ret = {}
	local i = 0
	for id in pairs(tab) do
		i = i + 1
		ret[i] = id
	end
	return ret
end



-- ZONE-SPECIFIC ACHIEVEMENTS
----------------------------------------------------

local ACHID_ZONE_NUMQUESTS
if (IsAlliance) then
  ACHID_ZONE_NUMQUESTS = {
  -- Kalimdor
	["Ashenvale"] = 4925,
	--["Azshara"] = nil,
	["Darkshore"] = 4928,
	["Desolace"] = 4930, -- faction neutral?
	--["Durotar"] = nil,
	["Dustwallow Marsh"] = 4929,
	["Felwood"] = 4931, -- faction neutral
	["Feralas"] = 4932,
	--["Moonglade"] = nil,
	--["Mulgore"] = nil,
	--["Northern Barrens"] = nil,
	["Silithus"] = 4934, -- faction neutral
	["Southern Barrens"] = 4937,
	["Stonetalon Mountains"] = 4936,
	["Tanaris"] = 4935, -- faction neutral
	--["Teldrassil"] = nil,
	["Thousand Needles"] = 4938, -- faction neutral
	["Un'Goro Crater"] = 4939, -- faction neutral
	["Winterspring"] = 4940, -- faction neutral
    -- Burning Crusade:
	--["Azuremyst Isle"] = nil,
	["Bloodmyst Isle"] = 4926,
    -- Cataclysm:
	["Mount Hyjal"] = 4870,
	["Uldum"] = 4872,
  -- Eastern Kingdoms
	["Arathi Highlands"] = 4896, -- faction neutral
	["Badlands"] = 4900, -- faction neutral
	["Blasted Lands"] = 4909, -- faction neutral
	["Burning Steppes"] = 4901, -- faction neutral
	["The Cape of Stranglethorn"] = 4905,
	--["Deadwind Pass"] = nil,
	--["Dun Morogh"] = nil,
	["Duskwood"] = 4903,
	["Eastern Plaguelands"] = 4892, -- faction neutral
	--["Elwynn Forest"] = nil,
	--["Hillsbrad Foothills"] = nil,
	["The Hinterlands"] = 4897, -- faction neutral
	["Loch Modan"] = 4899,
	["Northern Stranglethorn"] = 4906,
	["Redridge Mountains"] = 4902,
	["Searing Gorge"] = 4910, -- faction neutral
	--["Silverpine Forest"] = nil,
	["Swamp of Sorrows"] = 4904, -- faction neutral
	--["Tirisfal Glades"] = nil,
	["Western Plaguelands"] = 4893, -- faction neutral
	["Westfall"] = 4903,
	["Wetlands"] = 4899,
     -- Burning Crusade:
	--["Eversong Woods"] = nil,
	--["Ghostlands"] = nil,
	--["Isle of Quel'Danas"] = nil,
     -- Cataclysm:
	["Twilight Highlands"] = 4873,
	-- Vashj'ir:
	["Vashj'ir"] = 4869,
	["Kelp'thar Forest"] = 4869,
	["Shimmering Expanse"] = 4869,
	["Abyssal Depths"] = 4869,
  -- Outland
	["Blade's Edge Mountains"] = 1193,
	["Zangarmarsh"] = 1190,
	["Netherstorm"] = 1194,
	["Hellfire Peninsula"] = 1189,
	["Terokkar Forest"] = 1191,
	["Shadowmoon Valley (Outland)"] = 1195,
	["Nagrand (Outland)"] = 1192,
  -- Northrend
	["Icecrown"] = 40,
	["Dragonblight"] = 35,
	["Howling Fjord"] = 34,
	["Borean Tundra"] = 33,
	["Sholazar Basin"] = 39,
	["Zul'Drak"] = 36,
	["Grizzly Hills"] = 37,
	["The Storm Peaks"] = 38,
  -- Other (Cataclysm)
	["Deepholm"] = 4871, -- faction neutral
  }
else
  ACHID_ZONE_NUMQUESTS = {
  -- Kalimdor
	["Ashenvale"] = 4976,
	["Azshara"] = 4927,
	--["Darkshore"] = nil,
	["Desolace"] = 4930, -- faction neutral?
	--["Durotar"] = nil,
	["Dustwallow Marsh"] = 4978,
	["Felwood"] = 4931, -- faction neutral
	["Feralas"] = 4979,
	--["Moonglade"] = nil,
	--["Mulgore"] = nil,
	["Northern Barrens"] = 4933,
	["Silithus"] = 4934, -- faction neutral
	["Southern Barrens"] = 4981,
	["Stonetalon Mountains"] = 4980,
	["Tanaris"] = 4935, -- faction neutral
	--["Teldrassil"] = nil,
	["Thousand Needles"] = 4938, -- faction neutral
	["Un'Goro Crater"] = 4939, -- faction neutral
	["Winterspring"] = 4940, -- faction neutral
    -- Burning Crusade:
	--["Azuremyst Isle"] = nil,
	--["Bloodmyst Isle"] = nil,
    -- Cataclysm:
	["Mount Hyjal"] = 4870,
	["Uldum"] = 4872,
  -- Eastern Kingdoms
	["Arathi Highlands"] = 4896, -- faction neutral
	["Badlands"] = 4900, -- faction neutral
	["Blasted Lands"] = 4909, -- faction neutral
	["Burning Steppes"] = 4901, -- faction neutral
	["The Cape of Stranglethorn"] = 4905,
	--["Deadwind Pass"] = nil,
	--["Dun Morogh"] = nil,
	--["Duskwood"] = nil,
	["Eastern Plaguelands"] = 4892, -- faction neutral
	--["Elwynn Forest"] = nil,
	["Hillsbrad Foothills"] = 4895,
	["The Hinterlands"] = 4897, -- faction neutral
	--["Loch Modan"] = nil,
	["Northern Stranglethorn"] = 4906,
	--["Redridge Mountains"] = nil,
	["Searing Gorge"] = 4910, -- faction neutral
	["Silverpine Forest"] = 4894,
	["Swamp of Sorrows"] = 4904, -- faction neutral
	--["Tirisfal Glades"] = nil,
	["Western Plaguelands"] = 4893, -- faction neutral
	--["Westfall"] = nil,
	--["Wetlands"] = nil,
     -- Burning Crusade:
	--["Eversong Woods"] = nil,
	["Ghostlands"] = 4908,
	--["Isle of Quel'Danas"] = nil,
     -- Cataclysm:
	["Twilight Highlands"] = 5501,
	-- Vashj'ir:
	["Vashj'ir"] = 4982,
	["Kelp'thar Forest"] = 4982,
	["Shimmering Expanse"] = 4982,
	["Abyssal Depths"] = 4982,
  -- Outland
	["Blade's Edge Mountains"] = 1193,
	["Zangarmarsh"] = 1190,
	["Netherstorm"] = 1194,
	["Hellfire Peninsula"] = 1271,
	["Terokkar Forest"] = 1272,
	["Shadowmoon Valley (Outland)"] = 1195,
	["Nagrand (Outland)"] = 1273,
  -- Northrend
	["Icecrown"] = 40,
	["Dragonblight"] = 1359,
	["Howling Fjord"] = 1356,
	["Borean Tundra"] = 1358,
	["Sholazar Basin"] = 39,
	["Zul'Drak"] = 36,
	["Grizzly Hills"] = 1357,
	["The Storm Peaks"] = 38,
  -- Other (Cataclysm)
	["Deepholm"] = 4871, -- faction neutral
  }
end

local achDarkmoonFaire = {
	6019, 6021, 6023, 6027, 6028, 6029, 6032, 6026, 6025, 6022, 6020, IsAlliance and 6030 or 6031, 6332, 9250, 9885, 9894, 9983, 9755, 9756, 9770, 9786, 9780, 9793, 9800, 9806, 9812, 9819,
	-- Blight Boar concert:
	11918, -- Hey, You're a Rockstar!
	11921, -- Mosh Pit
	11920, -- Perfect Performance
	11919, -- Taking this Show on the Road
}
-- To get base data:
-- 1. /run Overachiever.Debug_GetIDsInCat(15101, true)
-- 2. /reload
-- 3. Look in WTF saved variables for: Overachiever_Settings.Debug_AchIDsInCat
-- Run again on a character of the other faction and compare, then, adjust for the faction-specific ones (e.g. "IsAlliance and 6030 or 6031").
-- But don't just leave it at that; look over them to see if there are any you ought to omit since they're redundant (perhaps because another achievement
-- in the list includes it as a criteria) or otherwise not worth suggesting.

local achDraenorGarrison = {
	IsAlliance and 9564 or 9562, -- Securing Draenor
	IsAlliance and 9491 or 9492, -- The Garrison Campaign

	IsAlliance and 9100 or 9545, -- More Plots
	IsAlliance and 9210 or 9132, -- Garrison Buddies
	IsAlliance and 9928 or 9901, -- Don't Call Me Junior
	IsAlliance and 9828 or 9897, -- Ten Hit Tunes
	8933, -- Staying Regular
	9094, -- Garrison Architect
	9099, -- Time for an Upgrade

	9141, -- A Rare Mission
	9145, -- Treasure Mission Specialist
	9150, -- Exploration Mission Specialist

	-- Invasions:
	9152, -- It's an Invasion!
	9244, -- Invasions Are Better with Friends
	9162, -- Bronze Defender
	9209, -- Master Defender
	9858, -- Master and Commander

	-- Unlock decorations (banners, monuments):
	IsAlliance and 9630 or 9248, -- Defender of Draenor
	IsAlliance and 9631 or 9255, -- Mythic Draenor Raider
	9264, -- Draenor Pet Brawler
	9246, -- Master Draenor Crafter
	9265, -- Master of Apexis
	9388, -- Guild Draenor Dungeon Hero

	-- Unlock blueprints:
	9406, -- Working More Orders (2nd in series; 1st is 9405, "Working Some Orders")
	9463, -- Draenic Pet Battler
	9454, -- Draenic Seed Collector
	9453, -- Draenic Stone Collector
	9462, -- Draenor Angler
	9129, -- Filling the Ranks (3rd in series; 1st is 9110, "Following Up")
	9497, -- Finding Your Waystones
	9487, -- Got My Mind On My Draenor Money
	9565, -- Master Trapper (2nd in series; 1st is 9450, "The Trap Game")
	9526, -- Master of Mounts (2nd in series; 1st is 9538, "Intro to Husbandry")
	9523, -- Patrolling Draenor (2nd in series; 1st is 9146, "Patrol Mission Specialist")
	9468, -- Salvaging Pays Off
	IsAlliance and 9478 or 9477, -- Savage Friends
	9703, -- Stay Awhile and Listen
	9527, -- Terrific Technology
	9495, -- The Bone Collector
	9429, -- Upgrading the Mill

	-- Other building-specific:
	IsAlliance and 9077	-- Choppin' Some Logs
	  or 9080,			-- Choppin' Even More Logs  !! 9077 is both factions but next-in-series is broken Horde-side; it shows the Alliance one. Using 9080 instead is a workaround. Last checked: WoW 8.0.1, build 27178.
	9498, -- Wingman
	IsAlliance and 9738 or 9508, -- Warlord of Draenor
	IsAlliance and 9539 or 9705, -- Advanced Husbandry
	IsAlliance and 9540 or 9706, -- The Stable Master
}
local achDraenorGarrisonShipyard = {
	10177, -- Set Sail! (series)
	10170, -- Seaman
	10164, -- Master of the Seas
	10165, -- Ironsides
	IsAlliance and 10256 or 10258, -- Charting a Course
	10166, -- Naval Mechanics (broken?)
}

-- Achievements common to class halls:
local achClassHall = {
	10994, -- A Glorious Campaign
	11223, -- Legendary Research
	11298, -- A Classy Outfit

	10461, -- Fighting with Style: Classic
	10747, -- Fighting with Style: Upgraded
	10748, -- Fighting with Style: Valorous
	10749, -- Fighting with Style: War-torn
	--11612, -- Fighting with Style: Challenging - now a Feat of Strength
	10852, -- Artifact or Artifiction
	11171, -- Arsenal of Power
	11609, -- Power Unbound
	11144, -- Power Realized

	10706, -- Training the Troops
	11214, -- Many Missions
	11218, -- There's a Boss In There
	11219, -- Need Backup
	11220, -- Roster of Champions
}

-- Battle for Azeroth achievements related to the War Campaign Ship (mission table, war campaign, etc.)
local achWarship = {
	IsAlliance and 12896 or 12867, -- Azeroth at War: The Barrens
	IsAlliance and 12898 or 12869, -- Azeroth at War: After Lordaeron
	IsAlliance and 12899 or 12870, -- Azeroth at War: Kalimdor on Fire
	12872, -- The Dirty Five
	IsAlliance and 13925 or 13924, -- The Fourth War
}

local achBrawlersGuild = {
	IsAlliance and 11558 or 11559, -- The First Rule of Brawler's Guild (series)
	11567, -- You Are Not The Contents Of Your Wallet
	11570, -- Educated Guesser
	11572, -- I Am Thrall's Complete Lack Of Surprise
	11573, -- Rumble Club
}

local achArgus = {
	12101, -- We Came Here For Two Reasons
	12077, -- Adventurer of Argus
	12100, -- Family Fighter
	12084, -- Infused and Abused
	12083, -- Paragon of Argus
}

local ACHID_ZONE_MISC = {
-- Kalimdor
	["Ashenvale"] = "4827:6",	-- "Surveying the Damage"
	["Azshara"] = { 5448, 5546, 5547 },	-- "Glutton for Fiery/Icy/Shadowy Punishment"
	["Darkshore"] = { "4827:4" },	-- "Surveying the Damage"
	["Desolace"] = "4827:8",	-- "Surveying the Damage"
	["Durotar"] = "4827:7",		-- "Surveying the Damage"
	["Molten Front"] = { 5859, 5866, 5867,	-- "Legacy of Leyara", "The Molten Front Offensive", "Flawless Victory", "Fireside Chat", "Master of the Molten Flow",
		5870, 5871, 5872, 5873, 5874, 5879 }, -- "King of the Spider-Hill", "Ready for Raiding II", "Death From Above", "Veteran of the Molten Front"
	["Mount Hyjal"] = { 4959, 5483,		-- "Beware of the 'Unbeatable?' Pterodactyl", "Bounce",
		5859, 5860, 5861, 5862, 5864,	-- "Legacy of Leyara", "The 'Unbeatable?' Pterodactyl: BEATEN.", "The Fiery Lords of Sethria's Roost", "Ludicrous Speed", "Gang War",
		5865, 5868, 5869 },		-- "Have... Have We Met?", "And the Meek Shall Inherit Kalimdor", "Infernal Ambassadors"
	["Southern Barrens"] = "4827:1",	-- "Surveying the Damage"
	["Tanaris"] = "4827:5",		-- "Surveying the Damage"
	["Thousand Needles"] = "4827:9",	-- "Surveying the Damage"
	["Uldum"] = {
		5317,  -- "Help the Bombardier! I'm the Bombardier!"
		4888,  -- "One Hump or Two?"
		4961,  -- "In a Thousand Years Even You Might be Worth Something"
	},
	["Winterspring"] = 5443,	-- "E'ko Madness"
-- Eastern Kingdoms
	["The Cape of Stranglethorn"] =	-- "Master Angler of Azeroth",
		{ 306, 389, 396,	-- "Gurubashi Arena Master", "Gurubashi Arena Grand Master",
		  "4827:2" },		-- "Surveying the Damage"
	["Northern Stranglethorn"] =	-- Need to confirm where these two achievements belong since Cataclysm:
		{ 306, 940 },	-- "Master Angler of Azeroth", "The Green Hills of Stranglethorn"
	["Badlands"] = "4827:3",	-- "Surveying the Damage"
	["Eastern Plaguelands"] = 5442,	-- "Full Caravan"
	--Peacebloom vs. Ghouls achievements unavailable at this time:
	--["Hillsbrad Foothills"] = { 5364, 5365,	-- "Don't Want No Zombies on My Lawn", "Bloom and Doom",
	--			    "4827:13" },	-- "Surveying the Damage"
	["Hillsbrad Foothills"] = "4827:13",	-- "Surveying the Damage"
	["Loch Modan"] = "4827:12",		-- "Surveying the Damage"
	["Silverpine Forest"] = "4827:10",	-- "Surveying the Damage"
	["Tol Barad"] = { 4874, IsAlliance and 5489 or 5490,	-- "Breaking out of Tol Barad", "Master of Tol Barad"
			  IsAlliance and 5718 or 5719 },	-- "Just Another Day in Tol Barad"
	["Tol Barad Peninsula"] = IsAlliance and 5718 or 5719,	-- "Just Another Day in Tol Barad"
	["Twilight Highlands"] = { 5451, 4960,	-- "Consumed by Nightmare", "Round Three. Fight!",
				   "4958:3" },	-- "The First Rule of Ring of Blood is You Don't Talk About Ring of Blood"
	["Westfall"] = "4827:11",	-- "Surveying the Damage"
	-- Vashj'ir:
	["Vashj'ir"] = { 4975, 5452,		-- "From Hell's Heart I Stab at Thee", "Visions of Vashj'ir Past"
			 IsAlliance and 5318 or 5319 },	-- "20,000 Leagues Under the Sea"
	["Kelp'thar Forest"] = { 4975, 5452,	-- "From Hell's Heart I Stab at Thee", "Visions of Vashj'ir Past"
			 IsAlliance and 5318 or 5319 },	-- "20,000 Leagues Under the Sea"
	["Shimmering Expanse"] = { 4975, 5452,	-- "From Hell's Heart I Stab at Thee", "Visions of Vashj'ir Past"
			 IsAlliance and 5318 or 5319 },	-- "20,000 Leagues Under the Sea"
	["Abyssal Depths"] = { 4975, 5452,	-- "From Hell's Heart I Stab at Thee", "Visions of Vashj'ir Past"
			 IsAlliance and 5318 or 5319 },	-- "20,000 Leagues Under the Sea"
-- Outland
	["Blade's Edge Mountains"] = 1276,	-- "Blade's Edge Bomberman"
	["Nagrand (Outland)"] = { 939, "1576:1" },	-- "Hills Like White Elekk", "Of Blood and Anguish" -- RENAMED ZONE
	["Netherstorm"] = 545,		-- "Shave and a Haircut"
	["Shadowmoon Valley (Outland)"] = {}, -- RENAMED ZONE
	["Shattrath City"] =	-- "My Sack is "Gigantique"", "Old Man Barlowned", "Kickin' It Up a Notch",
		{ 1165, 905, 906, 903,  },	-- "Shattrath Divided"
	["Terokkar Forest"] = { 905, 1275 },	-- "Old Man Barlowned", "Bombs Away"
	["Zangarmarsh"] = 893,		-- "Cenarion War Hippogryph"
-- Northrend
	["Borean Tundra"] = 561,	-- "D.E.H.T.A's Little P.I.T.A."
	["Dragonblight"] = {
		1277, -- Rapid Defense
		547, -- Veteran of the Wrathgate
		SUBZONES = {
			["Wyrmrest Temple"] = 11941 -- Chromie Homie (for "The Deaths of Chromie" scenario)
		}
	},
	["Dalaran (Northrend)"] = { 2096, 1956, 1958, 545, 1998, IsAlliance and 1782 or 1783, 3217 }, -- RENAMED ZONE
	["Grizzly Hills"] = { "1596:1" },	-- "Guru of Drakuru"
	["Icecrown"] = { SUBZONES = {
		["*Argent Tournament Grounds*The Ring of Champions*Argent Pavilion*The Argent Valiants' Ring*The Aspirants' Ring*The Alliance Valiants' Ring*Silver Covenant Pavilion*Sunreaver Pavilion*The Horde Valiants' Ring*"] =
			{ 2756, 2772, 2836, 2773, 3736 },
		-- "Argent Aspiration", "Tilted!", "Lance a Lot", "It's Just a Flesh Wound", "Pony Up!"
	} },
	["The Storm Peaks"] = 1428,	-- "Mine Sweeper"
	["Sholazar Basin"] =		-- "The Snows of Northrend", "Honorary Frenzyheart",
		{ 938, 961, 962, 952 },	-- "Savior of the Oracles", "Mercenary of Sholazar"
	["Zul'Drak"] = { "1576:2", "1596:2" },	-- "Of Blood and Anguish", "Guru of Drakuru"
	["Wintergrasp"] = { 1752, 2199, 1717, 1751, 1755, 1727, 1723 },
-- Darkmoon Faire
	["Darkmoon Island"] = achDarkmoonFaire,
	["Darkmoon Faire"] = achDarkmoonFaire,
	-- !! - not 100% certain which is needed; may be both; test when the faire's available
-- Other Cataclysm-related
	["Deepholm"] = { 5445, 5446, 5447, 5449 },	-- "Fungalophobia", "The Glop Family Line",
							-- "My Very Own Broodmother", "Rock Lover"
-- Pandaria
	["The Jade Forest"] = {
		IsAlliance and 6300 or 6534, -- Upjade Complete
		6550, -- Order of the Cloud Serpent
		7289, -- Shadow Hopper
		7290, -- How To Strain Your Dragon
		7291, -- In a Trail of Smoke
		7381, -- Restore Balance
	},
	["Krasarang Wilds"] = {
		IsAlliance and 6535 or 6536, -- Mighty Roamin' Krasaranger
		6547, -- The Anglers
		7518, -- Wanderers, Dreamers, and You
	},
	["Kun-Lai Summit"] = {
		6480, -- Settle Down, Bro
		IsAlliance and 6537 or 6538, -- Slum It in the Summit
		7386, -- Grand Expedition Yak
	},
	["Valley of the Four Winds"] = {
		6301, -- Rally the Valley
		6544, -- The Tillers
		6551, -- Friend on the Farm
		7292, -- Green Acres
		7293, -- Till the Break of Dawn
		7294, -- A Taste of Things to Come
		7295, -- Listen to the Drunk Fish
		7325, -- Now I'm the Master
		7502, -- Savior of Stoneplow
		6517, -- Extinction Event
	},
	["Townlong Steppes"] = {
		6539, -- One Steppe Foward, Two Steppes Back
		7299, -- Loner and a Rebel
	},
	["Dread Wastes"] = {
		6540, -- Dread Haste Makes Dread Waste
		6545, -- Klaxxi
		7312, -- Amber is the Color of My Energy
		7313, -- Stay Klaxxi
		7314, -- Test Drive
	},
	["Vale of Eternal Blossoms"] = {
		6546, -- The Golden Lotus
		7317, -- One Many Army
		7318, -- A Taste of History
		--7315 "Eternally in the Vale" is now a Feat of Strength
		7322, -- Roll Club
	},
	["Isle of Thunder"] = 8121, -- "Stormbreaker"
	["Timeless Isle"] = {
		8715, 8726, 8725, 8728, 8712, 8723, 8533, 8724, 8730, 8717
	},
-- Draenor
	["Ashran"] = {
		9102, -- Ashran Victory
		IsAlliance and 9104 or 9103, -- Bounty Hunter
		9105, -- Tour of Duty
		9106, -- Just for Me
		9216, -- High-value Targets
		IsAlliance and 9408 or 9217, -- Operation Counterattack
		IsAlliance and 9225 or 9224, -- Take Them Out
		9218, -- Grand Theft, 1st Degree
		9222, -- Divide and Conquer
		IsAlliance and 9256 or 9257, -- Rescue Operation
		IsAlliance and 9214 or 9215, -- Hero of Stormshield / Hero of Warspear
		IsAlliance and 9714 or 9715, -- Thy Kingdom Come
	},
	["Frostfire Ridge"] = {
		SUBZONES = {
			-- !! haven't tested these subzones
			["Bloodmaul Stronghold"] = { 9533, 9534, IsAlliance and 9530 or 9531 },
			["*Magnarok*Altar of Kron*Ascent of Frostfire*Refuse Pit*"] = { 9537, 9536, 9535 },
			["Iron Siegeworks"] = { 9710, 9711 }
		},
	},
	["Gorgrond"] = {
		IsAlliance and 8923 or 8924,
		9607, -- Make It a Bonus
		9400, -- Gorgrond Monster Hunter
		9401, -- Shredder Maniac
		9402, -- Prove Your Strength
		9423, -- Goliaths of Gorgrond
		SUBZONES = {
			--!! untested if subzone detection works properly for this one
			["Everbloom Wilds"] = { 9663, 9678, 9667, 9654, 9658 },
			["The Pit"] = { 9655, 9656, 9659 }
		},
	},
	["Nagrand (Draenor)"] = { -- RENAMED ZONE
		IsAlliance and 8927 or 8928, -- Nagrandeur
		IsAlliance and 9539 or 9705, -- Advanced Husbandry
		IsAlliance and 9540 or 9706, -- The Stable Master
		9615, -- With a Nagrand Cherry On Top
		SUBZONES = {
			-- !! haven't tested these subzones
			["Broken Precipice"] = { 9571, 9610 },
			["Mok'gol Watchpost"] = { 9548, 9541 },
			["Gorian Proving Grounds"] = 9617,
		},
	},
	["Spires of Arak"] = {
		IsAlliance and 8925 or 8926, -- Between Arak and a Hard Place
		9605, -- Arak Star
		9425, -- So Grossly Incandescent
		SUBZONES = {
			-- !! haven't tested these subzones
			["Skettis Ruins"] = { 9612, 9613 },
			["Lost Veil Anzu"] = { 9600, 9601 },
			["Pillars of Fate"] = { 9433, 9434, 9432 }, -- !! subzone might be "Shadowmoon Enclave" instead and/or might be in Shadowmoon Valley (or maybe need to cover both)
		},
	},
	["Shadowmoon Valley (Draenor)"] = { -- RENAMED ZONE
		SUBZONES = {
			-- !! haven't tested these subzones
			["*Darktide Roost*Darktide Strait*"] = { 9481, 9483, 9479 },
			["Socrethar's Rise"] = { 9437, 9436, 9435 },
		},
	},
	["Talador"] = {
		IsAlliance and 8920 or 8919, -- Don't Let the Tala-door Hit You on the Way Out
		9674, -- I Want More Talador
		SUBZONES = {
			["Shattrath City"] = { 9486, 9632, 9633, 9634, 9635, 9636, 9637, 9638 } -- !! haven't checked whether these all belong to this subzone (or multiple subzones? Harbor, City)
		},
	},
	["Tanaan Jungle"] = {
		10261, -- Jungle Treasure Hunter
		10259, -- Jungle Hunter
		10069, -- I Came, I Clawed, I Conquered
		10061, -- Hellbane
		IsAlliance and 10067 or 10074, -- In Pursuit of Gul'dan
		IsAlliance and 10068 or 10075, -- Draenor's Last Stand
		10071, -- The Legion Will NOT Conquer All
		IsAlliance and 10072 or 10265, -- Rumble in the Jungle (complete the above, and any in same series as one of the above, and the explore achievement)
		10052, -- Tiny Terrors in Tanaan
		IsAlliance and 10350 or 10349, -- Tanaan Diplomat
		--10334, -- Predator - Feat of Strength
	},
	["Garrison"] = achDraenorGarrison,
-- Legion
	["Azsuna"] = {
		11261, -- Adventurer of Azsuna
		10763, -- Azsuna Matata
		11175, -- Higher Dimensional Learning
		"11186:1", -- Tehd & Marius' Excellent Adventure
		11256, -- Treasures of Azsuna
		"11544:1", -- Defender of the Broken Isles
	},
	["Val'sharah"] = {
		11262, -- Adventurer of Val'sharah
		"11186:4", -- Tehd & Marius' Excellent Adventure
		10698, -- That's Val'sharah Folks!
		11258, -- Treasures of Val'sharah
		"11544:4", -- Defender of the Broken Isles
	},
	["Highmountain"] = {
		11264, -- Adventurer of Highmountain
		10059, -- Ain't No Mountain High Enough
		"11186:3", -- Tehd & Marius' Excellent Adventure
		11257, -- Treasures of Highmountain
		10774, -- Hatchling of the Talon
		--10398, -- "Drum Circle" - shows as red for some reason, both factions; comment out for now
		"11544:2", -- Defender of the Broken Isles
	},
	["Stormheim"] = {
		11263, -- Adventurer of Stormheim
		10627, -- Going Up
		"11186:2", -- Tehd & Marius' Excellent Adventure
		11259, -- Treasures of Stormheim
		10790, -- Vrykul Story, Bro
		10793, -- What a Ripoff!
		--11232, -- Lock, Stock and Two Smoking Goblins (starts in Dalaran which is available after "What a Ripoff!")
		"11544:3", -- Defender of the Broken Isles
	},
	["Suramar"] = {
		11265, -- Adventurer of Suramar
		11124, -- Good Suramaritan
		10756, -- Leyline Bling
		10617, -- Nightfallen But Not Forgotten
		11125, -- Now You're Thinking With Portals
		11260, -- Treasures of Suramar
		10778, -- The Nightfallen
		11133, -- Why Can't I Hold All This Mana?
		11340, -- Insurrection
	},
	--[[ ["Dalaran Sewers"] = {
		11066, -- Underbelly Tycoon
	}, --]]
	["Dalaran (Broken Isles)"] = { -- RENAMED ZONE
		10722, -- The Wish Remover
		11066, -- Underbelly Tycoon
	},
	["Broken Shore"] = {
		11731, -- A Magic Contribution
		11545, -- Legionfall Commander
		11735, -- Take Command
		11737, -- Disrupting the Nether
		11546, -- Breaching the Tomb
		11802, -- Bringing Home the Beacon
		11846, -- Champions of Legionfall
		11681, -- Crate Expectations
		11841, -- Naxt Victim
		11653, -- Paragon of the Broken Isles
		11786, -- Terrors of the Shore
		11787, -- The Gates of Hell
	},
	["Krokuun"] = achArgus,
	["Mac'Aree"] = achArgus,
	["Antoran Wastes"] = achArgus,
-- Legion: Class Halls
	["Acherus: The Ebon Hold"] = achClassHall, -- Death knight
	["The Fel Hammer"] = achClassHall, -- Demon hunter
	["The Dreamgrove"] = achClassHall, -- Druid
	["Trueshot Lodge"] = achClassHall, -- Hunter
	["Hall of the Guardian"] = achClassHall, -- Mage
	["Temple of Five Dawns"] = achClassHall, -- Monk
	["Sanctum of Light"] = achClassHall, -- Paladin
	["Netherlight Temple"] = achClassHall, -- Priest
	["The Hall of Shadows"] = achClassHall, -- Rogue
	["The Heart of Azeroth"] = achClassHall, -- Shaman
	["Dreadscar Rift"] = achClassHall, -- Warlock
	["Skyhold"] = achClassHall, -- Warrior
-- Battle for Azeroth
	["Drustvar"] = {
		12579, -- Tour of Duty: Drustvar
		12941, -- Adventurer of Drustvar
		12995, -- Treasures of Drustvar
		13064, -- Drust the Facts, Ma'am
		13083, -- Better, Faster, Stronger
		13087, -- Sausage Sampler
		13094, -- Cursed Game Hunter
		Alliance = {
			12497, -- Drust Do It.
			13082, -- Everything Old Is New Again
		},
	},
	["Nazmir"] = {
		12574, -- Tour of Duty: Nazmir
		12588, -- Eat Your Greens
		12771, -- Treasures of Nazmir
		12942, -- Adventurer of Nazmir
		13023, -- It's Really Getting Out of Hand
		13024, -- Carved in Stone, Written in Blood
		13028, -- Hoppin' Sad
		"13029:1", -- Eating Out of the Palm of My Tiny Hand
		13048, -- Life Finds a Way... To Die!  --!! split it up by criteria? (some are in another zone)
		Alliance = {
			13026, -- 7th Legion Spycatcher
		},
		Horde = {
			13021, -- A Most Efficient Apocalypse
			13022, -- Revenge is Best Served Speedily
			11868, -- The Dark Heart of Nazmir
			13025, -- Zandalari Spycatcher
		},
	},
	["Stormsong Valley"] = {
		12578, -- Tour of Duty: Stormsong Valley
		12853, -- Treasures of Stormsong Valley
		12940, -- Adventurer of Stormsong Valley
		13042, -- About To Break
		13045, -- Every Day I'm Truffling
		13046, -- These Hills Sing
		13047, -- Clever Use of Mechanical Explosives
		13051, -- Legends of the Tidesages
		13054, -- Sabertron Assemble
		Alliance = {
			13053, -- Deadliest Cache
			13062, -- Let's Bee Friends
			12496, -- Stormsong and Dance
		},
	},
	["Tiragarde Sound"] = {
		12577, -- Tour of Duty: Tiragarde Sound
		12852, -- Treasures of Tiragarde Sound
		12939, -- Adventurer of Tiragarde Sound
		13050, -- Bless the Rains Down in Freehold
		13057, -- Shanty Raid
		13058, -- Kul Tiran Up the Dance Floor
		Alliance = {
			12473, -- A Sound Plan
			13059, -- Drag Race
			13049, -- The Long Con
			12087, -- The Reining Champion
		},
		Horde = {
			12759, -- Baiting the Enemy
		}
	},
	["Vol'dun"] = {
		12576, -- Tour of Duty: Vol'dun
		12849, -- Treasures of Vol'dun
		12943, -- Adventurer of Vol'dun
		13011, -- Scourge of Zem'lan
		13016, -- Scavenger of the Sands
		13018, -- Dune Rider
		"13029:2", -- Eating Out of the Palm of My Tiny Hand
		Horde = {
			12478, -- Secrets in the Sands
			13009, -- Adept Sandfisher
			13017, -- Champion of the Vulpera
			13041, -- Hungry, Hungry Ranishu
			13014, -- Vorrik's Champion
		},
	},
	["Zuldazar"] = {
		12575, -- Tour of Duty: Zuldazar
		12851, -- Treasures of Zuldazar
		12944, -- Adventurer of Zuldazar
		"13029:3", -- Eating Out of the Palm of My Tiny Hand
		13035, -- By de Power of de Loa!
		13048, -- Life Finds a Way... To Die!  --!! split it up by criteria? (some are in another zone)
		--13037, -- Torcanata -- Not sure what's up with this one. Doesn't show in GUI for either faction right now (BFA pre-patch). Check it out later. !!
		Alliance = {
			12758, -- Baiting the Enemy
		},
		Horde = {
			12480, -- A Bargain of Blood
			13030, -- How to Ptrain Your Pterrordax
			13039, -- Paku'ai
			13038, -- Raptari Rider
			12481, -- The Final Seal
			11861, -- The Throne of Zuldazar
		},
	},
	["Nazjatar"] = {
		13638, -- Undersea Usurper
		13568, -- For Nazjatar!
		13715, -- From The Belly Of The Jelly
		13692, -- Give Me The Biggest Bag You've Got
		13720, -- Supplying the Assassins
		13569, -- Tour of Duty: Nazjatar
	},
	["Mardivas's Laboratory"] = {
		13699, -- Periodic Destruction
	},
	["Mechagon"] = {
		13541, -- Mecha-Done
		13555, -- Junkyard Tinkmaster
		13472, -- Diversed Investments
		13708, -- Most Minis Wins
		13570, -- Tour of Duty: Mechagon
		13489, -- Secret Fish of Mechagon
		13696, -- Scrappy's Best Friend
	},
	["Chamber of Heart"] = {
		13777, -- My Heart Container is Full
		13769, -- Power Up
		13772, -- Essence Essentials
		13994, -- Through the Depths of Visions
		14162, -- Horrific Masquerade
		14165, -- Masked Soliloquy (series to Symphony of Masks)
		14170, -- Thanks For The Mementos (series)
		13998, -- Pure of Heart
	},
	-- !! TODO: add reputation-related achievements for factions tied to BFA zones
-- Shadowlands
	["Bastion"] = {
		14281, -- The Path to Ascension
		14307, -- Adventurer of Bastion
		14311, -- Treasures of Bastion
		14514, -- Tour of Duty: Bastion
		14737, -- What Bastion Remembered - !! tooltips?
		14801, -- Sojourner of Bastion
		14339, -- Shard Labor
		14734, -- Rallying Cry of the Ascended
		14735, -- Flight School Graduate
		14741, -- Aerial Ace
		14762, -- Breaking the Stratus Fear
		14767, -- Count Your Blessings
		14768, -- What is that Melody?
		14335, -- The Ascended
	},
	["Maldraxxus"] = {
		14206, -- Blade of the Primus
		14308, -- Adventurer of Maldraxxus
		14312, -- Treasures of Maldraxxus
		14513, -- Tour of Duty: Maldraxxus
		14634, -- Nine Afterlives - !! tooltips?
		14763, -- Crypt Couture
		14799, -- Sojourner of Maldraxxus
		14802, -- Bloodsport
		14336, -- Undying Army
		14684,
		14748,
		14751,
		14752,
		14833,
	},
	["Ardenweald"] = {
		14164, -- Awaken, Ardenweald
		14309, -- Adventurer of Ardenweald
		14313, -- Treasures of Ardenweald
		14353, -- Ardenweald's a Stage
		14511, -- Tour of Duty: Ardenweald
		14774, -- Ardenweald Gourmand - !! tooltips?
		14779, -- Wild Hunting - !! tooltips okay or need "Adventurer" quest treatment?
		14788, -- Fractured Faerie Tales - !! tooltips?
		14800, -- Sojourner of Ardenweald
		14337, -- The Wild Hunt
		14671, -- Something's Not Quite Right....
    14672, -- A Bit of This, A Bit Of That (world quest)
	},
	["Revendreth"] = {
		13878, -- The Master of Revendreth
		14272, -- Best Bud With Benefits
		14277, -- The Accuser's Avowed
		14310, -- Adventurer of Revendreth
		14314, -- Treasures of Revendreth
		14512, -- Tour of Duty: Revendreth
		14769, -- Bat!
		14770, -- What We Ride in the Shadows - !! tooltips? mobID?
		14771, -- The Afterlife Express - !! tooltips? mobID?
		14798, -- Sojourner of Revendreth
		14338, -- Court of Harvesters
		14772, -- Caught in a Bat Romance
	},
	["The Maw"] = {
		14334, -- Into the Maw
		14656, -- Trading Partners
		14658, -- Soulkeeper's Burden
		14659, -- Handling His Henchmen - !! tooltips okay or need "Adventurer" quest treatment?
		--14660, -- It's About Sending a Message - !! -- THIS IS SEQUEL TO ABOVE. If doing special handling for above, will this work too or should we handle this instead of that?
		14738, -- Hunting Party
		14742, -- Who Sent You?
		14743, -- Deadly Serious - tooltips okay or need "Adventurer" quest treatment?
		--14743, -- Better to Be Lucky Than Dead - !! -- THIS IS SEQUEL TO ABOVE. If doing special handling for above, will this work too or should we handle this instead of that?
		14745, -- Grand Theft Shadehound
		14746, -- Prepare for Trouble!
		14747, -- Make it Double!
		14761, -- Deciphering Death's Intentions - !! tooltips?
		14894, -- To 'Ghast, Two Curios
		15107, -- Conquering Korthia
		15054, -- Minions of the Cold Dark
		15000, -- United Front
		14943, -- Guarmageddon
		15044, -- Krrprripripkraak's Heroes
		15042, -- Tea for the Troubled
		15039, -- Up For Grabs
		15036, -- Rooting Out the Evil
		15035, -- On the Offensive
		15034, -- Wings Against the Flames
		15033, -- Taking the Tremaculum
		15032, -- Breaking Their Hold
		15037, -- This Army
		15041, -- The Zovaal Shuffle
		15042, -- Tea for the Troubled
		15001, -- Jailer's Personal Stash
		15043, -- Hoarder of Torghast
		14961, -- Chains of Domination
		15064, -- Breaking the Chains
		15004, -- A Sly Fox
	},
	["Korthia"] = { 
		15107, -- Conquering Korthia
		15066, -- Reliquary Restoration
		15057, -- Friend of Plaguey
		15055, -- Friend of Ooz
		15056, -- Friend of Bloop
		14961, -- Chains of Domination
		15064, -- Breaking the Chains
	},
	["Covenant (Kyrian)"] = {
		14851, -- Bastion of Protection
		14852, -- The Hoot of the Issue
		14853, -- All The Colors of the Painbow
		14854, -- It's Not What You Wear
		14856, -- Charmed, I'm Sure
		14857, -- Itsy Bitsy Fighters
		14858, -- Curse of Thirst
		14859, -- Inside the Park Home Run
		14860, -- Bare Necessities
		14861, -- Learning from the Masters
		14862, -- It's How You Wear It
		14863, -- Death Foursworn
		14864, -- Personal Nightmare
		14865, -- Disciple of Humility
		14866, -- Master of the Path
		-- !! check these. any issues? any in a series?
	},
	["Covenant (Necrolord)"] = {
		14764,  -- The Great Luckydo
		14752,  -- Things To Do When You're Dead
		-- All of these are part of 14752:
		--14684,  -- Abominable Lives
		--14748,  -- Wardrobe Makeover
		--14751,  -- The Gang's All Here
		--14753,  -- It's a Wrap
		-- !! check these. any issues? any in a series?
	},
	["Covenant (Night Fae)"] = {
		14670,  -- That's the Spirit
		14675,  -- Spirit Talker
		14676,  -- Divine Spirit Savior
		14677,  -- Spiritual Observations
		14780,  -- Meditation Master
		14789,  -- All Spirits Great and Small
		14775,  -- Mush Appreciated
		-- !! check these. any issues? any in a series?
	},
	["Covenant (Venthyr)"] = {
		14682,  -- The Party Herald
		-- All of these are part of 14682:
		--14680,  -- Something for Everyone
		--14679,  -- Party Palace
		--14678,  -- Court Favors
		--14723,  -- Be Our Guest
		--14724,  -- People Pleaser
		--14725,  -- We Happy Few
		--14681,  -- Dredger Academy
		--14683,  -- Dredger Style
		--14726,  -- It's Certainly Never Boring
		--14727,  -- Master of Ceremonies
		-- !! check these. any issues?
	},
  ["Torghast, Tower of the Damned"] = {
    SUBZONES = {
      --["The Runecarver's Oubliette"] = 14759, -- !! Currently redunant with the other Torghast grouping that uses getSuggestionsFromCategory. May want to add feature to narrow things down so it doesn't show the others in this subzone (but check case by case; might be more to put here).
    }
  },
}
-- Make some subzones / quasi-subzones show suggestions from the main zone - !! not perfect as it won't tie in Explore achievements! TODO - maybe new system, use map IDs.
ACHID_ZONE_MISC["Thunder Totem"] = ACHID_ZONE_MISC["Highmountain"]
ACHID_ZONE_MISC["Darkhaven"] = ACHID_ZONE_MISC["Revendreth"]
ACHID_ZONE_MISC["The Eternal Terrace Lift"] = ACHID_ZONE_MISC["Revendreth"]

if (IsAlliance) then
  tinsert(ACHID_ZONE_MISC["Grizzly Hills"], 2016) -- "Grizzled Veteran"
  tinsert(ACHID_ZONE_MISC["Wintergrasp"], 1737) -- "Destruction Derby"
  --Currently a Feat of Strength but this may be a bug as I've seen reports that you can still get one. Then
  --again, maybe since it was much more difficult to get one previously, a FoS is meant to recognize that:
  --tinsert(ACHID_ZONE_MISC["Winterspring"], 3356) -- "Winterspring Frostsaber"
  tinsert(ACHID_ZONE_MISC["Twilight Highlands"], 5320) -- "King of the Mountain"
  tinsert(ACHID_ZONE_MISC["Twilight Highlands"], 5481) -- "Wildhammer Tour of Duty"
  tinsert(ACHID_ZONE_MISC["Darkshore"], 5453) -- "Ghosts in the Dark"
  -- As applicable, "City Defender", "Shave and a Haircut", "Fish or Cut Bait: <City>", "Let's Do Lunch: <City>":
  ACHID_ZONE_MISC["Stormwind City"] = { 388, 545, 5476, 5474 }
  ACHID_ZONE_MISC["Ironforge"] = { 388, 545, 5847, 5841 }
  ACHID_ZONE_MISC["Darnassus"] = { 388, 5848, 5842 }
  ACHID_ZONE_MISC["The Exodar"] = { 388 }
  -- "Wrath of the Alliance", faction leader kill, "For The Alliance!":
  ACHID_ZONE_MISC["Orgrimmar"] = { 604, 610, 614 }
  ACHID_ZONE_MISC["Thunder Bluff"] = { 604, 611, 614 }
  ACHID_ZONE_MISC["Undercity"] = { 604, 612, 614 }
  ACHID_ZONE_MISC["Silvermoon City"] = { 604, 613, 614 }
  -- "A Silver Confidant", "Champion of the Alliance":
  tinsert(ACHID_ZONE_MISC["Icecrown"], 3676)
  tinsert(ACHID_ZONE_MISC["Icecrown"], 2782)
  -- "Down Goes Van Rook" (there is no Horde equivalent, apparently)
  tinsert(ACHID_ZONE_MISC["Ashran"], 9228)

  tinsert(ACHID_ZONE_MISC["Shadowmoon Valley (Draenor)"], 8845) -- "As I Walk Through the Valley of the Shadow of Moon"
  tinsert(ACHID_ZONE_MISC["Shadowmoon Valley (Draenor)"], 9528) -- "On the Shadow's Trail"
  tinsert(ACHID_ZONE_MISC["Shadowmoon Valley (Draenor)"], 9602) -- "Shoot For the Moon"
  ACHID_ZONE_MISC["Lunarfall"] = achDraenorGarrison
  ACHID_ZONE_MISC["Shadowmoon Valley (Draenor)"].SUBZONES["Lunarfall Shipyard"] = achDraenorGarrisonShipyard

  ACHID_ZONE_MISC["Wind's Redemption"] = achWarship

  ACHID_ZONE_MISC["Deeprun Tram"] = { SUBZONES = { ["Bizmo's Brawlpub"] = achBrawlersGuild } }

else
  tinsert(ACHID_ZONE_MISC["Azshara"], 5454) -- "Joy Ride"
  tinsert(ACHID_ZONE_MISC["Grizzly Hills"], 2017) -- "Grizzled Veteran"
  tinsert(ACHID_ZONE_MISC["Wintergrasp"], 2476)	-- "Destruction Derby"
  tinsert(ACHID_ZONE_MISC["Twilight Highlands"], 5482) -- "Dragonmaw Tour of Duty"
  tinsert(ACHID_ZONE_MISC["Twilight Highlands"], 5321) -- "King of the Mountain"
  -- As applicable, "City Defender", "Shave and a Haircut", "Fish or Cut Bait: <City>", "Let's Do Lunch: <City>":
  ACHID_ZONE_MISC["Orgrimmar"] = { 1006, 545, 5477, 5475 }
  ACHID_ZONE_MISC["Thunder Bluff"] = { 1006, 5849, 5843 }
  ACHID_ZONE_MISC["Undercity"] = { 1006, 545, 5850, 5844 }
  ACHID_ZONE_MISC["Silvermoon City"] = { 1006 }
  -- "Wrath of the Horde", faction leader kill, "For The Horde!":
  ACHID_ZONE_MISC["Stormwind City"] = { 603, 615, 619 }
  ACHID_ZONE_MISC["Ironforge"] = { 603, 616, 619 }
  ACHID_ZONE_MISC["Darnassus"] = { 603, 617, 619 }
  ACHID_ZONE_MISC["The Exodar"] = { 603, 618, 619 }
  -- "The Sunreavers", "Champion of the Horde":
  tinsert(ACHID_ZONE_MISC["Icecrown"], 3677)
  tinsert(ACHID_ZONE_MISC["Icecrown"], 2788)

  tinsert(ACHID_ZONE_MISC["Frostfire Ridge"], 8671) -- "You'll Get Caught Up in The... Frostfire!"
  tinsert(ACHID_ZONE_MISC["Frostfire Ridge"], 9606) -- "Frostfire Fridge"
  tinsert(ACHID_ZONE_MISC["Frostfire Ridge"], 9529) -- "On the Shadow's Trail"

  ACHID_ZONE_MISC["Frostwall"] = achDraenorGarrison -- !! name not 100% verified (have to run Horde char around outskirts of their garrison, refreshing suggestions, to test)
  ACHID_ZONE_MISC["Frostfire Ridge"].SUBZONES["Frostwall Shipyard"] = achDraenorGarrisonShipyard

  ACHID_ZONE_MISC["The Banshee's Wail"] = achWarship

  ACHID_ZONE_MISC["Brawl'gar Arena"] = achBrawlersGuild

end
-- "The Fishing Diplomat":
tinsert(ACHID_ZONE_MISC["Stormwind City"], "150:2")
tinsert(ACHID_ZONE_MISC["Orgrimmar"], "150:1")
-- "Old Crafty" and "Old Ironjaw":
tinsert(ACHID_ZONE_MISC["Orgrimmar"], 1836)
tinsert(ACHID_ZONE_MISC["Ironforge"], 1837)
-- "Big City Pet Brawlin' - Alliance":
tinsert(ACHID_ZONE_MISC["Stormwind City"], "6584:1")
tinsert(ACHID_ZONE_MISC["Ironforge"], "6584:2")
tinsert(ACHID_ZONE_MISC["Darnassus"], "6584:3")
tinsert(ACHID_ZONE_MISC["The Exodar"], "6584:4")
-- "Big City Pet Brawlin' - Horde":
tinsert(ACHID_ZONE_MISC["Orgrimmar"], "6621:1")
tinsert(ACHID_ZONE_MISC["Thunder Bluff"], "6621:2")
tinsert(ACHID_ZONE_MISC["Undercity"], "6621:3")
tinsert(ACHID_ZONE_MISC["Silvermoon City"], "6621:4")

do
	local function mergelist(from, to)
		for k,v in pairs(from) do
			tinsert(to, v)
		end
	end

	-- Black Empire Assaults (Battle for Azeroth 8.3):
	local blackEmpireAssault = {
		14160, -- Rare to Well Done
		14159, -- Combating the Corruption
		14158, -- It's Not A Tumor!
		14161, -- All Consuming
	}
	local blackEmpireAssaultUldum = {
		14153, -- Uldum Under Assault
		14155, -- Uldum Accord
	}
	local blackEmpireAssaultVale = {
		14154, -- Defend the Vale
		14156, -- The Rajani
	}
	mergelist(blackEmpireAssault, ACHID_ZONE_MISC["Uldum"])
	mergelist(blackEmpireAssaultUldum, ACHID_ZONE_MISC["Uldum"])
	mergelist(blackEmpireAssault, ACHID_ZONE_MISC["Vale of Eternal Blossoms"])
	mergelist(blackEmpireAssaultVale, ACHID_ZONE_MISC["Vale of Eternal Blossoms"])

	-- Covenant sanctum achievements common to all Shadowlands covenants:
	local covSanctum = {
		14627, -- Choosing Your Purpose
		14834, -- Bound with Purpose
		14835, -- A Resolute Bond
		14836, -- Unwavering Bond
		14837, -- Nexus of Bonds
		14628, -- The Road to Renown
		14632, -- Conducting Anima
		14633, -- Master Navigator
		14636, -- Adventurer in Chief
		14839, -- Bound to Adventure
		14840, -- Adventures: Learning the Ropes
		14843, -- Adventures: Harmony of Purpose
		14844, -- Adventures: Into the Breach
		14845, -- Adventures: A Step in the Right Direction
		14637, -- Your Covenant's Flavor
		14638, -- The Anima Must Flow
		14639, -- Dedication to the Restoration
		14777, -- Restoration Expert
	}
	mergelist(covSanctum, ACHID_ZONE_MISC["Covenant (Kyrian)"])
	mergelist(covSanctum, ACHID_ZONE_MISC["Covenant (Necrolord)"])
	mergelist(covSanctum, ACHID_ZONE_MISC["Covenant (Night Fae)"])
	mergelist(covSanctum, ACHID_ZONE_MISC["Covenant (Venthyr)"])

  local covKey = getPlayerCovenant()
  if (covKey == "Kyrian") then
    ACHID_ZONE_MISC["Covenant"] = ACHID_ZONE_MISC["Covenant (Kyrian)"]
  elseif (covKey == "Necrolord") then
    ACHID_ZONE_MISC["Covenant"] = ACHID_ZONE_MISC["Covenant (Necrolord)"]
  elseif (covKey == "NightFae") then
    ACHID_ZONE_MISC["Covenant"] = ACHID_ZONE_MISC["Covenant (Night Fae)"]
  elseif (covKey == "Venthyr") then
    ACHID_ZONE_MISC["Covenant"] = ACHID_ZONE_MISC["Covenant (Venthyr)"]
  end
end

-- Alias:
ACHID_ZONE_MISC["City of Ironforge"] = ACHID_ZONE_MISC["Ironforge"]
ACHID_ZONE_MISC["Brawler's Guild"] = achBrawlersGuild

-- INSTANCES - ANY DIFFICULTY (any group size):
local ACHID_INSTANCES = {
-- Classic Dungeons
	["Ragefire Chasm"] = 629,
	["Wailing Caverns"] = 630,
	["Blackfathom Deeps"] = 632,
	["Stormwind Stockade"] = 633,		-- previously called "The Stockade"
	["Gnomeregan"] = 634,
	["Razorfen Kraul"] = 635,
	["Razorfen Downs"] = 636,
	["Uldaman"] = 638,
	["Zul'Farrak"] = 639,
	["Maraudon"] = 640,
	["Sunken Temple"] = 641,
	["Blackrock Depths"] = 642,
	["Lower Blackrock Spire"] = 643,
	--!! unavailable after Warlords of Draenor patch?-- ["Upper Blackrock Spire"] = { 1307, 2188 },	-- "Upper Blackrock Spire", "Leeeeeeeeeeeeeroy!"
	["Dire Maul"] = 644,
	["Stratholme"] = 646,
-- Classic Raids
	-- These are now Feats of Strength: ["Zul'Gurub"] = { 688, 560, 957 },	-- "Zul'Gurub", "Deadliest Catch", "Hero of the Zandalar"
	["Ruins of Ahn'Qiraj"] = 689,
	--["Onyxia's Lair"] = 684, -- This is now a Feat of Strength
	["The Molten Core"] = {
		686, 955,
		11741, -- So Hot Right Now
	},
	["Blackwing Lair"] = {
		685, -- Blackwing Lair (defeat Nefarion)
		11742, -- Dress in Lairs
	},
	["Temple of Ahn'Qiraj"] = {
		687, -- Temple of Ahn'Qiraj (defeat C'thun)
		11743, -- Accessor-Eyes
	},
	["Ahn'Qiraj Temple"] = 687,
-- Burning Crusade
	["Auchenai Crypts"] = 666,
	["The Mechanar"] = 658,
	-- This is now a Feat of Strength: ["Zul'Aman"] = 691,
	["The Blood Furnace"] = 648,
	["Hellfire Ramparts"] = 647,
	["Mana-Tombs"] = 651,
	["The Botanica"] = 659,
	["Shadow Labyrinth"] = 654,
	["Sunwell Plateau"] = {
		698, -- Sunwell Plateau (defeat Kil'jaeden)
		11749, -- Suns Out, Thori'dals Out
	},
	["Black Temple"] = {
		697, -- The Black Temple (defeat Illidan Stormrage)
		11748, -- Black is the New Black
		11869, -- I'll Hold These For You Until You Get Out (timewalking)
	},
	["Hyjal Summit"] = 695,			-- "The Battle for Mount Hyjal"
	["Tempest Keep"] = {
		696,
		11747, -- Merely a Set  (!! - zone name "The Eye"?)
	},
	["Sethekk Halls"] = 653,
	["Old Hillsbrad Foothills"] = 652,	-- "The Escape From Durnholde"
	["The Black Morass"] = 655,		-- "Opening of the Dark Portal"
	["Magtheridon's Lair"] = {
		693,
		11746, -- Outlandish Style
	},
	["Gruul's Lair"] = {
		692,
		11746, -- Outlandish Style
	},
	["Karazhan"] = {
		690,
		11746, -- Outlandish Style
	},
	["The Steamvault"] = 656,
	["Serpentshrine Cavern"] = {
		694, 144,	-- "Serpentshrine Cavern", "The Lurker Above"
		11747, -- Merely a Set
	},
	["The Shattered Halls"] = 657,
	["The Slave Pens"] = 649,
	["The Underbog"] = 650,			-- "Underbog"
	["Magisters' Terrace"] = 661,		-- "Magister's Terrace"
	["The Arcatraz"] = 660,
-- Lich King Dungeons
	["The Culling of Stratholme"] = 479,
	["Utgarde Keep"] = 477,
	["Drak'Tharon Keep"] = 482,
	["Gundrak"] = 484,
	["Ahn'kahet: The Old Kingdom"] = 481,
	["Halls of Stone"] = 485,
	["Utgarde Pinnacle"] = 488,
	["The Oculus"] = 487,
	["Halls of Lightning"] = 486,
	["The Nexus"] = 478,
	["The Violet Hold"] = 483,
	["Azjol-Nerub"] = 480,
	["Trial of the Champion"] = {
		IsAlliance and 4296 or 3778,
		11752, -- Style of the Crusader
	},
	["The Forge of Souls"] = 4516,
	["Halls of Reflection"] = 4518,
	["Pit of Saron"] = 4517,
-- Lich King Raids
	--["Naxxramas"] = 11744, -- Drop Dead, Gorgeous (feat of strength - for old Naxxramas, not WotLK, though gear obtainable from black market AH)
	["Naxxramas"] = 11750, -- Undying Aesthetic
	["Icecrown Citadel"] = 11753, -- Winter Catalog
	["Ulduar"] = {
		11751, -- Mogg-Saron
		12401, -- Glory of the Ulduar Raider
		12311, -- Secrets of Ulduar
		SUBZONES = {
			--["*Formation Grounds*The Colossal Forge*Razorscale's Aerie*The Scrapyard*"] = 12297, -- Siege
			["Formation Grounds"] = { 12312, 12313, 12314, 12315, 12316, 12317 },
			["Razorscale's Aerie"] = { 12321, 12322 },
			["The Colossal Forge"] = { 12323, 12324, 12325 },
			["The Scrapyard"] = { 12326, 12327, 12328, 12329, 12330 },

			--["*The Assembly of Iron*The Shattered Walkway*The Observation Ring*"] = 12302, -- Antechamber
			["The Assembly of Iron"] = { 12332, 12333, 12334, 12335, 12336 },
			["The Shattered Walkway"] = { 12337, 12338, 12339, 12340 },
			["The Observation Ring"] = { 12341, 12342 },

			--["*The Spark of Imagination*The Conservatory of Life*The Clash of Thunder*The Halls of Winter*"] = 12309, -- Keepers
			["The Halls of Winter"] = { 12343, 12344, 12345, 12347, 12346 },
			["The Clash of Thunder"] = { 12348, 12349, 12350, 12351 },
			["The Conservatory of Life"] = { 12360, 12361, 12362, 12363, 12364 },
			["The Spark of Imagination"] = { 12367, 12368, 12369 },

			--["*The Descent into Madness*The Prison of Yogg-Saron*"] = 12310, -- Descent
			["The Descent into Madness"] = { 12372, 12373 },
			["The Prison of Yogg-Saron"] = { 12384, 12385, 12395, 12396, 12397, 12398 },

			["The Celestial Planetarium"] = { 12399, 12400 }, -- Alganon
		},
	},

-- Cataclysm Dungeons
	-- Heroic only, but these dungeons are heroic only so it may as well always show up if suggesting for the zone:
	["Zul'Aman"] = { 5769, 5858, 5760, 5761, 5750 },  -- "Heroic: Zul'Aman", "Bear-ly Made It", "Ring Out!", "Hex Mix", "Tunnel Vision"
	["Zul'Gurub"] = { 5768, 5765, 5743, 5762, 5759, 5744 },  -- "Heroic: Zul'Gurub", "Here, Kitty Kitty...", "It's Not Easy Being Green", "Ohganot So Fast!", "Spirit Twister", "Gurubashi Headhunter"
-- Cataclysm Raids
	["Blackwing Descent"] = 11754, -- Glamour of Twilight -- !! add others for this raid!
	["The Bastion of Twilight"] = 11754, -- Glamour of Twilight -- !! add others for this raid! and confirm "The" in name.
	["Firelands"] = {
		5802, 5828, 5855, -- "Firelands", "Glory of the Firelands Raider", "Ragnar-O's"
		11755, -- Hot Couture
	},
	["Dragon Soul"] = {
		6169, -- Glory of the Dragon Soul Raider
		6175,
		6106,
		6107,
		6177,
		11756, -- Wardrobe of the Old Gods
	},

-- Pandaria Dungeons
	["Gate of the Setting Sun"] = 6945, -- "Mantid Swarm"
	["Stormstout Brewery"] = { 6400, 6402 }, -- "How Did He Get Up There?", "Ling-Ting's Herbal Journey"
	["Scarlet Monastery"] = 6946, -- "Empowered Spiritualist"
-- Pandaria Raids
	["Heart of Fear"] = {
		6718, 6845, 6936, 6518, 6683, 6553, 6937, 6922, -- "The Dread Approach", "Nightmare of Shek'zeer", "Candle in the Wind", "I Heard You Like Amber...", "Less Than Three", "Like An Arrow to the Face", "Overzealous", "Timing is Everything"
		11757, -- Sha of Fabulous
	},
	["Mogu'shan Vaults"] = { 6458, 6844, 6674, 6687, 6823, 6455, 7056, 6686 }, -- "Guardians of Mogu'shan", "The Vault of Mysteries", "Anything You Can Do, I Can Do Better...", "Getting Hot in Here", "Must Love Dogs", "Show Me Your Moves!", "Sorry, Were You Looking for This?", "Straight Six"
	["Terrace of Endless Spring"] = {
		6689, 6824, 6717, 6825, 6933, -- "Terrace of Endless Spring", "Face Clutchers", "Power Overwhelming", "The Mind-Killer", "Who's Got Two Green Thumbs?"
		11757, -- Sha of Fabulous
	},
	["Throne of Thunder"] = {
		8070, 8071, 8069, 8072, -- "Forgotten Depths", "Halls of Flesh-Shaping", "Last Stand of the Zandalari", "Pinnacle of Storms"
		8037, 8087, 8090, 8094, 8073, 8082, 8098, 8081, 8086, -- "Genetically Unmodified Organism", "Can't Touch This", "A Complete Circuit", "Lightning Overload", "Cage Match", "Head Case", "You Said Crossing the Streams Was Bad", "Ritualist Who?", "From Dusk 'til Dawn"
		-- 8089 "I Thought He Was Supposed to Be Hard?" is now a Feat of Strength
		11758, -- Thunderwear
	},
	["Siege of Orgrimmar"] = {
		8454, 8458, 8459, 8461, 8462, -- "Glory of the Orgrimmar Raider", "Vale of Eternal Sorrows", "Gates of Retribution", "The Underhold", "Downfall"
		IsAlliance and 8679 or 8680, -- "Conqueror of Orgrimmar" or "Liberator of Orgrimmar"
		11759, -- Yaass'shaarj
	},

-- Draenor Dungeons
-- !! not 100% sure on these zone names
	["Auchindoun"] = 9039,
	["Bloodmaul Slag Mines"] = 9037,
	["Grimrail Depot"] = 9043,
	["Iron Docks"] = 9038,
	["Shadowmoon Burial Grounds"] = 9041,
	["Skyreach"] = 8843,
	["The Everbloom"] = 9044,
	["Upper Blackrock Spire"] = 9042,
-- Draenor Raids
	["Highmaul"] = { 8975, 8987, 8958, 8948, 8947, 8988, 8977, 8974, 8976, 8986 },
	["Blackrock Foundry"] = {
		8978, 8979, 8930, 8980, 8929, 8983, 8981, 8982, 8984, 8952, 8989, 8990, 8991, 8992,
		11740, -- Make it W-orc W-orc
	},
	["Hellfire Citadel"] = {
		10026, 10057, 10013, 9972, 9979, 9988, 10086, 9989, 10012, 10087, 10030, 10073, 10023, 10024, 10025, 10020, 10019,
		11631, -- Extreme Makeover: Fel Edition
	},

-- Legion Dungeons
	["Eye of Azshara"] = 10780, -- "Eye of Azshara" (chain)
	["Darkheart Thicket"] = 10783,
	["Halls of Valor"] = 10786,
	["Neltharion's Lair"] = {
		10996, -- Got to Ketchum All
		10795, -- "Neltharion's Lair" (chain)
	},
	["Assault on Violet Hold"] = 10798,
	["Vault of the Wardens"] = 10801,
	["Black Rook Hold"] = {
		10709, -- You Used to Scrawl Me In Your Fel Tome
		10804, -- "Black Rook Hold" (chain)
	},
	["Maw of Souls"] = 10807,
	["Return to Karazhan"] = { -- RENAMED ZONE.  !! Double check
		11429, -- Return to Karazhan
		11433, -- Burn After Reading
		11338, -- Dine and Bash
		11430, -- One Night in Karazhan
		11432, -- Scared Straight
		11335, -- Season Tickets
	},
	["Cathedral of Eternal Night"] = 11700,
-- Legion Raids
	["The Emerald Nightmare"] = {
		10555, -- Buggy Fight
		10663, -- Imagined Dragons World Tour
		10753, -- Scare Bear
		10755, -- I Attack the Darkness
		10771, -- Webbing Crashers
		10772, -- Use the Force(s)
		10818, -- Darkbough
		10819, -- Tormented Guardians
		10820, -- Rift of Aln
		10830, -- Took the Red Eye Down
	},
	["The Nighthold"] = {
		10575, -- Burning Bridges
		10678, -- Cage Rematch
		10696, -- I've Got My Eyes On You
		10697, -- Grand Opening
		10699, -- Infinitesimal
		10704, -- Not For You
		10742, -- Gluten Free
		10754, -- Fruit of All Evil
		10817, -- A Change In Scenery
		10829, -- Arcing Aqueducts
		10837, -- Royal Athenaeum
		10838, -- Nightspire
		10839, -- Betrayer's Rise
		10851, -- Elementalry!
		11628, -- That's So Last Millenium
	},
	["Trial of Valor"] = { -- !! double check this zone name
		11394, -- Trial of Valor (series)
		11386, -- Boneafide Tri Tip
		11377, -- Patient Zero
		11762, -- Can I Get A Helya
	},
	["Tomb of Sargeras"] = {
		11763, -- Glory of the Tomb Raider
		11789, -- Chamber of the Avatar
		11790, -- Deceiver's Fall
		11760, -- Retro Trend
		11788, -- Wailing Halls
	},
	["Antorus, the Burning Throne"] = {
		11987, -- Glory of the Argus Raider
		12020, -- Argussy Up
		11989, -- Forbidden Descent
		11990, -- Hope's End
		11988, -- Light's Breach
		11991, -- Seat of the Pantheon
	},

-- Legion Scenarios
	["The Deaths of Chromie"] = 11941, -- Chromie Homie

-- Battle for Azeroth Dungeons
	["Freehold"] = 12831, -- Freehold (series: normal -> heroic -> mythic guild run)
	["Shrine of the Storm"] = 12835, -- Shrine of the Storm (series)
	["Waycrest Manor"] = 12483, -- Waycrest Manor (series)
	["Tol Dagor"] = 12840, -- Tol Dagor (series)
	["Siege of Boralus"] = 12847, -- Siege of Boralus
	["Atal'Dazar"] = 12824, -- Atal'Dazar (series)
	["The MOTHERLODE!!"] = 12844, -- The MOTHERLODE!! (series)
	["The Underrot"] = 12500, -- The Underrot (series)
	["Temple of Sethraliss"] = 12504, -- The Temple of Sethraliss (series)
	["Kings' Rest"] = 12848, -- Kings' Rest
-- Battle for Azeroth Raids
	["Uldir"] = {
		12806,
		12521,
		12522,
		12523,
	},
  ["Battle of Dazar'alor"] = {
		13315,
		13385,
		Alliance = {
			13287,
			13288,
			13286,
		},
		Horde = {
			13289,
			13290,
			13291,
		},
	},
	["Crucible of Storms"] = {
		13501,
		13414,
		13506,
	},
	["The Eternal Palace"] = {
		13687, -- Glory of the Eternal Raider
		13719, -- Depths of the Devoted
		13725, -- The Circle of Stars
		13718, -- The Grand Reception
		13571, -- Under the Seams
	},
	["Ny'alotha, the Waking City"] = {
		14146,
		14058,
		14157,
		14193,
		14194,
		14195,
		14196,
	},

-- Battle for Azeroth Warfronts
	["Battle for Stromgarde"] = {
		IsAlliance and 12888 or 12877, -- Strike Hard -> Strike Fast
		IsAlliance and 12881 or 12873, -- War is Hell
		12874, -- An Eventful Battle
		IsAlliance and 12886 or 12879, -- Tour of War
		IsAlliance and 12884 or 12878, -- Leader of Troops
		-- Heroic:
		IsAlliance and 13737 or 13735, -- Heroic: War is Hell
		IsAlliance and 13739 or 13738, -- Heroic: Tour of War
	},
	["Battle for Darkshore"] = {
		IsAlliance and 13297 or 13296, -- War for the Shore
		13310, -- By Nature's Call
		13308, -- Recruitment Officer
		13302, -- Under Cover of Darkness
		-- Heroic:
		IsAlliance and 14150 or 14149, -- Heroic: War for the Shore
	},

-- Shadowlands Dungeons / Torghast
	["Torghast, Tower of the Damned"] = getSuggestionsFromCategory(15440),
-- Shadowlands Raids
	["Castle Nathria"] = {
		14293,
		14294,
		14355,
		14376,
		14523,
		14524,
		14525,
		14608,
		14610,
		14614,
		14617,
		14619,
		14715,
		14717,
		14718,
	},
	["Sanctum of Domination"] = {
		14998,
		15003,
		15058,
		15065,
		15105,
		15108,
		15110,
		15122,
		15123,
		15124,
		15125,
		15126,
		15127,
		15128,
		15130,
		15131,
		15132,
		15133,
	},
}
-- Aliases
ACHID_INSTANCES["Molten Core"] = ACHID_INSTANCES["The Molten Core"]
--ACHID_INSTANCES["Hall of Blackhand"] = ACHID_INSTANCES["Upper Blackrock Spire"]
ACHID_INSTANCES["Violet Hold"] = ACHID_INSTANCES["Assault on Violet Hold"]
ACHID_INSTANCES[IsAlliance and "Warfronts Stromgarde - Alliance" or "Warfronts Stromgarde - Horde"] = ACHID_INSTANCES["Battle for Stromgarde"]
ACHID_INSTANCES[IsAlliance and "Warfronts Darkshore - Alliance" or "Warfronts Darkshore - Horde"] = ACHID_INSTANCES["Battle for Darkshore"]

-- Battlegrounds
ACHID_INSTANCES["The Battle for Gilneas"] = 5258
ACHID_INSTANCES["Eye of the Storm"] = { 1171, 587, 1258, 211 }
ACHID_INSTANCES["Silvershard Mines"] = 7106
ACHID_INSTANCES["Strand of the Ancients"] = 2194
ACHID_INSTANCES["Twin Peaks"] = 5223  -- "Master of Twin Peaks"
ACHID_INSTANCES["Wildhammer Stronghold"] = 5223  -- Also part of Twin Peaks
ACHID_INSTANCES["Dragonmaw Stronghold"] = 5223  -- Also part of Twin Peaks
ACHID_INSTANCES["Temple of Kotmogu"] = 6981 -- "Master of Temple of Kotmogu"
ACHID_INSTANCES["Deepwind Gorge"] = { 8360, 14175 } -- "Master of Deepwind Gorge" (two with same name; second is newer, apparently replaces the first after 8.3's revamp of Deepwind Gorge, but both still show in interface, so... that's weird)
ACHID_INSTANCES["Seething Shore"] = 12412  -- "Master of Seething Shore"
if (IsAlliance) then
	ACHID_INSTANCES["Alterac Valley"] = { 1167, 907, 226 }
	ACHID_INSTANCES["Arathi Basin"] = { 1169, 907 }
	ACHID_INSTANCES["Warsong Gulch"] = { 1172, 1259, 907 }
	ACHID_INSTANCES["Isle of Conquest"] = { 3857, 3845, 3846 }

else
	ACHID_INSTANCES["Alterac Valley"] = { 1167, 714, 226 }
	ACHID_INSTANCES["Arathi Basin"] = { 1169, 714 }
	ACHID_INSTANCES["Warsong Gulch"] = { 1172, 1259, 714 }
	ACHID_INSTANCES["Isle of Conquest"] = { 3957, 3845, 4176 }
end
-- For all battlegrounds:
local ACHID_BATTLEGROUNDS = { 238, 245, IsAlliance and 246 or 1005, 247, 229, 227, 231, 1785 }

-- INSTANCES - NORMAL ONLY (any group size):
local ACHID_INSTANCES_NORMAL = {
-- Classic Dungeons
	["The Deadmines"] = 628,
	["Shadowfang Keep"] = 631,
	["Scarlet Monastery"] = 637,
	["Scholomance"] = 645,
-- Cataclysm Dungeons
	["Lost City of the Tol'vir"] = 4848,
	["Blackrock Caverns"] = 4833,
	["Grim Batol"] = 4840,
	["The Vortex Pinnacle"] = 4847, -- Need to confirm zone name.
	["Halls of Origination"] = 4841,
	["The Stonecore"] = 4846,
	["Throne of the Tides"] = 4839,
-- Pandaria Dungeons
	["Mogu'shan Palace"] = 6755,
	["Shado-Pan Monastery"] = 6469,
	["Stormstout Brewery"] = 6457,
	["Temple of the Jade Serpent"] = 6757,
	["Scarlet Halls"] = 7413,
}

-- INSTANCES - HEROIC ONLY (any group size):
local ACHID_INSTANCES_HEROIC = {
-- Burning Crusade
	["Auchenai Crypts"] = 672,
	["The Blood Furnace"] = 668,
	["The Slave Pens"] = 669,
	["Hellfire Ramparts"] = 667,
	["Mana-Tombs"] = 671,
	["The Underbog"] = 670,			-- "Heroic: Underbog"
	["Old Hillsbrad Foothills"] = 673,	-- "Heroic: The Escape From Durnholde"
	["Magisters' Terrace"] = 682,		-- "Heroic: Magister's Terrace"
	["The Arcatraz"] = 681,
	["The Mechanar"] = 679,
	["The Shattered Halls"] = 678,
	["The Steamvault"] = 677,
	["The Botanica"] = 680,
	["The Black Morass"] = 676,		-- "Heroic: Opening of the Dark Portal"
	["Shadow Labyrinth"] = 675,
	["Sethekk Halls"] = 674,
-- Lich King Dungeons
	["Halls of Stone"] = { 496, 1866, 2154, 2155 },
	["Gundrak"] = { 495, 2040, 2152, 1864, 2058 },
	["Azjol-Nerub"] = { 491, 1860, 1296, 1297 },
	["Halls of Lightning"] = { 497, 2042, 1867, 1834 },
	["Utgarde Keep"] = { 489, 1919 },
	["The Nexus"] = { 490, 2037, 2036, 2150 },
	["Drak'Tharon Keep"] = { 493, 2039, 2057, 2151 },
	["Ahn'kahet: The Old Kingdom"] = { 492, 2056, 1862, 2038 }, --removed: 1861
	["The Oculus"] = { 498, 1868, 1871, 2044, 2045, 2046 },
	["The Violet Hold"] = { 494, 2153, 1865, 2041, 1816 },
	["The Culling of Stratholme"] = { 500, 1872, 1817 },
	["Utgarde Pinnacle"] = { 499, 1873, 2043, 2156, 2157 },
	["Trial of the Champion"] = { IsAlliance and 4298 or 4297, 3802, 3803, 3804 },
	["The Forge of Souls"] = { 4519, 4522, 4523 },
	["Halls of Reflection"] = { 4521, 4526 },
	["Pit of Saron"] = { 4520, 4524, 4525 },
-- Cataclysm Dungeons
	["Lost City of the Tol'vir"] = { 5291, 5292, 5066, 5290 },
	["Blackrock Caverns"] = { 5282, 5284, 5281, 5060, 5283 },
	["Shadowfang Keep"] = { 5505, 5093, 5503, 5504 },
	["Grim Batol"] = { 5298, 5062, 5297 },
	["The Vortex Pinnacle"] = { 5289, 5064, 5288 },
	["Halls of Origination"] = { 5296, 5065, 5293, 5294, 5295 },
	["The Deadmines"] = { 5083, 5370, 5369, 5368, 5367, 5366, 5371 },
	["The Stonecore"] = { 5063, 5287 },
	["Throne of the Tides"] = { 5061, 5285, 5286 },
-- Cataclysm Raids
	["Dragon Soul"] = { 6115, 6116, },
-- Pandaria Dungeons
	["Gate of the Setting Sun"] = { 6759, 6479, 6476 },
	["Mogu'shan Palace"] = { 6478, 6756, 6713, 6736 },
	["Shado-Pan Monastery"] = { 6470, 6471, 6477, 6472 },
	["Siege of Niuzao Temple"] = { 6763, 6485, 6822, 6688 },
	["Stormstout Brewery"] = { 6456, 6420, 6089 },
	["Temple of the Jade Serpent"] = { 6758, 6475, 6460, 6671 },
	["Scarlet Halls"] = { 6760, 6684, 6427 },
	["Scarlet Monastery"] = { 6761, 6929, 6928 },
	["Scholomance"] = { 6762, 6531, 6394, 6396, 6821 },
-- Pandaria Raids
	["Heart of Fear"] = { 6729, 6726, 6727, 6730, 6725, 6728 },
	["Mogu'shan Vaults"] = { 6723, 6720, 6722, 6721, 6719, 6724 },
	["Terrace of Endless Spring"] = { 6733, 6731, 6734, 6732 },
	["Throne of Thunder"] = { 8124, 8067 }, -- "Glory of the Thundering Raider", "Heroic: Lei Shen"
	["Siege of Orgrimmar"] = {
		8463, 8465, 8466, 8467, 8468, 8469, 8470, -- "Heroic: Immerseus", "Heroic: Fallen Protectors", "Heroic: Norushen", "Heroic: Sha of Pride", "Heroic: Galakras", "Heroic: Iron Juggernaut", "Heroic: Kor'kron Dark Shaman",
		8471, 8472, 8478, 8479, 8480, 8481, 8482, -- "Heroic: General Nazgrim", "Heroic: Malkorok", "Heroic: Spoils of Pandaria", "Heroic: Thok the Bloodthirsty", "Heroic: Siegecrafter Blackfuse", "Heroic: Paragons of the Klaxxi", "Heroic: Garrosh Hellscream"
	},

-- Draenor Dungeons
	["Auchindoun"] = { 9023, 9551, 9552 },
	["Bloodmaul Slag Mines"] = { 8993, 9005, 9008 },
	["Grimrail Depot"] = { 9024, 9007 },
	["Iron Docks"] = { 9081, 9083, 9082 },
	["Shadowmoon Burial Grounds"] = { 9018, 9025, 9026 },
	["Skyreach"] = { 9033, 9035,9034, 9036 },
	["The Everbloom"] = {
		9493, -- They Burn, Burn, Burn
		9017, -- Water Management
		9223, -- Weed Whacker
	},
	["Upper Blackrock Spire"] = { 9045, 9058, 9056, 9057 },

-- Legion Dungeons
	["Seat of the Triumvirate"] = 12007,
}
-- Aliases
--ACHID_INSTANCES_HEROIC["Hall of Blackhand"] = ACHID_INSTANCES_HEROIC["Upper Blackrock Spire"]

local ACHID_INSTANCES_HEROIC_PLUS = {
-- Draenor Dungeons
	["Auchindoun"] = "9619:3", -- Savage Hero
	["Bloodmaul Slag Mines"] = "9619:1",
	["Grimrail Depot"] = "9619:6",
	["Iron Docks"] = "9619:2",
	["Shadowmoon Burial Grounds"] = "9619:7",
	["Skyreach"] = "9619:4",
	["The Everbloom"] = "9619:5",
	["Upper Blackrock Spire"] = "9619:8",
-- Draenor Raids
	["Highmaul"] = "9619:9",
	["Blackrock Foundry"] = "9619:10",
-- Legion Dungeons
	["Return to Karazhan"] = 11929,
}
-- Aliases
--ACHID_INSTANCES_HEROIC_PLUS["Hall of Blackhand"] = ACHID_INSTANCES_HEROIC_PLUS["Upper Blackrock Spire"]

-- INSTANCES - 10-MAN ONLY (normal or heroic):
local ACHID_INSTANCES_10 = {
-- Lich King Raids
	["Naxxramas"] = { 2146, 576, 578, 572, 1856, 2176, 2178, 2180, 568, 1996, 1997, 1858, 564, 2182, 2184,
		566, 574, 562 }, -- 2187 "The Undying" is now a Feat of Strength
	["Onyxia's Lair"] = { 4396, 4402, 4403, 4404 },
	["The Eye of Eternity"] = { 622, 1874, 2148, 1869 },
	["The Obsidian Sanctum"] = { 1876, 2047, 2049, 2050, 2051, 624 },
	--[[ As of WoW 7.3.5, the 10-man and 25-man version of Ulduar achievements are unobtainable. A single new achievement exists for each, instead.
	["Ulduar"] = { 2957, 2894, -- 2903 "Champion of Ulduar" is now a Feat of Strength
		SUBZONES = {
			--["*Formation Grounds*The Colossal Forge*Razorscale's Aerie*The Scrapyard*"] = 2886, -- Siege
			["Formation Grounds"] = { 3097, 2905, 2907, 2909, 2911, 2913 },
			["Razorscale's Aerie"] = { 2919, 2923 },
			["The Colossal Forge"] = { 2925, 2927, 2930 },
			["The Scrapyard"] = { 2931, 2933, 2934, 2937, 3058 },

			--["*The Assembly of Iron*The Shattered Walkway*The Observation Ring*"] = 2888, -- Antechamber
			["The Assembly of Iron"] = { 2939, 2940, 2941, 2945, 2947 },
			["The Shattered Walkway"] = { 2951, 2953, 2955, 2959 },
			["The Observation Ring"] = { 3006, 3076 },

			--["*The Spark of Imagination*The Conservatory of Life*The Clash of Thunder*The Halls of Winter*"] = 2890, -- Keepers
			["The Halls of Winter"] = { 2961, 2963, 2967, 3182, 2969 },
			["The Clash of Thunder"] = { 2971, 2973, 2975, 2977 },
			["The Conservatory of Life"] = { 2979, 2980, 2985, 2982, 3177 },
			["The Spark of Imagination"] = { 2989, 3138, 3180 },

			--["*The Descent into Madness*The Prison of Yogg-Saron*"] = 2892, -- Descent
			["The Descent into Madness"] = { 2996, 3181 },
			["The Prison of Yogg-Saron"] = { 3009, 3157, 3008, 3012, 3014, 3015 },

			["The Celestial Planetarium"] = { 3036, 3003 }, -- Alganon
			  -- 3004 "He Feeds On Your Tears (10 player)" and 3316 "Herald of the Titans" are now Feats of Strength
		},
	},
	--]]
	["Vault of Archavon"] = { 1722, 3136, 3836, 4016 },
	["Trial of the Crusader"] = { 3917, 3936, 3798, 3799, 3800, 3996, 3797 },
	["Icecrown Citadel"] = { 4580, 4601, 4534, 4538, 4577, 4535, 4536, 4537, 4578, 4581, 4539, 4579, 4582 },
}

-- INSTANCES - 25-MAN ONLY (normal or heroic):
local ACHID_INSTANCES_25 = {
-- Lich King Raids
	["Naxxramas"] = { 579, 565, 577, 575, 2177, 563, 567, 1857, 569, 573, 1859, 2139, 2181, 2183, 2185,
		2147, 2140, 2179 },
		-- made Feats of Strength: 2186
	["Onyxia's Lair"] = { 4397, 4405, 4406, 4407 },
	["The Eye of Eternity"] = { 623, 1875, 1870, 2149 },
	["The Obsidian Sanctum"] = { 625, 2048, 2052, 2053, 2054, 1877 },
	--[[ As of WoW 7.3.5, the 10-man and 25-man version of Ulduar achievements are unobtainable. A single new achievement exists for each, instead.
	["Ulduar"] = { 2958, 2895, -- 2904 "Conqueror of Ulduar" is now a Feat of Strength
		SUBZONES = {
			--["*Formation Grounds*The Colossal Forge*Razorscale's Aerie*The Scrapyard*"] = 2887, -- Siege
			["Formation Grounds"] = { 3098, 2906, 2908, 2910, 2912, 2918 },
			["Razorscale's Aerie"] = { 2921, 2924 },
			["The Colossal Forge"] = { 2926, 2928, 2929 },
			["The Scrapyard"] = { 2932, 2935, 2936, 2938, 3059 },

			--["*The Assembly of Iron*The Shattered Walkway*The Observation Ring*"] = 2889, -- Antechamber
			["The Assembly of Iron"] = { 2942, 2943, 2944, 2946, 2948 },
			["The Shattered Walkway"] = { 2952, 2954, 2956, 2960 },
			["The Observation Ring"] = { 3007, 3077 },

			--["*The Spark of Imagination*The Conservatory of Life*The Clash of Thunder*The Halls of Winter*"] = 2891, -- Keepers
			["The Halls of Winter"] = { 2962, 2965, 2968, 3184, 2970 },
			["The Clash of Thunder"] = { 2972, 2974, 2976, 2978 },
			["The Conservatory of Life"] = { 3118, 2981, 2984, 2983, 3185 },
			["The Spark of Imagination"] = { 3237, 2995, 3189 },

			--["*The Descent into Madness*The Prison of Yogg-Saron*"] = 2893, -- Descent
			["The Descent into Madness"] = { 2997, 3188 },
			["The Prison of Yogg-Saron"] = { 3011, 3161, 3010, 3013, 3017, 3016 },

			["The Celestial Planetarium"] = { 3037, 3002 }, -- Alganon
			  -- 3005 "He Feeds On Your Tears (25 player)" is now a Feat of Strength
		},
	},
	--]]
	["Vault of Archavon"] = { 1721, 3137, 3837, 4017 },
	["Trial of the Crusader"] = { 3916, 3937, 3815, 3816, 3997, 3813 }, -- removed 3814
	["Icecrown Citadel"] = { 4620, 4621, 4610, 4614, 4615, 4611, 4612, 4613, 4616, 4622, 4618, 4619, 4617 },
}

-- INSTANCES - NORMAL 10-MAN ONLY:
local ACHID_INSTANCES_10_NORMAL = {
	["Icecrown Citadel"] = 4532,
	["The Ruby Sanctum"] = { -- !! Need to confirm zone name.
		4817,
		--11669, -- Unholy Determination (added in 7.2. currently unknown if this is obtainable and how; might not be part of the normal instance at all)
	}
}

-- INSTANCES - HEROIC 10-MAN ONLY:
local ACHID_INSTANCES_10_HEROIC = {
	["Trial of the Crusader"] = 3918, -- 3808 "A Tribute to Skill (10 player)" is now a Feat of Strength
	["Icecrown Citadel"] = 4636,
	["The Ruby Sanctum"] = 4818, -- Need to confirm zone name.
-- Cataclysm Raids
	["Firelands"] = 5803,	-- "Heroic: Ragnaros" (can be 10 or 25 apparently but putting it here allows detection that it's a raid when getting Suggestions outside it)
}

-- INSTANCES - NORMAL 25-MAN ONLY:
local ACHID_INSTANCES_25_NORMAL = {
	["Icecrown Citadel"] = 4608,
	["The Ruby Sanctum"] = 4815, -- Need to confirm zone name.
}

-- INSTANCES - HEROIC 25-MAN ONLY:
local ACHID_INSTANCES_25_HEROIC = {
	["Trial of the Crusader"] = { 3812 }, -- 3817 "A Tribute to Skill (25 player)" is now a Feat of Strength
	["Icecrown Citadel"] = 4637,
	["The Ruby Sanctum"] = 4816, -- Need to confirm zone name.
-- Cataclysm Raids
	["Firelands"] = 5803,	-- "Heroic: Ragnaros" (can be 10 or 25 apparently but putting it here allows detection that it's a raid when getting Suggestions outside it)
}

-- INSTANCES - MYTHIC ONLY (any group size):
local ACHID_INSTANCES_MYTHIC = {
-- Draenor Dungeons
	["The Everbloom"] = {
		"9619:5", -- Savage Hero
	},

-- Legion Dungeons
	["Eye of Azshara"] = {
		10456, -- But You Say He's Just a Friend
		10458, -- Ready for Raiding V
		10457, -- Stay Salty
	},
	["Darkheart Thicket"] = {
		10769, -- Burning Down the House
		10766, -- Egg-cellent!
	},
	["Halls of Valor"] = {
		10542, -- I Got What You Mead
		10544, -- Stag Party
		10543, -- Surge Protector
	},
	["Neltharion's Lair"] = 10875, -- Can't Eat Just One
	["Assault on Violet Hold"] = {
		10554, -- I Made a Food!
		10553, -- You're Just Making It WORSE!
	},
	["Vault of the Wardens"] = {
		10707, -- A Specter, Illuminated
		10679, -- I Ain't Even Cold
		10680, -- Who's Afraid of the Dark?
	},
	["Black Rook Hold"] = {
		10711, -- Adds? More Like Bads
		10710, -- Black Rook Moan
	},
	["Maw of Souls"] = {
		10411, -- Helheim Hath No Fury
		10413, -- Instant Karma
		10412, -- Poor Unfortunate Souls
	},
	["The Arcway"] = {
		10773, -- Arcanic Cling
		10775, -- Clean House
		10813, -- Mythic: The Arcway
		10776, -- No Time to Waste
	},
	["Court of Stars"] = {
		10611, -- Dropping Some Eaves
		10816, -- Mythic: Court of Stars
		10610, -- Waiting for Gerdo
	},
	["Cathedral of Eternal Night"] = {
		11769, -- A Steamy Romance Saga
		11768, -- Boom Bloom
		11703, -- Master of Shadows
	},
-- Legion Raids
	["The Emerald Nightmare"] = {
		10821, -- Mythic: Nythendra
		10822, -- Mythic: Elerethe Renferal
		10823, -- Mythic: Il'gynoth
		10824, -- Mythic: Ursoc
		10825, -- Mythic: Dragons of Nightmare
		10826, -- Mythic: Cenarius
		10827, -- Mythic: Xavius
	},
	["The Nighthold"] = {
		10840, -- Mythic: Skorpyron
		10842, -- Mythic: Anomaly
		10843, -- Mythic: Trilliax
		10844, -- Mythic: Aluriel
		10845, -- Mythic: Star Augur Etraeus
		10846, -- Mythic: High Botanist Tel'arn
		10847, -- Mythic: Tichondrius
		10848, -- Mythic: Krosus
		10849, -- Mythic: Grand Magistrix Elisande
		10850, -- Mythic: Gul'dan
	},
	["Trial of Valor"] = { -- !! double check this zone name
		11397, -- Mythic: Guarm
		11398, -- Mythic: Helya
		11396, -- Mythic: Odyn
		--11387, -- The Chosen - now a Feat of Strength
		11337, -- You Runed Everything!
	},
	["Tomb of Sargeras"] = {
		11774, 11780, 11767, 11775, 11781, 11779, 11776, 11777, 11778,
	},
	["Seat of the Triumvirate"] = {
		12008,
		12009,
		12005,
		12004,
	},
	["Antorus, the Burning Throne"] = {
		12001, -- Mythic: Aggramar
		11994, -- Mythic: Antoran High Command
		12002, -- Mythic: Argus the Unmaker
		11996, -- Mythic: Eonar
		11992, -- Mythic: Garothi Worldbreaker
		11993, -- Mythic: Hounds of Sargeras
		11997, -- Mythic: Imonar the Soulhunter
		11998, -- Mythic: Kin'garoth
		11995, -- Mythic: Portal Keeper Hasabel
		12000, -- Mythic: The Coven of Shivarra
		11999, -- Mythic: Varimathras
	},

-- Battle for Azeroth Dungeons
	["Freehold"] = {
		12833, -- Mythic: Freehold
		"13075:1", -- Battle for Azeroth Keymaster
		12548, -- I'm in Charge Now!
		12550, -- Pecking Order
		12998, -- That Sweete Booty
	},
	["Shrine of the Storm"] = {
		12838, -- Mythic: Shrine of the Storm
		"13075:3", -- Battle for Azeroth Keymaster
		12600, -- Breath of the Shrine
		12601, -- The Void Lies Sleeping
		12602, -- Trust No One
	},
	["Waycrest Manor"] = {
		12488, -- Mythic: Waycrest Manor
		"13075:2", -- Battle for Azeroth Keymaster
		12490, -- Alchemical Romance
		12495, -- Run Wild Like a Man On Fire
		12489, -- Losing My Profession
	},
	["Tol Dagor"] = {
		12842, -- Mythic: Tol Dagor
		"13075:7", -- Battle for Azeroth Keymaster
		12457, -- Remix to Ignition
		12462, -- Shot Through the Heart
	},
	["Siege of Boralus"] = {
		"13075:9", -- Battle for Azeroth Keymaster
		12726, -- A Fish Out of Water
		12727, -- Stand By Me
		12489, -- Losing My Profession
	},
	["Atal'Dazar"] = {
		12826, -- Mythic: Atal'Dazar
		"13075:4", -- Battle for Azeroth Keymaster
		12270, -- Bringing Hexy Back
		12272, -- Gold Fever
		12273, -- It's Lit!
	},
	["The MOTHERLODE!!"] = {
		12846, -- Mythic: The MOTHERLODE!!
		"13075:8", -- Battle for Azeroth Keymaster
		12855, -- Pitch Invasion
		12854, -- Ready for Raiding VI
	},
	["The Underrot"] = {
		12502, -- Mythic: Underrot
		"13075:5", -- Battle for Azeroth Keymaster
		12549, -- Not a Fun Guy
		12499, -- Sporely Alive
		12498, -- Taint Nobody Got Time For That
	},
	["Temple of Sethraliss"] = {
		12506, -- Mythic: The Temple of Sethraliss
		"13075:6", -- Battle for Azeroth Keymaster
		12508, -- Good Night, Sweet Prince
		12507, -- Snake Eater
		12503, -- Snake Eyes
	},
	["Kings' Rest"] = {
		"13075:10", -- Battle for Azeroth Keymaster
		12723, -- How to Keep a Mummy
		12721, -- Wrap God
		12722, -- It Belongs in a Mausoleum!
	},
	["Operation: Mechagon"] = { -- !! double check zone name
		13698, -- Clean Up On Aisle Mechagon
		13545, -- Go Ahead, Make My Daisy
		13723, -- M.C., Hammered
		13706, -- Stay Positive
		13789, -- Hertz Locker (unused? going to be a Feat of Strength later? it doesn't show in UI)
		13624, -- Keep DPS-ing and Nobody Explodes
	},
-- Battle for Azeroth Raids
	["Uldir"] = {
		12524,
		12526,
		12527,
		12529,
		12530,
		12531,
		12532,
		12533,
	},
	["Battle of Dazar'alor"] = {
		13292,
		13293,
		IsAlliance and 13298 or 13295, -- "Mythic: Jadefire Masters"
		13300,
		13299,
		13311,
		13312,
		13313,
		13314,
	},
	["Crucible of Storms"] = {
		13416,
		13417,
	},
	["The Eternal Palace"] = {
		13726, -- Mythic: Abyssal Commander Sivara
		13728, -- Mythic: Blackwater Behemoth
		13729, -- Mythic: Lady Ashvane
		13730, -- Mythic: Orgozoa
		13733, -- Mythic: Queen Azshara
		13727, -- Mythic: Radiance of Azshara
		13731, -- Mythic: The Queen's Court
		13732, -- Mythic: Za'qul
	},
	["Ny'alotha, the Waking City"] = {
		14041,
		14043,
		14044,
		14045,
		14046,
		14048,
		14049,
		14050,
		14051,
		14052,
		14054,
		14055,
	},
-- Shadowlands Dungeons
	["De Other Side"] = {
		14354,
		14374,
		14409,
		14606,
	},
	["Halls of Atonement"] = {
		14284,
		14352,
		14411,
		14567,		
	},
	["Mists of Tirna Scithe"] = {
		14291,
		14375,
		14413,
		14503,
	},
	["Plaguefall"] = {
		14292,
		14296,
		14347,
		14415,
	},
	["Sanguine Depths"] = {
		14199,
		14286,
		14289,
		14290,
	},
	["Spires of Ascension"] = {
		14323,
		14325,
		14327,
		14331,
	},
	["Tazavesh, the Veiled Market"] = {
		15106,
		15109,
		15177,
		15178,
		15179,
		15190,
	},
	["The Necrotic Wake"] = {
		14285,
		14295,
		14320,
		14368,
	},
	["Theater of Pain"] = {
		14297,
		14417,
		14533,
		14607,
	},
	
-- Shadowlands Raids
	["Castle Nathria"] = {
		14356,
		14357,
		14358,
		14359,
		14360,
		14361,
		14362,
		14363,
		14364,
		14365,
	},
	["Sanctum of Somination"] = {
		15112,
		15113,
		15114,
		15115,
		15116,
		15117,
		15118,
		15119,
		15120,
		15121,
	},
}


local ACHID_HOLIDAY = {
	["Darkmoon Faire"] = achDarkmoonFaire,
	["Lunar Festival"] = {
		913, -- To Honor One's Elders
		605, -- A Coin of Ancestry
	},
	["Love is in the Air"] = {
		1693, -- Fool For Love
		1694, -- Lovely Luck Is On Your Side
		1700, -- Perma-Peddle
		4624, -- Tough Love
		9389, -- It Might Just Save Your Life
		9394, -- They Really Love Me! (last of series starting with "Love Magnet"; put here directly since it has a reward)
	},
	["Noblegarden"] = {
		2798, -- Noble Gardener
		249, -- Dressed for the Occasion
		248, -- Sunday's Finest
	},
	["Children's Week"] = {
		1793, -- For the Children
		275, -- Veteran Nanny
	},
	["Midsummer Fire Festival"] = {
		IsAlliance and 1038 or 1039, -- "The Flame Warden" or "The Flame Keeper"
		IsAlliance and 1034 or 1036, -- The Fires of Azeroth
		IsAlliance and 8045 or 8044, -- "Flame Warden of Pandaria" or "Flame Keeper of Pandaria"
		IsAlliance and 11283 or 11284, -- "Flame Warden of Draenor" or "Flame Keeper of Draenor"
		IsAlliance and 11280 or 11282, -- "Flame Warden of the Broken Isles" or "Flame Keeper of the Broken Isles"
		IsAlliance and 1035 or 1037, -- "Desecration of the Horde" or "Desecration of the Alliance"
		IsAlliance and 8042 or 8043, -- Extinguishing Pandaria
		IsAlliance and 11276 or 11277, -- Extinguishing Draenor
		IsAlliance and 11278 or 11279, -- Extinguishing the Broken Isles
	},
	["Pirates' Day"] = 3457, -- The Captain's Booty
	["Brewfest"] = {
		1683, -- Brewmaster (includes many other achievements)
		1183, -- Brew of the Year
		IsAlliance and 1184 or 1203, -- Strange Brew
		1260, -- Almost Blind Luck
		293,  -- Disturbing the Peace
	},
	["Hallow's End"] = {
		1656,  -- Hallowed Be Thy Name
		971,   -- Tricks and Treats of Azeroth
		IsAlliance and 5836 or 5835,  -- Tricks and Treats of Northrend
		IsAlliance and 5837 or 5838,  -- Tricks and Treats of the Cataclysm
		IsAlliance and 7601 or 7602,  -- Tricks and Treats of Pandaria
		979,   -- The Mask Task
		284,   -- A Mask for All Occasions
		10365, -- A Frightening Friend
	},
	["Day of the Dead"] = {
		3456, -- Dead Man's Party
		9426, -- To the Afterlife
	},
	["Pilgrim's Bounty"] = {
		3478, -- Pilgrim
		IsAlliance and 3556 or 3557, -- Pilgrim's Paunch
		3558, -- Sharing is Caring
		3559, -- Turkey Lurkey
		IsAlliance and 3576 or 3577, -- Now We're Cookin'
		3578, -- The Turkinator
		3579, -- "FOOD FIGHT!"
		IsAlliance and 3580 or 3581, -- Pilgrim's Peril
		3582, -- Terokkar Turkey Time
		IsAlliance and 3596 or 3597, -- Pilgrim's Progress
	},
	["Feast of Winter Veil"] = {
		1691,  -- Merrymaker
		IsAlliance and 5853 or 5854, -- A-Caroling We Will Go
		1295,  -- Crashin' & Thrashin'
		IsAlliance and 4436 or 4437,  -- BB King
		8699,  -- The Danger Zone
		10353, -- Iron Armada
	},
	-- Aliases:  (since Overachiever.HOLIDAY_REV has these point to a different key, we don't need them to point to a table here)
}
-- Aliases:
ACHID_HOLIDAY["Winter Veil"] = ACHID_HOLIDAY["Feast of Winter Veil"]
ACHID_HOLIDAY["Midsummer"] = ACHID_HOLIDAY["Midsummer Fire Festival"]


-- Create reverse lookup table for L.SUBZONES:
local SUBZONES_REV = {}
for k,v in pairs(L.SUBZONES) do  SUBZONES_REV[v] = k;  end

local function ZoneLookup(zoneName, isSub, subz)
	-- Get Overachiever Key version of zoneName which can be either zone text or subzone text. If it's a subzone, set isSub to true so we use slightly different logic.
	-- subz is a fallback and only makes sense to use when isSub is not true.
	-- Overachiever Key is normally the unlocalized (English) name for a zone/subzone (trimmed if needed), but it can also be a special key that this addon set up, usually for
	-- disambiguation (e.g. "Dalaran (Northrend)" vs "Dalaran (Broken Isles)").
  zoneName = zoneName or subz
	if (not zoneName) then  return nil;  end
  local trimz = strtrim(zoneName)
  local result = isSub and SUBZONES_REV[trimz] or LBZR[trimz] or LBZR[zoneName] or trimz
  if (not isSub) then  result = Overachiever.GetZoneKey(result);  end
  return result
end


-- TRADESKILL ACHIEVEMENTS
----------------------------------------------------

local ACHID_TRADESKILL = {
	["Cooking"] = { 1563, 5845 },	-- "Hail to the Chef", "A Bunch of Lunch"
	["Fishing"] = { 1516, 5478, 5479, 5851 }, -- "Accomplished Angler", "The Limnologist", "The Oceanographer", "Gone Fishin'"
}

local ACHID_TRADESKILL_ZONE = {
	["Cooking"] = {
		["Dalaran"] = { 1998, IsAlliance and 1782 or 1783, 3217, 3296 },
			-- "Dalaran Cooking Award", "Our Daily Bread", "Chasing Marcia", "Cooking with Style"
		["Shattrath City"] = 906	-- "Kickin' It Up a Notch"
        },
	["Fishing"] = {
		["Dalaran"] = { 2096, 1958 },		-- "The Coin Master", "I Smell A Giant Rat"
		["Ironforge"] = { 1837 },		-- "Old Ironjaw"
		["Orgrimmar"] = {1836, "150:1"},	-- "Old Crafty", "The Fishing Diplomat"
		["Serpentshrine Cavern"] = 144,		-- "The Lurker Above"
		["Shattrath City"] = 905,		-- "Old Man Barlowned"
		["Stormwind City"] = { "150:2" },	-- "The Fishing Diplomat"
		["Terokkar Forest"] = { 905, 726 },	-- "Old Man Barlowned", "Mr. Pinchy's Magical Crawdad Box"
		--Feat of Strength: ["Zul'Gurub"] = 560,		-- "Deadliest Catch"

		-- "Master Angler of Azeroth":
		["The Cape of Stranglethorn"] = 306,
		["Northern Stranglethorn"] = 306, -- Need to confirm it belongs in both zones
		["Howling Fjord"] = 306,
		["Grizzly Hills"] = 306,
		["Borean Tundra"] = 306,
		["Sholazar Basin"] = 306,
		["Dragonblight"] = 306,
		["Crystalsong Forest"] = 306,
		["Icecrown"] = 306,
		["Zul'Drak"] = 306,

		["Mechagon"] = 13489, -- "Secret Fish of Mechagon"
	}
}
if (IsAlliance) then
  tinsert(ACHID_TRADESKILL_ZONE["Fishing"]["Stormwind City"], 5476)	-- "Fish or Cut Bait: Stormwind"
  tinsert(ACHID_TRADESKILL_ZONE["Fishing"]["Ironforge"], 5847)		-- "Fish or Cut Bait: Ironforge"
  ACHID_TRADESKILL_ZONE["Fishing"]["Darnassus"] = 5848			-- "Fish or Cut Bait: Darnassus"
  ACHID_TRADESKILL_ZONE["Cooking"]["Stormwind City"] = 5474		-- "Let's Do Lunch: Stormwind"
  ACHID_TRADESKILL_ZONE["Cooking"]["Ironforge"] = 5841			-- "Let's Do Lunch: Ironforge"
  ACHID_TRADESKILL_ZONE["Cooking"]["Darnassus"] = 5842			-- "Let's Do Lunch: Darnassus"
else
  tinsert(ACHID_TRADESKILL_ZONE["Fishing"]["Orgrimmar"], 5477)		-- "Fish or Cut Bait: Orgrimmar"
  ACHID_TRADESKILL_ZONE["Fishing"]["Thunder Bluff"] = 5849		-- "Fish or Cut Bait: Thunder Bluff"
  ACHID_TRADESKILL_ZONE["Fishing"]["Undercity"] = 5850			-- "Fish or Cut Bait: Undercity"
  ACHID_TRADESKILL_ZONE["Cooking"]["Orgrimmar"] = 5475			-- "Let's Do Lunch: Orgrimmar"
  ACHID_TRADESKILL_ZONE["Cooking"]["Thunder Bluff"] = 5843		-- "Let's Do Lunch: Thunder Bluff"
  ACHID_TRADESKILL_ZONE["Cooking"]["Undercity"] = 5844			-- "Let's Do Lunch: Undercity"
end

ACHID_TRADESKILL_ZONE["Fishing"]["City of Ironforge"] = ACHID_TRADESKILL_ZONE["Fishing"]["Ironforge"]

local ACHID_TRADESKILL_BG = { Cooking = 1785 }	-- "Dinner Impossible"



-- SUGGESTIONS TAB CREATION AND HANDLING
----------------------------------------------------

local VARS, VARS_CHAR
local frame, panel, sortdrop
local LocationsList, EditZoneOverride, subzdrop, subzdrop_menu, subzdrop_Update = {}
local diffdrop, raidsizedrop
local RefreshBtn, ResetBtn, NoSuggestionsLabel, ResultsLabel
local ShowHiddenCheckbox

--WHAT = LocationsList

local function SortDrop_OnSelect(self, value)
  VARS.SuggestionsSort = value
  frame.sort = value
  frame:ForceUpdate(true)
end

local function OnLoad(v, ver, vc)
  VARS = v
  VARS_CHAR = vc
  sortdrop:SetSelectedValue(VARS.SuggestionsSort or 0)
end

frame, panel = Overachiever.BuildNewTab("Overachiever_SuggestionsFrame", L.SUGGESTIONS_TAB,
                "Interface\\AddOns\\Overachiever_Tabs\\SuggestionsWatermark", L.SUGGESTIONS_HELP, OnLoad,
                ACHIEVEMENT_FILTER_INCOMPLETE)
frame.AchList_checkprev = true

sortdrop = TjDropDownMenu.CreateDropDown("Overachiever_SuggestionsFrameSortDrop", panel, {
  {
    text = L.TAB_SORT_NAME,
    value = 0
  },
  {
    text = L.TAB_SORT_COMPLETE,
    value = 1
  },
  {
    text = L.TAB_SORT_POINTS,
    value = 2
  },
  {
    text = L.TAB_SORT_ID,
    value = 3
  };
})
sortdrop:SetLabel(L.TAB_SORT, true)
sortdrop:SetPoint("TOPLEFT", panel, "TOPLEFT", -16, -22)
sortdrop:OnSelect(SortDrop_OnSelect)

local CurrentSubzone

local function Refresh_Add(...)
  local id, _, complete, nextid
  local hidden = VARS_CHAR and VARS_CHAR.SuggestionsHidden
  for i=1, select("#", ...) do
    id = select(i, ...)
    if (id) then

      if (type(id) == "table") then
        Refresh_Add(unpack(id))
        if (id.SUBZONES) then
          for subz, subzsuggest in pairs(id.SUBZONES) do
            if (subz == CurrentSubzone or strfind(subz, "*"..CurrentSubzone.."*", 1, true)) then
            -- Asterisks surround subzone names since they aren't used in any actual subzone names.
              Refresh_Add(subzsuggest)
            end
          end
        end
		if (id.Alliance) then
		  if (IsAlliance) then
		    Refresh_Add(unpack(id.Alliance))
		  else
		    id.Alliance = nil
		  end
		end
		if (id.Horde) then
		  if (not IsAlliance) then
		    Refresh_Add(unpack(id.Horde))
		  else
		    id.Horde = nil
		  end
		end

      elseif (type(id) == "string") then
        local crit
        id, crit = strsplit(":", id)
        id, crit = tonumber(id), tonumber(crit)
        if (showHidden or not hidden or not hidden[id]) then
          _, _, _, complete = GetAchievementInfo(id)
          if (complete) then
            nextid, complete = GetNextAchievement(id)
            if (nextid) then
              local name = GetAchievementCriteriaInfo(id, crit)
              while (complete and GetAchievementCriteriaInfo(nextid, crit) == name) do
              -- Find first incomplete achievement in the chain that has this criteria:
                id = nextid
                nextid, complete = GetNextAchievement(id)
              end
              if (nextid and GetAchievementCriteriaInfo(nextid, crit) == name) then
                id = nextid
              end
            end
          end
          suggested[id] = crit
        -- Known limitation (of no consequence at this time due to which suggestions actually use this feature):
        -- If an achievement is suggested due to multiple criteria, only one of them is reflected by this.
        -- (A future fix may involve making it a table when there's more than one, though it would need to check
        -- against adding the same criteria number twice.)
        else
          numHidden = numHidden + 1
        end

      else
        _, _, _, complete = GetAchievementInfo(id)
        if (complete) then
          nextid, complete = GetNextAchievement(id)
          if (nextid) then
            while (complete) do  -- Find first incomplete achievement in the chain:
              id = nextid
              nextid, complete = GetNextAchievement(id)
            end
            id = nextid or id
          end
        end
        if (showHidden or not hidden or not hidden[id]) then
          suggested[id] = true
        else
          numHidden = numHidden + 1
        end
      end

    end
  end
end

local TradeskillSuggestions

local function getOpenTradeskill()
	local _, skillLineDisplayName, parentSkillLineDisplayName
	_, skillLineDisplayName, _, _, _, _, parentSkillLineDisplayName = C_TradeSkillUI.GetTradeSkillLine()
	-- The return of C_TradeSkillUI.GetTradeSkillLine() is inconsistent! skillLineDisplayName may be, say, "Cooking" or it may be "Shadowlands Cooking" -- and when it's "Cooking", parentSkillLineDisplayName isn't given at all.
	-- It seems to be "Cooking" during the reaction to the "TRADE_SKILL_SHOW" event and "Shadowlands Cooking" otherwise.
	return parentSkillLineDisplayName and parentSkillLineDisplayName or skillLineDisplayName
end

local Refresh_lastcount, Refresh_stoploop = 0

local function getLocationSuggestions(retTab, zone, subzone, textoverride, instype, heroicD, heroicR, twentyfive, mythicD, mythicR)
	local prevSuggested
	if (retTab) then
		prevSuggested = {}
		copytab(suggested, prevSuggested)
		wipe(suggested)
	end

	CurrentSubzone = subzone

	if (instype and not textoverride) then  -- If in an instance:
		Refresh_Add(ACHID_INSTANCES[zone])
		if (instype == "pvp") then  -- If in a battleground:
			Refresh_Add(ACHID_BATTLEGROUNDS)
		end

		if (heroicD or heroicR) then
			if (twentyfive) then
				Refresh_Add(ACHID_INSTANCES_HEROIC[zone], ACHID_INSTANCES_HEROIC_PLUS[zone], ACHID_INSTANCES_25[zone], ACHID_INSTANCES_25_HEROIC[zone])
			else
				Refresh_Add(ACHID_INSTANCES_HEROIC[zone], ACHID_INSTANCES_HEROIC_PLUS[zone], ACHID_INSTANCES_10[zone], ACHID_INSTANCES_10_HEROIC[zone])
			end
		else
			if (twentyfive) then
				Refresh_Add(ACHID_INSTANCES_NORMAL[zone], ACHID_INSTANCES_25[zone], ACHID_INSTANCES_25_NORMAL[zone])
			else
				Refresh_Add(ACHID_INSTANCES_NORMAL[zone], ACHID_INSTANCES_10[zone], ACHID_INSTANCES_10_NORMAL[zone])
			end
		end

		if (mythicD or mythicR) then
			Refresh_Add(ACHID_INSTANCES_MYTHIC[zone], ACHID_INSTANCES_HEROIC_PLUS[zone])
			-- No need to check twentyfive; that's a legacy classification and the dungeons/raids with mythic-only achievements don't use it.
		end

	else
		Refresh_Add(Overachiever.ExploreZoneIDLookup(zone), ACHID_ZONE_NUMQUESTS[zone], ACHID_ZONE_MISC[zone])
		-- Also look for instance achievements for an instance you're near if we can look it up easily (since many zones
		-- have subzones with the instance name when you're near the instance entrance and some instance entrances are
		-- actually in their own "zone" using the instance's zone name):
		Refresh_Add(ACHID_INSTANCES[subzone] or ACHID_INSTANCES[zone])

		local ach10, ach25 = ACHID_INSTANCES_10[subzone] or ACHID_INSTANCES_10[zone], ACHID_INSTANCES_25[subzone] or ACHID_INSTANCES_25[zone]
		local achH10, achH25 = ACHID_INSTANCES_10_HEROIC[subzone] or ACHID_INSTANCES_10_HEROIC[zone], ACHID_INSTANCES_25_HEROIC[subzone] or ACHID_INSTANCES_25_HEROIC[zone]
		local achN10, achN25 = ACHID_INSTANCES_10_NORMAL[subzone] or ACHID_INSTANCES_10_NORMAL[zone], ACHID_INSTANCES_25_NORMAL[subzone] or ACHID_INSTANCES_25_NORMAL[zone]

		if (ach10 or ach25 or achH10 or achH25 or achN10 or achN25) then
		-- If there are 10-man or 25-man specific achievements, this is a raid:
			if (heroicR) then
				if (twentyfive) then
					Refresh_Add(ACHID_INSTANCES_HEROIC[subzone] or ACHID_INSTANCES_HEROIC[zone],
					ACHID_INSTANCES_HEROIC_PLUS[subzone] or ACHID_INSTANCES_HEROIC_PLUS[zone],
					ach25, achH25)
				else
					Refresh_Add(ACHID_INSTANCES_HEROIC[subzone] or ACHID_INSTANCES_HEROIC[zone],
					ACHID_INSTANCES_HEROIC_PLUS[subzone] or ACHID_INSTANCES_HEROIC_PLUS[zone],
					ach10, achH10)
				end
			else
				if (twentyfive) then
					Refresh_Add(ACHID_INSTANCES_NORMAL[subzone] or ACHID_INSTANCES_NORMAL[zone], ach25, achN25)
				else
					Refresh_Add(ACHID_INSTANCES_NORMAL[subzone] or ACHID_INSTANCES_NORMAL[zone], ach10, achN10)
				end
			end
		-- Not a raid (or at least no 10-man vs 25-man specific suggestions):
		elseif (heroicD) then
			Refresh_Add(ACHID_INSTANCES_HEROIC[subzone] or ACHID_INSTANCES_HEROIC[zone],
			ACHID_INSTANCES_HEROIC_PLUS[subzone] or ACHID_INSTANCES_HEROIC_PLUS[zone])
		else
			Refresh_Add(ACHID_INSTANCES_NORMAL[subzone] or ACHID_INSTANCES_NORMAL[zone])
		end

		if (mythicD or mythicR) then
			Refresh_Add(ACHID_INSTANCES_MYTHIC[subzone] or ACHID_INSTANCES_MYTHIC[zone],
			ACHID_INSTANCES_HEROIC_PLUS[subzone] or ACHID_INSTANCES_HEROIC_PLUS[zone])
		end
	end

	if (textoverride) then
		Refresh_Add(ACHID_HOLIDAY[zone])
	end

	if (retTab) then
		local tab = {}
		copytab(suggested, tab)
		wipe(suggested)
		copytab(prevSuggested, suggested)
		return tab
	end
end

local function getCurrentLocationSuggestions()
	local zone
	local subzone = ZoneLookup(GetSubZoneText(), true) or ""
	if (IsInInstance()) then
		zone = ZoneLookup(GetInstanceInfo(), nil, subzone) -- No 'or ""' this time.
	end
	if (not zone) then
		zone = ZoneLookup(GetRealZoneText(), nil, subzone) or ""
	end
	zone, subzone = GetZoneSpecialOverride(zone, subzone)

	local textoverride = false
	local instype, heroicD, mythicD, challenge, twentyfive, heroicR, mythicR = Overachiever.GetDifficulty()

	return getLocationSuggestions(true, zone, subzone, textoverride, instype, heroicD, heroicR, twentyfive, mythicD, mythicR)
end

local function Refresh(self, instanceRetry)
  if (not frame:IsVisible() or Refresh_stoploop) then  return;  end
  if (self == RefreshBtn or self == EditZoneOverride) then  PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);  end
  Refresh_stoploop = true

  wipe(suggested)
  EditZoneOverride:ClearFocus()
  CurrentSubzone = ZoneLookup(GetSubZoneText(), true) or ""
  local inputtext = strtrim(EditZoneOverride:GetText())
  local zone = LocationsList[ strlower(inputtext) ]
  local textoverride = false
  local instanceTry
  if (zone) then
    textoverride = true
    zone = LocationsList[zone]
    EditZoneOverride:SetText(zone)
    EditZoneOverride:SetTextColor(1, 1, 1)
    if (self ~= subzdrop) then  subzdrop_Update(zone);  end
    local subz = subzdrop:GetSelectedValue()
    if (subz ~= 0) then
		  CurrentSubzone = SUBZONES_REV[subz] or subz
		end
	elseif (inputtext and inputtext ~= "") then
		zone = ""
		EditZoneOverride:SetTextColor(0.75, 0.1, 0.1)
    subzdrop_Update()
  else
		if (instanceRetry ~= true) then -- check specifically against true because it could be "LeftButton"
			if (IsInInstance()) then
				instanceTry = true
				zone = ZoneLookup(GetInstanceInfo(), nil, CurrentSubzone) or ""
				--zone = "fake place force retry"
			end
		end
    if (not zone) then
		  instanceTry = false
		  zone = ZoneLookup(GetRealZoneText(), nil, CurrentSubzone) or ""
		end
		zone, CurrentSubzone = GetZoneSpecialOverride(zone, CurrentSubzone)
    subzdrop_Update()
  end
  --print(zone)

  local instype, heroicD, mythicD, challenge, twentyfive, heroicR, mythicR = Overachiever.GetDifficulty()

  -- Check for difficulty override:
  local val = diffdrop:GetSelectedValue()
  if (val ~= 0) then
    heroicD = val == 2 and true or false
    heroicR = heroicD
    mythicD = val == 3 and true or false
    mythicR = mythicD
  end
  val = raidsizedrop:GetSelectedValue()
  if (val ~= 0) then
    twentyfive = val == 25 and true or false
  end

  numHidden = 0

  -- Suggestions based on an open tradeskill window or whether a fishing pole is equipped:
  TradeskillSuggestions = getOpenTradeskill()
  local tradeskill = LBIR[TradeskillSuggestions]
  if (not ACHID_TRADESKILL[tradeskill] and IsEquippedItemType(LBI["Fishing Poles"])) then
    TradeskillSuggestions, tradeskill = LBI["Fishing"], "Fishing"
  end
  if (ACHID_TRADESKILL[tradeskill]) then
    Refresh_Add(ACHID_TRADESKILL[tradeskill])
    if (ACHID_TRADESKILL_ZONE[tradeskill]) then
      Refresh_Add(ACHID_TRADESKILL_ZONE[tradeskill][zone])
    end
    if (instype == "pvp") then  -- If in a battleground:
      Refresh_Add(ACHID_TRADESKILL_BG[tradeskill])
    end

  elseif (textoverride and zone == L.SUGGESTIONS_HIDDENLOCATION) then
    if (VARS_CHAR.SuggestionsHidden) then
      for id in pairs(VARS_CHAR.SuggestionsHidden) do
        suggested[id] = true
      end
    end
	elseif (textoverride and zone == L.SUGGESTIONS_AUTOTRACKEDLOCATION) then
		if (VARS.SuggestionsAutoTracking) then
      for id in pairs(VARS.SuggestionsAutoTracking) do
        suggested[id] = true
      end
    end

  else
    TradeskillSuggestions = nil

  -- Suggestions for your location:
    getLocationSuggestions(false, zone, CurrentSubzone, textoverride, instype, heroicD, heroicR, twentyfive, mythicD, mythicR)

  end

  -- Suggestions from recent reminders:
  Overachiever.RecentReminders_Check()
  for id in pairs(RecentReminders) do
    suggested[id] = true
  end

  local list, count = frame.AchList, 0
  wipe(list)
  local critlist = frame.AchList_criteria and wipe(frame.AchList_criteria)
  if (not critlist) then
    critlist = {}
    frame.AchList_criteria = critlist
  end
  for id,v in pairs(suggested) do
    count = count + 1
    list[count] = id
    if (v ~= true) then
      critlist[id] = v
    end
  end

  if (count == 0 and instanceTry) then
    Refresh_stoploop = nil
    return Refresh(nil, true)
  end

  if (self ~= panel or Refresh_lastcount ~= count) then
    Overachiever_SuggestionsFrameContainerScrollBar:SetValue(0)
  end
  frame:ForceUpdate(true)
  Refresh_lastcount = count
  Refresh_stoploop = nil
end

function frame.SetNumListed(num)
  if (num > 0 or numHidden > 0) then
    NoSuggestionsLabel:Hide()
    if (TradeskillSuggestions) then
      if (numHidden > 0) then
        ResultsLabel:SetText(L.SUGGESTIONS_RESULTS_TRADESKILL_HIDDEN:format(TradeskillSuggestions, num, numHidden))
      else
        ResultsLabel:SetText(L.SUGGESTIONS_RESULTS_TRADESKILL:format(TradeskillSuggestions, num))
      end
    else
      if (numHidden > 0) then
        ResultsLabel:SetText(L.SUGGESTIONS_RESULTS_HIDDEN:format(num, numHidden))
      else
        ResultsLabel:SetText(L.SUGGESTIONS_RESULTS:format(num))
      end
    end
  end
  if (num == 0) then
    NoSuggestionsLabel:Show()
    if (TradeskillSuggestions) then
      NoSuggestionsLabel:SetText(L.SUGGESTIONS_EMPTY_TRADESKILL:format(TradeskillSuggestions))
    else
			local inputtext = EditZoneOverride:GetText()
			if (inputtext and inputtext ~= "") then
				NoSuggestionsLabel:SetText(L.SUGGESTIONS_EMPTY_OVERRIDE)
			else
				NoSuggestionsLabel:SetText(L.SUGGESTIONS_EMPTY)
			end
    end
    if (numHidden < 1) then  ResultsLabel:SetText(" ");  end
  end

  local c = #frame.AchList
  local msg
  if (num < c) then
    if (ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrame_GetCategoryNumAchievements_Complete) then
      msg = L.SUGGESTIONS_FILTERED_OUT_INCOMPLETE
    elseif (ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrame_GetCategoryNumAchievements_Incomplete) then
	  msg = L.SUGGESTIONS_FILTERED_OUT_EARNED
	end
  end
  if (msg) then
    frame.frameWarning.label:SetText(msg:format(c - num))
    frame.frameWarning:Show()
  else
    frame.frameWarning:Hide()
  end
end

RefreshBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
RefreshBtn:SetWidth(75); RefreshBtn:SetHeight(21)
--RefreshBtn:SetPoint("TOPLEFT", sortdrop, "BOTTOMLEFT", 16, -14)
RefreshBtn:SetText(L.SUGGESTIONS_REFRESH)
RefreshBtn:SetScript("OnClick", Refresh)

ResultsLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ResultsLabel:SetPoint("TOPLEFT", RefreshBtn, "BOTTOMLEFT", 0, -8)
ResultsLabel:SetWidth(178)
ResultsLabel:SetJustifyH("LEFT")
ResultsLabel:SetText(" ")

panel:SetScript("OnShow", Refresh)

NoSuggestionsLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
NoSuggestionsLabel:SetPoint("TOP", frame, "TOP", 0, -189)
NoSuggestionsLabel:SetText(L.SUGGESTIONS_EMPTY)
NoSuggestionsLabel:SetWidth(490)

frame:RegisterEvent("TRADE_SKILL_SHOW")
frame:RegisterEvent("TRADE_SKILL_CLOSE")
frame:SetScript("OnEvent", Refresh)


ShowHiddenCheckbox = CreateFrame("CheckButton", "Overachiever_SuggestionsFrameShowHiddenCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
--ShowHiddenCheckbox:SetPoint("LEFT", sortdrop, "LEFT", 14, 0); ShowHiddenCheckbox:SetPoint("TOP", BaseLabel, "BOTTOM", 0, -24);
--ShowHiddenCheckbox:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", 0, 2)
ShowHiddenCheckbox:SetPoint("LEFT", sortdrop, "LEFT", 14, 0)
ShowHiddenCheckbox:SetPoint("BOTTOM", panel, "BOTTOM", 0, 0)
Overachiever_SuggestionsFrameShowHiddenCheckboxText:SetText(L.SUGGESTIONS_SHOWHIDDEN)
Overachiever_SuggestionsFrameShowHiddenCheckboxText:SetJustifyH("LEFT")
ShowHiddenCheckbox:SetHitRectInsets(0, -1 * min(Overachiever_SuggestionsFrameShowHiddenCheckboxText:GetWidth() + 8, 155), 0, 0)

ShowHiddenCheckbox:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
  
  GameTooltip:AddLine(L.SUGGESTIONS_SHOWHIDDEN_TIP, nil, nil, nil, 1)
  GameTooltip:AddLine(L.SUGGESTIONS_SHOWHIDDEN_TIP2, nil, nil, nil, 1)
  GameTooltip:Show()
end)
ShowHiddenCheckbox:SetScript("OnLeave", GameTooltip_Hide)
ShowHiddenCheckbox:SetScript("OnClick", function(self)
  if (self:GetChecked()) then
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
    showHidden = true
    Refresh(panel)
  else
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
    showHidden = false
    Refresh(panel)
  end
end)


-- SUPPORT FOR OTHER ADDONS
----------------------------------------------------

-- Open suggestions tables up for other addons to read or manipulate:
Overachiever.SUGGESTIONS = {
	zone_numquests = ACHID_ZONE_NUMQUESTS,
	zone = ACHID_ZONE_MISC,
	--zone_id = ACHID_ZONEID_MISC,
	instance = ACHID_INSTANCES,
	bg = ACHID_BATTLEGROUNDS,
	instance_normal = ACHID_INSTANCES_NORMAL,
	instance_heroic = ACHID_INSTANCES_HEROIC,
	instance_heroic_plus = ACHID_INSTANCES_HEROIC_PLUS,
	instance_10 = ACHID_INSTANCES_10,
	instance_25 = ACHID_INSTANCES_25,
	instance_10_normal = ACHID_INSTANCES_10_NORMAL,
	instance_10_heroic = ACHID_INSTANCES_10_HEROIC,
	instance_25_normal = ACHID_INSTANCES_25_NORMAL,
	instance_25_heroic = ACHID_INSTANCES_25_HEROIC,
	instance_mythic = ACHID_INSTANCES_MYTHIC,
	tradeskill = ACHID_TRADESKILL,
	tradeskill_zone = ACHID_TRADESKILL_ZONE,
	tradeskill_bg = ACHID_TRADESKILL_BG,
	holiday = ACHID_HOLIDAY,
}

-- Remove unneeded faction-specified suggestions:
do
	local function cleanup(tab)
		for k,v in pairs(tab) do
			if ((k == "Alliance" and not IsAlliance) or (k == "Horde" and IsAlliance)) then
				tab[k] = nil
			elseif (type(v) == "table") then
				cleanup(v)
			end
		end
	end
	cleanup(Overachiever.SUGGESTIONS)
end
-- /dump Overachiever.SUGGESTIONS.zone["Vol'dun"]


-- ZONE/INSTANCE OVERRIDE INPUT
----------------------------------------------------

EditZoneOverride = CreateFrame("EditBox", "Overachiever_SuggestionsFrameZoneOverrideEdit", panel, "InputBoxTemplate")
EditZoneOverride:SetWidth(170); EditZoneOverride:SetHeight(16)
EditZoneOverride:SetAutoFocus(false)
EditZoneOverride:SetPoint("TOPLEFT", sortdrop, "BOTTOMLEFT", 22, -19)
do
  local label = EditZoneOverride:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  label:SetPoint("BOTTOMLEFT", EditZoneOverride, "TOPLEFT", -6, 4)
  label:SetText(L.SUGGESTIONS_LOCATION)

  -- CREATE LIST OF VALID LOCATIONS:

  local places = {}

  local function extractNames(list)
    local ZONE_RENAME = Overachiever.ZONE_RENAME
    local INSTANCE_RENAME = Overachiever.INSTANCE_RENAME
		for i,v in ipairs(list) do
			local z = WOW_BFA and v.name or v
			local lz = LBZR[z] or z
			if (not ZONE_RENAME[lz] and not INSTANCE_RENAME[lz]) then  -- Omit zones that we use a different name for so we don't create a confusing autocomplete (e.g. people type "Dalaran" but get no suggestions because we put them somewhere else).
				places[z] = true -- Already localized so no need for LBZ here.
			--else	Overachiever.chatprint("omitting "..z)
			end
		end
  end

  -- Add all zones to the list:
  extractNames(Overachiever.GetZones())
  --extractNames(Overachiever.GetDungeons())

  -- Add instances for which we have suggestions:
  local locallookup = nil
  local function addtolist(list, ...)
    local tab
    for i=1,select("#", ...) do
      tab = select(i, ...)
      for k,v in pairs(tab) do
  	    list[ (locallookup and locallookup[k]) or LBZ[k] or ZONE_RENAME_REV[k] or k ] = true  -- Add localized version of zone/instance names.
    		--print("adding: k = "..(LBZ[k] or k)..(LBZ[k] and "" or "no LBZ[k]"))
    		if (Overachiever_Debug and (not (locallookup and locallookup[k])) and not LBZ[k] and not ZONE_RENAME_REV[k]) then  Overachiever.chatprint("POSSIBLE ERROR - no LBZ lookup found for "..k);  end
  	  end
    end
  end
  addtolist(places, ACHID_INSTANCES, ACHID_INSTANCES_NORMAL, ACHID_INSTANCES_HEROIC, ACHID_INSTANCES_HEROIC_PLUS,
            ACHID_INSTANCES_10, ACHID_INSTANCES_25, ACHID_INSTANCES_10_NORMAL, ACHID_INSTANCES_25_NORMAL,
            ACHID_INSTANCES_10_HEROIC, ACHID_INSTANCES_25_HEROIC, ACHID_INSTANCES_MYTHIC)
  addtolist(places, ACHID_ZONE_MISC); -- Required for "unlisted" zones like Molten Front (doesn't appear in GetMapContinents/GetMapZones scan)
  locallookup = Overachiever.HOLIDAY_REV
  addtolist(places, ACHID_HOLIDAY); -- These aren't actual zones but we want the user to be able to look them up by name.
  locallookup = nil
  addtolist = nil

	-- Additional special "locations":
  places[L.SUGGESTIONS_HIDDENLOCATION] = true  -- Hidden suggestions
	places[L.SUGGESTIONS_AUTOTRACKEDLOCATION] = true  -- Auto-Tracked suggestions

  -- Arrange into alphabetically-sorted array:
  local count = 0
  for k in pairs(places) do
    count = count + 1
    LocationsList[count] = k
	--print("adding "..k)
  end
  places = nil
  sort(LocationsList)
  -- Cross-reference by lowercase key to place in the array:
  for i,v in ipairs(LocationsList) do  LocationsList[strlower(v)] = i;  end
end

EditZoneOverride:SetScript("OnEnterPressed", Refresh)

local function findFirstLocation(text)
  if (strtrim(text) == "") then  return;  end
  local len = strlen(text)
  for i,v in ipairs(LocationsList) do
    if (strsub(strlower(v), 1, len) == text) then  return i, v, len, text;  end
  end
end

EditZoneOverride:SetScript("OnEditFocusGained", function(self)
  self:SetTextColor(1, 1, 1)
  self:HighlightText()
  CloseMenus()
end)

EditZoneOverride:SetScript("OnChar", function(self)
  local i, v, len = findFirstLocation(strlower(self:GetText()))
  if (i) then
    self:SetText(v)
    self:HighlightText(len, strlen(v))
    self:SetCursorPosition(len)
  end
end)

EditZoneOverride:SetScript("OnTabPressed", function(self)
  local text = strlower(self:GetText())
  local text2, len
  if (text == "") then
    text2 = LocationsList[IsShiftKeyDown() and #LocationsList or 1]
    len = 0
  elseif (not LocationsList[text]) then
    len = self:GetUTF8CursorPosition()
    if (len == 0) then
      text2 = LocationsList[IsShiftKeyDown() and #LocationsList or 1]
    else
      text = strsub(text, 1, len)
      if (IsShiftKeyDown()) then
        for i = #LocationsList, 1, -1 do
          if (strsub(strlower(LocationsList[i]), 1, len) == text) then
            text2 = LocationsList[i]
            break;
          end
        end
      else
        local i
        i, text2, len = findFirstLocation(text)
      end
    end
  else
    local i, v
    i, v, len, text = findFirstLocation(text)
    if (i) then
      local pos = self:GetUTF8CursorPosition()
      text = strsub(text, 1, pos)
      len = strlen(text)
      local mod = IsShiftKeyDown() and -1 or 1
      repeat
        i = i + mod
        text2 = LocationsList[i]
        if (not text2) then  i = (mod == 1 and 0) or #LocationsList + 1;  end
      until (text2 and strsub(strlower(text2), 1, pos) == text)
    end
  end
  if (text2) then
    self:SetText(text2)
    self:HighlightText(len, strlen(text2))
    self:SetCursorPosition(len)
  end
end)

EditZoneOverride:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(self, "ANCHOR_NONE");
	GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 4, 32)
  GameTooltip:AddLine(L.SUGGESTIONS_LOCATION_TIP, 1, 1, 1)
  GameTooltip:AddLine(L.SUGGESTIONS_LOCATION_TIP2, nil, nil, nil, 1)
  GameTooltip:Show()
end)

EditZoneOverride:SetScript("OnLeave", function(self)
  GameTooltip:Hide()
end)


subzdrop_menu = {  {  text = L.SUGGESTIONS_LOCATION_NOSUBZONE, value = 0  };  }
subzdrop = TjDropDownMenu.CreateDropDown("Overachiever_SuggestionsFrameSubzoneDrop", panel, subzdrop_menu)
subzdrop:SetLabel(L.SUGGESTIONS_LOCATION_SUBZONE, true)
subzdrop:SetPoint("LEFT", sortdrop, "LEFT")
subzdrop:SetPoint("TOP", EditZoneOverride, "BOTTOM", 0, -21)
subzdrop:SetDropDownWidth(158)
subzdrop:OnSelect(Refresh)

do
  local menu

  local function addtosubzlist(list, key, ...)
    local tab
    for i=1,select("#", ...) do
      tab = select(i, ...)
      tab = tab[key]
      tab = type(tab) == "table" and tab.SUBZONES
      if (tab) then
        for k in pairs(tab) do
          if (strsub(k, 1, 1) == "*") then
            for subz in gmatch(k, "%*?([^%*]+)%*") do  list[ L.SUBZONES[subz] or subz ] = true;  end
          else
            list[ L.SUBZONES[k] or k ] = true
          end
        end
      end
    end
  end

  function subzdrop_Update(zone)
    menu = menu or {}
    if (zone and menu[zone] == nil) then
      local tab = {}
      addtosubzlist(suggested, zone, ACHID_ZONE_MISC, ACHID_INSTANCES, ACHID_INSTANCES_10, ACHID_INSTANCES_25,
                ACHID_INSTANCES_10_NORMAL, ACHID_INSTANCES_25_NORMAL, ACHID_INSTANCES_10_HEROIC, ACHID_INSTANCES_25_HEROIC)
      -- Arrange into alphabetically-sorted array:
      local count = 0
      for k in pairs(suggested) do
        count = count + 1
        tab[count] = k
      end
      wipe(suggested)
      if (count > 0) then
        sort(tab)  -- Sort alphabetically.
        -- Turn into dropdown menu format:
        for i,name in ipairs(tab) do  tab[i] = {  text = name, value = name  };  end
        tinsert(tab, 1, {  text = L.SUGGESTIONS_LOCATION_NOSUBZONE, value = 0  })
        menu[zone] = tab
        subzdrop:SetMenu(tab)
        subzdrop:SetSelectedValue(0)
        subzdrop:Enable()
        return;
      else
        menu[zone] = false
      end
    end
    if (zone and menu[zone]) then
      subzdrop:SetMenu(menu[zone])
      subzdrop:Enable()
    else
      subzdrop:SetMenu(subzdrop_menu)
      subzdrop:Disable()
    end
  end
end

local orig_subzdropBtn_OnClick = Overachiever_SuggestionsFrameSubzoneDropButton:GetScript("OnClick")
Overachiever_SuggestionsFrameSubzoneDropButton:SetScript("OnClick", function(...)
  Refresh()
  if (subzdrop:IsEnabled()) then  orig_subzdropBtn_OnClick(...);  end
end)


-- Override for Normal/Heroic and group size
diffdrop = TjDropDownMenu.CreateDropDown("Overachiever_SuggestionsFrameDiffDrop", panel, {
  {
    text = L.SUGGESTIONS_DIFFICULTY_AUTO,
    value = 0
  },
  {
    text = L.SUGGESTIONS_DIFFICULTY_NORMAL,
    value = 1
  },
  {
    text = L.SUGGESTIONS_DIFFICULTY_HEROIC,
    value = 2
  },
  {
    text = L.SUGGESTIONS_DIFFICULTY_MYTHIC,
    value = 3
  };
})
diffdrop:SetLabel(L.SUGGESTIONS_DIFFICULTY, true)
diffdrop:SetPoint("TOPLEFT", subzdrop, "BOTTOMLEFT", 0, -18)
diffdrop:OnSelect(Refresh)

raidsizedrop = TjDropDownMenu.CreateDropDown("Overachiever_SuggestionsFrameRaidSizeDrop", panel, {
  {
    text = L.SUGGESTIONS_RAIDSIZE_AUTO,
    value = 0
  },
  {
    text = L.SUGGESTIONS_RAIDSIZE_10,
    value = 10
  },
  {
    text = L.SUGGESTIONS_RAIDSIZE_25,
    value = 25
  };
})
raidsizedrop:SetLabel(L.SUGGESTIONS_RAIDSIZE, true)
raidsizedrop:SetPoint("TOPLEFT", diffdrop, "BOTTOMLEFT", 0, -18)
raidsizedrop:OnSelect(Refresh)



RefreshBtn:SetPoint("TOPLEFT", raidsizedrop, "BOTTOMLEFT", 16, -14)

ResetBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
ResetBtn:SetWidth(75); ResetBtn:SetHeight(21)
ResetBtn:SetPoint("LEFT", RefreshBtn, "RIGHT", 4, 0)
ResetBtn:SetText(L.SEARCH_RESET)
ResetBtn:SetScript("OnClick", function(self)
  PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
  EditZoneOverride:SetText("")
  Refresh()
end)



-- MISCELLANEOUS
----------------------------------------------------

function Overachiever.OpenSuggestionsTab(text)
	if (not AchievementFrame:IsShown()) then  ToggleAchievementFrame();  end
	EditZoneOverride:SetText(text)
	if (Overachiever.GetSelectedTab() == frame) then
		--Overachiever.OpenTab_frame(frame)
		--PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		Refresh(RefreshBtn)
	else
		Overachiever.OpenTab_frame(frame, true)
	end
end

function Overachiever.GetLocalAutoTrackedSuggestions(incompleteOnly)
	local tracking = VARS.SuggestionsAutoTracking
	if (tracking) then
		local sug = getCurrentLocationSuggestions()
		local n = 0
		for id in pairs(sug) do
			local ok = false
			if (tracking[id]) then
				if (incompleteOnly) then
					local _, complete
					_, _, _, complete = GetAchievementInfo(id)
					if (not complete) then  ok = true;  end
				else
					ok = true
				end
			end
			if (ok) then
				n = n + 1
			else
				sug[id] = nil
			end
		end
		if (n == 0) then  return nil;  end
		return sug
	end
	return nil
end

function frame.ShouldCrossOut(id)
	return VARS_CHAR.SuggestionsHidden and VARS_CHAR.SuggestionsHidden[id]
end

function frame.ShouldAutoTrack(id)
	return VARS.SuggestionsAutoTracking and VARS.SuggestionsAutoTracking[id]
end

function frame.HandleAchBtnClick(self, button, ignoreModifiers)
	local id = self.id
	if (button == "RightButton") then
		if (IsShiftKeyDown() and not IsAltKeyDown()) then
			if (VARS_CHAR.SuggestionsHidden and VARS_CHAR.SuggestionsHidden[id]) then
				VARS_CHAR.SuggestionsHidden[id] = nil
				if (next(VARS_CHAR.SuggestionsHidden) == nil) then -- Is the table empty?
					VARS_CHAR.SuggestionsHidden = nil
				end
			else
				if (not VARS_CHAR.SuggestionsHidden) then  VARS_CHAR.SuggestionsHidden = {};  end
				VARS_CHAR.SuggestionsHidden[id] = true
			end
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			Refresh(panel)
			return true
		end
	elseif (IsShiftKeyDown() and IsAltKeyDown()) then
		if (VARS.SuggestionsAutoTracking and VARS.SuggestionsAutoTracking[id]) then
			VARS.SuggestionsAutoTracking[id] = nil
			if (next(VARS.SuggestionsAutoTracking) == nil) then -- Is the table empty?
				VARS.SuggestionsAutoTracking = nil
			end
		else
			if (not VARS.SuggestionsAutoTracking) then  VARS.SuggestionsAutoTracking = {};  end
			VARS.SuggestionsAutoTracking[id] = true
		end
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		Refresh(panel)
		Overachiever.AutoTrackingSettingUpdated()
		return true
	end
end

--[[
local function grabFromCategory(cat, ...)
  wipe(suggested)
  -- Get achievements in the category except those with a previous one in the chain that are also in the category:
  local id, prev, p2
  for i = 1, GetCategoryNumAchievements(cat) do
    id = GetAchievementInfo(cat, i)
	if (id) then
      prev, p2 = nil, GetPreviousAchievement(id)
      while (p2 and GetAchievementCategory(p2) == cat) do
        prev = p2
        p2 = GetPreviousAchievement(id)
      end
      suggested[ (prev or id) ] = true
	end
  end
  -- Add achievements specified by function call (useful for meta-achievements in a different category):
  for i=1, select("#", ...) do
    id = select(i, ...)
    suggested[id] = true
  end
  -- Fold achievements into their meta-achievements on the list:
  local tab, _, critType, assetID = {}
  for id in pairs(suggested) do
    for i=1,GetAchievementNumCriteria(id) do
      _, critType, _, _, _, _, _, assetID = GetAchievementCriteriaInfo(id, i)
      if (critType == 8 and suggested[assetID]) then
        tab[assetID] = true -- Not removed immediately in case there are meta-achievements within meta-achievements
      end
    end
  end
  for assetID in pairs(tab) do  suggested[assetID] = nil;  end
  -- Format list:
  local count = 0
  wipe(tab)
  for id in pairs(suggested) do
    count = count + 1
    tab[count] = id
  end
  return tab
end
--]]

-- ULDUAR 10: Results from grabFromCategory(14961, 2957):
--	{ 2894, 2903, 2905, 2907, 2909, 2911, 2913, 2919, 2925, 2927, 2931, 2933, 2934, 2937, 2939, 2940, 2945, 2947, 2951, 2955, 2957, 2959, 2961, 2963, 2967, 2969, 2971, 2973, 2975, 2977, 2979, 2980, 2982, 2985, 2989, 2996, 3003, 3004, 3008, 3009, 3012, 3014, 3015, 3036, 3076, 3097, 3138, 3157, 3177, 3316 }
-- ULDUAR 25: Results from grabFromCategory(14962, 2958):
--	{ 2895, 2904, 2906, 2908, 2910, 2912, 2918, 2921, 2926, 2928, 2932, 2935, 2936, 2938, 2942, 2943, 2946, 2948, 2952, 2956, 2958, 2960, 2962, 2965, 2968, 2970, 2972, 2974, 2976, 2978, 2981, 2983, 2984, 2995, 2997, 3002, 3005, 3010, 3011, 3013, 3016, 3017, 3037, 3077, 3098, 3118, 3161, 3185, 3237 }

--[[
-- /run Overachiever.Debug_GetIDsInCat( GetAchievementCategory(GetTrackedAchievements()) )
function Overachiever.Debug_GetIDsInCat(cat, simple)
  local tab = Overachiever_Settings.Debug_AchIDsInCat
  if (not tab) then  Overachiever_Settings.Debug_AchIDsInCat = {};  tab = Overachiever_Settings.Debug_AchIDsInCat;  end
  local catname = GetCategoryInfo(cat)
  tab[catname] = {}
  local subtab = tab[catname]
  local id, n
  for i=1,GetCategoryNumAchievements(cat) do
    id, n = GetAchievementInfo(cat, i)
    if (id) then
      if (simple) then
        subtab[i] = id
      else
        subtab[n] = id
      end
    end
  end
  if (simple) then  tab[catname] = table.concat(tab[catname], ", ");  end
end
--]]

--[[
do
	local okayFoS = {
		-- Achievements marked as Feat of Strength that we're okay with still being suggested (because they're still achievable or we think they might be).
		-- Periodically revisit these!
		[11869] = true, -- Done during Black Temple timewalking. Pretty sure that will happen again later so it's achievable.
		-- Ashran might come back later and, until then, no real harm suggesting these for that zone:
		[9256] = true,
		[9257] = true,
	}
-- /run Overachiever.Debug_GetMissingAch()
	local function getAchIDsFromTab(from, to)
	  for k,v in pairs(from) do
		if (type(v) == "table") then
		  getAchIDsFromTab(v, to)
		else
		  if (type(v) == "string") then
			local id, crit = strsplit(":", v)
			id, crit = tonumber(id) or id, tonumber(crit) or crit
			to[id] = to[id] or {}
			to[id][crit] = true
		  else
			to[v] = to[v] or false
		  end
		end
	  end
	end
	--local isAchievementInUI = Overachiever.IsAchievementInUI
	--local function isPreviousAchievementInUI(id)
	--  id = GetPreviousAchievement(id)
	--  if (id) then
	--    if (isAchievementInUI(id)) then  return true;  end
	--    return isPreviousAchievementInUI(id)
	--  end
	--end
	local FEAT_OF_STRENGTH_ID = 81
	local GUILD_FEAT_OF_STRENGTH_ID = 15093
	local function isInFeatOfStrengthCategory(id)
		local cat = GetAchievementCategory(id)
		local isFOS = false
		if (cat == FEAT_OF_STRENGTH_ID or cat == GUILD_FEAT_OF_STRENGTH_ID) then
			isFOS = true
		else
			local _, catParent = GetCategoryInfo(cat)
			if (catParent == FEAT_OF_STRENGTH_ID or catParent == GUILD_FEAT_OF_STRENGTH_ID) then
				isFOS = true
			end
		end
		return isFOS
	end

	function Overachiever.Debug_GetMissingAch()
	  wipe(suggested)
	  getAchIDsFromTab(Overachiever.SUGGESTIONS, suggested)
	  getAchIDsFromTab(OVERACHIEVER_ACHID, suggested)
	  getAchIDsFromTab(OVERACHIEVER_EXPLOREZONEID, suggested)
	  local count = 0
	  for id, crit in pairs(suggested) do
		if (type(id) ~= "number") then
		  print("Invalid ID type:",id,type(id))
		  count = count + 1
		elseif (GetAchievementInfo(id)) then
		  ----if (not isAchievementInUI(id, true) and not isPreviousAchievementInUI(id)) then
		  --if (not Overachiever.IsAchievementInUI(id, true)) then
		  --  print(GetAchievementLink(id),"is not found in the UI for this character.")
		  --  count = count + 1
		  if (not okayFoS[id] and isInFeatOfStrengthCategory(id)) then
			print(GetAchievementLink(id)," ("..id..") is a Feat of Strength.")
			count = count + 1
		  elseif (crit) then
			local num = GetAchievementNumCriteria(id)
			for c in pairs(crit) do
			  if (c > num) then
				print(GetAchievementLink(id),"is missing criteria #"..(tostring(c) or "<?>"))
				count = count + 1
			  end
			end
		  end
		else
		  print("Missing ID:",id..(crit and " (with criteria)" or ""))
		  count = count + 1
		end
	  end
	  print("Overachiever.Debug_GetMissingAch():",count,"problems found.")
	end
end
--]]


-- Thanks to chrisnolanca for many of the WoD changes.
-- https://github.com/ChrisNolan/OverachieverContinued/compare/WoDchanges


-- where? !!
-- 11607 They See Me Rolling
