
--
--  Overachiever - Tabs: CalendarNotice.lua
--    by Tuhljin
--
--  This isn't for a tab but for a small notification window. Requires the Suggestions tab.
--

if (not Overachiever.SUGGESTIONS) then  return;  end
local L = OVERACHIEVER_STRINGS


local createNotice, clearNotices
local numNotices = 0
local lastEvents

local SHOW_DAYS_UNLESS_OVER = 14

local hiddenEvents
local activeNoticeFrames = {}


--local r_desc, g_desc, b_desc = 0.4, 0.7333, 1 -- Approx. same color as that used to indicate such things as "Crafting Reagent" on an item tooltip (light blue)
--/dump GameTooltipTextLeft3:GetTextColor()

local r_desc, g_desc, b_desc = 0.741, 1, 0.467


local function CalendarGetDate()
	local info = C_DateAndTime.GetCurrentCalendarTime()
	return info.weekday, info.month, info.monthDay, info.year, info.hour, info.minute
end


local ACHID_HOLIDAY = Overachiever.SUGGESTIONS.holiday;

local function getHolidayAchs(localizedEventTitle)
	local key = Overachiever.HOLIDAY_REV[localizedEventTitle] or localizedEventTitle
	return ACHID_HOLIDAY[key]
end


function Overachiever.SetupHolidayNotices(achieveFrame, optionsChanged)
	--UI_HolidayNotice_SuggestionsTabOnly
	if (not Overachiever_Settings.UI_HolidayNotice) then
		if (lastEvents) then
			lastEvents = nil
			clearNotices()
		end
		return;
	end
	local events = Overachiever.GetTodaysEvents("notice", true, true, getHolidayAchs)
	--local events = Overachiever.GetHolidayEvents(2016, 12, 25, 1, "x", true, true, getHolidayAchs);
	if (events == lastEvents and not optionsChanged) then  return;  end
	lastEvents = events
	clearNotices()
	local startHidden = Overachiever_Settings.UI_HolidayNotice_SuggestionsTabOnly and not Overachiever_SuggestionsFrame:IsShown()
	for title,arr in pairs(events) do
		if (not hiddenEvents or not hiddenEvents[title]) then
			createNotice(title, arr.texture, arr.desc, startHidden, arr.hourStart, arr.minuteStart, arr.yearEnd, arr.monthEnd, arr.dayEnd, arr.hourEnd, arr.minuteEnd)
		end
	end
end

function Overachiever.ResetHiddenHolidayNotices()
	hiddenEvents = nil
	lastEvents = nil
end


Overachiever_SuggestionsFrame:HookScript("OnShow", function(self)
	if (Overachiever_Settings.UI_HolidayNotice_SuggestionsTabOnly) then
		for i,frame in ipairs(activeNoticeFrames) do
			frame:Show()
		end
	end
end)

Overachiever_SuggestionsFrame:HookScript("OnHide", function(self)
	if (Overachiever_Settings.UI_HolidayNotice_SuggestionsTabOnly) then
		for i,frame in ipairs(activeNoticeFrames) do
			frame:Hide()
		end
	end
end)


local function timeUntil(hour, minute)
	-- Returns number of minutes until the given time
	local hourNow, minuteNow = GetGameTime()
	return ((hour - hourNow) * 60) + (minute - minuteNow)
end

local notice_OnEnter

local function notice_OnUpdate(self)
	if (self.tip ~= nil and self.tip ~= IsShiftKeyDown()) then
		self.tip = nil
		notice_OnEnter(self)
	end
end

function notice_OnEnter(self)
	local shiftKey = IsShiftKeyDown()
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 5, 0)
	--GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
	GameTooltip:AddLine(self.title, 1, 1, 1)
	GameTooltip:AddLine(" ")
	local endLine, skipStart = nil, false
	if (self.hourEnd and self.minuteEnd) then
		if (self.yearEnd and self.monthEnd and self.dayEnd) then
			local weekday, month, day, year = CalendarGetDate()
			if (month ~= self.monthEnd or day ~= self.dayEnd) then
				if (not shiftKey) then --and month ~= self.monthEnd and self.monthEnd >= 1 and self.monthEnd <= 12) then
					local d = TjCalendar.GetDaysUntil(self.yearEnd, self.monthEnd, self.dayEnd)
					if (d and d > 0 and d <= SHOW_DAYS_UNLESS_OVER) then
						if (d == 1) then
							local t = timeUntil(24, 0) -- Time until the next day.
							t = t + (self.hourEnd * 60) + self.minuteEnd -- Add time from there to the end time.
							if (t < 60) then
								endLine = L.EVENTNOTICE_ENDS_MINUTES:format(t)
							elseif (t < 1440) then -- 1440 minutes is 24 hours
								--endLine = L.EVENTNOTICE_ENDS_HOURS:format(math.ceil(t / 60))
								endLine = L.EVENTNOTICE_ENDS_HOURS:format(math.floor((t / 60) + 0.5))
							end
						end
						if (not endLine) then  endLine = L.EVENTNOTICE_ENDS_DAYS:format(d);  end
					end
				end
				if (not endLine) then
					local ft = GameTime_GetFormattedTime(self.hourEnd, self.minuteEnd, true)
					endLine = L.EVENTNOTICE_ENDS_DATETIME:format(self.dayEnd, self.monthEnd, ft)
				end
			end
		end
		if (not endLine) then
			local t = timeUntil(self.hourEnd, self.minuteEnd)
			if (t > 0 and shiftKey) then
				local ft = GameTime_GetFormattedTime(self.hourEnd, self.minuteEnd, true)
				endLine = L.EVENTNOTICE_ENDS_TIME:format(self.dayEnd, self.monthEnd, ft)
			else
				if (t <= 0) then
					-- This normally shouldn't happen, but it might if the achievement frame was kept open as the event ended.
					endLine = L.EVENTNOTICE_ENDED_TODAY
					skipStart = true
				elseif (t < 60) then
					endLine = L.EVENTNOTICE_ENDS_MINUTES:format(t)
				else
					--endLine = L.EVENTNOTICE_ENDS_HOURS:format(math.ceil(t / 60))
					endLine = L.EVENTNOTICE_ENDS_HOURS:format(math.floor((t / 60) + 0.5))
				end
			end
		end
	end
	if (not skipStart) then
		if (self.hourStart and self.minuteStart) then
			--local hourNow, minuteNow = GetGameTime()
			--if (hourNow > self.hourStart or (hourNow == self.hourStart and minuteNow > self.minuteStart)) then
			local t = timeUntil(self.hourStart, self.minuteStart)
			if (t <= 0) then
				GameTooltip:AddLine(L.EVENTNOTICE_STARTED_TODAY)
			elseif (t < 60) then
				GameTooltip:AddLine(L.EVENTNOTICE_STARTS_MINUTES:format(t))
			else
				--GameTooltip:AddLine(L.EVENTNOTICE_STARTS_HOURS:format(math.ceil(t / 60)))
				GameTooltip:AddLine(L.EVENTNOTICE_STARTS_HOURS:format(math.floor((t / 60) + 0.5)))
			end
		else
			GameTooltip:AddLine(L.EVENTNOTICE_ONGOING)
		end
	end
	if (endLine) then  GameTooltip:AddLine(endLine);  end
	GameTooltip:AddLine(" ")
	if (shiftKey) then
		self.tip = true
		if (self.desc) then
			--GameTooltip:AddLine('"'..self.desc..'"', 1, 1, 1, 1)
			GameTooltip:AddLine(self.desc, r_desc, g_desc, b_desc, 1) -- last argument (1) enables wordwrap
			GameTooltip:AddLine(" ")
		end
		GameTooltip:AddLine(L.EVENTNOTICE_HELP)
	else
		self.tip = false
		GameTooltip:AddLine(L.EVENTNOTICE_TIP)
	end
	GameTooltip:Show()
	self:SetScript("OnUpdate", notice_OnUpdate)
end

local function notice_OnLeave(self)
	self.tip = nil
	GameTooltip:Hide()
	self:SetScript("OnUpdate", nil)
end

local function notice_OnClick(self, button)
	if (button == "RightButton") then
		if (IsShiftKeyDown()) then
			hiddenEvents = hiddenEvents or {}
			hiddenEvents[self.title] = true
			lastEvents = nil
			Overachiever.SetupHolidayNotices()
		end
	elseif (IsControlKeyDown()) then
		Calendar_LoadUI()
		if (Calendar_Show) then  Calendar_Show();  end
	else
		Overachiever.OpenSuggestionsTab(self.title)
	end
end

local function getNextNoticeFrame(texture, startHidden)
	numNotices = numNotices + 1
	local frame = _G["Overachiever_EventNoticeFrame" .. numNotices]
	if (frame)  then
		frame.tex:SetTexture(texture)
	else
		-- Create a frame that in some ways mimics those using Blizzard's CalendarDayButtonTemplate
		frame = CreateFrame("Button", "Overachiever_EventNoticeFrame" .. numNotices, AchievementFrame) --CreateFrame("Frame",...
		frame:SetPoint("TOPLEFT", AchievementFrame, "TOPRIGHT", 7, -24 - ((numNotices - 1) * 88))
		frame:SetWidth(82); frame:SetHeight(82);

		local frameTex = frame:CreateTexture("$parentTexture", "ARTWORK")
		frame.tex = frameTex
		frameTex:SetTexture(texture) --"Interface\\Calendar\\Holidays\\Calendar_HarvestFestivalStart"
		frameTex:SetPoint("CENTER", 0, 0)
		frameTex:SetTexCoord(0.0, 0.7109375, 0.0, 0.7109375)
		frameTex:SetWidth(76); frameTex:SetHeight(76);

		local frameBorder = CreateFrame("Frame", "$parentBorder", frame, "BackdropTemplate")
		frameBorder:SetAllPoints(frame)
		frameBorder:SetBackdrop( {
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
			insets = { left = 5, right = 5, top = 5, bottom = 5 }
		} )
		frameBorder:SetBackdropBorderColor(ACHIEVEMENTUI_GOLDBORDER_R, ACHIEVEMENTUI_GOLDBORDER_G, ACHIEVEMENTUI_GOLDBORDER_B, ACHIEVEMENTUI_GOLDBORDER_A)
		frameBorder:SetFrameLevel(frameBorder:GetFrameLevel()+1)

		-- Background needed since some events' textures have transparencies:
		local frameBG = frame:CreateTexture("$parentBackground", "BACKGROUND", -1)
		frameBG:SetTexture("Interface\\AchievementFrame\\UI-Achievement-AchievementBackground")
		frameBG:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, -3)
		frameBG:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, 3)
		frameBG:SetTexCoord(0, 1, 0, 0.5)
		local frameBGDarken = frame:CreateTexture(nil, "BORDER") -- Tried to make it BACKGROUND but with a higher sublayer but it's buggy; it's as if sublayer is ignored since it was above the other only 50% of the time.
		frameBGDarken:SetAllPoints(frameBG)
		frameBGDarken:SetColorTexture(0, 0, 0, 0.5)
		--frameBGDarken:SetColorTexture(0, 0, 0, 0.75)

		frame:SetScript("OnEnter", notice_OnEnter)
		frame:SetScript("OnLeave", notice_OnLeave) --GameTooltip_Hide)
		frame:SetScript("OnClick", notice_OnClick)
		frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	end
	if (startHidden) then
		frame:Hide()
	else
		frame:Show()
	end
	return frame
end

function createNotice(title, texture, description, startHidden, hourStart, minuteStart, yearEnd, monthEnd, dayEnd, hourEnd, minuteEnd)
	local frame = getNextNoticeFrame(texture, startHidden)
	frame.title = title
	frame.desc = description
	frame.hourStart = hourStart
	frame.minuteStart = minuteStart
	frame.yearEnd = yearEnd
	frame.monthEnd = monthEnd
	frame.dayEnd = dayEnd
	frame.hourEnd = hourEnd
	frame.minuteEnd = minuteEnd
	activeNoticeFrames[#activeNoticeFrames + 1] = frame
	return frame
end

function clearNotices()
	for i = 1, numNotices do
		local frame = _G["Overachiever_EventNoticeFrame" .. i]
		frame:Hide()
		frame.title = nil
	end
	numNotices = 0
	wipe(activeNoticeFrames)
end

-- ? popup menu: Hide , Open Calendar

C_Timer.After(0, function()
	-- Had to delay this using C_Timer.After because any hooks done immediately got lost (resulting in my functions not being called even though the frame was shown).
	if (AchievementFrame:IsShown()) then  Overachiever.SetupHolidayNotices();  end
	AchievementFrame:HookScript("OnShow", Overachiever.SetupHolidayNotices)
end)


--
--[[
local orig_onshow = AchievementFrame:GetScript("OnShow")
AchievementFrame:SetScript("OnShow", function(self)
	orig_onshow(self)
	Overachiever.SetupHolidayNotices()
end)
--]]
