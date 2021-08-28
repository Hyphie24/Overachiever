
local function tCopy(from, to)
	to = to or {}
	for k,v in pairs(from) do
		if (type(v) == "table") then
			to[k] = tCopy(v)
		else
			to[k] = v
		end
	end
	return to
end

local function createSetList(tab)
	if (type(tab) ~= "table") then  tab = { tab };  end
	return TjSetList(tab, tab.saveIndex and 2 or 1)
end

local function mergeCache(t1, t2)
	--[[ Expected format of t1 and t2:
	{
		[Criteria ID 1] = <list>,
		[Criteria ID 2] = <list>,
		...
		["saveIndex"] = <true or false>,
	}
	<list> is either a single integer or a table in one of these formats, depending on saveIndex:
	{
		<Achievement ID 1>,
		<Achievement ID 2>,
		...
	}
	Or:
	{
		<Achievement ID 1>,
		<Achievement ID 1's criteria index>,
		<Achievement ID 2>,
		<Achievement ID 2's criteria index>,
		...
	}
	--]]

	for k,list2 in pairs(t2) do
		if (type(k) == "number") then
			local list1 = t1[k]
			if (list1) then
				local setList1 = createSetList(list1)
				local setList2 = createSetList(list2)
				setList1:addAllUnique(setList2)
				t1[k] = setList1:squish(true)
			elseif (type(list2) == "table") then
				t1[k] = tCopy(list2)
			else
				t1[k] = list2
			end
		else
			if (list2 ~= t1[k]) then  error("Could not merge cache. Mismatched values detected at key \"" .. k .. "\".");  end
		end
	end
	return t1
end

local function splitCacheList(list, compList)
	-- Returns three lists: only in first list, only in compList, in both -- AKA current faction, other faction, both
	if (not compList) then
		local onlyFirst = (type(list) == "table") and tCopy(list) or list
		return onlyFirst, nil, nil
	end
	local setList = createSetList(list)
	local compSetList = createSetList(compList)
	local bothSetList = compSetList:getSharedSets(setList)
	setList:remAllFrom(bothSetList)
	compSetList:remAllFrom(bothSetList)
	return setList:squish(true), compSetList:squish(true), bothSetList:squish(true)
end

local function isCacheCompatible(thisVer, cacheVer, thisBuild, cacheBuild)
	if (thisBuild ~= cacheBuild) then  return false;  end
	if (cacheVer < "1.0.4") then  return false;  end
	return thisVer >= cacheVer -- Discard cache if it claims to be "from the future"
end

local function getCachePart(name, subname, ver, build)
	local tab = Overachiever_Cache_CritAssets and Overachiever_Cache_CritAssets[name]
	if (tab) then
		local data, versionData = tab[subname], tab[subname .. "_version"]
		if (data and versionData) then
			if (not ver or isCacheCompatible(ver, versionData.ver, build, versionData.build)) then
				--local vertype = versionData.type
				--if (vertype == "found" or vertype == "known") then
					return data, versionData
				--end
			elseif (Overachiever_Debug) then
				Overachiever.chatprint("Cache for \"" .. name .. "\":\"" .. subname .. "\" is incompatible.")
			end
		elseif (Overachiever_Debug) then
			Overachiever.chatprint("Cache part not found for \"" .. name .. "\":\"" .. subname .. "\".")
		end
	elseif (Overachiever_Debug) then
		Overachiever.chatprint("Cache container not found for \"" .. name .. "\":\"" .. subname .. "\".")
	end
	return nil, nil
end


function Overachiever.SaveCache(name, populateExcludeOtherFaction)
	-- Careful: Don't call this unless TjAchieve's cache was gathered this session and not possibly populated with data from the opposing faction.
	-- (This function will populate such data in some cases, so it's safest to not call it twice in a session. Also don't call it if GetCache was used for that.)

	if (Overachiever_Debug) then  Overachiever.chatprint("|cffffffffSaveCache|r called for \"" .. name .. "\".");  end

	local lookup, lookupIncomplete, critType
	if (name == "meta") then
		lookup, lookupIncomplete = Overachiever.GetMetaCriteriaLookup(true)
		critType = TjAchieve.CRITTYPE_META
	elseif (name == "kill") then
		lookup, lookupIncomplete = Overachiever.GetKillCriteriaLookup(true)
		critType = TjAchieve.CRITTYPE_KILL
	else
		error("Invalid call to Overachiever.SaveCache. Cache name \"" .. name .. "\" not recognized.")
	end
	if (lookupIncomplete)  then return;  end  -- Don't save data to cache if lookup wasn't completed.

	local ver = GetAddOnMetadata("Overachiever", "Version")
	local build = select(2, GetBuildInfo())
	local faction, otherFaction
	if (UnitFactionGroup("player") == "Alliance") then
		faction = "Alliance"
		otherFaction = "Horde"
	else
		faction = "Horde"
		otherFaction = "Alliance"
	end
	local faction_ver = faction .. "_version"

	Overachiever_Cache_CritAssets = Overachiever_Cache_CritAssets or {}

	local cache = Overachiever_Cache_CritAssets[name]
	if (not cache) then
		cache = {}
		Overachiever_Cache_CritAssets[name] = cache
	end

	cache[faction] = {}  -- Clear old data for current faction. We'll be replacing it.

	local otherFactionData, otherFactionVersionData = getCachePart(name, otherFaction)
	--if (otherFactionVersionData) then
	--	otherFactionVersionData.type = "found"
	--end

	if (not otherFactionData or not isCacheCompatible(ver, otherFactionVersionData.ver, build, otherFactionVersionData.build)) then
		-- If we have no compatible saved data from the opposing faction:
		-- 1. Copy down what we get from TjAchieve cache into "found" for this faction (overwriting what was there before if anything).
		-- 2. Set version data for this faction's table.
		-- 3. Remove "both" data.
		-- Note that we don't remove the other faction's data (if it exists) since it's generally okay for GetCache to return some old data from the
		-- opposing faction since, much of the time, the old data will still be useful (it'd be incomplete rather than just wrong).

		tCopy(lookup, cache[faction])
		cache[faction_ver] = { ver = ver, build = build, --[[ type = "found" --]] }
		cache.both, cache.both_version = nil, nil

		if (Overachiever_Debug) then  Overachiever.chatprint("- Saved current faction's data.");  end

	else
		-- If we have the opposing faction's data saved already and it's a compatible version:
		-- 1. Copy the contents of gathered TjAchieve cache, splitting it into two new tables: current faction's "known" data and the "both" table.
		-- 2. Set version data for all three tables.
		-- 3. Flag this faction, other faction, and "both" as "known". (Never mind: Type flag seems to be unnecessary, so it was removed.)
		-- 4. Push new data back into TjAchieve's cache, if called for.

		cache.both = {}
		-- Things not found in lookup that were in the other cache's data are left there. (This is why we can't do "cache[otherFaction] = {}" here.)

		for k,list in pairs(lookup) do
			if (type(k) == "number") then
				cache[faction][k], cache[otherFaction][k], cache.both[k] = splitCacheList(list, otherFactionData[k])
			else
				cache[faction][k], cache[otherFaction][k], cache.both[k] = list, list, list
			end
		end

		local verData = { ver = ver, build = build, --[[ type = "known" --]] }
		cache[faction_ver], cache.both_version = verData, verData
		--cache[otherFaction .. "_version"].type = "known"

		if (Overachiever_Debug) then  Overachiever.chatprint("- Saved data for all factions.");  end

		if (populateExcludeOtherFaction ~= 0) then
			local data = Overachiever.GetCache(name, populateExcludeOtherFaction)
			if (data) then
				TjAchieve.PopulateCritAssetCache(critType, data)
				if (Overachiever_Debug) then  Overachiever.chatprint("- Populated TjAchieve cache for asset " .. critType .. ".");  end
			end
		end
	end

end

function Overachiever.GetCache(name, excludeOtherFaction)

	if (Overachiever_Debug) then  Overachiever.chatprint("|cffffffffGetCache|r called for \"" .. name .. "\".");  end

	-- Detect obsolete structure:
	if (Overachiever_Cache_CritAssets and Overachiever_Cache_CritAssets[name .. "_version"]) then
		Overachiever_Cache_CritAssets = {}
		if (Overachiever_Debug) then  Overachiever.chatprint("Discarded cache using obsolete structure.");  end
		return false
	end

	local ver = GetAddOnMetadata("Overachiever", "Version")
	local build = select(2, GetBuildInfo())
	local faction, otherFaction
	if (UnitFactionGroup("player") == "Alliance") then
		faction = "Alliance"
		otherFaction = "Horde"
	else
		faction = "Horde"
		otherFaction = "Alliance"
	end

	local factionData = getCachePart(name, faction, ver, build)
	if (not factionData) then  return false;  end  -- Need to rebuild cache if we don't have a part we can use for this faction, regardless of other parts. (Even if all the achievement IDs are in "both" somehow, this should at least be an empty table.)

	local anyFactionData = getCachePart(name, "both", ver, build)

	local otherFactionData
	if (not excludeOtherFaction) then  otherFactionData = getCachePart(name, otherFaction);  end
	-- Note that we allow old data (omit ver and build arguments). We'll accept old data from the other faction, since we can't read it as the current character
	-- and it's better to have old data than no data.

	local data = tCopy(factionData)
	if (anyFactionData) then  data = mergeCache(data, anyFactionData);  end
	if (otherFactionData) then  data = mergeCache(data, otherFactionData);  end

	return data
end

function Overachiever.GetCachedFactionForData(name, key, ...)
	--if (not getCachePart(name, "both")) then  return nil;  end
	-- If we don't have "both" data, then we won't know for sure if this is faction-specific, but it's still most likely faction-specific if it's in the
	-- data for the opposing faction and not for the current one, so that's good enough in that case.
	local set, inAlliance, inHorde
	local allianceData = getCachePart(name, "Alliance")
	if (allianceData and allianceData[key]) then
		set = TjSetList:CreateSet(...)
		local setList = createSetList(allianceData[key])
		if (setList:contains(set)) then  inAlliance = true;  end
	end
	local hordeData = getCachePart(name, "Horde")
	if (hordeData and hordeData[key]) then
		set = set or TjSetList:CreateSet(...)
		local setList = createSetList(hordeData[key])
		if (setList:contains(set)) then  inHorde = true;  end
	end
	if (inAlliance and inHorde) then  return nil;  end
	if (allianceData) then
		if (inHorde) then  return "Horde";  end
	end
	if (hordeData) then
		if (inAlliance) then  return "Alliance";  end
	end
	return nil
end


if (Overachiever_Debug) then
	function Overachiever.InvalidateCache(name, subname)
		if (not name or not subname) then
			Overachiever.chatprint("Invalid arguments.")
		elseif (Overachiever_Cache_CritAssets and Overachiever_Cache_CritAssets[name]) then
			local versionData = Overachiever_Cache_CritAssets[name][subname .. "_version"]
			if (not versionData) then
				Overachiever.chatprint("Cache for \"" .. name .. "\":\"" .. subname .. "\" not found.")
				return;
			end
			versionData.build = "0"
			Overachiever.chatprint("Invalidated cache for \"" .. name .. "\":\"" .. subname .. "\".")
		else
			Overachiever.chatprint("Cache not found.")
		end
	end
end

--[[
/run Overachiever.InvalidateCache("meta", "Alliance")
/run Overachiever.InvalidateCache("meta", "Horde")
/run Overachiever.InvalidateCache("kill", "Alliance")
/run Overachiever.InvalidateCache("kill", "Horde")

/run Overachiever_Cache_CritAssets = {}

/ach ready for war
/ach quick cap

-- req by two of same name:
/ach #3850

/dump Overachiever_Cache_CritAssets.meta.Horde[3850]
--]]
