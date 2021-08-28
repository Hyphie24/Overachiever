
local L = OVERACHIEVER_STRINGS
local THIS_VERSION = GetAddOnMetadata("Overachiever", "Version")

local holidayNoticeChange

Overachiever.DefaultSettings = {
  Tooltip_ShowProgress = true;
  Tooltip_ShowProgress_Other = true;
  Tooltip_ShowID = false;
  UI_SeriesTooltip = true;
  UI_RequiredForMetaTooltip = true;
  UI_ProgressIfOtherCompleted = true;
  UI_HolidayNotice = true;
  UI_HolidayNotice_SuggestionsTabOnly = false;
  Tracker_AutoTimer = true;
  Tracker_AutoTimer_BG = true;
  Explore_AutoTrack = false;
  Explore_AutoTrack_Completed = false;
  CritterTip_loved = true;
  CritterTip_killed = true;
  WellReadTip_read = true;
  EatYourGreensTip_eat = true;
  AnglerTip_fished = true;
  SchoolTip_fished = true;
  DraenorAnglerTip_fished = true;
  Item_consumed = true;
  Item_consumed_whencomplete = false;
  Item_satisfied = true;
  Item_acquired = true;
  Mission_complete = true;
  Mission_complete_whencomplete = true;
  CreatureTip_killed = true;
  CreatureTip_killed_whencomplete = true;
  CreatureTip_killed_exclude_guild = false;
  VehicleTip_ridden = true;
  LetItSnow_flaked = false;
  FistfulOfLove_petals = false;
  BunnyMaker_eared = false;
  Brewfest_consumed = true;
  Brewfest_consumed_whencomplete = false;
  Darkmoon_consumed = true;
  Darkmoon_consumed_whencomplete = false;
  CheckYourHead_pumpkin = false;
  TurkeyLurkey_feathered = false;
  Draggable_AchFrame = true;
  DragSave_AchFrame = false;
  Tradeskill_ShowCompletedAch_Cooking = false;
  SoundAchIncomplete = 0;
  SoundAchIncomplete_AnglerCheckPole = true;
  SoundAchIncomplete_KillCheckCombat = true;
  ProgressToast_AutoTrack = false;
  ProgressToast_ChatLog = true;
  ProgressToast_Suggest = true;
  ToastCalendar_holiday = true;
  ToastCalendar_microholiday = false;
  ToastCalendar_bonusevent = false;
  ToastCalendar_dungeonevent = false;
  ToastCalendar_pvpbrawl = false;
  ToastCalendar_misc = false;
  ToastCalendar_noautofade = false;
  ToastCalendar_onlyclickfade = false;
  Throttle_AchLookup = false;
  Slash_SearchTab = true;
  Version = THIS_VERSION;
};

local function SoundSelected(self, key, val, clicked)
  if (clicked) then  PlaySoundFile( self:Fetch() );  end
end

local function updateEnabled()
  Overachiever_Options_ToastCalendar_onlyclickfade:SetEnabled( Overachiever_Options_ToastCalendar_noautofade:GetChecked() )
end

function Overachiever.CreateOptions(THIS_TITLE, BuildCriteriaLookupTab_check, AutoTrackCheck_Explore, CheckDraggable_AchFrame)
  local IDs = OVERACHIEVER_ACHID

  local items_general = {
	{ type = "labelwrap", text = L.OPT_LABEL_TOOLTIPS, topBuffer = 1 },
	{ variable = "Tooltip_ShowProgress", text = L.OPT_SHOWPROGRESS,
	  tooltip = L.OPT_SHOWPROGRESS_TIP },
	{ variable = "Tooltip_ShowProgress_Other", text = L.OPT_SHOWPROGRESS_OTHER,
	  tooltip = L.OPT_SHOWPROGRESS_OTHER_TIP },
	{ variable = "Tooltip_ShowID", text = L.OPT_SHOWID },
	
	{ type = "labelwrap", text = L.OPT_LABEL_TRACKING, topBuffer = 4 },
	{ variable = "Tracker_AutoTimer", text = L.OPT_AUTOTRACKTIMED, tooltip = L.OPT_AUTOTRACKTIMED_TIP },
	{ variable = "Tracker_AutoTimer_BG", text = L.OPT_AUTOTRACKTIMED_BG, tooltip = L.OPT_AUTOTRACKTIMED_TIP_BG },
	{ variable = "Explore_AutoTrack", text = L.OPT_AUTOTRACKEXPLORE,
	  tooltip = L.OPT_AUTOTRACKEXPLORE_TIP, OnChange = AutoTrackCheck_Explore },
	{ variable = "Explore_AutoTrack_Completed", text = L.OPT_AUTOTRACKEXPLORE_COMPLETED,
	  xOffset = 10, OnChange = AutoTrackCheck_Explore },
	{ variable = "ProgressToast_AutoTrack", text = L.OPT_AUTOTRACK_CRITERIATOAST, tooltip = L.OPT_AUTOTRACK_CRITERIATOAST_TIP, xOffset = 0 },
	
	{ type = "labelwrap", text = L.OPT_LABEL_CRITERIATOAST, topBuffer = 4 },
	{ variable = "ProgressToast_ChatLog", text = L.OPT_CRITERIATOAST_CHATLOG, tooltip = L.OPT_CRITERIATOAST_CHATLOG_TIP },
	{ variable = "ProgressToast_Suggest", text = L.OPT_CRITERIATOAST_SUGGEST, tooltip = L.OPT_CRITERIATOAST_SUGGEST_TIP },

	{ type = "labelwrap", text = L.OPT_LABEL_MAINUI, topBuffer = 4, xOffset = 0 },
	{ variable = "UI_SeriesTooltip", text = L.OPT_UI_SERIESTIP, tooltip = L.OPT_UI_SERIESTIP_TIP },
	{ variable = "UI_RequiredForMetaTooltip", text = L.OPT_UI_REQUIREDFORMETATIP,
	  tooltip = L.OPT_UI_REQUIREDFORMETATIP_TIP, OnChange = BuildCriteriaLookupTab_check },
	{ variable = "UI_ProgressIfOtherCompleted", text = L.OPT_UI_PROGRESSIFOTHERCOMPLETED, tooltip = L.OPT_UI_PROGRESSIFOTHERCOMPLETED_TIP },
	{ variable = "UI_HolidayNotice", text = L.OPT_UI_HOLIDAYNOTICE, OnChange = holidayNoticeChange,
	  tooltip = L.OPT_UI_HOLIDAYNOTICE_TIP, tooltip2 = L.OPT_UI_HOLIDAYNOTICE_TIP2 },
	{ variable = "UI_HolidayNotice_SuggestionsTabOnly", xOffset = 15, text = L.OPT_UI_HOLIDAYNOTICE_SUGGESTIONSTABONLY, OnChange = holidayNoticeChange },
	{ variable = "Draggable_AchFrame", xOffset = 0, text = L.OPT_DRAGGABLE, OnChange = CheckDraggable_AchFrame },
	{ variable = "DragSave_AchFrame", text = L.OPT_DRAGSAVE, xOffset = 15, OnChange = CheckDraggable_AchFrame },

	{ type = "labelwrap", text = L.OPT_LABEL_STARTTOAST, topBuffer = 4, xOffset = 0 },
	{ variable = "ToastCalendar_holiday", text = L.OPT_STARTTOAST_HOLIDAY, tooltip = L.OPT_STARTTOAST_HOLIDAY_TIP },
	{ variable = "ToastCalendar_microholiday", text = L.OPT_STARTTOAST_MICROHOLIDAY, tooltip = L.OPT_STARTTOAST_MICROHOLIDAY_TIP, column = 2 },
	{ variable = "ToastCalendar_bonusevent", text = L.OPT_STARTTOAST_BONUS, tooltip = L.OPT_STARTTOAST_BONUS_TIP },
	{ variable = "ToastCalendar_dungeonevent", text = L.OPT_STARTTOAST_DUNGEON, tooltip = L.OPT_STARTTOAST_DUNGEON_TIP, column = 2 },
	{ variable = "ToastCalendar_pvpbrawl", text = L.OPT_STARTTOAST_PVPBRAWL, tooltip = L.OPT_STARTTOAST_PVPBRAWL_TIP },
	{ variable = "ToastCalendar_misc", text = L.OPT_STARTTOAST_MISC, tooltip = L.OPT_STARTTOAST_MISC_TIP, tooltip2 = L.OPT_STARTTOAST_MISC_TIP2, column = 2 },
	{ variable = "ToastCalendar_noautofade", text = L.OPT_STARTTOAST_TIMEFADE, tooltip = L.OPT_STARTTOAST_TIMEFADE_TIP, OnChange = updateEnabled,
	  name = "Overachiever_Options_ToastCalendar_noautofade" },
	{ variable = "ToastCalendar_onlyclickfade", xOffset = 15, text = L.OPT_STARTTOAST_ONLYCLICKFADE, tooltip = L.OPT_STARTTOAST_ONLYCLICKFADE_TIP,
	  name = "Overachiever_Options_ToastCalendar_onlyclickfade" },

	{ type = "labelwrap", text = L.OPT_LABEL_TRADESKILLUI, topBuffer = 4, xOffset = 0 },
	{ variable = "Tradeskill_ShowCompletedAch_Cooking", text = L.OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING, tooltip = L.OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING_TIP },

	{ type = "sharedmedia", mediatype = "sound", variable = "SoundAchIncomplete", text = L.OPT_SELECTSOUND,
	  tooltip = L.OPT_SELECTSOUND_TIP, tooltip2 = L.OPT_SELECTSOUND_TIP2,
	  xOffset = 0, topBuffer = 10, OnChange = SoundSelected },
	{ variable = "SoundAchIncomplete_AnglerCheckPole", text = L.OPT_SELECTSOUND_ANGLERCHECKPOLE,
	  tooltip = L.OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP, xOffset = 15 },
	{ variable = "SoundAchIncomplete_KillCheckCombat", text = L.OPT_SELECTSOUND_CHECKCOMBAT,
	  tooltip = L.OPT_SELECTSOUND_CHECKCOMBAT_TIP, xOffset = 15 },

	{ type = "labelwrap", text = L.OPT_LABEL_MISC, topBuffer = 4, xOffset = 0 },
	{ variable = "Throttle_AchLookup", text = L.OPT_THROTTLE_ACHLOOKUP, tooltip = L.OPT_THROTTLE_ACHLOOKUP_TIP, tooltip2 = L.OPT_THROTTLE_ACHLOOKUP_TIP2 },
	{ variable = "Slash_SearchTab", text = L.OPT_SLASHSEARCH_TAB, tooltip = L.OPT_SLASHSEARCH_TAB_TIP, tooltip2 = L.OPT_SLASHSEARCH_TIP2 },
  }

  local items_reminders = {
	{ type = "Oa_AchLabel", text = L.OPT_LABEL_NEEDTOKILL, topBuffer = 4, id1 = IDs.MediumRare, id2 = IDs.NorthernExposure, id3 = IDs.Glorious, id4 = IDs.BattleMonsters },
	{ variable = "CreatureTip_killed", text = L.OPT_KILLCREATURETIPS, tooltip = L.OPT_KILLCREATURETIPS_TIP,
	  tooltip2 = L.OPT_KILLCREATURETIPS_TIP2, OnChange = BuildCriteriaLookupTab_check, xOffset = 28 },
	{ variable = "CreatureTip_killed_whencomplete", text = L.OPT_KILLCREATURETIPS_WHENCOMPLETE, xOffset = 39 },
	{ variable = "CreatureTip_killed_exclude_guild", text = L.OPT_KILLCREATURETIPS_EXCLUDE_GUILD, xOffset = 39 },

	--{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.LoveCritters, id2 = IDs.LoveCritters2, id3 = IDs.LoveCritters3, id4 = IDs.LoveCritters4, xOffset = 0 },
  { type = "Oa_AchLabel", text = L.OPT_LABEL_LOVECRITTER, topBuffer = 4, xOffset = 0,
    id1 = IDs.LoveCritters, id2 = IDs.LoveCritters2, id3 = IDs.LoveCritters7, id4 = IDs.LoveCritters8, -- Just give a sampling of 4 of them to make the UI cleaner. For now, choosing first two and last two.
  },
	{ variable = "CritterTip_loved", text = L.OPT_CRITTERTIPS, tooltip = L.OPT_CRITTERTIPS_TIP, xOffset = 28 },

	{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.PestControl, xOffset = 0 },
	{ variable = "CritterTip_killed", text = L.OPT_PESTCONTROLTIPS, tooltip = L.OPT_PESTCONTROLTIPS_TIP, xOffset = 28 },

	{ type = "Oa_AchLabel", text = L.OPT_LABEL_ACHTWO, topBuffer = 4, id1 = IDs.WellRead, id2 = IDs.HigherLearning, xOffset = 0 },
	{ variable = "WellReadTip_read", text = L.OPT_WELLREADTIPS, tooltip = L.OPT_WELLREADTIPS_TIP, xOffset = 28 },

	{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.EatYourGreens, xOffset = 0 },
	{ variable = "EatYourGreensTip_eat", text = L.OPT_EATYOURGREENSTIPS, tooltip = L.OPT_EATYOURGREENSTIPS_TIP, xOffset = 28 },

	{ type = "Oa_AchLabel", text = L.OPT_LABEL_ACHFOUR, topBuffer = 4, id1 = IDs.Scavenger, id2 = IDs.OutlandAngler, id3 = IDs.NorthrendAngler, id4 = IDs.PandarianAngler, xOffset = 0 },
	{ variable = "AnglerTip_fished", text = L.OPT_ANGLERTIPS, tooltip = L.OPT_ANGLERTIPS_TIP_ALWAYS, xOffset = 28 },

	{ type = "Oa_AchLabel", text = L.OPT_LABEL_DRAENORANGLER, topBuffer = 4, id1 = IDs.DraenorAngler, xOffset = 0 },
	{ variable = "DraenorAnglerTip_fished", text = L.OPT_ANGLERTIPS, tooltip = L.OPT_ANGLERTIPS_TIP_ALWAYS, xOffset = 28 },

	{ type = "Oa_AchLabel", text = L.OPT_LABEL_ACHTWO, topBuffer = 4, id1 = IDs.Limnologist, id2 = IDs.Oceanographer, xOffset = 0 },
	{ variable = "SchoolTip_fished", text = L.OPT_ANGLERTIPS, tooltip = L.OPT_ANGLERTIPS_TIP, xOffset = 28 },

	{ type = "Oa_AchLabel", text = L.OPT_LABEL_ACHSEVEN, topBuffer = 4, id1 = IDs.TastesLikeChicken, id2 = IDs.HappyHour,
		id3 = IDs.CataclysmicallyDelicious, id4 = IDs.DrownYourSorrows, id5 = IDs.PandarenCuisine, id6 = IDs.PandarenDelicacies,
		id7 = IDs.DraenorCuisine,
		xOffset = 0 },
	{ variable = "Item_consumed", text = L.OPT_CONSUMEITEMTIPS, tooltip = L.OPT_CONSUMEITEMTIPS_TIP, tooltip2 = L.OPT_CONSUMEITEMTIPS_TIP2, xOffset = 28 },
	{ variable = "Item_consumed_whencomplete", text = L.OPT_CONSUMEITEMTIPS_WHENCOMPLETE, xOffset = 39 },

	{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.RightAsRain, xOffset = 0 },
	{ variable = "Item_satisfied", text = L.OPT_SATISFIEDTIPS, tooltip = L.OPT_SATISFIEDTIPS_TIP, xOffset = 28 },

	{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.ThreeSheetsToTheWind, xOffset = 0 },
	{ variable = "Item_acquired", text = L.OPT_ACQUIREDTIPS, tooltip = L.OPT_ACQUIREDTIPS_TIP, xOffset = 28 },

	{ type = "Oa_AchLabel", text = L.OPT_LABEL_ACHTHREE, topBuffer = 4, id1 = IDs.MissionBarrens, id2 = IDs.MissionLordaeron, id3 = IDs.MissionKalimdor, xOffset = 0 },
	{ variable = "Mission_complete", text = L.OPT_MISSIONCOMPLETE, tooltip = L.OPT_MISSIONCOMPLETE_TIP, xOffset = 28 },
	{ variable = "Mission_complete_whencomplete", text = L.OPT_MISSIONCOMPLETE_WHENCOMPLETE, xOffset = 39 },

  { type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.AfterlifeExpress, xOffset = 0 },
	{ variable = "VehicleTip_ridden", text = L.OPT_VEHICLERIDDENTIPS, tooltip = L.OPT_VEHICLERIDDENTIPS_TIP, xOffset = 28 },

	{ type = "labelwrap", text = L.OPT_LABEL_SEASONALACHS, justifyH = "CENTER", topBuffer = 16, xOffset = 0 },

	{ type = "Oa_AchLabel", topBuffer = 4, xOffset = 0, id1 = IDs.FistfulOfLove, xOffset = 0 },
	{ variable = "FistfulOfLove_petals", text = L.OPT_FISTFULOFLOVETIPS, tooltip = L.OPT_FISTFULOFLOVETIPS_TIP, xOffset = 28 },

	{ type = "Oa_AchLabel", topBuffer = 4, xOffset = 0, id1 = IDs.BunnyMaker, xOffset = 0 },
	{ variable = "BunnyMaker_eared", text = L.OPT_BUNNYMAKERTIPS, tooltip = L.OPT_BUNNYMAKERTIPS_TIP, xOffset = 28 },

	{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.BrewfestDiet, xOffset = 0 },
	{ variable = "Brewfest_consumed", text = L.OPT_CONSUMEITEMTIPS, tooltip = L.OPT_CONSUMEITEMTIPS_TIP, tooltip2 = L.OPT_CONSUMEITEMTIPS_TIP2, xOffset = 28 },
	{ variable = "Brewfest_consumed_whencomplete", text = L.OPT_CONSUMEITEMTIPS_WHENCOMPLETE, xOffset = 39 },

	{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.DarkmoonFaireFeast, xOffset = 0 },
	{ variable = "Darkmoon_consumed", text = L.OPT_CONSUMEITEMTIPS, tooltip = L.OPT_CONSUMEITEMTIPS_TIP, tooltip2 = L.OPT_CONSUMEITEMTIPS_TIP2, xOffset = 28 },
	{ variable = "Darkmoon_consumed_whencomplete", text = L.OPT_CONSUMEITEMTIPS_WHENCOMPLETE, xOffset = 39 },

	{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.CheckYourHead, xOffset = 0 },
	{ variable = "CheckYourHead_pumpkin", text = L.OPT_CHECKYOURHEADTIPS, tooltip = L.OPT_CHECKYOURHEADTIPS_TIP, xOffset = 28 },

	{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.TurkeyLurkey, xOffset = 0 },
	{ variable = "TurkeyLurkey_feathered", text = L.OPT_TURKEYLURKEYTIPS, tooltip = L.OPT_TURKEYLURKEYTIPS_TIP, xOffset = 28 },

	{ type = "Oa_AchLabel", topBuffer = 4, id1 = IDs.LetItSnow, xOffset = 0 },
	{ variable = "LetItSnow_flaked", text = L.OPT_LETITSNOWTIPS, tooltip = L.OPT_LETITSNOWTIPS_TIP, xOffset = 28 },
  }

  local title = THIS_TITLE.." v"..THIS_VERSION

  local mainpanel, oldver = TjOptions.CreatePanel(THIS_TITLE, nil, {
	title = title,
	itemspacing = 3,
	scrolling = true,
	items = items_general,
	variables = "Overachiever_Settings",
	defaults = Overachiever.DefaultSettings,
	OnShow = updateEnabled
  });

  local reminderspanel = TjOptions.CreatePanel(L.OPTPANEL_REMINDERTOOLTIPS, THIS_TITLE, {
	title = title..": |cffffffff"..L.OPTPANEL_REMINDERTOOLTIPS,
	itemspacing = 3,
	scrolling = true,
	items = items_reminders,
	variables = Overachiever_Settings,
	defaults = Overachiever.DefaultSettings
  });

  return mainpanel, oldver
  --return reminderspanel, oldver
end



-- CREATE AND REGISTER CUSTOM OPTIONS ITEMS
---------------------------------------------

do
  local function icon_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetHyperlink( GetAchievementLink(self.id) )
    if (GameTooltip:GetBottom() < self:GetTop()) then
      GameTooltip:ClearAllPoints()
      GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMRIGHT")
    end
  end

  local function icon_OnClick(self)
    if (IsShiftKeyDown()) then
      if ( ChatEdit_GetActiveWindow() ) then
        ChatEdit_InsertLink(GetAchievementLink(self.id));
      else
        ChatFrame_OpenChat(GetAchievementLink(self.id));
      end
    else
      Overachiever.OpenToAchievement(self.id)
    end
  end

  local function createicon(name, num, parent, id)
    name = name.."Icon"..num
    local iconframe = CreateFrame("Button", name, parent)
    iconframe:SetWidth(21); iconframe:SetHeight(21)
    iconframe.id = id
    --iconframe:SetHitRectInsets(6, -6, 6, -6)
    local icon = iconframe:CreateTexture(name.."Texture", "BACKGROUND")
    icon:SetWidth(21); icon:SetHeight(21)
    icon:SetPoint("LEFT", iconframe)
    local _, _, _, _, _, _, _, _, _, tex = GetAchievementInfo(id)
    if (tex) then
      icon:SetTexture(tex)
      iconframe:SetScript("OnEnter", icon_OnEnter)
      iconframe:SetScript("OnLeave", GameTooltip_Hide)
      iconframe:SetScript("OnClick", icon_OnClick)
    else
      icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    end
    --[[
    local border = iconframe:CreateTexture(name.."Border", "BORDER")
    border:SetWidth(30); border:SetHeight(30)
    border:SetTexture("Interface\\AchievementFrame\\UI-Achievement-Progressive-IconBorder")
    border:SetPoint("TOPLEFT", iconframe)
    border:SetTexCoord(0, 0.65625, 0, 0.65625)
    --]]
    return iconframe
  end

  local CreateAchLabel_pre
  do
    local d, count
    local function achsub(s)
      count = count + 1
      local _, name = GetAchievementInfo(d["id"..count])
      return name or L.OPT_ACHUNKNOWN
    end

    function CreateAchLabel_pre(name, parent, data, arg)
	  local perRow = 2
	  if (data["id5"]) then  perRow = 3;  end
      local first = createicon(name, 1, parent, data.id1)
      local w = 28
      local yOffset = 0
      if (data.id2) then
        w = w + (23 * (perRow - 1))
        local iconframe
        local i, v, last, lastleft = 2, data.id2, first, first
        while (v) do
          iconframe = createicon(name, i, parent, v)
          if (i % perRow ~= 1) then -- If not first icon of a new row:
            iconframe:SetPoint("LEFT", last, "RIGHT", 2, 0)
          else
            if (not data.iconTopRight) then  data.iconTopRight = last;  end
            if (not data["id"..i+1]) then
              if (perRow == 2) then
                iconframe:SetPoint("TOP", lastleft, "BOTTOM", 12, -2)
              else
                iconframe:SetPoint("TOPLEFT", lastleft, "BOTTOMRIGHT", 2, -2)
              end
            else
              iconframe:SetPoint("TOP", lastleft, "BOTTOM", 0, -2)
            end
            yOffset = yOffset + 23
            lastleft = iconframe
          end
          last = iconframe
          i = i + 1
          v = data["id"..i]
        end
        if (not data.iconTopRight) then  data.iconTopRight = last;  end
      else
        data.iconTopRight = first
      end

      data.icon1 = first
      data.justifyH = data.justifyH or "LEFT"
      data.width = data.width or (505 - w)
      data.lbl_yOffset = yOffset

      local text = data.text
      if (not text) then
        local i = 1
    		local v = data["id"..i]
    		text = ""
    		while (v) do
    		  if (text ~= "") then  text = text .. ",|n";  end
    		  local _, n = GetAchievementInfo(v)
          text = text .. '"'..(n or L.OPT_ACHUNKNOWN)..'"'
    		  i = i + 1
    		  v = data["id"..i]
    		end
      else
        d, count = data, 0
        text = text:gsub("(%%s)", achsub)
        d = nil
      end
      data.text = text
    end
  end

  local function CreateAchLabel_post(frame, handletip, xOffset, yOffset, btmBuffer, name, parent, data, arg)
    local lbl_yOffset = data.lbl_yOffset or 0
    frame:SetPoint("LEFT", data.iconTopRight, "RIGHT", 4, 1 - (lbl_yOffset / 2))
    local iconBL = data.icon1
    data.icon1, data.iconTopRight, data.lbl_yOffset = nil, nil, nil
    return true, iconBL, handletip, xOffset + 4, yOffset - 6, btmBuffer + lbl_yOffset
  end

  TjOptions.RegisterItemType("Oa_AchLabel", 1, "labelwrap", { create_prehook = CreateAchLabel_pre, create_posthook = CreateAchLabel_post })
end


function holidayNoticeChange(self, varname, value, playerClicked)
	if (varname == "UI_HolidayNotice" and value and Overachiever.ResetHiddenHolidayNotices) then
		Overachiever.ResetHiddenHolidayNotices()
	end
	if (Overachiever.SetupHolidayNotices and AchievementFrame:IsShown()) then
		Overachiever.SetupHolidayNotices(nil, true)
	end
end
