
-- Thank you to all of the translators that have helped localize Overachiever. In addition to those mentioned
-- below in their respective sections, recognition is due to all who have used the localization system provided
-- for Overachiever by Curse Forge. See a list of them here:
-- http://wow.curseforge.com/projects/overachiever/localization/translators/

OVERACHIEVER_STRINGS = {
	BINDING_NAME_OVERACHIEVER_TAB_SEARCH = "Open Search Tab";
	BINDING_NAME_OVERACHIEVER_TAB_SUGGESTIONS = "Open Suggestions Tab";
	BINDING_NAME_OVERACHIEVER_TAB_WATCH = "Open Watch Tab";

	OVERACHIEVER_INSTALLED_TOAST = "OVERACHIEVER INSTALLED!";
	OVERACHIEVER_INSTALLED_MSG = "|cff7eff00Overachiever|r v%s was installed.";
	OVERACHIEVER_UPDATED_TOAST = "OVERACHIEVER UPDATED!";
	OVERACHIEVER_UPDATED_MSG = "|cff7eff00Overachiever|r was updated to v%s.";

	STARTTOAST_EVENT = "Happening Today";

	SERIESTIP = "Part of a series:";
	REQUIREDFORMETATIP = "Required for:";
	PROGRESSIFOTHERCOMPLETED = "%s's Progress:";
	RECENTREMINDERCRITERIA = "Recently spotted objective:";

	PROGRESS = "Progress";
	YOURPROGRESS = "Your Progress";
	COMPLETEDATE = "Completed on %2$d/%1$02d/%3$02d";  -- 1 - day 2 - month 3 - year
	INCOMPLETE = "Incomplete";

	MULTI_NEED = "%s (needed for %s achievements)";

	KILL_INCOMPLETE = "Need to kill";
	KILL_COMPLETE = "Already killed";
	--? "Need to defeat" -- for things you need to defeat but not kill

	CRITTER = "Critter";
	WILDPET = "Wild Pet";
	ACH_LOVECRITTERS_INCOMPLETE = "Needs some /love";
	ACH_LOVECRITTERS_COMPLETE = "Already /loved";

	ACH_WELLREAD_INCOMPLETE = "Needs to be read";
	ACH_WELLREAD_COMPLETE = "Already read";
	ACH_EATYOURGREENS_INCOMPLETE = "Need to eat";
	ACH_EATYOURGREENS_COMPLETE = "Already eaten";

	ACH_ANGLER_INCOMPLETE = "Need to fish";
	ACH_ANGLER_COMPLETE = "Already fished";
	-- Since some achievements say to catch a certain fish but don't require fishing from a specific node and so don't give the node's name in the criteria,
	-- use this to make reminder tooltips work on those nodes where the fish name is known but the node's full name isn't. The %s is a stand-in for the
	-- fish name. Put each possibility on a new line.
	ACH_FISHSCHOOL_FORMAT = [[%s School
School of %s
%s Swarm]];

	-- For fishing achievements that have only one criteria and which require fishing from a node. Put each on a new line. Format: <achievement ID>=<fishing node names (separated by commas)>
	ACH_ANGLER_COUNT = [[9455=Fire Ammonite School
9456=Abyssal Gulper School,Oily Abyssal Gulper School
9457=Blackwater Whiptail School
9458=Blind Lake Sturgeon School
9459=Fat Sleeper School
9460=Jawless Skulker School
9461=Sea Scorpion School,Oily Sea Scorpion School
]];

	ACH_CONSUME_INCOMPLETE = "Need to consume";
	ACH_CONSUME_COMPLETE = "Already consumed";
	ACH_CONSUME_INCOMPLETE_EXTRA = "Haven't consumed";

	ACH_CONSUME_91_INCOMPLETE = "I dare you to eat 91 all at once!";
	ACH_CONSUME_91_COMPLETE = "Gluttony already proven"; --"1000% Satisfied";

	ACH_ACQUIRE_INCOMPLETE = "Need to acquire";
	ACH_ACQUIRE_COMPLETE = "Already acquired";
	ACH_ACQUIRE_INCOMPLETE_EXTRA = "Haven't acquired";

	ACH_MISSIONCOMPLETE_INCOMPLETE = "Need to complete";
	ACH_MISSIONCOMPLETE_COMPLETE = "Previously completed";

	ACH_RIDE_INCOMPLETE = "Need to ride";
	ACH_RIDE_COMPLETE = "Already ridden";

	ACH_LETITSNOW_INCOMPLETE = "Need to use Handful of Snowflakes";
	ACH_LETITSNOW_COMPLETE = "Already used Handful of Snowflakes";
	ACH_FISTFULOFLOVE_INCOMPLETE = "Need to use Handful of Rose Petals";
	ACH_FISTFULOFLOVE_COMPLETE = "Already used Handful of Rose Petals";
	ACH_BUNNYMAKER_INCOMPLETE = "Need to use Spring Flowers";
	ACH_BUNNYMAKER_COMPLETE = "Already used Spring Flowers";
	ACH_CHECKYOURHEAD_INCOMPLETE = "Needs a pumpkin head";
	ACH_CHECKYOURHEAD_COMPLETE = "Already pumpkin-headed";
	ACH_TURKEYLURKEY_INCOMPLETE = "Needs feathers";
	ACH_TURKEYLURKEY_COMPLETE = "Already feathered";

	HOLIDAY_DARKMOONFAIRE = "Darkmoon Faire";
	HOLIDAY_LUNARFESTIVAL = "Lunar Festival";
	HOLIDAY_LOVEISINTHEAIR = "Love is in the Air";
	HOLIDAY_NOBLEGARDEN = "Noblegarden";
	HOLIDAY_CHILDRENSWEEK = "Children's Week";
	HOLIDAY_MIDSUMMER = "Midsummer Fire Festival";
	HOLIDAY_MIDSUMMER_SHORT = "Midsummer";
	HOLIDAY_PIRATESDAY = "Pirates' Day";
	HOLIDAY_BREWFEST = "Brewfest";
	HOLIDAY_HALLOWSEND = "Hallow's End";
	HOLIDAY_DAYOFTHEDEAD = "Day of the Dead";
	HOLIDAY_PIGRIMSBOUNTY = "Pilgrim's Bounty";
	HOLIDAY_WINTERVEIL = "Feast of Winter Veil";
	HOLIDAY_WINTERVEIL_SHORT = "Winter Veil";

	MSG_INVALIDID = "Invalid input: No achievement with that ID.";
	MSG_NAMENOTFOUND = 'No achievement with name containing "|cffffffff%s|r" was found.';
	MSG_OPENINGTO = "Opening to: ";
	MSG_ONEFOUND = "1 other achievement found: ";
	MSG_NUMFOUNDLIST = "%s other achievements found:";
	MSG_NOOPEN = "Could not open to an achievement. None visible in UI.";
	MSG_NOOPEN_LIST = "%s |4achievement:achievements; found:";
	MSG_ACHNOTFOUND = "Achievement not found.";

	MSG_CRITERIAPROGRESS = "|cff7eff00Achievement Progress:|r %s (%s)";

	OPTPANEL_REMINDERTOOLTIPS = "Reminder Tooltips";

	OPT_LABEL_SEASONALACHS = "SEASONAL ACHIEVEMENTS";

	OPT_LABEL_ACHTWO = '"%s" and "%s"';
	OPT_LABEL_ACHTHREE = '"%s," "%s," and "%s"';
	OPT_LABEL_ACHFOUR = '"%s," "%s,"|n"%s," "%s"';
	OPT_LABEL_ACHFIVE = '"%s," "%s,"|n"%s," "%s"|n"%s"';
	OPT_LABEL_ACHSIX = '"%s," "%s,"|n"%s," "%s"|n"%s," "%s"';
	OPT_LABEL_ACHSEVEN = '"%s," "%s,"|n"%s," "%s"|n"%s," "%s," "%s"';

	OPT_ACHUNKNOWN = "<Unknown>";

	OPT_LABEL_TOOLTIPS = "Achievement Tooltips and Links";
	OPT_SHOWPROGRESS = "Add your progress";
	OPT_SHOWPROGRESS_TIP = 'Add your progress when an achievement has quantity-based criteria, such as "Obtain 10 mounts."';
	OPT_SHOWPROGRESS_OTHER = "Compare progress in others' links";
	OPT_SHOWPROGRESS_OTHER_TIP = "Add your progress when the achievement info shown is that of another player.";
	OPT_SHOWID = "Show achievement IDs";

	OPT_LABEL_TRACKING = "Achievement Tracking";
	OPT_AUTOTRACKTIMED = "Auto-track timed achievements (non-battleground)";
	OPT_AUTOTRACKTIMED_TIP = "Automatically track achievements with timed criteria when the timer starts. If you are already tracking the maximum number allowed, it may take the place of a previously auto-tracked achievement.|n|nExcludes battleground-specific achievements.";
	OPT_AUTOTRACKTIMED_BG = "Auto-track timed battleground achievements";
	OPT_AUTOTRACKTIMED_TIP_BG = "Automatically track battleground achievements with timed criteria when the timer starts. (For example, those that require a win or flag capture within a certain time frame.)|n|nThe achievement is untracked upon leaving the battleground.";
	OPT_AUTOTRACKEXPLORE = "Auto-track exploration achievements as you travel";
	OPT_AUTOTRACKEXPLORE_TIP = "When you enter a zone, automatically track its exploration achievement. It will be untracked when you leave the zone.";
	OPT_AUTOTRACKEXPLORE_COMPLETED = "Including those completed on a different character";
	OPT_AUTOTRACK_CRITERIATOAST = 'Auto-track upon "Achievement Progress" toast';
	OPT_AUTOTRACK_CRITERIATOAST_TIP = 'When the "Achievement Progress" toast appears, automatically track the achievement (if the tracking limit permits).';

	OPT_LABEL_CRITERIATOAST = "Progress Reaction (Non-Tracking)";
	OPT_CRITERIATOAST_CHATLOG = "Add to chat log";
	OPT_CRITERIATOAST_CHATLOG_TIP = 'When the "Achievement Progress" toast appears, link the achievement and show the completed criteria in the chat log.';
	OPT_CRITERIATOAST_SUGGEST = "Add to Recent Reminders (Suggestions)";
	OPT_CRITERIATOAST_SUGGEST_TIP = 'When the "Achievement Progress" toast appears, temporarily add the achievement to the Suggestions tab as a "Recent Reminder."';

	OPT_LABEL_LOVECRITTER = '/Love Critter Achievements ("%s," "%s," etc.)';
	OPT_CRITTERTIPS = "Critter /loved?";
	OPT_CRITTERTIPS_TIP = "If this achievement is incomplete, add a line to the tooltips of critters that are part of its criteria to indicate whether you still need to /love that type of critter.";
	OPT_PESTCONTROLTIPS = "Pest exterminated?";
	OPT_PESTCONTROLTIPS_TIP = "If this achievement is incomplete, add a line to the tooltips of critters that are part of its criteria to indicate whether you still need to exterminate them.";
	OPT_WELLREADTIPS = "Book read?";
	OPT_WELLREADTIPS_TIP = "If the achievement is incomplete, add a line to the tooltips of books that are part of its criteria to indicate whether you need to read them.";
	OPT_EATYOURGREENSTIPS = "Green eaten?";
	OPT_EATYOURGREENSTIPS_TIP = "If the achievement is incomplete, add a line to the tooltips of plants in Nazmir that you need to eat.";

	OPT_ANGLERTIPS = "Fishing node fished?";
	OPT_ANGLERTIPS_TIP = "If the achievement is incomplete, add a line to the tooltips of fishing nodes that are part of its criteria to indicate whether you need to fish from them.";
	OPT_ANGLERTIPS_TIP_ALWAYS = "Add a line to the tooltips of fishing nodes that are part of its criteria to indicate whether you need to fish from them.";
	OPT_LABEL_DRAENORANGLER = '"%s" Sub-Achievements';

	OPT_LETITSNOWTIPS = "Handful of Snowflakes used?";
	OPT_LETITSNOWTIPS_TIP = "If the achievement is incomplete, add a line to the tooltips of players of an appropriate race/class combo to indicate whether you need to use a Handful of Snowflakes on them.";
	OPT_FISTFULOFLOVETIPS = "Handful of Rose Petals used?";
	OPT_FISTFULOFLOVETIPS_TIP = "If the achievement is incomplete, add a line to the tooltips of players of an appropriate race/class combo to indicate whether you need to use a Handful of Rose Petals on them.";
	OPT_BUNNYMAKERTIPS = "Spring Flowers used?";
	OPT_BUNNYMAKERTIPS_TIP = "If the achievement is incomplete, add a line to the tooltips of players of an appropriate level to indicate whether you need to use Spring Flowers on them. Note that enemy players that are 10 or more levels higher than you are assumed to be at least level 18.";
	OPT_CHECKYOURHEADTIPS = "Weighted Jack-o'-Lantern used?";
	OPT_CHECKYOURHEADTIPS_TIP = "If the achievement is incomplete, add a line to the tooltips of players to indicate whether you need to use a Weighted Jack-o'-Lantern on them.";
	OPT_TURKEYLURKEYTIPS = "Turkey Shooter used?";
	OPT_TURKEYLURKEYTIPS_TIP = "If the achievement is incomplete, add a line to the tooltips of players to indicate whether you need to use your Turkey Shooter on them.";

	OPT_CONSUMEITEMTIPS = "Item consumed?";
	OPT_CONSUMEITEMTIPS_TIP = "If the achievement is incomplete, add a line to the tooltips of items that are part of its criteria to indicate whether you need to consume them.";
	OPT_CONSUMEITEMTIPS_TIP2 = "Items that you are too low level to consume will not trigger a reminder sound.";
	--OPT_CONSUMEITEMTIPS_TIP3 = "Note: This option can add a few seconds to your initial load time.";
	OPT_CONSUMEITEMTIPS_WHENCOMPLETE = "Show even if achievement is complete";

	OPT_SATISFIEDTIPS = "1000% Satisfied?";
	OPT_SATISFIEDTIPS_TIP = "Add a line to the tooltips of items that are part the achievement's criteria to indicate whether you need to consume them.";

	OPT_ACQUIREDTIPS = "Item acquired?";
	OPT_ACQUIREDTIPS_TIP = "Add a line to the tooltips of items to indicate whether you need to acquire them for an achievement.";

	OPT_MISSIONCOMPLETE = "Mission completed?";
	OPT_MISSIONCOMPLETE_TIP = "Add a line to the tooltips of missions to indicate whether you need to complete them for an achievement.";
	OPT_MISSIONCOMPLETE_WHENCOMPLETE = "Show even if achievement is complete";

	OPT_VEHICLERIDDENTIPS = "Vehicle/creature ridden?";
	OPT_VEHICLERIDDENTIPS_TIP = "Add a line to the tooltips of vehicles and creatures that you need to ride to complete an achievement.";

	OPT_LABEL_NEEDTOKILL = 'Kill Creature Achievements ("%s," "%s," etc.)';
	OPT_KILLCREATURETIPS = "Creature killed?";
	OPT_KILLCREATURETIPS_TIP = "Add a line to the tooltips of creatures (excluding critters) indicating whether you need to kill them for an achievement.";
	OPT_KILLCREATURETIPS_TIP2 = "|nNote: This relies on achievements providing mob IDs. Many kill-achievements do, but not all. Creatures needed for those that don't will not have updated tooltips, with a few exceptions where the data has been manually entered into Overachiever.";
	OPT_KILLCREATURETIPS_WHENCOMPLETE = "Show even if achievement is complete";
	OPT_KILLCREATURETIPS_EXCLUDE_GUILD = "Exclude guild achievements";

	OPT_LABEL_MAINUI = "Main Achievement UI Modifications";
	OPT_UI_SERIESTIP = "Tooltip for achievements that are part of a series";
	OPT_UI_SERIESTIP_TIP = "When the cursor is over an achievement that is part of a series, display the names of others in the series and its relation to them.";
	OPT_UI_REQUIREDFORMETATIP = "Tooltip for achievements required by others";
	OPT_UI_REQUIREDFORMETATIP_TIP = "When the cursor is over an achievement that is required to earn another achievement, display the name of the meta-achievement.";
	--OPT_UI_REQUIREDFORMETATIP_FACTIONICON = "Add an icon when exclusive to one faction";
	--OPT_UI_REQUIREDFORMETATIP_FACTIONICON_TIP = "Add an Alliance or Horde icon when the requirement is exclusive to one faction."
	--OPT_UI_REQUIREDFORMETATIP_FACTIONICON_TIP2 = "|nRequires the |cffffffffCache module|r to be enabled.";
	OPT_UI_PROGRESSIFOTHERCOMPLETED = "Tooltip for quantity-based progress if completed by another";
	OPT_UI_PROGRESSIFOTHERCOMPLETED_TIP = "When the cursor is over a quantity-based achievement (e.g. critera of \"Obtain 10 mounts\") that was completed but not by the current character, display the current character's progress.";
	OPT_DRAGGABLE = "Make draggable";
	OPT_DRAGSAVE = "Remember position";
	OPT_UI_HOLIDAYNOTICE = "Display notice if a holiday event is active";
	OPT_UI_HOLIDAYNOTICE_SUGGESTIONSTABONLY = "On Suggestions tab only";
	OPT_UI_HOLIDAYNOTICE_TIP = "If there is a holiday event today (e.g. Brewfest or Darkmoon Faire), a graphical notice appears next to the achievement UI. Clicking it displays achievements for that event. Put your cursor over it for more details.";
	OPT_UI_HOLIDAYNOTICE_TIP2 = "|cffffffffTabs module with Suggestions tab is required.|r";

	OPT_LABEL_TRADESKILLUI = "Professions UI Modifications";
	OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING = "Indicate uncooked recipes for complete achievements";
	OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING_TIP = "If Overachiever's Trade module is enabled, then an achievement icon appears next to recipes that you need to cook in order to earn certain achievements. If this option is checked, then these icons will appear next to uncooked recipes even if the associated achievement is complete.";

	OPT_LABEL_STARTTOAST = "Holiday/Event Toasts";
	OPT_STARTTOAST_HOLIDAY = "Show today's holidays";
	OPT_STARTTOAST_HOLIDAY_TIP = "Show today's holidays in toast notifications upon entering the game world.";
	OPT_STARTTOAST_MICROHOLIDAY = "Show today's micro-holidays";
	OPT_STARTTOAST_MICROHOLIDAY_TIP = "Show today's micro-holidays in toast notifications upon entering the game world.";
	OPT_STARTTOAST_BONUS = "Show today's bonus events";
	OPT_STARTTOAST_BONUS_TIP = "Show today's bonus events in toast notifications upon entering the game world.";
	OPT_STARTTOAST_DUNGEON = "Show today's dungeon events";
	OPT_STARTTOAST_DUNGEON_TIP = "Show today's dungeon events in toast notifications upon entering the game world.";
	OPT_STARTTOAST_PVPBRAWL = "Show today's PvP brawl";
	OPT_STARTTOAST_PVPBRAWL_TIP = "Show today's PvP brawl in toast notifications upon entering the game world.";
	OPT_STARTTOAST_MISC = "Show today's misc. holidays";
	OPT_STARTTOAST_MISC_TIP = "Show today's miscellaneous \"holiday\" events in toast notifications upon entering the game world.";
	OPT_STARTTOAST_MISC_TIP2 = "These are events found in the default calendar as \"holidays\" but are neither considered full holidays nor covered by another category given here. Examples include WoW Anniversaries and raid release days (for new raids or difficulties, not weekly resets).";
	OPT_STARTTOAST_TIMEFADE = "Do not automatically hide";
	OPT_STARTTOAST_TIMEFADE_TIP = "Prevent toast notifications you don't interact with from fading after a few seconds.";
	OPT_STARTTOAST_ONLYCLICKFADE = "Require click to hide";
	OPT_STARTTOAST_ONLYCLICKFADE_TIP = "Prevent toast notifications from fading unless left- or right-clicked. (If unchecked, they will also fade if the cursor goes over them and then moves away.)";

	OPT_SELECTSOUND = "Incomplete Achievement Reminder Sound";
	OPT_SELECTSOUND_TIP = "Play the selected sound when an incomplete achievement reminder is added to the tooltip.";
	OPT_SELECTSOUND_TIP2 = "Sounds will only play once every 15 seconds.";
	OPT_SELECTSOUND_ANGLERCHECKPOLE = "Exclude fishing node reminders if pole is equipped";
	OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP = "Don't play reminder sound from fishing nodes if your fishing pole is equipped.";
	OPT_SELECTSOUND_CHECKCOMBAT = "Exclude kill reminders if in combat with creature";
	OPT_SELECTSOUND_CHECKCOMBAT_TIP = "Don't play reminder sound from needing to kill a creature while you are in combat with it.";

	OPT_LABEL_MISC = "Miscellaneous";
	OPT_THROTTLE_ACHLOOKUP = "Startup: Throttle achievement lookup";
	OPT_THROTTLE_ACHLOOKUP_TIP = "Overachiever looks up certain data on startup. If this is unchecked, lookup happens while the UI is first loading. If checked, data is gathered over time after the player enters the world.";
	OPT_THROTTLE_ACHLOOKUP_TIP2 = "|nThe advantage to throttled lookup is a faster initial loading time, but, for some users and on some characters, this can noticeably impact performance for several seconds at the start of a session.|n|nIf the |cffffffffCache module|r is enabled, then throttling doesn't improve loading time as significantly unless the cache needs to be rebuilt. The cache is rebuilt after each new WoW build is released.";
	OPT_SLASHSEARCH_TAB = "Slash commands use Search tab";
	OPT_SLASHSEARCH_TAB_TIP = "Use the Search tab to show search results from slash commands like \"/ach food\". If this is unchecked, results are output to the chat log instead (unless a silent output command like \"/achs\" is used).";
	OPT_SLASHSEARCH_TIP2 = "|cffffffffTabs module with Search tab is required.|r";

	SOUND_BELL_ALLIANCE = "Bell - Alliance";
	SOUND_BELL_HORDE = "Bell - Horde";
	SOUND_BELL_NIGHTELF = "Bell - Night Elf";
	SOUND_DRUMHIT = "Drum Hit";
	SOUND_BELL_BOATARRIVED = "Bells - Boat Arrived";
	SOUND_GONG_TROLL = "Gong - Troll";
	SOUND_BELL_MELLOW = "Mellow Bells";
	SOUND_ENTERQUEUE = "Enter Queue";
	SOUND_HEARTHBIND = "Hearthstone Bind";
	SOUND_BELL_KARA = "Karazhan Bell";
	SOUND_DING_AUCTION = "Auction Ding";
	SOUND_BELL_AUCTION = "Auction Bells";
	SOUND_ALARM1 = "Alarm Clock 1";
	SOUND_ALARM2 = "Alarm Clock 2";
	SOUND_ALARM3 = "Alarm Clock 3";
	SOUND_MAP_PING = "Map Ping";
	SOUND_SIMON_DING = "Simon Ding";
	SOUND_SIMON_STARTGAME = "Simon Start Game";
	SOUND_SIMON_STARTLEVEL = "Simon Start Level";
	SOUND_SIMON_BADPRESS = "Simon Bad Press";
	SOUND_SIMON_FAIL_LARGE = "Simon Fail Large";
	SOUND_SIMON_FAIL_SMALL = "Simon Fail Small";
	SOUND_YAR = "Yarrrr";
	SOUND_AGGRO_WARNING = "Aggro Warning";
	SOUND_AGGRO_PULLED = "Aggro Pulled";
	SOUND_GLYPH_CREATE_MAJOR = "Glyph Create Major";
	SOUND_GLYPH_CREATE_MINOR = "Glyph Create Minor";
	SOUND_GLYPH_DESTROY_MAJOR = "Glyph Destroy Major";
	SOUND_GLYPH_DESTROY_MINOR = "Glyph Destroy Minor";
	SOUND_BGTIMER = "Battleground Countdown";
	SOUND_BGTIMER_END = "Battleground Countdown End";
	SOUND_MEDAL_EXPIRES = "Medal Expires";
	SOUND_GARRISON_INVASION = "Garrison Invasion Alert";
	SOUND_BONUSEVENT = "Bonus Event";
	SOUND_DIGSITE_COMPLETE = "Digsite Complete";
	SOUND_STORE_CONFIRM = "Store Confirmation";
	SOUND_MEDAL_GOLDTOSILVER = "Medal Gold to Silver";
	SOUND_MEDAL_SILVERTOBRONZE = "Medal Silver to Bronze";
	SOUND_CHAR_CREATE = "Create Character";
	SOUND_QUEST_COMPLETE = "Quest Complete";
	SOUND_LEVELUP = "Level Up";
}

local L, locale = OVERACHIEVER_STRINGS, GetLocale()

--if (locale == "enGB") then  -- English (EU)
-- Unfortunately, GetLocale() returns "enUS" even when "enGB" would be more appropriate, and the SHORTDATE
-- global string is defined incorrectly for enGB clients (it's set as it is for enUS), so we have to do things
-- this way:
if (ACHIEVEMENT_TOOLTIP_COMPLETE == "Achievement earned by %1$s on %3$d/%2$d/20%4$02d") then
	L["COMPLETEDATE"] = "Completed on %1$d/%2$02d/%3$02d";  -- 1 - day 2 - month 3 - year
end

if (locale == "deDE") then  -- German
-- Thanks to users Svensn and Farook at wowinterface.com for many of these translations:
L["ACH_ACQUIRE_COMPLETE"] = "Bereits erworben"
L["ACH_ACQUIRE_INCOMPLETE"] = "Muss noch erworben werden"
L["ACH_ACQUIRE_INCOMPLETE_EXTRA"] = "Noch nicht erworben"
L["ACH_ANGLER_COMPLETE"] = "Bereits geangelt"
L["ACH_ANGLER_COUNT"] = [=[9455=Ein Schwarm Feuerammoniten
9456=Ein Schwarm ölige Tiefseeschluckaale,Ein Schwarm ölige Tiefseeschluckaale
9457=Ein Schwarm Schwarzwasserpeitschflossen
9458=Ein Schwarm blinder Seestöre
9459=Ein Schwarm dicker Schläfer
9460=Ein Schwarm kieferloser Schleicher
9461=Ein Schwarm Seeskorpione,Ein Schwarm öliger Seeskorpione]=]
L["ACH_ANGLER_INCOMPLETE"] = "Noch zu angeln"
L["ACH_BUNNYMAKER_COMPLETE"] = "Frühlingsblumen bereits angewendet"
L["ACH_BUNNYMAKER_INCOMPLETE"] = "Frühlingsblumen noch anzuwenden"
L["ACH_CHECKYOURHEAD_COMPLETE"] = "Kürbis bereits aufgesetzt"
L["ACH_CHECKYOURHEAD_INCOMPLETE"] = "Benötigt noch einen Kürbiskopf"
L["ACH_CONSUME_91_COMPLETE"] = "Fresssucht bereits nachgewiesen"
L["ACH_CONSUME_91_INCOMPLETE"] = "Trau dich, 91 auf einmal zu essen!"
L["ACH_CONSUME_COMPLETE"] = "Bereits konsumiert"
L["ACH_CONSUME_INCOMPLETE"] = "Noch zu konsumieren"
L["ACH_CONSUME_INCOMPLETE_EXTRA"] = "Noch nicht konsumiert"
L["ACH_EATYOURGREENS_COMPLETE"] = "bereits gegessen"
L["ACH_EATYOURGREENS_INCOMPLETE"] = "muss noch gegessen werden"
L["ACH_FISHSCHOOL_FORMAT"] = [=[Schwarm %s
%sschwarm
%steich]=]
L["ACH_FISTFULOFLOVE_COMPLETE"] = "Handvoll Rosenblüten bereits angewendet"
L["ACH_FISTFULOFLOVE_INCOMPLETE"] = "Handvoll Rosenblüten noch anzuwenden"
L["ACH_LETITSNOW_COMPLETE"] = "Handvoll Schneeflocken bereits angewendet"
L["ACH_LETITSNOW_INCOMPLETE"] = "Handvoll Schneeflocken noch anzuwenden"
L["ACH_LOVECRITTERS_COMPLETE"] = "Wurde bereits geliebt"
L["ACH_LOVECRITTERS_INCOMPLETE"] = "Braucht etwas /liebe"
L["ACH_MISSIONCOMPLETE_COMPLETE"] = "Zuvor abgeschlossen"
L["ACH_MISSIONCOMPLETE_INCOMPLETE"] = "Noch nicht abgeschlossen"
L["ACH_RIDE_COMPLETE"] = "Bereits geritten"
L["ACH_RIDE_INCOMPLETE"] = "Muss noch geritten werden"
L["ACH_TURKEYLURKEY_COMPLETE"] = "Bereits mit Federn beschossen"
L["ACH_TURKEYLURKEY_INCOMPLETE"] = "Noch mit Federn zu beschießen"
L["ACH_WELLREAD_COMPLETE"] = "Bereits gelesen"
L["ACH_WELLREAD_INCOMPLETE"] = "Muss noch gelesen werden"
L["BINDING_NAME_OVERACHIEVER_TAB_SEARCH"] = "Suche-Tab öffnen"
L["BINDING_NAME_OVERACHIEVER_TAB_SUGGESTIONS"] = "Vorschläge-Tab öffnen"
L["BINDING_NAME_OVERACHIEVER_TAB_WATCH"] = "Beobachtungs-Tab öffnen"
L["COMPLETEDATE"] = "Abgeschlossen am %1$02d.%2$02d.20%3$02d"
L["CRITTER"] = "Kleintier"
L["HOLIDAY_BREWFEST"] = "Braufest"
L["HOLIDAY_CHILDRENSWEEK"] = "Kinderwoche"
L["HOLIDAY_DARKMOONFAIRE"] = "Dunkelmond-Jahrmarkt"
L["HOLIDAY_DAYOFTHEDEAD"] = "Tag der Toten"
L["HOLIDAY_HALLOWSEND"] = "Schlotternächte"
L["HOLIDAY_LOVEISINTHEAIR"] = "Liebe liegt in der Luft"
L["HOLIDAY_LUNARFESTIVAL"] = "Mondfest"
L["HOLIDAY_MIDSUMMER"] = "Sonnenwendfest"
L["HOLIDAY_MIDSUMMER_SHORT"] = "Sonnenwendfest"
L["HOLIDAY_NOBLEGARDEN"] = "Nobelgartenfest"
L["HOLIDAY_PIGRIMSBOUNTY"] = "Pilgerfreudenfest"
L["HOLIDAY_PIRATESDAY"] = "Piratentag"
L["HOLIDAY_WINTERVEIL"] = "Winterhauchfest"
L["HOLIDAY_WINTERVEIL_SHORT"] = "Winterhauch"
L["INCOMPLETE"] = "Nicht abgeschlossen"
L["KILL_COMPLETE"] = "Bereits getötet"
L["KILL_INCOMPLETE"] = "Noch zu töten"
L["MSG_ACHNOTFOUND"] = "Erfolg nicht gefunden."
L["MSG_CRITERIAPROGRESS"] = "|cff7eff00Erfolgsfortschritt:|r %s (%s)"
L["MSG_INVALIDID"] = "Ungültige Eingabe: Kein Erfolg mit dieser ID."
L["MSG_NAMENOTFOUND"] = "Es wurde kein Erfolg gefunden, dessen Name \"|cffffffff%s|r\" enthält."
L["MSG_NOOPEN"] = "Der Erfolg konnte nicht angezeigt werden. Er ist im UI nicht sichtbar."
L["MSG_NOOPEN_LIST"] = "%s |4Erfolg:Erfolge; gefunden:"
L["MSG_NUMFOUNDLIST"] = "%s weitere Erfolge gefunden:"
L["MSG_ONEFOUND"] = "1 weiterer Erfolg gefunden: "
L["MSG_OPENINGTO"] = "Öffnen nach: "
L["MULTI_NEED"] = "%s (Benötigt für %s Errungenschaften)"
L["OPT_ACHUNKNOWN"] = "<Unbekannt>"
L["OPT_ACQUIREDTIPS"] = "Gegenstand erworben?"
L["OPT_ACQUIREDTIPS_TIP"] = "Zeigt in den Tooltipps von Gegenständen einen Hinweis an, ob Sie sie für einen Erfolg erwerben müssen."
L["OPT_ANGLERTIPS"] = "Fischschwarm geangelt?"
L["OPT_ANGLERTIPS_TIP"] = "Wenn der Erfolg noch nicht abgeschlossen ist, wird im Tooltip eines Fischschwarms der Hinweis angezeigt, ob er für den Erfolg noch geangelt werden muss."
L["OPT_ANGLERTIPS_TIP_ALWAYS"] = "Fügt eine Zeile in den Tooltips von noch zu angelnden Fischschwärmen ein, die zu den Kriterien des Erfolgs gehören."
L["OPT_AUTOTRACK_CRITERIATOAST"] = "Autom. Verfolgung bei Benachrichtigung über Erfolgsfortschritt"
L["OPT_AUTOTRACK_CRITERIATOAST_TIP"] = "Wenn eine Benachrichtigung über einen Erfolgsfortschritt erscheint, wird automatisch der Erfolg verfolgt (wenn das Limit noch nicht erreicht ist)."
L["OPT_AUTOTRACKEXPLORE"] = "Erkundungserfolge beim Reisen automatisch nachverfolgen"
L["OPT_AUTOTRACKEXPLORE_COMPLETED"] = "Abgeschlossene Erfolge einbeziehen"
L["OPT_AUTOTRACKEXPLORE_TIP"] = "Wenn du ein neues Gebiet betrittst, wird automatisch der dazugehörige Erkundungserfolg verfolgt. Die Anzeige wechselt nicht, wenn zu diesem Zeitpunkt ein Erfolg in der Erfolgsverfolgung angezeigt wird, welcher nichts mit der Erkundung bestimmter Gegenden zu tun hat."
L["OPT_AUTOTRACKTIMED"] = "Zeitliche Erfolge automatisch verfolgen"
L["OPT_AUTOTRACKTIMED_BG"] = "Autoverfolgung zeitlich festgelegt für Schlachtfelderfolge"
L["OPT_AUTOTRACKTIMED_TIP"] = "Erfolge mit zeitlichen Kriterien automatisch verfolgen, wenn der Timer startet. Wenn bereits das Maximum der gleichzeitig zu beobachteten Erfolge erreicht wurde, wird versucht, einen automatisch gesetzten Erkundungserfolg mit diesem Erfolg zu ersetzen; ansonsten wird dieser Erfolg ignoriert."
L["OPT_AUTOTRACKTIMED_TIP_BG"] = "Wenn eine Schlachtfeldbegegnung beginnt, verfolgt automatisch die Erfüllung, um es in einer festgelegten Zeitspanne zu gewinnen (wenn es unvollständig ist).|n|nDer Erfolg ist unverfolgt beim verlassen des Schlachtfeldes."
L["OPT_BUNNYMAKERTIPS"] = "Frühlingsblumen angewendet?"
L["OPT_BUNNYMAKERTIPS_TIP"] = "Wenn der Erfolg noch nicht abgeschlossen ist, wird im Tooltip eines Spielers der Hinweis angezeigt, ob bei seinem Geschlecht bzw. seiner Stufe noch Frühlingsblumen angewendet werden müssen. Beachte, dass gegnerische Spieler die 10+ Stufen höher sind als du, als mindestens Stufe 18 angesehen werden."
L["OPT_CHECKYOURHEADTIPS"] = "Gewichtige Kürbislaterne angewendet?"
L["OPT_CHECKYOURHEADTIPS_TIP"] = "Wenn der Erfolg noch nicht abgeschlossen ist, wird im Tooltip eines Spielers der Hinweis angezeigt, ob bei ihm noch eine Gewichtige Kürbislaterne angewendet werden muss."
L["OPT_CONSUMEITEMTIPS"] = "Gegenstand konsumiert?"
L["OPT_CONSUMEITEMTIPS_TIP"] = "Wenn der Erfolg noch nicht abgeschlossen ist, wird im Tooltip eines Gegenstandes der Hinweis angezeigt, ob es für den Erfolg noch konsumiert werden muss."
L["OPT_CONSUMEITEMTIPS_TIP2"] = "Gegenstände, die du aufgrund deiner geringen Stufe nicht konsumieren kannst, werden keinen Benachrichtigungston auslösen."
L["OPT_CONSUMEITEMTIPS_WHENCOMPLETE"] = "Auch anzeigen, wenn der Erfolg bereits abgeschlossen ist"
L["OPT_CRITERIATOAST_CHATLOG"] = "Im Chatfenster anzeigen"
L["OPT_CRITERIATOAST_CHATLOG_TIP"] = "Wenn eine Benachrichtigung über einen Erfolgsfortschritt erscheint, wird der Link und abgeschlossene Kriterien des Erfolgs im Chatfenster angezeigt."
L["OPT_CRITERIATOAST_SUGGEST"] = "Zu den Aktuellen Erinnerungen (Vorschläge) hinzufügen"
L["OPT_CRITERIATOAST_SUGGEST_TIP"] = "Wenn eine Benachrichtigung über einen Erfolgsfortschritt erscheint, wird der Erfolg als \"Aktuelle Erinnerung\" in den Vorschläge-Tab eingefügt."
L["OPT_CRITTERTIPS"] = "Kleintier via /liebe geliebt?"
L["OPT_CRITTERTIPS_TIP"] = "Wenn der Erfolg noch nicht abgeschlossen ist, wird im Tooltip eines Kleintieres der Hinweis angezeigt, ob es für den Erfolg noch geliebt werden muss."
L["OPT_DRAGGABLE"] = "Verschiebbar machen"
L["OPT_DRAGSAVE"] = "Position merken"
L["OPT_EATYOURGREENSTIPS"] = "Grün gegessen?"
L["OPT_EATYOURGREENSTIPS_TIP"] = "Wenn der Erfolg unvollständig ist, füge den Tooltips der Pflanzen in Nazmir eine Zeile hinzu, die du essen musst."
L["OPT_FISTFULOFLOVETIPS"] = "Handvoll Rosenblüten angewendet?"
L["OPT_FISTFULOFLOVETIPS_TIP"] = "Wenn der Erfolg noch nicht abgeschlossen ist, wird im Tooltip eines Spielers der Hinweis angezeigt, ob bei seinem Volk bzw. Klasse noch eine Handvoll Rosenblüten angewendet werden muss."
L["OPT_KILLCREATURETIPS"] = "Kreatur getötet?"
L["OPT_KILLCREATURETIPS_EXCLUDE_GUILD"] = "Gildenerfolge ausschließen"
L["OPT_KILLCREATURETIPS_TIP"] = "Zeigt im Tooltip einer Kreatur (außer Kleintiere) den Hinweis an, ob sie für einen Erfolg noch getötet werden muss."
L["OPT_KILLCREATURETIPS_TIP2"] = "Anmerkung: Beim Start (oder wenn diese Option aktiviert ist), wird jeder Erfolg gescannt, um die IDs der Einheiten festzustellen. Nicht alle Erfolge liefern derartige IDs. Die meisten tun es, aber Tooltips von Kreaturen, deren IDs nicht ermittelt werden konnten, bleiben unverändert."
L["OPT_KILLCREATURETIPS_WHENCOMPLETE"] = "Zeigt auch an, wenn der Erfolg abgeschlossen ist"
L["OPT_LABEL_ACHFIVE"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s\""
L["OPT_LABEL_ACHFOUR"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHSEVEN"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s,\" \"%s,\" \"%s\""
L["OPT_LABEL_ACHSIX"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHTHREE"] = "\"%s,\" \"%s,\" und \"%s\""
L["OPT_LABEL_ACHTWO"] = "\"%s\" und \"%s\""
L["OPT_LABEL_CRITERIATOAST"] = "Reaktion auf Fortschritt (Nicht verfolgte)"
L["OPT_LABEL_DRAENORANGLER"] = "\"%s\" Teilerfolge"
L["OPT_LABEL_LOVECRITTER"] = "/Liebe Kleintier Erfolge (\"%s,\" \"%s,\" usw.)"
L["OPT_LABEL_MAINUI"] = "Änderungen an der Benutzeroberfläche der Erfolge"
L["OPT_LABEL_MISC"] = "Sonstiges"
L["OPT_LABEL_NEEDTOKILL"] = "Erfolge für das Töten von Kreaturen (\"%s,\" \"%s,\" usw.)"
L["OPT_LABEL_SEASONALACHS"] = "WELTEREIGNIS-ERFOLGE"
L["OPT_LABEL_STARTTOAST"] = "Feiertag/Veranstaltung Toasts"
L["OPT_LABEL_TOOLTIPS"] = "Erfolg: Tooltips und Links"
L["OPT_LABEL_TRACKING"] = "Erfolg: Verfolgung"
L["OPT_LABEL_TRADESKILLUI"] = "Änderungen an der Benutzeroberfläche der Berufe"
L["OPT_LETITSNOWTIPS"] = "Handvoll Schneeflocken angewendet?"
L["OPT_LETITSNOWTIPS_TIP"] = "Wenn der Erfolg noch nicht abgeschlossen ist, wird im Tooltip eines Spielers der Hinweis angezeigt, ob bei seinem Volk bzw. Klasse noch eine Handvoll Schneeflocken angewendet werden muss."
L["OPT_MISSIONCOMPLETE"] = "Mission abgeschlossen?"
L["OPT_MISSIONCOMPLETE_TIP"] = "Zeigt in den Tooltipps von Missionen einen Hinweis an, ob Sie sie für einen Erfolg abschließen müssen."
L["OPT_MISSIONCOMPLETE_WHENCOMPLETE"] = "Zeigt auch an, wenn der Erfolg abgeschlossen ist"
L["OPT_PESTCONTROLTIPS"] = "Ungeziefer getötet?"
L["OPT_PESTCONTROLTIPS_TIP"] = "Wenn dieser Erfolg noch nicht abgeschlossen ist, wird im Tooltip des Ungeziefers angezeigt, ob es noch getötet werden muss."
L["OPT_SATISFIEDTIPS"] = "1000% zufriedengestellt?"
L["OPT_SATISFIEDTIPS_TIP"] = "Zeige im Tooltip eines Gegenstandes den Hinweis an, ob er für einen Erfolg konsumiert werden muss. "
L["OPT_SELECTSOUND"] = "Benachrichtigungston: Nicht abgeschlossener Erfolg"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE"] = "Noch zu angelnde Fischschwärme ignorieren, wenn Angel ausgerüstet ist"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP"] = "Erinnerungston bei Fischschwärmen nicht abspielen, wenn du gerade deine Angel angelegt hast."
L["OPT_SELECTSOUND_CHECKCOMBAT"] = "Nicht erinnern, dass eine Kreatur noch getötet werden muss, wenn man im Kampf mit ihr ist"
L["OPT_SELECTSOUND_CHECKCOMBAT_TIP"] = "Benachrichtigungston nicht abspielen, wenn eine Kreatur getötet werden muss, während man sie bekämpft."
L["OPT_SELECTSOUND_TIP"] = "Spielt den ausgewählten Ton ab, wenn im Tooltip der Hinweis zu sehen ist, dass der Erfolg noch nicht abgeschlossen ist."
L["OPT_SELECTSOUND_TIP2"] = "Töne werden nur einmal alle 15 Sekunden abgespielt."
L["OPT_SHOWID"] = "Erfolg-IDs anzeigen"
L["OPT_SHOWPROGRESS"] = "Deinen Fortschritt hinzufügen"
L["OPT_SHOWPROGRESS_OTHER"] = "Den Fortschritt in Links von anderen Spielern vergleichen"
L["OPT_SHOWPROGRESS_OTHER_TIP"] = "Deinen Fortschritt hinzufügen, wenn die Erfolge von einem anderen Spieler stammen."
L["OPT_SHOWPROGRESS_TIP"] = "Deinen Fortschritt hinzufügen, wenn ein Erfolg mengenbasierende Kriterien enthält, wie zum Beispiel \"Erhaltet 10 Reittiere.\""
L["OPT_SLASHSEARCH_TAB"] = "Schrägstrichbefehle in Registerkarte Suchen verwenden"
L["OPT_SLASHSEARCH_TAB_TIP"] = "Verwenden Sie die Registerkarte \"Suchen\", um Suchergebnisse von Schrägstrichbefehlen wie \"/ach essen\" anzuzeigen. Wenn dies nicht markiert ist, werden die Ergebnisse stattdessen im Chat-Protokoll ausgegeben (es sei denn, ein Befehl für die stille Ausgabe wie \"/achs\" wird verwendet)."
L["OPT_SLASHSEARCH_TIP2"] = "|cffffffffTabs-Modul mit Such-Tab wird benötigt.|r"
L["OPT_STARTTOAST_BONUS"] = "Zeigt die heutigen Bonus-Events"
L["OPT_STARTTOAST_BONUS_TIP"] = "Zeigt die heutigen Bonus-Events in Toast-Benachrichtigungen beim Betreten der Spielwelt an."
L["OPT_STARTTOAST_DUNGEON"] = "Zeigt die heutigen Dungeon-Events"
L["OPT_STARTTOAST_DUNGEON_TIP"] = "Zeigt die heutigen Dungeon-Events in Toast-Benachrichtigungen beim Betreten der Spielwelt an."
L["OPT_STARTTOAST_HOLIDAY"] = "Zeigt die heutigen Feiertage"
L["OPT_STARTTOAST_HOLIDAY_TIP"] = "Zeigt die heutigen Feiertage in Toast-Benachrichtigungen beim Betreten der Spielwelt an."
L["OPT_STARTTOAST_MICROHOLIDAY"] = "Zeigt die heutigen Mini-Feiertage"
L["OPT_STARTTOAST_MICROHOLIDAY_TIP"] = "Zeigt die heutigen Mini-Feiertage in Toast-Benachrichtigungen beim Betreten der Spielwelt an."
L["OPT_STARTTOAST_MISC"] = "Zeigt die heutigen sonstigen Feiertage an"
L["OPT_STARTTOAST_MISC_TIP"] = "Zeigt die heutigen sonstigen \"Feiertagsereignisse\" in Toast-Benachrichtigungen beim Betreten der Spielwelt an."
L["OPT_STARTTOAST_MISC_TIP2"] = "Es sind Events die im Standardkalender als \"Feiertage\" angegeben sind, aber weder als ganze Feiertage zählen noch in eine andere Kategorie hier passen. Beispiele wären hier die WoW-Geburtstage und Schlachtzugeröffnungstage (für neue Schlachtzüge oder Schwierigkeitsgrade aber nicht die wöchentlichen Zurücksetzungen)."
L["OPT_STARTTOAST_ONLYCLICKFADE"] = "Klick, um zu verbergen"
L["OPT_STARTTOAST_ONLYCLICKFADE_TIP"] = "Hindert Toast-Benachrichtigungen am Verblassen, wenn diese nicht links- oder rechtsgeklickt werden. (Wenn diese Option nicht aktiviert ist, werden sie auch verblassen, wenn der Mauszeiger über sie geht und sich dann wegbewegt)."
L["OPT_STARTTOAST_PVPBRAWL"] = "Zeigt die heutigen PvP-Raufereien an"
L["OPT_STARTTOAST_PVPBRAWL_TIP"] = "Zeigt die heutigen PvP-Raufereien in Toast-Benachrichtigungen beim Betreten der Spielwelt an."
L["OPT_STARTTOAST_TIMEFADE"] = "Nicht automatisch verbergen"
L["OPT_STARTTOAST_TIMEFADE_TIP"] = "Vermeidet, dass Toast-Benachrichtigungen, mit denen du nicht interagierst, nach ein paar Sekunden verblassen."
L["OPT_THROTTLE_ACHLOOKUP"] = "Beim Start: Erfolgesuche drosseln"
L["OPT_THROTTLE_ACHLOOKUP_TIP"] = "Overachiever sammelt beim Starten gewisse Daten. Wenn diese Option nicht ausgewählt ist, findet diese Durchsicht sofort, wenn das UI zum ersten Mal geladen wird, statt. Wenn dies ausgewählt ist, werden Daten nach und nach gesammelt, nachdem der Spieler die Welt betreten hat.|n|nDer Vorteil gegenüber der gebremsten Durchsicht besteht in einer schnelleren Anfangsladezeit, aber bei einigen Benutzern und bei manchen Charakteren kann sich das vorübergehend auf die Leistung auswirken."
L["OPT_THROTTLE_ACHLOOKUP_TIP2"] = "|nDer Vorteil der gedrosselten Suche ist eine schnellere anfängliche Ladezeit. Bei einigen Benutzern und einigen Charakteren kann dies jedoch zu Beginn einer Sitzung einige Sekunden lang die Leistung beeinträchtigen.|n|nWenn das |cffffffffCache-Modul|r aktiviert ist, wird die Ladezeit durch die Throttling-Funktion jedoch nicht wesentlich verbessert, es sei denn, der Cache muss neu erstellt werden. Der Cache wird nach jeder neuen WoW-Erstellung neu erstellt."
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING"] = "Noch zu kochende Rezepte kennzeichnen, um Erfolge vervollständigen zu können"
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING_TIP"] = "Wenn Overarchievers Handelsmodul aktiviert ist, erscheint ein Symbol neben den Rezepten, die noch gekocht werden müssen, um diverse Erfolge abzuschließen. Wenn die Option aktiviert ist, erscheinen diese Symbole auch dann noch neben ungekochten Rezepten, wenn der dazugehörige Erfolg schon abgeschlossen sein sollte. "
L["OPT_TURKEYLURKEYTIPS"] = "Truthahnbüchse angewendet?"
L["OPT_TURKEYLURKEYTIPS_TIP"] = "Wenn der Erfolg noch nicht abgeschlossen ist, wird im Tooltip eines Spielers der Hinweis angezeigt, ob bei ihm noch die Truthahnbüchse angewendet werden muss."
L["OPT_UI_HOLIDAYNOTICE"] = "Hinweis anzeigen, wenn ein festliches Ereignis stattfindet"
L["OPT_UI_HOLIDAYNOTICE_SUGGESTIONSTABONLY"] = "Nur im Vorschläge-Tab"
L["OPT_UI_HOLIDAYNOTICE_TIP"] = "Wenn ein festliches Ereignis stattfindet (z. B. Braufest oder Dunkelmond-Jahrmarkt), wird ein grafischer Hinweis neben dem Erfolgsfenster angezeigt. Wenn man darauf klickt, werden alle relevanten Erfolge des Ereignisses angezeigt. Bewege den Mauszeiger darüber, um mehr zu erfahren."
L["OPT_UI_HOLIDAYNOTICE_TIP2"] = "|cffffffffTabs-Modul mit Vorschläge-Tab wird benötigt.|r"
L["OPT_UI_PROGRESSIFOTHERCOMPLETED"] = "Tooltip für mengenbasierendem Fortschritt, wenn von anderem abgeschlossen"
L["OPT_UI_PROGRESSIFOTHERCOMPLETED_TIP"] = "Wenn der Mauszeiger über einem mengenbasierenden Erfolg ist (z. B. mit dem Kriterium \"Erhaltet 10 Reittiere\"), der von einem anderen Charakter abgeschlossen wurde, wird der Fortschritt des aktuellen Charakters angezeigt."
L["OPT_UI_REQUIREDFORMETATIP"] = "Tooltip für Erfolge, die Kriterien eines anderen Erfolgs sind"
L["OPT_UI_REQUIREDFORMETATIP_TIP"] = "Zeigt im Tooltip eines Erfolges den Namen des Meta-Erfolges an, den man mit diesem Erfolg abschließen kann."
L["OPT_UI_SERIESTIP"] = "Tooltip für Erfolge, die zu einer Serie von Erfolgen gehören"
L["OPT_UI_SERIESTIP_TIP"] = "Zeigt im Tooltip eines Erfolges, der zu einer Serie von Erfolgen gehört, die Namen der anderen und dessen Beziehung zu ihnen."
L["OPT_VEHICLERIDDENTIPS"] = "Fahrzeug/Kreatur geritten?"
L["OPT_VEHICLERIDDENTIPS_TIP"] = "Fügt eine Zeile zu den Tooltips von Fahrzeugen und Kreaturen hinzu, die du fahren musst, um einen Erfolg zu erzielen."
L["OPT_WELLREADTIPS"] = "Buch gelesen?"
L["OPT_WELLREADTIPS_TIP"] = "Wenn der Erfolg noch nicht abgeschlossen ist, wird im Tooltip eines Buches der Hinweis angezeigt, ob es für den Erfolg noch gelesen werden muss."
L["OPTPANEL_REMINDERTOOLTIPS"] = "Erinnerungshinweise"
L["OVERACHIEVER_INSTALLED_MSG"] = "|cff7eff00Overachiever|r v%s wurde installiert."
L["OVERACHIEVER_INSTALLED_TOAST"] = "OVERACHIEVER INSTALLIERT!"
L["OVERACHIEVER_UPDATED_MSG"] = "|cff7eff00Overachiever|r wurde auf v%s aktualisiert."
L["OVERACHIEVER_UPDATED_TOAST"] = "OVERACHIEVER AKTUALISIERT!"
L["PROGRESS"] = "Fortschritt"
L["PROGRESSIFOTHERCOMPLETED"] = "Fortschritt von %s:"
L["RECENTREMINDERCRITERIA"] = "Aktuell erkanntes Ziel:"
L["REQUIREDFORMETATIP"] = "Benötigt für:"
L["SERIESTIP"] = "Gehört zu einer Serie von Erfolgen:"
L["SOUND_AGGRO_PULLED"] = "Höchste Bedrohung"
L["SOUND_AGGRO_WARNING"] = "Bedrohungswarnung"
L["SOUND_ALARM1"] = "Wecker 1"
L["SOUND_ALARM2"] = "Wecker 2"
L["SOUND_ALARM3"] = "Wecker 3"
L["SOUND_BELL_ALLIANCE"] = "Glocke - Allianz"
L["SOUND_BELL_AUCTION"] = "Glocke - Auktionshaus"
L["SOUND_BELL_BOATARRIVED"] = "Glocke - Schiff angekommen"
L["SOUND_BELL_HORDE"] = "Glocke - Horde"
L["SOUND_BELL_KARA"] = "Glocke - Karazhan"
L["SOUND_BELL_MELLOW"] = "Helle Glocken"
L["SOUND_BELL_NIGHTELF"] = "Glocke - Nachtelf"
L["SOUND_BGTIMER"] = "Schlachtfeld-Timer"
L["SOUND_BGTIMER_END"] = "Schlachtfeld Countdown Ende"
L["SOUND_BONUSEVENT"] = "Bonus Event"
L["SOUND_CHAR_CREATE"] = "Charakter erstellen"
L["SOUND_DIGSITE_COMPLETE"] = "Grabungsstelle komplett"
L["SOUND_DING_AUCTION"] = "Auktion-Ding"
L["SOUND_DRUMHIT"] = "Trommelschlag"
L["SOUND_ENTERQUEUE"] = "Warteschlange beitreten"
L["SOUND_GARRISON_INVASION"] = "Garnisonsinvasion-Alarm"
L["SOUND_GLYPH_CREATE_MAJOR"] = "Erstellung einer erheblichen Glyphe"
L["SOUND_GLYPH_CREATE_MINOR"] = "Erstellung einer geringen Glyphe"
L["SOUND_GLYPH_DESTROY_MAJOR"] = "Zerstörung einer erheblichen Glyphe"
L["SOUND_GLYPH_DESTROY_MINOR"] = "Zerstörung einer geringen Glyphe"
L["SOUND_GONG_TROLL"] = "Gong - Troll"
L["SOUND_HEARTHBIND"] = "Ruhestein setzen"
L["SOUND_LEVELUP"] = "Level Up"
L["SOUND_MAP_PING"] = "Kartenping"
L["SOUND_MEDAL_EXPIRES"] = "Medaille abgelaufen"
L["SOUND_MEDAL_GOLDTOSILVER"] = "Medaille Gold zu Silber"
L["SOUND_MEDAL_SILVERTOBRONZE"] = "Medaille Silber zu Bronze"
L["SOUND_QUEST_COMPLETE"] = "Aufgabe abgeschlossen"
L["SOUND_SIMON_BADPRESS"] = "Simon schlechte Presse"
L["SOUND_SIMON_DING"] = "Simon Ding"
L["SOUND_SIMON_FAIL_LARGE"] = "Simon scheitern Groß"
L["SOUND_SIMON_FAIL_SMALL"] = "Simon scheitern Klein"
L["SOUND_SIMON_STARTGAME"] = "Simon Spielstart"
L["SOUND_SIMON_STARTLEVEL"] = "Simon Startlevel"
L["SOUND_STORE_CONFIRM"] = "Bestätigung speichern"
L["SOUND_YAR"] = "Yarrrr"
L["STARTTOAST_EVENT"] = "Findet heute statt"
L["WILDPET"] = "Wildtier"
L["YOURPROGRESS"] = "Dein Fortschritt"



elseif (locale == "frFR") then  -- French
-- Thanks to Atropyne (EU-Garona) for many of these translations:
L["ACH_ACQUIRE_COMPLETE"] = "Déjà acquis"
L["ACH_ACQUIRE_INCOMPLETE"] = "À besoin d'être acquis"
L["ACH_ACQUIRE_INCOMPLETE_EXTRA"] = "N'a pas été acquis"
L["ACH_ANGLER_COMPLETE"] = "Déjà pêché"
--[[Translation missing --]]
--[[ L["ACH_ANGLER_COUNT"] = ""--]] 
L["ACH_ANGLER_INCOMPLETE"] = "Doit être pêché"
L["ACH_BUNNYMAKER_COMPLETE"] = "A déjà utilisé les Fleurs printanières"
L["ACH_BUNNYMAKER_INCOMPLETE"] = "Doit utiliser les Fleurs printanières"
L["ACH_CHECKYOURHEAD_COMPLETE"] = "Déjà citrouillé"
L["ACH_CHECKYOURHEAD_INCOMPLETE"] = "Doit être citrouillé"
L["ACH_CONSUME_91_COMPLETE"] = "Gourmandise déjà prouvée"
L["ACH_CONSUME_91_INCOMPLETE"] = "Je te mets au défi d'en manger 91 d'un coup !"
L["ACH_CONSUME_COMPLETE"] = "Déjà consommé"
L["ACH_CONSUME_INCOMPLETE"] = "Doit être consommé"
L["ACH_CONSUME_INCOMPLETE_EXTRA"] = "N'a pas été consommé"
L["ACH_EATYOURGREENS_COMPLETE"] = "Déjà mangé"
L["ACH_EATYOURGREENS_INCOMPLETE"] = "Doit être mangé"
L["ACH_FISHSCHOOL_FORMAT"] = "Banc de %s"
L["ACH_FISTFULOFLOVE_COMPLETE"] = "A déjà reçu une Poignée de pétales de rose"
L["ACH_FISTFULOFLOVE_INCOMPLETE"] = "Doit recevoir une Poignée de pétales de rose"
L["ACH_LETITSNOW_COMPLETE"] = "A déjà reçu une Poignée de flocons de neige"
L["ACH_LETITSNOW_INCOMPLETE"] = "Doit lancer une Poignée de flocons de neige"
L["ACH_LOVECRITTERS_COMPLETE"] = "A déjà reçu de l' /amour"
L["ACH_LOVECRITTERS_INCOMPLETE"] = "A besoin d' /amour"
L["ACH_MISSIONCOMPLETE_COMPLETE"] = "Déjà complété"
L["ACH_MISSIONCOMPLETE_INCOMPLETE"] = "Doit être complété"
--[[Translation missing --]]
--[[ L["ACH_RIDE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_INCOMPLETE"] = ""--]] 
L["ACH_TURKEYLURKEY_COMPLETE"] = "Déjà Dindonisé"
L["ACH_TURKEYLURKEY_INCOMPLETE"] = "Doit être Dindonisé"
L["ACH_WELLREAD_COMPLETE"] = "Déjà lu"
L["ACH_WELLREAD_INCOMPLETE"] = "Doit être lu"
L["BINDING_NAME_OVERACHIEVER_TAB_SEARCH"] = "Ouvrir l'onglet de recherche"
L["BINDING_NAME_OVERACHIEVER_TAB_SUGGESTIONS"] = "Ouvrir l'onglet des suggestions"
L["BINDING_NAME_OVERACHIEVER_TAB_WATCH"] = "Ouvre l'onglet de suivi"
L["COMPLETEDATE"] = "Accompli le %1$d/%2$02d/%3$02d"
L["CRITTER"] = "Bestiole"
L["HOLIDAY_BREWFEST"] = "Fête des Brasseurs"
L["HOLIDAY_CHILDRENSWEEK"] = "Semaine des enfants"
L["HOLIDAY_DARKMOONFAIRE"] = "Foire de Sombrelune"
L["HOLIDAY_DAYOFTHEDEAD"] = "Jour des morts"
L["HOLIDAY_HALLOWSEND"] = "Sanssaint"
L["HOLIDAY_LOVEISINTHEAIR"] = "De l'amour dans l'air"
L["HOLIDAY_LUNARFESTIVAL"] = "Fête lunaire"
L["HOLIDAY_MIDSUMMER"] = "Fête du Feu du solstice d'été"
L["HOLIDAY_MIDSUMMER_SHORT"] = "Solstice d'été"
L["HOLIDAY_NOBLEGARDEN"] = "Le Jardin des nobles"
L["HOLIDAY_PIGRIMSBOUNTY"] = "Les Bienfaits du pèlerin"
L["HOLIDAY_PIRATESDAY"] = "Jour des pirates"
L["HOLIDAY_WINTERVEIL"] = "Voile d'hiver"
L["HOLIDAY_WINTERVEIL_SHORT"] = "Voile d'hiver"
L["INCOMPLETE"] = "Inachevés"
L["KILL_COMPLETE"] = "Déjà tué"
L["KILL_INCOMPLETE"] = "Doit tuer"
L["MSG_ACHNOTFOUND"] = "Haut fait introuvable."
--[[Translation missing --]]
--[[ L["MSG_CRITERIAPROGRESS"] = ""--]] 
L["MSG_INVALIDID"] = "Entrée invalide : aucun haut fait ne correspond à cette ID."
L["MSG_NAMENOTFOUND"] = "Aucun haut fait contenant le nom \"|cffffffff%s|r\" n'a été trouvé."
--[[Translation missing --]]
--[[ L["MSG_NOOPEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_NOOPEN_LIST"] = ""--]] 
L["MSG_NUMFOUNDLIST"] = "%s autres haut faits trouvés :"
L["MSG_ONEFOUND"] = "1 autre haut fait trouvé : "
L["MSG_OPENINGTO"] = "Ouverture de : "
--[[Translation missing --]]
--[[ L["MULTI_NEED"] = ""--]] 
L["OPT_ACHUNKNOWN"] = "<Inconnu>"
--[[Translation missing --]]
--[[ L["OPT_ACQUIREDTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_ACQUIREDTIPS_TIP"] = ""--]] 
L["OPT_ANGLERTIPS"] = "Ajoute à l'infobulle d'un banc de poisson s'il a déjà été pêché"
L["OPT_ANGLERTIPS_TIP"] = "Si le haut fait est inachevé, ajoute une ligne à l'infobulle des bancs de poissons concernés pour indiquer si vous devez y pêcher."
--[[Translation missing --]]
--[[ L["OPT_ANGLERTIPS_TIP_ALWAYS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACK_CRITERIATOAST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACK_CRITERIATOAST_TIP"] = ""--]] 
L["OPT_AUTOTRACKEXPLORE"] = "Suivi automatique des haut faits d'exploration quand vous voyagez"
L["OPT_AUTOTRACKEXPLORE_COMPLETED"] = "Inclure les haut faits accomplis"
L["OPT_AUTOTRACKEXPLORE_TIP"] = "Quand vous entrez dans une zone, active automatiquement le suivi du haut fait d'exploration associé. Ne s'active pas si vous suivez déjà autre chose qu'un autre haut fait d'exploration."
L["OPT_AUTOTRACKTIMED"] = "Suivi automatique des hauts faits chronométrés"
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACKTIMED_BG"] = ""--]] 
L["OPT_AUTOTRACKTIMED_TIP"] = "Active automatiquement le suivi des hauts faits chronométrés lorsque le décompte commence. Ne s'active pas si un autre haut fait est en cours de suivi à moins que celui-ci n'ait été activé par Overachiever."
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACKTIMED_TIP_BG"] = ""--]] 
L["OPT_BUNNYMAKERTIPS"] = "Ajoute si devez utiliser les Fleurs printanières"
L["OPT_BUNNYMAKERTIPS_TIP"] = "Si le haut fait est inachevé, ajoute une ligne à l'infobulle des joueurs des genre et niveau appropriés pour indiquer si vous devez encore utiliser les Fleurs printanières sur eux. Notez que les joueurs ennemis qui ont 10 niveaux de plus que vous ou davantage sont considérés comme étant au moins de niveau 18."
L["OPT_CHECKYOURHEADTIPS"] = "Ajoute si vous devez utiliser une citrouille de la Sanssaint lestée"
L["OPT_CHECKYOURHEADTIPS_TIP"] = "Si le haut fait n'est pas terminé, ajoute une ligne à l'infobulle des joueurs pour indiquer si vous devez encore utiliser une citrouille de la Sanssaint lestée sur eux."
L["OPT_CONSUMEITEMTIPS"] = "Ajoute à l'infobulle des objets s'ils doivent être consommés"
L["OPT_CONSUMEITEMTIPS_TIP"] = "Si le haut fait est inachevé, ajoute une ligne à l'infobulle des objets concernés pour indiquer si vous avez besoin de les consommer."
L["OPT_CONSUMEITEMTIPS_TIP2"] = "Les objets pour l'utilisation desquels votre niveau est insuffisant ne déclenchent pas de rappel sonore."
L["OPT_CONSUMEITEMTIPS_WHENCOMPLETE"] = "Afficher même si le haut fait est accompli."
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_CHATLOG"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_CHATLOG_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_SUGGEST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_SUGGEST_TIP"] = ""--]] 
L["OPT_CRITTERTIPS"] = "Ajouter le statut /amour dans l'infobulle des bestioles "
L["OPT_CRITTERTIPS_TIP"] = "Si ce haut fait est inachevé, ajoute une ligne à l'infobulle des bestioles concernées pour indiquer qu'elles ont toujours besoin d' /amour."
L["OPT_DRAGGABLE"] = "Rendre mobile"
L["OPT_DRAGSAVE"] = "Sauver la position"
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS_TIP"] = ""--]] 
L["OPT_FISTFULOFLOVETIPS"] = "Vous signale si vous avez besoin de lancer une Poignée de pétales de rose"
L["OPT_FISTFULOFLOVETIPS_TIP"] = "Si le haut fait est inachevé, ajoute une ligne à l'infobulle des joueurs des combinaisons race/classe concernées pour vous indiquer si vous devez utiliser une Poignée de pétales de rose sur eux."
L["OPT_KILLCREATURETIPS"] = "Ajoute si vous devez tuer une créature"
L["OPT_KILLCREATURETIPS_EXCLUDE_GUILD"] = "Exclure les hauts faits de guilde"
L["OPT_KILLCREATURETIPS_TIP"] = "Ajoute une ligne à l'infobulle des créatures (hormis les bestioles) qui doivent être tuées pour atteindre l'objectif d'un haut fait inachevé pour indiquer si vous devez encore les tuer."
L["OPT_KILLCREATURETIPS_TIP2"] = "Note : Au démarrage (ou lorsque cette option est activée) tous les hauts faits sont analysés afin de découvrir les IDs des \"unités\". Ils n'en fournissent pas tous. La plupart le font, mais les infobulles des créatures concernées par ceux qui ne le font pas ne seront pas affectées par cette option."
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_WHENCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_ACHFIVE"] = ""--]] 
L["OPT_LABEL_ACHFOUR"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\""
--[[Translation missing --]]
--[[ L["OPT_LABEL_ACHSEVEN"] = ""--]] 
L["OPT_LABEL_ACHSIX"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHTHREE"] = "\"%s,\" \"%s,\" et|n\"%s\""
L["OPT_LABEL_ACHTWO"] = "\"%s\" et \"%s\""
--[[Translation missing --]]
--[[ L["OPT_LABEL_CRITERIATOAST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_DRAENORANGLER"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_LOVECRITTER"] = ""--]] 
L["OPT_LABEL_MAINUI"] = "Modifications de l'IU principale des Hauts faits"
L["OPT_LABEL_MISC"] = "Divers"
L["OPT_LABEL_NEEDTOKILL"] = "Hauts faits d'élimination de monstres (\"%s,\" \"%s,\" etc.)"
L["OPT_LABEL_SEASONALACHS"] = "SAISON ACHEVÉES"
--[[Translation missing --]]
--[[ L["OPT_LABEL_STARTTOAST"] = ""--]] 
L["OPT_LABEL_TOOLTIPS"] = "Infobulles et liens des haut faits"
L["OPT_LABEL_TRACKING"] = "Suivi des haut faits"
L["OPT_LABEL_TRADESKILLUI"] = "Modifications de l'UI des professions"
L["OPT_LETITSNOWTIPS"] = "Vous signale si vous avez besoin de lancer une Poignée de flocons de neige"
L["OPT_LETITSNOWTIPS_TIP"] = "Si le haut fait est inachevé, ajoute une ligne à l'infobulle des joueurs des combinaisons de race/classe concernées pour vous indiquer si vous devez utiliser une Poignée de flocons de neige sur eux."
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_WHENCOMPLETE"] = ""--]] 
L["OPT_PESTCONTROLTIPS"] = "Ajoute à l'infobulle des nuisibles si vous les avez déjà exterminés"
L["OPT_PESTCONTROLTIPS_TIP"] = "Si ce haut fait est inachevé, ajoute une ligne à l'infobulle des nuisibles concernés pour indiquer si vous devez encore les exterminer."
L["OPT_SATISFIEDTIPS"] = "Satisfait à 1000% ?"
L["OPT_SATISFIEDTIPS_TIP"] = "Ajoute une ligne dans l'infobulle des objets qui font partie des critères de haut-fait et indiquer s'il faut les utiliser."
L["OPT_SELECTSOUND"] = "Rappel sonore de haut fait inachevé"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE"] = "Exclure les rappels des banc de poissons si une canne à pêche est équipée"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP"] = "Ne pas jouer le rappel sonore des bancs de poissons si votre canne à pêche est équipée."
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_CHECKCOMBAT"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_CHECKCOMBAT_TIP"] = ""--]] 
L["OPT_SELECTSOUND_TIP"] = "Jouer le son choisi lorsque le rappel d'un haut fait incomplet est ajouté à l'infobulle."
L["OPT_SELECTSOUND_TIP2"] = "Les sons ne seront joués qu'une fois toutes les 15 secondes."
L["OPT_SHOWID"] = "Montrer les IDs des hauts faits"
L["OPT_SHOWPROGRESS"] = "Ajouter votre progression"
L["OPT_SHOWPROGRESS_OTHER"] = "Comparer la progression via les liens d'autres joueurs"
L["OPT_SHOWPROGRESS_OTHER_TIP"] = "Ajouter votre progression quand les informations du haut fait affiché sont celles d'un autre joueur."
L["OPT_SHOWPROGRESS_TIP"] = "Ajouter votre progression quand un haut fait est basé sur une quantité, comme \"Obtenir 10 montures\"."
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_BONUS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_BONUS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_DUNGEON"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_DUNGEON_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_HOLIDAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_HOLIDAY_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MICROHOLIDAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MICROHOLIDAY_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_ONLYCLICKFADE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_ONLYCLICKFADE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_TIMEFADE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_TIMEFADE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP2"] = ""--]] 
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING"] = "Indique les recettes non préparées pour compléter les haut-faits"
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING_TIP"] = "Si le module Professions de Overachiever est activé, une icône de haut-fait apparaît près des recettes que vous devez cuisiner pour obtenir certains haut-faits. Si cette option est cochée, ces icônes apparaîtront près des recettes non préparées même si le haut-fait associé est déjà complété."
L["OPT_TURKEYLURKEYTIPS"] = "Dindoflingue utilisé ?"
L["OPT_TURKEYLURKEYTIPS_TIP"] = "Si le haut fait n'est pas terminé, ajoute une ligne à l'infobulle des joueurs pour indiquer si vous devez encore utiliser le Dindoflingue sur eux."
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE_SUGGESTIONSTABONLY"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_PROGRESSIFOTHERCOMPLETED"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_PROGRESSIFOTHERCOMPLETED_TIP"] = ""--]] 
L["OPT_UI_REQUIREDFORMETATIP"] = "Infobulle pour les hauts faits qui en requièrent d'autres"
L["OPT_UI_REQUIREDFORMETATIP_TIP"] = "Lorsque le curseur passe sur un haut fait qui est requis pour en accomplir un autre, affiche le nom du méta-haut fait."
L["OPT_UI_SERIESTIP"] = "Infobulle pour les hauts faits qui font partie d'une série"
L["OPT_UI_SERIESTIP_TIP"] = "Lorsque le curseur passe sur un haut fait qui fait partie d'une série, affiche le reste de la série et sa situation dans celle-ci."
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS_TIP"] = ""--]] 
L["OPT_WELLREADTIPS"] = "Ajoute à l'infobulle d'un livre si vous l'avez lu"
L["OPT_WELLREADTIPS_TIP"] = "Si le haut fait est inachevé, ajoute une ligne dans l'infobulle des livres concernés pour vous signaler si vous avez besoin de les lire."
L["OPTPANEL_REMINDERTOOLTIPS"] = "Rappel des info-bulles"
--[[Translation missing --]]
--[[ L["OVERACHIEVER_INSTALLED_MSG"] = ""--]] 
L["OVERACHIEVER_INSTALLED_TOAST"] = "OVERACHIEVER INSTALLÉ !"
--[[Translation missing --]]
--[[ L["OVERACHIEVER_UPDATED_MSG"] = ""--]] 
L["OVERACHIEVER_UPDATED_TOAST"] = "MISE À JOUR D'OVERACHIEVER !"
L["PROGRESS"] = "Progression"
--[[Translation missing --]]
--[[ L["PROGRESSIFOTHERCOMPLETED"] = ""--]] 
--[[Translation missing --]]
--[[ L["RECENTREMINDERCRITERIA"] = ""--]] 
L["REQUIREDFORMETATIP"] = "Requis pour :"
L["SERIESTIP"] = "Partie d'une série :"
--[[Translation missing --]]
--[[ L["SOUND_AGGRO_PULLED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_AGGRO_WARNING"] = ""--]] 
L["SOUND_ALARM1"] = "Alarme 1"
L["SOUND_ALARM2"] = "Alarme 2"
L["SOUND_ALARM3"] = "Alarme 3"
L["SOUND_BELL_ALLIANCE"] = "Cloche - Alliance"
L["SOUND_BELL_AUCTION"] = "Cloches de l'HV"
L["SOUND_BELL_BOATARRIVED"] = "Cloches - Le bateau a accosté"
L["SOUND_BELL_HORDE"] = "Cloche - Horde"
L["SOUND_BELL_KARA"] = "Cloche de Karazhan"
L["SOUND_BELL_MELLOW"] = "Cloches douces"
L["SOUND_BELL_NIGHTELF"] = "Cloche - Elfe de la nuit"
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER_END"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BONUSEVENT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_CHAR_CREATE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_DIGSITE_COMPLETE"] = ""--]] 
L["SOUND_DING_AUCTION"] = "Carillon - HV"
L["SOUND_DRUMHIT"] = "Battement de tambour"
L["SOUND_ENTERQUEUE"] = "Entrer dans la file"
--[[Translation missing --]]
--[[ L["SOUND_GARRISON_INVASION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_CREATE_MAJOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_CREATE_MINOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_DESTROY_MAJOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_DESTROY_MINOR"] = ""--]] 
L["SOUND_GONG_TROLL"] = "Gong - Troll"
L["SOUND_HEARTHBIND"] = "Son - Pierre de foyer"
L["SOUND_LEVELUP"] = "Niveau supérieur"
L["SOUND_MAP_PING"] = "Ping de la carte"
L["SOUND_MEDAL_EXPIRES"] = "La médaille expire"
L["SOUND_MEDAL_GOLDTOSILVER"] = "Médaille Or à Argent"
L["SOUND_MEDAL_SILVERTOBRONZE"] = "Médaille Argent à Bronze"
L["SOUND_QUEST_COMPLETE"] = "Quête complète"
--[[Translation missing --]]
--[[ L["SOUND_SIMON_BADPRESS"] = ""--]] 
L["SOUND_SIMON_DING"] = "Simon - Carillon"
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_LARGE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_SMALL"] = ""--]] 
L["SOUND_SIMON_STARTGAME"] = "Simon - Nouveau Jeu"
L["SOUND_SIMON_STARTLEVEL"] = "Simon - Nouveau Niveau"
L["SOUND_STORE_CONFIRM"] = "Confirmation du magasin"
L["SOUND_YAR"] = "Yarrrr"
L["STARTTOAST_EVENT"] = "Se passe aujourd'hui"
L["WILDPET"] = "Pet sauvage"
L["YOURPROGRESS"] = "Votre progression"



elseif (locale == "zhTW") then  -- Traditional Chinese
-- Thanks to user xyrho at wowinterface.com and laincat at curse.com for many of these translations:
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_INCOMPLETE_EXTRA"] = ""--]] 
L["ACH_ANGLER_COMPLETE"] = "已釣過"
--[[Translation missing --]]
--[[ L["ACH_ANGLER_COUNT"] = ""--]] 
L["ACH_ANGLER_INCOMPLETE"] = "未釣過"
L["ACH_BUNNYMAKER_COMPLETE"] = "已經使用春日鮮花"
L["ACH_BUNNYMAKER_INCOMPLETE"] = "需要使用春日鮮花"
L["ACH_CHECKYOURHEAD_COMPLETE"] = "已經使用增重的南瓜燈籠"
L["ACH_CHECKYOURHEAD_INCOMPLETE"] = "需要使用增重的南瓜燈籠"
--[[Translation missing --]]
--[[ L["ACH_CONSUME_91_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_CONSUME_91_INCOMPLETE"] = ""--]] 
L["ACH_CONSUME_COMPLETE"] = "已使用過"
L["ACH_CONSUME_INCOMPLETE"] = "需要使用"
L["ACH_CONSUME_INCOMPLETE_EXTRA"] = "未使用過"
--[[Translation missing --]]
--[[ L["ACH_EATYOURGREENS_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_EATYOURGREENS_INCOMPLETE"] = ""--]] 
L["ACH_FISHSCHOOL_FORMAT"] = "%s系"
L["ACH_FISTFULOFLOVE_COMPLETE"] = "已用過一把玫瑰花瓣"
L["ACH_FISTFULOFLOVE_INCOMPLETE"] = "需使用一把玫瑰花瓣"
L["ACH_LETITSNOW_COMPLETE"] = "已用過一捧雪花"
L["ACH_LETITSNOW_INCOMPLETE"] = "需使用一捧雪花"
L["ACH_LOVECRITTERS_COMPLETE"] = "已 /愛 過"
L["ACH_LOVECRITTERS_INCOMPLETE"] = "需要 /愛"
--[[Translation missing --]]
--[[ L["ACH_MISSIONCOMPLETE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_MISSIONCOMPLETE_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_INCOMPLETE"] = ""--]] 
L["ACH_TURKEYLURKEY_COMPLETE"] = "已經使用過火雞獵槍"
L["ACH_TURKEYLURKEY_INCOMPLETE"] = "需要使用火雞獵槍"
L["ACH_WELLREAD_COMPLETE"] = "已讀過"
L["ACH_WELLREAD_INCOMPLETE"] = "未讀過"
L["BINDING_NAME_OVERACHIEVER_TAB_SEARCH"] = "開啟搜尋標籤頁面"
L["BINDING_NAME_OVERACHIEVER_TAB_SUGGESTIONS"] = "開啟建議標籤頁面"
L["BINDING_NAME_OVERACHIEVER_TAB_WATCH"] = "開啟觀察標籤頁面"
L["COMPLETEDATE"] = "已完成 %2$d/%1$02d/%3$02d"
L["CRITTER"] = "小動物"
--[[Translation missing --]]
--[[ L["HOLIDAY_BREWFEST"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_CHILDRENSWEEK"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_DARKMOONFAIRE"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_DAYOFTHEDEAD"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_HALLOWSEND"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_LOVEISINTHEAIR"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_LUNARFESTIVAL"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_MIDSUMMER"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_MIDSUMMER_SHORT"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_NOBLEGARDEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_PIGRIMSBOUNTY"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_PIRATESDAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_WINTERVEIL"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_WINTERVEIL_SHORT"] = ""--]] 
L["INCOMPLETE"] = "未完成"
L["KILL_COMPLETE"] = "已擊殺"
L["KILL_INCOMPLETE"] = "需要擊殺"
L["MSG_ACHNOTFOUND"] = "找不到該成就。"
--[[Translation missing --]]
--[[ L["MSG_CRITERIAPROGRESS"] = ""--]] 
L["MSG_INVALIDID"] = "無效輸入：沒有成就有這編號。"
L["MSG_NAMENOTFOUND"] = "沒有包含 \"|cffffffff%s|r\" 的成就名稱被找到。"
--[[Translation missing --]]
--[[ L["MSG_NOOPEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_NOOPEN_LIST"] = ""--]] 
L["MSG_NUMFOUNDLIST"] = "另外找到 %s 項成就："
L["MSG_ONEFOUND"] = "找到 1 項成就："
L["MSG_OPENINGTO"] = "開啟："
--[[Translation missing --]]
--[[ L["MULTI_NEED"] = ""--]] 
L["OPT_ACHUNKNOWN"] = "<未知>"
--[[Translation missing --]]
--[[ L["OPT_ACQUIREDTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_ACQUIREDTIPS_TIP"] = ""--]] 
L["OPT_ANGLERTIPS"] = "提示魚點是否釣過？"
L["OPT_ANGLERTIPS_TIP"] = "如果成就有缺少，新增一行提示到魚點的標準說明從任何你需要來釣魚的魚點。"
--[[Translation missing --]]
--[[ L["OPT_ANGLERTIPS_TIP_ALWAYS"] = ""--]] 
L["OPT_AUTOTRACK_CRITERIATOAST"] = "自動追蹤彈出的 \"成就進度\""
L["OPT_AUTOTRACK_CRITERIATOAST_TIP"] = "\"成就進度\" 訊息彈出時，自動追蹤成就 (沒有超過追蹤數量上限時)。"
L["OPT_AUTOTRACKEXPLORE"] = "自動追蹤探索成就"
L["OPT_AUTOTRACKEXPLORE_COMPLETED"] = "包括已完成的成就"
L["OPT_AUTOTRACKEXPLORE_TIP"] = "轉換地圖時自動追蹤該區域探索成就。"
L["OPT_AUTOTRACKTIMED"] = "自動追蹤計時相關的成就 (戰場除外)"
L["OPT_AUTOTRACKTIMED_BG"] = "自動追蹤計時相關的戰場成就"
L["OPT_AUTOTRACKTIMED_TIP"] = "開始計時的時候自動追蹤有時間限制標準的成就。如果已經達到能夠追蹤的成就數量上限，會嘗試取代自動追蹤的探索成就；否則將不會被追蹤。|n|n不包含需要戰場勝利的成就。"
L["OPT_AUTOTRACKTIMED_TIP_BG"] = "戰場配對開始時，自動追蹤在特定時間內勝利的成就 (如果尚未完成的話)。|n|n離開戰場時會取消追蹤成就。"
L["OPT_BUNNYMAKERTIPS"] = "新增任何你需要許用春日鮮花"
L["OPT_BUNNYMAKERTIPS_TIP"] = "如果這個成就尚未完成，在18級以上女性玩家的提示訊息中提示你是否需要對她使用春日鮮花。注意假如是大於你10級的敵對角色，會被假設為至少18級。"
L["OPT_CHECKYOURHEADTIPS"] = "提示是否需要使用增重的南瓜燈籠"
L["OPT_CHECKYOURHEADTIPS_TIP"] = "如果這個成就尚未完成，在玩家的提示訊息中提示你是否需要對他使用增重的南瓜燈籠。"
L["OPT_CONSUMEITEMTIPS"] = "提示食物是否吃過？"
L["OPT_CONSUMEITEMTIPS_TIP"] = "增加食物提示說明"
L["OPT_CONSUMEITEMTIPS_TIP2"] = "如果你的等級不足以食用這個物品時，將不做提示"
L["OPT_CONSUMEITEMTIPS_WHENCOMPLETE"] = "完成後是否繼續提示"
L["OPT_CRITERIATOAST_CHATLOG"] = "新增到聊天內容"
L["OPT_CRITERIATOAST_CHATLOG_TIP"] = "\"成就進度\" 訊息彈出時，連結成就並且在聊天內容中顯示達成條件。"
L["OPT_CRITERIATOAST_SUGGEST"] = "新增到近期提醒 (建議)"
L["OPT_CRITERIATOAST_SUGGEST_TIP"] = "\"成就進度\" 訊息彈出時，將成就暫時加入到建議標籤頁做為 \"近期提醒\"。"
L["OPT_CRITTERTIPS"] = "提示小動物是否愛過"
L["OPT_CRITTERTIPS_TIP"] = "在小動物的提示說明中註明."
L["OPT_DRAGGABLE"] = "可拖曳移動"
L["OPT_DRAGSAVE"] = "記住視窗位置"
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS_TIP"] = ""--]] 
L["OPT_FISTFULOFLOVETIPS"] = "提示是否需要使用一把玫瑰花瓣"
L["OPT_FISTFULOFLOVETIPS_TIP"] = "增加玩家提示說明。"
L["OPT_KILLCREATURETIPS"] = "新增您是否需要殺死的怪物"
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_EXCLUDE_GUILD"] = ""--]] 
L["OPT_KILLCREATURETIPS_TIP"] = "新增一行動物提示(不包括小動物 )需要加以殺害，以符合標準的未完成的成就說明，表明您是否仍然需要殺死他們。"
L["OPT_KILLCREATURETIPS_TIP2"] = "注意：在啟動時(或是這設定啟用)，每個成就會被掃描來找出單位編號。並非所有成就提供編號。大部分如此，但是其中的生物的提示不會因為這設定而有改變。"
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_WHENCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_ACHFIVE"] = ""--]] 
L["OPT_LABEL_ACHFOUR"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\""
--[[Translation missing --]]
--[[ L["OPT_LABEL_ACHSEVEN"] = ""--]] 
L["OPT_LABEL_ACHSIX"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHTHREE"] = "\"%s,\" \"%s,\" 和 \"%s\""
L["OPT_LABEL_ACHTWO"] = "\"%s\" 和 \"%s\""
L["OPT_LABEL_CRITERIATOAST"] = "進度相關動作 (不追蹤)"
--[[Translation missing --]]
--[[ L["OPT_LABEL_DRAENORANGLER"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_LOVECRITTER"] = ""--]] 
L["OPT_LABEL_MAINUI"] = "成就視窗微調"
--[[Translation missing --]]
--[[ L["OPT_LABEL_MISC"] = ""--]] 
L["OPT_LABEL_NEEDTOKILL"] = "擊殺怪物成就 (\"%s\",\"%s\",及其他)"
L["OPT_LABEL_SEASONALACHS"] = "世界事件成就"
L["OPT_LABEL_STARTTOAST"] = "節慶/事件彈出通知"
L["OPT_LABEL_TOOLTIPS"] = "成就提示和連結"
L["OPT_LABEL_TRACKING"] = "成就追蹤"
L["OPT_LABEL_TRADESKILLUI"] = "專業視窗微調"
L["OPT_LETITSNOWTIPS"] = "提示是否需要使用一捧雪花？"
L["OPT_LETITSNOWTIPS_TIP"] = "如果成就尚未完成，在適當種族與職業組合玩家的提示訊息中提示你是否需要使用一捧雪花。"
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_WHENCOMPLETE"] = ""--]] 
L["OPT_PESTCONTROLTIPS"] = "顯示是否需要擊殺害蟲的提示"
L["OPT_PESTCONTROLTIPS_TIP"] = "如果這個成就尚未完成，在那些害蟲的提示訊息中提示你是否需要擊殺牠們。"
L["OPT_SATISFIEDTIPS"] = "1000%滿足?"
--[[Translation missing --]]
--[[ L["OPT_SATISFIEDTIPS_TIP"] = ""--]] 
L["OPT_SELECTSOUND"] = "缺少成就提醒音效"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE"] = "裝備魚竿時不提示釣魚成就"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP"] = "裝備魚竿時不聲音提示釣魚成就"
L["OPT_SELECTSOUND_CHECKCOMBAT"] = "戰鬥對象正確時不提示擊殺成就"
L["OPT_SELECTSOUND_CHECKCOMBAT_TIP"] = "正在與成就所需要擊殺的生物戰鬥時，不要播放提醒音效。"
L["OPT_SELECTSOUND_TIP"] = "在發現一個需要完成的成就提示時播出提示音效"
L["OPT_SELECTSOUND_TIP2"] = "這個聲音每15秒只會出現1次"
L["OPT_SHOWID"] = "顯示成就ID"
L["OPT_SHOWPROGRESS"] = "顯示進度"
L["OPT_SHOWPROGRESS_OTHER"] = "比較其他人的進度連結"
L["OPT_SHOWPROGRESS_OTHER_TIP"] = "在別人的成就訊息連結說明中顯示自己的進度."
L["OPT_SHOWPROGRESS_TIP"] = "在提示說明中顯示成就進度."
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TIP2"] = ""--]] 
L["OPT_STARTTOAST_BONUS"] = "顯示今天的獎勵事件"
L["OPT_STARTTOAST_BONUS_TIP"] = "進入遊戲時顯示今天的獎勵事件彈出通知。"
L["OPT_STARTTOAST_DUNGEON"] = "顯示今天的地城事件"
L["OPT_STARTTOAST_DUNGEON_TIP"] = "進入遊戲時顯示今天的地城事件彈出通知。"
L["OPT_STARTTOAST_HOLIDAY"] = "顯示今天的節慶"
L["OPT_STARTTOAST_HOLIDAY_TIP"] = "進入遊戲時顯示顯示今天的節慶彈出通知。"
L["OPT_STARTTOAST_MICROHOLIDAY"] = "顯示今天的小型節慶"
L["OPT_STARTTOAST_MICROHOLIDAY_TIP"] = "進入遊戲時顯示今天的小型節慶彈出通知。"
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP2"] = ""--]] 
L["OPT_STARTTOAST_ONLYCLICKFADE"] = "需要滑鼠點擊來隱藏通知"
L["OPT_STARTTOAST_ONLYCLICKFADE_TIP"] = "彈出通知不會自動消失除非使用滑鼠左鍵或右鍵點擊。 (停用時，滑鼠游標指向通知然後移開便會消失。)"
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL_TIP"] = ""--]] 
L["OPT_STARTTOAST_TIMEFADE"] = "不要自動隱藏"
L["OPT_STARTTOAST_TIMEFADE_TIP"] = "避免尚未使用滑鼠指向或點擊的彈出通知在幾秒後隱藏。"
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP2"] = ""--]] 
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING"] = "標示未烹飪食譜來完成成就"
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING_TIP"] = "如果Overachiever_Trade模組啟用，那麼成就圖示顯示在你需要烹飪的食譜旁邊為了獲得一些成就。如果設定被勾選，那麼這些圖示會顯示在未被烹飪食譜旁邊即使相關成就已經完成。"
L["OPT_TURKEYLURKEYTIPS"] = "提示是否需要使用火雞獵槍"
L["OPT_TURKEYLURKEYTIPS_TIP"] = "如果成就尚未完成，在玩家的提示訊息中提示你是否需要對他使用火雞獵槍。"
L["OPT_UI_HOLIDAYNOTICE"] = "節慶事件開始時顯示提醒通知"
L["OPT_UI_HOLIDAYNOTICE_SUGGESTIONSTABONLY"] = "只顯示於建議標籤頁面"
L["OPT_UI_HOLIDAYNOTICE_TIP"] = "如果今天有節慶事件 (例如 啤酒節 或 暗月馬戲團)，成就介面旁會顯示提醒通知的圖形。點一下通知圖形顯示這個事件的成就，滑鼠指向時會顯示更多詳細說明。"
L["OPT_UI_HOLIDAYNOTICE_TIP2"] = "|cffffffff需要載入標籤頁模組和建議標籤頁面。|r"
L["OPT_UI_PROGRESSIFOTHERCOMPLETED"] = "滑鼠提示中顯示當前角色的數量進度"
L["OPT_UI_PROGRESSIFOTHERCOMPLETED_TIP"] = "滑鼠指向以數量為主的成就 (例如 \"獲得10個坐騎\") 若是由其他角色完成，當前的角色尚未完成，仍要顯示當前角色的進度。"
L["OPT_UI_REQUIREDFORMETATIP"] = "顯示其他需要此成就來完成的提示"
L["OPT_UI_REQUIREDFORMETATIP_TIP"] = "當游標位於一個成就，需要獲得的另一項成就，顯示成就樹名稱。"
L["OPT_UI_SERIESTIP"] = "顯示系列成就的提示"
L["OPT_UI_SERIESTIP_TIP"] = "當滑鼠指向一個系列成就時，顯示系列中其他成就的名字和與目前成就的關係"
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS_TIP"] = ""--]] 
L["OPT_WELLREADTIPS"] = "提示書本是否閱讀過"
L["OPT_WELLREADTIPS_TIP"] = "增加書本提示說明."
L["OPTPANEL_REMINDERTOOLTIPS"] = "滑鼠提示提醒"
--[[Translation missing --]]
--[[ L["OVERACHIEVER_INSTALLED_MSG"] = ""--]] 
--[[Translation missing --]]
--[[ L["OVERACHIEVER_INSTALLED_TOAST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OVERACHIEVER_UPDATED_MSG"] = ""--]] 
--[[Translation missing --]]
--[[ L["OVERACHIEVER_UPDATED_TOAST"] = ""--]] 
L["PROGRESS"] = "進度"
L["PROGRESSIFOTHERCOMPLETED"] = "%s的進度"
--[[Translation missing --]]
--[[ L["RECENTREMINDERCRITERIA"] = ""--]] 
L["REQUIREDFORMETATIP"] = "需要："
L["SERIESTIP"] = "系列成就:"
--[[Translation missing --]]
--[[ L["SOUND_AGGRO_PULLED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_AGGRO_WARNING"] = ""--]] 
L["SOUND_ALARM1"] = "鬧鈴聲 1"
L["SOUND_ALARM2"] = "鬧鈴聲 2"
L["SOUND_ALARM3"] = "鬧鈴聲 3"
L["SOUND_BELL_ALLIANCE"] = "提示音效 - 聯盟"
L["SOUND_BELL_AUCTION"] = "拍賣場音效"
L["SOUND_BELL_BOATARRIVED"] = "提示音效 - 船進港時"
L["SOUND_BELL_HORDE"] = "提示音效 - 部落"
L["SOUND_BELL_KARA"] = "卡拉贊音效"
L["SOUND_BELL_MELLOW"] = "柔和的鈴聲"
L["SOUND_BELL_NIGHTELF"] = "提示音效 - 夜精靈"
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER_END"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BONUSEVENT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_CHAR_CREATE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_DIGSITE_COMPLETE"] = ""--]] 
L["SOUND_DING_AUCTION"] = "拍賣場音效"
L["SOUND_DRUMHIT"] = "擊鼓聲"
L["SOUND_ENTERQUEUE"] = "進入佇列"
--[[Translation missing --]]
--[[ L["SOUND_GARRISON_INVASION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_CREATE_MAJOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_CREATE_MINOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_DESTROY_MAJOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_DESTROY_MINOR"] = ""--]] 
L["SOUND_GONG_TROLL"] = "銅鑼音效"
L["SOUND_HEARTHBIND"] = "爐石束縛"
--[[Translation missing --]]
--[[ L["SOUND_LEVELUP"] = ""--]] 
L["SOUND_MAP_PING"] = "點擊地圖音效"
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_EXPIRES"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_GOLDTOSILVER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_SILVERTOBRONZE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_QUEST_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_BADPRESS"] = ""--]] 
L["SOUND_SIMON_DING"] = "賽門音效"
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_LARGE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_SMALL"] = ""--]] 
L["SOUND_SIMON_STARTGAME"] = "賽門遊戲開始音效"
L["SOUND_SIMON_STARTLEVEL"] = "賽門等級開始音效"
--[[Translation missing --]]
--[[ L["SOUND_STORE_CONFIRM"] = ""--]] 
L["SOUND_YAR"] = "Yarrrr音效"
L["STARTTOAST_EVENT"] = "今日正在舉行"
--[[Translation missing --]]
--[[ L["WILDPET"] = ""--]] 
L["YOURPROGRESS"] = "你的進度"



elseif (locale == "zhCN") then  -- Simplified Chinese
-- Thanks to user Miste(晨光麦) at wowinterface.com and yeah-chen and chrisccc at curse.com for many of these translations:
L["ACH_ACQUIRE_COMPLETE"] = "已获得"
L["ACH_ACQUIRE_INCOMPLETE"] = "需要获得"
L["ACH_ACQUIRE_INCOMPLETE_EXTRA"] = "未获得"
L["ACH_ANGLER_COMPLETE"] = "已钓过"
--[[Translation missing --]]
--[[ L["ACH_ANGLER_COUNT"] = ""--]] 
L["ACH_ANGLER_INCOMPLETE"] = "未钓过"
L["ACH_BUNNYMAKER_COMPLETE"] = "已使用过春季花束"
L["ACH_BUNNYMAKER_INCOMPLETE"] = "需要使用春季花束"
L["ACH_CHECKYOURHEAD_COMPLETE"] = "已使用过沉重的南瓜灯"
L["ACH_CHECKYOURHEAD_INCOMPLETE"] = "需要使用沉重的南瓜灯"
L["ACH_CONSUME_91_COMPLETE"] = "已经获得1000%的满足感"
L["ACH_CONSUME_91_INCOMPLETE"] = "一次吃掉91块曲奇！"
L["ACH_CONSUME_COMPLETE"] = "已使用过"
L["ACH_CONSUME_INCOMPLETE"] = "需要使用"
L["ACH_CONSUME_INCOMPLETE_EXTRA"] = "未使用过"
--[[Translation missing --]]
--[[ L["ACH_EATYOURGREENS_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_EATYOURGREENS_INCOMPLETE"] = ""--]] 
L["ACH_FISHSCHOOL_FORMAT"] = "群"
L["ACH_FISTFULOFLOVE_COMPLETE"] = "已使用过一堆玫瑰花瓣"
L["ACH_FISTFULOFLOVE_INCOMPLETE"] = "需要使用一堆玫瑰花瓣"
L["ACH_LETITSNOW_COMPLETE"] = "已使用过一捧雪花"
L["ACH_LETITSNOW_INCOMPLETE"] = "需要使用一捧雪花"
L["ACH_LOVECRITTERS_COMPLETE"] = "已 /爱 过"
L["ACH_LOVECRITTERS_INCOMPLETE"] = "需要 /爱"
L["ACH_MISSIONCOMPLETE_COMPLETE"] = "此前已完成"
L["ACH_MISSIONCOMPLETE_INCOMPLETE"] = "需要完成"
--[[Translation missing --]]
--[[ L["ACH_RIDE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_INCOMPLETE"] = ""--]] 
L["ACH_TURKEYLURKEY_COMPLETE"] = "已使用过火鸡枪"
L["ACH_TURKEYLURKEY_INCOMPLETE"] = "需要使用火鸡枪"
L["ACH_WELLREAD_COMPLETE"] = "已读过"
L["ACH_WELLREAD_INCOMPLETE"] = "未读过"
L["BINDING_NAME_OVERACHIEVER_TAB_SEARCH"] = "打开搜索标签"
L["BINDING_NAME_OVERACHIEVER_TAB_SUGGESTIONS"] = "打开建议标签"
L["BINDING_NAME_OVERACHIEVER_TAB_WATCH"] = "打开监视标签"
L["COMPLETEDATE"] = "完成于 %3$d-%2$02d-%1$02d"
L["CRITTER"] = "小动物"
L["HOLIDAY_BREWFEST"] = "美酒节"
L["HOLIDAY_CHILDRENSWEEK"] = "儿童周"
L["HOLIDAY_DARKMOONFAIRE"] = "暗月马戏团"
L["HOLIDAY_DAYOFTHEDEAD"] = "悼念日"
L["HOLIDAY_HALLOWSEND"] = "万圣节"
L["HOLIDAY_LOVEISINTHEAIR"] = "情人节"
L["HOLIDAY_LUNARFESTIVAL"] = "春节"
L["HOLIDAY_MIDSUMMER"] = "仲夏火焰节"
L["HOLIDAY_MIDSUMMER_SHORT"] = "仲夏"
L["HOLIDAY_NOBLEGARDEN"] = "复活节"
L["HOLIDAY_PIGRIMSBOUNTY"] = "感恩节"
L["HOLIDAY_PIRATESDAY"] = "海盗节"
L["HOLIDAY_WINTERVEIL"] = "冬幕节盛会"
L["HOLIDAY_WINTERVEIL_SHORT"] = "冬幕节"
L["INCOMPLETE"] = "未完成"
L["KILL_COMPLETE"] = "已经击杀"
L["KILL_INCOMPLETE"] = "需要击杀"
L["MSG_ACHNOTFOUND"] = "找不到该成就。"
L["MSG_CRITERIAPROGRESS"] = "|cff7eff00成就进度:|r %s (%s)"
L["MSG_INVALIDID"] = "无效输入：没有此成就ID。"
L["MSG_NAMENOTFOUND"] = "找不到含有 \"|cffffffff%s|r\" 的成就。"
L["MSG_NOOPEN"] = "无法打开至一项成就。在UI中无可见的。"
L["MSG_NOOPEN_LIST"] = "%s |4成就：成就；已找到："
L["MSG_NUMFOUNDLIST"] = "另外找到%s项成就："
L["MSG_ONEFOUND"] = "找到1项成就："
L["MSG_OPENINGTO"] = "开启："
L["MULTI_NEED"] = "%s (还需要 %s 成就)"
L["OPT_ACHUNKNOWN"] = "<未知>"
L["OPT_ACQUIREDTIPS"] = "获得物品？"
--[[Translation missing --]]
--[[ L["OPT_ACQUIREDTIPS_TIP"] = ""--]] 
L["OPT_ANGLERTIPS"] = "提示渔点是否钓过"
L["OPT_ANGLERTIPS_TIP"] = "提示渔点是否钓过。"
--[[Translation missing --]]
--[[ L["OPT_ANGLERTIPS_TIP_ALWAYS"] = ""--]] 
L["OPT_AUTOTRACK_CRITERIATOAST"] = "自动追踪奖杯的\"成就进度\""
L["OPT_AUTOTRACK_CRITERIATOAST_TIP"] = "当奖杯的\"成就进度\"出现时，自动追踪该成就(假如允许追踪的话)."
L["OPT_AUTOTRACKEXPLORE"] = "自动追踪探索成就"
L["OPT_AUTOTRACKEXPLORE_COMPLETED"] = "包括已完成的成就"
L["OPT_AUTOTRACKEXPLORE_TIP"] = "转换地图时自动追踪该区域探索成就。"
L["OPT_AUTOTRACKTIMED"] = "自动追踪计时成就"
L["OPT_AUTOTRACKTIMED_BG"] = "自动追踪战场成就"
L["OPT_AUTOTRACKTIMED_TIP"] = "自动在计时成就开始时显示时限。"
L["OPT_AUTOTRACKTIMED_TIP_BG"] = "当战场开始时，自动追踪成就完成所需的时间(如果它还没被完成的话)。|n|n该成就追踪会在离开战场后停止。"
L["OPT_BUNNYMAKERTIPS"] = "提示是否需要使用春季花束"
L["OPT_BUNNYMAKERTIPS_TIP"] = "提示是否需要使用春季花束。"
L["OPT_CHECKYOURHEADTIPS"] = "提示是否需要使用沉重的南瓜灯"
L["OPT_CHECKYOURHEADTIPS_TIP"] = "提示是否需要使用沉重的南瓜灯。"
L["OPT_CONSUMEITEMTIPS"] = "提示食物是否吃过"
L["OPT_CONSUMEITEMTIPS_TIP"] = "增加食物提示说明。"
L["OPT_CONSUMEITEMTIPS_TIP2"] = "如果你的等级不足以食用这个食物时，将不做提示。"
L["OPT_CONSUMEITEMTIPS_WHENCOMPLETE"] = "完成后继续提示"
L["OPT_CRITERIATOAST_CHATLOG"] = "添加到聊天记录"
L["OPT_CRITERIATOAST_CHATLOG_TIP"] = "当\"成就进度\"的奖杯出现时，链接到成就和显示完成方式在聊天记录中。"
L["OPT_CRITERIATOAST_SUGGEST"] = "添加到最近的提醒 (建议)"
L["OPT_CRITERIATOAST_SUGGEST_TIP"] = "当\"成就进度\"的奖杯出现时， 临时添加成就的建议标签作为一个\"最近的提醒\"。"
L["OPT_CRITTERTIPS"] = "提示小动物是否被 /爱 过"
L["OPT_CRITTERTIPS_TIP"] = "增加小动物提示说明。"
L["OPT_DRAGGABLE"] = "解锁"
L["OPT_DRAGSAVE"] = "记住位置"
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS_TIP"] = ""--]] 
L["OPT_FISTFULOFLOVETIPS"] = "提示是否需要使用一堆玫瑰花瓣"
L["OPT_FISTFULOFLOVETIPS_TIP"] = "提示是否需要使用一堆玫瑰花瓣。"
L["OPT_KILLCREATURETIPS"] = "新增需要杀死的怪物"
L["OPT_KILLCREATURETIPS_EXCLUDE_GUILD"] = "排除公会成就"
L["OPT_KILLCREATURETIPS_TIP"] = "新增需要杀死的怪物提示（不包括小动物）。"
L["OPT_KILLCREATURETIPS_TIP2"] = "Note: At startup (or when this is option is enabled), every achievement is scanned to find unit IDs. Not all achievements provide such IDs. Most do, but the tooltips of creatures which are the criteria of those that don't won't be altered by this option."
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_WHENCOMPLETE"] = ""--]] 
L["OPT_LABEL_ACHFIVE"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s\""
L["OPT_LABEL_ACHFOUR"] = "\"%s\"、\"%s\"、|n\"%s\"、\"%s\""
L["OPT_LABEL_ACHSEVEN"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s,\" \"%s,\" \"%s\""
L["OPT_LABEL_ACHSIX"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHTHREE"] = "\"%s\"、\"%s\"和|n\"%s\""
L["OPT_LABEL_ACHTWO"] = "\"%s\"和\"%s\""
L["OPT_LABEL_CRITERIATOAST"] = "进度反馈 (非跟踪)"
L["OPT_LABEL_DRAENORANGLER"] = "\"%s\" 子成就"
--[[Translation missing --]]
--[[ L["OPT_LABEL_LOVECRITTER"] = ""--]] 
L["OPT_LABEL_MAINUI"] = "主成就界面修改"
L["OPT_LABEL_MISC"] = "杂项"
L["OPT_LABEL_NEEDTOKILL"] = "击杀怪物成就（\"%s\"、\"%s\"及其它）"
L["OPT_LABEL_SEASONALACHS"] = "节日成就"
L["OPT_LABEL_STARTTOAST"] = "节日/事件庆典"
L["OPT_LABEL_TOOLTIPS"] = "成就提示和链接"
L["OPT_LABEL_TRACKING"] = "成就追踪"
L["OPT_LABEL_TRADESKILLUI"] = "专业技能窗口修改"
L["OPT_LETITSNOWTIPS"] = "提示是否需要使用一捧雪花"
L["OPT_LETITSNOWTIPS_TIP"] = "提示是否需要使用一捧雪花。"
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_WHENCOMPLETE"] = ""--]] 
L["OPT_PESTCONTROLTIPS"] = "提示是否需要击杀害虫"
L["OPT_PESTCONTROLTIPS_TIP"] = "提示是否需要击杀害虫。"
L["OPT_SATISFIEDTIPS"] = "提示是否需要吃曲奇"
L["OPT_SATISFIEDTIPS_TIP"] = "提示是否需要连续吃91块曲奇。"
L["OPT_SELECTSOUND"] = "未完成成就提示音效"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE"] = "装备鱼竿时不提示钓鱼成就"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP"] = "装备鱼竿时不声音提示钓鱼成就。"
L["OPT_SELECTSOUND_CHECKCOMBAT"] = "额外击杀提示， 假如在与生物战斗中"
L["OPT_SELECTSOUND_CHECKCOMBAT_TIP"] = "不要在战斗中击杀特定的怪物时播放提醒声音。"
L["OPT_SELECTSOUND_TIP"] = "在发现一个需要完成的成就时播放提示音。"
L["OPT_SELECTSOUND_TIP2"] = "每15秒此音效只会出现一次。"
L["OPT_SHOWID"] = "显示成就ID"
L["OPT_SHOWPROGRESS"] = "显示进度"
L["OPT_SHOWPROGRESS_OTHER"] = "与其他人的进度链接进行比较"
L["OPT_SHOWPROGRESS_OTHER_TIP"] = "在別人的成就链接说明中显示自己的进度。"
L["OPT_SHOWPROGRESS_TIP"] = "在提示说明中显示成就进度。"
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TIP2"] = ""--]] 
L["OPT_STARTTOAST_BONUS"] = "显示今日奖励事件"
L["OPT_STARTTOAST_BONUS_TIP"] = "在进入游戏时，会以通知形式显示今天的奖励事件。"
L["OPT_STARTTOAST_DUNGEON"] = "显示今天的地下城事件"
L["OPT_STARTTOAST_DUNGEON_TIP"] = "在进入游戏时，显示今天的地下城事件。"
L["OPT_STARTTOAST_HOLIDAY"] = "显示今天的节日"
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_HOLIDAY_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MICROHOLIDAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MICROHOLIDAY_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP2"] = ""--]] 
L["OPT_STARTTOAST_ONLYCLICKFADE"] = "需要点击隐藏"
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_ONLYCLICKFADE_TIP"] = ""--]] 
L["OPT_STARTTOAST_PVPBRAWL"] = "显示今天的PvP乱斗"
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL_TIP"] = ""--]] 
L["OPT_STARTTOAST_TIMEFADE"] = "不要自动隐藏"
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_TIMEFADE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP2"] = ""--]] 
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING"] = "已完成的烹饪成就仍然提示"
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING_TIP"] = "即使烹饪成就已完成，仍然在技能旁显示提示图标。"
L["OPT_TURKEYLURKEYTIPS"] = "提示是否需要使用火鸡枪"
L["OPT_TURKEYLURKEYTIPS_TIP"] = "提示是否需要使用火鸡枪。"
L["OPT_UI_HOLIDAYNOTICE"] = "如果节日事件是进行中的则显示通知"
L["OPT_UI_HOLIDAYNOTICE_SUGGESTIONSTABONLY"] = "只限于tab建议"
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE_TIP"] = ""--]] 
L["OPT_UI_HOLIDAYNOTICE_TIP2"] = "|cffffffffTab建议是必须的tab模块.|r"
L["OPT_UI_PROGRESSIFOTHERCOMPLETED"] = "数量进度会显示在鼠标提示上，假如完成另一个"
--[[Translation missing --]]
--[[ L["OPT_UI_PROGRESSIFOTHERCOMPLETED_TIP"] = ""--]] 
L["OPT_UI_REQUIREDFORMETATIP"] = "提示成就树"
L["OPT_UI_REQUIREDFORMETATIP_TIP"] = "当鼠标滑过一个需要先决条件的成就时，显示成就树的名称。"
L["OPT_UI_SERIESTIP"] = "提示系列成就"
L["OPT_UI_SERIESTIP_TIP"] = "当鼠标滑过一个系列成就时，显示系列中其他成就的名字和与当前成就的关系。"
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS_TIP"] = ""--]] 
L["OPT_WELLREADTIPS"] = "提示书本是否读过"
L["OPT_WELLREADTIPS_TIP"] = "增加书本提示说明。"
L["OPTPANEL_REMINDERTOOLTIPS"] = "工具提示"
L["OVERACHIEVER_INSTALLED_MSG"] = "|cff7eff00Overachiever|r v%s 已安装."
L["OVERACHIEVER_INSTALLED_TOAST"] = "OVERACHIEVER 已安装!"
L["OVERACHIEVER_UPDATED_MSG"] = "|cff7eff00Overachiever|r 需要更新到 v%s."
L["OVERACHIEVER_UPDATED_TOAST"] = "OVERACHIEVER 更新完毕!"
L["PROGRESS"] = "进度"
L["PROGRESSIFOTHERCOMPLETED"] = "%s的进度:"
L["RECENTREMINDERCRITERIA"] = "最近发现的目标:"
L["REQUIREDFORMETATIP"] = "需要："
L["SERIESTIP"] = "系列成就："
L["SOUND_AGGRO_PULLED"] = "激活注意"
L["SOUND_AGGRO_WARNING"] = "激活警告"
L["SOUND_ALARM1"] = "闹铃声1"
L["SOUND_ALARM2"] = "闹铃声2"
L["SOUND_ALARM3"] = "闹铃声3"
L["SOUND_BELL_ALLIANCE"] = "钟声 - 联盟"
L["SOUND_BELL_AUCTION"] = "铃声 - 拍卖行"
L["SOUND_BELL_BOATARRIVED"] = "钟声 - 船只到港"
L["SOUND_BELL_HORDE"] = "钟声 - 部落"
L["SOUND_BELL_KARA"] = "钟声 - 卡拉赞"
L["SOUND_BELL_MELLOW"] = "圆润的钟声"
L["SOUND_BELL_NIGHTELF"] = "钟声 - 暗夜精灵"
L["SOUND_BGTIMER"] = "战场计时器"
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER_END"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BONUSEVENT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_CHAR_CREATE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_DIGSITE_COMPLETE"] = ""--]] 
L["SOUND_DING_AUCTION"] = "拍卖行 - 叮"
L["SOUND_DRUMHIT"] = "击鼓声"
L["SOUND_ENTERQUEUE"] = "进入队列声"
L["SOUND_GARRISON_INVASION"] = "要塞入侵警报"
L["SOUND_GLYPH_CREATE_MAJOR"] = "大雕文创建"
L["SOUND_GLYPH_CREATE_MINOR"] = "小雕文创建"
L["SOUND_GLYPH_DESTROY_MAJOR"] = "大雕文摧毁"
L["SOUND_GLYPH_DESTROY_MINOR"] = "小雕文摧毁"
L["SOUND_GONG_TROLL"] = "锣声 - 巨魔"
L["SOUND_HEARTHBIND"] = "炉石绑定声"
--[[Translation missing --]]
--[[ L["SOUND_LEVELUP"] = ""--]] 
L["SOUND_MAP_PING"] = "小地图信号声"
L["SOUND_MEDAL_EXPIRES"] = "奖牌到期"
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_GOLDTOSILVER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_SILVERTOBRONZE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_QUEST_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_BADPRESS"] = ""--]] 
L["SOUND_SIMON_DING"] = "叮（奥格瑞拉小游戏）"
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_LARGE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_SMALL"] = ""--]] 
L["SOUND_SIMON_STARTGAME"] = "游戏开始（奥格瑞拉小游戏）"
L["SOUND_SIMON_STARTLEVEL"] = "升级（奥格瑞拉小游戏）"
--[[Translation missing --]]
--[[ L["SOUND_STORE_CONFIRM"] = ""--]] 
L["SOUND_YAR"] = "啊啊啊啊啊……"
L["STARTTOAST_EVENT"] = "今日所发生的事情"
L["WILDPET"] = "小动物"
L["YOURPROGRESS"] = "你的进度"



elseif (locale == "ruRU") then  -- Russian
-- Thanks to user Swix at wowinterface.com for many of these translations:
L["ACH_ACQUIRE_COMPLETE"] = "Уже получено"
L["ACH_ACQUIRE_INCOMPLETE"] = "Нужно получить"
L["ACH_ACQUIRE_INCOMPLETE_EXTRA"] = "Не получено"
L["ACH_ANGLER_COMPLETE"] = "Уже выловлено"
L["ACH_ANGLER_COUNT"] = [=[9455=Косяк огненного аммонита
9456=Косяк масляного глубинного угря-мешкорота,Косяк глубинного угря-мешкорота
9457=Косяк хлыстохвоста Черноводья
9458=Косяк слепого озерного осетра
9459=Косяк толстопузика
9460=Косяк безротого скрытиуса
9461=Косяк морских скорпионов,Косяк жирных морских скорпионов]=]
L["ACH_ANGLER_INCOMPLETE"] = "Нужно выловить"
L["ACH_BUNNYMAKER_COMPLETE"] = "Весенние цветы уже использованы"
L["ACH_BUNNYMAKER_INCOMPLETE"] = "Нужно использовать весенние цветы"
L["ACH_CHECKYOURHEAD_COMPLETE"] = "Уже надевали тыкву на голову"
L["ACH_CHECKYOURHEAD_INCOMPLETE"] = "Нужно надеть тыкву на голову"
L["ACH_CONSUME_91_COMPLETE"] = "Обжорство доказано"
L["ACH_CONSUME_91_INCOMPLETE"] = "Съешь 91 за один раз!"
L["ACH_CONSUME_COMPLETE"] = "Уже попробовали"
L["ACH_CONSUME_INCOMPLETE"] = "Нужно попробовать"
L["ACH_CONSUME_INCOMPLETE_EXTRA"] = "Не попробовали"
L["ACH_EATYOURGREENS_COMPLETE"] = "Уже съедено"
L["ACH_EATYOURGREENS_INCOMPLETE"] = "Нужно съесть"
L["ACH_FISHSCHOOL_FORMAT"] = [=[%s Школa
Из Школы %s
%s Рой]=]
L["ACH_FISTFULOFLOVE_COMPLETE"] = "Горсть розовых лепестков уже использовалась"
L["ACH_FISTFULOFLOVE_INCOMPLETE"] = "Воспользуйтесь горстью розовых лепестков"
L["ACH_LETITSNOW_COMPLETE"] = "Горсть снежинок уже использовалась"
L["ACH_LETITSNOW_INCOMPLETE"] = "Воспользуйтесь горстью снежинок"
L["ACH_LOVECRITTERS_COMPLETE"] = "Уже /любите"
L["ACH_LOVECRITTERS_INCOMPLETE"] = "Выразите /любовь"
L["ACH_MISSIONCOMPLETE_COMPLETE"] = "Уже выполнено"
L["ACH_MISSIONCOMPLETE_INCOMPLETE"] = "Нужно выполнить"
--[[Translation missing --]]
--[[ L["ACH_RIDE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_INCOMPLETE"] = ""--]] 
L["ACH_TURKEYLURKEY_COMPLETE"] = "Уже расстрелян"
L["ACH_TURKEYLURKEY_INCOMPLETE"] = "Нужно расстрелять"
L["ACH_WELLREAD_COMPLETE"] = "Прочитано"
L["ACH_WELLREAD_INCOMPLETE"] = "Нужно прочитать"
L["BINDING_NAME_OVERACHIEVER_TAB_SEARCH"] = "Открыть вкладку \"Поиск\""
L["BINDING_NAME_OVERACHIEVER_TAB_SUGGESTIONS"] = "Открыть вкладку \"Предположения\""
L["BINDING_NAME_OVERACHIEVER_TAB_WATCH"] = "Открыть вкладку \"Наблюдение\""
L["COMPLETEDATE"] = "Дата выполнения: %1$d/%2$02d/%3$02d"
L["CRITTER"] = "Существо"
L["HOLIDAY_BREWFEST"] = "Хмельной фестиваль"
L["HOLIDAY_CHILDRENSWEEK"] = "Детская неделя"
L["HOLIDAY_DARKMOONFAIRE"] = "Ярмарка Новолуния"
L["HOLIDAY_DAYOFTHEDEAD"] = "День мертвых"
L["HOLIDAY_HALLOWSEND"] = "Тыквовин"
L["HOLIDAY_LOVEISINTHEAIR"] = "Любовная лихорадка"
L["HOLIDAY_LUNARFESTIVAL"] = "Лунный фестиваль"
L["HOLIDAY_MIDSUMMER"] = "Огненный солнцеворот"
L["HOLIDAY_MIDSUMMER_SHORT"] = "Солнцеворот"
L["HOLIDAY_NOBLEGARDEN"] = "Сад чудес"
L["HOLIDAY_PIGRIMSBOUNTY"] = "Пиршество странников"
L["HOLIDAY_PIRATESDAY"] = "День пирата"
L["HOLIDAY_WINTERVEIL"] = "Праздник Зимнего Покрова"
L["HOLIDAY_WINTERVEIL_SHORT"] = "Зимний Покров"
L["INCOMPLETE"] = "Не выполнено"
L["KILL_COMPLETE"] = "Уже убит"
L["KILL_INCOMPLETE"] = "Нужно убить"
L["MSG_ACHNOTFOUND"] = "Достижение не найдено"
L["MSG_CRITERIAPROGRESS"] = "|cff7eff00Прогресс достижения:|r %s (%s)"
L["MSG_INVALIDID"] = "Неверный ввод: достижения с таким ID не существует."
L["MSG_NAMENOTFOUND"] = "Достижений с названием, содержащим \"|cffffffff%s|r\", не существует."
L["MSG_NOOPEN"] = "Не удалось открыть достижение. Не отображается в пользовательском интерфейсе."
L["MSG_NOOPEN_LIST"] = "%s |4достижение:достижения; найдено:"
L["MSG_NUMFOUNDLIST"] = "Ещё %s других достижений найдено:"
L["MSG_ONEFOUND"] = "Найдено ещё одно достижение: "
L["MSG_OPENINGTO"] = "Результат поиска: "
L["MULTI_NEED"] = "%s (необходимы для %s достижениях)"
L["OPT_ACHUNKNOWN"] = "<Неизвестно>"
L["OPT_ACQUIREDTIPS"] = "Предмет приобретен?"
L["OPT_ACQUIREDTIPS_TIP"] = "Добавить строку в подсказки предметов, чтобы указать, нужно ли их получить для достижения."
L["OPT_ANGLERTIPS"] = "Отмечать посещённые места поклёвки в подсказках"
L["OPT_ANGLERTIPS_TIP"] = "Если эти достижения не выполнены, во всплывающую подсказку к местам поклёвки будет добавляться строка, показывающая, ловили ли вы рыбу оттуда."
L["OPT_ANGLERTIPS_TIP_ALWAYS"] = "Добавляет строку к подсказки, рыболовному косяку, которые являются частью его критериев, чтобы указать, нужна ли рыба от них."
L["OPT_AUTOTRACK_CRITERIATOAST"] = "Предложить авто-слежение на \"Достижение с прогрессом\""
L["OPT_AUTOTRACK_CRITERIATOAST_TIP"] = "Когда появляется всплывающие окно \"Достижение Прогресса\", автоматически отслеживает достижение (если лимит отслеживания позволяет)."
L["OPT_AUTOTRACKEXPLORE"] = "Автоматически следить за достижениями на исследование"
L["OPT_AUTOTRACKEXPLORE_COMPLETED"] = "Включая выполненные достижения"
L["OPT_AUTOTRACKEXPLORE_TIP"] = "Когда вы входите в зону автоматически, отслеживать достижения на исследование. Если уже отслеживали достижение, то это заменит другое исследование, автоматически отслеживать даже, если там есть какое-либо другое достижение."
L["OPT_AUTOTRACKTIMED"] = "Авто-слежение достижений с временем"
L["OPT_AUTOTRACKTIMED_BG"] = "Авто-слежение временных достижений в полях боев"
L["OPT_AUTOTRACKTIMED_TIP"] = "Автоматически начинать слежение достижений с критерием по времени при запуске таймера. Если вы уже отслеживаете максимальное допустимое число достижений, то оно будет пытаться занять место достижения авто-исследования, в противном случае не будет отслеживаться."
L["OPT_AUTOTRACKTIMED_TIP_BG"] = "Когда начинается битва на поле битвы, автоматически отслеживается достижение для победы в заданное время (если оно незавершённо).|n|nДостижение не отслеживается после выхода из поле битвы."
L["OPT_BUNNYMAKERTIPS"] = "Добавляет, нужно ли вам использовать весенние цветы"
L["OPT_BUNNYMAKERTIPS_TIP"] = "Если достижение еще не выполненно, добавляется строка в подсказку игроков соответствующего пола и уровня, указывая, нужно ли вам использовать на них весенние цветы."
L["OPT_CHECKYOURHEADTIPS"] = "Добавлять строку о необходимости использовать \\\"Утяжеленный фонарь из тыквы \\\""
L["OPT_CHECKYOURHEADTIPS_TIP"] = "Если это достижение не выполнено, во всплывающую подсказку игрокам добавится строка, уведомляющая о необходимости использовать на них утяжеленный фонарь из тыквы."
L["OPT_CONSUMEITEMTIPS"] = "Добавлять строку о необходимости попробовать еду."
L["OPT_CONSUMEITEMTIPS_TIP"] = "Если это достижение не выполнено, во всплывающую подсказку еды добавится строка, уведомляющая о необходимости его попробовать."
L["OPT_CONSUMEITEMTIPS_TIP2"] = "Еда слишком низкого для вас уровня не будет вызывать звуковое напоминание."
L["OPT_CONSUMEITEMTIPS_WHENCOMPLETE"] = "Показывать, даже если достижение выполнено"
L["OPT_CRITERIATOAST_CHATLOG"] = "Добавлять в чат"
L["OPT_CRITERIATOAST_CHATLOG_TIP"] = "Когда уведомление \"Достижение Прогресса\" появляется, ссылка на достижения, также будет показано в завершённые критерии в чате."
L["OPT_CRITERIATOAST_SUGGEST"] = "Добавить в последние напоминания (Предложения)"
L["OPT_CRITERIATOAST_SUGGEST_TIP"] = "Когда уведомление \"Достижение Прогресса\" появляется, временно добавить достижение на вкладку предложения как \"последнее напоминание\"."
L["OPT_CRITTERTIPS"] = "Добавлять /любовный статус в подсказки существам"
L["OPT_CRITTERTIPS_TIP"] = "Если это достижение не выполнено, во всплывающую подсказку существам будет добавляться строка, показывающая /любите ли вы это существо или нет."
L["OPT_DRAGGABLE"] = "Позволить перетаскивать"
L["OPT_DRAGSAVE"] = "Запомнить позицию"
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS_TIP"] = ""--]] 
L["OPT_FISTFULOFLOVETIPS"] = "Добавляет, нужно ли вам использовать горсть розовых лепестков"
L["OPT_FISTFULOFLOVETIPS_TIP"] = "Если это достижение не выполнено, во всплывающую подсказку игрокам, подходящих по расе/классу, будет добавлена строка, указывающая на необходимость использования горсти розовых лепестков."
L["OPT_KILLCREATURETIPS"] = "Добавлять строку о необходимости убить существо"
L["OPT_KILLCREATURETIPS_EXCLUDE_GUILD"] = "Исключить достижения гильдии"
L["OPT_KILLCREATURETIPS_TIP"] = "Если это достижение не выполнено, во всплывающую подсказку существам (исключая спутников) добавится строка, уведомляющая о необходимости убить их."
L["OPT_KILLCREATURETIPS_TIP2"] = "Заметка: Вначале (или когда эта опция включена), каждое достижение сканируется на поиск Номера НПС. Не все достижения предоставляют правильные номера. Поэтому подсказки для существ, которые подходят по критериям, не будут отображаться этой опцией."
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_WHENCOMPLETE"] = ""--]] 
L["OPT_LABEL_ACHFIVE"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s\""
L["OPT_LABEL_ACHFOUR"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHSEVEN"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s,\" \"%s,\" \"%s\""
L["OPT_LABEL_ACHSIX"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHTHREE"] = "\"%s,\" \"%s,\" и|n\"%s\""
L["OPT_LABEL_ACHTWO"] = "\"%s\" и \"%s\""
L["OPT_LABEL_CRITERIATOAST"] = "Прогресс Реакции (Без Отслеживания)"
L["OPT_LABEL_DRAENORANGLER"] = "\"%s\" Cуб-Достижение"
--[[Translation missing --]]
--[[ L["OPT_LABEL_LOVECRITTER"] = ""--]] 
L["OPT_LABEL_MAINUI"] = "Модификации главного интерфейса достижений"
L["OPT_LABEL_MISC"] = "Разное"
L["OPT_LABEL_NEEDTOKILL"] = "Достижения по убийству существ (\"%s,\" \"%s,\" и т.д.)"
L["OPT_LABEL_SEASONALACHS"] = "СЕЗОННЫЕ ДОСТИЖЕНИЯ"
L["OPT_LABEL_STARTTOAST"] = "Праздник/Всплывающие Событие"
L["OPT_LABEL_TOOLTIPS"] = "Ссылки и всплывающие окошки"
L["OPT_LABEL_TRACKING"] = "Отслеживание достижений"
L["OPT_LABEL_TRADESKILLUI"] = "Изменения интерфейса профессии"
L["OPT_LETITSNOWTIPS"] = "Добавляет, нужно ли вам использовать горсть снежинок"
L["OPT_LETITSNOWTIPS_TIP"] = "Если это достижение не выполнено, во всплывающую подсказку игрокам будет добавляться строка, уведомляющая о необходимости использования горсти снежинок."
L["OPT_MISSIONCOMPLETE"] = "Миссия завершена?"
L["OPT_MISSIONCOMPLETE_TIP"] = "Добавить строку в подсказки миссий, чтобы указать, нужно ли выполнять их для достижения."
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_WHENCOMPLETE"] = ""--]] 
L["OPT_PESTCONTROLTIPS"] = "Добавлять строку о необходимости убийства существа"
L["OPT_PESTCONTROLTIPS_TIP"] = "Если это достижение не выполнено, во всплывающую подсказку существам будет добавляться строка, уведомляющая о необходимости убить данное существо."
L["OPT_SATISFIEDTIPS"] = "1000% удовлетворены?"
L["OPT_SATISFIEDTIPS_TIP"] = "Добавить строку в подсказках предметов, которые являются частью критериев достижения, чтобы указать, нужно ли использовать их."
L["OPT_SELECTSOUND"] = "Проигрывать звук при незавершённом достижении"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE"] = "Не уведомлять о рыбных местах, если удочка у вас в руках"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP"] = "Не проигрывать звук над рыбными местами, если удочка у вас в руках."
L["OPT_SELECTSOUND_CHECKCOMBAT"] = "Исключить напоминания о убивстве, если в бою с существом"
L["OPT_SELECTSOUND_CHECKCOMBAT_TIP"] = "Не воспроизводить звук напоминания, когда вам нужно убить существо, пока вы сражаетесь с ним."
L["OPT_SELECTSOUND_TIP"] = "Проигрывать выбранный звуковой файл, если во всплывающее окошко была добавлена информация о незавершённом достижении."
L["OPT_SELECTSOUND_TIP2"] = "Звук будет воспроизводиться не чаще раза в 15 секунд."
L["OPT_SHOWID"] = "Показывать ID достижений"
L["OPT_SHOWPROGRESS"] = "Добавлять ваш прогресс"
L["OPT_SHOWPROGRESS_OTHER"] = "Сравнивать прогресс в чужих ссылках"
L["OPT_SHOWPROGRESS_OTHER_TIP"] = "Добавлять ваш прогресс в информацию о достижениях других игроков."
L["OPT_SHOWPROGRESS_TIP"] = "Добавлять ваш прогресс в достижения, основанные на количественном критерии, например, \"Соберите 10 питомцев\"."
L["OPT_SLASHSEARCH_TAB"] = "Слэш-команды используют вкладку \"Поиск\""
L["OPT_SLASHSEARCH_TAB_TIP"] = "Используйте вкладку \"Поиск\" для отображения результатов поиска из слэш-команд, таких как  \"/ach food \". Если этот флажок не установлен, результаты выводятся в журнал чата (если не используется команда \"/achs\")."
L["OPT_SLASHSEARCH_TIP2"] = "|cffffffffНеобходим модуль вкладок с вкладкой Поиск.|r"
L["OPT_STARTTOAST_BONUS"] = "Показать сегодняшние бонусные события"
L["OPT_STARTTOAST_BONUS_TIP"] = "Показывает сегодняшние бонусные события в всплывающих уведомлениях при входе в игровой мир."
L["OPT_STARTTOAST_DUNGEON"] = "Показать сегодняшние события \"Подземелья\""
L["OPT_STARTTOAST_DUNGEON_TIP"] = "Показывает сегодняшние события \"Подземелья\" в всплывающих уведомлениях при входе в игровой мир."
L["OPT_STARTTOAST_HOLIDAY"] = "Показать сегодняшние праздники"
L["OPT_STARTTOAST_HOLIDAY_TIP"] = "Показывает сегодняшние праздники в всплывающие уведомления при входе в игровой мир."
L["OPT_STARTTOAST_MICROHOLIDAY"] = "Показать сегодняшние маленькие праздники"
L["OPT_STARTTOAST_MICROHOLIDAY_TIP"] = "Показывает сегодняшние маленькие праздники в всплывающих уведомлениях при входе в игровой мир."
L["OPT_STARTTOAST_MISC"] = "Показать сегодняшние разные праздники"
L["OPT_STARTTOAST_MISC_TIP"] = "Показывает различные события \"Праздник\" в всплывающих уведомлениях при входе в игровой мир."
L["OPT_STARTTOAST_MISC_TIP2"] = "Эти события, найденные в календаре по умолчанию, как  \"праздники\", но не считаются полными праздниками и не охвачены другой категорией, приведенной здесь. Примеры включают в себя годовщины WoW и дни релиза рейдов (для новых рейдов или сложностей, а не еженедельный сброс)."
L["OPT_STARTTOAST_ONLYCLICKFADE"] = "Требовать нажатие чтобы скрыть"
L["OPT_STARTTOAST_ONLYCLICKFADE_TIP"] = "Эти всплывающие уведомления не будут исчезать, если только левой или правой кнопкой, не кликните. (Если отключено, то они будут также исчезать, если мышь проходит над ними, и после пропадают.)"
L["OPT_STARTTOAST_PVPBRAWL"] = "Показать сегодняшнюю PvP потасовку"
L["OPT_STARTTOAST_PVPBRAWL_TIP"] = "Показывает сегодняшнюю PvP потасовку в всплывающих уведомлениях при входе в игровой мир."
L["OPT_STARTTOAST_TIMEFADE"] = "При отключенной функции, уведомление будут пропадать автоматически"
L["OPT_STARTTOAST_TIMEFADE_TIP"] = "Предотвращает всплывающие уведомления, с которыми Вы не взаимодействуете, задержка исчезновения около нескольких секунд."
L["OPT_THROTTLE_ACHLOOKUP"] = "Запуск: Регулирование отслеживания достижений"
L["OPT_THROTTLE_ACHLOOKUP_TIP"] = "Overachiever просматривает определенные данные при запуске. Если этот флажок не установлен, поиск выполняется во время загрузки пользовательского интерфейса. Если флажок установлен, данные собираются со временем после входа игрока в мир."
L["OPT_THROTTLE_ACHLOOKUP_TIP2"] = "|nПреимуществом регулирования поиска является более быстрая начальная загрузка, но для некоторых пользователей и некоторых персонажей это может заметно повлиять на производительность в течение нескольких секунд в начале сеанса.|n|nЕсли |cffffffffмодуль Кэш|r включен, регулирование не улучшает время загрузки, если не требуется перестроить кэш. Кэш будет перестроен после того, как будет выпущена новая сборка WoW."
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING"] = "Отображает не приготовленные рецепты для завершения достижений"
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING_TIP"] = "Если торговый модуль Overachiever'а включен, иконка достижения появится рядом с рецептом, который необходимо приготовить для получения соответствующего достижения. Если эта опция включена, то иконки появляться рядом с еще не приготовленными рецептами даже если эти достижения завершены."
L["OPT_TURKEYLURKEYTIPS"] = "Добавлять строку о необходимости использовать индейкомет"
L["OPT_TURKEYLURKEYTIPS_TIP"] = "Если это достижение не выполнено, во всплывающую подсказку игрокам добавится строка, уведомляющая о необходимости использовать на них индейкомет."
L["OPT_UI_HOLIDAYNOTICE"] = "Уведомление отображается, если событие праздника-активное"
L["OPT_UI_HOLIDAYNOTICE_SUGGESTIONSTABONLY"] = "Только в вкладке Предложения"
L["OPT_UI_HOLIDAYNOTICE_TIP"] = "Есть, ли сегодня праздник или событие (типо Хмельной фестиваль или Ярмарка Новолуния), появится графическое уведомление, рядом с UI достижения. Щелкнув на него, отобразится достижения для этого события. Поместите курсор над ним для более подробной информации."
L["OPT_UI_HOLIDAYNOTICE_TIP2"] = "|cffffffffТребуется модуль с вкладкой Предложения.|r"
L["OPT_UI_PROGRESSIFOTHERCOMPLETED"] = "Всплывающая подсказка на основе количества прогресса, если завершены другие"
L["OPT_UI_PROGRESSIFOTHERCOMPLETED_TIP"] = "При наведении курсора на основе количества достижения (типо, критерия для \"получения 10-ти транспорта\"), которая была завершена, но не для текущего персонажа, отображать ход текущего прогресса персонажей."
L["OPT_UI_REQUIREDFORMETATIP"] = "Показывать достижения, необходимые для других"
L["OPT_UI_REQUIREDFORMETATIP_TIP"] = "Если вы наведёте мышку на достижение, которое необходимо для получения другого достижения, во всплывающем окошке будет отображено название этого мета-достижения."
L["OPT_UI_SERIESTIP"] = "Показывать достижения, являющиеся частью серии"
L["OPT_UI_SERIESTIP_TIP"] = "Если вы наведёте курсор на достижение, являющееся частью серии, во всплывающее окошко будут добавлены имена других достижений из этой серии."
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS_TIP"] = ""--]] 
L["OPT_WELLREADTIPS"] = "Отмечать в подсказке книги, прочитана ли она"
L["OPT_WELLREADTIPS_TIP"] = "Если эти достижения не выполнены, во всплывающую подсказку к книгам будет добавляться строка, показывающая, прочитан ли этот экземпляр"
L["OPTPANEL_REMINDERTOOLTIPS"] = "Напоминающие подсказки"
L["OVERACHIEVER_INSTALLED_MSG"] = "|cff7eff00Overachiever|r v%s был установлен."
L["OVERACHIEVER_INSTALLED_TOAST"] = "OVERACHIEVER УСТАНОВЛЕН!"
L["OVERACHIEVER_UPDATED_MSG"] = "|cff7eff00Overachiever|r был обновлен до v%s."
L["OVERACHIEVER_UPDATED_TOAST"] = "OVERACHIEVER ОБНОВЛЕН!"
L["PROGRESS"] = "Прогресс"
L["PROGRESSIFOTHERCOMPLETED"] = "%s Прoгресс:"
L["RECENTREMINDERCRITERIA"] = "Недавно обнаруженная задача:"
L["REQUIREDFORMETATIP"] = "Требуется для:"
L["SERIESTIP"] = "Часть серии:"
L["SOUND_AGGRO_PULLED"] = "Тянуть угрoзу"
L["SOUND_AGGRO_WARNING"] = "Предупреждение Угрозы"
L["SOUND_ALARM1"] = "Alarm Clock 1"
L["SOUND_ALARM2"] = "Alarm Clock 2"
L["SOUND_ALARM3"] = "Alarm Clock 3"
L["SOUND_BELL_ALLIANCE"] = "Колокол - Альянс"
L["SOUND_BELL_AUCTION"] = "Колокол - Аукцион"
L["SOUND_BELL_BOATARRIVED"] = "Колокол - Прибытие коробля"
L["SOUND_BELL_HORDE"] = "Колокол - Орда"
L["SOUND_BELL_KARA"] = "Колокол - Каражан"
L["SOUND_BELL_MELLOW"] = "Колокол - Спокойный"
L["SOUND_BELL_NIGHTELF"] = "Колокол - Ночной Эльф"
L["SOUND_BGTIMER"] = "Таймер Поля боя"
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER_END"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BONUSEVENT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_CHAR_CREATE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_DIGSITE_COMPLETE"] = ""--]] 
L["SOUND_DING_AUCTION"] = "Звон аукциона"
L["SOUND_DRUMHIT"] = "Барабаны"
L["SOUND_ENTERQUEUE"] = "Вход в очередь"
L["SOUND_GARRISON_INVASION"] = "Оповещение о вторжении в Гарнизон"
L["SOUND_GLYPH_CREATE_MAJOR"] = "Создание большого глифа"
L["SOUND_GLYPH_CREATE_MINOR"] = "Создание малого глифа"
L["SOUND_GLYPH_DESTROY_MAJOR"] = "Уничтожение большого глифа"
L["SOUND_GLYPH_DESTROY_MINOR"] = "Уничтожение малого глифа"
L["SOUND_GONG_TROLL"] = "Гонг - Троль"
L["SOUND_HEARTHBIND"] = "Привязка камня возвращения"
L["SOUND_LEVELUP"] = "Уровень повышен"
L["SOUND_MAP_PING"] = "Импульс на карте"
L["SOUND_MEDAL_EXPIRES"] = "Медаль Истекает"
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_GOLDTOSILVER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_SILVERTOBRONZE"] = ""--]] 
L["SOUND_QUEST_COMPLETE"] = "Задание выполнено"
--[[Translation missing --]]
--[[ L["SOUND_SIMON_BADPRESS"] = ""--]] 
L["SOUND_SIMON_DING"] = "Саймон - звон"
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_LARGE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_SMALL"] = ""--]] 
L["SOUND_SIMON_STARTGAME"] = "Саймон - начало игры"
L["SOUND_SIMON_STARTLEVEL"] = "Саймон - начало уровня"
--[[Translation missing --]]
--[[ L["SOUND_STORE_CONFIRM"] = ""--]] 
L["SOUND_YAR"] = "Ярррр"
L["STARTTOAST_EVENT"] = "Сегодняшнее Событие"
L["WILDPET"] = "Дикий питомец"
L["YOURPROGRESS"] = "Ваш прогресс"



elseif (locale == "koKR") then  -- Korean
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_INCOMPLETE_EXTRA"] = ""--]] 
L["ACH_ANGLER_COMPLETE"] = "낚시 완료"
L["ACH_ANGLER_COUNT"] = [=[9455=화염 암모나이트 떼
9456=심연 풍선장어 떼,기름투성이 심연 풍선장어 떼
9457=검은바다 채찍꼬리 떼
9458=눈먼 철갑상어 떼
9459=통통 망둑어 떼
9460=무턱 모래무지 떼
9461=바다 전갈 떼,기름투성이 바다 전갈 떼

설명:
"드레노어 낚시꾼" 업적을 기준으로 설명합니다. 위의 내용을 복사해서 붙여넣기 한 후에  = 표시 뒤의 영어를 한글의 낚시 떼 이름으로 바꿔줍니다. 앞의 숫자는 업적 ID 입니다. 물고기가 잡히는 낚시 떼가 여러 개 인 경우 쉼표를 이용하여 구분합니다.
]=]
L["ACH_ANGLER_INCOMPLETE"] = "낚시 필요"
L["ACH_BUNNYMAKER_COMPLETE"] = "새봄맞이 꽃 사용 완료"
L["ACH_BUNNYMAKER_INCOMPLETE"] = "새봄맞이 꽃 사용 필요"
L["ACH_CHECKYOURHEAD_COMPLETE"] = "무거운 호박등 사용 완료"
L["ACH_CHECKYOURHEAD_INCOMPLETE"] = "무거운 호박등 사용 필요"
L["ACH_CONSUME_91_COMPLETE"] = "초코릿 과자를 연속으로 91번 먹기 완료"
L["ACH_CONSUME_91_INCOMPLETE"] = "초코릿 과자를 연속으로 91번 먹기 필요"
L["ACH_CONSUME_COMPLETE"] = "먹기 완료"
L["ACH_CONSUME_INCOMPLETE"] = "먹을 필요 있음"
L["ACH_CONSUME_INCOMPLETE_EXTRA"] = "먹은 적 없음"
--[[Translation missing --]]
--[[ L["ACH_EATYOURGREENS_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_EATYOURGREENS_INCOMPLETE"] = ""--]] 
L["ACH_FISHSCHOOL_FORMAT"] = "물고기 떼 %s"
L["ACH_FISTFULOFLOVE_COMPLETE"] = "붉은 꽃잎 한 줌 사용 완료"
L["ACH_FISTFULOFLOVE_INCOMPLETE"] = "붉은 꽃잎 한 줌 사용 필요"
L["ACH_LETITSNOW_COMPLETE"] = "눈송이 한 줌 사용 완료"
L["ACH_LETITSNOW_INCOMPLETE"] = "눈송이 한 줌 사용 필요"
L["ACH_LOVECRITTERS_COMPLETE"] = "/사랑 완료"
L["ACH_LOVECRITTERS_INCOMPLETE"] = "/사랑 필요"
--[[Translation missing --]]
--[[ L["ACH_MISSIONCOMPLETE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_MISSIONCOMPLETE_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_INCOMPLETE"] = ""--]] 
L["ACH_TURKEYLURKEY_COMPLETE"] = "칠면조 사냥총 사용 완료"
L["ACH_TURKEYLURKEY_INCOMPLETE"] = "칠면조 사냥총 사용 필요"
L["ACH_WELLREAD_COMPLETE"] = "독서 완료"
L["ACH_WELLREAD_INCOMPLETE"] = "독서 필요"
L["BINDING_NAME_OVERACHIEVER_TAB_SEARCH"] = "검색 탭"
L["BINDING_NAME_OVERACHIEVER_TAB_SUGGESTIONS"] = "추천 탭"
L["BINDING_NAME_OVERACHIEVER_TAB_WATCH"] = "추적 탭"
L["COMPLETEDATE"] = "업적 획득 - %3$02d/%02$d/%1$02d"
L["CRITTER"] = "동물"
L["HOLIDAY_BREWFEST"] = "가을 축제"
L["HOLIDAY_CHILDRENSWEEK"] = "어린이 주간"
L["HOLIDAY_DARKMOONFAIRE"] = "다크문 축제"
L["HOLIDAY_DAYOFTHEDEAD"] = "망자의 날"
L["HOLIDAY_HALLOWSEND"] = "할로윈 축제"
L["HOLIDAY_LOVEISINTHEAIR"] = "온누리에 사랑을"
L["HOLIDAY_LUNARFESTIVAL"] = "달의 축제"
L["HOLIDAY_MIDSUMMER"] = "한여름 축제"
L["HOLIDAY_MIDSUMMER_SHORT"] = "여름축제"
L["HOLIDAY_NOBLEGARDEN"] = "귀족의 정원"
L["HOLIDAY_PIGRIMSBOUNTY"] = "순례자의 감사절"
L["HOLIDAY_PIRATESDAY"] = "해적의 날"
L["HOLIDAY_WINTERVEIL"] = "겨울맞이 축제"
L["HOLIDAY_WINTERVEIL_SHORT"] = "겨울 축제"
L["INCOMPLETE"] = "업적 진행 중"
L["KILL_COMPLETE"] = "처치 완료"
L["KILL_INCOMPLETE"] = "처치 필요"
L["MSG_ACHNOTFOUND"] = "업적을 찾을 수 없습니다."
L["MSG_CRITERIAPROGRESS"] = "|cff7eff00업적 진행상황:|r %s (%s)"
L["MSG_INVALIDID"] = "올바르지 않은 값: 해당 ID와 업적이 존재하지 않습니다."
L["MSG_NAMENOTFOUND"] = "\"|cffffffff%s|r\"을 포함하는 업적을 찾을 수 없습니다."
--[[Translation missing --]]
--[[ L["MSG_NOOPEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_NOOPEN_LIST"] = ""--]] 
L["MSG_NUMFOUNDLIST"] = "%s개의 다른 업적을 찾았습니다:"
L["MSG_ONEFOUND"] = "1개의 다른 업적을 찾았습니다: "
L["MSG_OPENINGTO"] = "열기: "
L["MULTI_NEED"] = "%s (%s 업적에 필요)"
L["OPT_ACHUNKNOWN"] = "<무엇인가>"
--[[Translation missing --]]
--[[ L["OPT_ACQUIREDTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_ACQUIREDTIPS_TIP"] = ""--]] 
L["OPT_ANGLERTIPS"] = "물고기 떼 낚시 표시"
L["OPT_ANGLERTIPS_TIP"] = "업적을 완료하지 않은 경우 해당 물고기 떼에 마우스를 가져가면 툴팁에 낚시가 필요한 지 표시해줍니다."
L["OPT_ANGLERTIPS_TIP_ALWAYS"] = "일부 물고기떼에서 낚시할 때 툴팁에 업적에 포함되는지 표시합니다."
L["OPT_AUTOTRACK_CRITERIATOAST"] = "\"업적 진행상황\"에 자동으로 추가 됩니다."
L["OPT_AUTOTRACK_CRITERIATOAST_TIP"] = "\"업적 진행상황\"이 나타났을 때, 자동으로 업적을 추적합니다(추적이 허용하는 한도내에서)."
L["OPT_AUTOTRACKEXPLORE"] = "지역 이동시 탐험 업적을 자동으로 추적"
L["OPT_AUTOTRACKEXPLORE_COMPLETED"] = "완료한 업적 포함"
L["OPT_AUTOTRACKEXPLORE_TIP"] = "특정 지역으로 이동했을 때 자동으로 관련된 탐험 업적을 추적합니다. 다른 지역 탐험을 추적중이면 추적을 바꾸지 않습니다."
L["OPT_AUTOTRACKTIMED"] = "시간제한 업적 자동 추적"
L["OPT_AUTOTRACKTIMED_BG"] = "승리 요건을 만족하는 전장 업적 자동 추적"
L["OPT_AUTOTRACKTIMED_TIP"] = "시간제한이 있는 업적의 타이머가 시작되면 자동으로 추적합니다. 수동으로 업적을 추적중이면 업적 추적을 전환하지 않습니다."
L["OPT_AUTOTRACKTIMED_TIP_BG"] = "전장이 시작될 때 일정 시간내의 승리 요건에 대한 업적(불완전한 경우라도)을 추적 합니다.|n|n이 업적은 전장을 떠나게 되면 추적하지 않습니다."
L["OPT_BUNNYMAKERTIPS"] = "새봄맞이 꽃 사용 상태 표시"
L["OPT_BUNNYMAKERTIPS_TIP"] = "업적을 완료하지 않은 경우 적절한 성별과 레벨을 가진 플레이어의 툴팁에 새봄맞이 꽃을 사용할 필요가 있는지 표시합니다. 자신과 레벨이 10 이상 차이나는 적 플레이어의 경우에는 레벨 18 이상으로 취급됩니다."
L["OPT_CHECKYOURHEADTIPS"] = "무거운 호박등 사용 표시"
L["OPT_CHECKYOURHEADTIPS_TIP"] = "업적을 완료하지 않은 경우 해당하는 종족의 플레이어 툴팁에 무거운 호박등을 사용할 필요가 있는지 표시합니다."
L["OPT_CONSUMEITEMTIPS"] = "툴팁에 음식 먹은 상태 표시"
L["OPT_CONSUMEITEMTIPS_TIP"] = "업적을 완료하지 않은 경우 음식 아이템에 마우스를 가져가면 툴팁에 음식을 먹을 필요가 있는지 알려줍니다."
L["OPT_CONSUMEITEMTIPS_TIP2"] = "요구 레벨이 높아 먹을 수 없는 음식은 소리로 알려주지 않습니다."
L["OPT_CONSUMEITEMTIPS_WHENCOMPLETE"] = "업적을 완료한 후에도 표시"
L["OPT_CRITERIATOAST_CHATLOG"] = "대화 기록에 추가"
L["OPT_CRITERIATOAST_CHATLOG_TIP"] = "\"업적 진행상황\"이 나타났을 때,업적 및 완료된 상황을 대화 기록에 추가합니다."
L["OPT_CRITERIATOAST_SUGGEST"] = "최근 알림 추가 (추천)"
L["OPT_CRITERIATOAST_SUGGEST_TIP"] = "\"업적 진행상황\"이 나타났을 때, 임시로 업적 제안 탭의 \"최근 알림\"에 추가합니다."
L["OPT_CRITTERTIPS"] = "/사랑 상태 표시"
L["OPT_CRITTERTIPS_TIP"] = "업적을 완료하지 않은 경우 동물에 마우스를 가져다 대면 툴팁에 \"/사랑\"이 필요한지 표시합니다."
L["OPT_DRAGGABLE"] = "업적창 이동"
L["OPT_DRAGSAVE"] = "위치 저장"
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS_TIP"] = ""--]] 
L["OPT_FISTFULOFLOVETIPS"] = "붉은 꽃잎 한 줌 사용 표시"
L["OPT_FISTFULOFLOVETIPS_TIP"] = "업적을 완료하지 않은 경우 해당하는 종족/직업의 플레이어 툴팁에 붉은 꽃잎 한 줌을 사용할 필요가 있는지 표시합니다."
L["OPT_KILLCREATURETIPS"] = "몬스터를 죽인 횟수 표시"
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_EXCLUDE_GUILD"] = ""--]] 
L["OPT_KILLCREATURETIPS_TIP"] = "업적이 완료되지 않았다면 업적에 몬스터를 죽인 횟수를 표시합니다."
L["OPT_KILLCREATURETIPS_TIP2"] = "주의: 게임 시작시(설정에서 사용한 후 부터), 매 업적마다 유닛 ID를 찾습니다."
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_WHENCOMPLETE"] = ""--]] 
L["OPT_LABEL_ACHFIVE"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s\""
L["OPT_LABEL_ACHFOUR"] = "\"%s,\" \"%s,\" 및|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHSEVEN"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s,\"|n\"%s,\" \"%s,\" \"%s\""
L["OPT_LABEL_ACHSIX"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s,\"|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHTHREE"] = "\"%s,\" \"%s,\" 및|n\"%s\""
L["OPT_LABEL_ACHTWO"] = "\"%s\"|1과;와; \"%s\""
L["OPT_LABEL_CRITERIATOAST"] = "진행상황 반응 (비 추적)"
L["OPT_LABEL_DRAENORANGLER"] = "\\\"%s\\\"의 하위 업적"
--[[Translation missing --]]
--[[ L["OPT_LABEL_LOVECRITTER"] = ""--]] 
L["OPT_LABEL_MAINUI"] = "기본 업적창 툴팁 변경"
--[[Translation missing --]]
--[[ L["OPT_LABEL_MISC"] = ""--]] 
L["OPT_LABEL_NEEDTOKILL"] = "처치 업적 (\"%s,\" \"%s,\" 등.)"
L["OPT_LABEL_SEASONALACHS"] = "계절 이벤트 업적"
L["OPT_LABEL_STARTTOAST"] = "기념일/이벤트 팝업"
L["OPT_LABEL_TOOLTIPS"] = "업적 툴팁과 링크"
L["OPT_LABEL_TRACKING"] = "업적 추적"
L["OPT_LABEL_TRADESKILLUI"] = "전문 기술 창에 표시"
L["OPT_LETITSNOWTIPS"] = "눈송이 한 줌 사용 표시"
L["OPT_LETITSNOWTIPS_TIP"] = "업적을 완료하지 않은 경우 해당하는 종족/직업의 플레이어 툴팁에 눈송이 한 줌을 사용할 필요가 있는지 표시합니다."
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_WHENCOMPLETE"] = ""--]] 
L["OPT_PESTCONTROLTIPS"] = "처치 상태 표시"
L["OPT_PESTCONTROLTIPS_TIP"] = "업적을 완료하지 않은 경우 해당 동물에 마우스를 가져다대면 툴팁에 처치가 필요한지 표시합니다."
L["OPT_SATISFIEDTIPS"] = "기분 1000% 상승"
L["OPT_SATISFIEDTIPS_TIP"] = "그것을 먹을 필요가 있는지 나타내기 위해 업적의 기준을 일부 아이템의 툴팁 라인에 추가합니다."
L["OPT_SELECTSOUND"] = "완료하지 않은 업적 알림 소리"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE"] = "낚시대 착용시 알림 제외"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP"] = "낚시대를 착용중이면 물고기 떼에 마우스를 가져가도 알림 소리를 재생하지 않습니다."
L["OPT_SELECTSOUND_CHECKCOMBAT"] = "몹과 전투중이라면 죽임을 포함"
L["OPT_SELECTSOUND_CHECKCOMBAT_TIP"] = "전투중 필요에 의해 몹을 죽이는 경우 소리를 재생하지 않습니다."
L["OPT_SELECTSOUND_TIP"] = "완료되지 않은 업적이 발견되었을 때 선택한 소리를 재생합니다."
L["OPT_SELECTSOUND_TIP2"] = "15초에 한 번씩만 재생 됩니다."
L["OPT_SHOWID"] = "업적 ID 표시"
L["OPT_SHOWPROGRESS"] = "자신의 진행 상태 추가"
L["OPT_SHOWPROGRESS_OTHER"] = "다른 업적 링크와 비교"
L["OPT_SHOWPROGRESS_OTHER_TIP"] = "다른 사람의 업적 링크를 볼때 자신의 진행 상태를 추가합니다."
L["OPT_SHOWPROGRESS_TIP"] = "\"탈 것 10개 획득\"과 같은, 업적 달성이 수량 기준일 때 자신의 진행 상태를 추가합니다."
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TIP2"] = ""--]] 
L["OPT_STARTTOAST_BONUS"] = "오늘의 보너스 이벤트 표시"
L["OPT_STARTTOAST_BONUS_TIP"] = "게임에 접속할 때 오늘은 보너스 이벤트를 팝업으로 표시합니다."
L["OPT_STARTTOAST_DUNGEON"] = "오늘의 던전 이벤트 표시"
L["OPT_STARTTOAST_DUNGEON_TIP"] = "게임에 접속할 때 오늘의 던전 이벤트를 팝업으로 표시합니다."
L["OPT_STARTTOAST_HOLIDAY"] = "오늘의 기념일 표시"
L["OPT_STARTTOAST_HOLIDAY_TIP"] = "게임에 접속할 때 오늘의 기념일을 팝업으로 표시합니다."
L["OPT_STARTTOAST_MICROHOLIDAY"] = "오늘의 작은 기념일 표시"
L["OPT_STARTTOAST_MICROHOLIDAY_TIP"] = "게임에 접속할 때 오늘의 작은 기념일을 팝업으로 표시합니다."
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP2"] = ""--]] 
L["OPT_STARTTOAST_ONLYCLICKFADE"] = "클릭해야만 사라지도록 설정"
L["OPT_STARTTOAST_ONLYCLICKFADE_TIP"] = "팝업 알림은 왼쪽 또는 오른쪽 마우스를 클릭하지 않으면 사라지지 않습니다.(체크하지 않으면 마우스를 멀리 이동하면 사라집니다.)"
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL_TIP"] = ""--]] 
L["OPT_STARTTOAST_TIMEFADE"] = "자동으로 숨기지 않음"
L["OPT_STARTTOAST_TIMEFADE_TIP"] = "이벤트 알림 팝업창을 자동으로 숨기지 않습니다."
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP2"] = ""--]] 
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING"] = "업적이 요구하는 요리 중에서 요리하지 않은 요리법 표시"
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING_TIP"] = "Overachiever의 거래 모듈이 활성화되어 있으면, 업적 아이콘은 업적이 요구하는 특정한 요리를 획득하기 위해 요리를 해야 하는 요리법 옆에 나타납니다. 이 옵션이 표시되어 있으면, 이 아이콘은 관련 업적이 완료된 경우에도 요리하지 않은 요리법 옆에 나타납니다."
L["OPT_TURKEYLURKEYTIPS"] = "칠면조 사냥총 사용 표시"
L["OPT_TURKEYLURKEYTIPS_TIP"] = "업적을 완료하지 않은 경우 해당하는 직업의 플레이어 툴팁에 칠명조 사냥총을 사용할 필요가 있는지 표시합니다."
L["OPT_UI_HOLIDAYNOTICE"] = "이벤트가 시작되면 알림 표시"
L["OPT_UI_HOLIDAYNOTICE_SUGGESTIONSTABONLY"] = "추천 탭에만 표시"
L["OPT_UI_HOLIDAYNOTICE_TIP"] = "이벤트가 오늘 시작되면 (예: 가을 축제 또는 다크문 축제), 업적창에 그림으로 알림을 표시합니다. 해당 이벤트의 업적을 확인하려면 클릭하십시오. 추가로 들어가서 상세 내용을 확인할 수 있습니다."
L["OPT_UI_HOLIDAYNOTICE_TIP2"] = "|cffffffff추천 탭 모듈이 필요합니다.|r"
L["OPT_UI_PROGRESSIFOTHERCOMPLETED"] = "수량획득 기반의 업적을 툴팁에 표시(다른 캐릭터가 완료했을지라도)"
L["OPT_UI_PROGRESSIFOTHERCOMPLETED_TIP"] = "업적에 마우스 커서가 있을 때, 수량획득 기반의 업적(예: 탈것 10가지 획득)으로 완료되는 경우에  다른 캐릭터가 완료하였고, 현재 캐릭터는 완료하지 못했다면 진행상황을 툴팁에 표시합니다."
L["OPT_UI_REQUIREDFORMETATIP"] = "요구하는 관련 업적 표시"
L["OPT_UI_REQUIREDFORMETATIP_TIP"] = "업적 달성을 위해 다른 업적을 달성해야 하면 달성해야 할 해당 업적을 표시합니다."
L["OPT_UI_SERIESTIP"] = "업적 세트 표시"
L["OPT_UI_SERIESTIP_TIP"] = "업적이 특정 세트에 속하는 업적이면 세트에 속한 모든 업적을 추가로 표시합니다."
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS_TIP"] = ""--]] 
L["OPT_WELLREADTIPS"] = "독서 상태 표시"
L["OPT_WELLREADTIPS_TIP"] = "업적을 완료하지 않았으면 툴팁에 독서가 필요하다고 표시합니다."
L["OPTPANEL_REMINDERTOOLTIPS"] = "툴팁 설정"
L["OVERACHIEVER_INSTALLED_MSG"] = "|cff7eff00Overachiever|r v%s 이 설치되었습니다."
L["OVERACHIEVER_INSTALLED_TOAST"] = "OVERACHIEVER 설치됨!"
L["OVERACHIEVER_UPDATED_MSG"] = "|cff7eff00Overachiever|r  v%s 으로 업데이트 되었습니다.."
L["OVERACHIEVER_UPDATED_TOAST"] = "OVERACHIEVER 업데이트됨!"
L["PROGRESS"] = "진행 상태"
L["PROGRESSIFOTHERCOMPLETED"] = "%s'의 진행상황:"
L["RECENTREMINDERCRITERIA"] = "최근 진행한 목표:"
L["REQUIREDFORMETATIP"] = "아래 업적이 요구함:"
L["SERIESTIP"] = "업적 세트:"
L["SOUND_AGGRO_PULLED"] = "위협수준 획득"
L["SOUND_AGGRO_WARNING"] = "위협수준 경고"
L["SOUND_ALARM1"] = "알람 시계 1"
L["SOUND_ALARM2"] = "알람 시계 2"
L["SOUND_ALARM3"] = "알람 시계 3"
L["SOUND_BELL_ALLIANCE"] = "종소리 - 얼라이언스"
L["SOUND_BELL_AUCTION"] = "경매장 종료 종소리"
L["SOUND_BELL_BOATARRIVED"] = "종소리 - 배 도착"
L["SOUND_BELL_HORDE"] = "종소리 - 호드"
L["SOUND_BELL_KARA"] = "카라잔 종소리"
L["SOUND_BELL_MELLOW"] = "부드러운 종소리"
L["SOUND_BELL_NIGHTELF"] = "종소리 - 나이트 엘프"
L["SOUND_BGTIMER"] = "전장 타이머"
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER_END"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BONUSEVENT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_CHAR_CREATE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_DIGSITE_COMPLETE"] = ""--]] 
L["SOUND_DING_AUCTION"] = "경매장 시작 종소리"
L["SOUND_DRUMHIT"] = "북소리"
L["SOUND_ENTERQUEUE"] = "전장 신청 소리"
L["SOUND_GARRISON_INVASION"] = "주둔지 침공 경고"
L["SOUND_GLYPH_CREATE_MAJOR"] = "주문양 생성"
L["SOUND_GLYPH_CREATE_MINOR"] = "보조문양 생성"
L["SOUND_GLYPH_DESTROY_MAJOR"] = "주문양 파괴"
L["SOUND_GLYPH_DESTROY_MINOR"] = "보조문양 파괴"
L["SOUND_GONG_TROLL"] = "징소리 - 트롤"
L["SOUND_HEARTHBIND"] = "귀환석 지정 소리"
--[[Translation missing --]]
--[[ L["SOUND_LEVELUP"] = ""--]] 
L["SOUND_MAP_PING"] = "미니맵 위치 알림 소리"
L["SOUND_MEDAL_EXPIRES"] = "메달 파괴"
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_GOLDTOSILVER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_SILVERTOBRONZE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_QUEST_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_BADPRESS"] = ""--]] 
L["SOUND_SIMON_DING"] = "시몬 종소리"
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_LARGE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_SMALL"] = ""--]] 
L["SOUND_SIMON_STARTGAME"] = "시몬 게임 시작"
L["SOUND_SIMON_STARTLEVEL"] = "시몬 레벨 시작"
--[[Translation missing --]]
--[[ L["SOUND_STORE_CONFIRM"] = ""--]] 
L["SOUND_YAR"] = "이야~~~르"
L["STARTTOAST_EVENT"] = "오늘의 시작"
L["WILDPET"] = "야생 동물"
L["YOURPROGRESS"] = "자신의 진행 상태"




elseif (locale == "esES" or locale == "esMX") then  -- Spanish
-- Thanks to user PatoDaia at wowinterface.com for many of these translations:
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_INCOMPLETE_EXTRA"] = ""--]] 
L["ACH_ANGLER_COMPLETE"] = "Ya lo has pescado"
--[[Translation missing --]]
--[[ L["ACH_ANGLER_COUNT"] = ""--]] 
L["ACH_ANGLER_INCOMPLETE"] = "Necesitas pescarlo"
L["ACH_BUNNYMAKER_COMPLETE"] = "Ya has usado Flores primaverales"
L["ACH_BUNNYMAKER_INCOMPLETE"] = "Necesitas usar Flores primaverales"
L["ACH_CHECKYOURHEAD_COMPLETE"] = "Ya calabaceado."
L["ACH_CHECKYOURHEAD_INCOMPLETE"] = "Necesita una calabaza en la cabeza"
L["ACH_CONSUME_91_COMPLETE"] = "Ya has demostrado tu glotonería"
L["ACH_CONSUME_91_INCOMPLETE"] = "¡ Te reto a comer 91 de una sentada !"
L["ACH_CONSUME_COMPLETE"] = "Ya lo has probado"
L["ACH_CONSUME_INCOMPLETE"] = "Necesitas probarlo"
L["ACH_CONSUME_INCOMPLETE_EXTRA"] = "Aún no lo has probado"
--[[Translation missing --]]
--[[ L["ACH_EATYOURGREENS_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_EATYOURGREENS_INCOMPLETE"] = ""--]] 
L["ACH_FISHSCHOOL_FORMAT"] = "Banco de %s"
L["ACH_FISTFULOFLOVE_COMPLETE"] = "Ya has usado un Puñado de Pétalos de Rosa"
L["ACH_FISTFULOFLOVE_INCOMPLETE"] = "Necesitas usar un Puñado de Pétalos de Rosa"
L["ACH_LETITSNOW_COMPLETE"] = "Ya has usado un Puñado de Copos de Nieve"
L["ACH_LETITSNOW_INCOMPLETE"] = "Necesitas usar un Puñado de Copos de Nieve"
L["ACH_LOVECRITTERS_COMPLETE"] = "Ya la has /amado"
L["ACH_LOVECRITTERS_INCOMPLETE"] = "Necesita algo de /amor"
--[[Translation missing --]]
--[[ L["ACH_MISSIONCOMPLETE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_MISSIONCOMPLETE_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_INCOMPLETE"] = ""--]] 
L["ACH_TURKEYLURKEY_COMPLETE"] = "Ya emplumado"
L["ACH_TURKEYLURKEY_INCOMPLETE"] = "Necesita unas plumas"
L["ACH_WELLREAD_COMPLETE"] = "Ya lo has leído"
L["ACH_WELLREAD_INCOMPLETE"] = "Necesitas leerlo"
L["BINDING_NAME_OVERACHIEVER_TAB_SEARCH"] = "Abrir pestaña de Búsqueda"
L["BINDING_NAME_OVERACHIEVER_TAB_SUGGESTIONS"] = "Abrir pestaña de Sugerencias"
L["BINDING_NAME_OVERACHIEVER_TAB_WATCH"] = "Abrir pestaña de Seguimiento"
L["COMPLETEDATE"] = "Completado en %1$02d/%2$02d/%3$02d"
L["CRITTER"] = "Alimaña"
--[[Translation missing --]]
--[[ L["HOLIDAY_BREWFEST"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_CHILDRENSWEEK"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_DARKMOONFAIRE"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_DAYOFTHEDEAD"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_HALLOWSEND"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_LOVEISINTHEAIR"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_LUNARFESTIVAL"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_MIDSUMMER"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_MIDSUMMER_SHORT"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_NOBLEGARDEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_PIGRIMSBOUNTY"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_PIRATESDAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_WINTERVEIL"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_WINTERVEIL_SHORT"] = ""--]] 
L["INCOMPLETE"] = "Incompleto"
L["KILL_COMPLETE"] = "Ya lo has matado"
L["KILL_INCOMPLETE"] = "Necesitas matarlo"
L["MSG_ACHNOTFOUND"] = "Logro no encontrado."
--[[Translation missing --]]
--[[ L["MSG_CRITERIAPROGRESS"] = ""--]] 
L["MSG_INVALIDID"] = "Entrada errónea: No hay ningún logro con esa ID."
L["MSG_NAMENOTFOUND"] = "No se ha encontrado ningún logro cuyo nombre contenga \"|cffffffff%s|r\"."
--[[Translation missing --]]
--[[ L["MSG_NOOPEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_NOOPEN_LIST"] = ""--]] 
L["MSG_NUMFOUNDLIST"] = "%s logros adicionales encontrados:"
L["MSG_ONEFOUND"] = "1 logro adicional encontrado: "
L["MSG_OPENINGTO"] = "Abriendo a: "
--[[Translation missing --]]
--[[ L["MULTI_NEED"] = ""--]] 
L["OPT_ACHUNKNOWN"] = "<Desconocido>"
--[[Translation missing --]]
--[[ L["OPT_ACQUIREDTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_ACQUIREDTIPS_TIP"] = ""--]] 
L["OPT_ANGLERTIPS"] = "Añadir si ya has pescado un banco de peces a su tooltip"
L["OPT_ANGLERTIPS_TIP"] = "Si este logro está incompleto, añade una línea al tooltip de los bancos de peces incluidos en el logro, para indicar que necesitas pescar en él."
--[[Translation missing --]]
--[[ L["OPT_ANGLERTIPS_TIP_ALWAYS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACK_CRITERIATOAST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACK_CRITERIATOAST_TIP"] = ""--]] 
L["OPT_AUTOTRACKEXPLORE"] = "Auto-seguir logros de exploración conforme viajas"
L["OPT_AUTOTRACKEXPLORE_COMPLETED"] = "Incluir logros completados"
L["OPT_AUTOTRACKEXPLORE_TIP"] = "Sigue automáticamente el logro de exploración asociado a una zona cuando entras en ella. No cambia si actualmente se está siguiendo otro logro que no sea de exploración."
L["OPT_AUTOTRACKTIMED"] = "Auto-seguir logros temporizados."
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACKTIMED_BG"] = ""--]] 
L["OPT_AUTOTRACKTIMED_TIP"] = "Sigue automáticamente los logros por tiempo cuando el temporizador comienza. No cambia si actualmente se está siguiendo otro logro a menos que fuese seguido automáticamente por Overachiever."
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACKTIMED_TIP_BG"] = ""--]] 
L["OPT_BUNNYMAKERTIPS"] = "Añadir si aún necesitas usar Flores primaverales"
L["OPT_BUNNYMAKERTIPS_TIP"] = "Si este logro está incompleto, añade una línea al tooltip de los jugadores del nivel y raza apropiados para indicar que necesitas usar un Flores primaverales sobre él. Se asumirá que los jugadores enemigos que sean superiores a tí por 10 niveles o más serán al menos de nivel 18."
L["OPT_CHECKYOURHEADTIPS"] = "Añadir si aún necesitas usar una Calabaza iluminada pesada"
L["OPT_CHECKYOURHEADTIPS_TIP"] = "Si este logro está incompleto, añade una línea al tooltip de los jugadores para indicar que necesitas usar una Calabaza iluminada pesada sobre él."
L["OPT_CONSUMEITEMTIPS"] = "Añadir si aún necesitas ingerir un consumible a su tooltip"
L["OPT_CONSUMEITEMTIPS_TIP"] = "Si este logro está incompleto, añade una línea al tooltip de los consumibles incluidos en el logro, para indicar que necesitas comerlo o beberlo."
L["OPT_CONSUMEITEMTIPS_TIP2"] = "Los consumibles para los que no tienes suficiente nivel no activaran un sonido recordatorio."
L["OPT_CONSUMEITEMTIPS_WHENCOMPLETE"] = "Mostrar incluso si el logro ha sido completado"
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_CHATLOG"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_CHATLOG_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_SUGGEST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_SUGGEST_TIP"] = ""--]] 
L["OPT_CRITTERTIPS"] = "Añadir estado de /amor al tooltip de las alimañas"
L["OPT_CRITTERTIPS_TIP"] = "Si este logro está incompleto, añade una línea al tooltip de las alimañas incluidas en el logro, para indicar que aún necesitas hacer /amor sobre ellas."
L["OPT_DRAGGABLE"] = "Permitir moverlo."
L["OPT_DRAGSAVE"] = "Recordar posición"
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS_TIP"] = ""--]] 
L["OPT_FISTFULOFLOVETIPS"] = "Añadir si aún necesitas usar un Puñado de Pétalos de Rosa"
L["OPT_FISTFULOFLOVETIPS_TIP"] = "Si este logro está incompleto, añade una línea al tooltip de los jugadores con la combinación de clase/raza incluida en el logro, para indicar que necesitas usar un Puñado de Pétalos de Rosa sobre él."
L["OPT_KILLCREATURETIPS"] = "Añadir si necesitas matar una criatura a su tooltip"
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_EXCLUDE_GUILD"] = ""--]] 
L["OPT_KILLCREATURETIPS_TIP"] = "Añade una linea al tooltip de las criaturas (excluyendo alimañas) que necesitan ser matadas para cumplir los requisitos de un logro incompleto, para indicar que aún necesitas matarlas."
L["OPT_KILLCREATURETIPS_TIP2"] = "Nota: Al inicio (o cuando esta opción es activada), cada logro es escaneado para encontrar la ID de las criaturas afectadas. No todos los logros informan de esas IDs. Muchos lo hacen, pero los tooltips de las criaturas que son necesarias para los logros que no lo hacen no serán afectadas por esta opción."
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_WHENCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_ACHFIVE"] = ""--]] 
L["OPT_LABEL_ACHFOUR"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\""
--[[Translation missing --]]
--[[ L["OPT_LABEL_ACHSEVEN"] = ""--]] 
L["OPT_LABEL_ACHSIX"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHTHREE"] = "\"%s,\" \"%s,\" y \"%s\""
L["OPT_LABEL_ACHTWO"] = "\"%s\" y \"%s\""
--[[Translation missing --]]
--[[ L["OPT_LABEL_CRITERIATOAST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_DRAENORANGLER"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_LOVECRITTER"] = ""--]] 
L["OPT_LABEL_MAINUI"] = "Modificiaciones del interface de Logros"
--[[Translation missing --]]
--[[ L["OPT_LABEL_MISC"] = ""--]] 
L["OPT_LABEL_NEEDTOKILL"] = "Logros de matar criaturas (\"%s,\" \"%s,\" etc.)"
L["OPT_LABEL_SEASONALACHS"] = "LOGROS DE TEMPORADA"
--[[Translation missing --]]
--[[ L["OPT_LABEL_STARTTOAST"] = ""--]] 
L["OPT_LABEL_TOOLTIPS"] = "Tooltips y Enlaces de Logros"
L["OPT_LABEL_TRACKING"] = "Seguimiento de Logros"
L["OPT_LABEL_TRADESKILLUI"] = "Modificaciones del interface de profesiones"
L["OPT_LETITSNOWTIPS"] = "Añadir si aún necesitas usar un Puñado de Copos de Nieve"
L["OPT_LETITSNOWTIPS_TIP"] = "Si este logro está incompleto, añade una línea al tooltip de los jugadores con la combinación de clase/raza incluida en el logro, para indicar que necesitas usar un Puñado de Copos de Nieve sobre él."
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_WHENCOMPLETE"] = ""--]] 
L["OPT_PESTCONTROLTIPS"] = "Añadir si ya has eliminado una alimaña a su tooltip."
L["OPT_PESTCONTROLTIPS_TIP"] = "Si este logro está incompleto, añade una línea al tooltip de las alimañas incluidas en el logro, para indicar que aún necesitas exterminarlas."
L["OPT_SATISFIEDTIPS"] = "¿ Satisfecho al 1000% ?"
L["OPT_SATISFIEDTIPS_TIP"] = "Añade una linea al tooltip de los objetos que son parte del criterio de logros para indicar si aún necesitas consumirlos."
L["OPT_SELECTSOUND"] = "Sonido Recordatorio de Logro Incompleto"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE"] = "Excluir recordatorio de pesca si esta equipada una caña"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP"] = "No reproduce el sonido recordatorio de los bancos de peces si llevas equipada una caña de pescar."
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_CHECKCOMBAT"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_CHECKCOMBAT_TIP"] = ""--]] 
L["OPT_SELECTSOUND_TIP"] = "Reproduce el sonido seleccionado cuando el recordatorio para un logro incompleto es añadido al tooltip."
L["OPT_SELECTSOUND_TIP2"] = "El sonido recordatorio sólo se reproducirá una vez cada 15 segundos."
L["OPT_SHOWID"] = "Mostrar las IDs de los logros"
L["OPT_SHOWPROGRESS"] = "Añadir tu progreso"
L["OPT_SHOWPROGRESS_OTHER"] = "Comparar progreso con los logros de otros jugadores"
L["OPT_SHOWPROGRESS_OTHER_TIP"] = "Añade tu progreso cuando se muestre la información de un logro para otro jugador."
L["OPT_SHOWPROGRESS_TIP"] = "Añade tu progreso cuando un logro esta basado en un criterio cuantitativo, como \"Obtener 10 monturas.\""
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_BONUS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_BONUS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_DUNGEON"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_DUNGEON_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_HOLIDAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_HOLIDAY_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MICROHOLIDAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MICROHOLIDAY_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_ONLYCLICKFADE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_ONLYCLICKFADE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_TIMEFADE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_TIMEFADE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP2"] = ""--]] 
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING"] = "Indica las recetas sin cocinar para logros completados"
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING_TIP"] = "Si el módulo Overachiever - Trade está activado, aparecerá el icono de logro junto a las recetas que necesites cocinar para obtener ciertos logros. Si esta opción está  seleccionada, esos iconos aparecerán junto a las recetas sin cocinar incluso si el logro asociado a ellas ya ha sido completado."
L["OPT_TURKEYLURKEYTIPS"] = "Añadir si aún necesitas usar una Pavopistola"
L["OPT_TURKEYLURKEYTIPS_TIP"] = "Si este logro está incompleto, añade una línea al tooltip de los jugadores para indicar que necesitas usar tu Pavopistola sobre él."
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE_SUGGESTIONSTABONLY"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_PROGRESSIFOTHERCOMPLETED"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_PROGRESSIFOTHERCOMPLETED_TIP"] = ""--]] 
L["OPT_UI_REQUIREDFORMETATIP"] = "Tooltip en los logros requeridos por otros logros."
L["OPT_UI_REQUIREDFORMETATIP_TIP"] = "Cuando el cursor esta sobre un logro que es requerido para obtener otro logro, muestra el nombre del meta-logro."
L["OPT_UI_SERIESTIP"] = "Mostrar tooltip sobre logros que son parte de una serie"
L["OPT_UI_SERIESTIP_TIP"] = "Cuando el cursor esta sobre un logro que es parte de una serie, muestra los nombres de otros logros de la misma serie y su relación con ellos."
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS_TIP"] = ""--]] 
L["OPT_WELLREADTIPS"] = "Añadir si ya has leido un libro a su tooltip"
L["OPT_WELLREADTIPS_TIP"] = "Si este logro está incompleto, añade una línea al tooltip de los libros incluidos en el logro, para indicar que necesitas leerlos."
L["OPTPANEL_REMINDERTOOLTIPS"] = "Tooltips recordatorios"
--[[Translation missing --]]
--[[ L["OVERACHIEVER_INSTALLED_MSG"] = ""--]] 
--[[Translation missing --]]
--[[ L["OVERACHIEVER_INSTALLED_TOAST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OVERACHIEVER_UPDATED_MSG"] = ""--]] 
--[[Translation missing --]]
--[[ L["OVERACHIEVER_UPDATED_TOAST"] = ""--]] 
L["PROGRESS"] = "Progreso"
--[[Translation missing --]]
--[[ L["PROGRESSIFOTHERCOMPLETED"] = ""--]] 
--[[Translation missing --]]
--[[ L["RECENTREMINDERCRITERIA"] = ""--]] 
L["REQUIREDFORMETATIP"] = "Requerido para:"
L["SERIESTIP"] = "Parte de una serie:"
--[[Translation missing --]]
--[[ L["SOUND_AGGRO_PULLED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_AGGRO_WARNING"] = ""--]] 
L["SOUND_ALARM1"] = "Alarma de Reloj 1"
L["SOUND_ALARM2"] = "Alarma de Reloj 2"
L["SOUND_ALARM3"] = "Alarma de Reloj 3"
L["SOUND_BELL_ALLIANCE"] = "Campana - Alianza"
L["SOUND_BELL_AUCTION"] = "Campana de Subasta"
L["SOUND_BELL_BOATARRIVED"] = "Campana - Llegada de Barco"
L["SOUND_BELL_HORDE"] = "Campana - Horda"
L["SOUND_BELL_KARA"] = "Campana Karazhan"
L["SOUND_BELL_MELLOW"] = "Campanilla"
L["SOUND_BELL_NIGHTELF"] = "Campana - Elfo de la Noche"
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER_END"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BONUSEVENT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_CHAR_CREATE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_DIGSITE_COMPLETE"] = ""--]] 
L["SOUND_DING_AUCTION"] = "Tintineo de Subasta"
L["SOUND_DRUMHIT"] = "Golpe de Tambor"
L["SOUND_ENTERQUEUE"] = "Esperar en la Fila"
--[[Translation missing --]]
--[[ L["SOUND_GARRISON_INVASION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_CREATE_MAJOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_CREATE_MINOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_DESTROY_MAJOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_DESTROY_MINOR"] = ""--]] 
L["SOUND_GONG_TROLL"] = "Gong - Troll"
L["SOUND_HEARTHBIND"] = "Enlazar Piedra de Hogar"
--[[Translation missing --]]
--[[ L["SOUND_LEVELUP"] = ""--]] 
L["SOUND_MAP_PING"] = "Ping del Mapa"
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_EXPIRES"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_GOLDTOSILVER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_SILVERTOBRONZE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_QUEST_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_BADPRESS"] = ""--]] 
L["SOUND_SIMON_DING"] = "Simon - Ding"
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_LARGE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_SMALL"] = ""--]] 
L["SOUND_SIMON_STARTGAME"] = "Simon - Inicio de Juego"
L["SOUND_SIMON_STARTLEVEL"] = "Simon - Inicio de Nivel"
--[[Translation missing --]]
--[[ L["SOUND_STORE_CONFIRM"] = ""--]] 
L["SOUND_YAR"] = "Yarrrr"
--[[Translation missing --]]
--[[ L["STARTTOAST_EVENT"] = ""--]] 
L["WILDPET"] = "Mascota salvaje"
L["YOURPROGRESS"] = "Tu progreso"



	if (locale == "esMX") then  -- Spanish (Mexican)
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_INCOMPLETE_EXTRA"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_ANGLER_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_ANGLER_COUNT"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_ANGLER_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_BUNNYMAKER_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_BUNNYMAKER_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_CHECKYOURHEAD_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_CHECKYOURHEAD_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_CONSUME_91_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_CONSUME_91_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_CONSUME_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_CONSUME_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_CONSUME_INCOMPLETE_EXTRA"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_EATYOURGREENS_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_EATYOURGREENS_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_FISHSCHOOL_FORMAT"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_FISTFULOFLOVE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_FISTFULOFLOVE_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_LETITSNOW_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_LETITSNOW_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_LOVECRITTERS_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_LOVECRITTERS_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_MISSIONCOMPLETE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_MISSIONCOMPLETE_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_TURKEYLURKEY_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_TURKEYLURKEY_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_WELLREAD_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_WELLREAD_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["BINDING_NAME_OVERACHIEVER_TAB_SEARCH"] = ""--]] 
--[[Translation missing --]]
--[[ L["BINDING_NAME_OVERACHIEVER_TAB_SUGGESTIONS"] = ""--]] 
--[[Translation missing --]]
--[[ L["BINDING_NAME_OVERACHIEVER_TAB_WATCH"] = ""--]] 
--[[Translation missing --]]
--[[ L["COMPLETEDATE"] = ""--]] 
--[[Translation missing --]]
--[[ L["CRITTER"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_BREWFEST"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_CHILDRENSWEEK"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_DARKMOONFAIRE"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_DAYOFTHEDEAD"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_HALLOWSEND"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_LOVEISINTHEAIR"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_LUNARFESTIVAL"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_MIDSUMMER"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_MIDSUMMER_SHORT"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_NOBLEGARDEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_PIGRIMSBOUNTY"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_PIRATESDAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_WINTERVEIL"] = ""--]] 
--[[Translation missing --]]
--[[ L["HOLIDAY_WINTERVEIL_SHORT"] = ""--]] 
--[[Translation missing --]]
--[[ L["INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["KILL_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["KILL_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_ACHNOTFOUND"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_CRITERIAPROGRESS"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_INVALIDID"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_NAMENOTFOUND"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_NOOPEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_NOOPEN_LIST"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_NUMFOUNDLIST"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_ONEFOUND"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_OPENINGTO"] = ""--]] 
--[[Translation missing --]]
--[[ L["MULTI_NEED"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_ACHUNKNOWN"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_ACQUIREDTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_ACQUIREDTIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_ANGLERTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_ANGLERTIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_ANGLERTIPS_TIP_ALWAYS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACK_CRITERIATOAST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACK_CRITERIATOAST_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACKEXPLORE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACKEXPLORE_COMPLETED"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACKEXPLORE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACKTIMED"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACKTIMED_BG"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACKTIMED_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACKTIMED_TIP_BG"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_BUNNYMAKERTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_BUNNYMAKERTIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CHECKYOURHEADTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CHECKYOURHEADTIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CONSUMEITEMTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CONSUMEITEMTIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CONSUMEITEMTIPS_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CONSUMEITEMTIPS_WHENCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_CHATLOG"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_CHATLOG_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_SUGGEST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_SUGGEST_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITTERTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITTERTIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_DRAGGABLE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_DRAGSAVE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_FISTFULOFLOVETIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_FISTFULOFLOVETIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_EXCLUDE_GUILD"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_WHENCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_ACHFIVE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_ACHFOUR"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_ACHSEVEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_ACHSIX"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_ACHTHREE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_ACHTWO"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_CRITERIATOAST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_DRAENORANGLER"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_LOVECRITTER"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_MAINUI"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_MISC"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_NEEDTOKILL"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_SEASONALACHS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_STARTTOAST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_TOOLTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_TRACKING"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LABEL_TRADESKILLUI"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LETITSNOWTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_LETITSNOWTIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_WHENCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_PESTCONTROLTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_PESTCONTROLTIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SATISFIEDTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SATISFIEDTIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_ANGLERCHECKPOLE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_CHECKCOMBAT"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_CHECKCOMBAT_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SHOWID"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SHOWPROGRESS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SHOWPROGRESS_OTHER"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SHOWPROGRESS_OTHER_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SHOWPROGRESS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_BONUS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_BONUS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_DUNGEON"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_DUNGEON_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_HOLIDAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_HOLIDAY_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MICROHOLIDAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MICROHOLIDAY_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_ONLYCLICKFADE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_ONLYCLICKFADE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_TIMEFADE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_TIMEFADE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_TURKEYLURKEYTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_TURKEYLURKEYTIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE_SUGGESTIONSTABONLY"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_PROGRESSIFOTHERCOMPLETED"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_PROGRESSIFOTHERCOMPLETED_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_REQUIREDFORMETATIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_REQUIREDFORMETATIP_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_SERIESTIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_SERIESTIP_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_WELLREADTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_WELLREADTIPS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPTPANEL_REMINDERTOOLTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OVERACHIEVER_INSTALLED_MSG"] = ""--]] 
--[[Translation missing --]]
--[[ L["OVERACHIEVER_INSTALLED_TOAST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OVERACHIEVER_UPDATED_MSG"] = ""--]] 
--[[Translation missing --]]
--[[ L["OVERACHIEVER_UPDATED_TOAST"] = ""--]] 
--[[Translation missing --]]
--[[ L["PROGRESS"] = ""--]] 
--[[Translation missing --]]
--[[ L["PROGRESSIFOTHERCOMPLETED"] = ""--]] 
--[[Translation missing --]]
--[[ L["RECENTREMINDERCRITERIA"] = ""--]] 
--[[Translation missing --]]
--[[ L["REQUIREDFORMETATIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SERIESTIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_AGGRO_PULLED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_AGGRO_WARNING"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_ALARM1"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_ALARM2"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_ALARM3"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BELL_ALLIANCE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BELL_AUCTION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BELL_BOATARRIVED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BELL_HORDE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BELL_KARA"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BELL_MELLOW"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BELL_NIGHTELF"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER_END"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BONUSEVENT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_CHAR_CREATE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_DIGSITE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_DING_AUCTION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_DRUMHIT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_ENTERQUEUE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GARRISON_INVASION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_CREATE_MAJOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_CREATE_MINOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_DESTROY_MAJOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GLYPH_DESTROY_MINOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GONG_TROLL"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_HEARTHBIND"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_LEVELUP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_MAP_PING"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_EXPIRES"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_GOLDTOSILVER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_SILVERTOBRONZE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_QUEST_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_BADPRESS"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_DING"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_LARGE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_SMALL"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_STARTGAME"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_STARTLEVEL"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_STORE_CONFIRM"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_YAR"] = ""--]] 
--[[Translation missing --]]
--[[ L["STARTTOAST_EVENT"] = ""--]] 
--[[Translation missing --]]
--[[ L["WILDPET"] = ""--]] 
--[[Translation missing --]]
--[[ L["YOURPROGRESS"] = ""--]] 

	end

elseif (locale == "ptBR") then  -- Brazilian Portuguese
L["ACH_ACQUIRE_COMPLETE"] = "Já adquirido"
L["ACH_ACQUIRE_INCOMPLETE"] = "Necessita adquirir"
L["ACH_ACQUIRE_INCOMPLETE_EXTRA"] = "Não adquirido"
L["ACH_ANGLER_COMPLETE"] = "Já foi pescado"
L["ACH_ANGLER_COUNT"] = [=[9455=Cardume de Amonitas de Fogo
9456=Cardume de Enguias Abissais,Cardume de Enguias Abissais Oleosas
9457=Cardume de Azorragues Aguanegra
9458=Cardume de Esturjões Cegos do Lago
9459=Cardume de Pestanas Gordos
9460=Cardume de Sorrateiros Sem-queixo
9461=Cardume de Escorpiões do Mar,Cardume de Escorpiões do Mar Oleosos]=]
L["ACH_ANGLER_INCOMPLETE"] = "Precisa pescar"
L["ACH_BUNNYMAKER_COMPLETE"] = "Já usou Flores de Primavera"
L["ACH_BUNNYMAKER_INCOMPLETE"] = "Precisa usar Flores de Primavera"
L["ACH_CHECKYOURHEAD_COMPLETE"] = "Já usou Cabeça-de-abóbora"
L["ACH_CHECKYOURHEAD_INCOMPLETE"] = "Precisa de uma cabeça de abóbora"
L["ACH_CONSUME_91_COMPLETE"] = "Glutonaria já provada"
L["ACH_CONSUME_91_INCOMPLETE"] = "Eu te desafio a comer 91 de uma vez!"
L["ACH_CONSUME_COMPLETE"] = "Já foi consumido"
L["ACH_CONSUME_INCOMPLETE"] = "Precisa consumir"
L["ACH_CONSUME_INCOMPLETE_EXTRA"] = "Ainda não consumido"
L["ACH_EATYOURGREENS_COMPLETE"] = "Já consumido"
L["ACH_EATYOURGREENS_INCOMPLETE"] = "Precisa consumir"
L["ACH_FISHSCHOOL_FORMAT"] = [=[Cardume de %s
Grande Cardume de %s
Cardume Enorme de %s]=]
L["ACH_FISTFULOFLOVE_COMPLETE"] = "Punhado de Pétalas de Rosa já utilizado"
L["ACH_FISTFULOFLOVE_INCOMPLETE"] = "Precisa usar Punhado de Pétalas de Rosa"
L["ACH_LETITSNOW_COMPLETE"] = "Punhado de Flocos de Neve já utilizado"
L["ACH_LETITSNOW_INCOMPLETE"] = "Precisa usar Punhado de Flocos de Neve"
L["ACH_LOVECRITTERS_COMPLETE"] = "Já /amou"
L["ACH_LOVECRITTERS_INCOMPLETE"] = "Precisa /amar"
L["ACH_MISSIONCOMPLETE_COMPLETE"] = "Completado anteriormente"
L["ACH_MISSIONCOMPLETE_INCOMPLETE"] = "Necessita completar"
--[[Translation missing --]]
--[[ L["ACH_RIDE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_INCOMPLETE"] = ""--]] 
L["ACH_TURKEYLURKEY_COMPLETE"] = "Já \"empenado\""
L["ACH_TURKEYLURKEY_INCOMPLETE"] = "Precisa de penas"
L["ACH_WELLREAD_COMPLETE"] = "Já lido"
L["ACH_WELLREAD_INCOMPLETE"] = "Precisa ser lido"
L["BINDING_NAME_OVERACHIEVER_TAB_SEARCH"] = "Abrir Aba de Buscas"
L["BINDING_NAME_OVERACHIEVER_TAB_SUGGESTIONS"] = "Abrir Aba de Sugestões"
L["BINDING_NAME_OVERACHIEVER_TAB_WATCH"] = "Abrir Aba de Vigia"
L["COMPLETEDATE"] = "Completado em  %1$02d/%2$d/%3$02d"
L["CRITTER"] = "Bicho"
L["HOLIDAY_BREWFEST"] = "CervaFest"
L["HOLIDAY_CHILDRENSWEEK"] = "Semana das Crianças"
L["HOLIDAY_DARKMOONFAIRE"] = "Feira de Negraluna"
L["HOLIDAY_DAYOFTHEDEAD"] = "Dia dos Mortos"
L["HOLIDAY_HALLOWSEND"] = "Noturnália"
L["HOLIDAY_LOVEISINTHEAIR"] = "O Amor Está No Ar"
L["HOLIDAY_LUNARFESTIVAL"] = "Festival da Lua"
L["HOLIDAY_MIDSUMMER"] = "Festival do Fogo do Solstício"
L["HOLIDAY_MIDSUMMER_SHORT"] = "Solstício"
L["HOLIDAY_NOBLEGARDEN"] = "Jardinova"
L["HOLIDAY_PIGRIMSBOUNTY"] = "Festa da Fartura"
L["HOLIDAY_PIRATESDAY"] = "Dia dos Piratas"
L["HOLIDAY_WINTERVEIL"] = "Festa do Véu de Inverno"
L["HOLIDAY_WINTERVEIL_SHORT"] = "Véu de Inverno"
L["INCOMPLETE"] = "Incompleto"
L["KILL_COMPLETE"] = "Já matou"
L["KILL_INCOMPLETE"] = "Precisa matar"
L["MSG_ACHNOTFOUND"] = "Conquista não encontrada."
L["MSG_CRITERIAPROGRESS"] = "|cff7eff00Progresso da conquista:|r %s (%s)"
L["MSG_INVALIDID"] = "Dados inválidos: Nenhuma conquista com esse ID."
L["MSG_NAMENOTFOUND"] = "Nenhuma conquista cujo nome contenha \"|cffffffff%s|r\" foi encontrada."
L["MSG_NOOPEN"] = "Não foi possível abrir a conquista. Nenhuma visível na UI."
L["MSG_NOOPEN_LIST"] = "Conquista não encontrada"
L["MSG_NUMFOUNDLIST"] = "%s outras conquistas encontradas:"
L["MSG_ONEFOUND"] = "1 outra conquista encontrada:"
L["MSG_OPENINGTO"] = "Abrindo para:"
L["MULTI_NEED"] = "%s (requisito de %s conquistas)"
L["OPT_ACHUNKNOWN"] = "<desconhecido>"
L["OPT_ACQUIREDTIPS"] = "Item adquirido?"
L["OPT_ACQUIREDTIPS_TIP"] = "Adicione uma linha às dicas de items para indicar se você precisa adquiri-los para uma conquista"
L["OPT_ANGLERTIPS"] = "Cardume pescado?"
L["OPT_ANGLERTIPS_TIP"] = "Se uma conquista estiver incompleta, adiciona uma linha às dicas de tela dos pontos de pesca que fazem parte dos critérios da conquista para indicar se você precisa pescar neste lugar."
L["OPT_ANGLERTIPS_TIP_ALWAYS"] = "Adiciona uma linha à dica de tela dos pontos de pesca que são parte dos critérios, para indicar se você precisa pescá-los."
L["OPT_AUTOTRACK_CRITERIATOAST"] = "Listar autom. após mostrar \"Progresso de Conquista\""
L["OPT_AUTOTRACK_CRITERIATOAST_TIP"] = "Quando o aviso de \"Progresso da conquista\" aparece na tela, começa a listar a conquista automaticamente (se o limite de conquistas listadas permitir)."
L["OPT_AUTOTRACKEXPLORE"] = "Listar automaticamente conquistas de exploração enquanto você viaja"
L["OPT_AUTOTRACKEXPLORE_COMPLETED"] = "Incluindo conquistas completadas"
L["OPT_AUTOTRACKEXPLORE_TIP"] = "Quando você entra em uma zona, lista automaticamente sua conquista de exploração. Se já estiver listando uma conquista de exploração, isto vai substituir a conquista previamente listada automaticamente."
L["OPT_AUTOTRACKTIMED"] = "Listar automaticamente conquistas temporizadas (fora CB)"
L["OPT_AUTOTRACKTIMED_BG"] = "Listar automaticamente conquistas temporizadas de campos de batalha"
L["OPT_AUTOTRACKTIMED_TIP"] = "Listar automaticamente conquistas com critérios temporizados quando o cronômetro iniciar. Se você já estiver listando o número máximo de conquistas, esta vai tentar tomar o lugar de uma conquista de exploração listada automaticamente; caso contrário, não será listada."
L["OPT_AUTOTRACKTIMED_TIP_BG"] = "No início de uma partida de campo de batalha, lista automaticamente a conquista para vencê-la em tempo determinado (se estiver incompleta).|n|nA conquista é removida da lista após sair do campo de batalha."
L["OPT_BUNNYMAKERTIPS"] = "Flores de Primavera já usadas?"
L["OPT_BUNNYMAKERTIPS_TIP"] = "Se a conquista está incompleta, adiciona uma linha às dicas de tela de jogadores do gênero e nível apropriados para indicar se você precisa usar Flores de primavera neles. Note que jogadores inimigos que são 10 níveis ou mais acima de você são considerados como sendo no mínimo nível 18."
L["OPT_CHECKYOURHEADTIPS"] = "Lanterna de Abóbora com Peso usada?"
L["OPT_CHECKYOURHEADTIPS_TIP"] = "Se a conquista está completa, adicionar uma linha às dicas de tela de jogadores para indicar se você precisa usar uma Lanterna de Abóbora com Peso neles."
L["OPT_CONSUMEITEMTIPS"] = "Item consumido?"
L["OPT_CONSUMEITEMTIPS_TIP"] = "Se a conquista estiver incompleta, adicionar uma linha às dicas de tela dos itens que são parte dos seus critérios para indicar se você precisa consumi-los."
L["OPT_CONSUMEITEMTIPS_TIP2"] = "Os itens que você tem o nível muito baixo para consumir não vão disparar um som de lembrete."
L["OPT_CONSUMEITEMTIPS_WHENCOMPLETE"] = "Mostrar mesmo se a conquista estiver completa"
L["OPT_CRITERIATOAST_CHATLOG"] = "Adicionar ao registro de chat"
L["OPT_CRITERIATOAST_CHATLOG_TIP"] = "Quando o aviso de \"Progresso de conquista\" aparecer, cria um link da conquista e mostra o critério completado na área de chat."
L["OPT_CRITERIATOAST_SUGGEST"] = "Adicionar a lembretes recentes (Sugestões)"
L["OPT_CRITERIATOAST_SUGGEST_TIP"] = "Quando o aviso \"Progresso da conquista\" aparecer, adiciona a conquista temporariamente à aba de sugestões como um \"Lembrete recente\"."
L["OPT_CRITTERTIPS"] = "Criatura /amada?"
L["OPT_CRITTERTIPS_TIP"] = "Se essa conquista estiver incompleta, adiciona uma linha às dicas de tela de bichos que são parte dos seus critérios para indicar se você ainda precisa /amar esse tipo de bicho."
L["OPT_DRAGGABLE"] = "Tornar arrastável"
L["OPT_DRAGSAVE"] = "Lembrar posição"
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS"] = ""--]] 
L["OPT_EATYOURGREENSTIPS_TIP"] = "Se a conquista estiver incompleta, adicione uma linha as dicas de plantas em Nazmir que você precisa consumir."
L["OPT_FISTFULOFLOVETIPS"] = "Punhado de Pétalas de Rosas usado?"
L["OPT_FISTFULOFLOVETIPS_TIP"] = "Se a conquista estiver incompleta, acrescenta uma linha às dicas de tela de jogadores da combinação de raça/classe apropriada para indicar se você precisa usar um Punhado de Pétalas de Rosas neles."
L["OPT_KILLCREATURETIPS"] = "Criatura morta?"
L["OPT_KILLCREATURETIPS_EXCLUDE_GUILD"] = "Conquista de guilda excluidas"
L["OPT_KILLCREATURETIPS_TIP"] = "Adiciona uma linha às dicas de telas de criaturas (excluindo bichos) que precisam ser mortas para satisfazer os critérios de uma conquista incompleta, indicando se você ainda precisa matá-las."
L["OPT_KILLCREATURETIPS_TIP2"] = "Nota: Ao iniciar (ou quando esta opção está marcada), cada conquista é escaneada para encontrar IDs de unidades. Nem todas as conquistas fornecem estas IDs. A maioria sim, mas as dicas de tela de criaturas que são critério das que não fornecem não serão alteradas por esta opção."
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_WHENCOMPLETE"] = ""--]] 
L["OPT_LABEL_ACHFIVE"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s\""
L["OPT_LABEL_ACHFOUR"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHSEVEN"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s,\" \"%s,\" \"%s\""
L["OPT_LABEL_ACHSIX"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHTHREE"] = "\"%s,\" \"%s,\" e \"%s\""
L["OPT_LABEL_ACHTWO"] = "\"%s\" e \"%s\""
L["OPT_LABEL_CRITERIATOAST"] = "Reação a progresso (sem rastreio)"
L["OPT_LABEL_DRAENORANGLER"] = "Subconquistas de \"%s\""
--[[Translation missing --]]
--[[ L["OPT_LABEL_LOVECRITTER"] = ""--]] 
L["OPT_LABEL_MAINUI"] = "Modificações da Página Principal das Conquistas"
L["OPT_LABEL_MISC"] = "Diversos"
L["OPT_LABEL_NEEDTOKILL"] = "Conquistas de Matar criaturas (\"%s,\" \"%s,\" etc.)"
L["OPT_LABEL_SEASONALACHS"] = "CONQUISTAS SAZONAIS"
L["OPT_LABEL_STARTTOAST"] = "Avisos de feriados/eventos"
L["OPT_LABEL_TOOLTIPS"] = "Dicas de tela e vínculos para Conquistas"
L["OPT_LABEL_TRACKING"] = "Listagem de conquistas"
L["OPT_LABEL_TRADESKILLUI"] = "Modificações nas tela das profissões"
L["OPT_LETITSNOWTIPS"] = "Punhado de Flocos de Neve utilizado?"
L["OPT_LETITSNOWTIPS_TIP"] = "Se a conquista estiver incompleta, acrescentar uma linha às dicas de tela de jogadores da combinação de raça/classe apropriada para indicar se você precisa um Punhado de Flocos de Neve neles."
L["OPT_MISSIONCOMPLETE"] = "Missão incompleta?"
L["OPT_MISSIONCOMPLETE_TIP"] = "Adicione uma linha as dicas de missões para indicar se você precisa completa-las para uma conquista."
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_WHENCOMPLETE"] = ""--]] 
L["OPT_PESTCONTROLTIPS"] = "Praga exterminada?"
L["OPT_PESTCONTROLTIPS_TIP"] = "Se essa conquista está incompleta, adicionar uma linha às dicas de tela de bichos que fazem parte de seus critérios para indicar se você precisa exterminá-los."
L["OPT_SATISFIEDTIPS"] = "1000% Satisfeito?"
L["OPT_SATISFIEDTIPS_TIP"] = "Adiciona uma linha nas dicas de tela dos itens que são parte dos critérios da conquista para indicar se você precisa consumí-los."
L["OPT_SELECTSOUND"] = "Som de Lembrete de Conquista Incompleta"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE"] = "Ignorar lembretes de cardume se a vara estiver equipada"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP"] = "Não tocar som de lembrete de cardumes se sua vara de pesca estiver equipada."
L["OPT_SELECTSOUND_CHECKCOMBAT"] = "Ignorar lembretes de abate se estiver em combate com criatura"
L["OPT_SELECTSOUND_CHECKCOMBAT_TIP"] = "Não toca um som de lembrete para matar uma criatura enquanto você estiver em combate com ela."
L["OPT_SELECTSOUND_TIP"] = "Tocar o som selecionado quando um lembrete de conquista incompleta for adicionado à dica de tela."
L["OPT_SELECTSOUND_TIP2"] = "Os sons tocarão apenas uma vez a cada 15 segundos."
L["OPT_SHOWID"] = "Mostrar ID das Conquistas"
L["OPT_SHOWPROGRESS"] = "Adicionar seu progresso"
L["OPT_SHOWPROGRESS_OTHER"] = "Comparar o progresso nos vínculos de outros"
L["OPT_SHOWPROGRESS_OTHER_TIP"] = "Adiciona seu progresso quando a informação de conquista mostrada é de um outro jogador."
L["OPT_SHOWPROGRESS_TIP"] = "Adiciona seu progresso quando uma conquista tem critérios baseados em quantidade, como \"Obter 10 montarias\"."
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TIP2"] = ""--]] 
L["OPT_STARTTOAST_BONUS"] = "Mostrar eventos bônus de hoje"
L["OPT_STARTTOAST_BONUS_TIP"] = "Mostra os eventos bônus de hoje em avisos na tela assim que entrar no jogo."
L["OPT_STARTTOAST_DUNGEON"] = "Mostrar eventos de masmorras de hoje"
L["OPT_STARTTOAST_DUNGEON_TIP"] = "Mostra os eventos de masmorra de hoje em avisos na tela assim que entrar no jogo."
L["OPT_STARTTOAST_HOLIDAY"] = "Mostrar feriados de hoje"
L["OPT_STARTTOAST_HOLIDAY_TIP"] = "Mostra os feriados de hoje em avisos na tela assim que entrar no jogo."
L["OPT_STARTTOAST_MICROHOLIDAY"] = "Mostrar os microferiados de hoje"
L["OPT_STARTTOAST_MICROHOLIDAY_TIP"] = "Mostra os microferiados de hoje em avisos na tela assim que entrar no jogo."
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP2"] = ""--]] 
L["OPT_STARTTOAST_ONLYCLICKFADE"] = "Exigir clique para ocultar"
L["OPT_STARTTOAST_ONLYCLICKFADE_TIP"] = "Impede que notificações de aviso na tela desapareçam sozinhas a não ser que sejam clicadas com um botão do mouse. (Se desmarcada, os avisos também desaparecerão quando o ponteiro passa por cima deles e depois sai.)"
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL_TIP"] = ""--]] 
L["OPT_STARTTOAST_TIMEFADE"] = "Não ocultar automaticamente"
L["OPT_STARTTOAST_TIMEFADE_TIP"] = "Impede que os avisos na tela com os quais você não interagir desapareçam depois de alguns segundos."
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP2"] = ""--]] 
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING"] = "Indicar receitas não cozinhadas para completar conquistas"
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING_TIP"] = "Se o módulo Overachiever Trade estiver habilitado, então um ícone da conquista aparece próximo às receitas que você precisa cozinhar para ganhar certas conquistas. Se esta opção estiver marcada, então estes ícones aparecerão próximos às receitas não cozinhadas mesmo que a conquista associadas esteja completa."
L["OPT_TURKEYLURKEYTIPS"] = "Atirador de Peru usado?"
L["OPT_TURKEYLURKEYTIPS_TIP"] = "Se a conquista está incompleta, adiciona uma linha nas dicas de tela dos jogadores para indicar se você precisa usar seu Atirador de Peru neles."
L["OPT_UI_HOLIDAYNOTICE"] = "Mostrar um aviso se um evento está acontecendo"
L["OPT_UI_HOLIDAYNOTICE_SUGGESTIONSTABONLY"] = "Apenas na aba Sugestões"
L["OPT_UI_HOLIDAYNOTICE_TIP"] = "Se tiver um evento de feriado hoje (como CervaFest ou Feira de Negraluna), um aviso gráfico aparece próximo à tela de conquistas. Clicar nele mostrará as conquistas para esse evento. Posicione o ponteiro do mouse sobre ele para mais detalhes."
L["OPT_UI_HOLIDAYNOTICE_TIP2"] = "|cffffffffMódulo de abas com a aba Sugestões é necessário.|r"
L["OPT_UI_PROGRESSIFOTHERCOMPLETED"] = "Dica de tela para progresso baseado em quantidades se completado por outra"
L["OPT_UI_PROGRESSIFOTHERCOMPLETED_TIP"] = "Quando o ponteiro do mouse está sobre uma conquista baseada em quantidade (ex. critério de \"Obter 10 montarias\") que foi completado mas não pelo personagem atual, mostra apenas o progresso do personagem atual."
L["OPT_UI_REQUIREDFORMETATIP"] = "Dica de tela para conquistas requeridas por outros"
L["OPT_UI_REQUIREDFORMETATIP_TIP"] = "Quando o cursor está sobre uma conquista que é requerida para obter outra conquista, mostrar o nome da meta-conquista."
L["OPT_UI_SERIESTIP"] = "Dica de tela para conquistas que fazem parte de uma série"
L["OPT_UI_SERIESTIP_TIP"] = "Quando o cursor estiver sobre uma conquista que faz parte de uma série, mostrar os nomes das outras na série e sua relação com elas."
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS_TIP"] = ""--]] 
L["OPT_WELLREADTIPS"] = "Livro lido?"
L["OPT_WELLREADTIPS_TIP"] = "Se a conquista estiver incompleta, adicionar uma linha às dicas de tela de livros que fazem parte dos seus critérios para indicar se você precisa lê-los."
L["OPTPANEL_REMINDERTOOLTIPS"] = "Dicas de tela"
L["OVERACHIEVER_INSTALLED_MSG"] = "|cff7eff00Overachiever|r v%s foi instalado."
L["OVERACHIEVER_INSTALLED_TOAST"] = "OVERACHIEVER INSTALADO!"
L["OVERACHIEVER_UPDATED_MSG"] = "|cff7eff00Overachiever|r foi atualizado para v%s."
L["OVERACHIEVER_UPDATED_TOAST"] = "OVERACHIEVER ATUALIZADO!"
L["PROGRESS"] = "Progresso"
L["PROGRESSIFOTHERCOMPLETED"] = "Progresso de %s:"
L["RECENTREMINDERCRITERIA"] = "Objetivo avistado recentemente:"
L["REQUIREDFORMETATIP"] = "Requerido para:"
L["SERIESTIP"] = "Parte de uma série:"
L["SOUND_AGGRO_PULLED"] = "Aggro puxado"
L["SOUND_AGGRO_WARNING"] = "Aviso de aggro "
L["SOUND_ALARM1"] = "Despertador 1"
L["SOUND_ALARM2"] = "Despertador 2"
L["SOUND_ALARM3"] = "Despertador 3"
L["SOUND_BELL_ALLIANCE"] = "Sino - Aliança"
L["SOUND_BELL_AUCTION"] = "Sinos do Leilão"
L["SOUND_BELL_BOATARRIVED"] = "Sinos - Barco Chegou"
L["SOUND_BELL_HORDE"] = "Sino - Horda"
L["SOUND_BELL_KARA"] = "Sino de Karazhan"
L["SOUND_BELL_MELLOW"] = "Sinos suaves"
L["SOUND_BELL_NIGHTELF"] = "Sino - Elfo Noturno"
L["SOUND_BGTIMER"] = "Timer de Campo de Batalha"
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER_END"] = ""--]] 
L["SOUND_BONUSEVENT"] = "Evento bonus"
L["SOUND_CHAR_CREATE"] = "Criar personagem"
--[[Translation missing --]]
--[[ L["SOUND_DIGSITE_COMPLETE"] = ""--]] 
L["SOUND_DING_AUCTION"] = "Tinido de leilão"
L["SOUND_DRUMHIT"] = "Toque de Tambor"
L["SOUND_ENTERQUEUE"] = "Entrar na fila"
L["SOUND_GARRISON_INVASION"] = "Alerta de invasão de Guarnição"
L["SOUND_GLYPH_CREATE_MAJOR"] = "Criar Glifo Maior"
L["SOUND_GLYPH_CREATE_MINOR"] = "Criar Glifo Menor"
L["SOUND_GLYPH_DESTROY_MAJOR"] = "Destruir Glifo Maior"
L["SOUND_GLYPH_DESTROY_MINOR"] = "Destruir Glifo Menor"
L["SOUND_GONG_TROLL"] = "Gongo - Troll"
L["SOUND_HEARTHBIND"] = "Vínculo da Pedra de Regresso"
L["SOUND_LEVELUP"] = "Subir de nivel"
L["SOUND_MAP_PING"] = "Sibilo do mapa"
L["SOUND_MEDAL_EXPIRES"] = "Expirar medalha"
L["SOUND_MEDAL_GOLDTOSILVER"] = "Medalha de Ouro para Prata"
L["SOUND_MEDAL_SILVERTOBRONZE"] = "Medalha de Prata para Bronze"
--[[Translation missing --]]
--[[ L["SOUND_QUEST_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_BADPRESS"] = ""--]] 
L["SOUND_SIMON_DING"] = "Simon: Tinir"
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_LARGE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_SMALL"] = ""--]] 
L["SOUND_SIMON_STARTGAME"] = "Simon: Início do jogo"
L["SOUND_SIMON_STARTLEVEL"] = "Simon: Início do nível"
L["SOUND_STORE_CONFIRM"] = "Confirmação da loja"
L["SOUND_YAR"] = "Yarrrr"
L["STARTTOAST_EVENT"] = "Acontecendo hoje"
L["WILDPET"] = "Mascote Selvagem"
L["YOURPROGRESS"] = "Seu Progresso"



elseif (locale == "itIT") then  -- Italian
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_ACQUIRE_INCOMPLETE_EXTRA"] = ""--]] 
L["ACH_ANGLER_COMPLETE"] = "Già pescato"
L["ACH_ANGLER_COUNT"] = [=[9455=Banco di Ammoniti del Fuoco
9456=Banco di Anguille Abissali delle Profondità,Banco di Anguille Abissali delle Profondità Oleose
9457=Banco di Frustaliane Nere
9458=Banco di Storioni di Lago Ciechi
9459=Banco di Eleotridi Grassi
9460=Banco di Pescecauti Sdentati
9461=Banco di Scorpioni di Mare,Banco di Scorpioni di Mare Oleosi]=]
L["ACH_ANGLER_INCOMPLETE"] = "Da pescare"
L["ACH_BUNNYMAKER_COMPLETE"] = "Fiori di Primavera già utilizzati"
L["ACH_BUNNYMAKER_INCOMPLETE"] = "Necessità di utilizzare Fiori di Primavera"
L["ACH_CHECKYOURHEAD_COMPLETE"] = "Hai già la testa di zucca"
L["ACH_CHECKYOURHEAD_INCOMPLETE"] = "Ha bisogno di una testa di zucca"
L["ACH_CONSUME_91_COMPLETE"] = "Hai già dimostrato"
L["ACH_CONSUME_91_INCOMPLETE"] = "Ti sfido a mangiarne 91 tutti in una volta!"
L["ACH_CONSUME_COMPLETE"] = "Già consumato"
L["ACH_CONSUME_INCOMPLETE"] = "Da consumare"
L["ACH_CONSUME_INCOMPLETE_EXTRA"] = "Non consumato"
--[[Translation missing --]]
--[[ L["ACH_EATYOURGREENS_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_EATYOURGREENS_INCOMPLETE"] = ""--]] 
L["ACH_FISHSCHOOL_FORMAT"] = "Banco di %s"
L["ACH_FISTFULOFLOVE_COMPLETE"] = "Già usato la Manciata di Petali di Rosa"
L["ACH_FISTFULOFLOVE_INCOMPLETE"] = "Hai bisogno di usare la Manciata di Petali di Rosa"
L["ACH_LETITSNOW_COMPLETE"] = "Già usato la Manciata di Petali di Rosa"
L["ACH_LETITSNOW_INCOMPLETE"] = "Hai bisogno di usare la Manciata di Petali di Rosa"
L["ACH_LOVECRITTERS_COMPLETE"] = "Già /amato"
L["ACH_LOVECRITTERS_INCOMPLETE"] = "Richiede un po' di /love"
--[[Translation missing --]]
--[[ L["ACH_MISSIONCOMPLETE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_MISSIONCOMPLETE_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["ACH_RIDE_INCOMPLETE"] = ""--]] 
L["ACH_TURKEYLURKEY_COMPLETE"] = "Hai già le piume"
L["ACH_TURKEYLURKEY_INCOMPLETE"] = "Richiede piume"
L["ACH_WELLREAD_COMPLETE"] = "Già letto"
L["ACH_WELLREAD_INCOMPLETE"] = "Deve essere letto"
L["BINDING_NAME_OVERACHIEVER_TAB_SEARCH"] = "Apri Scheda Ricerca"
L["BINDING_NAME_OVERACHIEVER_TAB_SUGGESTIONS"] = "Apri Scheda Suggerimenti"
L["BINDING_NAME_OVERACHIEVER_TAB_WATCH"] = "Apri la scheda orologio"
L["COMPLETEDATE"] = "Completato il %1$02d/%2$d/%3$02d"
L["CRITTER"] = "Animale"
L["HOLIDAY_BREWFEST"] = "Festa della Birra"
L["HOLIDAY_CHILDRENSWEEK"] = "Settimana dei Bambini"
L["HOLIDAY_DARKMOONFAIRE"] = "Fiera di Lunacupa"
L["HOLIDAY_DAYOFTHEDEAD"] = "Giorno dei Morti"
L["HOLIDAY_HALLOWSEND"] = "Veglia delle Ombre"
L["HOLIDAY_LOVEISINTHEAIR"] = "Amore nell'Aria"
L["HOLIDAY_LUNARFESTIVAL"] = "Celebrazione della Luna"
L["HOLIDAY_MIDSUMMER"] = "Fuochi di Mezza Estate"
L["HOLIDAY_MIDSUMMER_SHORT"] = "Mezza Estate"
L["HOLIDAY_NOBLEGARDEN"] = "Festa di Nobiluova"
L["HOLIDAY_PIGRIMSBOUNTY"] = "Ringraziamento del Pellegrino"
L["HOLIDAY_PIRATESDAY"] = "Giorno dei Pirati"
L["HOLIDAY_WINTERVEIL"] = "Vigilia di Grande Inverno"
L["HOLIDAY_WINTERVEIL_SHORT"] = "Grande Inverno"
L["INCOMPLETE"] = "Incompleto"
L["KILL_COMPLETE"] = "Già ucciso"
L["KILL_INCOMPLETE"] = "Da uccidere"
L["MSG_ACHNOTFOUND"] = "Impresa non trovata."
L["MSG_CRITERIAPROGRESS"] = "|cff7eff00Progresso Impresa:|r %s (%s)"
L["MSG_INVALIDID"] = "Input non valido: non esiste un'impresa con quell'ID."
L["MSG_NAMENOTFOUND"] = "Nessuna impresa con nome contenente \"|cffffffff%s|r\" è stata trovata."
--[[Translation missing --]]
--[[ L["MSG_NOOPEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["MSG_NOOPEN_LIST"] = ""--]] 
L["MSG_NUMFOUNDLIST"] = "%s altre imperse trovate:"
L["MSG_ONEFOUND"] = "1 altra impresa trovata:"
L["MSG_OPENINGTO"] = "Apertura in:"
L["MULTI_NEED"] = "%s (richiesti per %s imprese)"
L["OPT_ACHUNKNOWN"] = "<Sconosciuto>"
--[[Translation missing --]]
--[[ L["OPT_ACQUIREDTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_ACQUIREDTIPS_TIP"] = ""--]] 
L["OPT_ANGLERTIPS"] = "Aggiungi se hai già pescato da un nodo al suo tooltip"
L["OPT_ANGLERTIPS_TIP"] = "Se l'impresa è incompleta, aggiungi una linea ai tooltip dei nodi di pesca che fanno parte del suo criterio per indicare se hai bisogno o meno di pescarli."
--[[Translation missing --]]
--[[ L["OPT_ANGLERTIPS_TIP_ALWAYS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACK_CRITERIATOAST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACK_CRITERIATOAST_TIP"] = ""--]] 
L["OPT_AUTOTRACKEXPLORE"] = "Autotraccia le imprese di esplorazione mentre viaggi"
L["OPT_AUTOTRACKEXPLORE_COMPLETED"] = "Includi imprese completate."
L["OPT_AUTOTRACKEXPLORE_TIP"] = "Quando entri in una zona, verrà tracciato automaticamente l'impresa di esplorazione associata. Non cambierà se stai tracciando qualcos'altro diverso da un'impresa di esplorazione."
L["OPT_AUTOTRACKTIMED"] = "Traccia automaticamente le imprese a tempo"
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACKTIMED_BG"] = ""--]] 
L["OPT_AUTOTRACKTIMED_TIP"] = "Traccia automaticamente imprese con criteri di tempo quando il timer viene avviato. Se stai già monitorando il numero massimo di risultati, tenterà di prendere il posto di un risultato del rilevamento automatico di esplorazione; in caso contrario, non verrà tracciato."
--[[Translation missing --]]
--[[ L["OPT_AUTOTRACKTIMED_TIP_BG"] = ""--]] 
L["OPT_BUNNYMAKERTIPS"] = "Fiori di Primavera usati?"
L["OPT_BUNNYMAKERTIPS_TIP"] = "Se l'impresa non è completa, aggiungere una riga nel tooltip del giocatoredel sesso appropriato per indicare se è necessario utilizzare i Fiori di Primavera su di loro. Nota che i giocatori nemici che sono 10 o più livelli superiori sono considerati livello almeno 18."
L["OPT_CHECKYOURHEADTIPS"] = "Jack Lanterna Appesantito usato?"
L["OPT_CHECKYOURHEADTIPS_TIP"] = "Se l'impresa non è completata, aggiungi una riga nel tooltip del giocatore per indicare se è necessario utilizzare un lanterna poderata Jack-o'-su di loro."
L["OPT_CONSUMEITEMTIPS"] = "Aggiungi se gli oggetti devono essere consumati ai loro tooltip"
L["OPT_CONSUMEITEMTIPS_TIP"] = "Se l'obiettivo è incompleto, aggiungi una linea al tooltip degli oggetti che fanno parte dei criteri indicati se devi consumarli."
L["OPT_CONSUMEITEMTIPS_TIP2"] = "Gli oggetti che non puoi consumare perchè sei di basso livello non faranno riprodurre un suono."
L["OPT_CONSUMEITEMTIPS_WHENCOMPLETE"] = "Mostra anche se l'impresa è completata"
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_CHATLOG"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_CHATLOG_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_SUGGEST"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_CRITERIATOAST_SUGGEST_TIP"] = ""--]] 
L["OPT_CRITTERTIPS"] = "Creatura /amata?"
L["OPT_CRITTERTIPS_TIP"] = "Se questa impresa è incompleta, aggiungi una riga nel tooltip delle creature che fanno parte di quell'impresa per indicare se quel tipo di creatura ancora necessita di /amore."
L["OPT_DRAGGABLE"] = "Rendi trascinabile"
L["OPT_DRAGSAVE"] = "Ricorda la posizione"
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_EATYOURGREENSTIPS_TIP"] = ""--]] 
L["OPT_FISTFULOFLOVETIPS"] = "Manciata di Petali di Rosa usata?"
L["OPT_FISTFULOFLOVETIPS_TIP"] = "Se l'impresa è incompleta, aggiungere una riga nel tooltip del giocatore con la combo razza/classe appropriata per indicare se è necessario utilizzare una manciata di petali di rosa su di loro."
L["OPT_KILLCREATURETIPS"] = "Creatura uccisa?"
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_EXCLUDE_GUILD"] = ""--]] 
L["OPT_KILLCREATURETIPS_TIP"] = "Aggiungere una riga nel tooltip delle creature (escluse i critter) che devono essere uccisi per soddisfare i criteri di un'impresa non completa che indica se hai ancora bisogno di ucciderli."
L["OPT_KILLCREATURETIPS_TIP2"] = "Nota: All'avvio (o quando questa è l'opzione è abilitata), ogni realizzazione viene analizzata per individuare gli ID di unità. Non tutte le realizzazioni forniscono tali ID. La maggior parte fanno, ma le descrizioni comandi di creature che sono i criteri di coloro che non lo fanno non sarà alterato da questa opzione."
--[[Translation missing --]]
--[[ L["OPT_KILLCREATURETIPS_WHENCOMPLETE"] = ""--]] 
L["OPT_LABEL_ACHFIVE"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s\""
L["OPT_LABEL_ACHFOUR"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHSEVEN"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s,\" \"%s,\" \"%s\""
L["OPT_LABEL_ACHSIX"] = "\"%s,\" \"%s,\"|n\"%s,\" \"%s\"|n\"%s,\" \"%s\""
L["OPT_LABEL_ACHTHREE"] = "\"%s,\" \"%s,\" e \"%s\""
L["OPT_LABEL_ACHTWO"] = "\"%s\" e \"%s\""
--[[Translation missing --]]
--[[ L["OPT_LABEL_CRITERIATOAST"] = ""--]] 
L["OPT_LABEL_DRAENORANGLER"] = "Sottoimprese \"%s\""
--[[Translation missing --]]
--[[ L["OPT_LABEL_LOVECRITTER"] = ""--]] 
L["OPT_LABEL_MAINUI"] = "Modifiche Pannello Interfaccia Imprese"
--[[Translation missing --]]
--[[ L["OPT_LABEL_MISC"] = ""--]] 
L["OPT_LABEL_NEEDTOKILL"] = "Uccidi la creatura dell'Impresa (\"%s,\" \"%s,\" ecc.)"
L["OPT_LABEL_SEASONALACHS"] = "IMPRESE STAGIONALI"
--[[Translation missing --]]
--[[ L["OPT_LABEL_STARTTOAST"] = ""--]] 
L["OPT_LABEL_TOOLTIPS"] = "Link e descrizioni di Imprese"
L["OPT_LABEL_TRACKING"] = "Tracciatore di Imprese"
L["OPT_LABEL_TRADESKILLUI"] = "Modifiche Interfaccia Professioni"
L["OPT_LETITSNOWTIPS"] = "Manciata di Fiocchi di Neve usata"
L["OPT_LETITSNOWTIPS_TIP"] = "Se l'impresa è incompleta, aggiungere una riga nel tooltip del giocatore con la combo razza/classe appropriata per indicare se è necessario utilizzare una manciata di fiocchi di neve su di loro."
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_MISSIONCOMPLETE_WHENCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_PESTCONTROLTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_PESTCONTROLTIPS_TIP"] = ""--]] 
L["OPT_SATISFIEDTIPS"] = "Soddisfatto al 1000%?"
L["OPT_SATISFIEDTIPS_TIP"] = "Aggiungere una riga alle descrizioni degli elementi che fanno parte il raggiungimento di criteri per indicare se è necessario consumarli"
L["OPT_SELECTSOUND"] = "Suono di avviso per Impresa Incompleta"
L["OPT_SELECTSOUND_ANGLERCHECKPOLE"] = "Escludi promemoria nodo di pesca se la canna da pesca è equipaggiata"
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_ANGLERCHECKPOLE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_CHECKCOMBAT"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_CHECKCOMBAT_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SELECTSOUND_TIP"] = ""--]] 
L["OPT_SELECTSOUND_TIP2"] = "I suoni verranno riprodotti solo ogni 15 secondi"
L["OPT_SHOWID"] = "Mostra gli ID delle Imprese"
L["OPT_SHOWPROGRESS"] = "Aggiungi il tuo progresso"
L["OPT_SHOWPROGRESS_OTHER"] = "Confronta il tuo progresso con quello dei link degli altri"
L["OPT_SHOWPROGRESS_OTHER_TIP"] = "Aggiungi il tuo progresso quando le informazioni di un'impresa mostrate sono quelle di un altro giocatore."
L["OPT_SHOWPROGRESS_TIP"] = "Aggiungi il tuo progresso quando un'impresa ha dei criteri basati sulle quantità, come \"Ottieni 10 cavalcature.\""
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TAB_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_SLASHSEARCH_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_BONUS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_BONUS_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_DUNGEON"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_DUNGEON_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_HOLIDAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_HOLIDAY_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MICROHOLIDAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MICROHOLIDAY_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_MISC_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_ONLYCLICKFADE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_ONLYCLICKFADE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_PVPBRAWL_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_TIMEFADE"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_STARTTOAST_TIMEFADE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_THROTTLE_ACHLOOKUP_TIP2"] = ""--]] 
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING"] = "Indica le ricette non cucinate per completare le imprese"
L["OPT_TRADESKILL_SHOWCOMPLETEDACH_COOKING_TIP"] = "Se il modulo del commercio Overachiever è abilitata, l'icona appare accanto al risultato ricette che è necessario per cucinare, al fine di ottenere obiettivi determinati. Se questa opzione è selezionata, queste icone apparirà accanto alle ricette crudi, anche se il risultato associato è completa."
L["OPT_TURKEYLURKEYTIPS"] = "Usare il fucile sul tacchino?"
L["OPT_TURKEYLURKEYTIPS_TIP"] = "Se l'impresa non è completata, aggiungere una riga al tooltip del giocatore per indicare se è necessario utilizzare il vostro fucile tacchino su di loro."
L["OPT_UI_HOLIDAYNOTICE"] = "Mostra avviso se è attivo un evento festivo"
L["OPT_UI_HOLIDAYNOTICE_SUGGESTIONSTABONLY"] = "Solo nella scheda Suggerimenti"
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_HOLIDAYNOTICE_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_PROGRESSIFOTHERCOMPLETED"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_PROGRESSIFOTHERCOMPLETED_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_REQUIREDFORMETATIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_UI_REQUIREDFORMETATIP_TIP"] = ""--]] 
L["OPT_UI_SERIESTIP"] = "Mostra tooltip per le imprese che fanno parte di una serie"
L["OPT_UI_SERIESTIP_TIP"] = "Quando il cursore è su un'impresa che fa parte di una serie, mostra i nomi delle altre della serie e la relazione con loro."
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS"] = ""--]] 
--[[Translation missing --]]
--[[ L["OPT_VEHICLERIDDENTIPS_TIP"] = ""--]] 
L["OPT_WELLREADTIPS"] = "Libro letto?"
L["OPT_WELLREADTIPS_TIP"] = "Se l'impresa non è completata, aggiungi una linea nel tooltip nei libri che sono parte del criterio per indicare se devi leggerli o no."
L["OPTPANEL_REMINDERTOOLTIPS"] = "Promemoria Tooltip"
L["OVERACHIEVER_INSTALLED_MSG"] = "|cff7eff00Overachiever|r v%s è stato installato."
L["OVERACHIEVER_INSTALLED_TOAST"] = "OVERACHIEVER INSTALLATO!"
L["OVERACHIEVER_UPDATED_MSG"] = "|cff7eff00Overachiever|r è stato aggiornato alla v%s."
L["OVERACHIEVER_UPDATED_TOAST"] = "OVERACHIEVER AGGIORNATO!"
L["PROGRESS"] = "Progresso"
L["PROGRESSIFOTHERCOMPLETED"] = "Progresso di %s:"
L["RECENTREMINDERCRITERIA"] = "Obiettivi recentemente individuati:"
L["REQUIREDFORMETATIP"] = "Richiesto per:"
L["SERIESTIP"] = "Parte di una serie:"
--[[Translation missing --]]
--[[ L["SOUND_AGGRO_PULLED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_AGGRO_WARNING"] = ""--]] 
L["SOUND_ALARM1"] = "Allarme 1"
L["SOUND_ALARM2"] = "Allarme 2"
L["SOUND_ALARM3"] = "Allarme 3"
L["SOUND_BELL_ALLIANCE"] = "Campana - Alleanza"
L["SOUND_BELL_AUCTION"] = "Campane Casa d'Aste"
L["SOUND_BELL_BOATARRIVED"] = "Campane - Arrivo Nave"
L["SOUND_BELL_HORDE"] = "Campana - Orda"
L["SOUND_BELL_KARA"] = "Campana Karazhan"
--[[Translation missing --]]
--[[ L["SOUND_BELL_MELLOW"] = ""--]] 
L["SOUND_BELL_NIGHTELF"] = "Campan - Elfo della Notte"
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BGTIMER_END"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_BONUSEVENT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_CHAR_CREATE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_DIGSITE_COMPLETE"] = ""--]] 
L["SOUND_DING_AUCTION"] = "Campana - Asta"
L["SOUND_DRUMHIT"] = "Colpo di Tamburo"
--[[Translation missing --]]
--[[ L["SOUND_ENTERQUEUE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_GARRISON_INVASION"] = ""--]] 
L["SOUND_GLYPH_CREATE_MAJOR"] = "Crea Glifo Maggiore"
L["SOUND_GLYPH_CREATE_MINOR"] = "Crea Glifo Minore"
L["SOUND_GLYPH_DESTROY_MAJOR"] = "Distruggi Glifo Maggiore"
L["SOUND_GLYPH_DESTROY_MINOR"] = "Distruggi Glifo Minore"
L["SOUND_GONG_TROLL"] = "Gong - Troll"
--[[Translation missing --]]
--[[ L["SOUND_HEARTHBIND"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_LEVELUP"] = ""--]] 
L["SOUND_MAP_PING"] = "Bling Mappa"
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_EXPIRES"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_GOLDTOSILVER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_MEDAL_SILVERTOBRONZE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_QUEST_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_BADPRESS"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_DING"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_LARGE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SOUND_SIMON_FAIL_SMALL"] = ""--]] 
L["SOUND_SIMON_STARTGAME"] = "Inizio Gioco Simon"
L["SOUND_SIMON_STARTLEVEL"] = "Inizio Livello Simon"
--[[Translation missing --]]
--[[ L["SOUND_STORE_CONFIRM"] = ""--]] 
L["SOUND_YAR"] = "Arrrr"
--[[Translation missing --]]
--[[ L["STARTTOAST_EVENT"] = ""--]] 
L["WILDPET"] = "Mascotte Selvatica"
L["YOURPROGRESS"] = "Il tuo progresso"



end

BINDING_HEADER_OVERACHIEVER = GetAddOnMetadata("Overachiever", "Title")
BINDING_NAME_OVERACHIEVER_TAB_SEARCH = L.BINDING_NAME_OVERACHIEVER_TAB_SEARCH;
BINDING_NAME_OVERACHIEVER_TAB_SUGGESTIONS = L.BINDING_NAME_OVERACHIEVER_TAB_SUGGESTIONS;
BINDING_NAME_OVERACHIEVER_TAB_WATCH = L.BINDING_NAME_OVERACHIEVER_TAB_WATCH;
