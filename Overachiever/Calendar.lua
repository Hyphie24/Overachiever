
local L = OVERACHIEVER_STRINGS

--local showUnknownToasts = true

-- BFA
local CalendarGetNumDayEvents = CalendarGetNumDayEvents or C_Calendar.GetNumDayEvents
local CalendarGetHolidayInfo = CalendarGetHolidayInfo or C_Calendar.GetHolidayInfo

local function CalendarGetDate()
	local info = C_DateAndTime.GetCurrentCalendarTime()
	return info.weekday, info.month, info.monthDay, info.year, info.hour, info.minute
end

local CalendarGetMonth = CalendarGetMonth or function(...)
	local info = C_Calendar.GetMonthInfo(...)
	return info.month, info.year, info.numDays, info.firstWeekday
end
-- BFA

local function CalendarGetDayEvent(monthOffset, monthDay, index)
	local event = C_Calendar.GetDayEvent(monthOffset, monthDay, index);
	if (event) then
		local hour, minute;
		if (event.sequenceType == "END") then
			hour = event.endTime.hour;
			minute = event.endTime.minute;
		else
			hour = event.startTime.hour;
			minute = event.startTime.minute;
		end
		return event.title, hour, minute, event.calendarType, event.sequenceType, event.eventType, event.iconTexture, event.modStatus, event.inviteStatus, event.invitedBy, event.difficulty, event.inviteType, event.sequenceIndex, event.numSequenceDays, event.difficultyName;
	else
		return nil, 0, 0, "", "", 0, "", "", 0, "", 0, 0, 0, 0, "";
	end
end


Overachiever.HOLIDAY_REV = { -- lookup table to support localization
--	["Localized holiday/event name"] = "The key we're using for this holiday/event",
	[L.HOLIDAY_DARKMOONFAIRE] = "Darkmoon Faire",
	[L.HOLIDAY_LUNARFESTIVAL] = "Lunar Festival",
	[L.HOLIDAY_LOVEISINTHEAIR] = "Love is in the Air",
	[L.HOLIDAY_NOBLEGARDEN] = "Noblegarden",
	[L.HOLIDAY_CHILDRENSWEEK] = "Children's Week",
	[L.HOLIDAY_MIDSUMMER] = "Midsummer Fire Festival",
	[L.HOLIDAY_PIRATESDAY] = "Pirates' Day",
	[L.HOLIDAY_BREWFEST] = "Brewfest",
	[L.HOLIDAY_HALLOWSEND] = "Hallow's End",
	[L.HOLIDAY_DAYOFTHEDEAD] = "Day of the Dead",
	[L.HOLIDAY_PIGRIMSBOUNTY] = "Pilgrim's Bounty",
	[L.HOLIDAY_WINTERVEIL] = "Feast of Winter Veil",
	-- Aliases: (used by Suggestions tab but not the title the in-game calendar uses)
	[L.HOLIDAY_MIDSUMMER_SHORT] = "Midsummer",
	[L.HOLIDAY_WINTERVEIL_SHORT] = "Winter Veil",
}

local HOLIDAYS_OPTIONS = {
	--"Brewfest" = {}, -- Nothing for this one. "The Brewfest Diet" can be completed when it's not Brewfest (if you already bought the food).
}

local function getHolidayAutoOptions(localizedEventTitle)
	local key = Overachiever.HOLIDAY_REV[localizedEventTitle] or localizedEventTitle
	return HOLIDAYS_OPTIONS[key]
end


local function getEventStartTexture(monthOffset, day, eventNum)
	local event = C_Calendar.GetDayEvent(monthOffset, day, eventNum)
	--if (event.sequenceType == "START") then  return event.iconTexture;  end
	local startDay = event.startTime.monthDay
	if (startDay == day) then  return event.iconTexture;  end  -- Events aren't a month or longer so we shouldn't have to check against month or year.
	if (startDay > day) then  monthOffset = monthOffset - 1;  end  -- If the start day is larger than the current day, then it must be from the previous month (and not an even earlier month, since events don't last that long).
	local title = event.title

	local numEvents = CalendarGetNumDayEvents(monthOffset, startDay)
	--print("numEvents, monthOffset, startDay", numEvents, monthOffset, startDay)
	for e = 1, numEvents do
		local event2 = C_Calendar.GetDayEvent(monthOffset, startDay, e)
		if (event2 and event2.title == title) then  return event2.iconTexture;  end
	end
	return ""
end

local function getEventEnding(title, calendarType, yearStart, monthStart, dayStart)
	local _, _, numDays = TjCalendar.StartReadingAt(yearStart, monthStart, true)
	local m = 0 -- Month offset
	local day = dayStart
	for i = 1, 100 do -- Look up to 100 days away, which should be more than enough; this is a failsafe.
		local numEvents = CalendarGetNumDayEvents(m, day)
		for e = 1, numEvents do
			local event = C_Calendar.GetDayEvent(m, day, e)
			if (event and event.sequenceType == "END" and title == event.title and calendarType == event.calendarType) then
				--local month, year = CalendarGetMonth(m)
				TjCalendar.StopReading()
				--return year, month, event.endTime.monthDay, event.endTime.hour, event.endTime.minute
				return event.endTime.year, event.endTime.month, event.endTime.monthDay, event.endTime.hour, event.endTime.minute
			end
		end
		day = day + 1
		if (day > numDays) then
			day = 1
			m = m + 1 -- !! This can't effectively go over 1. Thought it worked before, but apparently no longer. Leaving as is for now since there is no event over a month in length anyway.
			_, _, numDays = CalendarGetMonth(m)
		end
	end
	TjCalendar.StopReading()
	return nil, nil, nil, nil, nil
end

local lastEvents = {}
local lastCheckedDay, lastCheckedMonth
local eventsExpireHour, eventsExpireMinute = false, false

function Overachiever.GetTodaysEvents(cachekey, unexpiredOnly, searchEndDate, filterFunc)
	--return Overachiever.GetHolidayEvents(2016, 10, 5, 1, cachekey, unexpiredOnly, searchEndDate, filterFunc)
	return Overachiever.GetHolidayEvents(nil, nil, nil, nil, cachekey, unexpiredOnly, searchEndDate, filterFunc)
end

--/dump Overachiever.GetHolidayEvents(2017, 2, 1, 1, -1, true, true)
function Overachiever.GetHolidayEvents(year, month, day, hourOverride, cachekey, unexpiredOnly, searchEndDate, filterFunc)
	-- Make sure to use a unique cachekey for each combination of your other arguments. Otherwise, you may get back cached data for some other arguments.
	cachekey = cachekey or 0
	local weekdayNow, monthNow, dayNow, yearNow = CalendarGetDate()
	local hourNow, minuteNow = GetGameTime()
	if (lastCheckedDay == dayNow and lastCheckedMonth == monthNow and lastEvents[cachekey]) then
		if (eventsExpireHour == false or hourNow < eventsExpireHour or (hourNow == eventsExpireHour and minuteNow < eventsExpireMinute)) then
			return lastEvents[cachekey]
		end
	end
	lastCheckedDay = dayNow
	lastCheckedMonth = monthNow
	eventsExpireHour = false
	eventsExpireMinute = false

	year = year or yearNow
	month = month or monthNow
	day = day or dayNow
	hourNow = hourOverride or hourNow

	TjCalendar.StartReadingAt(year, month)
	--TjCalendar.StartReading()

	local result = nil
	local numEvents = CalendarGetNumDayEvents(0, day)
	local expired = {}
	for e = 1, numEvents do
		local title, hour, minute, calendarType, sequenceType, eventType, texture = CalendarGetDayEvent(0, day, e)
		--print(title, ",", calendarType, ",", sequenceType, ",", eventType, ",", texture)
		if (not expired[title] and calendarType == "HOLIDAY") then
			if (unexpiredOnly and sequenceType == "END" and (hour < hourNow or (hour == hourNow and minute <= minuteNow))) then
				expired[title] = true
				if (result) then  result[title] = nil;  end
			else
				local startTexture = getEventStartTexture(0, day, e)
				if (not filterFunc or filterFunc(title, startTexture)) then
					if (not result) then  result = {};  end
					if (not result[title]) then  result[title] = {};  end
					if (not result[title]["texture"] or result[title]["texture"] == "") then
						result[title]["texture"] = startTexture
					end
					if (not result[title]["desc"]) then
						local _, description = CalendarGetHolidayInfo(0, day, e)
						result[title]["desc"] = description
					end
					if (sequenceType == "START")  then
						result[title]["hourStart"] = hour
						result[title]["minuteStart"] = minute
					elseif (sequenceType == "END")  then
						result[title]["hourEnd"] = hour
						result[title]["minuteEnd"] = minute
						if (eventsExpireHour == false or (eventsExpireHour > hour or (eventsExpireHour == hour and eventsExpireMinute > minute))) then
							eventsExpireHour = hour
							eventsExpireMinute = minute
						end
					end
				end
			end
		end
	end

	TjCalendar.StopReading()

	if (searchEndDate and result) then
		for title,arr in pairs(result) do
			if (not arr["hourEnd"]) then
				arr["yearEnd"], arr["monthEnd"], arr["dayEnd"], arr["hourEnd"], arr["minuteEnd"] = getEventEnding(title, "HOLIDAY", year, month, day)
				--print("getEventEnding(",title,", \"HOLIDAY\", ",month,", ",day,")")
				--print(arr["yearEnd"], arr["monthEnd"], arr["dayEnd"], arr["hourEnd"], arr["minuteEnd"])
			end
		end
	end
	if (cachekey ~= -1) then  lastEvents[cachekey] = result;  end
	return result
end

--[[
--/run DEBUG_GETALLEVENTS()
--/run DEBUG_GETALLEVENTS("Timewalking Dungeon Event")

local function tabcontains(tab, element)
  for k,v in pairs(tab) do
    if (v == element) then  return true;  end
  end
  return false
end

function DEBUG_GETALLEVENTS(onlyTitle)
	local m = 1 -- Start month
	local events = {}
	--local _, _, numDays = TjCalendar.StartReadingAt(nil, 1, true) -- Start at first month of this year
	local _, _, numDays = TjCalendar.StartReadingAt(nil, m, true)
	local day = 1
	for i = 1, 366 do -- Look up to 366 days away (365 + 1 in case it's a leap year)
		local numEvents = CalendarGetNumDayEvents(0, day)
		for e = 1, numEvents do
			local event = C_Calendar.GetDayEvent(0, day, e)
			local title = event.title
			if (not onlyTitle or title == onlyTitle) then
				local startDay = event.startTime.monthDay
				if (startDay == day) then  -- Events aren't a month or longer so we shouldn't have to check against month or year.
					local texture = event.iconTexture
					if (not texture) then  texture = 0;  end
					if (events[title]) then
						if (not tabcontains(events[title], texture)) then
							events[title][#(events[title]) + 1] = texture
						end
					else
						events[title] = { texture }
					end
				end
			end

			--[=[
			local title, _, _, calendarType, sequenceType, _, texture = CalendarGetDayEvent(0, day, e)
			if (not onlyTitle or title == onlyTitle) then
				if (calendarType == "HOLIDAY") then --and sequenceType == "START") then
					texture = getEventStartTexture(0, day, e)
					if (not texture or texture == "") then  texture = 0;  end
					if (events[title]) then
						events[title][#(events[title]) + 1] = texture
					else
						events[title] = { texture }
					end
				end
			end
			--]=]
		end
		day = day + 1
		if (day > numDays) then
			day = 1
			m = m + 1
			if (m > 12) then  break;  end
			--_, _, numDays = CalendarGetMonth(m)
			TjCalendar.StopReading()
			_, _, numDays = TjCalendar.StartReadingAt(nil, m, true)
		end
	end
	TjCalendar.StopReading()

	C_Timer.After(0, function()
		local s = ""
		for k,v in pairs(events) do
			v = table.concat(v, ",")
			--s = s .. '["' .. v .. '"] = "edit_this",				-- ' .. k .. "\r\n"
			s = s .. '[' .. v .. '] = "edit_this",				-- ' .. k .. "\r\n"
		end
		error(s)
	end)

	return events
end
--]]

local EVENT_TEXTURE_LOOKUP = {
	[1671627] = "micro",				-- The Great Gnomeregan Run
	[235474] = "holiday",				-- Midsummer Fire Festival
	[235468] = "holiday",				-- Love is in the Air
	[1467050] = "bonus",				-- World Quest Bonus Event
	[235442] = "holiday",				-- Brewfest
	[1572475] = "micro",				-- Spring Balloon Festival
	[1574967] = "micro",				-- Kirin Tor Tavern Crawl
	[235457] = "holiday",				-- Fireworks Spectacular
	[1671631] = "micro",				-- Trial of Style
	[1574965] = "micro",				-- Call of the Scarab
	[1572472] = "micro",				-- March of the Tadpoles
	[1671624] = "micro",				-- Auction House Dance Party
	[1572479] = "micro",				-- Volunteer Guard Day
	[1129677] = "bonus",				-- Pet Battle Bonus Event
	[1572471] = "micro",				-- Glowcap Festival
	[235477] = "holiday",				-- Noblegarden
	[1129680] = "bonus",				-- Arena Skirmish Bonus Event
	[235445] = "holiday",				-- Children's Week
	--[0] = "holiday",					-- WoW's 13th Anniversary
	[1574970] = "micro",				-- Un'Goro Madness
	[235457] = "holiday",				-- Fireworks Celebration
	[235485] = "holiday",				-- Feast of Winter Veil
	[235465] = "holiday",				-- Pilgrim's Bounty
	[1671628] = "micro",				-- Moonkin Festival
	[235462] = "holiday",				-- Hallow's End
	[235465] = "holiday",				-- Harvest Festival
	[235481] = "holiday",				-- Pirates' Day
	[235471] = "holiday",				-- Lunar Festival
	[1467047] = "dungeon",			-- Legion Dungeon Event
	[1574966] = "micro",				-- Hatching of the Hippogryphs
	[307365] = "holiday",				-- Day of the Dead
	[1572478] = "micro",				-- Thousand Boat Bash
	[1129671] = "bonus",				-- Battleground Bonus Event
	[235448] = "holiday",				-- Darkmoon Faire
	-- Timewalking Dungeon Events:
	[1129686] = "dungeon",
	[1304688] = "dungeon",
	[1530590] = "dungeon",
	[1129674] = "dungeon",
	-- PVP Brawls:
	[1616334] = "pvpbrawl",
	--[[ They all use the same texture right now so no need to include each individually.
	[1616334] = "pvpbrawl",			-- PvP Brawl: Temple of Hotmogu
	[1616334] = "pvpbrawl",			-- PvP Brawl: Boss Fight Arena
	[1616334] = "pvpbrawl",			-- PvP Brawl: Southshore vs. Tarren Mill
	[1616334] = "pvpbrawl",			-- PvP Brawl: Packed House
	[1616334] = "pvpbrawl",			-- PvP Brawl: Deep Six
	[1616334] = "pvpbrawl",			-- PvP Brawl: Gravity Lapse
	[1616334] = "pvpbrawl",			-- PvP Brawl: Arathi Blizzard
	[1616334] = "pvpbrawl",			-- PvP Brawl: Warsong Scramble
	[1616334] = "pvpbrawl",			-- PvP Brawl: Deepwind Dunk
	--]]
}

--[[ Pre WoW 7.2.5:
local EVENT_TEXTURE_LOOKUP = {
	["calendar_volunteerguardday"] = "micro",				-- Volunteer Guard Day
	["calendar_weekendpetbattles"] = "bonus",				-- Pet Battle Bonus Event
	["calendar_glowcapfestival"] = "micro",					-- Glowcap Festival
	["Calendar_HallowsEnd"] = "holiday",					-- Hallow's End
	["calendar_weekendlegion"] = "dungeon",					-- Legion Dungeon Event
	["calendar_weekendpvpskirmish"] = "bonus",				-- Arena Skirmish Bonus Event
	["calendar_hatchingofthehippogryphs"] = "micro",		-- Hatching of the Hippogryphs
	["calendar_ungoromadness"] = "micro",					-- Un'Goro Madness
	["calendar_fireworks"] = "holiday",						-- Fireworks Celebration
	["Calendar_LoveInTheAir"] = "holiday",					-- Love is in the Air
	["calendar_thousandboatbash"] = "micro",				-- Thousand Boat Bash
	["calendar_weekendworldquest"] = "bonus",				-- World Quest Bonus Event
	["Calendar_Brewfest"] = "holiday",						-- Brewfest
	["Calendar_HarvestFestival"] = "holiday",				-- Harvest Festival
	["calendar_springballoonfestival"] = "micro",			-- Spring Balloon Festival
	["calendar_taverncrawl"] = "micro",						-- Kirin Tor Tavern Crawl
	["calendar_fireworks"] = "holiday",						-- Fireworks Spectacular
	["Calendar_LunarFestival"] = "holiday",					-- Lunar Festival
	["Calendar_PiratesDay"] = "holiday",					-- Pirates' Day
	["Calendar_Midsummer"] = "holiday",						-- Midsummer Fire Festival
	["Calendar_WinterVeil"] = "holiday",					-- Feast of Winter Veil
	["calendar_marchofthetadpoles"] = "micro",				-- March of the Tadpoles
	["Calendar_DayOfTheDead"] = "holiday",					-- Day of the Dead
	["Calendar_ChildrensWeek"] = "holiday",					-- Children's Week
	["Calendar_Noblegarden"] = "holiday",					-- Noblegarden
	["calendar_weekendbattlegrounds"] = "bonus",			-- Battleground Bonus Event
	["calendar_darkmoonfaireterokkar"] = "holiday",			-- Darkmoon Faire
	["calendar_callofthescarab"] = "micro",					-- Call of the Scarab
	["calendar_brawl"] = "pvpbrawl",						-- PvP Brawl (any)
	-- Timewalking Dungeon Events:
	["calendar_weekendburningcrusade"] = "dungeon",
	["calendar_weekendwrathofthelichking"] = "dungeon",
	["calendar_weekendcataclysm"] = "dungeon",
	["calendar_weekendmistsofpandaria"] = "dungeon",
}
--]]

-- /run Overachiever.ToastForEvents(true, true, true, true)
function Overachiever.ToastForEvents(holiday, microholiday, bonusevent, dungeonevent, pvpbrawl, misc)
	if (not holiday and not microholiday and not bonusevent and not dungeonevent and not pvpbrawl and not misc) then  return;  end
	--print("ToastForEvents",holiday, microholiday, bonusevent, dungeonevent, pvpbrawl)

	local function filterEvents(localizedTitle, texture)
		--print("filterEvents", localizedTitle, texture)
		local arr = EVENT_TEXTURE_LOOKUP[texture]
		if (not arr) then
			return misc
			--return showUnknownToasts
		end
		local holidayType = type(arr) == "table" and arr[1] or arr
		if     (holidayType == "holiday") then	return holiday
		elseif (holidayType == "micro") then	return microholiday
		elseif (holidayType == "bonus") then	return bonusevent
		elseif (holidayType == "dungeon") then	return dungeonevent
		elseif (holidayType == "pvpbrawl") then	return pvpbrawl
		end
	end

	local events = Overachiever.GetTodaysEvents(-1, true, nil, filterEvents)
	if (events) then
		--print("events:")
		for localizedEventTitle,tab in pairs(events) do
			local arr = EVENT_TEXTURE_LOOKUP[tab.texture]
			local onClick
			local holidayType = type(arr) == "table" and arr[1] or arr
			if (holidayType == "holiday") then
				onClick = function()
					if (not AchievementFrame and CanShowAchievementUI()) then
						AchievementFrame_LoadUI()
					end
					if (Overachiever.OpenSuggestionsTab) then
						Overachiever.OpenSuggestionsTab(localizedEventTitle)
					else
						Calendar_LoadUI()
						if (Calendar_Show) then  Calendar_Show();  end
					end
				end
			else
				onClick = function()
					Calendar_LoadUI()
					if (Calendar_Show) then  Calendar_Show();  end
				end
			end
			local achID = type(arr) == "table" and arr[2] or nil
			local delay
			if (Overachiever_Settings.ToastCalendar_noautofade) then
				delay = Overachiever_Settings.ToastCalendar_onlyclickfade and -1 or 0
			end
			--print("-",localizedEventTitle)
			Overachiever.ToastFakeAchievement(localizedEventTitle, achID, false, nil, delay, L.STARTTOAST_EVENT, onClick, tab.texture)
		end
	end
end



--/dump CalendarGetDayEvent(0, 4, 1)
--/dump C_Calendar.GetDayEvent(0, 4, 1)
