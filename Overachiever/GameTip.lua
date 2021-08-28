
local L = OVERACHIEVER_STRINGS
local OVERACHIEVER_ACHID = OVERACHIEVER_ACHID
local GetStatistic = GetStatistic

local Overachiever = Overachiever
local GetAchievementCriteriaInfo = Overachiever.GetAchievementCriteriaInfo
local chatprint = Overachiever.chatprint

local AchievementIcon = "Interface\\AddOns\\Overachiever\\AchShield"
local tooltip_complete = { r = 0.2, g = 0.5, b = 0.2 }
local tooltip_incomplete = { r = 1, g = 0.1, b = 0.1 }

local ARROW_UP = "|TInterface\\Minimap\\Minimap-PositionArrows:0:0:0:0:16:32:0:16:0:16|t"
local ARROW_DOWN = "|TInterface\\Minimap\\Minimap-PositionArrows:0:0:0:0:16:32:0:16:16:32|t"

local LBI = LibStub:GetLibrary("LibBabble-Inventory-3.0"):GetLookupTable()
local time = time


local REMINDER_EXPIRE_SECONDS = 180  -- Allow reminders from up to 3 minutes ago

--local skipNextExamineOneLiner


--[[
local function tabcontains(tab, element)
  for k,v in pairs(tab) do
    if (v == element) then  return true;  end
  end
  return false
end
--]]


local isCriteria
do
  local cache
  function isCriteria(achID, name)
    if (not cache or not cache[achID]) then
      cache = cache or {}
      cache[achID] = {}
      local n
      for i=1,GetAchievementNumCriteria(achID) do
        n = GetAchievementCriteriaInfo(achID, i)
        cache[achID][n] = i  -- Creating lookup table
      end
    end
	local crit = cache[achID][name]
    if (crit) then
      local _, _, complete = GetAchievementCriteriaInfo(achID, crit)
      return crit, complete
    end
  end
end

local isCriteria_formatted
do
  local cache
  function isCriteria_formatted(achID, name, base)
    if (not cache or not cache[achID]) then
      cache = cache or {}
      cache[achID] = {}
      local n
      for i=1,GetAchievementNumCriteria(achID) do
        n = GetAchievementCriteriaInfo(achID, i)
		local arr = { strsplit("\n", base) }
		-- Creating lookup table
		--cache[achID][base:format(n)] = i
		for k,v in ipairs(arr) do
		  cache[achID][v:format(n)] = i
		end
      end
    end
	local crit = cache[achID][name]
    if (crit) then
      local _, _, complete = GetAchievementCriteriaInfo(achID, crit)
      return crit, complete
    end
  end
end

local isCriteria_asset
do
  local cache
  function isCriteria_asset(achID, assetID)
    local _
    if (not cache or not cache[achID]) then
      cache = cache or {}
      cache[achID] = {}
      local a
      for i=1,GetAchievementNumCriteria(achID) do
        _, _, _, _, _, _, _, a  = GetAchievementCriteriaInfo(achID, i)
        cache[achID][a] = i  -- Creating lookup table
      end
    end
	local crit = cache[achID][assetID]
    if (crit) then
      local complete
      _, _, complete = GetAchievementCriteriaInfo(achID, crit)
      return crit, complete
    end
  end
end

--[[ Cacheless versions:
local function isCriteria(achID, name)
  local n, t, complete
  for i=1,GetAchievementNumCriteria(achID) do
    n, t, complete = GetAchievementCriteriaInfo(achID, i)
    if (n == name) then  return true, complete;  end
  end
end

local function isCriteria_formatted(achID, name, base)
  local n, t, complete
  for i=1,GetAchievementNumCriteria(achID) do
    n, t, complete = GetAchievementCriteriaInfo(achID, i)
    if (base:format(n) == name) then  return true, complete;  end
  end
end
--]]

Overachiever.IsCriteria = isCriteria

--[[
local function isCriteria_hidden(achID, name)
  local n, t, complete
  local i = 0
  repeat
    i = i + 1
    n, t, complete = GetAchievementCriteriaInfo(achID, i)
    if (n == name) then  return i, complete;  end
  until (not n)
end
--]]

local function addTooltipLineWithTexture(tooltip, text, texture, r, g, b)
	--tooltip:AddLine(text, r, g, b)
	--tooltip:AddTexture(AchievementIcon)
	-- Above method stopped working. I don't see a statement that this is intended so it seems to be a bug in WoW. Working around it:
	tooltip:AddLine("|T"..texture..":0|t " .. text, r, g, b)
end


local function getMobID(unit)
  local guid = UnitGUID(unit)
  if (not guid) then  return;  end
  local unitType, _, _, _, _, id = ("-"):split(guid)
  if (unitType == "Creature" or unitType == "Vehicle") then
    --chatprint("ExamineSetUnit "..(id and tonumber(id) or "nil"))
    return tonumber(id), unitType
  end
  --guid = tonumber( "0x"..strsub(guid, 6, 10) )
  --guid = tonumber(guid:sub(6,10), 16)
  --guid = tonumber((guid):sub(-12, -9), 16)
  --return guid
end

local function isPlayerInCombatWith(unit)
  --local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("unit", "mob")
  local isTanking, status = UnitDetailedThreatSituation("player", unit)
  return status ~= nil
end


local lastreminder = 0
local SharedMedia = LibStub:GetLibrary("LibSharedMedia-3.0")

local function PlayReminder()
  if (Overachiever_Settings.SoundAchIncomplete ~= 0 and time() >= lastreminder + 15) then
    local sound = SharedMedia:Fetch("sound", Overachiever_Settings.SoundAchIncomplete)
	--chatprint("sound: " .. (sound and sound or "nope"))
    if (sound) then
      PlaySoundFile(sound)
      lastreminder = time()
    end
  end
end


Overachiever.RecentReminders = {}
local RecentReminders = Overachiever.RecentReminders
--Overachiever.RecentReminders_Criteria = {}
--local RecentReminders_Criteria = Overachiever.RecentReminders_Criteria

function Overachiever.GetRecentReminders(id, getNames, checkCompletion)
	--Overachiever.RecentReminders_Check() -- Don't do this; the ID is used in at least one case where the achievement is showing already as a Recent Reminder, so it wouldn't make sense to not show the related objectives even if normal expiration time passed.
	if (RecentReminders[id]) then
		local results
		local anycomplete
		for nameOrCritID,t in pairs(RecentReminders[id]) do
			local name, _, complete
			if (getNames or checkCompletion) then
				if (type(nameOrCritID) == "number") then
					if (nameOrCritID > 0) then
						name, _, complete = GetAchievementCriteriaInfo(id, nameOrCritID)
						if (getNames) then  nameOrCritID = name;  end
						if (complete) then  anycomplete = true;  end
					else
						if (getNames) then  nameOrCritID = nil;  end
					end
				end
			end
			if (nameOrCritID) then
				results = results or {}
				if (checkCompletion) then
					results[#results+1] = { nameOrCritID, complete }  -- complete should be true if complete, false it not, or nil if we couldn't check
				else
					results[#results+1] = nameOrCritID
				end
			end
		end
		return results, anycomplete
	end
end

local function flagReminder(id, nameOrCritID, t)
	nameOrCritID = nameOrCritID or 0
	local r = RecentReminders[id]
	if (r) then
		r[nameOrCritID] = t or time()
	else
		RecentReminders[id] = { [nameOrCritID] = t or time() }
	end
end
Overachiever.FlagReminder = flagReminder


function Overachiever.RecentReminders_Check()
	local earliest = time() - REMINDER_EXPIRE_SECONDS
	for id,tab in pairs(RecentReminders) do
		for name,t in pairs(tab) do
			if (t < earliest) then
				RecentReminders[id][name] = nil
				if (next(RecentReminders[id]) == nil) then -- If the table is empty
					RecentReminders[id] = nil
					break;
				end
			end
		end
	end
end



local storeTooltip, outputTooltip
do
	local tipComplete, tipIncomplete

	function storeTooltip(tooltip, id, text, complete, nameOrCritID, noSound)
		local tab
		if (complete) then
			tab = tipComplete
			if (not tab) then
				tab = {}
				tipComplete = tab
			end
		else
			tab = tipIncomplete
			if (not tab) then
				tab = {}
				tipIncomplete = tab
			end
		end

		local data = tab[text]
		if (data) then
			data[#data+1] = id
		else
			tab[text] = { id }
		end

		if (not complete and tooltip == GameTooltip) then
			flagReminder(id, nameOrCritID)  --if (nameOrCritID) then  flagReminder(id, nameOrCritID);  end
			if (not noSound) then  PlayReminder();  end
		end
	end

	local function outputTooltip_inner(tooltip, tab, r, g, b)
		for text,data in pairs(tab) do
			local num = #data
			if (num > 1) then  text = L.MULTI_NEED:format(text, num);  end
			if (Overachiever_Debug) then  text = text .. ' [ID:' .. table.concat(data, ',') .. ']';  end
			addTooltipLineWithTexture(tooltip, text, AchievementIcon, r, g, b)
		end
	end

	function outputTooltip(tooltip)
		if (tipComplete) then  outputTooltip_inner(tooltip, tipComplete, tooltip_complete.r, tooltip_complete.g, tooltip_complete.b);  end
		if (tipIncomplete) then  outputTooltip_inner(tooltip, tipIncomplete, tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b);  end
		if (tipComplete or tipIncomplete) then
			tooltip:Show()
			tipComplete, tipIncomplete = nil, nil
		end
	end
end


local function isTwentyFiver(diffID)
  if (diffID == 4 or diffID == 6 or diffID == 7 or diffID == 20) then  return true;  end
  return false
end

function Overachiever.GetDifficulty()
  if (IsInInstance()) then
  -- IF IN AN INSTANCE:
  -- Returns: <instance type ("arena", "party", "pvp", "raid", or "scenario")>, <Is Heroic?>, <Is Mythic?>, <Challenge Mode?>, <Legacy raid size 25 players?>, <Heroic Raid?>, <Mythic Raid?>
  --   If in a raid, the "Heroic Raid?" return will match the "Heroic?" return. Otherwise, it will be nil. (Similar for "Mythic Raid?".)
  --   Note: While it may seem that the "Heroic?" and "Heroic Raid?" returns are redundant here, it's done this
  --   way to make the return values consistent with those given when you're NOT in an instance.

    --local name, itype, difficultyID, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()
	--local difficultyName, instanceType, isHeroic, isChallengeMode, displayHeroic, displayMythic, toggleDifficultyID = GetDifficultyInfo(difficultyID);
	local _, itype, difficultyID = GetInstanceInfo()
	local _, _, isHeroic, isChallengeMode, _, displayMythic, toggleDifficultyID = GetDifficultyInfo(difficultyID)
	if (itype == "raid") then  return itype, isHeroic, displayMythic, isChallengeMode, isTwentyFiver(difficultyID), isHeroic, displayMythic;  end
	return itype, isHeroic, displayMythic, isChallengeMode, nil, nil, nil
  else
  -- IF NOT IN AN INSTANCE:
  -- Returns: false, <Dungeon set as Heroic?>, <Dungeon set as Mythic?>, nil, <Legacy raid size is 25 players?>, <Raid set as Heroic?>, <Raid set as Mythic?>

    local d = GetDungeonDifficultyID()
	local _, _, isHeroicD, _, _, displayMythicD = GetDifficultyInfo(d);
    local r = GetLegacyRaidDifficultyID() --GetRaidDifficultyID()
	local _, _, isHeroicR, _, _, displayMythicR = GetDifficultyInfo(r)
	return false, isHeroicD, displayMythicD, nil, isTwentyFiver(r), isHeroicR, displayMythicR --isTwentyFiver(GetLegacyRaidDifficultyID())
  end
end

--[[
http://wowprogramming.com/docs/api/GetInstanceInfo
local name, itype, difficulty, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()
difficulty:
0 - None; not in an Instance.
1 - 5-player Instance.
2 - 5-player Heroic Instance.
3 - 10-player Raid Instance.
4 - 25-player Raid Instance.
5 - 10-player Heroic Raid Instance.
6 - 25-player Heroic Raid Instance.
7 - 25-player Raid Finder Instance.
8 - Challenge Mode Instance.
9 - 40-player Raid Instance.
10 - Not used.
11 - Heroic Scenario Instance.
12 - Scenario Instance.
13 - Not used.
14 - 10-30-player Normal Raid Instance.
15 - 10-30-player Heroic Raid Instance.
16 - 20-player Mythic Raid Instance .
17 - 10-30-player Raid Finder Instance.
18 - 40-player Event raid (Used by the level 100 version of Molten Core for WoW's 10th anniversary).
19 - 5-player Event instance (Used by the level 90 version of UBRS at WoD launch).
20 - 25-player Event scenario (unknown usage).
21 - Not used.
22 - Not used.
23 - Mythic 5-player Instance.
24 - Timewalker 5-player Instance.
--]]

--[[
function Overachiever.GetDifficulty()
  local inInstance = IsInInstance()
  if (inInstance) then
-- IF IN AN INSTANCE:
  -- Returns: <instance type ("arena", "party", "pvp", "raid", or "scenario")>, <Heroic?>, <25-player Raid?>, <Heroic Raid?>, <Dynamic?>
  --   If in a raid, the "Heroic Raid?" return will match the "Heroic?" return. Otherwise, it will be nil (actually
  --   no return). "Dynamic?" refers to whether the current instance's difficulty can be changed on the fly, as is
  --   the case with the Icecrown Citadel raid.
  --   Note: While it may seem that the "Heroic?" and "Heroic Raid?" returns are redundant here, it's done this
  --   way to make the return values consistent with those given when you're NOT in an instance.
    local _, itype, diff, _, _, dynDiff, isDynamic = GetInstanceInfo()
    --if (isDynamic) then  diff = dynDiff;  end  -- Testing is needed to see if this line is necessary.
    local _, _, isHeroic = GetDifficultyInfo(diff) -- This function can also give us isChallengeMode, but we're not using it at the moment.
    return itype, isHeroic, (diff == 4 or diff == 6), (diff == 5 or diff == 6), isDynamic
  end
-- IF NOT IN AN INSTANCE:
  -- Returns: false, <Dungeon set as Heroic?>, <Raid set for 25 players?>, <Raid set as Heroic?>
  local d = GetDungeonDifficultyID()
  local r = GetRaidDifficultyID()
  return false, (d > 1), (r == 4 or r == 6), (r > 4)
end
--]]


-- UNIT TOOLTIP HOOK
----------------------

local CritterAch = {
  LoveCritters = { "CritterTip_loved", L.ACH_LOVECRITTERS_COMPLETE, L.ACH_LOVECRITTERS_INCOMPLETE },
  LoveCritters2 = { "CritterTip_loved", L.ACH_LOVECRITTERS_COMPLETE, L.ACH_LOVECRITTERS_INCOMPLETE },
  LoveCritters3 = { "CritterTip_loved", L.ACH_LOVECRITTERS_COMPLETE, L.ACH_LOVECRITTERS_INCOMPLETE },
  LoveCritters4 = { "CritterTip_loved", L.ACH_LOVECRITTERS_COMPLETE, L.ACH_LOVECRITTERS_INCOMPLETE },
  LoveCritters5 = { "CritterTip_loved", L.ACH_LOVECRITTERS_COMPLETE, L.ACH_LOVECRITTERS_INCOMPLETE },
  LoveCritters6 = { "CritterTip_loved", L.ACH_LOVECRITTERS_COMPLETE, L.ACH_LOVECRITTERS_INCOMPLETE },
  LoveCritters7 = { "CritterTip_loved", L.ACH_LOVECRITTERS_COMPLETE, L.ACH_LOVECRITTERS_INCOMPLETE },
  LoveCritters8 = { "CritterTip_loved", L.ACH_LOVECRITTERS_COMPLETE, L.ACH_LOVECRITTERS_INCOMPLETE },
  PestControl = { "CritterTip_killed", L.KILL_COMPLETE, L.KILL_INCOMPLETE },
};

local function CritterCheck(ach, name)
  local id = OVERACHIEVER_ACHID[ach]
  if (select(4, GetAchievementInfo(id))) then
    CritterAch[ach] = nil;
    return;
  end
  local crit, complete = isCriteria(id, name)
  if (crit) then
    local tip = complete and CritterAch[ach][2] or CritterAch[ach][3]
    if (Overachiever_Debug) then  tip = tip .. " (" .. id .. ")";  end
    return id, tip, complete, crit
  end
end

local VehicleMobAch = {
  --WhatWeRideInTheShadows = { "VehicleTip_ridden", L.ACH_RIDE_COMPLETE, L.ACH_RIDE_INCOMPLETE },
  AfterlifeExpress = { "VehicleTip_ridden", L.ACH_RIDE_COMPLETE, L.ACH_RIDE_INCOMPLETE },
};

local function VehicleMobCheck(ach, mobID)
  local id = OVERACHIEVER_ACHID[ach]
  if (select(4, GetAchievementInfo(id))) then
    VehicleMobAch[ach] = nil;
    return;
  end
  local crit, complete = isCriteria_asset(id, mobID)
  if (crit) then
    local tip = complete and VehicleMobAch[ach][2] or VehicleMobAch[ach][3]
    if (Overachiever_Debug) then  tip = tip .. " (" .. id .. ")";  end
    return id, tip, complete, crit
  end
end

local RaceClassAch = {
  FistfulOfLove = { "FistfulOfLove_petals", L.ACH_FISTFULOFLOVE_COMPLETE, L.ACH_FISTFULOFLOVE_INCOMPLETE,
    { "Gnome WARLOCK", "Orc DEATHKNIGHT", "Human DEATHKNIGHT", "NightElf PRIEST", "Orc SHAMAN", "Tauren DRUID", "Scourge WARRIOR", "Troll ROGUE", "BloodElf MAGE", "Draenei PALADIN", "Dwarf HUNTER" }
  },
  LetItSnow = { "LetItSnow_flaked", L.ACH_LETITSNOW_COMPLETE, L.ACH_LETITSNOW_INCOMPLETE,
    { "Orc DEATHKNIGHT", "Human WARRIOR", "Tauren SHAMAN", "NightElf DRUID", "Scourge ROGUE", "Troll HUNTER", "Gnome MAGE", "Dwarf PALADIN", "BloodElf WARLOCK", "Draenei PRIEST" }
  },
  CheckYourHead = { "CheckYourHead_pumpkin", L.ACH_CHECKYOURHEAD_COMPLETE, L.ACH_CHECKYOURHEAD_INCOMPLETE,
    { "BloodElf", "Draenei", "Dwarf", "Gnome", "Goblin", "Human", "NightElf", "Orc", "Tauren", "Troll", "Scourge", "Worgen" }, true
  },
  TurkeyLurkey = { "TurkeyLurkey_feathered", L.ACH_TURKEYLURKEY_COMPLETE, L.ACH_TURKEYLURKEY_INCOMPLETE,
    { "BloodElf ROGUE", "Dwarf ROGUE", "Gnome ROGUE", "Goblin ROGUE", "Human ROGUE", "NightElf ROGUE", "Orc ROGUE", "Troll ROGUE", "Scourge ROGUE", "Worgen ROGUE" }
  },
  BunnyMaker = { "BunnyMaker_eared", L.ACH_BUNNYMAKER_COMPLETE, L.ACH_BUNNYMAKER_INCOMPLETE,
    { "BloodElf", "Draenei", "Dwarf", "Gnome", "Goblin", "Human", "NightElf", "Orc", "Tauren", "Troll", "Scourge", "Worgen" }, true,
    function(unit)
      --if (UnitSex(unit) == 3) then
        local level = UnitLevel(unit)
        if (level >= 18 or level == -1) then  return true;  end
        -- Assumes that players 10 or more levels higher than you are at least level 18. (Though that's not necessarily
        -- the case, they generally would be.)
      --end
    end
  },
};
--[[
-- /run Overachiever.Debug_GetRaceClassAchCrit()
function Overachiever.Debug_GetRaceClassAchCrit()
  local s, sub = ""
  for k,tab in pairs(RaceClassAch) do
    local id = OVERACHIEVER_ACHID[k]
    sub = k.." ("..id.."): "
    for i=1,GetAchievementNumCriteria(id) do
      local n = GetAchievementCriteriaInfo(id, i)
      local r, c
      local n1, n2, n3, n4 = strsplit(" ", n, 4)
      if (n2 == "Elf") then
        r = n1..n2
        if (n3) then  c = strupper(n3..(n4 or ""));  end
      else
        r = n1 == "Undead" and "Scourge" or n1
        if (n2) then  c = strupper(n2..(n3 or ""));  end
      end
      n = r..(c and " "..c or "")
      sub = sub..'"'..n..'"'..", "
    end
    print(sub)
    s = s == "" and sub or s.."|n|n"..sub
  end
  error(s) -- Use the popup for easy copy+paste
end
--]]

local function RaceClassCheck(ach, tab, raceclass, race, unit)
  local id = OVERACHIEVER_ACHID[ach]
  if (select(4, GetAchievementInfo(id))) then
    RaceClassAch[ach] = nil;
    return;
  end
  local func = tab[6]
  if (func and not func(unit)) then  return;  end
  local text = tab[5] and race or raceclass
  for i,c in ipairs(tab[4]) do
    if (c == text) then
      local _, _, complete = GetAchievementCriteriaInfo(id, i)
      return id, complete and tab[2] or tab[3], complete, i
    end
  end
end

function Overachiever.ExamineSetUnit(tooltip)
  --skipNextExamineOneLiner = true
  tooltip = tooltip or GameTooltip  -- Workaround since another addon is known to break this
  local name, unit = tooltip:GetUnit()
  if (not unit) then  return;  end
  local id, text, complete, crit, needtipshow

  if (UnitIsPlayer(unit)) then
    local raceName, r = UnitRace(unit)
	local className, c = UnitClass(unit)
    if (r and c) then
      local raceclass = r.." "..c
      for key,tab in pairs(RaceClassAch) do
        if (Overachiever_Settings[ tab[1] ]) then
          id, text, complete, crit = RaceClassCheck(key, tab, raceclass, r, unit)
          if (text) then
            local r, g, b
            if (complete) then
              r, g, b = tooltip_complete.r, tooltip_complete.g, tooltip_complete.b
            else
              r, g, b = tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b
              PlayReminder()
      			  local playername = UnitName(unit)
      			  if (playername) then  playername = playername .. " (" .. raceName .. " " .. className .. ")";  end
      			  flagReminder(id, playername)
            end
            addTooltipLineWithTexture(tooltip, text, AchievementIcon, r, g, b)
            needtipshow = true
          end
        end
      end
    end

  elseif (name) then
    local type = UnitCreatureType(unit)
    --if (type == L.CRITTER or type == L.WILDPET) then
    if (type == L.CRITTER or type == L.WILDPET or UnitLevel(unit) < 10) then  -- Some critters aren't called critters any more for some reason. The unit level check should help.
      for key,tab in pairs(CritterAch) do
        if (Overachiever_Settings[ tab[1] ]) then
          local critNum
          id, text, complete, critNum = CritterCheck(key, name)
          if (text) then
            local r, g, b
            if (complete) then
              r, g, b = tooltip_complete.r, tooltip_complete.g, tooltip_complete.b
            else
              r, g, b = tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b
              PlayReminder()
              flagReminder(id, critNum) --flagReminder(id, name)
            end
            addTooltipLineWithTexture(tooltip, text, AchievementIcon, r, g, b)
            needtipshow = true
          end
        end
      end

    else
      local mobID, unitType = getMobID(unit)
      --local tab = TjAchieve.GetCriteriaByAsset(TjAchieve.CRITTYPE_KILL, mobID, true)
      --local tab = Overachiever.GetKillCriteriaLookup()[mobID]
      if (unitType == "Creature" and Overachiever_Settings.CreatureTip_killed and UnitCanAttack("player", unit)) then
        local tab = Overachiever.GetKillCriteriaLookup(true)
        if (tab and tab[mobID]) then
          tab = tab[mobID]
          local includeCompleteAch = Overachiever_Settings.CreatureTip_killed_whencomplete
          local excludeGuild = Overachiever_Settings.CreatureTip_killed_exclude_guild
          local num, numincomplete, potential, _, achcom, guild, c, t = 0, 0
          for i = 1, #tab, 2 do
            id = tab[i]
            _, _, _, achcom, _, _, _, _, _, _, _, guild = GetAchievementInfo(id)
            if ((not achcom or includeCompleteAch) and (not guild or not excludeGuild)) then
              num = num + 1
              _, _, c = GetAchievementCriteriaInfo(id, tab[i+1])
              if (not c) then
                numincomplete = numincomplete + 1
                potential = potential or {}
                potential[id] = tab[i+1]
              end
            end
          end

          if (num > 0) then
            if (numincomplete > 0) then
              local cat, t
              local instype, heroic, mythic, challenge, twentyfive = Overachiever.GetDifficulty()
              for id, crit in pairs(potential) do
  			  --[[
                cat = GetAchievementCategory(id)
                if (((not instype or not heroic) and (OVERACHIEVER_CATEGORY_HEROIC[cat] or (OVERACHIEVER_HEROIC_CRITERIA[id] and OVERACHIEVER_HEROIC_CRITERIA[id][crit])))
                    or ((not instype or not twentyfive) and OVERACHIEVER_CATEGORY_25[cat])) then
                  numincomplete = numincomplete - 1 -- Discount this reminder if it's heroic-only and you're not in a heroic instance or if it's 25-man only and you're not in a 25-man instance.
                else
                  flagReminder(id, crit)
                end
  			  --]]
  			  -- We don't have an easy way to detect whether the achievement is heroic-only any more here. (Maybe add a new function for this later?)
  			  -- We can still use the criteria-specific table, though:
                if ((not instype or not heroic) and (OVERACHIEVER_HEROIC_CRITERIA[id] and OVERACHIEVER_HEROIC_CRITERIA[id][crit]) or
                    (not instype or not mythic) and (OVERACHIEVER_MYTHIC_CRITERIA[id] and OVERACHIEVER_MYTHIC_CRITERIA[id][crit])) then
                  numincomplete = numincomplete - 1 -- Discount this reminder if it's heroic-only and you're not in a heroic instance or if it's 25-man only and you're not in a 25-man instance.
                else
                  flagReminder(id, crit)
                end
              end
            end
            
            local r, g, b
            if (numincomplete <= 0) then
              text = L.KILL_COMPLETE
              r, g, b = tooltip_complete.r, tooltip_complete.g, tooltip_complete.b
            else
              text = L.KILL_INCOMPLETE
              r, g, b = tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b
              if (not Overachiever_Settings.SoundAchIncomplete_KillCheckCombat or not isPlayerInCombatWith(unit)) then
                PlayReminder()
              end
            end
            addTooltipLineWithTexture(tooltip, text, AchievementIcon, r, g, b)
            needtipshow = true
          end
        end

      elseif (unitType == "Vehicle") then
        for key,tab in pairs(VehicleMobAch) do
          --print(key, mobID, tab[1], Overachiever_Settings[ tab[1] ])
          if (Overachiever_Settings[ tab[1] ]) then
            local critNum
            id, text, complete, critNum = VehicleMobCheck(key, mobID)
            if (text) then
              local r, g, b
              if (complete) then
                r, g, b = tooltip_complete.r, tooltip_complete.g, tooltip_complete.b
              else
                r, g, b = tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b
                PlayReminder()
                flagReminder(id, critNum) --flagReminder(id, name)
              end
              addTooltipLineWithTexture(tooltip, text, AchievementIcon, r, g, b)
              needtipshow = true
              if (TipTac) then  -- Attempt compatibility with the addon TipTac
                C_Timer.After(0, function()
                  if (tooltip:IsShown() and text) then -- Sanity check
                    addTooltipLineWithTexture(tooltip, text, AchievementIcon, r, g, b)
                    --tooltip:Show()
                  end
                end)
              end
            end
          end
        end
      end
    end
  end

  if (needtipshow) then  tooltip:Show();  end
end


-- WORLD OBJECT TOOLTIP HOOK
------------------------------

local WorldObjAch = {
  -- OVERACHIEVER_ACHID Key = { 1. Saved variable, 2. tooltip if complete, 3. tooltip if incomplete,
  --   4. bool: fishing, 5. possible criteria format, 6. bool: show nothing if entire achievement is complete }
  WellRead = { "WellReadTip_read", L.ACH_WELLREAD_COMPLETE, L.ACH_WELLREAD_INCOMPLETE },
  HigherLearning = { "WellReadTip_read", L.ACH_WELLREAD_COMPLETE, L.ACH_WELLREAD_INCOMPLETE },
  EatYourGreens = { "EatYourGreensTip_eat", L.ACH_EATYOURGREENS_COMPLETE, L.ACH_EATYOURGREENS_INCOMPLETE },
  Scavenger = { "AnglerTip_fished", L.ACH_ANGLER_COMPLETE, L.ACH_ANGLER_INCOMPLETE, true },
  OutlandAngler = { "AnglerTip_fished", L.ACH_ANGLER_COMPLETE, L.ACH_ANGLER_INCOMPLETE, true },
  NorthrendAngler = { "AnglerTip_fished", L.ACH_ANGLER_COMPLETE, L.ACH_ANGLER_INCOMPLETE, true },
  PandarianAngler = { "AnglerTip_fished", L.ACH_ANGLER_COMPLETE, L.ACH_ANGLER_INCOMPLETE, true, L.ACH_FISHSCHOOL_FORMAT },
  Limnologist = { "SchoolTip_fished", L.ACH_ANGLER_COMPLETE, L.ACH_ANGLER_INCOMPLETE, true, L.ACH_FISHSCHOOL_FORMAT, true },
  Oceanographer = { "SchoolTip_fished", L.ACH_ANGLER_COMPLETE, L.ACH_ANGLER_INCOMPLETE, true, L.ACH_FISHSCHOOL_FORMAT, true },
};
local WorldObjLookup = {}
if (L.ACH_ANGLER_COUNT) then
	local arr = { strsplit("\n", L.ACH_ANGLER_COUNT) }
	for k,v in ipairs(arr) do
		local data
		local achID, names = strsplit("=", v, 2)
		achID = tonumber(achID)
		if (achID and names and names ~= "") then
			names = { strsplit(",", names) }
			for k2,text in ipairs(names) do
				if (text ~= "") then
					data = data or { "DraenorAnglerTip_fished", L.ACH_ANGLER_COMPLETE, L.ACH_ANGLER_INCOMPLETE, true, ["id"] = achID }
					WorldObjLookup[text] = data
				end
			end
		end
	end
end

local function WorldObjCheck(ach, text)
  local id, data, complete, crit
  if (not ach) then
    if (not WorldObjLookup[text]) then  return;  end
    data = WorldObjLookup[text]
    id = data.id
    complete = select(4, GetAchievementInfo(id))
    if (complete and data[6]) then
      WorldObjLookup[text] = nil;
      return;
    end

  else
    data = WorldObjAch[ach]
    id = OVERACHIEVER_ACHID[ach]
    local achComplete = select(4, GetAchievementInfo(id))
    if (achComplete and data[6]) then
      WorldObjAch[ach] = nil;
      return;
    end
    local isCrit
    if (data[5]) then
      crit, complete = isCriteria_formatted(id, text, data[5])
    else
      crit, complete = isCriteria(id, text)
    end
    if (not crit) then  return;  end
	complete = complete or achComplete
  end

  return id, complete and data[2] or data[3], complete, data[4], crit
end


do
  Overachiever.Last_Tooltip_Check = 0
  local tip_cache, last_tiptext = {}
  local tooltipUsed, sizeAdjusted

  local function examineLine(line)
      local id, text, complete, angler, crit

	  -- Remove up or down arrow from front of text (as given when above/below something on the minimap):
	  local tiptext
	  if (strsub(line, 1, 68) == ARROW_UP) then
	    tiptext = strsub(line, 69)
	  elseif (strsub(line, 1, 69) == ARROW_DOWN) then
	    tiptext = strsub(line, 70)
	  else
	    tiptext = line
	  end

	  id, text, complete, angler, crit = WorldObjCheck(nil, tiptext)
	  if (not text) then
        for key,tab in pairs(WorldObjAch) do
          if (Overachiever_Settings[ tab[1] ]) then
            id, text, complete, angler, crit = WorldObjCheck(key, tiptext)
            if (text) then  break;  end
          end
        end
	  end

      return text and { line = line, cleantip = tiptext, id = id, crit = crit, text = text, complete = complete, angler = angler } or nil
  end

  function Overachiever.ExamineOneLiner(tooltip)
  -- Unfortunately, there isn't a "GameTooltip:SetWorldObject" or similar type of thing, so we have to check for
  -- these sorts of tooltips in a less direct way.

    tooltipUsed = nil

    --if (skipNextExamineOneLiner) then  skipNextExamineOneLiner = nil;  return;  end
    -- Skipping works because this function is consistently called after the functions that set skipNextExamineOneLiner to true.
	-- At least, it used to or seemed like it did. On second examination (years later, perhaps due to API changes?), it seems unnecessary so we can
	-- do without it.

    tooltip = tooltip or GameTooltip  -- Workaround since another addon is known to break this

	--if (tooltip:NumLines() == 1 or MouseIsOver(Minimap)) then
    if (tooltip:NumLines() == 1) then
	  local n = tooltip:GetName()
	  if (_G[n.."TextRight1"]:GetText()) then  return;  end

	  local tiptext = _G[n.."TextLeft1"]:GetText()
	  local t = time()
	  local last_check = Overachiever.Last_Tooltip_Check

	  if (tiptext ~= last_tiptext or t >= last_check + 60) then
	    last_tiptext = tiptext
		Overachiever.Last_Tooltip_Check = t
		wipe(tip_cache)

	    if (tiptext:find("\n")) then
		  local arr = { strsplit("\n", tiptext) }
		  local num, found = 0, 0
		  for i,line in ipairs(arr) do
		    local results = examineLine(line)
			num = num + 1
			if (results) then  found = found + 1;  end
			tip_cache[num] = results or line
		  end
		  if (found == 0) then  wipe(tip_cache);  end
		else
		  local results = examineLine(tiptext)
		  if (results) then
		    tip_cache[1] = results
		  end
	    end
	  end

	  if (next(tip_cache) ~= nil) then
		local needRewrite = #tip_cache > 1
		local count, needSound = 0
		for i,arr in ipairs(tip_cache) do
			local line, text, r, g, b
			if (type(arr) == "table") then
				line, text = arr.line, arr.text
				if (arr.complete) then
					r, g, b = tooltip_complete.r, tooltip_complete.g, tooltip_complete.b
				else
					r, g, b = tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b
					--if (t ~= last_check) then -- Different from previous check since reminder's "last seen" time (from flagReminder) should be reset if you mouse over the object again.
						flagReminder(arr.id, arr.crit, t)  --flagReminder(arr.id, arr.cleantip, t)
						if (not arr.angler or not Overachiever_Settings.SoundAchIncomplete_AnglerCheckPole or not IsEquippedItemType(LBI["Fishing Poles"])) then
							needSound = true
						end
					--end
				end
			else
				line = arr
			end
			if (needRewrite and i == 1) then -- can also have a setting that makes it never rewrite, just append to bottom (even if it may be a little confusing determining which it's referring to)
				_G[n.."TextLeft1"]:SetText(line)
				count = 1
			elseif (i > 1) then
				-- Have to force the color because of a glitch where the font is white if the tooltip hasn't been that long before.
				--tooltip:AddLine(line, NORMAL_FONT_COLOR:GetRGB())
				-- Above doesn't work for some reason. Have to do it this way:
				tooltip:AddLine(NORMAL_FONT_COLOR_CODE .. line)
				-- !! (try w/o this in beta, or using rgb instead? okay there?) !!
				count = count + 1
				-- Make font not small; large, as if it's on the first line.
				_G[n.."TextLeft"..count]:SetFontObject(GameTooltipHeaderText)
				sizeAdjusted = true
			end
			if (text) then
				addTooltipLineWithTexture(tooltip, text, AchievementIcon, r, g, b)
				count = count + 1
			end
		end
		tooltipUsed = true
		tooltip:Show()
		if (needSound) then  PlayReminder();  end
	  end

    end
  end

  local function delayedExamine()
    if (GameTooltip:IsShown()) then  Overachiever.ExamineOneLiner(GameTooltip);  end
  end

  -- We need this function because something is making the tooltip refresh its text while it's open, causing us to lose what we added:
  function Overachiever.ExamineOneLiner_clear(tooltip)
    -- This is a workaround. I'm not sure why Blizzard makes the tooltip refresh like they do. Anyway, we know the tooltip's either not going to be
	-- displayed or about to be "shown" again (even though the text might be the same as before), but the problem is that if it's the latter, our
	-- OnShow hook (Overachiever.ExamineOneLiner) doesn't get called if the frame was still visible. So, we hide it, so when GameTooltip:Show() is
	-- called next, our hook is always called. (And if it was the latter, the tooltip not being displayed, then hiding it *shouldn't* cause problems.)
	--tooltip:Hide()
	-- We can't just do the above, as it causes the tooltip to be hidden when we don't want it to. (Depends on addons you're using. Seems most common in
	-- my testing with buffs/debuffs that have a timer ticking.) So, we use a variable to track when we know we need to do this. However, that doesn't
	-- catch all instances, so the C_Timer.After call is used to catch the rest. (We don't want to only use the timer call because if it's the refreshing
	-- tooltip issue, what we add is for a brief moment not shown - repeatedly, every few seconds, since the tooltip keeps refreshing.)
	if (tooltipUsed) then
	  tooltip:Hide()
	elseif (tooltip == GameTooltip) then
	  C_Timer.After(0, delayedExamine)
	end

	if (sizeAdjusted) then
	  local i = 2
	  local lineObj = _G["GameTooltipTextLeft"..i]
	  while (lineObj) do
	    lineObj:SetFontObject(GameTooltipText)
		i = i + 1
		lineObj = _G["GameTooltipTextLeft"..i]
	  end
	  sizeAdjusted = nil
	end
  end

end


-- ITEM TOOLTIP HOOK
----------------------

-- All this consumable item tracking stuff really should be rewritten when you've got the time. (It's so disorganized and confusing because Blizzard kept changing things on me but I didn't want to take too long fixing things.)
-- It should be much easier to add stuff in the new version, as well. Make it so you can just add to the data table; don't require additional lines of code
-- to process it (e.g. instead of calling BuildItemLookupTab for each directly, use a loop through the table).

--local numDrinksConsumed, numFoodConsumed
local TastesLikeChicken_crit, HappyHour_crit

local ConsumeItemAch = {
--AchIdentifier = { "variable", "tooltip complete", "tooltip incomplete", "tooltip criteria incomplete (but ach complete)", lookupTable, "saved variable key; use only if criteria not in API" },
  TastesLikeChicken = { "Item_consumed", L.ACH_CONSUME_COMPLETE, L.ACH_CONSUME_INCOMPLETE, L.ACH_CONSUME_INCOMPLETE_EXTRA, nil, "Food" },
  HappyHour = { "Item_consumed", L.ACH_CONSUME_COMPLETE, L.ACH_CONSUME_INCOMPLETE, L.ACH_CONSUME_INCOMPLETE_EXTRA, nil, "Drink" },
  CataclysmicallyDelicious = { "Item_consumed", L.ACH_CONSUME_COMPLETE, L.ACH_CONSUME_INCOMPLETE, L.ACH_CONSUME_INCOMPLETE_EXTRA, {} },
  DrownYourSorrows = { "Item_consumed", L.ACH_CONSUME_COMPLETE, L.ACH_CONSUME_INCOMPLETE, L.ACH_CONSUME_INCOMPLETE_EXTRA, {} },
  PandarenCuisine = { "Item_consumed", L.ACH_CONSUME_COMPLETE, L.ACH_CONSUME_INCOMPLETE, L.ACH_CONSUME_INCOMPLETE_EXTRA, {} },
  PandarenDelicacies = { "Item_consumed", L.ACH_CONSUME_COMPLETE, L.ACH_CONSUME_INCOMPLETE, L.ACH_CONSUME_INCOMPLETE_EXTRA, {} },
  DraenorCuisine = { "Item_consumed", L.ACH_CONSUME_COMPLETE, L.ACH_CONSUME_INCOMPLETE, L.ACH_CONSUME_INCOMPLETE_EXTRA, {} },
  BrewfestDiet = { "Brewfest_consumed", L.ACH_CONSUME_COMPLETE, L.ACH_CONSUME_INCOMPLETE, L.ACH_CONSUME_INCOMPLETE_EXTRA, {} },
  DarkmoonFaireFeast = { "Darkmoon_consumed", L.ACH_CONSUME_COMPLETE, L.ACH_CONSUME_INCOMPLETE, L.ACH_CONSUME_INCOMPLETE_EXTRA, {} },

  -- Item-related achievements that aren't actually about consuming items, but the system should work for them fine:
  ThreeSheetsToTheWind = { "Item_acquired", L.ACH_ACQUIRE_COMPLETE, L.ACH_ACQUIRE_INCOMPLETE, L.ACH_ACQUIRE_INCOMPLETE_EXTRA, {} },
};

local MiscItemAch = {
-- [item ID] = { "AchievementKey", "variable", "tooltip complete", "tooltip incomplete" }
	[62680] = { "RightAsRain", "Item_satisfied", L.ACH_CONSUME_91_COMPLETE, L.ACH_CONSUME_91_INCOMPLETE },
}

--[[
function debug_getAssets(key)
	local id = OVERACHIEVER_ACHID[key]
	if (not id) then  return;  end
	local tab = {}
	for i=1,GetAchievementNumCriteria(id) do
		local _, _, completed, _, _, _, _, asset = GetAchievementCriteriaInfo(id, i)
		tab[#tab+1] = asset
	end
	return table.concat(tab, "\n")
end
--]]


function Overachiever.BuildItemLookupTab(THIS_VERSION)
	local needRefresh, oldver, oldbuild = false, "0", "0"
	if (Overachiever_CharVars_Consumed and Overachiever_CharVars_Consumed.LastBuilt) then
		oldver, oldbuild = strsplit("|", Overachiever_CharVars_Consumed.LastBuilt, 2)
		if (oldver ~= THIS_VERSION) then  needRefresh = true;  end
	else
		Overachiever_CharVars_Consumed = Overachiever_CharVars_Consumed or {}
		needRefresh = true
	end
	--local _, gamebuild = GetBuildInfo()
	--if (oldver ~= THIS_VERSION or gamebuild ~= oldbuild) then  needRefresh = true;  end
	local anyRefreshed = false
	local Consumed_Default = Overachiever.Consumed_Default

	for k,v in pairs(ConsumeItemAch) do
		local id = OVERACHIEVER_ACHID[k]
		local tab
		if (v[6]) then
			local needRefreshThis = needRefresh
			tab = Overachiever_CharVars_Consumed[v[6]]
			if (not tab) then
				tab = {}
				Overachiever_CharVars_Consumed[v[6]] = tab
				needRefreshThis = true
			end
			v[5] = tab

			if (needRefreshThis) then
				if (Consumed_Default[k]) then
					for k2,v2 in pairs(Consumed_Default[k]) do
						if (tab[k2] == nil) then  tab[k2] = 0;  end
					end
				end
				if (oldver < "0.99.2") then  -- Remove criteria that belong to a different achievement:
					--chatprint(k..": Removing criteria that belong to a different achievement:")
					for k2,v2 in pairs(ConsumeItemAch) do
						if (not v2[6]) then
							local id2 = OVERACHIEVER_ACHID[k2]
							--chatprint(k2)
							for i=1,GetAchievementNumCriteria(id2) do
								local asset = select(8, GetAchievementCriteriaInfo(id2, i))
								if (tab[asset] ~= nil) then
									--chatprint("- " .. asset)
									tab[asset] = nil
								end
							end
						end
					end
					--chatprint("- Done.")
				end
				anyRefreshed = true
			end

		else
			tab = v[5]
			local _, completed, asset
			for i=1,GetAchievementNumCriteria(id) do
				_, _, completed, _, _, _, _, asset = GetAchievementCriteriaInfo(id, i)
				tab[asset] = not not completed  -- completed should be true or false anyway, but "not not" guarantees that
			end
		end
	end

	if (anyRefreshed) then
		local _, gamebuild = GetBuildInfo()
		Overachiever_CharVars_Consumed.LastBuilt = THIS_VERSION.."|"..gamebuild
	end

	--numDrinksConsumed = tonumber((GetStatistic(OVERACHIEVER_ACHID.Stat_ConsumeDrinks))) or 0
	--numFoodConsumed = tonumber((GetStatistic(OVERACHIEVER_ACHID.Stat_ConsumeFood))) or 0

	TastesLikeChicken_crit = Overachiever_CharVars_Consumed.Food
	HappyHour_crit = Overachiever_CharVars_Consumed.Drink

	Overachiever.Consumed_Default = nil
end


--[=[
function Overachiever.BuildItemLookupTab(THIS_VERSION, id, savedtab, tab, duptab, alwaysLookup)
  if (id) then  -- Build lookup tables (since examining the criteria each time is time-consuming):
-- This is separate from the BuildCriteriaLookupTab function because while that gave some good achievements
-- involving consumable items, it also gave some that didn't fit well. This function instead uses hardcoded IDs
-- taken from OVERACHIEVER_ACHID.
-- When duptab is used, it specifies that: 1) The achievement ID given provides reliable data on whether a
-- criteria is completed, so it is good to use that data instead of relying on saved data. 2) Some asset data
-- in duptab overlaps with the assets in this achievement, but since duptab didn't get its criteria info
-- reliably, we should update duptab data to match where applicable.
    tab = tab or {}

    if (id == OVERACHIEVER_ACHID.TastesLikeChicken or id == OVERACHIEVER_ACHID.HappyHour) then
    -- Unfortunately, the WoW API no longer supports grabbing item IDs from "Tastes Like Chicken" and "It's Happy Hour Somewhere".
    -- This guts the functionality that the Reminder Tooltips feature relied on for those two achievements. Consequently,
    -- we're not going to be able to intelligently detect new foods you come across and whether you need to consume them.
    -- The best we can do is preserve whatever table data is already in the SavedVariables and supplement it with some default item
    -- IDs (Overachiever.Consumed_Default, which is based on data collected in a prior version of WoW).
      if ((not savedtab or next(savedtab) == nil) and Overachiever.Consumed_Default[id]) then
        wipe(tab)
        for k,v in pairs(Overachiever.Consumed_Default[id]) do
          tab[k] = v;
          if (savedtab) then  savedtab[k] = v;  end
        end
        if (Overachiever_Debug) then  chatprint("Skipped lookup table rebuild for Ach #"..id..": Used default list because WoW API no longer supports the required method and character has no relevant saved data.");  end
      elseif (savedtab) then
        wipe(tab)
        for k,v in pairs(savedtab) do  tab[k] = v;  end  -- Copy table (cannot just set using "=" or reference will be lost)
        if (Overachiever_Debug) then  chatprint("Skipped lookup table rebuild for Ach #"..id..": Retrieved from saved variables because WoW API no longer supports the required method.");  end
      end
      return tab
    end

    local i, _, completed, asset = 1
    _, _, completed, _, _, _, _, asset = GetAchievementCriteriaInfo(id, i)
    while (asset) do -- while loop used because "hidden" criteria may be used (where GetAchievementNumCriteria returns only 1).
      if (duptab) then
        tab[asset] = completed or 0
        if (duptab[asset]) then  duptab[asset] = completed or 0;  end
      elseif (savedtab) then
        tab[asset] = savedtab[asset] or 0
      else
        tab[asset] = completed or 0
      end
	  if (alwaysLookup and tab[asset] == 0) then  tab[asset] = -1;  end
      i = i + 1
      _, _, completed, _, _, _, _, asset = GetAchievementCriteriaInfo(id, i)
    end
    return tab
  end

  numDrinksConsumed = tonumber((GetStatistic(OVERACHIEVER_ACHID.Stat_ConsumeDrinks))) or 0
  numFoodConsumed = tonumber((GetStatistic(OVERACHIEVER_ACHID.Stat_ConsumeFood))) or 0

--[[  -- Old code to see whether tables should be built. Now, tables are always used (either built or retrieved
      -- from a saved variable) because Blizzard's API no longer tells us what has been consumed. To be
      -- reliable, Overachiever needs to "see" what is consumed so from now on we'll always use the tracking
      -- table. (Variable ItemLookupTabBuilt is no longer used.)
  if ( ItemLookupTabBuilt or not Overachiever_Settings.Item_consumed or
       (not Overachiever_Settings.Item_consumed_whencomplete and select(4, GetAchievementInfo(foodID)) and
       select(4, GetAchievementInfo(drinkID))) ) then
  -- OLD: If the tables are built, or we don't add this info to tooltips, or we don't add this info to tooltips if
  -- the achievement is complete AND both achievements are complete, then do nothing.
    return;
  end
--]]

  -- Determine whether we should (re)build the lookup tables. If they don't exist (in whole or in part), the
  -- addon has changed, or the game build has changed, the tables will be (re)built.
  local needBuild
  local _, gamebuild = GetBuildInfo()
  if (not Overachiever_CharVars_Consumed or not Overachiever_CharVars_Consumed.LastBuilt or
      not Overachiever_CharVars_Consumed.Food or not Overachiever_CharVars_Consumed.Drink or
      not Overachiever_CharVars_Consumed.Food2 or not Overachiever_CharVars_Consumed.Drink2 or
      not Overachiever_CharVars_Consumed.PandaEats or not Overachiever_CharVars_Consumed.PandaEats2) then
    Overachiever_CharVars_Consumed = Overachiever_CharVars_Consumed or {}
    Overachiever_CharVars_Consumed.Food = Overachiever_CharVars_Consumed.Food or {}
    Overachiever_CharVars_Consumed.Drink = Overachiever_CharVars_Consumed.Drink or {}
    Overachiever_CharVars_Consumed.Food2 = Overachiever_CharVars_Consumed.Food2 or {}
    Overachiever_CharVars_Consumed.Drink2 = Overachiever_CharVars_Consumed.Drink2 or {}
    Overachiever_CharVars_Consumed.PandaEats = Overachiever_CharVars_Consumed.PandaEats or {}
    Overachiever_CharVars_Consumed.PandaEats2 = Overachiever_CharVars_Consumed.PandaEats2 or {}
    -- Saving char vars for these ones is pointless since the API gives us data on criteria completion: (some achievements from above should probably be given this treatment instead)
    --Overachiever_CharVars_Consumed.Brewfest = Overachiever_CharVars_Consumed.Brewfest or {}
    needBuild = true
  else
    local oldver, oldbuild = strsplit("|", Overachiever_CharVars_Consumed.LastBuilt, 2)
    if (oldver ~= THIS_VERSION or gamebuild ~= oldbuild) then  needBuild = true;  end
  end

  if (needBuild) then
    Overachiever_CharVars_Consumed.Food = Overachiever.BuildItemLookupTab(THIS_VERSION, OVERACHIEVER_ACHID.TastesLikeChicken, Overachiever_CharVars_Consumed.Food, FoodCriteria)
    Overachiever_CharVars_Consumed.Drink = Overachiever.BuildItemLookupTab(THIS_VERSION, OVERACHIEVER_ACHID.HappyHour, Overachiever_CharVars_Consumed.Drink, DrinkCriteria)
    Overachiever_CharVars_Consumed.Food2 = Overachiever.BuildItemLookupTab(THIS_VERSION, OVERACHIEVER_ACHID.CataclysmicallyDelicious, Overachiever_CharVars_Consumed.Food2, FoodCriteria2, FoodCriteria)
    Overachiever_CharVars_Consumed.Drink2 = Overachiever.BuildItemLookupTab(THIS_VERSION, OVERACHIEVER_ACHID.DrownYourSorrows, Overachiever_CharVars_Consumed.Drink2, DrinkCriteria2, DrinkCriteria)
    Overachiever_CharVars_Consumed.PandaEats = Overachiever.BuildItemLookupTab(THIS_VERSION, OVERACHIEVER_ACHID.PandarenCuisine, Overachiever_CharVars_Consumed.PandaEats, PandaEats)
    Overachiever_CharVars_Consumed.PandaEats2 = Overachiever.BuildItemLookupTab(THIS_VERSION, OVERACHIEVER_ACHID.PandarenDelicacies, Overachiever_CharVars_Consumed.PandaEats2, PandaEats2)
    Overachiever_CharVars_Consumed.LastBuilt = THIS_VERSION.."|"..gamebuild
  else
    FoodCriteria, DrinkCriteria = Overachiever_CharVars_Consumed.Food, Overachiever_CharVars_Consumed.Drink
    FoodCriteria2, DrinkCriteria2 = Overachiever_CharVars_Consumed.Food2, Overachiever_CharVars_Consumed.Drink2
    PandaEats, PandaEats2 = Overachiever_CharVars_Consumed.PandaEats, Overachiever_CharVars_Consumed.PandaEats2;
    ConsumeItemAch.TastesLikeChicken[5], ConsumeItemAch.HappyHour[5] = FoodCriteria, DrinkCriteria
    ConsumeItemAch.CataclysmicallyDelicious[5], ConsumeItemAch.DrownYourSorrows[5] = FoodCriteria2, DrinkCriteria2
    ConsumeItemAch.PandarenCuisine[5], ConsumeItemAch.PandarenDelicacies[5] = PandaEats, PandaEats2
    if (Overachiever_Debug) then  chatprint("Skipped food/drink lookup table rebuild: Retrieved from saved variables.");  end
  end
  -- Since the API gives us data on criteria completion, we don't need char vars for this so gather their data now: (some achievements from above should probably be given this treatment instead)
  Overachiever.BuildItemLookupTab(THIS_VERSION, OVERACHIEVER_ACHID.DraenorCuisine, nil, DraenorEats, nil, true)
  Overachiever.BuildItemLookupTab(THIS_VERSION, OVERACHIEVER_ACHID.BrewfestDiet, nil, BrewfestEats, nil, true)
  Overachiever.BuildItemLookupTab(THIS_VERSION, OVERACHIEVER_ACHID.DarkmoonFaireFeast, nil, DarkmoonFaireEats, nil, true)

  Overachiever.Consumed_Default = nil
end
--]=]

-- Run periodically (then "/dump TESTTAB") to see if Blizzard reinstated API-accessible tracking:
-- /run TESTTAB={};local id,i,_,a=1832,1; _, _, c, _, _, _, _, a = GetAchievementCriteriaInfo(id, i); while (a) do TESTTAB[i]=c or nil; i=i+1; _, _, c, _, _, _, _, a = GetAchievementCriteriaInfo(id, i); end
-- Only worth doing on a character that's actually consumed things on the list for ach #1832, of course.
-- Also, you can use this to get an item's ID:  /run local name,link=GameTooltip:GetItem();local _,_,id=strfind(link,"item:(%d+)");print(link,":",id)


local function ItemConsumedCheck(key, tab, itemID)
	local id = OVERACHIEVER_ACHID[key]
	local achcomplete = select(4, GetAchievementInfo(id))
	if (achcomplete and not Overachiever_Settings[ tab[1].."_whencomplete" ]) then  return;  end
	local complete = tab[5][itemID]
	if (complete ~= nil) then
		local crit
		if (complete == true) then
			-- If we already know it's complete, no need to look anything up since while it could change from incomplete to complete, the inverse isn't true.
		elseif (not tab[6]) then -- For criteria given by the API:
			crit, complete = isCriteria_asset(id, itemID)
			if (not crit) then  return;  end  -- That should never happen
			if (complete) then  tab[5][itemID] = true;  end  -- If complete, update the table so we don't have to look this criteria up again.
		else
			complete = false
		end
		local tip = complete and tab[2] or achcomplete and tab[4] or tab[3]
		--if (Overachiever_Debug) then  tip = tip .. " [ID:" .. id .. "]";  end
		return id, tip, complete, achcomplete, crit
	end
end


local function MiscItemCheck(tab)
  --local tab = MiscItemAch[itemID]
  if (not Overachiever_Settings[ tab[2] ]) then  return;  end
  local id = OVERACHIEVER_ACHID[tab[1]]
  local _, _, _, complete = GetAchievementInfo(id)
  return id, complete and tab[3] or tab[4], complete
end


function Overachiever.ExamineItem(tooltip)
	--skipNextExamineOneLiner = true
	tooltip = tooltip or this or GameTooltip  -- Workaround in case another addon breaks this
	local name, link = tooltip:GetItem() -- Issue: This doesn't reliably get the item we want?
	if (not link) then  return;  end
	local _, _, itemID  = strfind(link, "item:(%d+)")
	itemID = tonumber(itemID)
	if (not itemID) then  return;  end  -- Ignores special objects not classified as normal items, like battlepets
	local itemMinLevel

	for key,tab in pairs(ConsumeItemAch) do
		if (Overachiever_Settings[ tab[1] ]) then
			local id, text, complete, achcomplete, crit = ItemConsumedCheck(key, tab, itemID)
			if (text) then
				if (itemMinLevel == nil) then  itemMinLevel = select(5, GetItemInfo(link)) or 0;  end
				--print("itemMinLevel",itemMinLevel,id,name,UnitLevel("player"))
				storeTooltip(tooltip, id, text, complete, crit, (achcomplete or itemMinLevel > UnitLevel("player")))
			end
		end
	end

	if (MiscItemAch[itemID]) then
		local id, text, complete = MiscItemCheck(MiscItemAch[itemID])
		if (text) then
			if (itemMinLevel == nil) then  itemMinLevel = select(5, GetItemInfo(link)) or 0;  end
			storeTooltip(tooltip, id, text, complete, name, (itemMinLevel > UnitLevel("player")))
		end
	end

	outputTooltip(tooltip)
end


--[[
function Overachiever.ExamineItem(tooltip)
  --skipNextExamineOneLiner = true
  tooltip = tooltip or this or GameTooltip  -- Workaround in case another addon breaks this
  local name, link = tooltip:GetItem() -- Issue: This doesn't reliably get the item we want?
  if (not link) then  return;  end
  -- Could check IsUsableItem(link) to see if it's something in your inventory..
  local itemMinLevel, itemType, subtype = select(5, GetItemInfo(link))
  if ((itemType == LBI["Consumable"] and (subtype == LBI["Food & Drink"] or subtype == LBI["Consumable"] or subtype == LBI["Other"])) or
      (itemType == LBI["Trade Goods"] and subtype == LBI["Meat"])) then
    local _, _, itemID  = strfind(link, "item:(%d+)")
    itemID = tonumber(itemID)
    if (not itemID) then  return;  end  -- Ignores special objects not classified as normal items, like battlepets
	
    local id, text, complete, achcomplete
	local idPrev, textPrev, completePrev, achcomplete
    for key,tab in pairs(ConsumeItemAch) do
      if (Overachiever_Settings[ tab[1] ]) then
        id, text, complete, achcomplete = ItemConsumedCheck(key, tab, itemID)
        --if (text) then  break;  end -- Can't be as simple as that, or else we won't check multiple achievements to find the "least complete" one.
		if (text) then
		  if (not complete and not achcomplete) then
		    flagReminder(id, name)
			--idPrev = nil
		    --break
			idPrev, textPrev, completePrev, achcompletePrev = id, text, complete, achcomplete
		  elseif (not idPrev or (not achcomplete and (completePrev or not complete))) then
		    idPrev, textPrev, completePrev, achcompletePrev = id, text, complete, achcomplete
		  end
		end
      end
    end
	if (idPrev) then
	  id, text, complete, achcomplete = idPrev, textPrev, completePrev, achcompletePrev
	end
    if (text) then
      local r, g, b
      if (complete) then
        r, g, b = tooltip_complete.r, tooltip_complete.g, tooltip_complete.b
      else
        r, g, b = tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b
        if (not achcomplete and tooltip == GameTooltip and itemMinLevel <= UnitLevel("player")) then
          -- Extra checks needed since the previous item sometimes shows up on the tooltip?
          PlayReminder()
        end
      end
      tooltip:AddLine(text, r, g, b)
      tooltip:AddTexture(AchievementIcon)
      needtipshow = true
    end

    if (MiscItemAch[itemID]) then
      id, text, complete = MiscItemCheck(MiscItemAch[itemID])
      if (text) then
        local r, g, b
        if (complete) then
          r, g, b = tooltip_complete.r, tooltip_complete.g, tooltip_complete.b
        else
          r, g, b = tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b
          if (tooltip == GameTooltip and itemMinLevel <= UnitLevel("player")) then
            -- Extra checks needed since the previous item sometimes shows up on the tooltip?
            PlayReminder()
            flagReminder(id, name)
          end
        end
        tooltip:AddLine(text, r, g, b)
        tooltip:AddTexture(AchievementIcon)
        needtipshow = true
      end
    end

    if (needtipshow) then  tooltip:Show();  end

  end
end
--]]


local function BagUpdate(...)
  if (not Overachiever.Criteria_Updated) then  return;  end  -- Attempt to prevent unnecessary processing.
  Overachiever.Criteria_Updated = nil

  for i=1,select("#", ...),3 do
    local itemID, old, new = select(i, ...)
    --print(itemID, old, new)
    if (old > new) then
      if (TastesLikeChicken_crit[itemID]) then
        --local _, link = GetItemInfo(itemID)
        --print("You ate:",link)
        TastesLikeChicken_crit[itemID] = true
      end

      if (HappyHour_crit[itemID]) then
        --local _, link = GetItemInfo(itemID)
        --print("You drank:",link)
        HappyHour_crit[itemID] = true
      end

    end
  end

  --[[
  local oldF, oldD = numFoodConsumed, numDrinksConsumed
  numFoodConsumed = tonumber((GetStatistic(OVERACHIEVER_ACHID.Stat_ConsumeFood))) or 0  -- My theory is that GetStatistic can be a relatively slow call (and apparently it gets worse the more achievements and/or statistics-data the character has). Avoid when possible (hence the check above).
  numDrinksConsumed = tonumber((GetStatistic(OVERACHIEVER_ACHID.Stat_ConsumeDrinks))) or 0

  --print("BagUpdate",...)
  --print("BagUpdate?",numFoodConsumed,oldF < numFoodConsumed, numDrinksConsumed,oldD < numDrinksConsumed)

  local changeF, changeD = oldF < numFoodConsumed, oldD < numDrinksConsumed
  if (changeF or changeD) then
    for i=1,select("#", ...),3 do
      local itemID = select(i, ...)  --local itemID, old, new = select(i, ...)
      --print(itemID, old, new)
      --if (old > new) then
      if (changeF) then
        if (TastesLikeChicken_crit[itemID]) then
          --local _, link = GetItemInfo(itemID)
          --print("You ate:",link)
          TastesLikeChicken_crit[itemID] = true
        end
      end
      if (changeD) then
        if (HappyHour_crit[itemID]) then
          --local _, link = GetItemInfo(itemID)
          --print("You drank:",link)
          HappyHour_crit[itemID] = true
        end
      end
      --end
    end
  end
  --]]
end

--[[
local function BagUpdate(...)
  local oldF, oldD = numFoodConsumed, numDrinksConsumed
  numFoodConsumed = tonumber((GetStatistic(OVERACHIEVER_ACHID.Stat_ConsumeFood))) or 0
  numDrinksConsumed = tonumber((GetStatistic(OVERACHIEVER_ACHID.Stat_ConsumeDrinks))) or 0

  --print("BagUpdate",...)
  --print("BagUpdate?",numFoodConsumed,oldF < numFoodConsumed, numDrinksConsumed,oldD < numDrinksConsumed)

  local changeF, changeD = oldF < numFoodConsumed, oldD < numDrinksConsumed -- This isn't reliable any more. At least, it doesn't work for the newer achievements I've tried. Probably should rewrite this, not even bother grabbing these numbers, etc.
  if (changeF or changeD) then
    local itemID, old, new
    for i=1,select("#", ...),3 do
      itemID, old, new = select(i, ...)
      --print(itemID, old, new)
      --if (old > new) then
      if (changeF) then
        if (FoodCriteria[itemID]) then
          --local _, link = GetItemInfo(itemID)
          --print("You ate:",link)
          FoodCriteria[itemID] = true
          Overachiever_CharVars_Consumed.Food[itemID] = true
        end
        if (FoodCriteria2[itemID]) then
          --local _, link = GetItemInfo(itemID)
          --print("You ate:",link)
          FoodCriteria2[itemID] = true
          Overachiever_CharVars_Consumed.Food2[itemID] = true
        end
        if (PandaEats[itemID]) then -- Unfortunately, this won't be triggered because the associated consumables don't increase the statistic properly.
          if (Overachiever_Debug) then
            local _, link = GetItemInfo(itemID)
            print("You ate:",link)
          end
          PandaEats[itemID] = true
          Overachiever_CharVars_Consumed.PandaEats[itemID] = true
        end
        if (PandaEats2[itemID]) then -- Unfortunately, this won't be triggered because the associated consumables don't increase the statistic properly.
          if (Overachiever_Debug) then
            local _, link = GetItemInfo(itemID)
            print("You ate:",link)
          end
          PandaEats2[itemID] = true
          Overachiever_CharVars_Consumed.PandaEats2[itemID] = true
        end
      end
      if (changeD) then
        if (DrinkCriteria[itemID]) then
          --local _, link = GetItemInfo(itemID)
          --print("You drank:",link)
          DrinkCriteria[itemID] = true
          Overachiever_CharVars_Consumed.Drink[itemID] = true
        end
        if (DrinkCriteria2[itemID]) then
          --local _, link = GetItemInfo(itemID)
          --print("You drank:",link)
          DrinkCriteria2[itemID] = true
          Overachiever_CharVars_Consumed.Drink2[itemID] = true
        end
        if (PandaEats[itemID]) then -- Unfortunately, this won't be triggered because the associated consumables don't increase the statistic properly.
          if (Overachiever_Debug) then
            local _, link = GetItemInfo(itemID)
            print("You drank:",link)
          end
          PandaEats[itemID] = true
          Overachiever_CharVars_Consumed.PandaEats[itemID] = true
        end
        if (PandaEats2[itemID]) then -- Unfortunately, this won't be triggered because the associated consumables don't increase the statistic properly.
          if (Overachiever_Debug) then
            local _, link = GetItemInfo(itemID)
            print("You drank:",link)
          end
          PandaEats2[itemID] = true
          Overachiever_CharVars_Consumed.PandaEats2[itemID] = true
        end
      end
      --end
    end
  end
end
--]]

TjBagWatch.RegisterFunc(BagUpdate, true)


-- MISSIONS
-------------

local missionsFrame = CreateFrame("frame")
Overachiever.MissionsFrame = missionsFrame


local MissionAch = {
	MissionBarrens = true,
	MissionLordaeron = true,
	MissionKalimdor = true
}

local function MissionCheck(key, missionID)
	local id = OVERACHIEVER_ACHID[key]
	--local achcomplete = select(4, GetAchievementInfo(id))
	local _, name, _, achcomplete = GetAchievementInfo(id)
	if (achcomplete and not Overachiever_Settings.Mission_complete_whencomplete) then  return;  end
	local crit, complete = isCriteria_asset(id, missionID)
	if (not crit) then  return;  end
	local tip = complete and L.ACH_MISSIONCOMPLETE_COMPLETE or achcomplete and L.ACH_MISSIONCOMPLETE_INCOMPLETE_EXTRA or L.ACH_MISSIONCOMPLETE_INCOMPLETE
	if (IsShiftKeyDown()) then
		tip = tip .. "|n    [" .. name .. "]"
	end
	return id, tip, complete, achcomplete, crit
end

local function getMissionID(button)
	if (button.info) then
		return button.info.missionID
	else
		if (GarrisonLandingPageReport and GarrisonLandingPageReport.List) then
			-- See function GarrisonLandingPageReportMission_OnEnter in Blizzard_GarrisonLandingPage.lua:
			local items = GarrisonLandingPageReport.List.items
			if GarrisonLandingPageReport.selectedTab == GarrisonLandingPageReport.Available then
				items = GarrisonLandingPageReport.List.AvailableItems;
			end
			local item = items[button.id]
			if (item) then
				return item.missionID
			end
		end
	end
	return false
	--GarrisonLandingPageReport.List.AvailableItems
end

local function missionButtonOnEnter(self, ...)
	if (Overachiever_Settings.Mission_complete) then
		--local name = self.info and self.info.name or self.Title and self.Title:GetText()
		local missionID = getMissionID(self)
		if (missionID) then
      --print("mission",missionID)
			local id, text, complete
			for key,tab in pairs(MissionAch) do
				local id, text, complete, achComplete, crit = MissionCheck(key, missionID)
				if (text) then
					local r, g, b
					if (complete) then
						r, g, b = tooltip_complete.r, tooltip_complete.g, tooltip_complete.b
					else
						r, g, b = tooltip_incomplete.r, tooltip_incomplete.g, tooltip_incomplete.b
					end
					GameTooltip:AddLine(" ")
					addTooltipLineWithTexture(GameTooltip, text, AchievementIcon, r, g, b)
					GameTooltip:Show()

					if (not complete) then
						flagReminder(id, crit)
						--[[
						-- Two ways to get the name; both of them work.
						--local info = C_Garrison.GetBasicMissionInfo(missionID)
						--flagReminder(id, info.name)
						-- Went with this way since it seems less likely there'd be a localization problem, though I'm pretty sure the other way is fine, too:
						local name = self.info and self.info.name or self.Title and self.Title:GetText()
						flagReminder(id, name)
						--]]
					end

					break
				end
			end
		end
	end
	-- If we want to check by name instead:
	--local name = self.Title and self.Title:GetText()
	-- self.info.missionID : Can see it on BFAMissionFrameMissionsListScrollFrameButton1 but not GarrisonLandingPageReportListListScrollFrameButton1, so we
	-- have to rely on name. (Likewise, we see self.info.name on the former but not the latter, so we get the name from self.Title:GetText() instead.)
end


missionsFrame:RegisterEvent("ADDON_LOADED")

missionsFrame:SetScript("OnEvent", function(self, event, arg1, ...)
	--print("MissionsFrame OnEvent", event, arg1, ...)
	if (event == "ADDON_LOADED" and arg1 == "Blizzard_GarrisonUI") then
		missionsFrame:UnregisterEvent("ADDON_LOADED")
		Overachiever.MissionsFrame, missionsFrame = nil, nil
		for k,v in pairs(BFAMissionFrameMissionsListScrollFrame.buttons) do
			-- BFAMissionFrameMissionsListScrollFrameButton1 thru ...Button9
			v:HookScript("OnEnter", missionButtonOnEnter)
			--print(v:GetName())
		end
		for k,v in pairs(GarrisonLandingPageReportListListScrollFrame.buttons) do
			-- GarrisonLandingPageReportListListScrollFrameButton1 thru ...Button10
			v:HookScript("OnEnter", missionButtonOnEnter)
		end
	end
end)


-- Register some Blizzard sounds
----------------------------------

if (SharedMedia) then
  -- File ID lookup: https://wow.tools/files/
  local soundtab = {
  [566564] = L.SOUND_BELL_ALLIANCE,
  [565853] = L.SOUND_BELL_HORDE,
  [566558] = L.SOUND_BELL_NIGHTELF,
  [566027] = L.SOUND_DRUMHIT,
  [566652] = L.SOUND_BELL_BOATARRIVED,
  [565564] = L.SOUND_GONG_TROLL,
  [568154] = L.SOUND_BELL_MELLOW,

  [568587] = L.SOUND_ENTERQUEUE,
  [568924] = L.SOUND_HEARTHBIND,
  [566254] = L.SOUND_BELL_KARA,

  [567482] = L.SOUND_DING_AUCTION,
  [567499] = L.SOUND_BELL_AUCTION,
  [567436] = L.SOUND_ALARM1,
  [567399] = L.SOUND_ALARM2,
  [567458] = L.SOUND_ALARM3,
  [567416] = L.SOUND_MAP_PING,

  [568232] = L.SOUND_SIMON_DING,
  [569664] = L.SOUND_SIMON_STARTGAME,
  [569518] = L.SOUND_SIMON_STARTLEVEL,
  [568975] = L.SOUND_SIMON_BADPRESS,
  [568156] = L.SOUND_SIMON_FAIL_LARGE,
  [569335] = L.SOUND_SIMON_FAIL_SMALL,

  [568382] = L.SOUND_YAR,

  [567401] = L.SOUND_AGGRO_WARNING,
  [567471] = L.SOUND_AGGRO_PULLED,
  [567404] = L.SOUND_GLYPH_CREATE_MAJOR,
  [567487] = L.SOUND_GLYPH_CREATE_MINOR,
  [567410] = L.SOUND_GLYPH_DESTROY_MAJOR,
  [567447] = L.SOUND_GLYPH_DESTROY_MINOR,
  [1074321] = L.SOUND_GARRISON_INVASION,

  [567474] = L.SOUND_BGTIMER,
  [567438] = L.SOUND_BGTIMER_END,
  [648409] = L.SOUND_MEDAL_EXPIRES,
  [667359] = L.SOUND_MEDAL_GOLDTOSILVER,
  [667361] = L.SOUND_MEDAL_SILVERTOBRONZE,

  [569593] = L.SOUND_LEVELUP,
  [1053670] = L.SOUND_BONUSEVENT,
  [899283] = L.SOUND_DIGSITE_COMPLETE,
  [959042] = L.SOUND_STORE_CONFIRM,
  [567522] = L.SOUND_CHAR_CREATE,
  [567439] = L.SOUND_QUEST_COMPLETE,

  --[[
  -- Old, pre WoW 8.2:
  ["Sound\\Doodad\\BellTollAlliance.ogg"] = L.SOUND_BELL_ALLIANCE,
  ["Sound\\Doodad\\BellTollHorde.ogg"] = L.SOUND_BELL_HORDE,
  ["Sound\\Doodad\\BellTollNightElf.ogg"] = L.SOUND_BELL_NIGHTELF,
  ["Sound\\Doodad\\BellTollTribal.ogg"] = L.SOUND_DRUMHIT,
  ["Sound\\Doodad\\BoatDockedWarning.ogg"] = L.SOUND_BELL_BOATARRIVED,
  ["Sound\\Doodad\\G_GongTroll01.ogg"] = L.SOUND_GONG_TROLL,
  ["Sound\\Spells\\ShaysBell.ogg"] = L.SOUND_BELL_MELLOW,

  ["Sound\\Spells\\PVPEnterQueue.ogg"] = L.SOUND_ENTERQUEUE,
  ["Sound\\Spells\\bind2_Impact_Base.ogg"] = L.SOUND_HEARTHBIND,
  ["Sound\\Doodad\\KharazahnBellToll.ogg"] = L.SOUND_BELL_KARA,

  ["Sound\\Interface\\AuctionWindowOpen.ogg"] = L.SOUND_DING_AUCTION,
  ["Sound\\Interface\\AuctionWindowClose.ogg"] = L.SOUND_BELL_AUCTION,
  ["Sound\\Interface\\AlarmClockWarning1.ogg"] = L.SOUND_ALARM1,
  ["Sound\\Interface\\AlarmClockWarning2.ogg"] = L.SOUND_ALARM2,
  ["Sound\\Interface\\AlarmClockWarning3.ogg"] = L.SOUND_ALARM3,
  ["Sound\\Interface\\MapPing.ogg"] = L.SOUND_MAP_PING,

  ["Sound\\Spells\\SimonGame_Visual_GameTick.ogg"] = L.SOUND_SIMON_DING,
  ["Sound\\Spells\\SimonGame_Visual_LevelStart.ogg"] = L.SOUND_SIMON_STARTGAME,
  ["Sound\\Spells\\SimonGame_Visual_GameStart.ogg"] = L.SOUND_SIMON_STARTLEVEL,

  ["Sound\\Spells\\YarrrrImpact.ogg"] = L.SOUND_YAR,

  ["Sound\\Interface\\Aggro_Enter_Warning_State.ogg"] = L.SOUND_AGGRO_WARNING,
  ["Sound\\Interface\\Aggro_Pulled_Aggro.ogg"] = L.SOUND_AGGRO_PULLED,
  ["Sound\\Interface\\Glyph_MajorCreate.ogg"] = L.SOUND_GLYPH_CREATE_MAJOR,
  ["Sound\\Interface\\Glyph_MinorCreate.ogg"] = L.SOUND_GLYPH_CREATE_MINOR,
  ["Sound\\Interface\\Glyph_MajorDestroy.ogg"] = L.SOUND_GLYPH_DESTROY_MAJOR,
  ["Sound\\Interface\\Glyph_MinorDestroy.ogg"] = L.SOUND_GLYPH_DESTROY_MINOR,
  ["Sound\\Interface\\UI_BattlegroundCountdown_Timer.ogg"] = L.SOUND_BGTIMER,
  ["Sound\\Interface\\UI_Challenges_MedalExpires.ogg"] = L.SOUND_MEDAL_EXPIRES,
  ["Sound\\Interface\\UI_Garrison_Toast_InvasionAlert.ogg"] = L.SOUND_GARRISON_INVASION,
  --]]
  --[[ don't work for some reason
  
  ["Sound\\Interface\\GLUECREATECHARACTERBUTTON.mp3"] = "Create Character",
  ["Sound\\Interface\\UI_igStore_PurchaseDelivered_Toast_01.ogg"] = "Store Delivered",
  ["Sound\\Interface\\Deathbind Sound.ogg"] = "Deathbind",
  ["Sound\\Interface\\FX_Shimmer_Whoosh_Generic.ogg"] = "Shimmer Whoosh",

  ["Sound\\Interface\\UI_BattlegroundCountdown_Finished.ogg"] = "Battleground Countdown Finished",

  -- Found these or something apparently similar. Now using File IDs.
  ["Sound\\Interface\\UI_DigsiteCompletion_Toast.ogg"] = "Digsite Complete",
  ["Sound\\Interface\\UI_Garrison_Invasion_AlertPing.ogg"] = "Garrison Invasion Alert",
  ["Sound\\Interface\\UI_igStore_ConfirmPurchase_Button.ogg"] = "Store Confirmation",
  ["Sound\\Interface\\UI_Challenges_MedalExpires_GoldtoSilver.ogg"] = "Medal Gold to Silver",
  ["Sound\\Interface\\UI_Challenges_MedalExpires_SilvertoBronze.ogg"] = "Medal Silver to Bronze",
  ["Sound\\Interface\\gsCharacterCreationCreateChar.ogg"] = "Create Character",
  ["Sound\\Interface\\UI_AutoQuestComplete.ogg"] = "Auto Quest Complete",
  ["Sound\\Interface\\UI_BonusEventSystemVignettes.ogg"] = "Bonus Event",
  --]]
  }
  for data,name in pairs(soundtab) do
    local key = "Blizzard: "..name
    if (not SharedMedia:Register("sound", key, data)) then
	  if (not SharedMedia:IsValid("sound", key)) then
	    chatprint('Error: Failed to register Blizzard sound "' .. name .. '"')
	  end
	--else chatprint('Registered ' .. name .. ' with ' ..data)
	end
  end
  soundtab = nil
end


-- Default consumable items list
----------------------------------

Overachiever.Consumed_Default = {
	TastesLikeChicken = {
		[27657] = 0,
		[6038] = 0,
		[21030] = 0,
		[44072] = 0,
		[16168] = 0,
		[20064] = 0,
		--[62660] = 0,
		[4537] = 0,
		[4539] = 0,
		[4541] = 0,
		[18635] = 0,
		[22236] = 0,
		[5066] = 0,
		[1017] = 0,
		[34747] = 0,
		[20224] = 0,
		[21254] = 0,
		[27635] = 0,
		[21240] = 0,
		[34762] = 0,
		[17198] = 0,
		[27857] = 0,
		[22324] = 0,
		[17222] = 0,
		[8543] = 0,
		[12212] = 0,
		[12216] = 0,
		[24408] = 0,
		--[19306] = 0,
		[33454] = 0,
		[42431] = 0,
		[9681] = 0,
		[2680] = 0,
		[24009] = 0,
		[4599] = 0,
		[4601] = 0,
		[4603] = 0,
		[4605] = 0,
		[4607] = 0,
		[34125] = 0,
		[24008] = 0,
		[6657] = 0,
		[8950] = 0,
		--[59228] = 0,
		[12224] = 0,
		[2683] = 0,
		[34748] = 0,
		[34764] = 0,
		[34780] = 0,
		[43004] = 0,
		[27658] = 0,
		[21023] = 0,
		[21031] = 0,
		[24105] = 0,
		[33872] = 0,
		[5525] = 0,
		[2070] = 0,
		[21071] = 0,
		--[34065] = 0,
		--[33024] = 0,
		[7228] = 0,
		[13889] = 0,
		[18045] = 0,
		[34765] = 0,
		[6290] = 0,
		[35563] = 0,
		--[62662] = 0,
		[34062] = 0,
		[30357] = 0,
		[23211] = 0,
		[17119] = 0,
		[13929] = 0,
		[13933] = 0,
		--[33026] = 0,
		[42350] = 0,
		[27858] = 0,
		[4457] = 0,
		--[59227] = 0,
		[34749] = 0,
		[42430] = 0,
		[34767] = 0,
		[11952] = 0,
		[12763] = 0,
		[43005] = 0,
		[17199] = 0,
		[8364] = 0,
		--[62677] = 0,
		[42779] = 0,
		--[62661] = 0,
		[35947] = 0,
		[29453] = 0,
		--[33025] = 0,
		[27665] = 0,
		[19994] = 0,
		[20223] = 0,
		[3663] = 0,
		[21217] = 0,
		[23435] = 0,
		--[62663] = 0,
		--[34063] = 0,
		[6316] = 0,
		[37252] = 0,
		--[34064] = 0,
		[13546] = 0,
		[787] = 0,
		[7807] = 0,
		[8959] = 0,
		[22238] = 0,
		[32721] = 0,
		[2687] = 0,
		[34750] = 0,
		[42942] = 0,
		[34763] = 0,
		[27651] = 0,
		[27659] = 0,
		[27667] = 0,
		[6807] = 0,
		[3664] = 0,
		[3665] = 0,
		[3666] = 0,
		[16169] = 0,
		[21072] = 0,
		[6308] = 0,
		[1326] = 0,
		[20074] = 0,
		[19060] = 0,
		[22645] = 0,
		[12209] = 0,
		[23172] = 0,
		[35565] = 0,
		--[62664] = 0,
		--[62680] = 0,
		[30358] = 0,
		[12213] = 0,
		[30355] = 0,
		[2679] = 0,
		[5476] = 0,
		[1114] = 0,
		[2684] = 0,
		--[59231] = 0,
		[41729] = 0,
		[40356] = 0,
		[33218] = 0,
		[42432] = 0,
		[35948] = 0,
		[13888] = 0,
		[29448] = 0,
		[43518] = 0,
		[33825] = 0,
		[6362] = 0,
		[33866] = 0,
		[29393] = 0,
		[43087] = 0,
		[35949] = 0,
		[12217] = 0,
		[13754] = 0,
		[13758] = 0,
		[2682] = 0,
		[20857] = 0,
		[75028] = 0,
		[2685] = 0,
		--[62649] = 0,
		--[62665] = 0,
		--[33043] = 0,
		[42433] = 0,
		[27661] = 0,
		[17344] = 0,
		[3220] = 0,
		[20031] = 0,
		[13810] = 0,
		[35710] = 0,
		--[59232] = 0,
		[32722] = 0,
		--[58275] = 0,
		--[58258] = 0,
		[75029] = 0,
		[42434] = 0,
		[117] = 0,
		[27660] = 0,
		[3726] = 0,
		[21033] = 0,
		[3728] = 0,
		[3729] = 0,
		[33874] = 0,
		[43088] = 0,
		[35950] = 0,
		--[33246] = 0,
		[43647] = 0,
		[33443] = 0,
		[19061] = 0,
		[27664] = 0,
		[75030] = 0,
		[34768] = 0,
		[11415] = 0,
		--[62666] = 0,
		[21153] = 0,
		[30359] = 0,
		[6458] = 0,
		[35287] = 0,
		[13930] = 0,
		[13934] = 0,
		[23756] = 0,
		[34760] = 0,
		[22239] = 0,
		[67270] = 0,
		[40358] = 0,
		[34753] = 0,
		[75031] = 0,
		[1113] = 0,
		[43488] = 0,
		[29449] = 0,
		[5472] = 0,
		[11950] = 0,
		[8365] = 0,
		[5480] = 0,
		[37452] = 0,
		[5474] = 0,
		[35951] = 0,
		[5478] = 0,
		[19301] = 0,
		[67271] = 0,
		[27859] = 0,
		[75032] = 0,
		[3770] = 0,
		[3771] = 0,
		--[62651] = 0,
		--[62667] = 0,
		[8932] = 0,
		[3727] = 0,
		[6522] = 0,
		[34754] = 0,
		[8948] = 0,
		[8952] = 0,
		--[58276] = 0,
		[45932] = 0,
		[24539] = 0,
		[67272] = 0,
		[40359] = 0,
		--[58260] = 0,
		[8075] = 0,
		[42429] = 0,
		[19996] = 0,
		[5526] = 0,
		[21537] = 0,
		[38427] = 0,
		[20390] = 0,
		[1082] = 0,
		[16166] = 0,
		[16170] = 0,
		[35952] = 0,
		[33924] = 0,
		[45901] = 0,
		[67273] = 0,
		[19062] = 0,
		[2287] = 0,
		[75034] = 0,
		[12215] = 0,
		--[62652] = 0,
		--[62668] = 0,
		[4538] = 0,
		[4540] = 0,
		[4542] = 0,
		[4544] = 0,
		[5057] = 0,
		[414] = 0,
		[12214] = 0,
		[12218] = 0,
		[29394] = 0,
		[13760] = 0,
		[13756] = 0,
		[34755] = 0,
		[75035] = 0,
		[36831] = 0,
		[43490] = 0,
		[42995] = 0,
		[23326] = 0,
		[44049] = 0,
		[961] = 0,
		[28486] = 0,
		[4602] = 0,
		[12210] = 0,
		[35953] = 0,
		[5095] = 0,
		[13755] = 0,
		[13759] = 0,
		[22895] = 0,
		[4592] = 0,
		[75036] = 0,
		[43015] = 0,
		--[62653] = 0,
		--[62669] = 0,
		[20388] = 0,
		[4604] = 0,
		[4606] = 0,
		[4608] = 0,
		[24540] = 0,
		[43523] = 0,
		[6361] = 0,
		[65499] = 0,
		[20452] = 0,
		[29452] = 0,
		[34759] = 0,
		[34756] = 0,
		--[58278] = 0,
		[30458] = 0,
		[43491] = 0,
		[42996] = 0,
		[20516] = 0,
		[20222] = 0,
		--[58265] = 0,
		[43571] = 0,
		[16971] = 0,
		[21236] = 0,
		[40202] = 0,
		[33048] = 0,
		[39691] = 0,
		[13931] = 0,
		[30816] = 0,
		[4656] = 0,
		[37583] = 0,
		[23175] = 0,
		--[62654] = 0,
		--[62670] = 0,
		[43268] = 0,
		[30361] = 0,
		[13935] = 0,
		[13927] = 0,
		[18632] = 0,
		[422] = 0,
		[42342] = 0,
		[27854] = 0,
		[12238] = 0,
		--[58263] = 0,
		[21235] = 0,
		[34757] = 0,
		--[58279] = 0,
		[42994] = 0,
		[43492] = 0,
		[42997] = 0,
		[23327] = 0,
		[34751] = 0,
		[38428] = 0,
		[43572] = 0,
		[11951] = 0,
		[11444] = 0,
		[2681] = 0,
		[6888] = 0,
		[28501] = 0,
		[24421] = 0,
		[23160] = 0,
		[8953] = 0,
		[37584] = 0,
		[6317] = 0,
		--[62655] = 0,
		--[62671] = 0,
		[20389] = 0,
		[2888] = 0,
		[33449] = 0,
		--[58264] = 0,
		[32685] = 0,
		[7806] = 0,
		[7808] = 0,
		[35285] = 0,
		[724] = 0,
		[42998] = 0,
		[20557] = 0,
		[34758] = 0,
		--[58280] = 0,
		[6289] = 0,
		[27655] = 0,
		[27663] = 0,
		[6303] = 0,
		--[33254] = 0,
		[6299] = 0,
		[1707] = 0,
		[16167] = 0,
		[16171] = 0,
		[6291] = 0,
		[20062] = 0,
		[11584] = 0,
		[3927] = 0,
		[8957] = 0,
		[29292] = 0,
		[37585] = 0,
		[23495] = 0,
		--[62656] = 0,
		[24338] = 0,
		--[62676] = 0,
		[11109] = 0,
		[29451] = 0,
		--[19223] = 0,
		[18633] = 0,
		--[68687] = 0,
		[41751] = 0,
		[27855] = 0,
		[4594] = 0,
		[18255] = 0,
		[29412] = 0,
		[33226] = 0,
		[733] = 0,
		[43478] = 0,
		--[19224] = 0,
		[42999] = 0,
		[13724] = 0,
		[65515] = 0,
		[13851] = 0,
		[27662] = 0,
		--[58262] = 0,
		[12211] = 0,
		[5349] = 0,
		[37582] = 0,
		--[19304] = 0,
		[3448] = 0,
		[6890] = 0,
		[29450] = 0,
		--[58277] = 0,
		--[58261] = 0,
		--[62657] = 0,
		[7097] = 0,
		[30610] = 0,
		[4536] = 0,
		--[58259] = 0,
		--[58267] = 0,
		[32686] = 0,
		[31672] = 0,
		[22237] = 0,
		[30155] = 0,
		[17408] = 0,
		[20225] = 0,
		[27636] = 0,
		--[58266] = 0,
		[22019] = 0,
		[34752] = 0,
		[27656] = 0,
		[43000] = 0,
		[65500] = 0,
		[65516] = 0,
		[17407] = 0,
		[8243] = 0,
		[21552] = 0,
		[14894] = 0,
		[4593] = 0,
		[20063] = 0,
		[34770] = 0,
		[33451] = 0,
		[1487] = 0,
		[29293] = 0,
		[75033] = 0,
		[33004] = 0,
		--[62658] = 0,
		[34769] = 0,
		[33052] = 0,
		--[58269] = 0,
		[18254] = 0,
		[13928] = 0,
		[13932] = 0,
		[42993] = 0,
		[6887] = 0,
		[27856] = 0,
		[5527] = 0,
		[19696] = 0,
		[20226] = 0,
		[34761] = 0,
		[19995] = 0,
		[43480] = 0,
		--[19225] = 0,
		[43001] = 0,
		[17197] = 0,
		[65517] = 0,
		[44071] = 0,
		[33867] = 0,
		[5473] = 0,
		[34410] = 0,
		[5477] = 0,
		[5479] = 0,
		--[19305] = 0,
		[33452] = 0,
		[16766] = 0,
		[21215] = 0,
		[17406] = 0,
		[20227] = 0,
		--[62659] = 0,
		[27666] = 0,
		[33053] = 0,
		[42778] = 0,
		[38706] = 0,
		[13893] = 0,
		--[73260] = 0,
		[31673] = 0,
		[75027] = 0,
		[28112] = 0,
		[74921] = 0,
		[42428] = 0,
		[3662] = 0,
		--[58268] = 0,
		[8076] = 0,
		[24072] = 0,
		[34766] = 0,
	},
	HappyHour = {
		[33030] = 0,
		[37899] = 0,
		[37907] = 0,
		[32668] = 0,
		[23492] = 0,
		[24006] = 0,
		[46402] = 0,
		[17404] = 0,
		[37493] = 0,
		[21241] = 0,
		[22779] = 0,
		[22018] = 0,
		--[19221] = 0,
		[30457] = 0,
		[34019] = 0,
		[23584] = 0,
		[8766] = 0,
		[33031] = 0,
		[34832] = 0,
		[37900] = 0,
		[37908] = 0,
		[2593] = 0,
		[42777] = 0,
		[44570] = 0,
		[2595] = 0,
		[2723] = 0,
		[2596] = 0,
		[44618] = 0,
		[40036] = 0,
		[37494] = 0,
		[61982] = 0,
		[21114] = 0,
		[33956] = 0,
		[34020] = 0,
		[1179] = 0,
		[33032] = 0,
		[27553] = 0,
		[15723] = 0,
		[37909] = 0,
		[38698] = 0,
		[24007] = 0,
		[23246] = 0,
		[4952] = 0,
		[4953] = 0,
		[1119] = 0,
		[34411] = 0,
		[44619] = 0,
		[27860] = 0,
		[37495] = 0,
		[61983] = 0,
		[38300] = 0,
		--[19222] = 0,
		[43695] = 0,
		[17198] = 0,
		[34021] = 0,
		[23585] = 0,
		[29454] = 0,
		[33033] = 0,
		[37902] = 0,
		[3772] = 0,
		[29482] = 0,
		[33445] = 0,
		[29401] = 0,
		[38430] = 0,
		[18269] = 0,
		[34412] = 0,
		[44620] = 0,
		[37488] = 0,
		[37496] = 0,
		[61984] = 0,
		[37901] = 0,
		[37489] = 0,
		[13813] = 0,
		[42381] = 0,
		[9360] = 0,
		[40357] = 0,
		[23704] = 0,
		[40042] = 0,
		[43696] = 0,
		[1322] = 0,
		[34022] = 0,
		[23161] = 0,
		[21721] = 0,
		[29395] = 0,
		[33034] = 0,
		[2894] = 0,
		[159] = 0,
		[37903] = 0,
		[5265] = 0,
		[38429] = 0,
		[38294] = 0,
		[37492] = 0,
		[44573] = 0,
		[29112] = 0,
		[1262] = 0,
		[8077] = 0,
		[8078] = 0,
		[8079] = 0,
		[17402] = 0,
		[2136] = 0,
		[32455] = 0,
		[35720] = 0,
		[36748] = 0,
		[32722] = 0,
		[31451] = 0,
		[11846] = 0,
		--[62790] = 0,
		[44616] = 0,
		[37904] = 0,
		--[33234] = 0,
		[1645] = 0,
		[17199] = 0,
		[9260] = 0,
		--[58256] = 0,
		[23586] = 0,
		--[62675] = 0,
		[33035] = 0,
		[19318] = 0,
		[38350] = 0,
		[46319] = 0,
		[30499] = 0,
		[1205] = 0,
		[44716] = 0,
		[44574] = 0,
		[4791] = 0,
		[41731] = 0,
		--[19299] = 0,
		[4595] = 0,
		[18287] = 0,
		[46399] = 0,
		[38466] = 0,
		[37490] = 0,
		[10841] = 0,
		[61986] = 0,
		[23176] = 0,
		--[58274] = 0,
		[23164] = 0,
		[17048] = 0,
		--[44941] = 0,
		--[59229] = 0,
		--[33236] = 0,
		[28284] = 0,
		[30858] = 0,
		[19997] = 0,
		[32667] = 0,
		--[58257] = 0,
		[44575] = 0,
		[33028] = 0,
		[33036] = 0,
		[3703] = 0,
		[30615] = 0,
		[37905] = 0,
		[39738] = 0,
		[38431] = 0,
		--[59230] = 0,
		--[62672] = 0,
		[32424] = 0,
		[9361] = 0,
		[23848] = 0,
		[37497] = 0,
		[21151] = 0,
		[46400] = 0,
		[17403] = 0,
		[37491] = 0,
		[33929] = 0,
		[5342] = 0,
		[20709] = 0,
		[22778] = 0,
		[37499] = 0,
		--[74822] = 0,
		--[62674] = 0,
		[38320] = 0,
		[30703] = 0,
		[5350] = 0,
		[17196] = 0,
		[34017] = 0,
		[2288] = 0,
		[28399] = 0,
		[1708] = 0,
		[2686] = 0,
		[33029] = 0,
		[37498] = 0,
		[37898] = 0,
		[37906] = 0,
		--[59029] = 0,
		[38432] = 0,
		[39520] = 0,
		[33042] = 0,
		[4600] = 0,
		[43086] = 0,
		--[19300] = 0,
		[18284] = 0,
		[18288] = 0,
		[46401] = 0,
		[35954] = 0,
		[18300] = 0,
		[2594] = 0,
		[37253] = 0,
		[44571] = 0,
		[33444] = 0,
		[32453] = 0,
		[30309] = 0,
		[9451] = 0,
		[12003] = 0,
		[7676] = 0,
		[44617] = 0,
		[46403] = 0,
		[34018] = 0,
		[40035] = 0,
		[61985] = 0,
	}
}
