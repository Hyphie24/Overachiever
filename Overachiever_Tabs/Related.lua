
--
--  Overachiever - Tabs: Related.lua
--    by Tuhljin
--
--  If you don't wish to use the related tab, feel free to delete this file or rename it (e.g. to Related_unused.lua).
--  The addon's other features will work regardless.
--

local DEFAULT_SERIES_DEEPER_META = true

local L = OVERACHIEVER_STRINGS
local GetAchievementInfo = GetAchievementInfo
local GetAchievementCriteriaInfo = Overachiever.GetAchievementCriteriaInfo


local VARS
local frame, panel, sortdrop
local BasePreLabel, BaseLabel, ResultsLabel
local CloseBtn, RecursiveCheckbox
local BaseMouseableArea

local baseAchID, prevTab
local achProcessed = -1


local next = next
local pairs = pairs


local metas -- = Overachiever.GetMetaCriteriaLookup()
local seriesLookup, seriesPlace = {}, {}
local seriesCount = 0

local function addRelativesSeries(id, relatives, newList)
	local anyFound = false
	local place = 0
	-- Get others in a series:
	local ach = GetPreviousAchievement(id)
	if (seriesLookup[ach]) then  return;  end  -- Stop if we already processed this series.
	while (ach) do
		relatives[ach] = true
		newList[ach] = true
		seriesLookup[ach] = seriesCount
		place = place - 1
		seriesPlace[ach] = place
		anyFound = true
		ach = GetPreviousAchievement(ach)
	end
	place = 0
	ach = GetNextAchievement(id)
	if (seriesLookup[ach]) then  return;  end  -- Stop if we already processed this series. (Would have already stopped unless there was no previous, only next.)
	while (ach) do
		relatives[ach] = true
		newList[ach] = true
		seriesLookup[ach] = seriesCount
		place = place + 1
		seriesPlace[ach] = place
		anyFound = true
		ach = GetNextAchievement(ach)
	end
	if (anyFound) then
		seriesLookup[id] = seriesCount
		seriesPlace[id] = 0
		seriesCount = seriesCount + 1
	end
end

local function addRelativesMeta(id, relatives, newList)
	-- Get those the base achievement is a criteria for:
	if (metas[id]) then
		local m = metas[id]
		if (type(m) == "table") then
			for i,ach in pairs(m) do
				if (not relatives[ach]) then
					relatives[ach] = true
					if (newList) then  newList[ach] = true;  end
				end
			end
		elseif (not relatives[m]) then
			relatives[m] = true
			if (newList) then  newList[m] = true;  end
		end
	end
	-- Get those the base achievement has as its criteria:
	for i=1,GetAchievementNumCriteria(id) do
		local _, critType, _, _, _, _, _, assetID = GetAchievementCriteriaInfo(id, i)
		if (critType == 8 and not relatives[assetID]) then
			relatives[assetID] = true
			if (newList) then  newList[assetID] = true;  end
		end
	end
end

local function findRelatives()
	wipe(seriesLookup)
	wipe(seriesPlace)
	local relatives, newFromSeries, newFromMeta = {}, {}, {}
	relatives[baseAchID] = true
	addRelativesSeries(baseAchID, relatives, newFromSeries)
	addRelativesMeta(baseAchID, relatives, newFromMeta)
	if (VARS.RelatedRecursive) then
		local failsafe = 0
		while (next(newFromSeries) or next(newFromMeta)) do
			local nfs, nfm = {}, {}
			for id in pairs(newFromSeries) do
				addRelativesMeta(id, relatives, nfm)
			end
			for id in pairs(newFromMeta) do
				addRelativesSeries(id, relatives, nfs)
				addRelativesMeta(id, relatives, nfm)
			end
			newFromSeries = nfs
			newFromMeta = nfm
			failsafe = failsafe + 1
			if (failsafe > 1000) then
				Overachiever.chatprint("Error: Too many loops in findRelatives() - Related.lua.")
				break
			end
		end
	elseif (DEFAULT_SERIES_DEEPER_META) then
		if (next(newFromSeries)) then
			for id in pairs(newFromSeries) do
				addRelativesMeta(id, relatives)
			end
		end
	end

	local list = frame.AchList
	wipe(list)
	local count = 0
	for id in pairs(relatives) do
		count = count + 1
		list[count] = id
	end
	achProcessed = baseAchID
	Overachiever_RelatedFrameContainerScrollBar:SetValue(0) -- scroll to top
	frame:ForceUpdate(true)
end

local function valincludes(val, id)
  if (val == id)  then return true;  end
  if (type(val) == "table") then
    for k,v in pairs(val) do
	  if (v == id) then  return true;  end
	end
  end
  return false;
end

function Overachiever.RelatedTab_Compare(id1, id2)
  if (seriesLookup[id1] and seriesLookup[id1] == seriesLookup[id2]) then  -- If in the same series
    return seriesPlace[id1] < seriesPlace[id2] and -1 or 1
  end
  if (valincludes(metas[id1], id2)) then  return -1;  end -- If #1 is needed for #2, then #1 comes first
  if (valincludes(metas[id2], id1)) then  return 1;  end -- If #2 is needed for #1, then #2 comes first
  -- The rest isn't so cut and dry. We'll try to put things in a series next to each other and make the flow as "natural" as possible.
  if (seriesLookup[id1] and not seriesLookup[id2]) then  return -1;  end  -- If #1 is in a series but #2 isn't, put #1 first.
  if (seriesLookup[id2] and not seriesLookup[id1]) then  return 1;  end   -- If #2 is in a series but #1 isn't, put #2 first.
  return 0
end


local function closePanel()
  frame.tab:Hide()
  if (prevTab) then
    Overachiever.OpenTab_frame(prevTab)
    prevTab = nil
  else
    AchievementFrameBaseTab_OnClick(1)
    --Overachiever.UI_SelectAchievement(baseAchID)
    --[[
    -- Go to main tab:
    ToggleAchievementFrame()
    -- Problem is, if this achievement is part of a category which has sub-categories, the sub-categories aren't displayed.
    --]]
  end
  baseAchID = nil
  PlaySound(SOUNDKIT.IG_SPELLBOOK_CLOSE)
  --PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
end




local function SortDrop_OnSelect(self, value)
  VARS.SearchSort = value
  frame.sort = value
  frame:ForceUpdate(true)
end

local function OnLoad(v)
  VARS = v
  -- Moved the rest elsewhere since load order is different for this tab:
  --sortdrop:SetSelectedValue(VARS.SearchSort or 4)
  --if (VARS.RelatedRecursive) then  RecursiveCheckbox:SetChecked(true);  end
end

local function buildRelatedTab()

	frame, panel = Overachiever.BuildNewTab("Overachiever_RelatedFrame", L.RELATED_TAB,
					 "Interface\\AddOns\\Overachiever_Tabs\\RelatedWatermark", L.RELATED_HELP, OnLoad)

	sortdrop = TjDropDownMenu.CreateDropDown("Overachiever_RelatedFrameSortDrop", panel, {
	  {
		text = L.TAB_SORT_RELATION, -- Special sorting option. Not usable in just any tab (yet?).
		value = 4
	  },
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
	sortdrop:SetSelectedValue(VARS.SearchSort or 4)

	function frame.SetNumListed(num)
	  ResultsLabel:SetText(L.RELATED_RESULTS:format(num))

	  local c = #frame.AchList
	  if (num < c) then
		frame.frameWarning.label:SetText(L.RELATED_FILTERED_OUT:format(c - num))
		--local w = frame.frameWarning.label:GetStringWidth() + 100
		--if (w > 492) then  w = 492;  end
		--frame.frameWarning:SetWidth(w)
		frame.frameWarning:Show()
	  else
		frame.frameWarning:Hide()
	  end
	end


	--[[
	EditBaseAch = CreateFrame("EditBox", "Overachiever_RelatedFrameBaseAchEdit", panel, "InputBoxTemplate")
	EditBaseAch:SetWidth(170); EditBaseAch:SetHeight(16)
	EditBaseAch:SetAutoFocus(false)
	EditBaseAch:SetPoint("TOPLEFT", sortdrop, "BOTTOMLEFT", 22, -19)
	do
	  local label = EditBaseAch:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	  label:SetPoint("BOTTOMLEFT", EditBaseAch, "TOPLEFT", -6, 4)
	  label:SetText(L.RELATED_BASE)
	end
	--]]

	BasePreLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	--BasePreLabel:SetPoint("BOTTOMLEFT", sortdrop, "BOTTOMLEFT", 16, -15)
	BasePreLabel:SetPoint("TOPLEFT", sortdrop, "BOTTOMLEFT", 16, -3)
	BasePreLabel:SetText(L.RELATED_BASE)


	BaseLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge") --"GameFontNormal"
	BaseLabel:SetPoint("TOPLEFT", BasePreLabel, "BOTTOMLEFT", 0, -4)
	BaseLabel:SetWordWrap(true) -- should default to this; enabling just in case that changes
	BaseLabel:SetNonSpaceWrap(true)
	BaseLabel:SetWidth(180)
	BaseLabel:SetJustifyH("LEFT") -- need this since we're setting the width
	BaseLabel:SetText("not set")

	BaseMouseableArea = CreateFrame("Button", nil, panel) --CreateFrame("Frame", nil, panel)
	BaseMouseableArea:SetPoint("TOPLEFT", BaseLabel, "TOPLEFT", 0, 0)
	BaseMouseableArea:SetWidth(BaseLabel:GetWidth())
	function BaseMouseableArea:AdjustHeight()
		self:SetHeight(BaseLabel:GetHeight()) -- * BaseLabel:GetNumLines()) --(BaseLabel:GetHeight() + BaseLabel:GetSpacing()) * BaseLabel:GetNumLines()
	end

	BaseMouseableArea:SetScript("OnEnter", function(self)
	  if (not baseAchID) then  return;  end
	  GameTooltip:SetOwner(self, "ANCHOR_NONE")
	  --GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 10, 0)
	  GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 0, 15)
	  GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
	  GameTooltip:SetHyperlink( GetAchievementLink(baseAchID) )
	end)

	BaseMouseableArea:SetScript("OnClick", function(self, button, down)
	  if (not baseAchID) then  return;  end
	  if (IsShiftKeyDown()) then
		if ( ChatEdit_GetActiveWindow() ) then
		  ChatEdit_InsertLink(GetAchievementLink(baseAchID));
		else
		  ChatFrame_OpenChat(GetAchievementLink(baseAchID));
		end
	  elseif (IsControlKeyDown()) then
	  -- We prefer an openToAchievement() call instead of a direct AchievementFrame_SelectAchievement() call, so
	  -- we do this here instead of calling orig_WatchFrameLinkButtonTemplate_OnLeftClick():
		Overachiever.OpenToAchievement(baseAchID)
	  end
	end)

	BaseMouseableArea:SetScript("OnLeave", GameTooltip_Hide)


	RecursiveCheckbox = CreateFrame("CheckButton", "Overachiever_RelatedFrameRecursiveCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
	RecursiveCheckbox:SetPoint("LEFT", sortdrop, "LEFT", 14, 0)
	RecursiveCheckbox:SetPoint("TOP", BaseLabel, "BOTTOM", 0, -24)
	Overachiever_RelatedFrameRecursiveCheckboxText:SetText(L.RELATED_RECURSIVE)
	Overachiever_RelatedFrameRecursiveCheckboxText:SetJustifyH("LEFT")
	RecursiveCheckbox:SetHitRectInsets(0, -1 * min(Overachiever_RelatedFrameRecursiveCheckboxText:GetWidth() + 8, 155), 0, 0)

	RecursiveCheckbox:SetScript("OnClick", function(self)
		if (self:GetChecked()) then
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
			VARS.RelatedRecursive = true
			findRelatives()
		else
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
			VARS.RelatedRecursive = false
			findRelatives()
		end
	end)

	RecursiveCheckbox:SetScript("OnEnter", function(self)
	  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	  GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
	  GameTooltip:SetText(L.RELATED_RECURSIVE_TIP, nil, nil, nil, nil, 1)
	end)

	RecursiveCheckbox:SetScript("OnLeave", GameTooltip_Hide)
	if (VARS.RelatedRecursive) then  RecursiveCheckbox:SetChecked(true);  end


	ResultsLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	ResultsLabel:SetPoint("LEFT", BaseLabel, "LEFT", 0, 0)
	ResultsLabel:SetPoint("TOP", RecursiveCheckbox, "BOTTOM", 0, -24)


	CloseBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
	CloseBtn:SetWidth(75); CloseBtn:SetHeight(21)
	CloseBtn:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", 0, 2) -- 0, 63 lines up with "Search" button
	CloseBtn:SetText(L.RELATED_CLOSE)
	CloseBtn:SetScript("OnClick", closePanel)

	-- Building the tab late like this causes it to be the wrong size until it is re-shown. This works around this:
	frame.tab:Hide()
	frame.tab:Show()
	-- The above is actually just a partial workaround, since it still looks funny when it's not the selected tab (until re-shown). But that
	-- doesn't matter for us since we want to select the tab now anyway:
	--Overachiever.OpenTab_frame(frame, true) -- Do this as part of the other function

	panel:SetScript("OnShow", function()
		local tab = Overachiever.GetSelectedTab(true)
		if (tab ~= frame)  then  prevTab = tab;  end
	end)

	Overachiever.CheckDraggable_AchFrame_redo()

end


function Overachiever.OpenRelatedTab(id)
	metas = metas or Overachiever.GetMetaCriteriaLookup()
	if (not frame) then
		buildRelatedTab()
		buildRelatedTab = nil
	elseif (not baseAchID) then
		frame.tab:Show()
	end
	baseAchID = id
	local _, name = GetAchievementInfo(id)
	BaseLabel:SetText(name)
	BaseMouseableArea:AdjustHeight()
	if (achProcessed ~= id) then  findRelatives();  end
	if (Overachiever.GetSelectedTab() == frame) then
		Overachiever.OpenTab_frame(frame)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	else
		Overachiever.OpenTab_frame(frame, true)
	end
end


local orig_AchievementButton_OnClick = AchievementButton_OnClick
AchievementButton_OnClick = function(self, ignoreModifiers, ...)
  if (not ignoreModifiers and IsControlKeyDown() and IsShiftKeyDown()) then
    Overachiever.OpenRelatedTab(self.id)
    return;
  end
  return orig_AchievementButton_OnClick(self, ignoreModifiers, ...)
end

