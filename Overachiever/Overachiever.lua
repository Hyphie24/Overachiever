
--
--  Overachiever
--    by Tuhljin
--

--Overachiever_Debug = true

local THIS_VERSION = GetAddOnMetadata("Overachiever", "Version")
local THIS_TITLE = GetAddOnMetadata("Overachiever", "Title")

local LINK_CTRL_TRACK_SERIES = false

local ACHINFO_NAME = 2

Overachiever = {}
local Overachiever = Overachiever

local L = OVERACHIEVER_STRINGS

local CATEGORIES_ALL
local CATEGORY_EXPLOREROOT, CATEGORIES_EXPLOREZONES
local OptionsPanel, openOptions
local MadeDraggable_AchFrame, MadeDragSave_AchFrame

local COSMIC_MAP_ID = 946

local TexAlert = "Interface\\AddOns\\Overachiever\\AlertGreenLine"
local TexAlertBorders = "Interface\\AddOns\\Overachiever\\AlertBordersGreen"

-- Possible return values from getEmbeddedFactionIcon() in FrameXML\MapBar.lua:
local IconAlliance = "|TInterface\\TargetingFrame\\UI-PVP-ALLIANCE:19:16:0:0:64:64:0:32:0:38|t"
local IconHorde = "|TInterface\\TargetingFrame\\UI-PVP-HORDE:18:19:0:0:64:64:0:38:0:36|t"

--local IconNotReadyX = "|TInterface\\RaidFrame\\ReadyCheck-NotReady:14:14:0:0|t"


--[[ This is no longer used. Instead, use the "Startup: Throttle achievement lookup" setting in Overachiever options.
-- Set this to true to make the achievement criteria lookup builder run in a background task after entering the world instead of
-- during startup. Also see the variable BUILD_CRIT_STEPS in libs/TjAchieve.lua.
local THROTTLE_ACHLOOKUP = true
--]]

-- BFA
local WOW_BFA = select(4, GetBuildInfo()) >= 80000
local OpenCalendar = OpenCalendar or C_Calendar.OpenCalendar
local AlertFrame_PauseOutAnimation = WOW_BFA and AlertFrame_PauseOutAnimation or AlertFrame_StopOutAnimation
-- BFA


local GetAchievementInfo = GetAchievementInfo

-- Overcome problem where GetAchievementCriteriaInfo throws an error if the achievement ID or criteria number is invalid:
do
  local GAI = GetAchievementCriteriaInfo
  function Overachiever.GetAchievementCriteriaInfo(...)
    if (pcall(GAI, ...)) then
      return GAI(...); -- Calling it again instead of saving values from previous call seems to be better since we would have to deal with new tables, unpack, manipulating the table for unpack to actually work as expected, etc.
      --tremove(achievementInfo, 1)
      --achievementInfo[#achievementInfo+1] = ''; -- Inserting this on the end is necessary for unpack to work as expected if there are any nil values in the table.
      --return unpack(achievementInfo)
    end
  end
end
local GetAchievementCriteriaInfo = Overachiever.GetAchievementCriteriaInfo


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

local function emptyfunc()  end


local function chatprint(msg, premsg)
  premsg = premsg or "["..THIS_TITLE.."]"
  DEFAULT_CHAT_FRAME:AddMessage("|cff7eff00"..premsg.."|r "..msg, 0.741, 1, 0.467);
end
Overachiever.chatprint = chatprint

local function BuildCategoryInfo()
  CATEGORY_EXPLOREROOT = GetAchievementCategory(OVERACHIEVER_ACHID.WorldExplorer);
  CATEGORIES_EXPLOREZONES = {};
  local name, parentID
  local CATEGORIES_INDIV_ALL = GetCategoryList()
  for i,id in ipairs(CATEGORIES_INDIV_ALL) do
    name, parentID = GetCategoryInfo(id)
    if (parentID == CATEGORY_EXPLOREROOT) then
      CATEGORIES_EXPLOREZONES[#(CATEGORIES_EXPLOREZONES) + 1] = id;
    end
  end
end

local function getSelectedAchievement(ignoreTab, ignoreFilter)
  if (AchievementFrame and (ignoreTab or AchievementFrame.selectedTab == 1)) then
    if (ignoreFilter or ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrame_GetCategoryNumAchievements_All) then
      return AchievementFrameAchievements.selection
    end
    local id = AchievementFrameAchievements.selection
    local _, _, _, complete = GetAchievementInfo(id)
    if ((complete and ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrame_GetCategoryNumAchievements_Complete) or
        (not complete and ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrame_GetCategoryNumAchievements_Incomplete)) then
      return id
    end
  end
end

local function expandCategory(category)
-- Based on part of AchievementFrame_SelectAchievement() in Blizzard_AchievementUI.lua
  for i, entry in next, ACHIEVEMENTUI_CATEGORIES do
    if ( entry.id == category ) then
      entry.collapsed = false;
    elseif ( entry.parent == category ) then
      entry.hidden = false;
    end
  end
  AchievementFrameCategories_Update()
end

--[[
local function isAchievementInUI(id, checkNext, allowStatistic)
-- Return true if the achievement should be found in the standard UI
  local StartTime
  if (Overachiever_Debug) then  StartTime = debugprofilestop();  end
  if (not allowStatistic) then -- Attempting to open to a statistic through AchievementFrame_SelectAchievement can cause WoW to crash.
    local _, _, _, _, _, _, _, _, flags = GetAchievementInfo(id)
	local flag_statistic = 0x00000001 -- Didn't see where Blizzard put this in their constants
	if (bit.band(flags, flag_statistic) == flag_statistic) then  return false;  end
  end
  if (checkNext) then
    local nextID, completed = GetNextAchievement(id)
    if (nextID and completed) then
      local newID;
      while ( nextID and completed ) do
        newID, completed = GetNextAchievement(nextID);
        if ( completed ) then
          nextID = newID;
        end
      end
      id = nextID;
    end
  end
  local cat = GetAchievementCategory(id)
  for i=1,GetCategoryNumAchievements(cat) do
    if (GetAchievementInfo(cat, i) == id) then
      if (Overachiever_Debug) then  print("- isAchievementInUI:"..(id or "nil")..": TRUE. Took "..(debugprofilestop() - StartTime) .." ms.");  end
      return true
    end
  end
  if (Overachiever_Debug) then  print("- isAchievementInUI:"..(id or "nil")..": FALSE. Took "..(debugprofilestop() - StartTime) .." ms.");  end
  return false
end
--]]

local function isAchievementInUI(id, checkSeries, ignoreCache)
	-- ignoreCache arg: This argument is ignored; we always use a cache now. Left it in to remind me that some places pass in true for a 3rd argument (so they
	-- should be fixed if the function signature changes later; didn't fix them now in case we need this feature again). We'll see if that causes any problems,
	-- but TjAchieve's cache *should* be accurate enough even for those places that wanted to force a recheck.
	if (checkSeries) then  return TjAchieve.IsAchievementStandard(id);  end
	return TjAchieve.IsAchievementVisible(id)
end


local function openToAchievement(id, canToggleTracking)
  assert( (type(id)=="number"), "Invalid achievement ID." )
  --if (GetPreviousAchievement(id) or isAchievementInUI(id, true)) then
  if (isAchievementInUI(id, true)) then -- GetPreviousAchievement is now redundant when checking isAchievementInUI
    local sel
    if (not AchievementFrame or not AchievementFrame:IsShown()) then
      ToggleAchievementFrame()
    elseif (canToggleTracking) then
      sel = getSelectedAchievement()
    end
    if (sel and (id == sel or TjAchieve.GetFirstSeenInSeries(id) == sel)) then
      AchievementButton_ToggleTracking(LINK_CTRL_TRACK_SERIES and sel or id)
      return true
    else
      if (Overachiever.UI_SelectAchievement(id)) then  return true;  end
    end
  end
  UIErrorsFrame:AddMessage(L.MSG_ACHNOTFOUND, 1.0, 0.1, 0.1, 1.0)
  chatprint(L.MSG_ACHNOTFOUND)
  return false
end

local function getCategoryID(name)
  local n
  for i,id in ipairs(CATEGORIES_ALL) do
    n = GetCategoryInfo(id)
    if (n == name) then  return id;  end
  end
end

local getAchievementID_cat, getAchievementID_tab
do
  local found

  local function get_arg1_argN(n, arg1, ...)
	--if (n == 1) then  return arg1, arg1;  end -- Unnecessary since it's never 1. Required if that's possible, though, or you could have errors.
    return arg1, select(n-1, ...)
  end

  function getAchievementID_cat(category, argnum, pattern, anyCase, getAll)
  -- Go over a given category, looking only at achievements that would normally be listed in the UI for the
  -- player character at this time:
    if (getAll) then  found = found and wipe(found) or {};  end
    if (anyCase) then  pattern = strlower(pattern);  end
    local id, ret, anyFound
    for i=1,GetCategoryNumAchievements(category) do
      id, ret = get_arg1_argN(argnum, GetAchievementInfo(category, i))
	    if (not id) then
        -- Absurdly, GetCategoryNumAchievements now seems to be giving the WRONG NUMBER for at least some categories. (Confirmed in WoW 6.2.2. Might have started earlier.)
		    -- Consequently, we need to watch for nil IDs and skip them.
      else
        if (anyCase) then
          if (not ret) then
            chatprint("getAchievementID_cat: ret is nil.", "["..THIS_TITLE.." DEBUG]")
            print("category:",category, "index:",i, "argnum:",argnum)
            ret = ''
          else
		  	ret = strlower(ret)
          end
        end
        if ( strfind(ret, pattern, 1, true) ) then
          if (getAll) then
            found[#(found) + 1] = id;
            anyFound = true
          else
            return id;
          end
        end
	    end
    end
    if (anyFound) then
      return found;
    end
  end

  function getAchievementID_tab(tab, argnum, pattern, anyCase, getAll)
  -- Look at achievements whose IDs are in a given table:
    if (getAll) then  found = found and wipe(found) or {};  end
    if (anyCase) then  pattern = strlower(pattern);  end
    local ret, anyFound
    for i,id in ipairs(tab) do
      ret = select(argnum, GetAchievementInfo(id))
      if (anyCase) then  ret = strlower(ret);  end
      if ( strfind(ret, pattern, 1, true) ) then
        if (getAll) then
          found[#(found) + 1] = id;
          anyFound = true
        else
          return id;
        end
      end
    end
    if (anyFound) then
      return found;
    end
  end

end

local function getAchievementID(list, argnum, pattern, anyCase)
  list = list or CATEGORIES_ALL
  if (type(list) == "table") then
    local id
    for i,cat in ipairs(list) do
      id = getAchievementID_cat(cat, argnum, pattern, anyCase)
      if (id) then  return id;  end
    end
  elseif (type(list) == "number") then
    return getAchievementID_cat(list, argnum, pattern, anyCase)
  elseif (type(list) == "string") then
    local cat = getCategoryID(list)
    assert(cat, "Category not found.")
    return getAchievementID_cat(cat, argnum, pattern, anyCase)
  end
end


--[[
local isGuildAchievement
do
  local GuildCatLookup
  function isGuildAchievement(id)
    if (not GuildCatLookup) then
      GuildCatLookup = {}
	  local CATEGORIES_GUILD_ALL = GetGuildCategoryList()
      for i,c in ipairs(CATEGORIES_GUILD_ALL) do
        GuildCatLookup[c] = true
      end
    end
    local cat = GetAchievementCategory(id)
    return GuildCatLookup[cat]
  end
end
--]]

local function isGuildAchievement(id)
	local isGuild = select(12, GetAchievementInfo(id))
	return isGuild -- Separate line so we don't also return arguments after the 12th.
end

local isUIInGuildView
do
  local fakeframe
  function isUIInGuildView()
    fakeframe = fakeframe or { border = { SetTexture = emptyfunc, SetTexCoord = emptyfunc } }
    AchievementButton_ToggleMetaView(fakeframe)  -- Done so we can find out what their local variable IN_GUILD_VIEW is currently.
    return fakeframe.guildView
  end
end

local function checkGuildMembersTooltip(frame)
  if (frame.id and not isGuildAchievement(frame.id)) then  return;  end
  local gv = isUIInGuildView()
  if (not gv) then  AchievementFrame_ToggleView();  end  -- Toggle so we're in guild mode so AchievementFrameAchievements_CheckGuildMembersTooltip will work as desired.
  AchievementFrameAchievements_CheckGuildMembersTooltip(frame)
  if (not gv) then  AchievementFrame_ToggleView();  end
end


-- ACHIEVEMENT ID LOOKUP
--------------------------

local getAllAchievements --, getAllAchievementsInCat
do
  local ALL_ACHIEVEMENTS
  function getAllAchievements(catlist)
  -- Retrieve an array of all achievement IDs, including those not normally listed in the UI for this character.
    catlist = catlist or CATEGORIES_ALL
    ALL_ACHIEVEMENTS = ALL_ACHIEVEMENTS or {}
    if (ALL_ACHIEVEMENTS[catlist]) then  return ALL_ACHIEVEMENTS[catlist];  end
    local catlookup = {}
    for i,c in ipairs(catlist) do
      catlookup[c] = true
    end
    local buildlist = {}
    local gap, i, size, id = 0, 0, 0
    --local debug_largestgap = 0
    repeat
      i = i + 1
      id = GetAchievementInfo(i)
      if (id) then
        --if (gap > debug_largestgap) then debug_largestgap = gap; print("high gap:",debug_largestgap); end
        gap = 0
        if (catlookup[GetAchievementCategory(id)]) then  size = size + 1; buildlist[size] = id;  end
      else
        gap = gap + 1
      end
    until (gap > 1000) -- 1000 is arbitrary. As of this writing, the largest gap is 79, but this is more future-safe.
    --print("last ach ID:",buildlist[size], "/ size:",size)
    catlookup = nil
    ALL_ACHIEVEMENTS[catlist] = buildlist
    return buildlist
  end

  --[[
  local ALL_ACHIEVEMENTS_BYCAT
  function getAllAchievementsInCat(cat)
    ALL_ACHIEVEMENTS_BYCAT = ALL_ACHIEVEMENTS_BYCAT or {}
    if (ALL_ACHIEVEMENTS_BYCAT[cat]) then  return ALL_ACHIEVEMENTS_BYCAT[cat];  end
    local tab, size, list = {}, 0, getAllAchievements()
    for i,id in ipairs(list) do
      if (GetAchievementCategory(id) == cat) then  size = size + 1; tab[size] = id;  end
    end
    ALL_ACHIEVEMENTS_BYCAT[cat] = tab
    return tab
  end
  --]]
end


local function BuildCriteriaLookupTab_check()
	if (Overachiever_Settings.UI_RequiredForMetaTooltip and not TjAchieve.IsCritAssetCacheReady(TjAchieve.CRITTYPE_META)) then
		local data
		if (Overachiever.GetCache) then  data = Overachiever.GetCache("meta");  end
		if (data) then
			TjAchieve.PopulateCritAssetCache(TjAchieve.CRITTYPE_META, data)
			if (Overachiever_Debug) then  chatprint("BuildCriteriaLookupTab_check: meta cache populated from saved variables");  end
		else
			local status = TjAchieve.BuildCritAssetCache(TjAchieve.CRITTYPE_META)
			if (status == "started") then
				--if (not THROTTLE_ACHLOOKUP) then
				if (not Overachiever_Settings.Throttle_AchLookup) then
					TjAchieve.RushBuildCritAssetCache(TjAchieve.CRITTYPE_META)
					if (Overachiever_Debug) then  chatprint("BuildCriteriaLookupTab_check: meta caching rushed");  end
					if (Overachiever.SaveCache) then  Overachiever.SaveCache("meta");  end
				else
					if (Overachiever_Debug) then
						chatprint("BuildCriteriaLookupTab_check: meta caching started")
						TjAchieve.AddBuildCritAssetCacheListener(TjAchieve.CRITTYPE_META, function()
							chatprint("BuildCriteriaLookupTab_check: meta caching complete")
						end)
					end
					if (Overachiever.SaveCache) then
						TjAchieve.AddBuildCritAssetCacheListener(TjAchieve.CRITTYPE_META, function()
							Overachiever.SaveCache("meta")
						end)
					end
				end
			end
		end
	end
	if (Overachiever_Settings.CreatureTip_killed and not TjAchieve.IsCritAssetCacheReady(TjAchieve.CRITTYPE_KILL)) then
		local data
		if (Overachiever.GetCache) then  data = Overachiever.GetCache("kill", true);  end
		if (data) then
			TjAchieve.PopulateCritAssetCache(TjAchieve.CRITTYPE_KILL, data)
			if (Overachiever_Debug) then  chatprint("BuildCriteriaLookupTab_check: kill cache populated from saved variables");  end
		else
			local status = TjAchieve.BuildCritAssetCache(TjAchieve.CRITTYPE_KILL, true)
			if (status == "started") then
				--if (not THROTTLE_ACHLOOKUP) then
				if (not Overachiever_Settings.Throttle_AchLookup) then
					TjAchieve.RushBuildCritAssetCache(TjAchieve.CRITTYPE_KILL, true)
					if (Overachiever_Debug) then  chatprint("BuildCriteriaLookupTab_check: kill caching rushed");  end
					if (Overachiever.SaveCache) then  Overachiever.SaveCache("kill", true);  end
				else
					if (Overachiever_Debug) then
						chatprint("BuildCriteriaLookupTab_check: kill caching started")
						TjAchieve.AddBuildCritAssetCacheListener(TjAchieve.CRITTYPE_KILL, function()
							chatprint("BuildCriteriaLookupTab_check: kill caching complete")
						end)
					end
					if (Overachiever.SaveCache) then
						TjAchieve.AddBuildCritAssetCacheListener(TjAchieve.CRITTYPE_KILL, function()
							Overachiever.SaveCache("kill", true)
						end)
					end
				end
			end
		end
	end
	--Overachiever.GetCache = nil
end

function Overachiever.GetMetaCriteriaLookup(doNotRush)
	if (not TjAchieve.IsCritAssetCacheReady(TjAchieve.CRITTYPE_META)) then
		if (doNotRush) then
			return TjAchieve.ASSETS[TjAchieve.CRITTYPE_META], true
		end
		TjAchieve.RushBuildCritAssetCache(TjAchieve.CRITTYPE_META)
	end
	return TjAchieve.ASSETS[TjAchieve.CRITTYPE_META]
end

function Overachiever.GetKillCriteriaLookup(doNotRush)
	if (not TjAchieve.IsCritAssetCacheReady(TjAchieve.CRITTYPE_KILL)) then
		if (doNotRush) then
			return TjAchieve.ASSETS[TjAchieve.CRITTYPE_KILL], true
		end
		TjAchieve.RushBuildCritAssetCache(TjAchieve.CRITTYPE_KILL, true)
	end
	if (OVERACHIEVER_MOB_CRIT) then
		-- Add hardcoded contents to the cache:
		local AchLookup_kill = TjAchieve.ASSETS[TjAchieve.CRITTYPE_KILL]

		local function containsSet(tab, val1, val2, maxIndex)
			for i = 1, maxIndex or #tab, 2 do
				if (tab[i] == val1 and tab[i + 1] == val2) then  return true;  end
			end
			return false
		end

		local numCopy = 0
		for mobID,list in pairs(OVERACHIEVER_MOB_CRIT) do
			if (AchLookup_kill[mobID]) then
				local tab = AchLookup_kill[mobID]
				--[[ Unneeded. We know it will be a table because we passed true for saveIndex.
				if (type(tab) ~= "table") then
					tab = { tab }
				end
				--]]

				local size = #tab
				local sizeOrig = size
				for i = 1, #list, 2 do
					if (not containsSet(tab, list[i], list[i + 1], sizeOrig)) then
						tab[size + 1] = list[i]
						tab[size + 2] = list[i + 1]
						size = size + 2
						numCopy = numCopy + 1
					elseif (Overachiever_Debug) then
						chatprint("Found duplicate data in cache while copying OVERACHIEVER_MOB_CRIT data: [" .. mobID .. "] " .. list[i] .. ", " .. list[i + 1])
					end
				end

				--[[
				local size = #tab
				for i,v in ipairs(list) do
					size = size + 1
					tab[size] = v
				end
				--]]
			else
				AchLookup_kill[mobID] = list
				numCopy = numCopy + 1
			end
		end
		if (Overachiever_Debug) then  chatprint('GetKillCriteriaLookup: Copied '..numCopy..' entries from OVERACHIEVER_MOB_CRIT.');  end
		OVERACHIEVER_MOB_CRIT = nil
	end
	return TjAchieve.ASSETS[TjAchieve.CRITTYPE_KILL]
end

--[===[
local function BuildCriteriaLookupTab(...)
-- To be called in this fashion: BuildCriteriaLookupTab( <criteriaType1>, <table1>, <saveCriteriaNumber1>[, <criteriaType2>, <table2>, <saveCriteriaNumber2>[, ...]] )
  local num = select("#", ...)
  local list = getAllAchievements() -- Consider CATEGORIES_INDIV_ALL only?
  local _, critType, assetID, a, tab, savenum
  local numc, i
  local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
  for x,id in ipairs(list) do
    --for i=1,GetAchievementNumCriteria(id) do
    numc = GetAchievementNumCriteria(id)
    i = 1
    repeat
      _, critType, _, _, _, _, _, assetID = GetAchievementCriteriaInfo(id, i)
      if (critType and assetID and assetID ~= 0) then

        for arg=1,num,3 do
          a, tab, savenum = select(arg, ...)
          if (critType == a) then
            if (tab[assetID]) then
              local v = tab[assetID]
              if (type(v) == "table") then
                local size = #v
                v[size+1] = id
                if (savenum) then  v[size+2] = i;  end
              else
                tab[assetID] = { v, id }  -- Safe to assume savenum isn't true since this wasn't already a table
              end
            else
              if (savenum) then
                tab[assetID] = { id, i }
              else
                tab[assetID] = id
              end
            end
          end
        end

      end
      i = i + 1
    until (i > numc or not assetID)
  end
end

local AchLookup_metaach, AchLookup_kill
local function BuildCriteriaLookupTab_check(forceMeta)
  local meta = not AchLookup_metaach and (Overachiever_Settings.UI_RequiredForMetaTooltip or (forceMeta == true))
  local kill = not AchLookup_kill and Overachiever_Settings.CreatureTip_killed
  if (kill) then
    AchLookup_kill = OVERACHIEVER_MOB_CRIT -- Use this as the baseline. Build the rest of the lookup table upon it.
    OVERACHIEVER_MOB_CRIT = nil
  end
  if (meta and kill) then
    AchLookup_metaach = {}
	--AchLookup_kill = {}
    BuildCriteriaLookupTab(8, AchLookup_metaach, nil, 0, AchLookup_kill, true)
    Overachiever.AchLookup_kill = AchLookup_kill
  elseif (meta) then
    AchLookup_metaach = {}
    BuildCriteriaLookupTab(8, AchLookup_metaach)
  elseif (kill) then
    --AchLookup_kill = {}
    BuildCriteriaLookupTab(0, AchLookup_kill, true)
    Overachiever.AchLookup_kill = AchLookup_kill
  end
  --[[
  if (kill and OVERACHIEVER_MOB_CRIT) then
    for mobID,arr in pairs(OVERACHIEVER_MOB_CRIT) do
	  if (AchLookup_kill[mobID]) then
	    local v = AchLookup_kill[mobID]
		local size = #v
		v[size+1] = arr[1]
		v[size+2] = arr[2]
	  else
		AchLookup_kill[mobID] = { arr[1], arr[2] }
	  end
	end
	OVERACHIEVER_MOB_CRIT = nil
  end
  --]]
end

function Overachiever.GetMetaCriteriaLookup()
  if (not AchLookup_metaach) then  BuildCriteriaLookupTab_check(true);  end
  return AchLookup_metaach
end
--]===]


-- DRAGGABLE FRAMES
---------------------

local function changeAchFrameDragging(enable)
  if (enable) then
        TjDragIt.EnableDragging(AchievementFrame, AchievementFrameHeader, AchievementFrameCategoriesContainer,
                                AchievementFrameAchievementsContainer, AchievementFrameStatsContainer,
								--Overachiever_LeftFrame, Overachiever_LeftFrame.helpIcon,
                                Overachiever_SearchFrameContainer, Overachiever_SuggestionsFrameContainer, Overachiever_WatchFrameContainer, Overachiever_RelatedFrameContainer)
  else
      TjDragIt.DisableDragging(AchievementFrame, AchievementFrameHeader, AchievementFrameCategoriesContainer,
                               AchievementFrameAchievementsContainer, AchievementFrameStatsContainer,
							   --Overachiever_LeftFrame, Overachiever_LeftFrame.helpIcon,
                               Overachiever_SearchFrameContainer, Overachiever_SuggestionsFrameContainer, Overachiever_WatchFrameContainer, Overachiever_RelatedFrameContainer)
  end
end

local orig_AchievementFrame_area

local function CheckDraggable_AchFrame(self, key, val, clicked, LoadPos)
  if (AchievementFrame) then
    -- Check if draggable:
    if (Overachiever_Settings.Draggable_AchFrame) then
      if (not MadeDraggable_AchFrame) then
        changeAchFrameDragging(true)
        MadeDraggable_AchFrame = true
      end
    elseif (MadeDraggable_AchFrame) then
      changeAchFrameDragging(false)
      MadeDraggable_AchFrame = nil
    end
    if (key and AchievementFrame:IsShown()) then
    -- If option may have been changed by the user, frame needs to be hidden before changing its attributes.
      HideUIPanel(AchievementFrame)
    end
    -- Check if position saved:
    if (Overachiever_Settings.DragSave_AchFrame) then
      if (not MadeDragSave_AchFrame) then
        if (not Overachiever_CharVars.Pos_AchievementFrame) then
          Overachiever_CharVars.Pos_AchievementFrame = Overachiever_CharVars_Default and Overachiever_CharVars_Default.Pos_AchievementFrame or {}
        end
        TjDragIt.EnablePositionSaving(AchievementFrame, Overachiever_CharVars.Pos_AchievementFrame, LoadPos)
        --AchievementFrame:SetAttribute("UIPanelLayout-enabled", false);
		SetUIPanelAttribute(AchievementFrame, "area", nil);
        MadeDragSave_AchFrame = true
      end
    elseif (MadeDragSave_AchFrame) then
      TjDragIt.DisablePositionSaving(AchievementFrame)
      --AchievementFrame:SetAttribute("UIPanelLayout-enabled", true);
	  SetUIPanelAttribute(AchievementFrame, "area", orig_AchievementFrame_area);
      MadeDragSave_AchFrame = nil
    end
  end
end

function Overachiever.CheckDraggable_AchFrame_redo()
  -- Call this when a draggable element is created late so it wasn't included before
  if (Overachiever_Settings.Draggable_AchFrame and MadeDraggable_AchFrame) then -- Only do anything if we want draggable frames and already acted on this
    -- Disable then re-enable dragging:
    changeAchFrameDragging(false)
	changeAchFrameDragging(true)
  end
end

local AchievementUI_OnShow_post_called

local function AchievementUI_OnShow_post()
  if (AchievementUI_OnShow_post_called) then  return;  end
  AchievementUI_OnShow_post_called = true
  -- Delayed setting the area attribute until now so that if Blizzard_AchievementUI was loaded just before the
  -- AchievementFrame is to be shown, AchievementFrame wouldn't be set as the current UI panel by code in
  -- UIParent.lua, which causes problems when we don't want it to interact with other UI panels in the standard
  -- way. (Set now instead of leaving it out because the player may want it to interact normally again later.)
  if (orig_AchievementFrame_area) then
    if (not AchievementFrame) then
      -- AchievementFrame should exist at this point but some addons do something that gets this called when it hasn't been loaded yet.
      -- This should prevent the error that otherwise occurs when we try to reference a member of UIPanelWindows["AchievementFrame"], below.
      AchievementFrame_LoadUI()
    end
    if (UIPanelWindows["AchievementFrame"]) then -- Prevent error message due to other addons doing something... weird? This breaks functionality but maybe it's okay since the problem might happen with other addons that duplicate this functionality (movable achievement frame) anyway.
      UIPanelWindows["AchievementFrame"].area = orig_AchievementFrame_area
      if (not Overachiever_Settings.DragSave_AchFrame) then
        --AchievementFrame:SetAttribute("UIPanelLayout-area", orig_AchievementFrame_area);
        SetUIPanelAttribute(AchievementFrame, "area", orig_AchievementFrame_area);
      end
    elseif (Overachiever_Debug) then
      chatprint('Error: UIPanelWindows["AchievementFrame"] not found.')
    end
    --orig_AchievementFrame_area = nil
  end
  CheckDraggable_AchFrame(nil, nil, nil, nil, true)
  --if (not Overachiever_Settings.DragSave_AchFrame) then
  if (Overachiever_Settings.Draggable_AchFrame and not Overachiever_Settings.DragSave_AchFrame) then
  -- If we aren't saving the position, then re-open the frame to put it in the standard place. (It'll do this
  -- automatically from now on.)
  -- This is needed in case some other frame that modifies the position is already open (like the character panel).
    local prevfunc = AchievementFrame:GetScript("OnHide")
    AchievementFrame:SetScript("OnHide", nil)
    HideUIPanel(AchievementFrame)
    AchievementFrame:SetScript("OnHide", prevfunc)
    prevfunc = AchievementFrame:GetScript("OnShow")
    AchievementFrame:SetScript("OnShow", nil)
    ShowUIPanel(AchievementFrame)
    AchievementFrame:SetScript("OnShow", prevfunc)
  end
end


-- ACHIEVEMENT HYPERLINK HOOK
-------------------------------

----local orig_SetItemRef = SetItemRef
--local orig_ChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow
--ChatFrame_OnHyperlinkShow = function(self, link, text, button, ...)
hooksecurefunc("ChatFrame_OnHyperlinkShow", function(self, link, text, button)
  -- IIRC, hooksecurefunc wasn't good enough before (I believe we needed to be able to prevent original processing because Control and Alt clicking the links had
  -- some sort of reaction), but something has changed. It's fine, now, so we'll use it since it's safe and simple.
  if (strsub(link, 1, 11) == "achievement") then
    if (IsControlKeyDown()) then
      local id = strsplit(":", strsub(link, 13));
      id = tonumber(id)
      if (IsShiftKeyDown()) then
        --[[
        if (not AchievementFrame) then
          AchievementFrame_LoadUI()
          openToAchievement(id)
        elseif (not AchievementFrame:IsShown()) then
          ToggleAchievementFrame()
        end
        --]]
        local delay = false
        if (not AchievementFrame) then
          ToggleAchievementFrame()
          if (Overachiever.OpenRelatedTab) then
            openToAchievement(id)
            delay = true
          end
        elseif (Overachiever.OpenRelatedTab and not AchievementFrame:IsShown()) then
          ToggleAchievementFrame()
          openToAchievement(id)
        end
        if (Overachiever.OpenRelatedTab) then
          if (delay) then  -- The delay is needed in this case or else the left panel of the frame renders incorrectly.
            C_Timer.After(0, function()  Overachiever.OpenRelatedTab(id);  end)
          else
            Overachiever.OpenRelatedTab(id)
          end
          return;
        end
      end
      openToAchievement(id, true)
      return;
    elseif (IsAltKeyDown()) then
      if (not AchievementFrame) then  AchievementFrame_LoadUI();  end
      if (Overachiever_WatchFrame) then
        local id = strsplit(":", strsub(link, 13));
        id = tonumber(id)
        Overachiever_WatchFrame.SetAchWatchList(id, true)
        return;
      end
    end
  end
  --return orig_ChatFrame_OnHyperlinkShow(self, link, text, button, ...)
end)



-- ACHIEVEMENT TRACKER CHANGES AND PROGRESS TRACKING
------------------------------------------------------

hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "OnBlockHeaderEnter", function(self, block)
  if (not block.id) then  return;  end
  local obj = block.HeaderText
  GameTooltip:SetOwner(obj, "ANCHOR_NONE")
  local x, y = obj:GetCenter()
  local w = UIParent:GetWidth() / 3
  if (x > w) then
    GameTooltip:SetPoint("TOPRIGHT", obj, "TOPLEFT", -6, 0)
  else
    GameTooltip:SetPoint("TOP", obj, "TOP", 0, 0)
    GameTooltip:SetPoint("LEFT", ObjectiveTrackerFrame, "RIGHT", -8, 0)
  end
  GameTooltip:SetHyperlink( GetAchievementLink(block.id) )
end)

hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "OnBlockHeaderLeave", function()
  GameTooltip:Hide()
end)

--[[ Unused. Call Overachiever.ExploreZoneIDLookup(zone) instead. The search component (getAchievementID) can cause micro stutters (0.1 second on a pretty high-end PC) so it wasn't ideal to call while traveling in-game which was the whole point of this.
function Overachiever.FindExplorationAchievementForZone(zone)
  return Overachiever.ExploreZoneIDLookup(zone) or getAchievementID(CATEGORIES_EXPLOREZONES, ACHINFO_NAME, zone, true)
end
--]]

local function ReactToCriteriaToast(achievementID, criteriaString)
  --local _, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuildAch = GetAchievementInfo(achievementID);
  if (Overachiever_Settings.ProgressToast_ChatLog) then
    local link = GetAchievementLink(achievementID)
    chatprint("", L.MSG_CRITERIAPROGRESS:format(link, criteriaString))
  end
  if (Overachiever_Settings.ProgressToast_Suggest) then
    local crit = Overachiever.IsCriteria(achievementID, criteriaString)
    Overachiever.FlagReminder(achievementID, crit or criteriaString)
  end
  if (Overachiever_Settings.ProgressToast_AutoTrack) then
    Overachiever.TrackAchievement(achievementID)
  end
end
--TEST_ReactToCriteriaToast = ReactToCriteriaToast
--/dump TEST_ReactToCriteriaToast(12510, "A Golden Opportunity")


-- META-CRITERIA TOOLTIP
--------------------------

local orig_AchievementButton_GetMeta

local function MetaCriteriaOnEnter(self)
  local id = self.id
  if (id and type(id) == "number" and id > 0) then  -- Extra checks needed for compatibility with addons like Failchievements.
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
    local link = GetAchievementLink(id)
    GameTooltip:SetHyperlink(link)
    checkGuildMembersTooltip(self)
    if (GameTooltip:GetBottom() < self:GetTop()) then
      GameTooltip:ClearAllPoints()
      GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
    end
  -- If for some reason the ID isn't there but a date completed is (something that probably shouldn't happen), fall
  -- back to the way tooltips were handled in Blizzard_AchievementUI.xml's MetaCriteriaTemplate:
  elseif ( self.date ) then
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    GameTooltip:AddLine(string.format(ACHIEVEMENT_META_COMPLETED_DATE, self.date), 1, 1, 1);
    checkGuildMembersTooltip(self)
    GameTooltip:Show();
  end
end

local function new_AchievementButton_GetMeta(...)
  local frame = orig_AchievementButton_GetMeta(...)
  frame:SetScript("OnEnter", MetaCriteriaOnEnter)
  return frame;
end


-- TOOLTIP FOR UI'S ACHIEVEMENT BUTTONS
-----------------------------------------

local achbtnOnEnter, achbtnOnLeave, achBtnRedisplay
local AddAchListToTooltip
do
  local button
  local r_sel, g_sel, b_sel = 0.741, 1, 0.467
  local r_com, g_com, b_com = 0.25, 0.75, 0.25
  local r_inc, g_inc, b_inc = 0.6, 0.6, 0.6
  local temptab

  function AddAchListToTooltip(tooltip, list, hoverAchID)
    if (type(list) == "table") then
      local _, name, completed, anycomplete
      temptab = temptab or {}
	  --local notInUI
      for i,ach in ipairs(list) do
        _, name, _, completed = GetAchievementInfo(ach)
		if (Overachiever_Debug) then  name = name .. " (" .. ach .. ")";  end
        if (completed) then
          anycomplete = true
        else
          completed = false  -- nil becomes false for use in temptab.
        end

		--local alteredName
		if (Overachiever.GetCachedFactionForData) then
			local faction = Overachiever.GetCachedFactionForData("meta", hoverAchID, ach)
			--local currentFaction = UnitFactionGroup("player")
			--if (faction ~= currentFaction) then
				if (faction == "Alliance") then
					name = IconAlliance .. "  " ..name
					--alteredName = true
				elseif (faction == "Horde") then
					name = IconHorde .. "  " ..name
					--alteredName = true
				end
			--end
		end
		--[[
		if (temptab[name] == nil and not alteredName and not isAchievementInUI(ach, true)) then
			notInUI = notInUI or {}
			notInUI[name] = true
		elseif (notInUI and notInUI[name] and isAchievementInUI(ach, true)) then
			notInUI[name] = false
		end
		--]]

        temptab[name] = temptab[name] or completed
        -- It being complete takes precedence, since if the name was already used, but this time it's complete,
        -- the previous one must've been for the other faction.
      end
      for name,completed in pairs(temptab) do
	    --if (notInUI and notInUI[name]) then  name = IconNotReadyX .. " " .. name;  end
        if (completed) then
          tooltip:AddLine(name, r_com, g_com, b_com)
          tooltip:AddTexture(136814) -- "Interface\\RAIDFRAME\\ReadyCheck-Ready"
        else
          tooltip:AddLine(name, 1, 1, 1) --, r_inc, g_inc, b_inc)
          if (anycomplete) then
            tooltip:AddTexture("") -- fake texture to push the text over
          end
        end
      end
      wipe(temptab)

    else
	  local ach = list
      local _, name, _, completed = GetAchievementInfo(ach)
	  if (Overachiever_Debug) then  name = name .. " (" .. ach .. ")";  end

	  --local alteredName
	  if (Overachiever.GetCachedFactionForData) then
		local faction = Overachiever.GetCachedFactionForData("meta", hoverAchID, ach)
		--local currentFaction = UnitFactionGroup("player")
		--if (faction ~= currentFaction) then
			if (faction == "Alliance") then
			  name = IconAlliance .. " " ..name
			  --alteredName = true
			elseif (faction == "Horde") then
			  name = IconHorde .. " " ..name
			  --alteredName = true
			end
		--end
	  end
	  --[[
	  if (not alteredName and not isAchievementInUI(ach, true)) then
		name = IconNotReadyX .. " " .. name
	  end
	  --]]
      if (completed) then
        tooltip:AddLine(name, r_com, g_com, b_com)
        tooltip:AddTexture(136814) -- "Interface\\RAIDFRAME\\ReadyCheck-Ready"
      else
        tooltip:AddLine(name, 1, 1, 1) --, r_inc, g_inc, b_inc)
      end
    end
  end

  function achbtnOnEnter(self)
    local id, tipset, guildtip = self.id, 0
	-- If tipset is 1, then if adding a new line, you should add an empty line first. 0 means nothing is on the tooltip yet. Otherwise, use 2.
    GameTooltip:SetOwner(self, "ANCHOR_NONE")
    GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 8, 0)
    GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)

	-- This section based on part of AchievementShield_OnEnter:
	if ( self.accountWide ) then
		if ( self.completed ) then
			GameTooltip:AddLine(ACCOUNT_WIDE_ACHIEVEMENT_COMPLETED);
		else
			GameTooltip:AddLine(ACCOUNT_WIDE_ACHIEVEMENT);
		end
		tipset = 1
		GameTooltip:Show();
	end
	local me
	if ( (tipset == 0 or not self.completed) and self.shield.earnedBy ) then
		GameTooltip:AddLine(format(ACHIEVEMENT_EARNED_BY,self.shield.earnedBy));
		me = UnitName("player")
		if ( not self.shield.wasEarnedByMe ) then
			GameTooltip:AddLine(format(ACHIEVEMENT_NOT_COMPLETED_BY, me));
		elseif ( me ~= self.shield.earnedBy ) then
			GameTooltip:AddLine(format(ACHIEVEMENT_COMPLETED_BY, me));
		end
		GameTooltip:Show();
		tipset = 1
	end


    checkGuildMembersTooltip(self)

    -- This guild data doesn't pop up as consistently as I'd like but the same thing happens with the default UI and after running tests with the relevant events and functions, it seems to be a Blizzard bug.
    -- Generally, if there's anything to display, selecting the achievement and then moving the cursor away and back will make it work for that achievement. (Same workaround goes for default UI.)

    if (GameTooltip:NumLines() > 0) then  tipset, guildtip = 1, true;  end
    button = self

    if (Overachiever_Settings.UI_SeriesTooltip and (GetNextAchievement(id) or GetPreviousAchievement(id))) then
      if (tipset == 1) then  GameTooltip:AddLine(" ");  end
      tipset = 2 --tipset + 1
      GameTooltip:AddLine(L.SERIESTIP)
      GameTooltip:AddLine(" ")
      local ach = GetPreviousAchievement(id)
      local first, _, name, anycomplete
      while (ach) do  -- Find first achievement in the series:
        first = ach
        ach = GetPreviousAchievement(ach)
      end
      ach = first or id
      local completed = select(4, GetAchievementInfo(ach))
      while (ach) do
        _, name = GetAchievementInfo(ach)
        if (ach == id) then
          GameTooltip:AddLine(name, r_sel, g_sel, b_sel)
        elseif (completed) then
          GameTooltip:AddLine(name, r_com, g_com, b_com)
        else
          GameTooltip:AddLine(name, r_inc, g_inc, b_inc)
        end
        if (completed) then
		  GameTooltip:AddTexture(136814) -- "Interface\\RAIDFRAME\\ReadyCheck-Ready"
          anycomplete = true
        elseif (anycomplete) then
          GameTooltip:AddTexture("") -- fake texture to push the text over
        end
        ach, completed = GetNextAchievement(ach)
      end
      GameTooltip:AddLine(" ")
    end

    if (Overachiever_Settings.UI_RequiredForMetaTooltip and TjAchieve.GetAchievementByAsset(TjAchieve.CRITTYPE_META, id)) then
      if (tipset == 1) then  GameTooltip:AddLine(" ");  end
      tipset = 2 --tipset + 1
      GameTooltip:AddLine(L.REQUIREDFORMETATIP)
      GameTooltip:AddLine(" ")
      AddAchListToTooltip(GameTooltip, TjAchieve.GetAchievementByAsset(TjAchieve.CRITTYPE_META, id, true), id)
      GameTooltip:AddLine(" ")
    end

    if (Overachiever_Settings.UI_ProgressIfOtherCompleted) then
      local _, _, _, completed, _, _, _, _, _, _, _, _, wasEarnedByMe = GetAchievementInfo(id)
	  if (completed and not wasEarnedByMe) then
	    local numCrit = GetAchievementNumCriteria(id)
		local didLabel = false
	    for i=1,numCrit do
		  local criteriaString, _, critCompleted, quantity, totalQuantity, _, _, _, quantityString = GetAchievementCriteriaInfo(id, i)
		  quantityString = Overachiever.GetCriteriaProgressString(quantity, totalQuantity, quantityString)
		  if (quantityString) then
		    if (not didLabel) then
			  if (tipset == 1) then  GameTooltip:AddLine(" ");  end
			  tipset = 2 --tipset + 1
			  if (not me) then  me = UnitName("player");  end
			  GameTooltip:AddLine(L.PROGRESSIFOTHERCOMPLETED:format(me))
			  GameTooltip:AddLine(" ")
			  didLabel = true
			end
		    local r, g, b
			if (critCompleted) then
			  r, g, b = r_com, g_com, b_com -- critCompleted refers to this character's completion; if that should change, then may need to check if quantity < totalQuantity
			else
			  r, g, b = r_inc, g_inc, b_inc
			end
			if (numCrit == 1) then
			  GameTooltip:AddLine(quantityString, r, g, b);
		    else
			  if (criteriaString:sub(-1) == "." and criteriaString:sub(-2) ~= "..")  then  criteriaString = criteriaString:sub(1, -2);  end -- Remove period at end of statement.
			  GameTooltip:AddLine("|cffffffff"..criteriaString..":|r  " .. quantityString, r, g, b) --|cff7eff00 --|cffffff00
			end
		  end
		end
		if (didLabel) then
		  GameTooltip:AddLine(" ")
		end
	  end
    end

    local reminders, anycomplete = Overachiever.GetRecentReminders(id, true, true)
    if (reminders) then
      if (tipset == 1) then  GameTooltip:AddLine(" ");  end
      tipset = 2 --tipset + 1
      GameTooltip:AddLine(L.RECENTREMINDERCRITERIA)
      GameTooltip:AddLine(" ")
      for i,critArr in ipairs(reminders) do
	    if (critArr[2]) then
		  GameTooltip:AddLine(critArr[1], r_com, g_com, b_com)
		  GameTooltip:AddTexture(136814) -- "Interface\\RAIDFRAME\\ReadyCheck-Ready"
		else
		  GameTooltip:AddLine(critArr[1], 1, 1, 1)
		  if (anycomplete) then
		    GameTooltip:AddTexture("") -- fake texture to push the text over
		  end
		end
      end
      GameTooltip:AddLine(" ")
    end

    if (Overachiever_Settings.Tooltip_ShowID) then
      if (tipset > 0) then
        if (tipset == 1 and guildtip) then  GameTooltip:AddLine(" ");  end
        GameTooltip:AddDoubleLine(" ", "|cff7eff00ID:|r "..id, nil, nil, nil, 0.741, 1, 0.467)
      else
        GameTooltip:AddLine("|cff7eff00ID:|r "..id, 0.741, 1, 0.467)
      end
      if (Overachiever_Debug) then
        GameTooltip:AddDoubleLine(" ", "|cff7eff00Category:|r "..tostring(GetAchievementCategory(id)), 0.741, 1, 0.467)
      end
      tipset = 1 --tipset + 1
    end

    if (tipset > 0) then
      GameTooltip:Show()
      return true
    end
  end

  function achbtnOnLeave(self)
    button = nil
    AchievementMeta_OnLeave(self) -- Used because it sets guildMemberRequestFrame, a variable local to Blizzard_AchievementUI.lua,
    -- to nil without doing anything else except GameTooltip:Hide() which we want to do anyway.
  end

  -- This function is needed to handle cases where OnEnter isn't triggered again because the frame scrolls down
  -- but the cursor remains on the same button:
  function achBtnRedisplay()
    if (button) then
      if (not achbtnOnEnter(button)) then
        GameTooltip:Hide()
      end
    end
  end
end

Overachiever.AchBtnRedisplayTooltip = achBtnRedisplay


--local function achbtnShieldOnEnter(self, ...)
--  return achbtnOnEnter(self:GetParent(), ...);
--end


-- TOASTS
-----------

-- /run Overachiever.ToastFakeAchievement("test")

--[[
local fakeToastBaseID, fakeToastName, fakeToastDelay
local hookedAchToast = false

local function achievementToasted(frame, achievementID, alreadyEarned)
  if (achievementID == fakeToastBaseID) then
    frame.Name:SetText(fakeToastName)
    if (fakeToastDelay) then
	  if (fakeToastDelay <= 0) then
	    C_Timer.After(0, function()  AlertFrame_StopOutAnimation(frame);  end)
	  else
	    local delay = fakeToastDelay
	    C_Timer.After(0, function()
          frame.waitAndAnimOut.animOut:SetStartDelay(delay)
		end)
	  end
    end
    fakeToastBaseID = nil
    fakeToastName = nil
    fakeToastDelay = nil
  end
end
--]]

--local function alertOnClick(self, ...)
function OverachieverAlertFrame_OnClick(self, ...)
	if (self.delay == -1) then
		self:SetScript("OnLeave", AlertFrame_ResumeOutAnimation)
		self.delay = 0
	end
	if (self.onClick) then
		if (AlertFrame_OnClick(self, ...)) then  return;  end -- Handle right-clicking to hide the frame.
		self.onClick(self, ...)
	elseif (self.onClick == false) then
		AlertFrame_OnClick(self, ...)
	else
		AchievementAlertFrame_OnClick(self, ...)
	end
end

local function OverachieverAlertFrame_SetUp(frame, achievementID, alreadyEarned, name, delay, toptext, onClick, icon)
	-- An alert flagged as alreadyEarned has more space for the text to display since there's no shield+points icon.
	local ret = AchievementAlertFrame_SetUp(frame, achievementID, alreadyEarned)
	frame.Name:SetText(name)
	frame.Unlocked:SetText(toptext or (toptext == false and THIS_TITLE) or ACHIEVEMENT_UNLOCKED)
	frame.onClick = onClick
	frame.delay = delay
	--frame:SetScript("OnClick", alertOnClick) -- made this part of the template
	if (delay) then
		if (delay <= 0) then
			C_Timer.After(0, function()  AlertFrame_PauseOutAnimation(frame);  end) -- Also need this? frame.waitAndAnimOut.animOut:SetStartDelay(1);
		else
			C_Timer.After(0, function()
				frame.waitAndAnimOut.animOut:SetStartDelay(delay)
			end)
		end
	end
	if (delay == -1) then
		frame:SetScript("OnLeave", nil)
	else
		frame:SetScript("OnLeave", AlertFrame_ResumeOutAnimation)
	end
	if (icon) then
		--HEY = HEY or { frame.Icon.Texture:GetTexCoord() }
		frame.Icon.Texture:SetTexture(icon)
		frame.Icon.Texture:SetTexCoord(0.0, 0.7109375, 0.0, 0.7109375)
		frame.Background:SetTexture(TexAlert)
		--frame.OldAchievement:SetTexture(TexAlertBorders) (Currently broken)
	else
		frame.Icon.Texture:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
		frame.Background:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Alert-Background")
		frame.OldAchievement:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Borders")
	end
end
-- /run Overachiever.ToastFakeAchievement("test")
-- /run Overachiever.ToastForEvents(true, true, true, true)
-- /run Overachiever.ToastFakeAchievement("test", nil, nil, nil, -1, "okay")

function Overachiever.ToastFakeAchievement(name, baseID, playSound, chatMessage, delay, toptext, onClick, icon, newEarn)
  if (Kiosk.IsEnabled()) then
    return;
  end
  if ( not AchievementFrame ) then
    AchievementFrame_LoadUI();
  end

  --[[
  if (not hookedAchToast) then
	hooksecurefunc(AchievementAlertSystem, "setUpFunction", achievementToasted)
	hookedAchToast = true
  --]]

  if (not Overachiever.AlertSystem) then
	--Overachiever.AlertSystem = AlertFrame:AddQueuedAlertFrameSubSystem("AchievementAlertFrameTemplate", AchievementAlertFrame_SetUp, 4, math.huge)
	--hooksecurefunc(Overachiever.AlertSystem, "setUpFunction", achievementToasted)
	Overachiever.AlertSystem = AlertFrame:AddQueuedAlertFrameSubSystem("OverachieverAlertFrameTemplate", OverachieverAlertFrame_SetUp, 4, math.huge)
  end

  if (not baseID) then  baseID = 5208;  end -- 5208 is "Twin Peaking", chosen because of its thumbs-up texture.
  Overachiever.AlertSystem:AddAlert(baseID, not newEarn, name, delay, toptext, onClick, icon)

  --[[
  fakeToastName = name
  fakeToastBaseID = baseID
  fakeToastDelay = delay
  AchievementAlertSystem:AddAlert(baseID, true)
  --CriteriaAlertSystem:AddAlert(baseID, true)
  --for alertFrame in AchievementAlertSystem.alertFramePool:EnumerateActive() do
  --end
  --]]

  --if (playSound) then  PlaySound("UI_Alert_AchievementGained");  end
  if (playSound) then  PlaySound(12891);  end
  if (chatMessage) then  chatprint("", chatMessage);  end
end


-- GLOBAL FUNCTIONS
-----------------------

function Overachiever.OnEvent(self, event, arg1, ...)
  --print("[Oa]", event, arg1, ...)
  if (event == "CRITERIA_UPDATE") then
    -- Both of these are used by GameTip.lua
    Overachiever.Criteria_Updated = true
	Overachiever.Last_Tooltip_Check = 0

  elseif (event == "PLAYER_ENTERING_WORLD") then
    Overachiever.MainFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
    Overachiever.MainFrame:RegisterEvent("CRITERIA_UPDATE") -- used by GameTip.lua

    BuildCategoryInfo()
    BuildCategoryInfo = nil

    local oldver, toast, msg
    OptionsPanel, oldver = Overachiever.CreateOptions(THIS_TITLE, BuildCriteriaLookupTab_check, Overachiever.AutoTrackingSettingUpdated, CheckDraggable_AchFrame)
    Overachiever.CreateOptions = nil

    if (oldver and oldver ~= THIS_VERSION) then
      Overachiever_Settings.Version = THIS_VERSION
	  toast = L.OVERACHIEVER_UPDATED_TOAST
	  msg = L.OVERACHIEVER_UPDATED_MSG:format(THIS_VERSION)
      local def, settings = Overachiever.DefaultSettings, Overachiever_Settings

      -- Remove options no longer in this version:
      for k,v in pairs(settings) do
        if (def[k] == nil) then  settings[k] = nil;  end
      end
      -- Add options new to this version, set to default:
      for k,v in pairs(def) do
        if (settings[k] == nil) then  settings[k] = v;  end
      end

      if (oldver < "0.40" and Overachiever_CharVars_Default) then
        Overachiever_CharVars_Default.Pos_AchievementWatchFrame = nil
      end

	  if (oldver < "1.0.0") then
	    Overachiever_Settings.Throttle_AchLookup = false
	  end

	elseif (oldver == false) then -- Must be false, not nil; false indicates we created the variables table (fresh install) whereas nil would mean there was no change
	  toast = L.OVERACHIEVER_INSTALLED_TOAST
	  msg = L.OVERACHIEVER_INSTALLED_MSG:format(THIS_VERSION)

	elseif (oldver ~= THIS_VERSION) then -- failsafe; shouldn't happen unless player manually messes with saved variables
	  Overachiever_Settings.Version = THIS_VERSION
    end

    if (Overachiever_CharVars and Overachiever_CharVars.Version ~= THIS_VERSION) then
      local oldver_char = Overachiever_CharVars.Version or "0"
      if (oldver_char < "0.40") then  Overachiever_CharVars.Pos_AchievementWatchFrame = nil;  end
      if (oldver_char < "0.55") then  Overachiever_CharVars.TrackedAch = nil;  end  -- No longer necessary as between-session objective tracking is now done by WoW itself.

      if (oldver_char < "0.99.2" and Overachiever_CharVars_Consumed) then
        for k,v in pairs(Overachiever_CharVars_Consumed) do
          if (k ~= "Drink" and k ~= "Food" and k ~= "LastBuilt") then
            Overachiever_CharVars_Consumed[k] = nil
            --chatprint("Overachiever_CharVars_Consumed["..k.."] removed.")
          end
        end
      end

     --[[  No longer necessary as multi-session/persistent tracking is now handled by WoW itself:
      local tracked = Overachiever_CharVars.TrackedAch
      if (tracked and GetNumTrackedAchievements() == 0) then
      -- Resume tracking from last session:
        if (type(tracked) == "table") then
          for i,id in ipairs(tracked) do
            AddTrackedAchievement(id)
          end
        else
          AddTrackedAchievement(tracked)
        end
      end
     --]]
    elseif (not Overachiever_CharVars) then
      Overachiever_CharVars = {}
    end
    Overachiever_CharVars.Version = THIS_VERSION

    GameTooltip:HookScript("OnTooltipSetUnit", Overachiever.ExamineSetUnit)
    GameTooltip:HookScript("OnShow", Overachiever.ExamineOneLiner)
  	GameTooltip:HookScript("OnTooltipCleared", Overachiever.ExamineOneLiner_clear)
  	GameTooltip:HookScript("OnTooltipSetItem", Overachiever.ExamineItem)
    ItemRefTooltip:HookScript("OnTooltipSetItem", Overachiever.ExamineItem)
    hooksecurefunc(ItemRefTooltip, "SetHyperlink", Overachiever.ExamineAchievementTip)
    hooksecurefunc(GameTooltip, "SetHyperlink", Overachiever.ExamineAchievementTip)

    local StartTime
    if (Overachiever_Debug) then  StartTime = debugprofilestop();  end

    Overachiever.BuildItemLookupTab(THIS_VERSION)
    Overachiever.BuildItemLookupTab = nil

    if (Overachiever_Debug) then
      local prev = StartTime
      StartTime = debugprofilestop()
      chatprint("Building/retrieving food/drink lookup tables took "..(StartTime - prev)/1000 .." seconds.")
    end

    BuildCriteriaLookupTab_check()
    if (Overachiever_Debug) then
	  local n = string.format("%.0f", (debugprofilestop() - StartTime)/1000)
      chatprint("BuildCriteriaLookupTab_check() call took "..n.." seconds.")
    end

	do
		local status = TjAchieve.BuildIDCache()
		if (status ~= "complete") then
			if (not Overachiever_Settings.Throttle_AchLookup) then
				TjAchieve.RushBuildIDCache()
				if (Overachiever_Debug) then  chatprint("RushBuildIDCache");  end
			elseif (Overachiever_Debug) then
				chatprint("BuildIDCache")
				TjAchieve.AddBuildIDCacheListener(function()
					chatprint("BuildIDCache: complete")
				end)
			end
		end
	end

	if (toast) then
	  C_Timer.After(0, function()
	    -- This strange double-timer thing works around an issue where the timer starts counting down, so to speak, during the loading screen if the UI is being reloaded (as per /reload), making the toast not appear.
	    C_Timer.After(4, function()
	      Overachiever.ToastFakeAchievement(toast, nil, false, msg, 15, nil, function()  openOptions();  end)
	    end)
	  end)
	end

	OpenCalendar() -- We need calendar data to be available later (not just for toasts, but also holiday notices on achievement GUI), so we request it now. (Needed if some other addon doesn't do this.)
	-- You might think we'd want to watch for event CALENDAR_UPDATE_EVENT_LIST after this, but it's not reliably called. Some report you need to call another function like CalendarSetAbsMonth beforehand for it to work,
	-- but how we're doing it, we don't seem to need to do that or use that event at all.

	local OS = Overachiever_Settings
	if (OS.ToastCalendar_holiday or OS.ToastCalendar_microholiday or OS.ToastCalendar_bonusevent or OS.ToastCalendar_dungeonevent or
	    OS.ToastCalendar_pvpbrawl or OS.ToastCalendar_misc) then
	  C_Timer.After(0, function()
	    -- This strange double-timer thing works around an issue where the timer starts counting down, so to speak, during the loading screen if the UI is being reloaded (as per /reload), making the toast not appear.
		C_Timer.After(5, function()
		  Overachiever.ToastForEvents(OS.ToastCalendar_holiday, OS.ToastCalendar_microholiday, OS.ToastCalendar_bonusevent,
		                              OS.ToastCalendar_dungeonevent, OS.ToastCalendar_pvpbrawl, OS.ToastCalendar_misc)
		end)
	  end)
	  --[[
      Overachiever.MainFrame:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	  --if (not IsAddOnLoaded("Blizzard_Calendar")) then  UIParentLoadAddOn("Blizzard_Calendar");  end
      OpenCalendar()
	  --]]
	end

  --[[
  elseif (event == "CALENDAR_UPDATE_EVENT_LIST") then
    Overachiever.MainFrame:UnregisterEvent("CALENDAR_UPDATE_EVENT_LIST")
	--Overachiever.MainFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	--Overachiever.MainFrame:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
	C_Timer.After(0, function()
	  -- This strange double-timer thing works around an issue where the timer starts counting down, so to speak, during the loading screen if the UI is being reloaded (as per /reload), making the toast not appear.
	  C_Timer.After(5, function()
		Overachiever.ToastForEvents(Overachiever_Settings.ToastCalendar_holiday, Overachiever_Settings.ToastCalendar_microholiday, Overachiever_Settings.ToastCalendar_bonusevent, Overachiever_Settings.ToastCalendar_dungeonevent)
	  end)
	end)
  --]] --[[
  elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then
	Overachiever.MainFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	C_Timer.After(8, function()
	  Overachiever.ToastForEvents(Overachiever_Settings.ToastCalendar_holiday, Overachiever_Settings.ToastCalendar_microholiday, Overachiever_Settings.ToastCalendar_bonusevent, Overachiever_Settings.ToastCalendar_dungeonevent)
	end)
  --]]

  elseif (event == "TRACKED_ACHIEVEMENT_UPDATE") then
    --print("*****", event, arg1, select(2, GetAchievementInfo(arg1)), "*****")
    if (arg1 and arg1 > 0) then  -- Attempt to work around an apparent WoW bug. May prevent errors but if the given ID is 0, we have no way of knowing what the achievement really was so we can't track it (unless there's another call with the correct data).
      local criteriaID, elapsed, duration = ...
	  --print("criteriaID, elapsed, duration",criteriaID, elapsed, duration)
      if (elapsed and duration and elapsed < duration) then
  	    local canTrack, isBGTimer
        local pvpMap = OVERACHIEVER_BGTIMERID[arg1]
        local pvpMap2 = OVERACHIEVER_BGTIMERID_RATED[arg1]
  	    if (pvpMap or pvpMap2) then -- If this is one of the battleground timers, then we have to treat it a special way because there is a Blizzard bug that makes this event trigger for achievements for OTHER battlegrounds:
    		  local _, instanceType, _, _, _, _, _, instanceMapID = GetInstanceInfo()
    		  --print("instanceMapID",instanceMapID)
    		  if (instanceType == "pvp" and (pvpMap == true or (instanceMapID and (instanceMapID == pvpMap or instanceMapID == pvpMap2)))) then
    		    Overachiever.FlagReminder(arg1)
      			canTrack = Overachiever_Settings.Tracker_AutoTimer_BG
      			if (canTrack) then  isBGTimer = true;  end
      		else
    		    canTrack = false
    		  end
    		elseif (pvpMap == false) then
    		  canTrack = false
    		else
    		  Overachiever.FlagReminder(arg1)
    		  canTrack = Overachiever_Settings.Tracker_AutoTimer
    		end
    		--print("canTrack",canTrack)

    		if (canTrack) then
          Overachiever.TrackTimedAchievement(arg1, isBGTimer)
    		end
      end
  	end

  elseif (event == "CRITERIA_EARNED") then
    ReactToCriteriaToast(arg1, ...)

  elseif (event == "ADDON_LOADED" and arg1 == "Blizzard_AchievementUI") then
    Overachiever.MainFrame:UnregisterEvent("ADDON_LOADED")
    -- Meta-criterea creation intercept:
    orig_AchievementButton_GetMeta = AchievementButton_GetMeta
    AchievementButton_GetMeta = new_AchievementButton_GetMeta
    -- Add "series" tooltip to default achievement buttons:
    Overachiever.UI_HookAchButtons(AchievementFrameAchievementsContainer.buttons, AchievementFrameAchievementsContainerScrollBar)
    -- Allow closing frame with Escape even when UIPanelLayout-area is nil:
    tinsert(UISpecialFrames, "AchievementFrame");

    -- Make main achievement UI draggable:
    -- - Prevent UIParent.lua from seeing area field (or it'll do things that mess up making the frame draggable, at least when you want the position to be saved: it snaps to another position when another panel, e.g. Character, opens).
    if (UIPanelWindows["AchievementFrame"]) then  -- This if statement prevents error messages when the addon MoveAnything is used to move AchievementFrame.
      orig_AchievementFrame_area = UIPanelWindows["AchievementFrame"].area
      UIPanelWindows["AchievementFrame"].area = nil
    end
    -- - Hook the first OnShow call to complete this. (Function not called now in case saved variables aren't ready or the frame
    --   isn't showing right away.)
    AchievementFrame:HookScript("OnShow", AchievementUI_OnShow_post)

    -- Make the default UI's "Achievement Filter" dropdown respond to clicks anywhere instead of only on the down-arrow button:
    --AchievementFrameFilterDropDownButton:SetWidth( AchievementFrameFilterDropDown:GetWidth() )
    if (AchievementFrameFilterDropDownButton and AchievementFrameFilterDropDownMouseOver) then -- failsafe
      AchievementFrameFilterDropDownButton:SetWidth( AchievementFrameFilterDropDownMouseOver:GetWidth() )
      AchievementFrameFilterDropDownButton:HookScript("OnEnter", AchievementFrameFilterDropDownMouseOver:GetScript("OnEnter"))
      AchievementFrameFilterDropDownButton:HookScript("OnLeave", AchievementFrameFilterDropDownMouseOver:GetScript("OnLeave"))
    end

  elseif (event == "PLAYER_LOGOUT") then
    if (Overachiever_CharVars.Pos_AchievementFrame) then
    -- Set standard location for this frame for other characters that don't have positions saved yet:
      Overachiever_CharVars_Default = Overachiever_CharVars_Default or {}
      Overachiever_CharVars_Default.Pos_AchievementFrame = Overachiever_CharVars.Pos_AchievementFrame
    end

   --[[  No longer necessary as this is now done by WoW itself:
    -- Remember tracked achievements:
    local num = GetNumTrackedAchievements()
    if (num > 0) then
      if (num == 1) then
        Overachiever_CharVars.TrackedAch = GetTrackedAchievements()
      else
        Overachiever_CharVars.TrackedAch = { GetTrackedAchievements() }
      end
    else
      Overachiever_CharVars.TrackedAch = nil
    end
   --]]

  --else
    --chatprint(event)

  end
end


function Overachiever.OpenTab(name)
  if (not AchievementFrame or not AchievementFrame:IsShown()) then
    ToggleAchievementFrame()
  end
  local frame = _G[name]
  if (frame) then  Overachiever.OpenTab_frame(frame);  end
end

function Overachiever.UI_SelectAchievement(id, failFunc, ...)
  AchievementFrameBaseTab_OnClick(1)
  Overachiever.NoAlterSetFilter = true
  local retOK, ret1 = pcall(AchievementFrame_SelectAchievement, id)
  Overachiever.NoAlterSetFilter = nil
  if (retOK) then
    local category = GetAchievementCategory(id)
    local _, parentID = GetCategoryInfo(category)
    if (parentID == -1) then
      expandCategory(category)
    end
    return true
  else
    chatprint(L.MSG_ACHNOTFOUND)
    if (Overachiever_Debug) then
      chatprint(ret1, "[Error]")
    elseif (failFunc) then
      failFunc(...)
    else
    -- Open to summary to hide potentially problematic (though interesting) listing of irregular achievements:
      AchievementCategoryButton_OnClick(AchievementFrameCategoriesContainerButton1)
    end
  end
  return false
end

function Overachiever.UI_HookAchButtons(buttons, scrollbar)
  for i,button in ipairs(buttons) do
    button:HookScript("OnEnter", achbtnOnEnter)
    button:HookScript("OnLeave", achbtnOnLeave)
    local shield = _G[button:GetName().."Shield"]
    --shield:SetScript("OnEnter", achbtnShieldOnEnter)
    shield:EnableMouse(false) -- Removes its tie to AchievementShield_OnEnter and lets the parent button control highlighting, etc.
  end
  scrollbar:HookScript("OnValueChanged", achBtnRedisplay)
end

Overachiever.IsAchievementInUI = isAchievementInUI;
Overachiever.OpenToAchievement = openToAchievement;
Overachiever.GetAllAchievements = getAllAchievements;
--Overachiever.BuildCriteriaLookupTab = BuildCriteriaLookupTab;
Overachiever.AddAchListToTooltip = AddAchListToTooltip;
Overachiever.IsGuildAchievement = isGuildAchievement
Overachiever.isUIInGuildView = isUIInGuildView


-- SLASH COMMANDS
-------------------

local function slashHandler(msg, self, silent, func_nomsg)
  if (msg == "") then
    func_nomsg = func_nomsg or ToggleAchievementFrame
    func_nomsg();
  --elseif (msg == "!!rebuild") then
    --Overachiever_CharVars_Consumed.LastBuilt = nil
    --chatprint("Food/drink lookup table will be rebuilt the next time Overachiever loads. Use the /reload command to do so now.")
  else
    if (Overachiever_Settings.Slash_SearchTab) then
	  if (Overachiever.OpenSearchToNameOrID(msg))  then  return;  end
	end

	local results = Overachiever.AchSearchNameOrID(msg, not not silent, nil, nil, silent and 1 or nil)
	local num = #results
	if (num > 0) then
		local id, pos = Overachiever.GetFirstVisibleAchFromList(results)
		if (not silent) then
			if (id) then
				tremove(results, pos)
				num = num - 1
			end
			if (id) then
				chatprint(L.MSG_OPENINGTO..GetAchievementLink(id))
				if (num == 1) then
					chatprint(L.MSG_ONEFOUND..GetAchievementLink(results[1]))
				end
			end
			if (not id and num == 1) then
				chatprint(L.MSG_NOOPEN_LIST:format(num) .. " " .. GetAchievementLink(results[1]))
			elseif (num > 1) then
				chatprint(id and L.MSG_NUMFOUNDLIST:format(num) or L.MSG_NOOPEN_LIST:format(num))
				local a, b, c
				for i=1,num,3 do
					a, b, c = results[i], results[i+1], results[i+2]
					a, b, c = GetAchievementLink(a), b and GetAchievementLink(b), c and GetAchievementLink(c)
					if (b) then  a = a.."  --  "..b;  end
					if (c) then  a = a.."  --  "..c;  end
					chatprint(a, "-- ")
				end
			end
			if (not id) then  chatprint(L.MSG_NOOPEN);  end
		end
		if (id) then  openToAchievement(id);  end
	elseif (not silent) then
		if (tonumber(msg) or (strsub(msg, 1,1) == "#" and tonumber(strsub(msg, 2)))) then
			chatprint(L.MSG_INVALIDID)
		else
			chatprint(L.MSG_NAMENOTFOUND:format(msg))
		end
	end
    --[[
    if (strsub(msg, 1,1) == "#") then
      local id = tonumber(strsub(msg, 2))
      if (id) then
        if (GetAchievementInfo(id)) then
          if (not silent) then  chatprint(L.MSG_OPENINGTO..GetAchievementLink(id));  end
          openToAchievement(id)
        elseif (not silent) then
          chatprint(L.MSG_INVALIDID);
        end
        return;
      end
    end
    local id = Overachiever.SearchForAchievement(nil, nil, ACHINFO_NAME, msg, not silent)
    if (id) then  openToAchievement(id);  end
	--]]
  end
end

function openOptions(panel) -- function name defined as local above
  panel = panel or OptionsPanel
  InterfaceOptionsFrame_OpenToCategory(panel)
  -- Working around a Blizzard bug by calling this twice:
  InterfaceOptionsFrame_OpenToCategory(panel)

  -- Expand the options category: (based in part on code in InterfaceOptionsFrame.lua function InterfaceOptionsFrame_OpenToCategory)
	local elementToDisplay
	for i, element in next, INTERFACEOPTIONS_ADDONCATEGORIES do
		if ( element == panel ) then --or (panelName and element.name and element.name == panelName) ) then
			elementToDisplay = element;
			break;
		end
	end
	local buttons = InterfaceOptionsFrameAddOns.buttons;
	for i, button in next, buttons do
		if ( button.element == elementToDisplay and button.element.collapsed ) then
			OptionsListButtonToggle_OnClick(button.toggle);
			break;
		end
	end
end

SLASH_Overachiever1 = "/oa";
SlashCmdList["Overachiever"] = function (msg, self)  slashHandler(msg, self, nil, openOptions);  end

SLASH_Overachiever_silent1 = "/oasilent";
SLASH_Overachiever_silent2 = "/oas";
SlashCmdList["Overachiever_silent"] = function(msg, self)  slashHandler(msg, self, true, openOptions);  end;

SLASH_Overachiever_silentAch1 = "/achsilent";
SLASH_Overachiever_silentAch2 = "/achs";
SlashCmdList["Overachiever_silentAch"] = function(msg, self)  slashHandler(msg, self, true);  end;

-- Replace the original slash command handler for /ach, /achieve, /achievement, and /achievements:
SlashCmdList["ACHIEVEMENTUI"] = slashHandler;


-- MAPS AND ZONES
--------------------------

function Overachiever.GetContinents()
	return C_Map.GetMapChildrenInfo(COSMIC_MAP_ID, Enum.UIMapType.Continent, true)
end

if (WOW_BFA) then
----- BFA:

function Overachiever.GetZones(parentMapID)
	return C_Map.GetMapChildrenInfo(parentMapID or COSMIC_MAP_ID, Enum.UIMapType.Zone, true)
end

----- :BFA
else
----- Legion:

local function getMapContinents_names()
  local tab = {}
  local continents = { GetMapContinents() }
  local count = 0
  for i,v in ipairs(continents) do
    if (i % 2 == 0) then -- As of WoW 6.0, only the even numbered results are strings. The rest are integers (IDs for the continents).
      count = count + 1
      tab[count] = continents[i];
    end
  end
  return tab
end

local function getMapZones_names(index)
  local tab = {}
  local zones = { GetMapZones(index) }
  local count = 0
  for i,v in ipairs(zones) do
    if (i % 2 == 0) then -- As of WoW 6.0, only the even numbered results are strings. The rest are integers (IDs for the continents).
      count = count + 1
      tab[count] = zones[i];
    end
  end
  return tab
end

function Overachiever.GetZones()
	local zones = {}
	local continents = getMapContinents_names()
	local num = 0
	for i,cname in pairs(continents) do
		local zones_continent = getMapZones_names(i)
		for k,v in pairs(zones_continent) do
			num = num + 1
			zones[num] = v
		end
	end
	return zones
end

----- :Legion
end

function Overachiever.GetDungeons(parentMapID)
	return C_Map.GetMapChildrenInfo(parentMapID or COSMIC_MAP_ID, Enum.UIMapType.Dungeon, true)
end

function Overachiever.GetParentZone(mapID)
	-- Get the map ID of the parent zone for a map, e.g. Elwynn Forest's ID if given Northshire's ID. Limited to giving zones' IDs, not continents', so if given
	-- Elwynn Forest's ID, it returns nil.
	--if (not mapID) then  mapID = MapUtil.GetDisplayableMapForPlayer();  end
	if (not mapID) then  mapID = C_Map.GetBestMapForUnit("player");  end
	local parent = MapUtil.GetMapParentInfo(mapID, Enum.UIMapType.Zone, true)
	return parent and parent.mapID ~= mapID and parent or nil
end



-- LOCALIZATION ASSIST
--------------------------

if (Overachiever_Debug) then

  function Overachiever.Debug_GetKillCriteriaAchs()
    local data = Overachiever.GetKillCriteriaLookup()
    if (not data) then  return;  end
    local tab, _, a = {}
    for k,v in pairs(data) do
      for i = 1, #v, 2 do
        _, a = GetAchievementInfo( v[i] )
        tab[a] = (tab[a] or 0) + 1
      end
    end
    return tab
  end

  -- Achievement and criteria data gathering:

  function Overachiever.Debug_GetAchData()
    local tab = Overachiever_Settings.Debug_AchData
    if (not tab) then  Overachiever_Settings.Debug_AchData = {};  tab = Overachiever_Settings.Debug_AchData;  end
    local _, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText
    local critString, critType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, critID
    for k,id in pairs(OVERACHIEVER_ACHID) do
      _, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText = GetAchievementInfo(id)
      tab[id] = { Name = Name, Description = Description, RewardText = RewardText }
      tab[id].Criteria = {}
      local crit = tab[id].Criteria
      for i=1,GetAchievementNumCriteria(id) do
        critString, critType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, critID = GetAchievementCriteriaInfo(id, i)
        if (not strfind(quantityString, "/")) then  quantityString = nil;  end
        crit[i] = { critString = critString, quantityString = quantityString }
      end
    end
    chatprint("Achievement/criteria data gathered. Reload the interface or log out to output to saved variables file.")
  end

  -- Zone data gathering:

  local ZoneID

  local function BuildZoneIDTable_z(connum, num, zonename, next, ...)
    num = num + 1
    ZoneID[zonename] = {}
    ZoneID[zonename].C = connum
    ZoneID[zonename].Z = num
    if (next) then
      BuildZoneIDTable_z(connum, num, next, ...)
    end
  end

  -- Intended first call: BuildZoneIDTable(0, Overachiever.GetContinentsNames());
  local function BuildZoneIDTable(num, conname, next, ...)
    num = num + 1
    --print("BuildZoneIDTable: "..conname.." ("..num..")")
    BuildZoneIDTable_z(num, 0, Overachiever.GetMapZones_names(num))
    if (next) then
      BuildZoneIDTable(num, next, ...)
    end
  end

  -- /run Overachiever.Debug_GetExplorationData(true)
  function Overachiever.Debug_GetExplorationData(testAchMatch, saveZoneIDs)
    if (not ZoneID and (testAchMatch or saveZoneIDs)) then
      ZoneID = {}
      BuildZoneIDTable(0, Overachiever.GetContinentsNames());
      chatprint("Zone data gathered.")
    end
    if (saveZoneIDs) then  Overachiever_Settings.Debug_ZoneData = ZoneID;  end

    local tab = {}
    local catname, id, name, trimname
    for _, category in ipairs(CATEGORIES_EXPLOREZONES) do
      catname = GetCategoryInfo(category)
      tab[catname] = {}
      for i=1,GetCategoryNumAchievements(category) do
        id, name = GetAchievementInfo(category, i)
        if (id) then
          if (testAchMatch) then
            trimname = strsub(name,9) -- Cut off "Explore " - meant for use with English client only
            if (trimname and ZoneID[trimname]) then
              name = trimname
            else
              chatprint("Achievement name doesn't match a zone: "..name)
              name = "!! "..name
            end
          end
          tab[catname][name] = id;
        end
      end
    end
    Overachiever_Settings.Debug_ExplorationData = tab
    chatprint("Exploration Achievement data gathered. Reload the interface or log out to output to saved variables file.")
  end

end


-- FRAME INITIALIZATION
--------------------------

Overachiever.MainFrame = CreateFrame("Frame")
Overachiever.MainFrame:Hide()
Overachiever.MainFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
Overachiever.MainFrame:RegisterEvent("ADDON_LOADED")
--Overachiever.MainFrame:RegisterEvent("ACHIEVEMENT_EARNED")
Overachiever.MainFrame:RegisterEvent("TRACKED_ACHIEVEMENT_UPDATE")
Overachiever.MainFrame:RegisterEvent("CRITERIA_EARNED")
Overachiever.MainFrame:RegisterEvent("PLAYER_LOGOUT")

Overachiever.MainFrame:SetScript("OnEvent", Overachiever.OnEvent)

--Overachiever.MainFrame:RegisterEvent("PLAYER_LOGIN")




--[[
-- /run Overachiever.ListCompletedAchievements()
function Overachiever.ListCompletedAchievements()
	local achs = Overachiever.GetAllAchievements()
	local list, num = {}, 0
	for i,id in ipairs(achs) do
		local id, name, points, completed = GetAchievementInfo(id)
		if (completed) then
			num = num + 1
			list[num] = id
		end
	end
	C_Timer.After(0, function()
		local s = ""
		for i,id in ipairs(list) do
			s = s .. id .. "\r\n"
		end
		error(s)
	end)
	return list
end
--]]


--[[ obsolete?
getAchievementID
getCategoryID
CATEGORIES_INDIV_ALL, CATEGORIES_GUILD_ALL, CATEGORIES_ALL
BuildCategoryInfo

Overachiever.UI_GetValidCategories

GetAllAchievements
Overachiever.GetAllAchievements

isGuildAchievement
--]]
