local L = OVERACHIEVER_STRINGS
local GetAchievementInfo = GetAchievementInfo
local GetAchievementCriteriaInfo = Overachiever.GetAchievementCriteriaInfo


local isGuildAchievement = Overachiever.IsGuildAchievement
local isUIInGuildView = Overachiever.isUIInGuildView

local tabs, tabselected, prevtab
local LeftFrame
local varsLoaded, oldver = false

local function emptyfunc() end

local ACHIEVEMENTUI_FONTHEIGHT
local In_Guild_View   -- imitation of Blizzard's local IN_GUILD_VIEW

local GetPreviousAchievement = GetPreviousAchievement


--[[
local isAchievementInUI_cache = {}
local function isAchievementInUI(id, checkNext, ignoreCache)
-- The cache is here and not in the main Overachiever.IsAchievementInUI function because there are some issues that
-- could arise where the cache would have outdated data, but those issues shouldn't be relevant in the places the
-- function here is called with the "ignoreCache" arg set to nil/false (or omitted). (In theory, there are ways to mitigate those issues
-- so in the future the cache could automatically be used when appropriate, but this solution will do for now.)
  if (not ignoreCache and isAchievementInUI_cache[id] ~= nil) then  return isAchievementInUI_cache[id];  end
  local result = Overachiever.IsAchievementInUI(id, checkNext)
  isAchievementInUI_cache[id] = result
  return result
end
--]]

local isAchievementInUI = Overachiever.IsAchievementInUI


local FilterByTab = {}
local orig_AchievementFrame_SetFilter = AchievementFrame_SetFilter

AchievementFrame_SetFilter = function(value, tabswitch)
  if (not tabswitch) then
    local frame = tabselected or AchievementFrameAchievements
    FilterByTab[frame] = value
    Overachiever_Tabs_Settings.AchFilters[frame:GetName()] = value
  end
  if (not Overachiever.NoAlterSetFilter and (tabswitch or tabselected)) then
    local orig_SetValue = AchievementFrameAchievementsContainerScrollBar.SetValue
    AchievementFrameAchievementsContainerScrollBar.SetValue = emptyfunc
    orig_AchievementFrame_SetFilter(value)
    AchievementFrameAchievementsContainerScrollBar.SetValue = orig_SetValue
  else
    return orig_AchievementFrame_SetFilter(value)
  end
end


local function click_parent(self, ...)
  return self:GetParent():Click()
end

local function getFrameOfButton(button)
  return button:GetParent():GetParent():GetParent()
end

local function delayedToggleView(self)
  if (not self) then
    if (tabselected) then  tabselected:SetScript("OnUpdate", delayedToggleView);  end
    return;
  end
  self:SetScript("OnUpdate", nil)
  if (self.selection) then
    if (isGuildAchievement(self.selection)) then
      if (not isUIInGuildView()) then  AchievementFrame_ToggleView();  end
    elseif (isUIInGuildView()) then
      AchievementFrame_ToggleView()
    end
  elseif (self.guildView_default) then
    if (not isUIInGuildView()) then  AchievementFrame_ToggleView();  end
  elseif (isUIInGuildView()) then
    AchievementFrame_ToggleView()
  end
end

local function clearSelection(frame)
-- Based on AchievementFrameAchievements_ClearSelection().
  AchievementButton_ResetObjectives();
  for _, button in next, frame.buttons do
    button:Collapse();
    if ( not button:IsMouseOver() ) then
      button.highlight:Hide();
    end
    button.selected = nil;
    if ( not button.tracked:GetChecked() ) then
      button.tracked:Hide();
    end
    button.description:Show();
    button.hiddenDescription:Hide();
  end

  frame.selection = nil;
  if (isUIInGuildView()) then  AchievementFrame_ToggleView();  end
end

local function selectButton(button)
  if (isUIInGuildView()) then
    if (not isGuildAchievement(button.id)) then
      AchievementFrame_ToggleView()
    end
  elseif (isGuildAchievement(button.id)) then
    AchievementFrame_ToggleView()
  end
-- Based on AchievementFrameAchievements_SelectButton().
  local achievements = getFrameOfButton(button);

  achievements.selection = button.id;
  achievements.selectionIndex = button.index;
  button.selected = true;
  SetFocusedAchievement(button.id)
end

local function isPreviousAchievementInUI(id)
  id = GetPreviousAchievement(id)
  if (id) then
    if (isAchievementInUI(id, false)) then  return true;  end
    return isPreviousAchievementInUI(id)
  end
end

local function AutoTrackIcon_OnEnter(self)
  GameTooltip:SetOwner(self, "ANCHOR_NONE")
  GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 10, 0)
  GameTooltip:AddLine(L.SUGGESTIONS_AUTOTRACKING_TIP, 1, 1, 1)
  GameTooltip:AddLine(L.SUGGESTIONS_AUTOTRACKING_TIP2)
  GameTooltip:Show()
end

local function AutoTrackIcon_OnLeave(self)
  GameTooltip:Hide()
end

local function setButtonGuildView(button, guildView)
-- Based on parts of AchievementFrameAchievements_ToggleView().
  if (guildView) then
    if (not button.Oa_guildView) then
      button.Oa_guildView = true
	local name = button:GetName();
	-- reset button info to get proper saturation/desaturation
	button.completed = nil;
	button.id = nil;
	-- title
	button.titleBar:SetAlpha(1);
	-- icon frame
	button.icon.frame:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Guild");
	button.icon.frame:SetTexCoord(0.25976563, 0.40820313, 0.50000000, 0.64453125);
	button.icon.frame:SetPoint("CENTER", 2, 2);
	-- tsunami
	local tsunami = _G[name.."BottomTsunami1"];
	tsunami:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Borders");
	tsunami:SetTexCoord(0, 0.72265, 0.58984375, 0.65234375);
	tsunami:SetAlpha(0.2);
	local tsunami = _G[name.."TopTsunami1"];
	tsunami:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Borders");
	tsunami:SetTexCoord(0.72265, 0, 0.65234375, 0.58984375);
	tsunami:SetAlpha(0.15);
	-- glow
	button.glow:SetTexCoord(0, 1, 0.26171875, 0.51171875);
    end
  elseif (button.Oa_guildView) then
    button.Oa_guildView = nil
	local name = button:GetName();
	-- reset button info to get proper saturation/desaturation
	button.completed = nil;
	button.id = nil;
	-- title
	button.titleBar:SetAlpha(0.8);
	-- icon frame
	button.icon.frame:SetTexture("Interface\\AchievementFrame\\UI-Achievement-IconFrame");
	button.icon.frame:SetTexCoord(0, 0.5625, 0, 0.5625);
	button.icon.frame:SetPoint("CENTER", -1, 2);
	-- tsunami
	local tsunami = _G[name.."BottomTsunami1"];
	tsunami:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Borders");
	tsunami:SetTexCoord(0, 0.72265, 0.51953125, 0.58203125);
	tsunami:SetAlpha(0.35);
	local tsunami = _G[name.."TopTsunami1"];
	tsunami:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Borders");
	tsunami:SetTexCoord(0.72265, 0, 0.58203125, 0.51953125);
	tsunami:SetAlpha(0.3);
	-- glow
	button.glow:SetTexCoord(0, 1, 0.00390625, 0.25390625);
  end
end

local function displayAchievement(button, frame, achievement, index, selectionID)
-- This function is based on AchievementButton_DisplayAchievement, with only a few alterations as needed.
-- Things to always do before calling this:  Overachiever.RecentReminders_Check()  AND  In_Guild_View = isUIInGuildView()
-- To do after calling this:  delayedToggleView()
  --local StartTime
  --if (Overachiever_Debug) then  StartTime = debugprofilestop(); print("displayAchievement:"..(achievement or "nil"))  end

  local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy
  if (achievement) then
    id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy = GetAchievementInfo(achievement);
    --if (Overachiever_Debug) then  print("GetAchievementInfo("..achievement..") took "..(debugprofilestop() - StartTime) .." ms.");  end
  end
  if ( not id ) then
    button:Hide();
    return;
  else
    button:Show();
  end

  button.index = index;
  button.element = true;

  --if (Overachiever_Debug) then  print("- Next bit took "..(debugprofilestop() - StartTime) .." ms."); StartTime = debugprofilestop();  end

  if ( button.id ~= id ) then
    local saturatedStyle;
    if ( bit.band(flags, ACHIEVEMENT_FLAGS_ACCOUNT) == ACHIEVEMENT_FLAGS_ACCOUNT ) then
      button.accountWide = true;
      saturatedStyle = "account";
    else
      button.accountWide = nil;
      if ( In_Guild_View ) then
        saturatedStyle = "guild";
      else
        saturatedStyle = "normal";
      end
    end

    local guildach = isGuildAchievement(id)
    setButtonGuildView(button, guildach)
    if (In_Guild_View) then
      if (not guildach) then
        AchievementFrame_ToggleView()
        In_Guild_View = nil
      end
    elseif (guildach) then
      AchievementFrame_ToggleView()
      In_Guild_View = true
    end

    button.id = id;
    button.label:SetWidth(ACHIEVEMENTBUTTON_LABELWIDTH);
    button.label:SetText(name)

    if ( GetPreviousAchievement(id) ) then
      -- If this is a progressive achievement, show the total score.
      AchievementShield_SetPoints(AchievementButton_GetProgressivePoints(id), button.shield.points, AchievementPointsFont, AchievementPointsFontSmall);
    else
      AchievementShield_SetPoints(points, button.shield.points, AchievementPointsFont, AchievementPointsFontSmall);
    end
    if ( points > 0 ) then
      button.shield.icon:SetTexture([[Interface\AchievementFrame\UI-Achievement-Shields]]);
    else
      button.shield.icon:SetTexture([[Interface\AchievementFrame\UI-Achievement-Shields-NoPoints]]);
    end

    if ( isGuild ) then
      button.shield.points:Show();
      button.shield.wasEarnedByMe = nil;
      button.shield.earnedBy = nil;
    else
      button.shield.wasEarnedByMe = not (completed and not wasEarnedByMe);
      button.shield.earnedBy = earnedBy;
    end

    button.description:SetText(description);
    button.hiddenDescription:SetText(description);
    button.numLines = ceil(button.hiddenDescription:GetHeight() / ACHIEVEMENTUI_FONTHEIGHT);
    button.icon.texture:SetTexture(icon);
    if ( completed or wasEarnedByMe ) then
      button.completed = true;
      button.dateCompleted:SetText(string.format(SHORTDATE, day, month, year));
      button.dateCompleted:Show();
      button:Saturate();
      if ( button.saturatedStyle ~= saturatedStyle ) then
        button:Saturate();
      end
    else
      button.completed = nil;
      button.dateCompleted:Hide();
      button:Desaturate();
      -- Overachiever color customization:
      local RecentReminders = Overachiever.RecentReminders
      -- Make sure Overachiever.RecentReminders_Check() was called before displayAchievement(...) for this:
      if (RecentReminders and RecentReminders[id]) then
        local name = button:GetName()
        --button:SetBackdropBorderColor(.8, .5, .5)
        _G[name .. "Background"]:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\ParchmentDesaturateGreen")
        _G[name.."Glow"]:SetVertexColor(.13, .52, .17)
      elseif (not isAchievementInUI(id, false)) then
        local name = button:GetName()
        --button:SetBackdropBorderColor(.8, .5, .5)
        if (isPreviousAchievementInUI(id)) then
          _G[name .. "Background"]:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\ParchmentDesaturateBlue")
          _G[name.."Glow"]:SetVertexColor(.22, .17, .43)
        else
          _G[name .. "Background"]:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\ParchmentDesaturateRed")
          _G[name.."Glow"]:SetVertexColor(.52, .17, .13)
        end
      end
    end

    if ( rewardText == "" ) then
      button.reward:Hide();
      button.rewardBackground:Hide();
    else
      button.reward:SetText(rewardText);
      button.reward:Show();
      button.rewardBackground:Show();
      if ( button.completed ) then
        button.rewardBackground:SetVertexColor(1, 1, 1);
      else
        button.rewardBackground:SetVertexColor(0.35, 0.35, 0.35);
      end
    end

    if ( IsTrackedAchievement(id) ) then
      button.check:Show();
      button.label:SetWidth(button.label:GetStringWidth() + 4);
      button.tracked:SetChecked(true);
      button.tracked:Show();
    else
      button.check:Hide();
      button.tracked:SetChecked(false);
      button.tracked:Hide();
    end
  end

  if ( id == selectionID ) then
    frame.selection = button.id;
    frame.selectionIndex = button.index;
    button.selected = true;
    button.highlight:Show();
    local height = AchievementButton_DisplayObjectives(button, button.id, button.completed);
    if ( height == ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT ) then
      button:Collapse();
    else
      button:Expand(height);
    end
    if ( not completed or (not wasEarnedByMe and not isGuild) ) then
      button.tracked:Show();
    end
  elseif ( button.selected ) then
    button.selected = nil;
    if ( not button:IsMouseOver() ) then
      button.highlight:Hide();
    end
    button:Collapse();
    button.description:Show();
    button.hiddenDescription:Hide();
  end

  if (frame.ShouldCrossOut and frame.ShouldCrossOut(id)) then
    if (not button.CrossOut) then
      button.CrossOut = CreateFrame("frame", nil, button) --button.icon
  	  local overPos = button --alternatively: button.shield OR button.icon
  	  local tl = button.CrossOut:CreateTexture(nil, "OVERLAY", nil, 5) --, 1)
  	  button.CrossOut.Left = tl
  	  tl:SetPoint("CENTER", overPos)
  	  tl:SetAtlas("GarrMission_EncounterBar-Xleft")
  	  tl:SetHeight(72) --48
  	  tl:SetWidth(72) --48
  	  local tr = button.CrossOut:CreateTexture(nil, "OVERLAY", nil, 1)
  	  button.CrossOut.Right = tr
  	  tr:SetPoint("CENTER", overPos)
  	  tr:SetAtlas("GarrMission_EncounterBar-Xright")
  	  tr:SetHeight(72)
  	  tr:SetWidth(72)
  	end
    button.CrossOut:Show()
  elseif (button.CrossOut) then
    button.CrossOut:Hide()
  end

  if (frame.ShouldAutoTrack and frame.ShouldAutoTrack(id)) then
    if (not button.AutoTrackIcon) then
      --local icon = CreateFrame("frame", nil, button)
      local icon = CreateFrame("Button", nil, button)
      icon:SetWidth(32); icon:SetHeight(32)
      icon:SetPoint("TOPLEFT", button, "TOPLEFT", 142, -9)
      local tex = icon:CreateTexture(nil, "BACKGROUND")
      tex:SetTexture("Interface\\Minimap\\Tracking\\None") --tex:SetTexture(136460)
      tex:SetPoint("CENTER", icon, "CENTER", 0, 0)
      icon.tex = tex
      --icon:EnableMouse(true)
      icon:SetMouseMotionEnabled(true)
      icon:SetScript("OnEnter", AutoTrackIcon_OnEnter)
      icon:SetScript("OnLeave", AutoTrackIcon_OnLeave)
      icon:SetMouseClickEnabled(false) -- Have to put this after SetScript calls or it gets reverted.
      icon:SetScale(0.65)
      button.AutoTrackIcon = icon
  	end
    button.AutoTrackIcon:Show()
  elseif (button.AutoTrackIcon) then
    button.AutoTrackIcon:Hide()
  end

  --if (Overachiever_Debug) then  print("- Last bit took for \""..name.."\" took "..(debugprofilestop() - StartTime) .." ms.");  end

  return id;
end


local sortList
do
  local getret
  local select = select

  local function sortList_simple(a, b, aOverrideV, bOverrideV)
    local aV = aOverrideV or select(getret, GetAchievementInfo(a))
    local bV = bOverrideV or select(getret, GetAchievementInfo(b))
    if (aV == nil) then
      a, getret = tostringall(a, getret)
      error("nil value found while sorting: ID="..a..", getret="..getret)
    elseif (bV == nil) then
      b, getret = tostringall(b, getret)
      error("nil value found while sorting: ID="..b..", getret="..getret)
    end

    -- If values are the same, fall back to alphabetical order by name:
    if (aV == bV) then
      local aID, bID
      aID, aV = GetAchievementInfo(a)
      bID, bV = GetAchievementInfo(b)
      -- If names are the same, fall back to ID:
      if (aV == bV) then
        aV, bV = aID, bID
      end
    end
    if (type(aV) == "string") then
    -- Handle things so, e.g., "200 Daily Quests Complete" comes before "1000 Daily Quests Complete":
      local numA, textA = aV:match("([^%s]+) (.+)")
      numA = tonumber(numA)
      if (numA) then
        local numB, textB = bV:match("([^%s]+) (.+)")
        numB = tonumber(numB)
        if (numB) then
          if (numA ~= numB) then  return numA < numB;  end
          return textA < textB
        end
      end
    end
    return aV < bV
  end

  local function sortList_date(a, b)
    local aM, aD, aY = select(5, GetAchievementInfo(a))
    local bM, bD, bY = select(5, GetAchievementInfo(b))
    if (aM and bM) then  -- Both achievements are completed
      if (aY < bY) then
        return true
      elseif (aY > bY) then
        return false
      elseif (aM < bM) then
        return true
      elseif (aM > bM) then
        return false
      elseif (aD < bD) then
        return true
      elseif (aD > bD) then
        return false
      end
    elseif (aM) then  -- A is complete; B is not
      return true
    elseif (bM) then  -- B is complete; A is not
      return false
    end
    -- If dates are the same or neither is complete, fall back to alphabetical order by name:
    getret = 2
    return sortList_simple(a, b)
  end

  local function sortList_points(a, b)
    local aP = AchievementButton_GetProgressivePoints(a)
    local bP = AchievementButton_GetProgressivePoints(b)
    --This should have been set properly already to avoid doing it here repeatedly: getret = 3
    return sortList_simple(a, b, aP, bP)
  end

  local function sortList_relation(a, b)
    local r = Overachiever.RelatedTab_Compare(a, b)
	if (r < 0) then
	  return true
	elseif (r > 0) then
	  return false;
	end
	-- Fall back to ID:
	return a < b
  end

  function sortList(list, mode)
    if (#list < 2) then
      return list
    elseif (mode == 1) then  -- Date completed
      sort(list, sortList_date)
    elseif (mode == 2) then  -- Points
      getret = 3;
      sort(list, sortList_points)
    elseif (mode == 3) then  -- ID
      sort(list)  -- ID already given in the table, so default sort can handle this.
    elseif (mode == 4) then  -- Relation
      sort(list, sortList_relation)
    else  -- Name (mode 0, default)
      getret = 2
      sort(list, sortList_simple)
    end
  end
end

local FilteredList, FilteredList_current
local function applyAchievementFilter(list, completed, built, checkprev, critlist)
  FilteredList = FilteredList or {}
  local list2 = FilteredList[list]
  if (list2) then
    if (built and FilteredList_current[list] == completed) then  return list2;  end
    wipe(list2)
  else
    FilteredList[list] = {}
    list2 = FilteredList[list]
  end
  local count, _, c = 0
  for i,id in pairs(list) do  -- Using pairs instead of ipairs so we can safely nil things out.
    _, _, _, c = GetAchievementInfo(id)
    if (not c and critlist and critlist[id]) then
      _, _, c = GetAchievementCriteriaInfo(id, critlist[id])
    end
    if (c == completed) then
      count = count + 1
      list2[count] = id
    elseif (checkprev and completed) then
    -- If we're listing complete achievements and this one is incomplete but it's in a series where the previous
    -- one is complete, then we can display that one instead. This option is used by the Suggestions tab.
      local prev = GetPreviousAchievement(id)
      if (prev) then
        _, _, _, c = GetAchievementInfo(prev)
        -- We don't need to go any deeper than one previous, since the Suggestions by default finds the first
        -- incomplete one (or the last one in the series, if all are complete).
        if (c) then
          count = count + 1
          list2[count] = prev
        end
      end
    end
  end
  FilteredList_current = FilteredList_current or {}
  FilteredList_current[list] = completed
  return list2
end

local function updateAchievementsList(frame)
  --local StartTime
  --if (Overachiever_Debug) then  StartTime = debugprofilestop(); print("updateAchievementsList",frame:GetName());  end

  local list, sorted = frame.AchList, frame.AchList_sorted
  if (ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrame_GetCategoryNumAchievements_Complete) then
    list = applyAchievementFilter(list, true, sorted, frame.AchList_checkprev, frame.AchList_criteria)
  elseif (ACHIEVEMENTUI_SELECTEDFILTER == AchievementFrame_GetCategoryNumAchievements_Incomplete) then
    list = applyAchievementFilter(list, false, sorted, frame.AchList_checkprev, frame.AchList_criteria)
  end
  if (not sorted) then
    sortList(list, frame.sort)
    frame.AchList_sorted = true
  end
-- This function based on AchievementFrameAchievements_Update in Blizzard_AchievementUI.lua.
  local scrollFrame = frame.scrollFrame
  local offset = HybridScrollFrame_GetOffset(scrollFrame);
  local buttons = scrollFrame.buttons;
  local numAchievements = #list
  local numButtons = #buttons;

  local selection = frame.selection;
  if ( selection ) then
    AchievementButton_ResetObjectives();
  end

  local extraHeight = scrollFrame.largeButtonHeight or ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT

  Overachiever.RecentReminders_Check()
  In_Guild_View = isUIInGuildView()
  local displayedHeight, index = 0;
  for i = 1, numButtons do
    index = i + offset
    displayAchievement(buttons[i], frame, list[index], index, selection);
    displayedHeight = displayedHeight + buttons[i]:GetHeight();
  end
  delayedToggleView()

  local totalHeight = numAchievements * ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT;
  totalHeight = totalHeight + (extraHeight - ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT);

  HybridScrollFrame_Update(scrollFrame, totalHeight, displayedHeight);

  if ( selection ) then
    frame.selection = selection;
  else
    HybridScrollFrame_CollapseButton(scrollFrame);
  end

  if (frame.SetNumListed) then  frame.SetNumListed(numAchievements);  end

  --if (Overachiever_Debug) then  print("- Took "..(debugprofilestop() - StartTime)/1000 .." seconds.");  end
end

local function forceUpdate(frame, keepSelection, fromHook)
-- Based on AchievementFrameAchievements_ForceUpdate:
  if ( not keepSelection and frame.selection ) then
    local nextID = GetNextAchievement(frame.selection);
    local id, _, _, completed = GetAchievementInfo(frame.selection);
    if ( nextID and completed ) then
      frame.selection = nil;
    end
  end
  if (not fromHook) then
  -- Don't do these when called by forceUpdate_all because they are handled by
  -- AchievementFrameAchievements_ForceUpdate and shouldn't occur again:
    AchievementFrameAchievementsObjectives:Hide();
    AchievementFrameAchievementsObjectives.id = nil;
  end

  local buttons = frame.scrollFrame.buttons;
  for i, button in next, buttons do
    button.id = nil;
  end

  frame.AchList_sorted = nil
  if (frame:IsShown()) then  updateAchievementsList(frame);  end
end

local function forceUpdate_all()
  for k,tab in ipairs(tabs) do
    forceUpdate(tab.frame, nil, true)
  end
end

local function tabUnselect()
  --print("tabUnselect",tabselected and tabselected.tab.text:GetText() or "nil")
  prevtab = tabselected
  tabselected = nil
  -- for k,tab in ipairs(tabs) do
  --   tab.text:SetPoint("CENTER", tab, "CENTER", 0, -3)
  -- end
end

local tabOnClick
do
  local true_clickedTab
  AchievementFrame_UpdateTabs = function(clickedTab, ...) -- Based on AchievementFrame_UpdateTabs, which we're overwriting:
    clickedTab = true_clickedTab or clickedTab --Overachiever: Added this line
    PanelTemplates_Tab_OnClick(_G["AchievementFrameTab"..clickedTab], AchievementFrame);
    local tab;
    for i = 1, 99 do --Overachiever: Increased max from 3 to 99
    tab = _G["AchievementFrameTab"..i];
      if (not tab) then  break;  end --Overachiever: Added this line
      if ( i == clickedTab ) then
        tab.text:SetPoint("CENTER", 0, -5);
      else
        tab.text:SetPoint("CENTER", 0, -3);
      end
    end
  end

  function tabOnClick(self, button)
    true_clickedTab = self:GetID()
    AchievementFrameBaseTab_OnClick(1) -- This will handle some possibly-necessary toggling of views, etc. (Have to use 1 instead of the proper tab ID because the function treats 4+ the same as it would 3 (statistics) instead of 1 (normal achievements listing).)
    true_clickedTab = nil

    -- Don't play sound when this is a silentDisplay or Overachiever.OpenTab_frame call.
    if (button) then  PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB);  end

    if (self.flash and UIFrameIsFading(self.flash)) then
      UIFrameFlashRemoveFrame(self.flash)
      self.flash:Hide()
    end

    tabselected = self.frame
    AchievementFrame_ShowSubFrame(self.frame, LeftFrame)
    LeftFrame.label:SetText(self:GetText())

	-- Working around a strange bug where the Help Icon -- or its texture (if not the frame itself) -- floats on its own.
	-- Problem seems to only happen when Make Draggable option is checked.
	--LeftFrame.helpIcon:ClearAllPoints()
	--LeftFrame.helpIcon:SetPoint("LEFT", LeftFrame.label, "RIGHT", 4, 0)
	LeftFrame.helpIcon.tex:ClearAllPoints()
	LeftFrame.helpIcon.tex:SetPoint("CENTER", LeftFrame.helpIcon, "CENTER", 0, 0)
	-- End workaround. Hopefully, whatever bug is causing this will be fixed and this workaround will be unnecessary soon.

    AchievementFrameWaterMark:SetTexture(self.watermark) -- Note: nil actually works here for watermark texture. No error; just no visible watermark!
    --PanelTemplates_Tab_OnClick(self, AchievementFrame)  -- Not needed here any more: AchievementFrame_UpdateTabs, called by AchievementFrameBaseTab_OnClick, will call it.
    updateAchievementsList(self.frame)
  end
end

local function silentDisplay(button)
  tabOnClick(getFrameOfButton(button).tab)
end

local orig_compheader_OnShow
local function compheader_OnShow(...)
  -- Prevent comparison portrait from reverting to player's when you switch tabs while comparing achievements:
  if (not tabselected) then  orig_compheader_OnShow(...);  end
end

local function achbtnOnClick(self, button, ignoreModifiers)
  local frame = getFrameOfButton(self)
  if (frame.HandleAchBtnClick and frame.HandleAchBtnClick(self, button, ignoreModifiers)) then
    return;
  end
  if (button == "RightButton") then  return;  end

  local id = self.id
  if ( IsShiftKeyDown() and IsControlKeyDown() and Overachiever.OpenRelatedTab ) then
    Overachiever.OpenRelatedTab(id)
	return;
  --elseif ( IsControlKeyDown() and (GetPreviousAchievement(id) or isAchievementInUI(id, true, true)) ) then
  elseif ( IsControlKeyDown() and isAchievementInUI(id, true, true) ) then -- GetPreviousAchievement no longer needed since isAchievementInUI checks previous
    Overachiever.UI_SelectAchievement(id, silentDisplay, self)
    return;
  elseif (Overachiever_WatchFrame and IsAltKeyDown()) then
    Overachiever_WatchFrame.SetAchWatchList(id, tabselected ~= Overachiever_WatchFrame)
    return;
  end

  -- This section based on the AchievementButton_OnClick function in Blizzard_AchievementUI.lua:
  if (IsModifiedClick() and not ignoreModifiers) then
  	local handled = nil;
	if ( IsModifiedClick("CHATLINK") ) then
		local achievementLink = GetAchievementLink(self.id);
		if ( achievementLink ) then
			handled = ChatEdit_InsertLink(achievementLink);
			if ( not handled and SocialPostFrame and Social_IsShown() ) then
				Social_InsertLink(achievementLink);  -- Can this introduce taint??
				handled = true;
			end
		end
	end
	if ( not handled and IsModifiedClick("QUESTWATCHTOGGLE") ) then
		AchievementButton_ToggleTracking(self.id);
	end
	return;
--[[ Pre Overachiever 1.0 (released with WoW 8.0, though some changes made were to catch up with previous changes):
  if (IsModifiedClick()) then
    if ( IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() ) then
      local achievementLink = GetAchievementLink(self.id);
      if ( achievementLink ) then
        ChatEdit_InsertLink(achievementLink);
      end
    elseif ( IsModifiedClick("QUESTWATCHTOGGLE") ) then
      AchievementButton_ToggleTracking(self.id);
    end
    return;
--]]
  end

  local frame = getFrameOfButton(self)
  if ( self.selected ) then
    if ( not self:IsMouseOver() ) then
      self.highlight:Hide();
    end
    clearSelection(frame)
    HybridScrollFrame_CollapseButton(frame.scrollFrame);
    updateAchievementsList(frame);
    return;
  end
  clearSelection(frame)
  selectButton(self);
  Overachiever.RecentReminders_Check()
  In_Guild_View = isUIInGuildView()
  displayAchievement(self, frame, self.id, self.index, self.id)
  HybridScrollFrame_ExpandButton(frame.scrollFrame, ((self.index - 1) * ACHIEVEMENTBUTTON_COLLAPSEDHEIGHT), self:GetHeight());
  delayedToggleView()
  updateAchievementsList(frame)
end

local redir_btn_tinsert
local function post_AchievementButton_OnLoad(self)
  if (redir_btn_tinsert) then
    self:SetScript("OnClick", achbtnOnClick)
    local shield = _G[self:GetName().."Shield"]
    shield:SetScript("OnClick", click_parent)
    tinsert(redir_btn_tinsert, self);
    -- Our button isn't put into this table as of WoW 4.0.1, so this line is unneeded:
    -- tremove(AchievementFrameAchievementsContainer.buttons);

	-- Add right click feature:
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	--shield:RegisterForClicks("LeftButtonUp", "RightButtonUp")

    if ( not ACHIEVEMENTUI_FONTHEIGHT ) then
      local _, fontHeight = self.description:GetFont();
      ACHIEVEMENTUI_FONTHEIGHT = fontHeight;
    end
  end
end

local function ListFrame_OnShow(self)
  self.panel:Show()
  AchievementFrame_SetFilter( FilterByTab[self] or ACHIEVEMENT_FILTER_ALL, true )
  delayedToggleView()
end

local function ListFrame_OnHide(self)
  self.panel:Hide()
end


function Overachiever.BuildNewTab(name, text, watermark, helptip, loadFunc, filter)
  local numtabs, tab = 0
  repeat
    numtabs = numtabs + 1
  until (not _G["AchievementFrameTab"..numtabs])
  tab = CreateFrame("Button", "AchievementFrameTab"..numtabs, AchievementFrame, "AchievementFrameTabButtonTemplate")
  tab:SetText(text)
  tab:SetPoint("LEFT", "AchievementFrameTab"..numtabs-1, "RIGHT", -5, 0)
  tab:SetID(numtabs)
  PanelTemplates_SetNumTabs(AchievementFrame, numtabs)

  local frame = CreateFrame("Frame", name, AchievementFrame)
  frame:SetWidth(504); frame:SetHeight(440)
  frame:SetPoint("TOPLEFT", AchievementFrameAchievements, "TOPLEFT", 0, 0)
  frame:SetPoint("BOTTOM", AchievementFrameAchievements, "BOTTOM")
  local frameBG = frame:CreateTexture("$parentBackground", "BACKGROUND")
  frameBG:SetTexture("Interface\\AchievementFrame\\UI-Achievement-AchievementBackground")
  frameBG:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, -3)
  frameBG:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, 3)
  frameBG:SetTexCoord(0, 1, 0, 0.5)
  local frameBGDarken = frame:CreateTexture(nil, "ARTWORK")
  frameBGDarken:SetAllPoints(frameBG)
  frameBGDarken:SetColorTexture(0, 0, 0, 0.75)
  local frameBorder = CreateFrame("Frame", nil, frame, "BackdropTemplate")
  frameBorder:SetAllPoints(frame)
  frameBorder:SetBackdrop( {
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 5, right = 5, top = 5, bottom = 5 }
  } )
  frameBorder:SetBackdropBorderColor(ACHIEVEMENTUI_GOLDBORDER_R, ACHIEVEMENTUI_GOLDBORDER_G, ACHIEVEMENTUI_GOLDBORDER_B, ACHIEVEMENTUI_GOLDBORDER_A)
  frameBorder:SetFrameLevel(frameBorder:GetFrameLevel()+1)

  local scrollframe = CreateFrame("ScrollFrame", "$parentContainer", frame, "HybridScrollFrameTemplate")
  scrollframe:SetWidth(504); scrollframe:SetHeight(440)
  scrollframe:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -3)
  scrollframe:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 5)
  local scrollbar = CreateFrame("Slider", "$parentScrollBar", scrollframe, "HybridScrollBarTemplate")
  scrollbar:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 1, -16)
  scrollbar:SetPoint("BOTTOMLEFT", scrollframe, "BOTTOMRIGHT", 1, 12)
  frame.scrollFrame = scrollframe
  frame.scrollbar = scrollbar

  scrollbar.Show =
    function (self)
      frame:SetWidth(504);
      for _, button in next, frame.buttons do
        button:SetWidth(496);
      end
      getmetatable(self).__index.Show(self);
    end

  scrollbar.Hide =
    function (self)
      frame:SetWidth(530);
      for _, button in next, frame.buttons do
        button:SetWidth(522);
      end
      getmetatable(self).__index.Hide(self);
    end

	local frameWarning = CreateFrame("Frame", nil, frame)
	frameWarning:SetPoint("BOTTOM", frame, "BOTTOM", 0, 3)
	frameWarning:SetWidth(520)  -- 492  490
	frameWarning:SetHeight(26)
	frameWarning:SetFrameLevel(frameWarning:GetFrameLevel() + 2)
	frameWarning.tex = frameWarning:CreateTexture("$parentBackground", "BACKGROUND")
	frameWarning.tex:SetColorTexture(0.025, 0.025, 0.025, 0.75)
	frameWarning.tex:SetAllPoints()
	frameWarning:Hide()
	frame.frameWarning = frameWarning

	local filteredOutLabel = frameWarning:CreateFontString(nil, "HIGH", "GameFontGreen") --"GameFontNormal" "GameFontHighlight"
	filteredOutLabel:SetPoint("CENTER", frameWarning, "CENTER", 0, 0)
	filteredOutLabel:SetWidth(490)
	--filteredOutLabel:Font:SetTextColor(r, g, b, a)
	--filteredOutLabel:SetShadowColor(1, 0, 0, 1)
	frameWarning.label = filteredOutLabel

	local function scollbarValueChange(self, value, ...)
		local vmin, vmax = self:GetMinMaxValues()
		local prev = frameWarning.top
		--local new = (value >= (vmax / 2))
		local new = (value >= vmax - 20)
		if (prev ~= new) then
			frameWarning.top = new
			frameWarning:ClearAllPoints()
			if (new) then
				frameWarning:SetPoint("TOP", frame, "TOP", 0, -3)
			else
				frameWarning:SetPoint("BOTTOM", frame, "BOTTOM", 0, 3)
			end
		end
	end
	scrollbar:HookScript("OnValueChanged", scollbarValueChange)

	scrollbar:HookScript("OnShow", function(self)
		frameWarning:SetWidth(492)
		--scollbarValueChange(self, self:GetValue()) -- Might be needed to fix a bug where the warning message appears at the top of the window when it should be at the bottom. But, after running into the issue once, I couldn't reproduce the problem, so disabling for now since I can't test whether this helps or even hurts.
	end)

	scrollbar:HookScript("OnHide", function(self)
		frameWarning:SetWidth(520)
	end)


  tinsert(ACHIEVEMENTFRAME_SUBFRAMES, name)

  tab.watermark, tab.loadFunc = watermark, loadFunc
  tab.frame = frame
  frame.tab = tab
  frame.helptip = helptip

  tab:SetScript("OnClick", tabOnClick)
  if (not tabs) then
    tabs = {}
    hooksecurefunc("AchievementFrameBaseTab_OnClick", tabUnselect)
    hooksecurefunc("AchievementFrameComparisonTab_OnClick", tabUnselect)
    orig_compheader_OnShow = AchievementFrameComparisonHeader:GetScript("OnShow")
    AchievementFrameComparisonHeader:SetScript("OnShow", compheader_OnShow)
    hooksecurefunc("AchievementButton_OnLoad", post_AchievementButton_OnLoad)
    hooksecurefunc("AchievementFrameAchievements_ForceUpdate", forceUpdate_all)
  end
  tabs[#(tabs)+1] = tab
  frame.AchList = {}
  frame.ForceUpdate = forceUpdate

  scrollframe.update = function() updateAchievementsList(frame) end;  -- Needed in this fashion for HybridScrollFrame_SetOffset calls.
  _G[name.."ContainerScrollBarBG"]:Show()
  frame.buttons = {}
  redir_btn_tinsert = frame.buttons
  HybridScrollFrame_CreateButtons(scrollframe, "AchievementTemplate", 0, -2);
  redir_btn_tinsert = nil
  Overachiever.UI_HookAchButtons(frame.buttons, scrollbar)

  local panel = CreateFrame("Frame", nil, LeftFrame)
  panel:SetPoint("TOPLEFT", LeftFrame.label, "BOTTOMLEFT", 0, -6)
  panel:SetPoint("RIGHT", LeftFrame, "RIGHT")
  panel:SetPoint("BOTTOM", LeftFrame, "BOTTOM")
  panel:Hide()
  frame.panel = panel
  frame:Hide()
  frame:SetScript("OnShow", ListFrame_OnShow)
  frame:SetScript("OnHide", ListFrame_OnHide)

  FilterByTab[frame] = filter

  if (varsLoaded and tab.loadFunc) then
	local v = Overachiever_Tabs_Settings
	local vc = Overachiever_Tabs_CharVars
	local AchFilters = v.AchFilters
	if (AchFilters[name]) then  FilterByTab[tab.frame] = AchFilters[name];  end
	tab.loadFunc(v, oldver, vc)
	tab.loadFunc = nil
  end

  function frame:GetAchList(unfiltered)
    if (not unfiltered and FilteredList and FilteredList[self.AchList]) then
	  return FilteredList[self.AchList]
	end
	return self.AchList
  end

  return frame, panel
end

function Overachiever.OpenTab_frame(frame, makeSound)
  tabOnClick(frame.tab, makeSound and "LeftButton" or nil)
end


local HelpIcon_OnEnter

local function HelpIcon_OnUpdate(self)
  local shiftKey = IsShiftKeyDown() and true or false
  if (self.shiftKey ~= shiftKey) then
    HelpIcon_OnEnter(self)
  end
end

function HelpIcon_OnEnter(self)
  local shiftKey = IsShiftKeyDown() and true or false
  self.tex:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\HelpIconHighlight")
  GameTooltip:SetOwner(self, "ANCHOR_NONE")
  GameTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 10, 0)
  GameTooltip:AddLine(self.tip:format(tabselected.tab:GetText()), 1, 1, 1)
  --GameTooltip:AddLine(" ")
  GameTooltip:AddLine(tabselected.helptip, nil, nil, nil, 1)
  GameTooltip:AddLine(" ")
  if (shiftKey) then
    GameTooltip:AddLine(L.TAB_HELP, nil, nil, nil, 1)
  else
    GameTooltip:AddLine(L.TAB_HELP_LESS, nil, nil, nil, 1)
  end
  GameTooltip:Show()
  if (self.shiftKey == nil) then
    self:SetScript("OnUpdate", HelpIcon_OnUpdate)
  end
  self.shiftKey = shiftKey
end

local function HelpIcon_OnLeave(self)
  self.tex:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\HelpIcon")
  GameTooltip:Hide()
  self:SetScript("OnUpdate", nil)
  self.shiftKey = nil
end

local function LeftFrame_OnShow(self)
  AchievementFrameCategoriesContainer:Hide()
  AchievementFrameCategoriesContainerScrollBar:Hide()
  AchievementFrameFilterDropDown:Show()
  AchievementFrameHeaderLeftDDLInset:Show()
  --AchievementFrameHeaderRightDDLInset:Show()
end

local function LeftFrame_OnHide(self)
  AchievementFrameCategoriesContainer:Show()
  if (not AchievementFrameAchievements:IsShown()) then
    AchievementFrameFilterDropDown:Hide()
	AchievementFrameHeaderLeftDDLInset:Hide()
    --AchievementFrameHeaderRightDDLInset:Hide()
  end
  if (not Overachiever.NoAlterSetFilter) then
    AchievementFrame_SetFilter( FilterByTab[AchievementFrameAchievements] or ACHIEVEMENT_FILTER_ALL, true )
  end
end

local LeftFrame_OnEvent, LeftFrame_OnUpdate
local recolor_AchievementObjectives_DisplayCriteria
do
  local time, last, isSet = time, 0

  -- Meta-criteria recolor:
  function recolor_AchievementObjectives_DisplayCriteria(objectivesFrame, id)
    --if (isSet or not id or GetPreviousAchievement(id) or isAchievementInUI(id, true)) then  return;  end
	if (isSet or not id or isAchievementInUI(id, true)) then  return;  end -- GetPreviousAchievement is now redundant with isAchievementInUI
    -- Checking for isSet like this means we "ignore" calls when CRITERIA_UPDATE events have been detected until
    -- the OnUpdate function clears it. Since the OnUpdate func calls AchievementButton_DisplayObjectives
    -- which in turn calls AchievementObjectives_DisplayCriteria which will in turn trigger this function (since
    -- it should be hooked to it), this simple check should be all that's needed to throttle this function.
    -- (Throttling is required in the first place because the default achievement UI responds to CRITERIA_UPDATE by
    -- calling AchievementButton_DisplayObjectives.)
    -- Known issue: Since recolors are throttled, the wrong color may display for some meta-criteria for a couple
    -- of seconds but this should only be noticeable if you're in the UI looking at one of the few relevant
    -- achievements while in combat or otherwise triggering AchievementObjectives_DisplayCriteria repeatedly.
    local metaCriteria, index = AchievementFrameMeta1, 1
    while (metaCriteria and metaCriteria:IsShown()) do
      --if (not GetPreviousAchievement(metaCriteria.id) and not isAchievementInUI(metaCriteria.id, true)) then
      if (not isAchievementInUI(metaCriteria.id, true)) then -- GetPreviousAchievement is redundant
        metaCriteria.label:SetTextColor(.9, .4, .4, 1)
      end
      index = index + 1
      metaCriteria = _G["AchievementFrameMeta"..index]
    end
  end

  local function LeftFrame_OnUpdate(self) -- Throttled response to CRITERIA_UPDATE, only happens if LeftFrame is shown:
    if (time() < last + 2) then  return;  end
    last = time()
    isSet = nil
    self:SetScript("OnUpdate", nil)
    for k,tab in ipairs(tabs) do
      local frame = tab.frame
      if ( tabselected == frame and frame.selection ) then
-- Based on part of AchievementFrameAchievements_OnEvent.
        local id = AchievementFrameAchievementsObjectives.id;
        local button = AchievementFrameAchievementsObjectives:GetParent();
        AchievementFrameAchievementsObjectives.id = nil;
        -- if ( self:IsVisible() ) then    -- this visibility check was added to WoW's UI code, but it shouldn't
	--         be necessary here because LeftFrame_OnUpdate should only be called when it's visible anyway.
          AchievementButton_DisplayObjectives(button, id, button.completed);
          updateAchievementsList(frame)
        -- end
        return; -- This only needs to happen once, no matter which frame it is that's currently shown.
      end
    end
  end

  function LeftFrame_OnEvent(self, event, arg1, ...)
    if (event == "CRITERIA_UPDATE") then
      if (isSet) then  return;  end
      self:SetScript("OnUpdate", LeftFrame_OnUpdate)
      isSet = true
	--[[ Handled by TjAcheive now:
	elseif (event == "ACHIEVEMENT_EARNED") then
      isAchievementInUI_cache[arg1] = nil
	  local failsafe = 0
      local nextID = GetNextAchievement(arg1)
      while (nextID and failsafe < 100) do
        isAchievementInUI_cache[nextID] = nil
        nextID = GetNextAchievement(nextID)
		failsafe = failsafe + 1
      end
	--]]
    end
  end

end


do
  LeftFrame = CreateFrame("Frame", "Overachiever_LeftFrame", AchievementFrameCategories)
  LeftFrame:SetPoint("TOPLEFT", AchievementFrameCategories, "TOPLEFT", 9, -5)
  LeftFrame:SetPoint("TOPRIGHT", AchievementFrameCategories, "TOPRIGHT", -9, -5)
  LeftFrame:SetPoint("BOTTOM", AchievementFrameCategories, "BOTTOM", 0, 8)

  local label = LeftFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
  label:SetPoint("TOPLEFT", LeftFrame, "TOPLEFT", 1, -6)
  label:SetText("Overachiever")
  LeftFrame.label = label

  local HelpIcon = CreateFrame("Frame", nil, LeftFrame)
  HelpIcon:SetWidth(32); HelpIcon:SetHeight(32)
  HelpIcon:SetPoint("LEFT", label, "RIGHT", 4, 0)
  local tex = HelpIcon:CreateTexture(nil, "BACKGROUND")
  tex:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\HelpIcon")
  tex:SetPoint("CENTER", HelpIcon, "CENTER", 0, 0)
  HelpIcon.tex = tex
  HelpIcon:EnableMouse(true)
  HelpIcon:SetScript("OnEnter", HelpIcon_OnEnter)
  HelpIcon:SetScript("OnLeave", HelpIcon_OnLeave)
  HelpIcon.tip = GetAddOnMetadata("Overachiever", "Title")..": %s"
  HelpIcon:SetScale(0.85)
  LeftFrame.helpIcon = HelpIcon

  LeftFrame:Hide()
  LeftFrame:SetScript("OnShow", LeftFrame_OnShow)
  LeftFrame:SetScript("OnHide", LeftFrame_OnHide)

  tinsert(ACHIEVEMENTFRAME_SUBFRAMES, "Overachiever_LeftFrame")

  LeftFrame:RegisterEvent("ADDON_LOADED")
  LeftFrame:SetScript("OnEvent", function(self, event, arg1)
    if (arg1 == "Overachiever_Tabs") then
      self:UnregisterEvent("ADDON_LOADED")
      self:RegisterEvent("CRITERIA_UPDATE")
	  --self:RegisterEvent("ACHIEVEMENT_EARNED")
      self:SetScript("OnEvent", LeftFrame_OnEvent)
      varsLoaded = true

      Overachiever_Tabs_Settings = Overachiever_Tabs_Settings or {}
      local v = Overachiever_Tabs_Settings
      oldver = v.Version
      v.Version = GetAddOnMetadata("Overachiever_Tabs", "Version")
      if (oldver == v.Version) then  oldver = false;  end

	  Overachiever_Tabs_CharVars = Overachiever_Tabs_CharVars or {}
	  local vc = Overachiever_Tabs_CharVars
	  vc.Version = v.Version

      v.AchFilters = v.AchFilters or {}
      local AchFilters = v.AchFilters
      if (AchFilters["AchievementFrameAchievements"]) then
        AchievementFrame_SetFilter(AchFilters["AchievementFrameAchievements"])
      end
      if (tabs) then
        local name
        for k,tab in ipairs(tabs) do
          name = tab.frame:GetName()
          if (AchFilters[name]) then  FilterByTab[tab.frame] = AchFilters[name];  end
          if (tab.loadFunc) then
            tab.loadFunc(v, oldver, vc)
            tab.loadFunc = nil
          end
        end
      end
    end
  end)
end

-- Meta-criteria creation intercept (in addition to the base Overachiever intercept):
local function MetaCriteriaOnClick(self)
  local id = self.id
  --if (id and (GetPreviousAchievement(id) or isAchievementInUI(id, true, true)) ) then
  if (id and isAchievementInUI(id, true, true) ) then -- GetPreviousAchievement is redundant
    Overachiever.UI_SelectAchievement(id, silentDisplay, self:GetParent():GetParent())
  end
end
local orig_AchievementButton_GetMeta = AchievementButton_GetMeta
local function new_AchievementButton_GetMeta(...)
  local frame = orig_AchievementButton_GetMeta(...)
  frame:SetScript("OnClick", MetaCriteriaOnClick)
  return frame;
end
AchievementButton_GetMeta = new_AchievementButton_GetMeta

-- Meta-criteria recolor:
hooksecurefunc("AchievementObjectives_DisplayCriteria", recolor_AchievementObjectives_DisplayCriteria)


-- Flashing tab:
local flashFrame, flashFrame_stop
do
  local frames

  local function flashFrame_OnFinished(self)
      if (self.showWhenDone) then
        self.frame:Show()
      else
        self.frame:Hide()
      end
      self.frame:SetAlpha(1)
      frames[self.frame] = nil
      if (next(frames) == nil) then -- If the table is empty
        frames = nil -- then get rid of it.
      end
    end

  function flashFrame(frame, fadeInTime, fadeOutTime, flashDuration, showWhenDone, flashInHoldTime, flashOutHoldTime)
    if (frames) then
      if (frames[frame]) then  return;  end  -- If currently flashing, do nothing.
    else
      frames = {}
    end

    frame:SetAlpha(0)
    frame:Show()
    local flasher = frame:CreateAnimationGroup()
    frames[frame] = flasher

    -- Flashing in
    local fade1 = flasher:CreateAnimation("Alpha")
    fade1:SetDuration(fadeInTime)
	--fade1:SetChange(1)
	fade1:SetFromAlpha(0)
	fade1:SetToAlpha(1)
    fade1:SetOrder(1)

    if (flashInHoldTime) then  fade1:SetStartDelay(flashInHoldTime);  end

    -- Flashing out
    local fade2 = flasher:CreateAnimation("Alpha")
    fade2:SetDuration(fadeOutTime)
    --fade2:SetChange(-1)
	fade2:SetFromAlpha(1)
	fade2:SetToAlpha(0)
    fade2:SetOrder(2)

    if (flashOutHoldTime) then  fade2:SetEndDelay(flashOutHoldTime);  end

    flasher:SetScript("OnFinished", flashFrame_OnFinished)
    flasher.showWhenDone = showWhenDone
    flasher.frame = frame

    flasher:Play()
  end

  function flashFrame_stop(frame)
    if (frames and frames[frame]) then
      frames[frame]:Stop()
      flashFrame_OnFinished(frames[frame])
    end
  end
end

function Overachiever.FlashTab(tab)
  if (tabselected and tabselected.tab == tab) then  return;  end
  local flash = tab.flash
  if (not flash) then
    flash = CreateFrame("Frame", tab:GetName().."Flash", tab)
    flash:SetPoint("TOPLEFT", "$parentLeft", "TOPLEFT")
    flash:SetPoint("BOTTOMRIGHT", "$parentRight", "BOTTOMRIGHT")
    local tex = flash:CreateTexture("$parentBackground", "BACKGROUND")
    tex:SetTexture("Interface\\AddOns\\Overachiever_Tabs\\TabHighlight")
    tex:SetBlendMode("ADD")
    tex:SetPoint("TOPLEFT", flash, "TOPLEFT", 7, 8)
    tex:SetPoint("BOTTOMRIGHT", flash, "BOTTOMRIGHT", -3, -3)
    tab.flash = flash
  end
  --if (UIFrameIsFading(flash)) then  UIFrameFlashRemoveFrame(flash);  end
  --UIFrameFlash(flash, 0.35, 0.35, 0.9, nil, 0.05, 0.15)
  -- Use our own animation since the above causes taint:
  flashFrame_stop(flash)
  flashFrame(flash, 0.35, 0.35, 0.9, nil, 0.05, 0.15)
end

function Overachiever.GetSelectedTab(prev)
  if (prev) then  return prevtab;  else  return tabselected;  end
end



function Overachiever.Debug_DumpTab(unfiltered, simple)
	if (tabselected and tabselected.GetAchList) then
		local chatprint = Overachiever.chatprint
		local list = tabselected:GetAchList(unfiltered)
		local num = #list
		chatprint("Tab contains " .. num .. " achievements.")
		if (num > 0) then
			local tab = {}
			for i,id in pairs(list) do
				tab[#tab+1] = id
			end
			sort(tab)
			local s
			if (simple) then
				s = "{ "..strjoin(", ", unpack(tab)).." }"
			else
				for i,id in ipairs(tab) do
					local _, name = GetAchievementInfo(id)
					if (name) then  tab[i] = id .. ", -- " .. name;  end
				end
				s = "{\n    "..strjoin("\n    ", unpack(tab)).."\n}"
			end
			print(s)
			chatprint("Outputting as error message to allow copying.")
			error("Copy the following table:\n" .. s)
		end
	end
end
-- /run Overachiever.Debug_DumpTab(true)
