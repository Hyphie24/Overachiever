
--
--  TjCalendar.lua
--    by Tuhljin
--
--  Make it easier for addons to deal with WoW's calendar. In addition to providing some utility functions, this
--  library aims to deal with the GUI problem that arises from reading the calendar. The problem is that doing so
--  often requires the calendar to be set to the current month in order to be reliable, but if the user is currently
--  looking at the calendar, this can be disruptive. So, two functions are provided here: One to indicate you're
--  about to read from the calendar, which sets its position to the current month (and year!), and another to
--  indicate you're done reading from the calendar, which puts the calendar position back where it was (if there
--  actually was a change).
--
--  These two functions are, in order, TjCalendar.StartReading() and TjCalendar.StopReading(). In this file, the
--  contents between calling TjCalendar.StartReading() and TjCalendar.StopReading() will be called a "Reading block."
--
--  Note that at this time you cannot safely nest these calls such that, e.g., StartReading() is called twice, then
--  one StopReading() followed by some processing and then the second StopReading(). This functionality wasn't needed
--  at the time this was written so was deemed unnecessary (albeit ideal and logical).
--
--  Also note that StartReading() uses the CalendarGetDate function which only returns reliable data after the
--  PLAYER_LOGIN event has fired, so don't call it until after that time.
--
--  [month, year, numDays, firstWeekday] = TjCalendar.StartReading([getMonthData])
--    Start a Reading block, as described above. Does not return anything unless the argument getMonthData evaluates
--    to true, in which case it returns what you'd get from a call to "CalendarGetMonth(0)" if the calendar position
--    was the current month (which it would be at that point since a Reading block is started). It is sometimes slightly
--    more efficient to get this return data than it would be to simply start a block and then call CalendarGetMonth(0)
--    yourself afterward since StartReading could have needed to call that function anyway.
--
--  TjCalendar.StopReading()
--    Stop a Reading block, as described above.
--
--  [month, year, numDays, firstWeekday] = TjCalendar.StartReadingAt(startYear, startMonth[, getMonthData])
--    As TjCalendar.StartReading except that the calendar position is set to a year and month specified here instead of
--    the current one. If year is nil, the current year is used - but be careful that the month you intend is in this year.
--


local THIS_VERSION = 0.04

if (TjCalendar and TjCalendar.Version >= THIS_VERSION) then  return;  end

TjCalendar = TjCalendar or {}
local TjCalendar = TjCalendar
TjCalendar.Version = THIS_VERSION

local monthSet, yearSet

local internal_monthSet, internal_yearSet


local CalendarSetAbsMonth = CalendarSetAbsMonth or C_Calendar.SetAbsMonth

local function CalendarGetDate()
	local info = C_DateAndTime.GetCurrentCalendarTime()
	return info.weekday, info.month, info.monthDay, info.year, info.hour, info.minute
end

local CalendarGetMonth = CalendarGetMonth or function(...)
	local info = C_Calendar.GetMonthInfo(...)
	return info.month, info.year, info.numDays, info.firstWeekday
end


local function internal_StartReadingAt(year, month, getMonthData)
	if (not year) then
		local _
		_, _, _, year = CalendarGetDate()
	end
	local m, y, numDays, firstWeekday = CalendarGetMonth()
	if (m ~= month or y ~= year) then
		internal_monthSet, internal_yearSet = m, y
		CalendarSetAbsMonth(month, year)
		-- Note that if year is omitted, it doesn't use the current year as in the year NOW but rather the current year as in the year the
		-- calendar is currently showing. So you often DO need to specify the year to be sure it's set to the correct one.
		if (getMonthData) then
			return CalendarGetMonth()
		end
	else
		internal_monthSet, internal_yearSet = nil, nil
		if (getMonthData) then
			return m, y, numDays, firstWeekday
		end
	end
end

local function internal_StartReading(getMonthData)
	local weekday, month, day, year = CalendarGetDate()
	return internal_StartReadingAt(year, month, getMonthData)
end

local function internal_StopReading()
	if (internal_monthSet) then
		CalendarSetAbsMonth(internal_monthSet, internal_yearSet)
		internal_monthSet, internal_yearSet = nil, nil
	end
end


function TjCalendar.StartReadingAt(year, month, getMonthData)
	if (not year) then
		local _
		_, _, _, year = CalendarGetDate()
	end
	local m, y, numDays, firstWeekday = CalendarGetMonth()
	if (m ~= month or y ~= year) then
		monthSet, yearSet = m, y
		CalendarSetAbsMonth(month, year)
		-- Note that if year is omitted, it doesn't use the current year as in the year NOW but rather the current year as in the year the
		-- calendar is currently showing. So you often DO need to specify the year to be sure it's set to the correct one.
		if (getMonthData) then
			return CalendarGetMonth()
		end
	else
		monthSet, yearSet = nil, nil
		if (getMonthData) then
			return m, y, numDays, firstWeekday
		end
	end
end

function TjCalendar.StartReading(getMonthData)
	local weekday, month, day, year = CalendarGetDate()
	return TjCalendar.StartReadingAt(year, month, getMonthData)
end

function TjCalendar.StopReading()
	if (monthSet) then
		CalendarSetAbsMonth(monthSet, yearSet)
		monthSet, yearSet = nil, nil
	end
end


function TjCalendar.GetDaysBetween(year1, month1, day1, year2, month2, day2)
	assert(year1 and month1 and day1 and year2 and month2 and day2, "Invalid argument given to TjCalendar.GetDaysBetween()")
	if (year1 > year2 or (year1 == year2 and (month1 > month2 or (month1 == month2 and day1 > day2)))) then
		--print("flip",year2, month2, day2, year1, month1, day1)
		local diff = TjCalendar.GetDaysBetween(year2, month2, day2, year1, month1, day1)
		if (diff) then  diff = diff * -1;  end
		return diff
	end
	if (year1 == year2 and month1 == month2) then  return day2 - day1;  end
	local _, _, numDays = internal_StartReadingAt(year1, month1, true)
	local diff = numDays - day1; -- Number of days left in the month after today
	--[[
	if ((year1 == year2 and month1 + 1 == month2) or (year1 + 1 == year2 and month1 == 12 and month2 == 1)) then -- If month2 is one month after month1:
		internal_StopReading()
		return diff + day2
	end
	--]]
	for mOffset = 1, 100 do -- 100 months should be far more than enough; this is a failsafe
		local m, y, numDays = CalendarGetMonth(mOffset)
		if (m == month2 and y == year2) then
			internal_StopReading()
			return diff + day2
		end
		diff = diff + numDays
		--print("diff up",numDays,diff)
	end
	internal_StopReading()
	return false
end

-- Note that this function rounds up. E.g., if you're mid-day through today and ask for days until tomorrow, it will return 1.
function TjCalendar.GetDaysUntil(year, month, day)
	assert(month and day and year, "Invalid argument given to TjCalendar.GetDaysUntil()")
	local weekday, m, d, y = CalendarGetDate()
	--print(y, m, d, year, month, day)
	return TjCalendar.GetDaysBetween(y, m, d, year, month, day)
end
