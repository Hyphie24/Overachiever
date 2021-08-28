
--[[
----------------------------------------------------------------------------------------------------------------------------------------------

TjAchieve.lua
  by Tuhljin

Dependencies: TjThreads library is required for BuildIDCache(), BuildCritAssetCache(), and related features.

Make it easier for addons to deal with achievements, with a focus on improving performance (handling caches and throttling) and preventing
error messages (which can occur when you're trying achievement/criteria IDs without first verifying that they are valid).

For commonly called functions that "replace" standard WoW API calls, it is suggested that you simplify things by using a line like the
following near the top of your script:
  local GetAchievementCriteriaInfo = TjAchieve.GetAchievementCriteriaInfo

A note on terminology: An achievement that's "visible" in the GUI is one you can find and select in the non-modded achievement GUI. This does
not include achievements in a series which aren't shown because you aren't on that step and it isn't the most recently completed step. The
"standard" achievements are all the visible ones plus those that aren't visible but are in a series with a visible achievement. This does not
include achievements exclusive to the opposite faction or unacquired Feats of Strength.

CAREFUL: As a general rule, you should not alter the contents of tables returned by these functions. Many of them are used internally.


Quick and safe to call any time
-------------------------------

These functions get results quickly enough that you shouldn't need to worry about processing time or listeners. They either don't use caches
or rapidly build them on demand.

TjAchieve.GetAchievementCriteriaInfo( achievementID, criteriaIndex )
  Call this instead of the normal GetAchievementCriteriaInfo function to prevent an error from being thrown when an invalid achievement or
criteria index is used. Returns nil if there would have been an error. You must still use numbers as arguments or an error IS thrown.
  NOTE: This is only intended for use with two arguments, as indicated (achievementID, criteriaIndex). It won't work with the one-argument
signature option of the normal GetAchievementCriteriaInfo function (statisticID). The underlying GetAchievementCriteriaInfo function is
an expensive call so, despite this being in the "Quick" section, it may take a while if called, say, hundreds of times at once.

list = TjAchieve.GetAllCategories()
  Returns a list (numerically indexed table) of all category IDs, a combination of WoW's GetCategoryList() and GetGuildCategoryList().

list = TjAchieve.GetAchIDs()
  Returns a list of all achievement IDs.

list = TjAchieve.GetGuildAchIDs()
  Returns a list of all guild achievement IDs.

list = TjAchieve.GetOtherAchIDs()
  Returns a list of all IDs for achievements that aren't of the personal or guild type. For example, those used for hidden tracking. Note that
there is no "standard" equivalent to this function (like "GetStandardOtherAchIDs()") since such achievements are nonstandard by definition.

list = TjAchieve.GetPersonalAchIDs()
  Returns a list of all non-guild achievement IDs.

num = TjAchieve.GetRealNumCriteria( achievementID )
  Returns the actual number of criteria for the given achievement. This is usually the same as what the normal GetAchievementNumCriteria function
gives but there are a few achievements where it is different. (This can vary depending on the faction of the current player character.)
  For instance, as of WoW 7.3.5 and likely earlier, both versions of "Warlord of Draenor" (9508 for Horde, 9738 for Alliance) only list one or
two criteria in the achievement GUI when they really should show eight. (This function successfully returns 8 but, because of a quirk or bug with
WoW itself that we can't work around, only for the achievement for your own faction. Usually, faction does not make a difference, though.)
  NOTE: Sometimes the discrepancy is apparently the result of a bug (as with "Warlord of Draenor") which means this function can be a helpful
workaround. Other times, there is a good reason for the difference. (For instance, a criteria may used internally but is only confusing if shown
to the player.) Still other times, it is debatable whether the criteria should be shown or it is useful only in certain circumstances. For this
reason, it's recommended that you use this feature carefully.


Cacheless but with optional throttled processing
------------------------------------------------

These functions don't use a cache but the results can take a while to process, so a listener can (optionally) be used. The listener is a function
you pass to them which will be called with your results when they're ready.

TjAchieve.StartSearchCriteriaByCategory( query, [categoriesList,] listenerFunc )
  Gathers a list of achievement IDs that have criteria which match the given query and which are within one of the given categories.
  Arguments:
    query (string)			The text to look for. You can pass TjAchieve.ANY_NON_BLANK in to include all achievements that have defined criteria.
    categoriesList (table)	A numerically indexed table containing achievement category IDs. You can omit this argument or pass false to include
							all achievement categories.
    listenerFunc (function)	The listener function. When the search is complete, it will be passed either a table containing the list mentioned
							above or false, indicating nothing was found.

list = TjAchieve.SearchCriteriaByCategoryNow( query[, categoriesList] )
  As TjAchieve.StartSearchCriteriaByCategory, except it isn't throttled and the results are returned immediately instead of being passed to another
function. This may cause the game to stutter for a few moments.

TjAchieve.StartSearchCriteriaByID( query, [idList,] listenerFunc )
  As TjAchieve.StartSearchCriteriaByCategory except it looks at all achievements in a list of achievement IDs instead of looking at achievement
categories. You can omit the idList argument or pass false there to include all achievements (even those that aren't found in the UI).

list = TjAchieve.SearchCriteriaByIDNow( query[, idList] )
  As TjAchieve.StartSearchCriteriaByID, except it isn't throttled and the results are returned immediately instead of being passed to another
function. This may cause the game to stutter for a few moments.


Calling before a cache is built may build it
--------------------------------------------

These functions may force a rush build of the associated cache (if it isn't fully built yet) to ensure the returns are accurate, resulting
in significant execution time.

id = TjAchieve.GetFirstSeenInSeries( achID )
  Given an achievement ID, returns the same ID if it is visible in the UI. Otherwise, if the achievement is in a series, then the ID of the
"closest" visible achievement is returned (the first visible achievement found when traversing up/down the series). If this fails, false is
returned.

id[, id2, ...] OR list = TjAchieve.GetAchievementByAsset( assetType, assetID[, packed ] )
  Given an asset's type and ID, returns all of the achievement IDs associated with that asset.
  If the packed argument evaluates to true, then the values normally returned may instead be part of a table which is then the only return
value. (If multiple IDs would be returned, or if packed is set to the string "always", they will be in a table. Otherwise, only a single,
non-table value is returned.) Do not alter the table's contents! In some cases, they are used internally.

id, index[, id2, index2, ...] OR list = TjAchieve.GetCriteriaByAsset( assetType, assetID[, packed ] )
  Given an asset's type and ID, returns all of the achievement IDs and criteria indexes associated with that asset.
  If the packed argument evaluates to true, then the values normally returned will instead be part of a table which is then the only return
value. Do not alter the table's contents! They are used internally.

list = TjAchieve.GetStandardAchIDs()
  Returns a list of IDs for all standard achievements. ("Standard" as per the definition given at the top of this file.)

list = TjAchieve.GetStandardPersonalAchIDs()
  Returns a list of IDs for all standard personal (non-guild) achievements.

list = TjAchieve.GetStandardGuildAchIDs()
  Returns a list of IDs for all standard guild achievements.

bool = TjAchieve.IsAchievementStandard( id )
  Return true if the achievement with the given ID is a standard achievement (per the definition given above).

bool = TjAchieve.IsAchievementVisible( id )
  Return true if the achievement with the given ID is visible in the GUI.


Achievement ID cache management
-------------------------------

status = TjAchieve.BuildIDCache()
  Start populating the achievement ID cache. This may take some time but it is throttled so as to allow gameplay and other scripts to
continue. It is safe to call multiple times since only the first call will start the process.
  Returns:
    status (string)		"started" (if just started due to your call), "ongoing" (if started previously), or "complete".

ready = TjAchieve.IsIDCacheReady()
  Returns true if the achievement ID cache has been fully populated. False otherwise.

TjAchieve.RushBuildIDCache()
  Populates the achievement ID cache without throttling. If the throttled process was already started, this takes over where that left off.

TjAchieve.AddBuildIDCacheListener( func )
  Specify a function to be called once the ID cache has been fully populated. If it is already populated, then the function is called almost
immediately (on the next tick).


Criteria asset ID cache management
----------------------------------

status = TjAchieve.BuildCritAssetCache( assetType[, saveIndex] )
  Start populating a criteria asset ID cache. This may take some time but it is throttled so as to allow gameplay and other scripts to
continue. It is safe to call multiple times since only the first call will start the process.
  Unlike the achievement ID cache, there can be more than one resulting cache and which one is built depends on the arguments passed here.
  Arguments:
    assetType (number)	The asset ID. For instance, 0 for mob IDs or 8 for IDs of achievements that are criteria (used by meta-achievements).
    saveIndex (boolean)	If true, then the resulting cache saves the criteria index in addition to the achievement ID. Defaults to false. If
    					the index isn't needed, this should be false to avoid the excessive use of memory. If this function was already called
    					using the same assetType but saveIndex was false and now it is true, then previous data will be discarded and the
    					cache will be rebuilt.
  Returns:
    status (string)		"started" (if just started due to your call), "ongoing" (if started previously), or "complete".

ready = TjAchieve.IsCritAssetCacheReady( assetType )
  Returns 1 or 2 if the criteria asset ID cache has been fully populated: 1 if without criteria indexes, 2 if with indexes. Returns false
otherwise.

TjAchieve.RushBuildCritAssetCache( assetType[, saveIndex] )
  Populates the criteria asset ID cache without throttling. If the throttled process was already started, this takes over where that left off.

TjAchieve.AddBuildCritAssetCacheListener( assetType, func )
  Specify a function to be called once the criteria asset ID cache has been fully populated. If it is already populated, then the function is
called almost immediately (on the next tick). The function is passed the assetType (to allow you to use a single function to listen for
multiple criteria asset ID caches' completions).

TjAchieve.PopulateCritAssetCache( assetType, data )
  Populate the criteria asset cache using previously-saved data. Must be the COMPLETE data for all achievements and must be in the same format
used by TjAchieve normally or unexpected results may occur when the cache is called upon.


Constants
---------

TjAchieve.CRITTYPE_META		The asset type for meta-achievement criteria.
TjAchieve.CRITTYPE_KILL		The asset type for kill criteria.


----------------------------------------------------------------------------------------------------------------------------------------------
--]]


local THIS_VERSION = "0.13"

if (TjAchieve and TjAchieve.Version >= THIS_VERSION) then  return;  end  -- Lua's pretty good at this. It even knows that "1.0.10" > "1.0.9". However, be aware that it thinks "1.0" < "1.0b" so putting a "b" on the end for Beta, nothing for release, doesn't work.

TjAchieve = TjAchieve or {}
local TjAchieve = TjAchieve
TjAchieve.Version = THIS_VERSION

TjAchieve.CRITTYPE_KILL = 0
TjAchieve.CRITTYPE_META = 8

TjAchieve.ANY_NON_BLANK = "~any_non_blank~" -- Special wildcard for searches. (Must be lowercase since strlower is used on queries.)

-- Set this to a higher number to finish building the lookup table faster. If frame rate drops occur, lower the number. Minimum 1.
-- Can also/instead change INTERVAL in libs/TjThreads.lua to try to reduce drops in frame rate (theoretically).
local BUILD_CRIT_STEPS = 20  --50 --15 --50
local BUILD_CRITCOUNT_STEPS = 100

local BUILD_ID_CAT_STEPS = 5

local SEARCH_CRIT_CAT_STEPS = 100
local SEARCH_CRIT_IDS_STEPS = 250 --750

local ACH, CRITCOUNT



----------------------------------------------------------------------------------------------------------------------------------------------
-- API WRAPPERS AND ALTERNATIVES
-- These exist because using WoW's default API functions can result in errors in some cases.
----------------------------------------------------------------------------------------------------------------------------------------------

-- HELPERS

local GetAchievementInfo = GetAchievementInfo
local GetPreviousAchievement = GetPreviousAchievement
local GetNextAchievement = GetNextAchievement

local pcall = pcall

-- A protected call that doesn't append true to the results when successful and returns nil if unsuccessful.
local tryCall
do
	local function tryCall_helper(noerrors, ...)
		if (noerrors) then  return ...;  end
		return nil;
	end
	function tryCall(func, ...)
		-- Supposedly, it's more efficient to do this here than encapsulating the returns in a table and using tremove and unpack:
		return tryCall_helper(pcall(func, ...))
	end
end

--[[
local function tryCall(func, ...)
	return (function(noerrors, ...)
		if (noerrors) then  return ...;  end
		return nil;
	)(pcall(func, ...));
end
--]]

--[[
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
--]]


-- Overcome problem where GetAchievementCriteriaInfo throws an error if the achievement ID or criteria number is invalid:
do
	local GACI = GetAchievementCriteriaInfo
	function TjAchieve.GetAchievementCriteriaInfo(achievementID, index)
		assert(type(achievementID) == "number", "Usage: TjAchieve.GetAchievementCrieriaInfo(achievementID, index)")
		assert(type(index) == "number", "Usage: TjAchieve.GetAchievementCrieriaInfo(achievementID, index)")
		return tryCall(GACI, achievementID, index)
	end
end
local GetAchievementCriteriaInfo = TjAchieve.GetAchievementCriteriaInfo


local orig_GetAchievementNumCriteria = GetAchievementNumCriteria
do
	function TjAchieve.GetRealNumCriteria(achievementID)
		--assert(type(achievementID) == "number", "Usage: TjAchieve.GetRealNumCriteria(achievementID)")
		if (CRITCOUNT[achievementID]) then  return CRITCOUNT[achievementID];  end
		if (TjAchieve.status_ACH) then
			-- If the cache was built and it's not in there, then the count from the normal function is correct so it may be quicker to call that than
			-- do our own calculation.
			return orig_GetAchievementNumCriteria(achievementID)
		end
		local i = 0
		local _, completed, asset
		repeat
			i = i + 1
			_, _, completed, _, _, _, _, asset = GetAchievementCriteriaInfo(achievementID, i)
		until (not asset)
		return i - 1
	end
end
local real_GetAchievementNumCriteria = TjAchieve.GetRealNumCriteria

--[[ UNUSED:
-- Overcome problem where GetAchievementInfo throws an error if the achievement ID is invalid:
--    Call this instead of the normal GetAchievementInfo function to prevent an error from being thrown when an
--    invalid achievement or category ID is used. Returns nil if there would have been an error. You must still use
--    integers as arguments or an error is thrown.
--    Note: Since WoW 5.1, GetAchievementInfo seems to behave how it used to months (years?) ago: Returning nil
--    instead of throwing errors due to an invalid achievement ID or category ID argument (provided they are
--    integers, anyway). The code for this function remains here, though, in case things change again.

-- Simple error-preventing version:
do
	local GAI = GetAchievementInfo
	function TjAchieve.GetAchievementInfo(...)
		return tryCall(GAI, ...)
	end
end
local GetAchievementInfo = TjAchieve.GetAchievementInfo

-- Alternate version: Populates the cache.
function TjAchieve.GetAchievementInfo(category, id)
  if (type(id) ~= "number") then  id = category;  category = nil;  end  -- Emulates how standard GetAchievementInfo gets arguments: Checking on the second argument's type, not just seeing if it's nil/false.
  if (ACH[id] == false) then  return nil;  end
  if (ACH[id] == nil) then
    if (type(id) ~= "number") then  error("Invalid achievement ID.", 2);  end
    if (category and type(category) ~= "number") then  error("Invalid achievement category ID.", 2);  end
    local ret
    if (category) then  ret = pcall(GetAchievementInfo, category, id);  else  ret = pcall(GetAchievementInfo, id);  end
    if (not ret) then
      ACH[id] = false
      return nil
    end
    ACH[id] = category or true
  end
  if (category) then  return GetAchievementInfo(category, id);  end
  return GetAchievementInfo(id)
end
--]]



----------------------------------------------------------------------------------------------------------------------------------------------
-- CACHE DEFINITIONS AND BASIC ACCESS
----------------------------------------------------------------------------------------------------------------------------------------------

-- NOTE: It is recommended that you use the functions provided to get data (see above) instead of directly referencing the variables
-- that make up a cache.

-- TjAchieve.status_ACH 	values: nil = Not started. false = Building. true = Ready.

-- ALL ACHIEVEMENTS ID cache. When fully populated, it includes every achievement the API tells us exists.
-- Keys are IDs (integers). Possible values:
-- true			The achievement was found in the standard UI.
-- -1			It has not been determined whether this achievement is in the standard UI.
-- 0			The achievement cannot be found in the standard UI and we expect this won't change.
-- number > 0	The achievement wasn't found in the standard UI but another from the same series was. This is that achievement's ID.
--				(Only the last complete and first incomplete achievement in a series are displayed. This ID will be the incomplete
--				achievement if the requested achievement is incomplete or the complete achievement otherwise.)
TjAchieve.ACH = TjAchieve.ACH or {}
ACH = TjAchieve.ACH  -- ACH defined above as local


-- Achievement criteria index cache. Stores highest numbered criteria found for a given achievement. THIS IS NOT A COMPLETE LIST. Even when
-- fully populated, it only includes achievements where GetAchievementNumCriteria does not match the value from TjAchieve.GetRealNumCriteria.
TjAchieve.CRITCOUNT = TjAchieve.CRITCOUNT or {}
CRITCOUNT = TjAchieve.CRITCOUNT  -- CRITCOUNT defined above as local


--[[ UNUSED:
-- Achievement criteria/statistic ID cache. Possible values:
-- false: This is an invalid ID.
-- true: This is a valid ID.
TjAchieve.CRIT = TjAchieve.CRIT or {}
local CRIT = TjAchieve.CRIT
--]]


-- TjAchieve.status_CA[assetType]		values: nil = Not started. false = Building. true = Ready.

-- CRITERIA ASSETS ID cache. Divided into parts, a key and data for each. That key indicates the criteria asset type in question (e.g. 0 for
-- mob IDs). The data is a table with its own keys, which are integers giving the asset ID (e.g. the actual mob ID). The value for the data
-- table will either be an integer, indicating the associated achievement ID, or a table, which will either be a simple list of multiple
-- achievement IDs OR it will be a list which alternately gives achievement IDs and criteria indexes, like this:
--   { id, index }
-- Or, if there are multiple IDs and associated indexes, like this:
--   { id1, index1, id2, index2, ... }
-- You can tell whether indexes are included or not by checking against the key "saveIndex" of the associated data table, which will be true
-- if indexes are included.
TjAchieve.ASSETS = TjAchieve.ASSETS or {}
local ASSETS = TjAchieve.ASSETS


function TjAchieve.GetAllCategories()
	if (not TjAchieve.CATEGORIESLIST) then
		local list1 = GetCategoryList()
		local list2 = GetGuildCategoryList()
		local thelist = {}
		TjAchieve.CATEGORIESLIST = thelist
		local i = 0
		for k,v in pairs(list1) do
			i = i + 1
			thelist[i] = v
		end
		for k,v in pairs(list2) do
			i = i + 1
			thelist[i] = v
		end
	end
	return TjAchieve.CATEGORIESLIST
end

local function getAllAchievements(key, catFunc, excludeCats)
	-- Retrieve an array of all achievement IDs, including those not normally listed in the UI for this character.
	local ACHIEVEMENTS_ALL = TjAchieve.ACHIEVEMENTS_ALL
	if (not ACHIEVEMENTS_ALL) then
		ACHIEVEMENTS_ALL = {}
		TjAchieve.ACHIEVEMENTS_ALL = ACHIEVEMENTS_ALL
	end
	if (ACHIEVEMENTS_ALL[key]) then  return ACHIEVEMENTS_ALL[key];  end
	local catlist = catFunc()
	local catlookup = {}
	for i,c in ipairs(catlist) do
		catlookup[c] = true
	end

	local buildlist = {}
	local gap, i, size, id = 0, 0, 0
	--local debug_largestgap = 0
	local GetAchievementCategory = GetAchievementCategory
	repeat
		i = i + 1
		id = GetAchievementInfo(i)
		if (id) then
			--if (gap > debug_largestgap) then debug_largestgap = gap; print("high gap:",debug_largestgap); end
			gap = 0
			if (key == 1) then
				size = size + 1
				buildlist[size] = id
				if (catlookup[GetAchievementCategory(id)]) then  -- If its achievement category is in the UI:
					ACH[id] = -1
				else
					ACH[id] = 0
				end
			else
				local inCat = catlookup[GetAchievementCategory(id)]
				if ((not excludeCats and inCat) or (excludeCats and not inCat)) then
					size = size + 1
					buildlist[size] = id
				end
			end
		else
			gap = gap + 1
		end
	until (gap > 1000) -- 1000 is arbitrary. As of this writing, the largest gap is 79, but this is more future-safe.
	--print("last ach ID:",buildlist[size], "/ size:",size)
	catlookup = nil
	ACHIEVEMENTS_ALL[key] = buildlist
	return buildlist
end

function TjAchieve.GetAchIDs()
	return getAllAchievements(1, TjAchieve.GetAllCategories)
end

function TjAchieve.GetPersonalAchIDs()
	return getAllAchievements(2, GetCategoryList)
end

function TjAchieve.GetGuildAchIDs()
	return getAllAchievements(3, GetGuildCategoryList)
end

function TjAchieve.GetOtherAchIDs()
	return getAllAchievements(4, TjAchieve.GetAllCategories, true)
end


local getFirstSeenInSeries_precache
local function getFirstSeenInSeries(id)
	if (not TjAchieve.status_ACH and not getFirstSeenInSeries_precache) then
		TjAchieve.RushBuildIDCache()
	end
	if (ACH[id] == true) then  return id;  end
	local _, _, _, completed = GetAchievementInfo(id)
	local func = completed and GetNextAchievement or GetPreviousAchievement
	repeat
		id = func(id)
		if (id and ACH[id] == true) then  return id;  end
	until (not id)
	return false
end
TjAchieve.GetFirstSeenInSeries = getFirstSeenInSeries

function TjAchieve.GetAchievementByAsset(assetType, assetID, packed)
	assert(type(assetType) == "number", "Usage: TjAchieve.GetAchievementByAsset(assetType[, saveIndex])")
	local ready = TjAchieve.IsCritAssetCacheReady(assetType)
	if (not ready) then
		TjAchieve.RushBuildCritAssetCache(assetType)
	end
	local r = ASSETS[assetType][assetID]
	if (r) then
		if (type(r) == "table") then
			if (ready == 2) then -- Asking only for IDs but we got criteria indexes as well:
				if (#r == 2) then
					return r[1]
				elseif (#r == 4) then
					return r[1], r[3]
				end
				local tab = {}
				local num = 1
				for i = 1, #r, 2 do
					tab[num] = r[i]
					num = num + 1
				end
				if (packed and (packed == "always" or #tab > 1)) then  return tab;  end
				return unpack(tab)
			end
			if (packed and (packed == "always" or #r > 1)) then  return r;  end
			return unpack(r)
		end
		if (packed == "always") then  return { r };  end
		return r
	end
end

function TjAchieve.GetCriteriaByAsset(assetType, assetID, packed)
	assert(type(assetType) == "number", "Usage: TjAchieve.GetCriteriaByAsset(assetType[, saveIndex])")
	if (TjAchieve.IsCritAssetCacheReady(assetType) ~= 2) then
		TjAchieve.RushBuildCritAssetCache(assetType, true)
	end
	local r = ASSETS[assetType][assetID]
	if (r) then
		if (packed) then  return r;  end
		return unpack(r)
	end
end


local ACH_standard, ACH_standard_personal, ACH_standard_guild

local function buildStandardList(achList, tab)
	if (not TjAchieve.status_ACH) then
		TjAchieve.RushBuildIDCache()
	end
	local n = 0
	for i,id in ipairs(achList) do
		if (ACH[id] ~= 0) then
			n = n + 1
			tab[n] = id
		end
	end
end


function TjAchieve.GetStandardAchIDs()
	if (not ACH_standard) then
		ACH_standard = {}
		buildStandardList(TjAchieve.GetAchIDs(), ACH_standard)
	end
	return ACH_standard
end

function TjAchieve.GetStandardPersonalAchIDs()
	if (not ACH_standard_personal) then
		ACH_standard_personal = {}
		buildStandardList(TjAchieve.GetPersonalAchIDs(), ACH_standard_personal)
	end
	return ACH_standard_personal
end

function TjAchieve.GetStandardGuildAchIDs()
	if (not ACH_standard_guild) then
		ACH_standard_guild = {}
		buildStandardList(TjAchieve.GetGuildAchIDs(), ACH_standard_guild)
	end
	return ACH_standard_guild
end


function TjAchieve.IsAchievementStandard(id)
	if (not TjAchieve.status_ACH) then
		TjAchieve.RushBuildIDCache()
	end
	return ACH[id] ~= 0
end

function TjAchieve.IsAchievementVisible(id)
	if (not TjAchieve.status_ACH) then
		TjAchieve.RushBuildIDCache()
	end
	return ACH[id] == true
end



----------------------------------------------------------------------------------------------------------------------------------------------
-- THROTTLED POPULATION OF CACHES AND EVENT MONITORING TO KEEP IT ACCURATE
----------------------------------------------------------------------------------------------------------------------------------------------

TjAchieve.Frame = TjAchieve.Frame or CreateFrame("Frame")
-- Handle possible changes to UI visibility:
TjAchieve.Frame:RegisterEvent("ACHIEVEMENT_EARNED")
TjAchieve.Frame:SetScript("OnEvent", function(self, event, arg1)
	ACH[arg1] = true -- Most recently completed achievements are shown

	local id = GetPreviousAchievement(arg1)
	if (id) then
		-- Achievements prior to the most recent are not shown
		ACH[id] = arg1
	end

	id = GetNextAchievement(arg1)
	if (id) then
		-- The next achievement after the most recently completed one is shown
		ACH[id] = true
	end

	ACH_standard, ACH_standard_personal, ACH_standard_guild = nil, nil, nil
end)

local function informListeners(tab, arg1, errMsg)
	C_Timer.After(0, function()  -- Use a timer to allow clean up to be completed before listeners are informed.
		for i,func in ipairs(tab) do
			local noerrors, ret2
			if (arg1 == nil) then
				noerrors, ret2 = pcall(func)
			else
				noerrors, ret2 = pcall(func, arg1)
			end
			if (not noerrors) then
				C_Timer.After(0, function()  -- Use a timer so one listener's errors don't prevent other listeners from being called.
					error("TjAchieve encountered an error while " .. errMsg .. ". Check the listening function for problems. The original error message follows:\n" .. ret2)
				end)
			end
		end
	end)
end

local idCacheBuildStep
do
	local num = 0
	local tab, cats, size, prevcat, lastcat
	local function buildStepUIAch()
		if (num == 0) then
			tab = {}
			cats = TjAchieve.GetAllCategories()
			size = #cats
			prevcat = 0
			lastcat = BUILD_ID_CAT_STEPS
		else
			lastcat = prevcat + BUILD_ID_CAT_STEPS
		end
		if (lastcat > size) then  lastcat = size;  end
		for iCat = prevcat + 1, lastcat do
			local catID = cats[iCat]
			for i = 1, GetCategoryNumAchievements(catID) do
				local achID = GetAchievementInfo(catID, i)
				if (achID) then
					num = num + 1
					tab[num] = achID
				--else
					--print("huh",catID,i)
				end
			end
			prevcat = iCat
		end
		if (prevcat == size) then  return true;  end
	end

	function idCacheBuildStep()
		TjAchieve.GetAchIDs()
		TjAchieve.GetPersonalAchIDs()
		TjAchieve.GetGuildAchIDs()
		coroutine.yield()

		-- Determine which achievements currently show in the UI. (We'll listen to the ACHIEVEMENT_EARNED event to update this as needed.)
		while (not buildStepUIAch()) do
			coroutine.yield()
		end
		-- Save our results:
		for i,ach in ipairs(tab) do
			ACH[ach] = true
		end
		tab = nil

		-- Find first visible in series for each:
		for ach,v in pairs(ACH) do
			if (v == -1) then
				getFirstSeenInSeries_precache = true
				local id = getFirstSeenInSeries(ach)  -- This call is fast enough (at least with getFirstSeenInSeries_precache true) that we don't do any yields. If it becomes slower for some reason, consider adding one after every so many calls to it.
				getFirstSeenInSeries_precache = nil
				ACH[ach] = id or 0
			end
		end
		-- Handle possible changes to UI visibility:
		--do this earlier in case something changes while the cache is being built -- TjAchieve.Frame:RegisterEvent("ACHIEVEMENT_EARNED")

		-- Flag which achievements have mismatched max criteria numbers
		do
			local list = TjAchieve.GetAchIDs()
			local yieldIn = BUILD_CRITCOUNT_STEPS
			for x,id in ipairs(list) do
				if (yieldIn < 1) then
					--print("yield before", id)
					coroutine.yield()
					yieldIn = BUILD_CRITCOUNT_STEPS
				end
				yieldIn = yieldIn - 1

				local old = orig_GetAchievementNumCriteria(id)
				local new = real_GetAchievementNumCriteria(id)
				if (old ~= new) then
					CRITCOUNT[id] = new
				end
			end
		end

		-- We're done!
		TjAchieve.status_ACH = true
		if (TjAchieve.listeners_IDCache) then
			-- Inform the listeners:
			informListeners(TjAchieve.listeners_IDCache, nil, "calling an achievement ID cache listener")
			TjAchieve.listeners_IDCache = nil
		end
		idCacheBuildStep = nil -- Allow this do/end block to go out of scope
	end
end


function TjAchieve.BuildIDCache()
	if (TjAchieve.status_ACH == nil) then
		TjAchieve.status_ACH = false
		TjThreads.AddTask(idCacheBuildStep)
		return "started"
	end
	return TjAchieve.status_ACH and "complete" or "ongoing"
end

function TjAchieve.IsIDCacheReady()
	return not not TjAchieve.status_ACH
end

function TjAchieve.RushBuildIDCache()
	if (idCacheBuildStep) then
		TjThreads.RushTask(idCacheBuildStep)
	end
end

function TjAchieve.AddBuildIDCacheListener(func)
	if (TjAchieve.status_ACH == true) then
		C_Timer.After(0, func)
	else
		if (not TjAchieve.listeners_IDCache) then  TjAchieve.listeners_IDCache = {};  end
		TjAchieve.listeners_IDCache[#TjAchieve.listeners_IDCache + 1] = func
	end
end


local function flagTaskComplete(assetType)
	if (not TjAchieve.status_CA) then  TjAchieve.status_CA = {};  end
	TjAchieve.status_CA[assetType] = true
	if (TjAchieve.listeners_CACache and TjAchieve.listeners_CACache[assetType]) then
		informListeners(TjAchieve.listeners_CACache[assetType], nil, "updating a criteria asset cache listener")
		TjAchieve.listeners_CACache[assetType] = nil
		if (next(TjAchieve.listeners_CACache) == nil) then -- Is the table empty?
			TjAchieve.listeners_CACache = nil
		end
	end
	if (TjAchieve.CritAssetTasks) then
		TjAchieve.CritAssetTasks[assetType] = nil
		if (next(TjAchieve.CritAssetTasks) == nil) then -- Is the table empty?
			TjAchieve.CritAssetTasks = nil
		end
	end
	--print("task complete",assetType)
end

local function createAssetLookupFunc(assetType, saveIndex)
	saveIndex = not not saveIndex
	ASSETS[assetType] = { ["saveIndex"] = saveIndex } -- Important that this happens before the function is ever called.
	return function()
		--print("task start",assetType)
		local tab = ASSETS[assetType]
		local list = TjAchieve.GetAchIDs()
		local _, critType, assetID
		local numc, i
		local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
		local yieldIn = BUILD_CRIT_STEPS
		for x,id in ipairs(list) do
			if (yieldIn < 1) then
				--print("yield before", id,"(",assetType,")")
				coroutine.yield()
				yieldIn = BUILD_CRIT_STEPS
			end
			yieldIn = yieldIn - 1

			--for i=1,GetAchievementNumCriteria(id) do
			numc = real_GetAchievementNumCriteria(id)
			i = 1
			repeat
				_, critType, _, _, _, _, _, assetID = GetAchievementCriteriaInfo(id, i)
				if (critType and critType == assetType and assetID and assetID ~= 0) then
					if (tab[assetID]) then
						local v = tab[assetID]
						if (type(v) == "table") then
							local size = #v
							v[size+1] = id
							if (saveIndex) then  v[size+2] = i;  end
						else
							tab[assetID] = { v, id }  -- Safe to assume saveIndex isn't true since this wasn't already a table
						end
					else
						if (saveIndex) then
							tab[assetID] = { id, i }
						else
							tab[assetID] = id
						end
					end
				end
				i = i + 1
			until (i > numc or not assetID)
		end

		-- We're done!
		flagTaskComplete(assetType)
	end
end


function TjAchieve.BuildCritAssetCache(assetType, saveIndex)
	assert(type(assetType) == "number", "Usage: TjAchieve.BuildCritAssetCache(assetType[, saveIndex])")
	if (not TjAchieve.status_CA) then  TjAchieve.status_CA = {};  end
	if (saveIndex and ASSETS[assetType] and not ASSETS[assetType]["saveIndex"]) then
		-- If we want to save the index but the currently cached data doesn't do so:
		TjAchieve.status_CA[assetType] = nil
		if (TjAchieve.CritAssetTasks and TjAchieve.CritAssetTasks[assetType]) then
			TjThreads.RemoveTask(TjAchieve.CritAssetTasks[assetType])
			TjAchieve.CritAssetTasks[assetType] = nil
		end
	end
	if (TjAchieve.status_CA[assetType] == nil) then
		TjAchieve.status_CA[assetType] = false
		local func = createAssetLookupFunc(assetType, saveIndex)
		if (not TjAchieve.CritAssetTasks) then  TjAchieve.CritAssetTasks = {};  end
		TjAchieve.CritAssetTasks[assetType] = func
		TjThreads.AddTask(func)
		return "started"
	end
	return TjAchieve.status_CA[assetType] and "complete" or "ongoing"
end

function TjAchieve.PopulateCritAssetCache(assetType, data)
	assert(type(assetType) == "number" and type(data) == "table", "Usage: TjAchieve.PopulateCritAssetCache(assetType[, saveIndex])")
	if (TjAchieve.status_CA and TjAchieve.status_CA[assetType] == false) then
		-- Retrieval already in progress. Stop it:
		TjAchieve.status_CA[assetType] = nil
		if (TjAchieve.CritAssetTasks and TjAchieve.CritAssetTasks[assetType]) then
			TjThreads.RemoveTask(TjAchieve.CritAssetTasks[assetType])
			TjAchieve.CritAssetTasks[assetType] = nil
		end
	end
	ASSETS[assetType] = data
	flagTaskComplete(assetType)
end

function TjAchieve.IsCritAssetCacheReady(assetType)
	if (TjAchieve.status_CA and TjAchieve.status_CA[assetType]) then
		return ASSETS[assetType]["saveIndex"] and 2 or 1
	end
	return false
end

function TjAchieve.RushBuildCritAssetCache(assetType, saveIndex)
	assert(type(assetType) == "number", "Usage: TjAchieve.RushBuildCritAssetCache(assetType[, saveIndex])")
	--print("TjAchieve.RushBuildCritAssetCache", assetType, saveIndex)
	TjAchieve.BuildCritAssetCache(assetType, saveIndex)
	if (TjAchieve.CritAssetTasks and TjAchieve.CritAssetTasks[assetType]) then
		TjThreads.RushTask(TjAchieve.CritAssetTasks[assetType])
	end
end

function TjAchieve.AddBuildCritAssetCacheListener(assetType, func)
	if (TjAchieve.status_CA and TjAchieve.status_CA[assetType] == true) then
		C_Timer.After(0, func)
	else
		if (not TjAchieve.listeners_CACache) then  TjAchieve.listeners_CACache = {};  end
		if (not TjAchieve.listeners_CACache[assetType]) then  TjAchieve.listeners_CACache[assetType] = {};  end
		TjAchieve.listeners_CACache[assetType][#TjAchieve.listeners_CACache[assetType] + 1] = func
	end
end



----------------------------------------------------------------------------------------------------------------------------------------------
-- OTHER THROTTLED FUNCTIONALITY
----------------------------------------------------------------------------------------------------------------------------------------------

local createCriteriaSearchFunc
do
	local function findCriteria(id, pattern)
		local critString, foundCrit
		--print("findCriteria " .. id .. " " .. pattern)
		for i=1,orig_GetAchievementNumCriteria(id) do
			if (pattern == TjAchieve.ANY_NON_BLANK) then  return true;  end -- Alternative: Also check if critString isn't blank? Ignore single status bar w/o displayed text?
			critString = GetAchievementCriteriaInfo(id, i)
			if (critString) then
				foundCrit = strfind(strlower(critString), pattern, 1, true)
				if (foundCrit) then  return true;  end
			end
		end
	end

	function createCriteriaSearchFunc(query, listener, categories, achList)
		query = strlower(query)
		if (categories == true) then
			categories = TjAchieve.GetAllCategories()
		elseif (achList == true) then
			achList = TjAchieve.GetAchIDs()
		end
		return function()
			local found = {}
			local anyFound
			if (categories) then
				local yieldIn = SEARCH_CRIT_CAT_STEPS
				local id
				for _,cat in ipairs(categories) do
					for i=1,GetCategoryNumAchievements(cat) do

						if (yieldIn < 1) then
							--print("yield before", cat,",",i)
							coroutine.yield()
							yieldIn = SEARCH_CRIT_CAT_STEPS
						end
						yieldIn = yieldIn - 1

						id = GetAchievementInfo(cat, i)
						if (id and findCriteria(id, query)) then
							found[#found+1] = id
							anyFound = true
						end
					end
				end
			else
				local yieldIn = SEARCH_CRIT_IDS_STEPS
				for i,id in ipairs(achList) do

					if (yieldIn < 1) then
						--print("yield before", i,",",id)
						coroutine.yield()
						yieldIn = SEARCH_CRIT_IDS_STEPS
					end
					yieldIn = yieldIn - 1

					if (findCriteria(id, query)) then
						found[#found+1] = id
						anyFound = true
					end
				end
			end
			if (listener) then  listener(found);  end
			return found
		end
	end
end


function TjAchieve.StartSearchCriteriaByCategory(query, categoriesList, listenerFunc)
	if (type(categoriesList) == "function" and not listenerFunc) then
		listenerFunc = categoriesList
		categoriesList = nil
	end
	local func = createCriteriaSearchFunc(query, listenerFunc, categoriesList or true, nil)
	TjThreads.AddTask(func)
end

function TjAchieve.SearchCriteriaByCategoryNow(query, categoriesList)
	local func = createCriteriaSearchFunc(query, false, categoriesList or true, nil)
	TjThreads.AddTask(func)
	return TjThreads.RushTask(func)
end

function TjAchieve.StartSearchCriteriaByID(query, idList, listenerFunc)
	if (type(idList) == "function" and not listenerFunc) then
		listenerFunc = idList
		idList = nil
	end
	local func = createCriteriaSearchFunc(query, listenerFunc, nil, idList or true)
	TjThreads.AddTask(func)
end

function TjAchieve.SearchCriteriaByIDNow(query, idList)
	local func = createCriteriaSearchFunc(query, false, nil, idList or true)
	TjThreads.AddTask(func)
	return TjThreads.RushTask(func)
end

-- /dump TjAchieve.SearchCriteriaByCategoryNow("course")
-- /dump TjAchieve.StartSearchCriteriaByID("course", function(...) print("done", unpack(...)) end)
-- /dump TjAchieve.StartSearchCriteriaByCategory("course", function(...) print("done", unpack(...)) end)

-- /dump TjAchieve.StartSearchCriteriaByID("course", function(...) print("done", unpack(...)) end)



----------------------------------------------------------------------------------------------------------------------------------------------


--[[
function TjAchieve.TestBuild(assetType, saveIndex)
	TjAchieve.AddBuildCritAssetCacheListener(assetType, function()
		print("Build Complete")
	end)
	print("Start Build")
	--return TjAchieve.BuildCritAssetCache(0, true)
	return TjAchieve.BuildCritAssetCache(assetType, saveIndex)
end
-- /dump TjAchieve.TestBuild(8)
-- /dump TjAchieve.TestBuild(0, true)
-- /dump TjAchieve.IsCritAssetCacheReady(0)
-- /dump TjAchieve.GetAchievementByAsset(8, 10068)
-- /dump TjAchieve.GetCriteriaByAsset(8, 10068)
--]]
