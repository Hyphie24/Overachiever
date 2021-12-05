
--
--  Overachiever - Tabs: Search.lua
--    by Tuhljin
--
--  If you don't wish to use the search tab, feel free to delete this file or rename it (e.g. to Search_unused.lua).
--  The addon's other features will work regardless.
--

local L = OVERACHIEVER_STRINGS
local GetAchievementInfo = GetAchievementInfo
local GetAchievementCriteriaInfo = Overachiever.GetAchievementCriteriaInfo

local EditBoxes = {}

local searchInProgress = false


-- Set this to "true" (without quotes) to make Search tab edit boxes lose their input focus when a search begins.
local OPTION_LoseFocusOnSearch = false


local VARS
local frame, panel, sortdrop
local EditAny, EditName, EditDesc, EditCriteria, EditReward
local SubmitBtn, ResetBtn, ResultsLabel, SearchingLabel
local FullListCheckbox, FullListCheckboxTextColor
local typedrop

local function SortDrop_OnSelect(self, value)
  VARS.SearchSort = value
  frame.sort = value
  frame:ForceUpdate(true)
end

local function TypeDrop_OnSelect(self, value)
  VARS.SearchType = value
  frame.guildView_default = value == 2 and true or nil
  if (value == 3) then
    FullListCheckbox:Disable()
	if (not FullListCheckboxTextColor) then
	  FullListCheckboxTextColor = { FullListCheckbox.Text:GetTextColor() }
	end
	FullListCheckbox.Text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
  else
    FullListCheckbox:Enable()
	if (FullListCheckboxTextColor) then  FullListCheckbox.Text:SetTextColor( unpack(FullListCheckboxTextColor) );  end
  end
end

local function FullList_OnClick(self)
  if (self:GetChecked()) then
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
    VARS.SearchFullList = true
  else
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
    VARS.SearchFullList = false
  end
end

local function OnLoad(v)
  VARS = v
  if (VARS.SearchFullList) then  FullListCheckbox:SetChecked(true);  end
  sortdrop:SetSelectedValue(VARS.SearchSort or 0)
  typedrop:SetSelectedValue(VARS.SearchType or 1)
end

frame, panel = Overachiever.BuildNewTab("Overachiever_SearchFrame", L.SEARCH_TAB,
                 "Interface\\AddOns\\Overachiever_Tabs\\SearchWatermark", L.SEARCH_HELP, OnLoad)

sortdrop = TjDropDownMenu.CreateDropDown("Overachiever_SearchFrameSortDrop", panel, {
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


local function clearSearchResults()
	frame.AchList = {}
	Overachiever_SearchFrameContainerScrollBar:SetValue(0)
	frame:ForceUpdate(true)
	ResultsLabel:Hide()
end

local function processSearchResults(results)
	searchInProgress = false
	frame.AchList = results -- If you find a bug later, try changing this to do a wipe and table copy (to preserve references). Seems unneeded, though.
	Overachiever_SearchFrameContainerScrollBar:SetValue(0)
	frame:ForceUpdate(true)
	ResultsLabel:Show()
	SearchingLabel:Hide()
end

local function beginSearch(self)
  if (searchInProgress) then  return;  end
  PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)

  if (OPTION_LoseFocusOnSearch) then
    for i,editbox in ipairs(EditBoxes) do
      _G[editbox]:SetAutoFocus(false)
      _G[editbox]:ClearFocus()
    end
  end

  local name, desc, criteria, reward, any = EditName:GetText(), EditDesc:GetText(), EditCriteria:GetText(), EditReward:GetText(), EditAny:GetText()
  if (name == "" and desc == "" and criteria == "" and reward == "" and any == "") then  -- all fields are blank
    --ResultsLabel:Hide()
    return;
  end

  local excludeHidden = not VARS.SearchFullList
  local achType = nil
  if (VARS.SearchType == 1) then
	achType = "p"
  elseif (VARS.SearchType == 2) then
	achType = "g"
  elseif (VARS.SearchType == 3) then
	achType = "o"
	excludeHidden = false
  end

  searchInProgress = true
  clearSearchResults()
  Overachiever.StartAchSearch(excludeHidden, achType, nil, name, desc, criteria, reward, any, processSearchResults)
  SearchingLabel:Show()
end
-- /dump Overachiever_SearchFrame.AchList

function frame.SetNumListed(num)
  if (searchInProgress) then  return;  end
  ResultsLabel:SetText(L.SEARCH_RESULTS:format(num))

  local c = #frame.AchList
  if (num < c) then
    frame.frameWarning.label:SetText(L.SEARCH_FILTERED_OUT:format(c - num))
	--local w = frame.frameWarning.label:GetStringWidth() + 100
	--if (w > 492) then  w = 492;  end
	--frame.frameWarning:SetWidth(w)
    frame.frameWarning:Show()
  else
    frame.frameWarning:Hide()
  end
end


local function tabPressed(self)
  self:SetAutoFocus(false)
  EditBox_HandleTabbing(self, EditBoxes)
end

local function escapeEditBox(self)
  self:SetAutoFocus(false)
end

local function focusEditBox(self, clearAll)
  for i,editbox in ipairs(EditBoxes) do
    _G[editbox]:SetAutoFocus(false)
  end
  self:SetAutoFocus(true)
end

local function createEditBox(name, labeltext, obj, x, y)
  name = "Overachiever_SearchFrame"..name.."Edit"
  local editbox = CreateFrame("EditBox", name, panel, "InputBoxTemplate")
  editbox:SetAutoFocus(false)
  editbox:SetWidth(170); editbox:SetHeight(16)
  editbox:SetPoint("TOPLEFT", obj, "BOTTOMLEFT", x or 0, y or -23)
  local label = editbox:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  label:SetPoint("BOTTOMLEFT", editbox, "TOPLEFT", -6, 4)
  label:SetText(labeltext)
  editbox:SetScript("OnTabPressed", tabPressed)
  editbox:SetScript("OnEnterPressed", beginSearch)
  editbox:HookScript("OnEscapePressed", escapeEditBox)
  editbox:HookScript("OnEditFocusGained", focusEditBox)
  EditBoxes[#EditBoxes+1] = name  -- We use the name rather than a frame because names are used by EditBox_HandleTabbing.
  return editbox
end

EditName = createEditBox("Name", L.SEARCH_NAME, sortdrop, 22, -19)
EditDesc = createEditBox("Desc", L.SEARCH_DESC, EditName)
EditCriteria = createEditBox("Criteria", L.SEARCH_CRITERIA, EditDesc)
EditReward = createEditBox("Reward", L.SEARCH_REWARD, EditCriteria)
EditAny = createEditBox("Any", L.SEARCH_ANY, EditReward)
createEditBox = nil


typedrop = TjDropDownMenu.CreateDropDown("Overachiever_SearchFrameTypeDrop", panel, {
  {
    text = L.SEARCH_TYPE_ALL,
    value = 0
  },
  {
    text = L.SEARCH_TYPE_INDIV,
    value = 1
  },
  {
    text = L.SEARCH_TYPE_GUILD,
    value = 2
  },
  {
    text = L.SEARCH_TYPE_OTHER,
    value = 3
  };
})
typedrop:SetLabel(L.SEARCH_TYPE, true)
typedrop:SetPoint("LEFT", sortdrop, "LEFT")
typedrop:SetPoint("TOP", EditAny, "BOTTOM", 0, -21)
typedrop:OnSelect(TypeDrop_OnSelect)


FullListCheckbox = CreateFrame("CheckButton", "Overachiever_SearchFrameFullListCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
--FullListCheckbox:SetPoint("TOPLEFT", EditAny, "BOTTOMLEFT", -8, -12)
FullListCheckbox:SetPoint("LEFT", EditAny, "LEFT", -8, 0)
FullListCheckbox:SetPoint("TOP", typedrop, "BOTTOM", 0, -4)
Overachiever_SearchFrameFullListCheckboxText:SetText(L.SEARCH_FULLLIST)
Overachiever_SearchFrameFullListCheckboxText:SetJustifyH("LEFT")
FullListCheckbox:SetHitRectInsets(0, -1 * min(Overachiever_SearchFrameFullListCheckboxText:GetWidth() + 8, 155), 0, 0)
FullListCheckbox:SetScript("OnClick", FullList_OnClick)
FullListCheckbox:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
  --GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
  GameTooltip:SetText(L.SEARCH_FULLLIST_TIP, nil, nil, nil, nil, 1)
end)
FullListCheckbox:SetScript("OnLeave", GameTooltip_Hide)

local function resetEditBoxes(self, button, ...)
  if (button ~= true) then  PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);  end
  for i,editbox in ipairs(EditBoxes) do
    _G[editbox]:SetText("")
  end
end

SubmitBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
SubmitBtn:SetWidth(75); SubmitBtn:SetHeight(21)
SubmitBtn:SetPoint("TOPLEFT", FullListCheckbox, "BOTTOMLEFT", 2, -8)
SubmitBtn:SetText(L.SEARCH_SUBMIT)
SubmitBtn:SetScript("OnClick", beginSearch)

ResetBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
ResetBtn:SetWidth(75); ResetBtn:SetHeight(21)
ResetBtn:SetPoint("LEFT", SubmitBtn, "RIGHT", 4, 0)
ResetBtn:SetText(L.SEARCH_RESET)
ResetBtn:SetScript("OnClick", resetEditBoxes)

ResultsLabel = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ResultsLabel:SetPoint("TOPLEFT", SubmitBtn, "BOTTOMLEFT", 0, -8)
ResultsLabel:Hide()

SearchingLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
SearchingLabel:SetPoint("TOP", frame, "TOP", 0, -189)
SearchingLabel:SetText(L.SEARCH_SEARCHING)
SearchingLabel:SetWidth(490)
SearchingLabel:Hide()



function Overachiever.OpenSearchTab(name)
	if (not AchievementFrame:IsShown()) then  ToggleAchievementFrame();  end
	resetEditBoxes(ResetBtn, true)
	if (name) then  EditName:SetText(name);  end
	if (Overachiever.GetSelectedTab() ~= frame) then
		Overachiever.OpenTab_frame(frame, true)
	end
	beginSearch()
end



--[[
function Overachiever.Debug_GetIDRange()
  local gap, i, id, firstid, lastid = 0, 0
  repeat
    i = i + 1
    firstid = GetAchievementInfo(i)
    assert(i < 1000)
  until (firstid)
  repeat
    i = i + 1
    id = GetAchievementInfo(i)
    if (id) then  gap, lastid = 0, id;  else  gap = gap + 1;  end
  until (gap > 1000)
  print("ID range: {", firstid, ",", lastid, "}")
end
-- Last check: WoW 3.2: { 6 , 4316 }
--]]
