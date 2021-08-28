
--
--  TjSetList.lua
--    by Tuhljin
--
--  Manage lists of data, each element of which can be one value or a set of values.
--


local THIS_VERSION = 0.01

if (TjSetList and TjSetList.Version >= THIS_VERSION) then  return;  end

TjSetList = TjSetList or {}
TjSetList.Version = THIS_VERSION


--[[
local function tCopyIntKeys(from, to)
	to = to or {}
	for k,v in ipairs(from) do
		if (type(v) == "table") then
			to[k] = tCopyIntKeys(v)
		else
			to[k] = v
		end
	end
	return to
end
--]]


local Set = {}
Set.__index = Set

function Set:new(o)
	o = o or {}
	setmetatable(o, self)
	return o
end

function Set:equals(other)
	-- Can pass in another Set or any other table that has a numerically-indexed list
	if (#self ~= #other) then  return false;  end
	for i,v in ipairs(self) do
		if (v ~= other[i]) then  return false;  end
	end
	return true
end


local SetList = {}
SetList.__index = SetList

function SetList:new(o, setSize)
	o = o or {}
	o._setSize = setSize
	setmetatable(o, self)
	return o
end

function SetList:squish(canLeaveTab)
	local tab = {}
	local inc = self._setSize
	local c = 0
	for i,set in ipairs(self) do
		for i2,v in ipairs(set) do
			c = c + 1
			tab[c] = v
		end
	end
	if (canLeaveTab) then
		if (c == 0) then  return nil;  end
		if (c == 1) then  return tab[1];  end
	end
	return tab
end

function SetList:contains(setIn)
	for i,set in ipairs(self) do
		if (set:equals(setIn)) then  return true;  end
	end
	return false
end

local function add_set(self, set, uniqueOnly, failed, sim)
	if (self._setSize and #set ~= self._setSize) then
		error("Specified set has size " .. #set .. ". The required size of sets for this list is " .. self._setSize .. ".")
	end
	if (not uniqueOnly or not self:contains(set)) then
		if (not sim) then
			tinsert(self, set)
		end
	elseif (failed) then
		tinsert(failed, set)
	end
end

function SetList:add(set)
	add_set(self, set, false)
end

function SetList:addAll(sets)
	for i,set in ipairs(sets) do
		add_set(self, set, false)
	end
end

function SetList:addAllUnique(sets, saveFailed)
	local failed = saveFailed and {}
	for i,set in ipairs(sets) do
		add_set(self, set, true, failed)
	end
	if (saveFailed) then  return failed;  end
end

function SetList:getSharedSets(sets)
	local shared = {}
	for i,set in ipairs(sets) do
		add_set(self, set, true, shared, true)
	end
	return SetList:new(shared, self._setSize)
end

function SetList:replaceSets(sets)
	local size = max(#self, #sets)
	for i=size,1,-1 do
		self[i] = sets[i]
	end
end

function SetList:remAllFrom(other)
	-- Pass in another SetList as 'other'
	local newList = {}
	local n = 0
	for i,set in ipairs(self) do
		if (not other:contains(set)) then
			n = n + 1
			newList[n] = set
		end
	end
	self:replaceSets(newList)
end


function TjSetList:SplitIntoSets(tab, setSize)
	local size = #tab
	if (size % setSize ~= 0) then  error("The given table's size is not divisible by the given set size.");  end
	local sets = {}
	local c = 0
	for i=1,size,setSize do
		local list = {}
		for n=1,setSize do
			list[n] = tab[i + n - 1]
		end
		c = c + 1
		sets[c] = Set:new(list)
	end
	return sets
end

function TjSetList:Create(tab, setSize)
	if (tab and not setSize) then
		setSize = tab
		tab = nil
	end
	if (not setSize or type(setSize) ~= "number") then  error("Invalid arguments. Usage: TjSetList:Create([tab,] setSize)");  end
	local list
	if (tab) then
		if (type(tab) ~= "table") then  error("Invalid argument. 'tab' must be a table or omitted.");  end
		local sets = self:SplitIntoSets(tab, setSize)
		list = SetList:new(sets, setSize)
	else
		list = SetList:new(nil, setSize)
	end
	return list
end

function TjSetList:CreateSet(...)
	local tab = ...
	if (type(tab) == "table") then  return Set:new(tab);  end
	return Set:new( {...} )
end

setmetatable(TjSetList, { __call = TjSetList.Create })
