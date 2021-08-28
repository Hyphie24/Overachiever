

local ANY_NON_BLANK = "~"
local ENFORCE_ID_SEARCH_IN_LIST = false

local THROTTLE = true


local ACHINFO_NAME = 2

local MULTI_SEARCH = {
	2, -- Name
	8, -- Description
	11, -- Reward
	"crit"
}


local GetAchievementInfo = GetAchievementInfo


local function isInTable(tab, item)
	for i,v in ipairs(tab) do
		if (v == item) then  return true;  end
	end
	return false
end

local function getList(excludeHidden, achType)
	if (excludeHidden) then
		if (achType == "p") then
			return TjAchieve.GetStandardPersonalAchIDs()
		elseif (achType == "g") then
			return TjAchieve.GetStandardGuildAchIDs()
		elseif (achType == "o") then
			return {}
		else
			return TjAchieve.GetStandardAchIDs()
		end
	else
		if (achType == "p") then
			return TjAchieve.GetPersonalAchIDs()
		elseif (achType == "g") then
			return TjAchieve.GetGuildAchIDs()
		elseif (achType == "o") then
			return TjAchieve.GetOtherAchIDs()
		else
			return TjAchieve.GetAchIDs()
		end
	end
end
--Overachiever.AchSearchGetList = getList

function Overachiever.AchSearch(argnum, query, excludeHidden, achType, strictCase, limit)
	local list = getList(excludeHidden, achType)
	return Overachiever.AchSearchFromList(list, argnum, query, strictCase, limit)
end

function Overachiever.AchSearchFromList(list, argnum, query, strictCase, limit)
	--if (limit and type(limit) ~= "number") then  error("Invalid call to Overachiever.AchSearchFromList(). Limit must be a number if not nil/false.");  end
	local qtype = type(query)
	if (not strictCase and qtype == "string") then  query = strlower(query);  end
	local results, numFound = {}, 0
    for i,id in ipairs(list) do
		local ret = select(argnum, GetAchievementInfo(id))
		if (qtype == type(ret)) then
			local found = false
			if (query == ret) then
				found = true
			elseif (qtype == "string") then
				if (not strictCase) then  ret = strlower(ret);  end
				if ((query == ANY_NON_BLANK and ret ~= "") or strfind(ret, query, 1, true)) then
					found = true
				end
			end
			if (found) then
				numFound = numFound + 1
				results[numFound] = id
				if (limit and numFound >= limit) then  break;  end
			end
		end
	end
	return results
end

function Overachiever.AchSearchNameOrID(query, excludeHidden, achType, strictCase, limit)
	local list = getList(excludeHidden, achType)
	return Overachiever.AchSearchNameOrIDFromList(list, query, strictCase, limit)
end

function Overachiever.AchSearchNameOrIDFromList(list, query, strictCase, limit)
	if (not query or query == "")  then return {};  end
	local id = tonumber(query)
	if (not id and query:sub(1, 1) == "#") then  id = tonumber(query:sub(2));  end  -- Get ID from strings like "#123"
	if (id) then
		if (not GetAchievementInfo(id) or (ENFORCE_ID_SEARCH_IN_LIST and not isInTable(list, id))) then
			id = nil
		end
	end
	if (id and limit == 1) then  return { id };  end

	local results = Overachiever.AchSearchFromList(list, ACHINFO_NAME, query, strictCase, limit)
	if (id) then  tinsert(results, 1, id);  end
	return results
end


function Overachiever.GetFirstVisibleAchFromList(list)
	for i,id in ipairs(list) do
		if (TjAchieve.IsAchievementVisible(id)) then  return id, i;  end
	end
	return nil, nil
end


function Overachiever.OpenSearchToNameOrID(name)
	--if (not AchievementFrame and CanShowAchievementUI()) then
	--	AchievementFrame_LoadUI()
	--end
	Overachiever.OpenTab("Overachiever_SearchFrame")
	if (Overachiever.OpenSearchTab) then
		Overachiever.OpenSearchTab(name)
		return true
	end
	return false
end



-- THROTTLED
--------------

local function handleSubthread(func, ...)
	-- Make sure you don't pass any nil arguments to this. They don't play nicely with unpack. (Instead, use something like false when possible.)
	local WAITING = {}
	local results = WAITING
	local args = { ... }
	args[#args + 1] = function(output)
		results = output
	end
	func(unpack(args))
	local task = TjThreads.GetLatestTask()
	if (THROTTLE) then
		coroutine.yield(TjThreads.QUICKYIELD)
		while (results == WAITING) do
			if (not TjThreads.IsTaskActive(task)) then
				error("Subthread has terminated without yielding expected results. Check previous error in log.")
			end
			coroutine.yield(TjThreads.QUICKYIELD)
		end
	else
		TjThreads.RushTask(task)
		if (results == WAITING) then
			error("Subthread has terminated without yielding expected results. Check previous error in log.")
		end
	end
	return results
end


local function createMultiSearchFunc(list, query, strictCase, listener)
	return function()
		local results_all, results_lookup = {}, {}
		local numFound = 0
		for i,argnum in ipairs(MULTI_SEARCH) do
			local results
			if (argnum == ACHINFO_NAME) then
				results = Overachiever.AchSearchNameOrIDFromList(list, query, strictCase)
			elseif (argnum == "crit") then
				if (THROTTLE) then  coroutine.yield();  end
				local q = query
				if (query == ANY_NON_BLANK) then  q = TjAchieve.ANY_NON_BLANK;  end
				results = handleSubthread(TjAchieve.StartSearchCriteriaByID, q, list)
			else
				results = Overachiever.AchSearchFromList(list, argnum, query, strictCase)
			end
			for i,id in ipairs(results) do
				if (not results_lookup[id]) then
					numFound = numFound + 1
					results_all[numFound] = id
					results_lookup[id] = true
				end
			end
		end
		listener(results_all)
	end
end

function Overachiever.StartAchSearchMulti(query, excludeHidden, achType, strictCase, listenerFunc)
	-- Search names, descriptions, and rewards
	local list = getList(excludeHidden, achType)
	Overachiever.StartAchSearchMultiFromList(list, query, strictCase, listenerFunc)
end

function Overachiever.StartAchSearchMultiFromList(list, query, strictCase, listenerFunc)
	local func = createMultiSearchFunc(list, query or "", strictCase, listenerFunc)
	TjThreads.AddTask(func)
end


local function createFullSearchFunc(list, strictCase, nameOrID, desc, criteria, reward, any, listener)
	return function()
		if (nameOrID ~= "") then
			-- Check name first since it may be a numeric ID (which eliminates all other achievements)
			list = Overachiever.AchSearchNameOrIDFromList(list, nameOrID, strictCase)
			if (THROTTLE) then  coroutine.yield();  end
		end
		if (reward ~= "") then
			-- Rewards next since there are relatively few of these so it may narrow the list quickly
			list = Overachiever.AchSearchFromList(list, 11, reward, strictCase)
			if (THROTTLE) then  coroutine.yield();  end
		end
		if (desc ~= "") then
			list = Overachiever.AchSearchFromList(list, 8, desc, strictCase)
			if (THROTTLE) then  coroutine.yield();  end
		end
		if (#list > 0 and criteria ~= "") then
			if (criteria == ANY_NON_BLANK) then  criteria = TjAchieve.ANY_NON_BLANK;  end
			list = handleSubthread(TjAchieve.StartSearchCriteriaByID, criteria, list)
		end
		if (#list > 0 and any ~= "") then
			list = handleSubthread(Overachiever.StartAchSearchMultiFromList, list, any, strictCase or false)
		end
		listener(list)
	end
end

function Overachiever.StartAchSearch(excludeHidden, achType, strictCase, nameOrID, desc, criteria, reward, any, listenerFunc)
	local list = getList(excludeHidden, achType)
	local func = createFullSearchFunc(list, strictCase, nameOrID or "", desc or "", criteria or "", reward or "", any or "", listenerFunc)
	TjThreads.AddTask(func)
end
-- /run Overachiever.StartAchSearch(nil, nil, nil, "food", "food", "", "", "")



--[[
function Overachiever.Debug_CriteriaSearch(query, excludeHidden, achType)
	local list = getList(excludeHidden, achType)
	local results = TjAchieve.SearchCriteriaByIDNow(query, list)
	if (results) then
		print("Found:")
		for i,id in ipairs(results) do
			print(i,id)
		end
	else
		print("Nothing found.")
	end
end
--]]
