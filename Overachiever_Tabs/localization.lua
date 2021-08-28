
local L, locale = OVERACHIEVER_STRINGS, GetLocale()

L.SEARCH_TAB = "Search";
L.SEARCH_HELP = "Use this tab to search for achievements. You can also search for achievements by name or ID using slash commands. See Overachiever's readme.txt file for details.";
L.SEARCH_NAME = "Name or ID:";
L.SEARCH_DESC = "Description:";
L.SEARCH_CRITERIA = "Criteria:";
L.SEARCH_REWARD = "Reward:";
L.SEARCH_ANY = "Any of the above:";
L.SEARCH_FULLLIST = "Include unlisted|nachievements";
L.SEARCH_FULLLIST_TIP = "Include in the search achievements that aren't normally listed in the default UI, such as those exclusive to the opposing faction, unacquired Feats of Strength, etc.";
L.SEARCH_TYPE = "Type:";
L.SEARCH_TYPE_INDIV = "Personal";
L.SEARCH_TYPE_GUILD = "Guild";
L.SEARCH_TYPE_OTHER = "Other";
L.SEARCH_TYPE_ALL = "All";
L.SEARCH_SUBMIT = "Search";
L.SEARCH_RESET = "Reset";
L.SEARCH_RESULTS = "Found %s |4achievement:achievements;.";
L.SEARCH_FILTERED_OUT = "%s |4achievement was:achievements were; omitted by the filter.";
L.SEARCH_SEARCHING = "Searching..."

L.SUGGESTIONS_TAB = "Suggestions";
L.SUGGESTIONS_HELP = "Suggested achievements are listed here based on your current location. Also listed are all \"Recent Reminder\" achievements.|n|n|cffffffffShift-alt-click|r on a suggested achievement to auto-track it when it becomes suggested for your current location.|n|n|cffffffffShift-right-click|r on a suggested achievement to hide it. (This is character-specific and affects all locations.)";
L.SUGGESTIONS_REFRESH = "Refresh";
L.SUGGESTIONS_EMPTY = "Overachiever has no suggestions for you at this time.";
L.SUGGESTIONS_EMPTY_TRADESKILL = "%s: Overachiever has no suggestions for you at this time.";
L.SUGGESTIONS_EMPTY_OVERRIDE = "Overachiever has no suggestions for the specified location.";
L.SUGGESTIONS_RESULTS = "%d |4suggestion:suggestions; found.";
L.SUGGESTIONS_RESULTS_HIDDEN = "%d |4suggestion:suggestions; found.|n(%d |4is:are; hidden.)";
L.SUGGESTIONS_RESULTS_TRADESKILL = "%s: %d |4suggestion:suggestions; found.";
L.SUGGESTIONS_RESULTS_TRADESKILL_HIDDEN = "%s: %d |4suggestion:suggestions; found.|n(%d |4is:are; hidden.)";
L.SUGGESTIONS_LOCATION = "Location:"
L.SUGGESTIONS_LOCATION_TIP = "Override Zone/Instance Location"
L.SUGGESTIONS_LOCATION_TIP2 = "Leave blank to get suggestions for your current location or start typing to get a matching zone or instance name to use instead. Press |cffffffffTab|r to cycle between locations that match the text to the left of the cursor. |cffffffffShift+Tab|r cycles in reverse order. If the cursor is at the leftmost position, it cycles between all valid locations.|n|nYou can also enter the name of certain holidays/world events (such as \"|cffffffffHallow's End|r\").|n|nEnter \"|cffffffffhidden|r\" to show all suggestions that you've flagged as hidden, regardless of their locations.|n|nEnter \"|cffffffffautotracked|r\" to show all suggestions that you've flagged for auto-tracking, regardless of their locations."
L.SUGGESTIONS_LOCATION_SUBZONE = "Subzone:"
L.SUGGESTIONS_LOCATION_NOSUBZONE = "(unspecified)"
L.SUGGESTIONS_DIFFICULTY = "Instance Difficulty:"
L.SUGGESTIONS_DIFFICULTY_AUTO = "Auto-Detect"
L.SUGGESTIONS_DIFFICULTY_NORMAL = "Normal"
L.SUGGESTIONS_DIFFICULTY_HEROIC = "Heroic"
L.SUGGESTIONS_DIFFICULTY_MYTHIC = "Mythic"
L.SUGGESTIONS_RAIDSIZE = "Raid Size:"
L.SUGGESTIONS_RAIDSIZE_AUTO = "Auto-Detect"
L.SUGGESTIONS_RAIDSIZE_10 = "10-man"
L.SUGGESTIONS_RAIDSIZE_25 = "25-man"
L.SUGGESTIONS_SHOWHIDDEN = "Show Hidden"
L.SUGGESTIONS_SHOWHIDDEN_TIP = "Check to show hidden suggestions for this location."
L.SUGGESTIONS_SHOWHIDDEN_TIP2 = "If you want to see all hidden suggestions regardless of location, enter \"|cffffffffhidden|r\" into the Location field, above.|n|n|cffffffffShift-right-click|r on an achievement to toggle whether it is hidden."
L.SUGGESTIONS_FILTERED_OUT_INCOMPLETE = "Showing COMPLETED achievements. %s |4achievement was:achievements were; filtered out.";
L.SUGGESTIONS_FILTERED_OUT_EARNED = "%s |4achievement was:achievements were; already earned.";
L.SUGGESTIONS_AUTOTRACKING_TIP = "Auto-Tracking";
L.SUGGESTIONS_AUTOTRACKING_TIP2 = "This achievement will automatically be tracked/untracked|nbased on your current location.|n|n|cffffffffShift-alt-click|r to toggle.";
L.SUGGESTIONS_HIDDENLOCATION = "hidden"
L.SUGGESTIONS_AUTOTRACKEDLOCATION = "autotracked"

L.SUGGESTIONS_ZONERENAME_DALARAN_NORTHREND = "Dalaran (Northrend)"
L.SUGGESTIONS_ZONERENAME_DALARAN_BROKENISLES = "Dalaran (Broken Isles)"
L.SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_OUTLAND = "Shadowmoon Valley (Outland)"
L.SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_DRAENOR = "Shadowmoon Valley (Draenor)"
L.SUGGESTIONS_ZONERENAME_NAGRAND_OUTLAND = "Nagrand (Outland)"
L.SUGGESTIONS_ZONERENAME_NAGRAND_DRAENOR = "Nagrand (Draenor)"
L.SUGGESTIONS_ZONERENAME_KARAZHAN_LEGION = "Return to Karazhan"
L.SUGGESTIONS_ZONERENAME_COVENANT = "Covenant"
L.SUGGESTIONS_ZONERENAME_COVENANT_KYRIAN = "Covenant (Kyrian)"
L.SUGGESTIONS_ZONERENAME_COVENANT_NECROLORD = "Covenant (Necrolord)"
L.SUGGESTIONS_ZONERENAME_COVENANT_NIGHTFAE = "Covenant (Night Fae)"
L.SUGGESTIONS_ZONERENAME_COVENANT_VENTHYR = "Covenant (Venthyr)"

L.WATCH_TAB = "Watch";
L.WATCH_HELP = "Create your watch list by |cffffffffalt+clicking|r on achievements in the other tabs or achievement chat links. |cffffffffAlt+click|r on one displayed here to stop watching it.";
L.WATCH_EMPTY = "Your watch list is empty. Alt+click on an achievement in another tab or an achievement's chat link to watch it.";
L.WATCH_EMPTY_SHORT = "Empty List";
L.WATCH_DISPLAYEDLIST = "Displayed List:";
L.WATCH_DEFAULTLIST = "Default List:";
L.WATCH_DEFAULTLIST_TIP = "The specified list will be the Displayed List at the beginning of each session.";
L.WATCH_COPY = "Copy to List:";
L.WATCH_COPY_TIP = "When enabled, if you |cffffffffshift+alt+click|r on an achievement on this tab, it will be added to the specified watch list.";
L.WATCH_LIST_GLOBAL = "Global";
L.WATCH_LIST_PERCHAR = "Character-specific";
L.WATCH_NEW = "New";
L.WATCH_DELETE = "Delete";
L.WATCH_CLEAR = "Clear";
L.WATCH_COPY = "Copy To:";
L.WATCH_POPUP_NEWLIST = "Enter the name of your new achievement watch list:";
L.WATCH_POPUP_DELETELIST = "Are you sure you want to permanently delete the current achievement watch list?";
L.WATCH_POPUP_CLEARLIST = "Are you sure you want to clear the contents of the current achievement watch list?";
L.WATCH_ERR_INVALIDID = 'Removed "%s" from Watch List: An achievement with that ID could not be found.';
L.WATCH_FILTERED_OUT = "%s |4achievement was:achievements were; omitted by the filter.";

L.RELATED_TAB = "Related";
L.RELATED_HELP = "This tab shows achievements that are related to one another. One achievement was chosen as the base. The rest are in the same series as the base, are one of the criteria of the base or of another in its series, or have as one of their own criteria either the base or an achievement in its series.";
L.RELATED_RESULTS = "Found %s |4achievement:achievements;.";
L.RELATED_BASE = "Base Achievement:";
L.RELATED_CLOSE = "Close";
L.RELATED_RECURSIVE = "Extended";
L.RELATED_RECURSIVE_TIP = "Do a recursive search so all achievements that are indirectly related to the base achievement are also included.";
L.RELATED_FILTERED_OUT = "%s |4achievement was:achievements were; omitted by the filter.";

L.TAB_SORT = "Sort by:";
L.TAB_SORT_NAME = "Name";
L.TAB_SORT_ID = "ID";
L.TAB_SORT_POINTS = "Point value";
L.TAB_SORT_COMPLETE = "Date completed";
L.TAB_SORT_RELATION = "Relation";
L.TAB_HELP = "|cffffffffCtrl-click|r on an achievement to jump to its place in the standard UI.|n|n|cffffffffCtrl-shift-click|r on an achievement to view related achievements.|n|nA |cffffffffblue background|r means it is part of a series for which you haven't completed an earlier step.|n|nA |cffffffffred background|r means it cannot be found in the standard UI for this character. It may be exclusive to the opposing faction or is an unacquired Feat of Strength.|n|nA |cffffffffgreen background|r means the achievement is on the \"Recent Reminder\" list. It became especially relevant within the last 2 minutes (e.g. because its timer started or an objective was seen in a tooltip).";
L.TAB_HELP_LESS = "Hold |cffffffffShift|r now for more details.";

L.EVENTNOTICE_ONGOING = "This event is ongoing.";
L.EVENTNOTICE_STARTED_TODAY = "This event started earlier today.";
L.EVENTNOTICE_STARTS_HOURS = "This event starts in|cff7eff00 %s |4hour:hours;|r.";
L.EVENTNOTICE_STARTS_MINUTES = "This event starts in|cff7eff00 %s |4minute:minutes;|r.";
L.EVENTNOTICE_ENDED_TODAY = "|cffff2020This event ended|r earlier today."
L.EVENTNOTICE_ENDS_DAYS = "It ends in|cffff2020 %s |4day:days;|r.";
L.EVENTNOTICE_ENDS_HOURS = "It ends in|cffff2020 %s |4hour:hours;|r.";
L.EVENTNOTICE_ENDS_MINUTES = "It ends in|cffff2020 %s |4minute:minutes;|r.";
L.EVENTNOTICE_ENDS_DATETIME = "It ends on %2$d/%1$02d at %3$s (server time).";  -- 1 - day 2 - month 3 - time
L.EVENTNOTICE_ENDS_TIME = "It ends today at %3$s (server time).";
L.EVENTNOTICE_TIP = "Hold |cffffffffShift|r for more details.";
L.EVENTNOTICE_HELP = "|cffffffffClick|r to see related achievements.|n|cffffffffCtrl-click|r to open the calendar.|n|cffffffffShift-right-click|r to temporarily hide this notice."; --|n|cffffffffRight-click|r for more options.";


L.SUBZONES = {
-- Ulduar:
	["Formation Grounds"] = "Formation Grounds",
	["Razorscale's Aerie"] = "Razorscale's Aerie",
	["The Assembly of Iron"] = "The Assembly of Iron",
	["The Celestial Planetarium"] = "The Celestial Planetarium",
	["The Clash of Thunder"] = "The Clash of Thunder",
	["The Colossal Forge"] = "The Colossal Forge",
	["The Conservatory of Life"] = "The Conservatory of Life",
	["The Descent into Madness"] = "The Descent into Madness",
	["The Halls of Winter"] = "The Halls of Winter",
	["The Observation Ring"] = "The Observation Ring",
	["The Prison of Yogg-Saron"] = "The Prison of Yogg-Saron",
	["The Scrapyard"] = "The Scrapyard",
	["The Shattered Walkway"] = "The Shattered Walkway",
	["The Spark of Imagination"] = "The Spark of Imagination",
-- Icecrown:
	["Argent Tournament Grounds"] = "Argent Tournament Grounds",
	["The Ring of Champions"] = "The Ring of Champions",
	["Argent Pavilion"] = "Argent Pavilion",
	["The Argent Valiants' Ring"] = "The Argent Valiants' Ring",
	["The Aspirants' Ring"] = "The Aspirants' Ring",
	["The Alliance Valiants' Ring"] = "The Alliance Valiants' Ring",
	["Silver Covenant Pavilion"] = "Silver Covenant Pavilion",
	["Sunreaver Pavilion"] = "Sunreaver Pavilion",
	["The Horde Valiants' Ring"] = "The Horde Valiants' Ring",
}


--if (locale == "enGB") then  -- English (EU)
-- Unfortunately, GetLocale() returns "enUS" even when "enGB" would be more appropriate, and the SHORTDATE
-- global string is defined incorrectly for enGB clients (it's set as it is for enUS), so we have to do things
-- this way:
if (ACHIEVEMENT_TOOLTIP_COMPLETE == "Achievement earned by %1$s on %3$d/%2$d/20%4$02d") then
	L.EVENTNOTICE_ENDS_DATETIME = "It ends on %1$d/%2$02d at %3$s (server time).";  -- 1 - day 2 - month 3 - time
end

if (locale == "deDE") then  -- German
-- Tabs
L["EVENTNOTICE_ENDED_TODAY"] = "|cffff2020Dieses Ereignis endete|r heute frühzeitig."
L["EVENTNOTICE_ENDS_DATETIME"] = "Es endet am %1$02d.%2$02d um %3$s (Serverzeit)."
L["EVENTNOTICE_ENDS_DAYS"] = "Es endet in|cffff2020 %s |4Tag:Tagen;|r."
L["EVENTNOTICE_ENDS_HOURS"] = "Es endet in|cffff2020 %s |4Stunde:Stunden;|r."
L["EVENTNOTICE_ENDS_MINUTES"] = "Es endet in|cffff2020 %s |4Minute:Minuten;|r."
L["EVENTNOTICE_ENDS_TIME"] = "Es endet heute um %3$s (Serverzeit)."
L["EVENTNOTICE_HELP"] = "|cffffffffKlick|r, um dazugehörige Erfolge anzuzeigen.|n|cffffffffSTRG-Klick|r, um den Kalender zu öffnen.|n|cffffffffUMSCHALT-Rechtsklick|r, um diesen Hinweis temporär zu verstecken."
L["EVENTNOTICE_ONGOING"] = "Dieses Ereignis findet gerade statt."
L["EVENTNOTICE_STARTED_TODAY"] = "Dieses Ereignis begann heute frühzeitig."
L["EVENTNOTICE_STARTS_HOURS"] = "Dieses Ereignis beginnt in|cff7eff00 %s |4Stunde:Stunden;|r."
L["EVENTNOTICE_STARTS_MINUTES"] = "Dieses Ereignis beginnt in|cff7eff00 %s |4Minute:Minuten;|r."
L["EVENTNOTICE_TIP"] = "Halte |cffffffffUMSCHALT|r, um mehr zu erfahren."
L["RELATED_BASE"] = "Basiserfolg:"
L["RELATED_CLOSE"] = "Eng"
L["RELATED_FILTERED_OUT"] = "%s |4Erfolg wurde:Erfolge wurden; durch den Filter ausgelassen."
L["RELATED_HELP"] = "Dieser Tab zeigt Erfolge, die mit einem anderen verwandt sind. Ein Erfolg wurde als Basiserfolg ausgewählt. Der Rest gehört zur selben Serie wie der Basiserfolg, ist eines der Kriterien vom Basiserfolg oder vom anderen aus seiner Serie, oder hat in seinen Kriterien den Basiserfolg oder ein Erfolg in seiner Serie."
L["RELATED_RECURSIVE"] = "Erweitert"
L["RELATED_RECURSIVE_TIP"] = "Führe eine rekursive Suche durch, so dass alle Erfolge, die indirekt mit dem Basiserfolg verwandt sind, auch mit einbezogen werden."
L["RELATED_RESULTS"] = "Es wurden %s |4Erfolg:Erfolge; gefunden."
L["RELATED_TAB"] = "Verwandt"
L["SEARCH_ANY"] = "Überall suchen:"
L["SEARCH_CRITERIA"] = "Kriterien:"
L["SEARCH_DESC"] = "Beschreibung:"
L["SEARCH_FILTERED_OUT"] = "%s |4Erfolg wurde:Erfolge wurden; durch den Filter weggelassen."
L["SEARCH_FULLLIST"] = "Versteckte Erfolge"
L["SEARCH_FULLLIST_TIP"] = "Auch Erfolge durchsuchen, die man nicht erreichen kann. Zum Beispiel sind das Erfolge aus der gegnerischen Fraktion, fehlende Heldentaten und so weiter."
L["SEARCH_HELP"] = "In diesem Tab können Erfolge gesucht werden. Erfolge können auch via Name oder ID mithilfe von Schrägstrichbefehlen gesucht werden. Schau dir die readme.txt an, um mehr zu erfahren."
L["SEARCH_NAME"] = "Name oder ID:"
L["SEARCH_RESET"] = "Zurücksetzen"
L["SEARCH_RESULTS"] = "%s |4Erfolg:Erfolge; gefunden."
L["SEARCH_REWARD"] = "Belohnung:"
L["SEARCH_SEARCHING"] = "Suche..."
L["SEARCH_SUBMIT"] = "Suchen"
L["SEARCH_TAB"] = "Suche"
L["SEARCH_TYPE"] = "Typ:"
L["SEARCH_TYPE_ALL"] = "Alle"
L["SEARCH_TYPE_GUILD"] = "Gilde"
L["SEARCH_TYPE_INDIV"] = "Persönlich"
L["SEARCH_TYPE_OTHER"] = "Anderes"
L["SUGGESTIONS_AUTOTRACKEDLOCATION"] = "automatisch verfolgt"
L["SUGGESTIONS_AUTOTRACKING_TIP"] = "Automatische Verfolgung"
L["SUGGESTIONS_AUTOTRACKING_TIP2"] = "Dieser Erfolg wird automatisch verfolgt/nicht verfolgt|n anhand deines aktuellen Standorts.|n|n|cffffffffUmschalt-Alt-Klick|r zum Umschalten."
L["SUGGESTIONS_DIFFICULTY"] = "Instanzschwierigkeit:"
L["SUGGESTIONS_DIFFICULTY_AUTO"] = "Auto-Erkennung"
L["SUGGESTIONS_DIFFICULTY_HEROIC"] = "Heroisch"
L["SUGGESTIONS_DIFFICULTY_MYTHIC"] = "Mythisch"
L["SUGGESTIONS_DIFFICULTY_NORMAL"] = "Normal"
L["SUGGESTIONS_EMPTY"] = "Overachiever hat zurzeit keine Vorschläge für dich."
L["SUGGESTIONS_EMPTY_OVERRIDE"] = "Overachiever hat keine Vorschläge für den angegebenen Standort."
L["SUGGESTIONS_EMPTY_TRADESKILL"] = "%s: Overachiever hat zur Zeit keine Vorschläge für dich."
L["SUGGESTIONS_FILTERED_OUT_EARNED"] = "%s |4Erfolg wurde:Erfolge wurden; bereits erlangt."
L["SUGGESTIONS_FILTERED_OUT_INCOMPLETE"] = "Zeige ABGESCHLOSSENE Erfolge. %s |4Erfolg wurde:Erfolge wurden; herausgefiltert."
L["SUGGESTIONS_HELP"] = "Hier werden Erfolge aufgelistet, die du in deiner aktuellen Zone abschließen kannst. Außerdem werden alle Erfolge aufgelistet, an die du in den letzen 2 Minuten per Tooltip erinnert wurdest und auch jene, durch die kürzlich ein Timer gestartet wurde."
L["SUGGESTIONS_HIDDENLOCATION"] = "versteckt "
L["SUGGESTIONS_LOCATION"] = "Standort:"
L["SUGGESTIONS_LOCATION_NOSUBZONE"] = "(nicht genauer beschrieben)"
L["SUGGESTIONS_LOCATION_SUBZONE"] = "Teilgebiet:"
L["SUGGESTIONS_LOCATION_TIP"] = "Gebiet-/Instanz-Standort überschreiben"
L["SUGGESTIONS_LOCATION_TIP2"] = [=[Lass dieses Feld leer, um Vorschläge für deinen aktuellen Standort zu erhalten, oder trage hier den gültigen Namen eines Gebiets oder einer Instanz ein, der automatisch erweitert wird. Drücke |cffffffffTAB|r, um zwischen den Standorten zu wechseln, deren Namen mit dem Text links vom Cursor beginnen. Drücke |cffffffffUMSCHALT+TAB|r, um in entgegengesetzter Richtung zu wechseln. Wenn das Feld leer ist, wird zwischen allen gültigen Standorten gewechselt.

Tabs]=]
L["SUGGESTIONS_RAIDSIZE"] = "Schlachtzugsgröße:"
L["SUGGESTIONS_RAIDSIZE_10"] = "10er"
L["SUGGESTIONS_RAIDSIZE_25"] = "25er"
L["SUGGESTIONS_RAIDSIZE_AUTO"] = "Auto-Erkennung"
L["SUGGESTIONS_REFRESH"] = "Aktualisieren"
L["SUGGESTIONS_RESULTS"] = "%d |4Vorschlag:Vorschläge; gefunden."
L["SUGGESTIONS_RESULTS_HIDDEN"] = "%d |4Vorschlag:Vorschläge; gefunden.|n(%d |4ist:sind; versteckt.) "
L["SUGGESTIONS_RESULTS_TRADESKILL"] = "%s: %d |4Vorschlag:Vorschläge; gefunden."
L["SUGGESTIONS_RESULTS_TRADESKILL_HIDDEN"] = "%s: %d |4Vorschlag:Vorschläge; gefunden.|n(%d |4ist:sind; versteckt.) "
L["SUGGESTIONS_SHOWHIDDEN"] = "Verborgenes zeigen"
L["SUGGESTIONS_SHOWHIDDEN_TIP"] = "Anhaken, um verborgene Vorschläge für diesen Standort zu zeigen."
L["SUGGESTIONS_SHOWHIDDEN_TIP2"] = "Falls du alle verborgene Vorschläge unabhängig vom Standort sehen möchtest, gib \"versteckt\" in das obenstehende Standortfeld ein. |n|n|cffffffffUmschalt-Rechtsklick|r auf einen Erfolg, um die Anzeige dieses Erfolgs zu aktivieren/deaktivieren."
L["SUGGESTIONS_TAB"] = "Vorschläge"
L["SUGGESTIONS_ZONERENAME_COVENANT"] = "Pakt"
L["SUGGESTIONS_ZONERENAME_COVENANT_KYRIAN"] = "Pakt (Kyrianer)"
L["SUGGESTIONS_ZONERENAME_COVENANT_NECROLORD"] = "Pakt (Necrolords)"
L["SUGGESTIONS_ZONERENAME_COVENANT_NIGHTFAE"] = "Pakt (Nachtfae)"
L["SUGGESTIONS_ZONERENAME_COVENANT_VENTHYR"] = "Pakt (Venthyr)"
L["SUGGESTIONS_ZONERENAME_DALARAN_BROKENISLES"] = "Dalaran (Verheerte Inseln)"
L["SUGGESTIONS_ZONERENAME_DALARAN_NORTHREND"] = "Dalaran (Nordend)"
L["SUGGESTIONS_ZONERENAME_KARAZHAN_LEGION"] = "Rückkehr nach Karazhan"
L["SUGGESTIONS_ZONERENAME_NAGRAND_DRAENOR"] = "Nagrand (Draenor)"
L["SUGGESTIONS_ZONERENAME_NAGRAND_OUTLAND"] = "Nagrand (Scherbenwelt)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_DRAENOR"] = "Schattenmondtal (Draenor)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_OUTLAND"] = "Schattenmondtal (Scherbenwelt)"
L["TAB_HELP"] = "|cffffffffSTRG-Klick|r auf einen Erfolg, um ihn in der Standard-UI anzuzeigen.|n|nEin |cffffffffblauer Hintergrund|r bedeutet, dass der Erfolg zu einer noch nicht freigeschalteten Serie von Erfolgen gehört.|n|nEin |cffffffffroter Hintergrund|r bedeutet, dass der Erfolg nicht im Standard-UI gefunden werden konnte, weil er nur von der gegnerischen Fraktion erlangt werden kann oder eine unerreichte Heldentat ist.|n|nEin |cffffffffgrüner Hintergrund|r zeigt an, dass du kürzlich im Tooltip an diesen Erfolg erinnert wurdest, oder dass dieser Erfolg einen kürzlich gestarteten Timer hat."
L["TAB_HELP_LESS"] = "Halte jetzt |cffffffffShift|r gedrückt, um weitere Informationen zu erhalten."
L["TAB_SORT"] = "Sortieren nach:"
L["TAB_SORT_COMPLETE"] = "Abgeschlossen am"
L["TAB_SORT_ID"] = "ID"
L["TAB_SORT_NAME"] = "Name"
L["TAB_SORT_POINTS"] = "Erfolgspunkte"
L["TAB_SORT_RELATION"] = "Beziehung"
L["WATCH_CLEAR"] = "Leeren"
L["WATCH_COPY"] = "Kopiere nach:"
L["WATCH_COPY_TIP"] = "Wenn aktiviert, wird mit |cffffffffUMSCHALT+ALT+Klick|r ein Erfolg in diesem Tab auf die Beobachtungsliste gesetzt."
L["WATCH_DEFAULTLIST"] = "Standardliste:"
L["WATCH_DEFAULTLIST_TIP"] = "Die angegebene Liste wird zu Beginn jeder Sitzung die Angezeigte Liste sein."
L["WATCH_DELETE"] = "Löschen"
L["WATCH_DISPLAYEDLIST"] = "Angezeigte Liste:"
L["WATCH_EMPTY"] = "Deine Beobachtungsliste ist leer. ALT+Klick auf einen Erfolg in einem anderen Tab oder auf einen Chat-Link, um seine Beobachtung zu starten."
L["WATCH_EMPTY_SHORT"] = "Liste leeren"
L["WATCH_ERR_INVALIDID"] = "\"%s\" aus der Beobachtungsliste entfernt: Ein Erfolg mit dieser ID konnte nicht gefunden werden."
L["WATCH_FILTERED_OUT"] = "%s |4Erfolg wurde:Erfolge wurden; durch den Filter weggelassen."
L["WATCH_HELP"] = "Fülle deine Beobachtungsliste, indem du via |cffffffffALT+Klick|r auf Erfolge in anderen Tabs oder auf Chat-Links klickst. |cffffffffALT+Klick|r auf einen hier angezeigten Erfolg, um seine Beobachtung zu beenden."
L["WATCH_LIST_GLOBAL"] = "Global"
L["WATCH_LIST_PERCHAR"] = "Charakterspezifisch"
L["WATCH_NEW"] = "Neu"
L["WATCH_POPUP_CLEARLIST"] = "Willst du wirklich den Inhalt der aktuellen Erfolgsbeobachtungsliste leeren?"
L["WATCH_POPUP_DELETELIST"] = "Willst du wirklich und endgültig die aktuelle Erfolgsbeobachtungsliste löschen?"
L["WATCH_POPUP_NEWLIST"] = "Trage den Namen deiner neuen Erfolgsbeobachtungsliste ein:"
L["WATCH_TAB"] = "Beobachten"

-- Tabs/SUBZONES
	L.SUBZONES["Argent Pavilion"] = "Argentumpavillon"
	L.SUBZONES["Argent Tournament Grounds"] = "Argentumturnierplatz"
	L.SUBZONES["Formation Grounds"] = "Gestaltungsgelände"
	L.SUBZONES["Razorscale's Aerie"] = "Klingenschuppes Horst"
	L.SUBZONES["Silver Covenant Pavilion"] = "Silberbundpavillon"
	L.SUBZONES["Sunreaver Pavilion"] = "Sonnenhäscherpavillon"
	L.SUBZONES["The Alliance Valiants' Ring"] = "Der Ring der Recken der Allianz"
	L.SUBZONES["The Argent Valiants' Ring"] = "Der Ring der Recken des Argentumkreuzzugs"
	L.SUBZONES["The Aspirants' Ring"] = "Der Ring der Streiter"
	L.SUBZONES["The Assembly of Iron"] = "Die Versammlung des Eisens"
	L.SUBZONES["The Celestial Planetarium"] = "Das himmlische Planetarium"
	L.SUBZONES["The Clash of Thunder"] = "Der Donnerschlag"
	L.SUBZONES["The Colossal Forge"] = "Die kolossale Schmiede"
	L.SUBZONES["The Conservatory of Life"] = "Das Konservatorium des Lebens"
	L.SUBZONES["The Descent into Madness"] = "Der Abstieg in den Wahnsinn"
	L.SUBZONES["The Halls of Winter"] = "Die Hallen des Winters"
	L.SUBZONES["The Horde Valiants' Ring"] = "Der Ring der Recken der Horde"
	L.SUBZONES["The Observation Ring"] = "Der Beobachtungsring"
	L.SUBZONES["The Prison of Yogg-Saron"] = "Das Gefängnis von Yogg-Saron"
	L.SUBZONES["The Ring of Champions"] = "Der Ring der Champions"
	L.SUBZONES["The Scrapyard"] = "Der Schrottplatz"
	L.SUBZONES["The Shattered Walkway"] = "Der zerschmetterte Gang"
	L.SUBZONES["The Spark of Imagination"] = "Der Funke der Imagination"



elseif (locale == "frFR") then  -- French
-- Tabs
L["EVENTNOTICE_ENDED_TODAY"] = "|cffff2020Cet évènement s'est fini|r plus tôt aujourd'hui."
L["EVENTNOTICE_ENDS_DATETIME"] = "Se termine le %2$d/%1$02d à %3$s (heure du serveur)."
L["EVENTNOTICE_ENDS_DAYS"] = "Il se termine dans |cffff2020 %s |4day:days;|r."
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_HOURS"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_MINUTES"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_TIME"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_HELP"] = ""--]] 
L["EVENTNOTICE_ONGOING"] = "Cet évènement est en cours."
L["EVENTNOTICE_STARTED_TODAY"] = "Cet événement a débuté plus tôt dans la journée."
L["EVENTNOTICE_STARTS_HOURS"] = "Cet évènement commence dans |cff7eff00 %s |4heure:heures;|r."
L["EVENTNOTICE_STARTS_MINUTES"] = "Cet événement démarre dans |cff7eff00 %s |4minute:minutes;|r."
--[[Translation missing --]]
--[[ L["EVENTNOTICE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_BASE"] = ""--]] 
L["RELATED_CLOSE"] = "Fermer"
--[[Translation missing --]]
--[[ L["RELATED_FILTERED_OUT"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_HELP"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_RECURSIVE"] = ""--]] 
L["RELATED_RECURSIVE_TIP"] = "Effectuez une recherche récursive afin d'inclure toutes les réalisations indirectement liées à la réalisation de base."
--[[Translation missing --]]
--[[ L["RELATED_RESULTS"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_TAB"] = ""--]] 
L["SEARCH_ANY"] = "Tout ce qui précède :"
L["SEARCH_CRITERIA"] = "Critère :"
L["SEARCH_DESC"] = "Description :"
--[[Translation missing --]]
--[[ L["SEARCH_FILTERED_OUT"] = ""--]] 
L["SEARCH_FULLLIST"] = "Inclure tous les hauts faits"
L["SEARCH_FULLLIST_TIP"] = "Inclut dans la recherche les hauts faits qui ne sont pas normalement affichés dans l'IU par défaut, comme ceux de la faction adverse, les Tours de force non accomplis, etc."
L["SEARCH_HELP"] = "Utilisez cet onglet pour chercher des hauts faits. Vous pouvez également rechercher des hauts faits par nom ou par ID en utilisant les commandes \"slash\". Référez-vous au fichier readme.txt d'Overachiever pour les détails."
L["SEARCH_NAME"] = "Nom :"
L["SEARCH_RESET"] = "Réinitialiser"
L["SEARCH_RESULTS"] = "%s |4haut fait trouvé:hauts faits trouvés;."
L["SEARCH_REWARD"] = "Récompense :"
L["SEARCH_SEARCHING"] = "Recherche..."
L["SEARCH_SUBMIT"] = "Chercher"
L["SEARCH_TAB"] = "Recherches"
L["SEARCH_TYPE"] = "Type :"
L["SEARCH_TYPE_ALL"] = "Tout"
L["SEARCH_TYPE_GUILD"] = "Guilde"
L["SEARCH_TYPE_INDIV"] = "Personnel"
L["SEARCH_TYPE_OTHER"] = "Autre"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKEDLOCATION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP2"] = ""--]] 
L["SUGGESTIONS_DIFFICULTY"] = "Difficulté d'instance :"
L["SUGGESTIONS_DIFFICULTY_AUTO"] = "Auto-détection"
L["SUGGESTIONS_DIFFICULTY_HEROIC"] = "Héroïque"
L["SUGGESTIONS_DIFFICULTY_MYTHIC"] = "Mythique"
L["SUGGESTIONS_DIFFICULTY_NORMAL"] = "Normale"
L["SUGGESTIONS_EMPTY"] = "Overachiever n'a aucune suggestion pour le moment"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_EMPTY_OVERRIDE"] = ""--]] 
L["SUGGESTIONS_EMPTY_TRADESKILL"] = " %s: Overachiever n'a aucune suggestion à faire pour le moment."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_EARNED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_INCOMPLETE"] = ""--]] 
L["SUGGESTIONS_HELP"] = "Les hauts faits suggérés sont affichés ici en fonction de votre localisation. Sont également listés tous les hauts faits qui vous ont été rappelés par une infobulle dans les 2 dernières minutes ou qui ont une alarme qui s'est déclenchée récemment."
L["SUGGESTIONS_HIDDENLOCATION"] = "caché"
L["SUGGESTIONS_LOCATION"] = "Emplacement :"
L["SUGGESTIONS_LOCATION_NOSUBZONE"] = "(indéterminé)"
L["SUGGESTIONS_LOCATION_SUBZONE"] = "Sous-zone :"
L["SUGGESTIONS_LOCATION_TIP"] = "Ne pas tenir compte de l'emplacement de la zone/instance"
L["SUGGESTIONS_LOCATION_TIP2"] = "Laissez vierge pour obtenir les suggestions relatives à votre position actuelle ou entrez les premiers caractères pour obtenir un nom de zone ou d'instance valide. Appuez sur |cffffffffTab|r pour faire défiler les noms de lieux correspondants au texte entré à gauche du curseur. |cffffffffShift+Tab|r fait défiler les noms dans l'ordre inverse. Si le curseur est à l'extrême gauche, tous les lieux possibles défilent."
L["SUGGESTIONS_RAIDSIZE"] = "Taille du raid :"
L["SUGGESTIONS_RAIDSIZE_10"] = "10 joueurs"
L["SUGGESTIONS_RAIDSIZE_25"] = "25 joueurs"
L["SUGGESTIONS_RAIDSIZE_AUTO"] = "Auto-détection"
L["SUGGESTIONS_REFRESH"] = "Rafraîchir"
L["SUGGESTIONS_RESULTS"] = "%d |4suggestion trouvée:suggestions trouvées;."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_RESULTS_HIDDEN"] = ""--]] 
L["SUGGESTIONS_RESULTS_TRADESKILL"] = " %s: %d |4suggestion trouvée:suggestions trouvées;."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_RESULTS_TRADESKILL_HIDDEN"] = ""--]] 
L["SUGGESTIONS_SHOWHIDDEN"] = "Montrer caché"
L["SUGGESTIONS_SHOWHIDDEN_TIP"] = "Cochez pour afficher les suggestions cachées pour cet emplacement."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_SHOWHIDDEN_TIP2"] = ""--]] 
L["SUGGESTIONS_TAB"] = "Suggestions"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_KYRIAN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NECROLORD"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NIGHTFAE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_VENTHYR"] = ""--]] 
L["SUGGESTIONS_ZONERENAME_DALARAN_BROKENISLES"] = "Dalaran (Îles Brisées)"
L["SUGGESTIONS_ZONERENAME_DALARAN_NORTHREND"] = "Dalaran (Norfendre)"
L["SUGGESTIONS_ZONERENAME_KARAZHAN_LEGION"] = "Retour à Karazhan"
L["SUGGESTIONS_ZONERENAME_NAGRAND_DRAENOR"] = "Nagrand (Draenor)"
L["SUGGESTIONS_ZONERENAME_NAGRAND_OUTLAND"] = "Nagrand (Outreterre)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_DRAENOR"] = "Vallée d’Ombrelune (Draenor)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_OUTLAND"] = "Vallée d’Ombrelune (Outreterre)"
L["TAB_HELP"] = "|cffffffffCtrl-click|r sur un haut fait pour l'afficher dans l'IU standard.|n|nUn |cfffffffffond bleu|r signifie qu'il fait partie d'une série dont vous n'avez pas encore effectué une étape précédente.|n|nUn |cfffffffffond rouge|r signifie qu'il ne peut pas être trouvé dans l'IU standard de ce personnage car il est propre à la faction adverse ou bien il s'agit d'un Tour de force non accompli.|n|nA |cfffffffffond vert|r signifie qu'un rappel pour ce haut fait a été affiché récemment dans une infobulle ou qu'il possède une alarme qui s'est déclenchée il y a peu."
--[[Translation missing --]]
--[[ L["TAB_HELP_LESS"] = ""--]] 
L["TAB_SORT"] = "Trier par :"
L["TAB_SORT_COMPLETE"] = "Date d'accomplissement"
L["TAB_SORT_ID"] = "ID"
L["TAB_SORT_NAME"] = "Nom"
L["TAB_SORT_POINTS"] = "Valeur en point"
L["TAB_SORT_RELATION"] = "Relation"
L["WATCH_CLEAR"] = "Vider"
L["WATCH_COPY"] = "Copier vers :"
L["WATCH_COPY_TIP"] = "Quand activé, si vous |cffffffffmajuscule+alt+clicquez|r sur un haut-fait sur cet onglet, il sera ajouté à la liste de suivi spécifiée."
L["WATCH_DEFAULTLIST"] = "Liste par défaut :"
L["WATCH_DEFAULTLIST_TIP"] = "La liste spécifiée sera la Liste Affichée au début de chaque session."
L["WATCH_DELETE"] = "Supprimer"
L["WATCH_DISPLAYEDLIST"] = "Liste Affichée :"
L["WATCH_EMPTY"] = "Votre liste de suivi est vide. Vous pouvez faire Alt+click sur un haut fait dans un autre onglet ou sur un lien de haut fait dans la fenêtre de discussion pour l'afficher."
L["WATCH_EMPTY_SHORT"] = "Vider la Liste"
L["WATCH_ERR_INVALIDID"] = "\"%s\" supprimé de la liste: Le haut-fait avec cet ID est introuvable."
--[[Translation missing --]]
--[[ L["WATCH_FILTERED_OUT"] = ""--]] 
L["WATCH_HELP"] = "Vous pouvez créer votre liste de suivi avec un |cffffffffalt+click|r sur un haut fait dans un autre onglet ou sur un lien de haut fait dans la fenêtre de discussion. Avec un |cffffffffAlt+click|r sur un haut fait affiché ici, vous arrêtez le suivi."
L["WATCH_LIST_GLOBAL"] = "Global"
L["WATCH_LIST_PERCHAR"] = "Spécifique-Personnage"
L["WATCH_NEW"] = "Nouveau"
L["WATCH_POPUP_CLEARLIST"] = "Êtes-vous certain de vouloir effacer le contenu de la liste de suivi courante ?"
L["WATCH_POPUP_DELETELIST"] = "Êtes-vous certain de vouloir supprimer définitivement la liste de suivi courante ?"
L["WATCH_POPUP_NEWLIST"] = "Entrez le nom de votre nouvelle liste de suivi :"
L["WATCH_TAB"] = "Suivi"

-- Tabs/SUBZONES
	L.SUBZONES["Argent Pavilion"] = "Pavillon d'Argent"
	L.SUBZONES["Argent Tournament Grounds"] = "Enceinte du tournoi d'Argent"
	L.SUBZONES["Formation Grounds"] = "Champs d'entraînement"
	L.SUBZONES["Razorscale's Aerie"] = "Aire de Tranchécaille"
	L.SUBZONES["Silver Covenant Pavilion"] = "Pavillon du Concordat argenté"
	L.SUBZONES["Sunreaver Pavilion"] = "Pavillon de Saccage-soleil"
	L.SUBZONES["The Alliance Valiants' Ring"] = "Lice des vaillants de l'Alliance"
	L.SUBZONES["The Argent Valiants' Ring"] = "Lice des vaillants d'Argent"
	L.SUBZONES["The Aspirants' Ring"] = "Lice des aspirants"
	L.SUBZONES["The Assembly of Iron"] = "L'assemblée du Fer"
	L.SUBZONES["The Celestial Planetarium"] = "Le planétarium céleste"
	L.SUBZONES["The Clash of Thunder"] = "Le fracas du tonnerre"
	L.SUBZONES["The Colossal Forge"] = "La forge colossale"
	L.SUBZONES["The Conservatory of Life"] = "Le jardin de  la vie"
	L.SUBZONES["The Descent into Madness"] = "La descente dans la folie"
	L.SUBZONES["The Halls of Winter"] = "Les salles de l'hiver"
	L.SUBZONES["The Horde Valiants' Ring"] = "Lice des vaillants de la Horde"
	L.SUBZONES["The Observation Ring"] = "Le cercle d'observation"
	L.SUBZONES["The Prison of Yogg-Saron"] = "Prison de Yogg-Saron"
	L.SUBZONES["The Ring of Champions"] = "Lice des champions"
	L.SUBZONES["The Scrapyard"] = "La ferraillerie"
	L.SUBZONES["The Shattered Walkway"] = "Le passage brisé"
	L.SUBZONES["The Spark of Imagination"] = "L'étincelle d'imagination"



elseif (locale == "zhTW") then  -- Traditional Chinese
-- Tabs
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDED_TODAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_DATETIME"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_DAYS"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_HOURS"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_MINUTES"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_TIME"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_HELP"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ONGOING"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_STARTED_TODAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_STARTS_HOURS"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_STARTS_MINUTES"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_BASE"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_CLOSE"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_FILTERED_OUT"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_HELP"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_RECURSIVE"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_RECURSIVE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_RESULTS"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_TAB"] = ""--]] 
L["SEARCH_ANY"] = "以上皆可："
L["SEARCH_CRITERIA"] = "條件："
L["SEARCH_DESC"] = "描述："
--[[Translation missing --]]
--[[ L["SEARCH_FILTERED_OUT"] = ""--]] 
L["SEARCH_FULLLIST"] = "搜索所有成就"
L["SEARCH_FULLLIST_TIP"] = "包括所有成就、已完成的、未完成的、無法完成的，等等。"
L["SEARCH_HELP"] = "使用此標籤來搜索成就。您也可以使用命令搜索成就的名稱或編號。見 Overachiever 的 Readme.txt 文件的相關內容。"
L["SEARCH_NAME"] = "名稱："
L["SEARCH_RESET"] = "重置"
L["SEARCH_RESULTS"] = "搜索到 %s 個成就。"
L["SEARCH_REWARD"] = "獎勵："
--[[Translation missing --]]
--[[ L["SEARCH_SEARCHING"] = ""--]] 
L["SEARCH_SUBMIT"] = "搜索"
L["SEARCH_TAB"] = "搜索"
L["SEARCH_TYPE"] = "類型:"
L["SEARCH_TYPE_ALL"] = "全部"
L["SEARCH_TYPE_GUILD"] = "公會"
L["SEARCH_TYPE_INDIV"] = "個人"
--[[Translation missing --]]
--[[ L["SEARCH_TYPE_OTHER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKEDLOCATION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP2"] = ""--]] 
L["SUGGESTIONS_DIFFICULTY"] = "副本難度:"
L["SUGGESTIONS_DIFFICULTY_AUTO"] = "自動偵測"
L["SUGGESTIONS_DIFFICULTY_HEROIC"] = "英雄"
L["SUGGESTIONS_DIFFICULTY_MYTHIC"] = "傳奇"
L["SUGGESTIONS_DIFFICULTY_NORMAL"] = "普通"
L["SUGGESTIONS_EMPTY"] = "Overachiever現在沒有任何建議。"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_EMPTY_OVERRIDE"] = ""--]] 
L["SUGGESTIONS_EMPTY_TRADESKILL"] = "%s: Overachiever 此時無法提供建議."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_EARNED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_INCOMPLETE"] = ""--]] 
L["SUGGESTIONS_HELP"] = "根據你目前的位置建議追蹤成就。"
L["SUGGESTIONS_HIDDENLOCATION"] = "隱藏"
L["SUGGESTIONS_LOCATION"] = "區域："
L["SUGGESTIONS_LOCATION_NOSUBZONE"] = "(未指定)"
L["SUGGESTIONS_LOCATION_SUBZONE"] = "子區域："
L["SUGGESTIONS_LOCATION_TIP"] = "無視區域/副本位置"
L["SUGGESTIONS_LOCATION_TIP2"] = "在欄位中輸入一個完整的有效區域或副本名稱，以取得提示。若欄位保持空白，則會根據你目前的所在位置。當游標在欄位中時，按下|cffffffffTab|r鍵可根據已輸入的內容依序產生有效的完整位置名稱。按下|cffffffffShift+Tab|r則產生前一個名稱。如果游標在欄位的最左側，它將依序產生所有有效位置名稱。"
L["SUGGESTIONS_RAIDSIZE"] = "團隊大小:"
L["SUGGESTIONS_RAIDSIZE_10"] = "10-人"
L["SUGGESTIONS_RAIDSIZE_25"] = "25-人"
L["SUGGESTIONS_RAIDSIZE_AUTO"] = "自動偵測"
L["SUGGESTIONS_REFRESH"] = "刷新"
L["SUGGESTIONS_RESULTS"] = "找到 %d 個建議。"
L["SUGGESTIONS_RESULTS_HIDDEN"] = "找到 %d 個建議。|n(%d 個已隱藏。)"
L["SUGGESTIONS_RESULTS_TRADESKILL"] = "%s: 找到 %d 個建議."
L["SUGGESTIONS_RESULTS_TRADESKILL_HIDDEN"] = "%s: 找到 %d 個建議。|n(%d 個已隱藏。)"
L["SUGGESTIONS_SHOWHIDDEN"] = "顯示隱藏建議"
L["SUGGESTIONS_SHOWHIDDEN_TIP"] = "顯示這個位置的隱藏建議。"
L["SUGGESTIONS_SHOWHIDDEN_TIP2"] = "如果你想要看到所有隱藏建議，不分地區，在上方的地區欄位中輸入 \\\"隱藏\\\"。|n|n|cffffffffShift-右鍵|r點擊成就切換顯示/隱藏。"
L["SUGGESTIONS_TAB"] = "建議"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_KYRIAN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NECROLORD"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NIGHTFAE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_VENTHYR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_DALARAN_BROKENISLES"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_DALARAN_NORTHREND"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_KARAZHAN_LEGION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_NAGRAND_DRAENOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_NAGRAND_OUTLAND"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_DRAENOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_OUTLAND"] = ""--]] 
L["TAB_HELP"] = "|cffffffffCtrl + 點選|r 所選成就會跳轉到該成就的頁面.|n|n |cffffffff藍色背景|r表示此成就是你還沒有完成前續內容的系列成就部分.|n|n |cffffffff紅色背景|r表示此成就無法在你當前人物的標準成就界面中找到,因為這是陣營專屬成就,或者是你尚未取得的『光輝事跡』成就."
--[[Translation missing --]]
--[[ L["TAB_HELP_LESS"] = ""--]] 
L["TAB_SORT"] = "類型:"
L["TAB_SORT_COMPLETE"] = "完成時間"
L["TAB_SORT_ID"] = "成就ID"
L["TAB_SORT_NAME"] = "名稱"
L["TAB_SORT_POINTS"] = "成就點數"
--[[Translation missing --]]
--[[ L["TAB_SORT_RELATION"] = ""--]] 
L["WATCH_CLEAR"] = "清除"
L["WATCH_COPY"] = "複製到:"
L["WATCH_COPY_TIP"] = "當啟用時，假如你 |cffffffffshift+alt+點擊|r 在一個標籤上的成就，將會新增至指定的觀察列表中。"
L["WATCH_DEFAULTLIST"] = "預設列表:"
L["WATCH_DEFAULTLIST_TIP"] = "指定列表會顯示列表在任何場景的開始時候。"
L["WATCH_DELETE"] = "刪除"
L["WATCH_DISPLAYEDLIST"] = "顯示列表:"
L["WATCH_EMPTY"] = "你的觀察列表是空的。Alt+點擊在其它成就標籤上或是成就連結來觀察。"
L["WATCH_EMPTY_SHORT"] = "空的列表"
L["WATCH_ERR_INVALIDID"] = "已從觀察列表移除\"%s\": 此成就ID並未被發現。"
--[[Translation missing --]]
--[[ L["WATCH_FILTERED_OUT"] = ""--]] 
L["WATCH_HELP"] = "在其它成就標籤上或是成就連結使用 |cffffffffalt+點擊|r新建你的觀察列表。 |cffffffffAlt+點擊|r 停止觀察。"
L["WATCH_LIST_GLOBAL"] = "全部"
L["WATCH_LIST_PERCHAR"] = "字符特殊"
L["WATCH_NEW"] = "新的"
L["WATCH_POPUP_CLEARLIST"] = "要將這個成就觀察列表的內容清除?"
L["WATCH_POPUP_DELETELIST"] = "要將這個成就觀察列表刪除?"
L["WATCH_POPUP_NEWLIST"] = "輸入新建成就列表的名稱:"
L["WATCH_TAB"] = "觀察"

-- Tabs/SUBZONES
	L.SUBZONES["Argent Pavilion"] = "銀白亭閣"
	L.SUBZONES["Argent Tournament Grounds"] = "銀白聯賽場地"
	L.SUBZONES["Formation Grounds"] = "構築之地"
	L.SUBZONES["Razorscale's Aerie"] = "銳鱗之巢"
	L.SUBZONES["Silver Covenant Pavilion"] = "白銀誓盟亭閣"
	L.SUBZONES["Sunreaver Pavilion"] = "奪日者亭閣"
	L.SUBZONES["The Alliance Valiants' Ring"] = "聯盟驍士競技場"
	L.SUBZONES["The Argent Valiants' Ring"] = "銀白驍士競技場"
	L.SUBZONES["The Aspirants' Ring"] = "志士競技場"
	L.SUBZONES["The Assembly of Iron"] = "鐵之集會所"
	L.SUBZONES["The Celestial Planetarium"] = "星穹渾天儀"
	L.SUBZONES["The Clash of Thunder"] = "雷鳴之廳"
	L.SUBZONES["The Colossal Forge"] = "巨熔爐"
	L.SUBZONES["The Conservatory of Life"] = "生命溫室"
	L.SUBZONES["The Descent into Madness"] = "驟狂斜廊"
	L.SUBZONES["The Halls of Winter"] = "凜冬之廳"
	L.SUBZONES["The Horde Valiants' Ring"] = "部落驍士競技場"
	L.SUBZONES["The Observation Ring"] = "觀察之環"
	L.SUBZONES["The Prison of Yogg-Saron"] = "尤格薩倫之獄"
	L.SUBZONES["The Ring of Champions"] = "勇士競技場"
	L.SUBZONES["The Scrapyard"] = "廢料場"
	L.SUBZONES["The Shattered Walkway"] = "破碎走道"
	L.SUBZONES["The Spark of Imagination"] = "創思之廳"



elseif (locale == "zhCN") then  -- Simplified Chinese
-- Tabs
L["EVENTNOTICE_ENDED_TODAY"] = "在更早些时刻|cffff2020这个事件已开始|r。"
L["EVENTNOTICE_ENDS_DATETIME"] = "将在 %2$d/%1$02d 的 %3$s 结束(服务器时间)."
L["EVENTNOTICE_ENDS_DAYS"] = "距结束还有|cffff2020 %s |4day:天;|r。"
L["EVENTNOTICE_ENDS_HOURS"] = "距结束还有|cffff2020 %s |4hour:小时;|r。"
L["EVENTNOTICE_ENDS_MINUTES"] = "距结束还有|cffff2020 %s |4minute:分钟;|r。"
L["EVENTNOTICE_ENDS_TIME"] = "将在今天的 %3$s 结束(服务器时间)."
L["EVENTNOTICE_HELP"] = "|cffffffff点击|r查看相关成就。|n|cffffffffCtrl-点击|r打开日历。|n|cffffffffShift-右-点击|r暂时隐藏本提示。"
L["EVENTNOTICE_ONGOING"] = "这个事件正在进行中。"
L["EVENTNOTICE_STARTED_TODAY"] = "这个事件开始于更早的时刻。"
L["EVENTNOTICE_STARTS_HOURS"] = "距事件开始还有|cff7eff00 %s |4hour:小时;|r。"
L["EVENTNOTICE_STARTS_MINUTES"] = "距事件开始还有|cff7eff00 %s |4minute:分钟;|r。"
L["EVENTNOTICE_TIP"] = "按住|cffffffffShift|r显示更多细节。"
L["RELATED_BASE"] = "成就成果:"
L["RELATED_CLOSE"] = "关闭"
--[[Translation missing --]]
--[[ L["RELATED_FILTERED_OUT"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_HELP"] = ""--]] 
L["RELATED_RECURSIVE"] = "额外"
--[[Translation missing --]]
--[[ L["RELATED_RECURSIVE_TIP"] = ""--]] 
L["RELATED_RESULTS"] = "找到 %s |4achievement:成就;。"
L["RELATED_TAB"] = "相关的"
L["SEARCH_ANY"] = "以上所有："
L["SEARCH_CRITERIA"] = "条件："
L["SEARCH_DESC"] = "描述："
--[[Translation missing --]]
--[[ L["SEARCH_FILTERED_OUT"] = ""--]] 
L["SEARCH_FULLLIST"] = "包含隐藏成就"
L["SEARCH_FULLLIST_TIP"] = "包括没有在默认列表中显示的成就，例如阵营专属成就、‘光辉事迹’成就等。"
L["SEARCH_HELP"] = "使用这个标签来搜索成就。你也可以通过斜杠命令用名字或ID来搜索成就。详细请参见Overachiever的readme.txt文件。"
L["SEARCH_NAME"] = "名称或者ID："
L["SEARCH_RESET"] = "重置"
L["SEARCH_RESULTS"] = "找到 %s 个成就。"
L["SEARCH_REWARD"] = "奖励："
L["SEARCH_SEARCHING"] = "搜索中……"
L["SEARCH_SUBMIT"] = "搜索"
L["SEARCH_TAB"] = "搜索"
L["SEARCH_TYPE"] = "类型："
L["SEARCH_TYPE_ALL"] = "全部"
L["SEARCH_TYPE_GUILD"] = "公会"
L["SEARCH_TYPE_INDIV"] = "个人"
L["SEARCH_TYPE_OTHER"] = "其它"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKEDLOCATION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP2"] = ""--]] 
L["SUGGESTIONS_DIFFICULTY"] = "地下城难度："
L["SUGGESTIONS_DIFFICULTY_AUTO"] = "自动检测"
L["SUGGESTIONS_DIFFICULTY_HEROIC"] = "英雄"
L["SUGGESTIONS_DIFFICULTY_MYTHIC"] = "史诗"
L["SUGGESTIONS_DIFFICULTY_NORMAL"] = "普通"
L["SUGGESTIONS_EMPTY"] = "Overachiever当前没有建议。"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_EMPTY_OVERRIDE"] = ""--]] 
L["SUGGESTIONS_EMPTY_TRADESKILL"] = "%s：Overachiever当前没有建议。"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_EARNED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_INCOMPLETE"] = ""--]] 
L["SUGGESTIONS_HELP"] = "根据你的当前区域建议追踪成就。"
L["SUGGESTIONS_HIDDENLOCATION"] = "隐藏"
L["SUGGESTIONS_LOCATION"] = "区域："
L["SUGGESTIONS_LOCATION_NOSUBZONE"] = "（未指定）"
L["SUGGESTIONS_LOCATION_SUBZONE"] = "子区域："
L["SUGGESTIONS_LOCATION_TIP"] = "无视区域/副本位置"
L["SUGGESTIONS_LOCATION_TIP2"] = "在字段中输入一个完整的有效区域或副本名称，以取得提示。若字段保持空白，则会根据你目前的所在位置。当光标在字段中时，按下|cffffffffTab|r键可根据已输入的内容依序产生有效的完整位置名称。按下|cffffffffShift+Tab|r则产生前一个名称。如果光标在字段的最左侧，它将依序产生所有有效位置名称。"
L["SUGGESTIONS_RAIDSIZE"] = "团队模式："
L["SUGGESTIONS_RAIDSIZE_10"] = "10人"
L["SUGGESTIONS_RAIDSIZE_25"] = "25人"
L["SUGGESTIONS_RAIDSIZE_AUTO"] = "自动检测"
L["SUGGESTIONS_REFRESH"] = "刷新"
L["SUGGESTIONS_RESULTS"] = "找到 %d 个建议。"
L["SUGGESTIONS_RESULTS_HIDDEN"] = "找到 %d 个建议。|n(有 %d 个被隐藏)"
L["SUGGESTIONS_RESULTS_TRADESKILL"] = "%s：找到 %d 个建议。"
L["SUGGESTIONS_RESULTS_TRADESKILL_HIDDEN"] = "%s：找到 %d 个建议。|n(有 %d 个被隐藏)"
L["SUGGESTIONS_SHOWHIDDEN"] = "显示隐藏"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_SHOWHIDDEN_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_SHOWHIDDEN_TIP2"] = ""--]] 
L["SUGGESTIONS_TAB"] = "建议"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_KYRIAN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NECROLORD"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NIGHTFAE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_VENTHYR"] = ""--]] 
L["SUGGESTIONS_ZONERENAME_DALARAN_BROKENISLES"] = "达拉然 (破碎群岛)"
L["SUGGESTIONS_ZONERENAME_DALARAN_NORTHREND"] = "达拉然 (诺森德)"
L["SUGGESTIONS_ZONERENAME_KARAZHAN_LEGION"] = "重返卡拉赞"
L["SUGGESTIONS_ZONERENAME_NAGRAND_DRAENOR"] = "纳兰格 (德拉诺)"
L["SUGGESTIONS_ZONERENAME_NAGRAND_OUTLAND"] = "纳兰格 (外域)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_DRAENOR"] = "影月谷 (德拉诺)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_OUTLAND"] = "影月谷 (外域)"
L["TAB_HELP"] = "|cffffffffCtrl-点击|r跳转到该成就在成就界面的位置。|n|n|cffffffffCtrl-shift-点击|r查看相关的成就。|n|n一个|cffffffff蓝色背景|r表示你还没有完成该前续步骤的成就。|n|n一个|cffffffff红色背景|r表示该成就无法在当前人物的成就界面中找到，因为这是阵营专属或是无法取得的光辉事迹。|n|n一个|cffffffff绿色背景|r表示该成就会出现在‘最近的提醒’列表。 它会在过去的2分钟内显得特别重要 (列如：它的计时器或者目标会显示在鼠标提示上)。"
--[[Translation missing --]]
--[[ L["TAB_HELP_LESS"] = ""--]] 
L["TAB_SORT"] = "排序："
L["TAB_SORT_COMPLETE"] = "完成时间"
L["TAB_SORT_ID"] = "成就ID"
L["TAB_SORT_NAME"] = "名称"
L["TAB_SORT_POINTS"] = "成就点数"
L["TAB_SORT_RELATION"] = "相关"
L["WATCH_CLEAR"] = "清除"
L["WATCH_COPY"] = "复制"
L["WATCH_COPY_TIP"] = "当启用时，假如你 |cffffffffshift+alt+点击|r 一个标签上的成就，将会新增至指定的监视列表中。"
L["WATCH_DEFAULTLIST"] = "默认列表："
L["WATCH_DEFAULTLIST_TIP"] = "The specified list will be the Displayed List at the beginning of each session."
L["WATCH_DELETE"] = "删除"
L["WATCH_DISPLAYEDLIST"] = "已显示列表："
L["WATCH_EMPTY"] = "你的监视列表是空的。在成就标签上或是成就链接上 Alt+点击 来监视。"
L["WATCH_EMPTY_SHORT"] = "清空列表"
L["WATCH_ERR_INVALIDID"] = "已将\"%s\"从监视列表中移除：找不到这个成就。"
--[[Translation missing --]]
--[[ L["WATCH_FILTERED_OUT"] = ""--]] 
L["WATCH_HELP"] = "在其他成就标签上或是成就链接使用 |cffffffffalt+点击|r来新建你的监视列表. |cffffffffAlt+点击|r 将停止监视. "
L["WATCH_LIST_GLOBAL"] = "全局"
L["WATCH_LIST_PERCHAR"] = "字符特殊"
L["WATCH_NEW"] = "新增"
L["WATCH_POPUP_CLEARLIST"] = "确定要清除这个成就监视列表的内容么？"
L["WATCH_POPUP_DELETELIST"] = "确定要删除这个成就监视列表么？"
L["WATCH_POPUP_NEWLIST"] = "输入一个新的成就监视列表名称："
L["WATCH_TAB"] = "监视"

-- Tabs/SUBZONES
	L.SUBZONES["Argent Pavilion"] = "银色大帐"
	L.SUBZONES["Argent Tournament Grounds"] = "银色比武场"
	L.SUBZONES["Formation Grounds"] = "练兵场"
	L.SUBZONES["Razorscale's Aerie"] = "锋鳞之巢"
	L.SUBZONES["Silver Covenant Pavilion"] = "银色盟约大帐"
	L.SUBZONES["Sunreaver Pavilion"] = "夺日者大帐"
	L.SUBZONES["The Alliance Valiants' Ring"] = "联盟勇士赛场"
	L.SUBZONES["The Argent Valiants' Ring"] = "银色勇士赛场"
	L.SUBZONES["The Aspirants' Ring"] = "候选者赛场"
	L.SUBZONES["The Assembly of Iron"] = "钢铁议会"
	L.SUBZONES["The Celestial Planetarium"] = "天文台"
	L.SUBZONES["The Clash of Thunder"] = "雷霆角斗场"
	L.SUBZONES["The Colossal Forge"] = "巨人熔炉"
	L.SUBZONES["The Conservatory of Life"] = "生命温室"
	L.SUBZONES["The Descent into Madness"] = "疯狂阶梯"
	L.SUBZONES["The Halls of Winter"] = "寒冬大厅"
	L.SUBZONES["The Horde Valiants' Ring"] = "部落勇士赛场"
	L.SUBZONES["The Observation Ring"] = "观测场"
	L.SUBZONES["The Prison of Yogg-Saron"] = "尤格-萨隆的监狱"
	L.SUBZONES["The Ring of Champions"] = "冠军赛场"
	L.SUBZONES["The Scrapyard"] = "废料场"
	L.SUBZONES["The Shattered Walkway"] = "破碎通道"
	L.SUBZONES["The Spark of Imagination"] = "思想火花"



elseif (locale == "ruRU") then  -- Russian
-- Tabs
L["EVENTNOTICE_ENDED_TODAY"] = "|cffff2020Это событие закончилось|r сегодня."
L["EVENTNOTICE_ENDS_DATETIME"] = "Оно заканчивается по %2$d/%1$02d в %3$s (серверному времени)."
L["EVENTNOTICE_ENDS_DAYS"] = "Оно заканчивается в|cffff2020 %s |4дня:дней;|r."
L["EVENTNOTICE_ENDS_HOURS"] = "Оно заканчивается в|cffff2020 %s |4часа:часов;|r."
L["EVENTNOTICE_ENDS_MINUTES"] = "Оно заканчивается в|cffff2020 %s |4минут:минуты;|r."
L["EVENTNOTICE_ENDS_TIME"] = "Оно заканчивается сегодня в %3$s (серверному времени)."
L["EVENTNOTICE_HELP"] = "|cffffffffЩелкните|r, чтобы просмотреть связанные достижения.|n|cffffffffCTRL+ЛКМ|r, чтобы открыть календарь.|n|cffffffffShift+ПКМ|r, чтобы временно скрыть это уведомление."
L["EVENTNOTICE_ONGOING"] = "Это событие продолжается."
L["EVENTNOTICE_STARTED_TODAY"] = "Это событие началось сегодня."
L["EVENTNOTICE_STARTS_HOURS"] = "Это событие начинается в|cff7eff00 %s |4часа:часов;|r."
L["EVENTNOTICE_STARTS_MINUTES"] = "Это событие начинается в|cff7eff00 %s |4минута:минуты;|r."
L["EVENTNOTICE_TIP"] = "Удерживайте |cffffffffShift|r для получения дополнительных сведений."
L["RELATED_BASE"] = "Базовые достижения:"
L["RELATED_CLOSE"] = "Закрыть"
L["RELATED_FILTERED_OUT"] = "%s |4достижение было:достижения были; пропущено(ы) фильтром."
L["RELATED_HELP"] = "На этой вкладке показаны достижения, которые связаны друг с другом. Одно из достижения было выбрано в качестве базового. Остальные в той же серии, что и базовые, являются являются одним из серии базовых, или имеют в качестве одного из своих собственных критериев, либо достижение в своей серии."
L["RELATED_RECURSIVE"] = "Расширенный"
L["RELATED_RECURSIVE_TIP"] = "Сделать рекурсивный поиск, так что все достижения, которые косвенно связанны с достижением базового, также будут включены."
L["RELATED_RESULTS"] = "Найдено %s |4достижение:достижений;."
L["RELATED_TAB"] = "Связанный"
L["SEARCH_ANY"] = "Всё перечисленное:"
L["SEARCH_CRITERIA"] = "Критерий:"
L["SEARCH_DESC"] = "Описание:"
L["SEARCH_FILTERED_OUT"] = "%s |4достижение было:достижения были; пропущено(ы) фильтром."
L["SEARCH_FULLLIST"] = "Включить отсутствующие|nв списке достижения"
L["SEARCH_FULLLIST_TIP"] = "В поиск будут включаться все достижения, включая не представленные в стандартном интерфейсе (например, достижения для противоположной фракции или невыполнимые)."
L["SEARCH_HELP"] = "Воспользуйтесь этой вкладкой для поиска достижений. Вы также можете искать достижения по имени или номеру, используя команды чата. Более подробную информацию вы найдёте в файле readme.txt в папке аддона."
L["SEARCH_NAME"] = "Название или ID:"
L["SEARCH_RESET"] = "Сбросить"
L["SEARCH_RESULTS"] = "Найдено достижений: %s."
L["SEARCH_REWARD"] = "Награда:"
L["SEARCH_SEARCHING"] = "Поиск..."
L["SEARCH_SUBMIT"] = "Поиск"
L["SEARCH_TAB"] = "Поиск"
L["SEARCH_TYPE"] = "Тип:"
L["SEARCH_TYPE_ALL"] = "Все"
L["SEARCH_TYPE_GUILD"] = "Гильдия"
L["SEARCH_TYPE_INDIV"] = "Лично"
L["SEARCH_TYPE_OTHER"] = "Другие"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKEDLOCATION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP2"] = ""--]] 
L["SUGGESTIONS_DIFFICULTY"] = "Сложность подземелья:"
L["SUGGESTIONS_DIFFICULTY_AUTO"] = "Автоопределение"
L["SUGGESTIONS_DIFFICULTY_HEROIC"] = "Героический"
L["SUGGESTIONS_DIFFICULTY_MYTHIC"] = "Мифический"
L["SUGGESTIONS_DIFFICULTY_NORMAL"] = "Нормальный"
L["SUGGESTIONS_EMPTY"] = "В данный момент подходящих достижений не обнаружено."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_EMPTY_OVERRIDE"] = ""--]] 
L["SUGGESTIONS_EMPTY_TRADESKILL"] = "%s: Overachiever в данный момент не имеет для вас предложений."
L["SUGGESTIONS_FILTERED_OUT_EARNED"] = "%s |4достижение было:достижения были; уже получено(ы)."
L["SUGGESTIONS_FILTERED_OUT_INCOMPLETE"] = "Отображение ЗАВЕРШЕННЫХ достижений. %s |4достижение было:достижения были; отфильтровано(ы)."
L["SUGGESTIONS_HELP"] = "Предполагаемые достижения, указанные здесь, основаны на вашем текущем местоположении. Также перечислены все \"последнее напоминание\" достижений.|n|n|cffffffffShift-правый клик|r в предлагаемом достижении, чтобы скрыть его. (Это зависит по персонажу и влияет на все местоположения.)"
L["SUGGESTIONS_HIDDENLOCATION"] = "Скрытая"
L["SUGGESTIONS_LOCATION"] = "Локация:"
L["SUGGESTIONS_LOCATION_NOSUBZONE"] = "неопределённо"
L["SUGGESTIONS_LOCATION_SUBZONE"] = "Подзона:"
L["SUGGESTIONS_LOCATION_TIP"] = "Пересечение зоны/подземелья в локации"
L["SUGGESTIONS_LOCATION_TIP2"] = "Оставьте поле пустым, чтобы получить предложения для Вашего текущего местоположения или попробуйте ввести, чтобы получить соответствие, действующий зоны или имя подземелья, чтобы использовать вместо этого. Нажмите |cffffffffTab|r для переключения между локациями, которые соответствуют тексту слева от курсора. |cffffffffShift+Tab|r показывает это в обратном порядке. Если курсор находится в крайнем левой позиции, он циклически перемещается между всеми допустимыми локациями.|n|nВы также можете ввести название определенных праздников/мировых событий (например, Тыквовин заканчивается)."
L["SUGGESTIONS_RAIDSIZE"] = "Сложность рейда:"
L["SUGGESTIONS_RAIDSIZE_10"] = "10 игроков"
L["SUGGESTIONS_RAIDSIZE_25"] = "25 игроков"
L["SUGGESTIONS_RAIDSIZE_AUTO"] = "Автоопределение"
L["SUGGESTIONS_REFRESH"] = "Обновить"
L["SUGGESTIONS_RESULTS"] = "%d |4предполoжения:предложений; найдено."
L["SUGGESTIONS_RESULTS_HIDDEN"] = "%d |4предложение:предложения; найдено.|n(%d |4эти:находятся; скрытыми.)"
L["SUGGESTIONS_RESULTS_TRADESKILL"] = "%s: %d |4предложение:предложений; найденно."
L["SUGGESTIONS_RESULTS_TRADESKILL_HIDDEN"] = "%s: %d |4предложение:предложения; найдено.|n(%d |4эти:находятся; скрытыми.)"
L["SUGGESTIONS_SHOWHIDDEN"] = "Показать скрытые"
L["SUGGESTIONS_SHOWHIDDEN_TIP"] = "Проверить и показать скрытые, предположения для этой локации."
L["SUGGESTIONS_SHOWHIDDEN_TIP2"] = "Если вам, нужно увидеть все скрытые предположения независимо от местоположения, введите \"скрытые\" в поле \"Локации\" выше.|n|n|cffffffffShift-правый клик|r на достижение для показа является, ли оно скрытым."
L["SUGGESTIONS_TAB"] = "Предположения"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_KYRIAN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NECROLORD"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NIGHTFAE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_VENTHYR"] = ""--]] 
L["SUGGESTIONS_ZONERENAME_DALARAN_BROKENISLES"] = "Даларан (Расколотые острова)"
L["SUGGESTIONS_ZONERENAME_DALARAN_NORTHREND"] = "Даларан (Нордскол)"
L["SUGGESTIONS_ZONERENAME_KARAZHAN_LEGION"] = "Возвращение в Каражан"
L["SUGGESTIONS_ZONERENAME_NAGRAND_DRAENOR"] = "Награнд (Дренор)"
L["SUGGESTIONS_ZONERENAME_NAGRAND_OUTLAND"] = "Награнд (Запределье)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_DRAENOR"] = "Долина Призрачной Луны (Дренор)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_OUTLAND"] = "Долина Призрачной Луны (Запределье)"
L["TAB_HELP"] = "|cffffffffCtrl-клик|r на достижении перенаправит вас к его местоположению в стандартном интерфейсе.|n|n|cffffffffCtrl-shift-клик|r на достижения для просмотра связанных достижений.|n|n|cffffffffСиний фон|r означает, что это часть серии достижений, для которой вы ещё не выполнили предыдущий шаг.|n|n|cffffffffКрасный фон|r означает, что это достижение не может быть найдено в стандартном интерфейсе, так оно эксклюзивно для противоположной фракции или не получаемый Великий подвиг.|n|n|cffffffffЗелёный фон|r означает, что достижение находится в списке \\\"Недавнее Напоминание\\\". Это стало особенно актуальным в последние 2 минуты (например, потому что запущен его таймер или задача была, показана в подсказке)."
--[[Translation missing --]]
--[[ L["TAB_HELP_LESS"] = ""--]] 
L["TAB_SORT"] = "Сортировать по:"
L["TAB_SORT_COMPLETE"] = "дате завершения"
L["TAB_SORT_ID"] = "номеру"
L["TAB_SORT_NAME"] = "названию"
L["TAB_SORT_POINTS"] = "очкам"
L["TAB_SORT_RELATION"] = "отношению"
L["WATCH_CLEAR"] = "Очистить"
L["WATCH_COPY"] = "Копировать в:"
L["WATCH_COPY_TIP"] = "Когда включено, если Вы, нажмете |cffffffffshift+alt+клик|r на достижение в этой вкладке, оно будет добавлено в специальный отслеживаемый лист."
L["WATCH_DEFAULTLIST"] = "Стандартный лист:"
L["WATCH_DEFAULTLIST_TIP"] = "Специальный лист будет показан Отображаемым листом в начале каждой сессии."
L["WATCH_DELETE"] = "Удалить"
L["WATCH_DISPLAYEDLIST"] = "Отображаемый лист:"
L["WATCH_EMPTY"] = "Ваш список наблюдений пуст. Нажмите на достижение Alt+Клик для наблюдения за ним, а также, получите ссылку на достижения в чат, чтобы посмотреть его."
L["WATCH_EMPTY_SHORT"] = "Пустой лист"
L["WATCH_ERR_INVALIDID"] = "Удален \"%s\" из списка: не удалось найти достижение с таким ID"
L["WATCH_FILTERED_OUT"] = "%s |4достижение было:достижения были; пропущено(ы) фильтром."
L["WATCH_HELP"] = "Создайте ваш список наблюдений нажав  |cffffffffalt+клик|r по достижению в других закладках или по ссылке в чате. Нажав |cffffffffAlt+клик|r по одному из присутствующих достижений вы удалите его из списка."
L["WATCH_LIST_GLOBAL"] = "Общее"
L["WATCH_LIST_PERCHAR"] = "По персонажу"
L["WATCH_NEW"] = "Новая"
L["WATCH_POPUP_CLEARLIST"] = "Вы уверены, что хотите очистить содержимое текущего листа достижений?"
L["WATCH_POPUP_DELETELIST"] = "Действительно хотите удалить текущий список слежения за достижениями?"
L["WATCH_POPUP_NEWLIST"] = "Введите имя нового списка слежения за достижениями:"
L["WATCH_TAB"] = "Наблюдение"

-- Tabs/SUBZONES
	L.SUBZONES["Argent Pavilion"] = "Серебряный павильон"
	L.SUBZONES["Argent Tournament Grounds"] = "Ристалище Серебряного турнира"
	L.SUBZONES["Formation Grounds"] = "Плац"
	L.SUBZONES["Razorscale's Aerie"] = "Гнездо Острокрылой"
	L.SUBZONES["Silver Covenant Pavilion"] = "Павильон Серебряного Союза"
	L.SUBZONES["Sunreaver Pavilion"] = "Павильон Похитителей Солнца"
	L.SUBZONES["The Alliance Valiants' Ring"] = "Арена искателей славы из Альянса"
	L.SUBZONES["The Argent Valiants' Ring"] = "Арена искателей славы Серебряного Авангарда"
	L.SUBZONES["The Aspirants' Ring"] = "Арена претендентов"
	L.SUBZONES["The Assembly of Iron"] = "Железное Собрание"
	L.SUBZONES["The Celestial Planetarium"] = "Священный Планетарий"
	L.SUBZONES["The Clash of Thunder"] = "Раскаты Грома"
	L.SUBZONES["The Colossal Forge"] = "Гигантская кузня"
	L.SUBZONES["The Conservatory of Life"] = "Оранжерея Жизни"
	L.SUBZONES["The Descent into Madness"] = "Провал Безумия"
	L.SUBZONES["The Halls of Winter"] = "Залы Зимы"
	L.SUBZONES["The Horde Valiants' Ring"] = "Арена искателей славы из Орды"
	L.SUBZONES["The Observation Ring"] = "Круг Наблюдения"
	L.SUBZONES["The Prison of Yogg-Saron"] = "Темница Йогг-Сарона"
	L.SUBZONES["The Ring of Champions"] = "Арена чемпионов"
	L.SUBZONES["The Scrapyard"] = "Мусорная свалка"
	L.SUBZONES["The Shattered Walkway"] = "Обвалившаяся галерея"
	L.SUBZONES["The Spark of Imagination"] = "Искра Воображения"



elseif (locale == "koKR") then  -- Korean
-- Tabs
L["EVENTNOTICE_ENDED_TODAY"] = "|cffff2020이벤트는 오늘 0시에|r 종료되었습니다."
L["EVENTNOTICE_ENDS_DATETIME"] = "이벤트는 %2$d/%1$02d at %3$s 에 종료됩니다(서버 시간)."
L["EVENTNOTICE_ENDS_DAYS"] = "이벤트는 |cffff2020 %s |4일:일;|r 후에 종료됩니다."
L["EVENTNOTICE_ENDS_HOURS"] = "이벤트는 |cffff2020 %s |4시간:시간;|r 후에 종료됩니다."
L["EVENTNOTICE_ENDS_MINUTES"] = "이벤트는|cffff2020 %s |4분:분;|r. 후에 종료됩니다"
L["EVENTNOTICE_ENDS_TIME"] = "이벤트는 오늘 %3$s 후에 종료됩니다(서버 시간)."
L["EVENTNOTICE_HELP"] = "|cffffffff클릭|r하면 연계된 업적을 표시합니다.|n|cffffffffCtrl-클릭|r하면 달력을 엽니다.|n|cffffffffShift-오른쪽-클릭|r하면 이 메시지를 숨깁니다."
L["EVENTNOTICE_ONGOING"] = "이벤트는 진행중입니다."
L["EVENTNOTICE_STARTED_TODAY"] = "이벤트는 오늘 0시에 시작되었습니다."
L["EVENTNOTICE_STARTS_HOURS"] = "이벤트는 시작한지 |cff7eff00 %s |4시:시;|r가 지났습니다."
L["EVENTNOTICE_STARTS_MINUTES"] = "이벤트는 시작한지 |cff7eff00 %s |4분:분;|r이 지났습니다."
L["EVENTNOTICE_TIP"] = "|cffffffffShift|r를 누르면 상세정보를 확인할 수 있습니다."
L["RELATED_BASE"] = "기본 업적:"
L["RELATED_CLOSE"] = "닫기"
--[[Translation missing --]]
--[[ L["RELATED_FILTERED_OUT"] = ""--]] 
L["RELATED_HELP"] = "이 탭은 하나의 업적에 연계된 업적을 표시합니다. 하나의 업적을 기본으로 선택한 후 이것을 기본으로 하여 동일한 계열, 또는 연계된 업적을 표시하게 됩니다."
L["RELATED_RECURSIVE"] = "확장"
L["RELATED_RECURSIVE_TIP"] = "기본 업적에 관련되어 있는 모든 업적을 연계하여 검색합니다."
L["RELATED_RESULTS"] = "%s |4업적:업적; 찾음."
L["RELATED_TAB"] = "연계"
L["SEARCH_ANY"] = "다음 중 적어도 하나 포함:"
L["SEARCH_CRITERIA"] = "기준:"
L["SEARCH_DESC"] = "내용:"
--[[Translation missing --]]
--[[ L["SEARCH_FILTERED_OUT"] = ""--]] 
L["SEARCH_FULLLIST"] = "모든 업적(숨겨진 업적 포함) 검색"
L["SEARCH_FULLLIST_TIP"] = "달성하지 않은 위업이나 반대 평판때문에 기본 UI에서는 표시되지 않는 업적들도 모두 표시합니다."
L["SEARCH_HELP"] = "업적을 검색하려면 이 탭을 이용하십시오. 또한 /명령어를 이용해서 이름이나 ID로 검색할 수도 있습니다. (자세한 내용은 readme.txt 참고하세요.)"
L["SEARCH_NAME"] = "이름:"
L["SEARCH_RESET"] = "초기화"
L["SEARCH_RESULTS"] = "%s개의 업적을 찾음."
L["SEARCH_REWARD"] = "보상:"
--[[Translation missing --]]
--[[ L["SEARCH_SEARCHING"] = ""--]] 
L["SEARCH_SUBMIT"] = "검색"
L["SEARCH_TAB"] = "검색"
L["SEARCH_TYPE"] = "유형:"
L["SEARCH_TYPE_ALL"] = "모두"
L["SEARCH_TYPE_GUILD"] = "길드"
L["SEARCH_TYPE_INDIV"] = "개인"
--[[Translation missing --]]
--[[ L["SEARCH_TYPE_OTHER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKEDLOCATION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP2"] = ""--]] 
L["SUGGESTIONS_DIFFICULTY"] = "던전 난이도:"
L["SUGGESTIONS_DIFFICULTY_AUTO"] = "자동 선택"
L["SUGGESTIONS_DIFFICULTY_HEROIC"] = "영웅"
L["SUGGESTIONS_DIFFICULTY_MYTHIC"] = "신화"
L["SUGGESTIONS_DIFFICULTY_NORMAL"] = "일반"
L["SUGGESTIONS_EMPTY"] = "지금은 Overachiever가 추천하는 업적이 없습니다."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_EMPTY_OVERRIDE"] = ""--]] 
L["SUGGESTIONS_EMPTY_TRADESKILL"] = "%s: 지금은 Overachiever가 추천하는 업적이 없습니다."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_EARNED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_INCOMPLETE"] = ""--]] 
L["SUGGESTIONS_HELP"] = "추천된 업적은 플레이어의 현재 위치를 기준하여 표시됩니다. 또한 2분전까지 툴팁으로 알려주었던 업적도 포함됩니다."
L["SUGGESTIONS_HIDDENLOCATION"] = "숨김"
L["SUGGESTIONS_LOCATION"] = "위치:"
L["SUGGESTIONS_LOCATION_NOSUBZONE"] = "(미지정)"
L["SUGGESTIONS_LOCATION_SUBZONE"] = "세부지역:"
L["SUGGESTIONS_LOCATION_TIP"] = "지역/던전 추천"
L["SUGGESTIONS_LOCATION_TIP2"] = "현재 지역의 추천 업적이나 지역에 맞는 추천을 위해 남깁니다. |cffffffffTab|r키를 누르면 커서의 왼쪽에 해당되는 내용이 표시됩니다. |cffffffffShift+Tab|r누르면 역순으로 표시됩니다. 커서가 왼쪽에 근접하면 모든 해당지역이 표시됩니다."
L["SUGGESTIONS_RAIDSIZE"] = "입장 인원:"
L["SUGGESTIONS_RAIDSIZE_10"] = "10인"
L["SUGGESTIONS_RAIDSIZE_25"] = "25인"
L["SUGGESTIONS_RAIDSIZE_AUTO"] = "자동 선택"
L["SUGGESTIONS_REFRESH"] = "새로 고침"
L["SUGGESTIONS_RESULTS"] = "추천하는 업적 %d개."
L["SUGGESTIONS_RESULTS_HIDDEN"] = "%d 개의 추천 업적이 있습니다.|n(%d 개 숨김 상태)"
L["SUGGESTIONS_RESULTS_TRADESKILL"] = "%s: 추천하는 업적 %d개."
L["SUGGESTIONS_RESULTS_TRADESKILL_HIDDEN"] = "%s: %d 개의 추천 업적이 있습니다.|n(%d 개 숨김 상태)"
L["SUGGESTIONS_SHOWHIDDEN"] = "숨김 표시"
L["SUGGESTIONS_SHOWHIDDEN_TIP"] = "현재 위치에 대한 숨김 제안의 표시를 위해 선택합니다."
L["SUGGESTIONS_SHOWHIDDEN_TIP2"] = "현재 지역에 대한 제안이 숨겨져있는데 표시하려면, \"숨김\"을 해제하면 됩니다.|n|n|cffffffffShift-right-click|r 하여 업적 상태를 토글할 수 있습니다."
L["SUGGESTIONS_TAB"] = "추천"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_KYRIAN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NECROLORD"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NIGHTFAE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_VENTHYR"] = ""--]] 
L["SUGGESTIONS_ZONERENAME_DALARAN_BROKENISLES"] = "달라란 (부서진 섬)"
L["SUGGESTIONS_ZONERENAME_DALARAN_NORTHREND"] = "달라란 (노스렌드)"
L["SUGGESTIONS_ZONERENAME_KARAZHAN_LEGION"] = "다시 찾은 카라잔"
L["SUGGESTIONS_ZONERENAME_NAGRAND_DRAENOR"] = "나그란드 (드레노어)"
L["SUGGESTIONS_ZONERENAME_NAGRAND_OUTLAND"] = "나그란드 (아웃랜드)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_DRAENOR"] = "어둠달 골짜기 (드레노어)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_OUTLAND"] = "어둠달 골짜기 (아웃랜드)"
L["TAB_HELP"] = "|cffffffff컨트롤+좌클릭|r으로 기본 UI의 해당 업적으로 이동할 수 있습니다.|n|n|cffffffff푸른 바탕|r은 완료되지 않은 업적 세트의 일부를 의미합니다.|n|n|cffffffff붉은 바탕|r은 반대 평판 등의 이유로 이 캐릭터의 기본 UI에는 존재하지 않는 업적을 의미합니다.|n|n|cffffffff녹색 바탕|r은 이 업적과 관련된 알림 정보가 최근 툴팁에 표시되었음을 의미합니다."
--[[Translation missing --]]
--[[ L["TAB_HELP_LESS"] = ""--]] 
L["TAB_SORT"] = "정렬 기준:"
L["TAB_SORT_COMPLETE"] = "완료된 날짜 순"
L["TAB_SORT_ID"] = "ID 순"
L["TAB_SORT_NAME"] = "이름 순"
L["TAB_SORT_POINTS"] = "업적 점수 순"
L["TAB_SORT_RELATION"] = "연계"
L["WATCH_CLEAR"] = "지우기"
L["WATCH_COPY"] = "복사"
L["WATCH_COPY_TIP"] = "현재 탭의 업적에 |cffffffffshift+alt+click|r하면, 추적 목록에 표시됩니다."
L["WATCH_DEFAULTLIST"] = "기본 목록:"
L["WATCH_DEFAULTLIST_TIP"] = "지정된 목록이 각 세션의 처음에 표시된 목록입니다."
L["WATCH_DELETE"] = "삭제"
L["WATCH_DISPLAYEDLIST"] = "표시된 목록:"
L["WATCH_EMPTY"] = "추적 목록이 비었습니다. 다른 탭의 업적을 <알트+클릭>하여 해당 업적을 추적할 수 있습니다."
L["WATCH_EMPTY_SHORT"] = "빈 목록"
L["WATCH_ERR_INVALIDID"] = "추적 목록에서 '%s' 삭제: 업적 ID를 찾을 수 없습니다."
--[[Translation missing --]]
--[[ L["WATCH_FILTERED_OUT"] = ""--]] 
L["WATCH_HELP"] = "다른 탭이나 업적 링크에서 |cffffffffAlt+좌클릭|r하여 추적 항목을 추가할 수 있습니다. 현재 창에서 |cffffffffAlt+좌클릭|r하면 추적 목록에서 제거합니다."
L["WATCH_LIST_GLOBAL"] = "전체"
L["WATCH_LIST_PERCHAR"] = "현재 캐릭터 한정"
L["WATCH_NEW"] = "신규"
L["WATCH_POPUP_CLEARLIST"] = "현재 추천 업적 목록을 초기화 하시겠습니까?"
L["WATCH_POPUP_DELETELIST"] = "현재 추천 업적 목록을 삭제 하시겠습니까?"
L["WATCH_POPUP_NEWLIST"] = "새로운 추천 업적 목록의 이름을 입력하세요."
L["WATCH_TAB"] = "추적"

-- Tabs/SUBZONES
	L.SUBZONES["Argent Pavilion"] = "은빛십자군 막사"
	L.SUBZONES["Argent Tournament Grounds"] = "은빛십자군 마상시합 광장"
	L.SUBZONES["Formation Grounds"] = "전투대형 훈련장"
	L.SUBZONES["Razorscale's Aerie"] = "칼날비늘의 둥지"
	L.SUBZONES["Silver Covenant Pavilion"] = "은빛 서약단 막사"
	L.SUBZONES["Sunreaver Pavilion"] = "선리버 막사"
	L.SUBZONES["The Alliance Valiants' Ring"] = "얼라이언스 용맹전사의 투기장"
	L.SUBZONES["The Argent Valiants' Ring"] = "은빛십자군 용맹전사의 투기장"
	L.SUBZONES["The Aspirants' Ring"] = "지원자의 투기장"
	L.SUBZONES["The Assembly of Iron"] = "무쇠 회합실"
	L.SUBZONES["The Celestial Planetarium"] = "별자리 투영관"
	L.SUBZONES["The Clash of Thunder"] = "천둥의 울림"
	L.SUBZONES["The Colossal Forge"] = "거대 제련실"
	L.SUBZONES["The Conservatory of Life"] = "생명의 정원"
	L.SUBZONES["The Descent into Madness"] = "광기의 내리막길"
	L.SUBZONES["The Halls of Winter"] = "겨울의 전당"
	L.SUBZONES["The Horde Valiants' Ring"] = "호드 용맹전사의 투기장"
	L.SUBZONES["The Observation Ring"] = "관찰 지구"
	L.SUBZONES["The Prison of Yogg-Saron"] = "요그사론의 감옥"
	L.SUBZONES["The Ring of Champions"] = "용사의 투기장"
	L.SUBZONES["The Scrapyard"] = "고철 야적장"
	L.SUBZONES["The Shattered Walkway"] = "부서진 산책로"
	L.SUBZONES["The Spark of Imagination"] = "상상의 흔적"



elseif (locale == "esES" or locale == "esMX") then  -- Spanish
-- Tabs
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDED_TODAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_DATETIME"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_DAYS"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_HOURS"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_MINUTES"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_TIME"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_HELP"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ONGOING"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_STARTED_TODAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_STARTS_HOURS"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_STARTS_MINUTES"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_BASE"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_CLOSE"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_FILTERED_OUT"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_HELP"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_RECURSIVE"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_RECURSIVE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_RESULTS"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_TAB"] = ""--]] 
L["SEARCH_ANY"] = "Cualquiera de los anteriores:"
L["SEARCH_CRITERIA"] = "Requisitos:"
L["SEARCH_DESC"] = "Descripción:"
--[[Translation missing --]]
--[[ L["SEARCH_FILTERED_OUT"] = ""--]] 
L["SEARCH_FULLLIST"] = "Incluir logros ocultos"
L["SEARCH_FULLLIST_TIP"] = "Incluye en la búsqueda de logros aquellos que normalmente no aparecen en el interface por defecto, como aquellos exclusivos de la facción contraria, Logros de fuerza sin conseguir, etc."
L["SEARCH_HELP"] = "Usa esta pestaña para buscar logros. También puedes usar los comandos de chat para buscar logros por nombre o ID. Lee el archivo readme.txt de Overachiever para más detalles."
L["SEARCH_NAME"] = "Nombre:"
L["SEARCH_RESET"] = "Limpiar"
L["SEARCH_RESULTS"] = "|4Encontrado:Encontrados; %s |4logro:logros;."
L["SEARCH_REWARD"] = "Recompensa:"
--[[Translation missing --]]
--[[ L["SEARCH_SEARCHING"] = ""--]] 
L["SEARCH_SUBMIT"] = "Buscar"
L["SEARCH_TAB"] = "Búsqueda"
L["SEARCH_TYPE"] = "Tipo:"
L["SEARCH_TYPE_ALL"] = "Todo"
L["SEARCH_TYPE_GUILD"] = "Hermandad"
L["SEARCH_TYPE_INDIV"] = "Personal"
--[[Translation missing --]]
--[[ L["SEARCH_TYPE_OTHER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKEDLOCATION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP2"] = ""--]] 
L["SUGGESTIONS_DIFFICULTY"] = "Dificultad de la instancia:"
L["SUGGESTIONS_DIFFICULTY_AUTO"] = "Autodetectar"
L["SUGGESTIONS_DIFFICULTY_HEROIC"] = "Heroico"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_DIFFICULTY_MYTHIC"] = ""--]] 
L["SUGGESTIONS_DIFFICULTY_NORMAL"] = "Normal"
L["SUGGESTIONS_EMPTY"] = "Overachiever no tiene sugerencias para ti en este momento."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_EMPTY_OVERRIDE"] = ""--]] 
L["SUGGESTIONS_EMPTY_TRADESKILL"] = "%s: Overachiever no tiene sugerencias para tí en este momento."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_EARNED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_INCOMPLETE"] = ""--]] 
L["SUGGESTIONS_HELP"] = "Las sugerencias de logros aquí listados se basan en tu ubicación actual. También se lista cualquier logro del cual se te ha mostrado un tooltip recordatorio en los últimos dos minutos."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_HIDDENLOCATION"] = ""--]] 
L["SUGGESTIONS_LOCATION"] = "Ubicación:"
L["SUGGESTIONS_LOCATION_NOSUBZONE"] = "(sin especificar)"
L["SUGGESTIONS_LOCATION_SUBZONE"] = "Subzona:"
L["SUGGESTIONS_LOCATION_TIP"] = "Ignorar la ubicación actual"
L["SUGGESTIONS_LOCATION_TIP2"] = "Déjalo en blanco para obtener sugerencias sobre tu ubicación actual o empieza a teclear para obtener una zona o instancia coincidente válida para usar en vez de la actual. Pulsa |cffffffffTabulador|r para alternar entre las ubicaciones que coinciden con el texto a la izquierda del cursor. |cffffffffSfit+Tabulador|r alterna invirtiendo el orden. Si el cursor está en la izquierda del todo, alternará entre todas las ubicaciones válidas."
L["SUGGESTIONS_RAIDSIZE"] = "Tamaño de la banda:"
L["SUGGESTIONS_RAIDSIZE_10"] = "10 jugadores"
L["SUGGESTIONS_RAIDSIZE_25"] = "25 jugadores"
L["SUGGESTIONS_RAIDSIZE_AUTO"] = "Autodetectar"
L["SUGGESTIONS_REFRESH"] = "Actualizar"
L["SUGGESTIONS_RESULTS"] = "%d |4sugerencia:sugerencias; |4encontrada:encontradas;"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_RESULTS_HIDDEN"] = ""--]] 
L["SUGGESTIONS_RESULTS_TRADESKILL"] = "%s: %d |4sugerencia:sugerencias; |4encontrada:encontradas;"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_RESULTS_TRADESKILL_HIDDEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_SHOWHIDDEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_SHOWHIDDEN_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_SHOWHIDDEN_TIP2"] = ""--]] 
L["SUGGESTIONS_TAB"] = "Sugerencias"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_KYRIAN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NECROLORD"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NIGHTFAE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_VENTHYR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_DALARAN_BROKENISLES"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_DALARAN_NORTHREND"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_KARAZHAN_LEGION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_NAGRAND_DRAENOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_NAGRAND_OUTLAND"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_DRAENOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_OUTLAND"] = ""--]] 
L["TAB_HELP"] = "|cffffffffCtrl-click|r sobre un logro para saltar a su posición en el interface estándar.|n|nUn |cfffffffffondo azul|r indica que es parte de una serie para la que aún no has completado un paso anterior.|n|nUn |cfffffffffondo rojo|r indica que no se encuentra en el interface estándar para este personaje porque es exclusivo de la facción contraria o es una Proeza de fuerza que aún no has logrado.|n|nUn |cfffffffffondo verde|r indica que se ha mostrado un tooltip recordatorio sobre este logro recientemente."
--[[Translation missing --]]
--[[ L["TAB_HELP_LESS"] = ""--]] 
L["TAB_SORT"] = "Ordenado por:"
L["TAB_SORT_COMPLETE"] = "Fecha de finalización"
L["TAB_SORT_ID"] = "ID"
L["TAB_SORT_NAME"] = "Nombre"
L["TAB_SORT_POINTS"] = "Puntuación"
--[[Translation missing --]]
--[[ L["TAB_SORT_RELATION"] = ""--]] 
L["WATCH_CLEAR"] = "Limpiar"
L["WATCH_COPY"] = "Copiar a:"
L["WATCH_COPY_TIP"] = "Al activarlo, si haces |cffffffffshift+alt+click|r sobre un logro en esta pestaña, éste será añadido a la lista de seguimiento especificada."
L["WATCH_DEFAULTLIST"] = "Lista por Defecto:"
L["WATCH_DEFAULTLIST_TIP"] = "La lista especificada será la Lista Mostrada al inicio de cada sesión."
L["WATCH_DELETE"] = "Borrar"
L["WATCH_DISPLAYEDLIST"] = "Lista Mostrada:"
L["WATCH_EMPTY"] = "Tu lista de vigilancia está vacía. Alt+click sobre un logro en otra pestaña o sobre el enlace de un logro en el chat para vigilarlo."
L["WATCH_EMPTY_SHORT"] = "Lista Vacía"
L["WATCH_ERR_INVALIDID"] = "Quitado \"%s\" de la lista de vigilancia: no se ha podido encontrar ningún logro con esa ID."
--[[Translation missing --]]
--[[ L["WATCH_FILTERED_OUT"] = ""--]] 
L["WATCH_HELP"] = "Crea tu lista de vigilancia haciendo |cffffffffalt+click|r sobre logros en las otras pestañas o sobre enlaces de logros el el chat. |cffffffffAlt+click|r sobre uno mostrado aquí para dejar de vigilarlo."
L["WATCH_LIST_GLOBAL"] = "Global"
L["WATCH_LIST_PERCHAR"] = "Específica de cada personaje"
L["WATCH_NEW"] = "Nueva"
L["WATCH_POPUP_CLEARLIST"] = "¿ Estás seguro de que deseas limpiar el contenido de la lista de seguimiento de logros actual ?"
L["WATCH_POPUP_DELETELIST"] = "¿ Estás seguro de que deseas borrar permanentemente la lista de seguimiento de logros actual ?"
L["WATCH_POPUP_NEWLIST"] = "Introduce el nombre de tu nueva lista de seguimiento de logros:"
L["WATCH_TAB"] = "Seguimiento"

-- Tabs/SUBZONES
	L.SUBZONES["Argent Pavilion"] = "Pabellón Argenta"
	L.SUBZONES["Argent Tournament Grounds"] = "Campos del Torneo Argenta"
	L.SUBZONES["Formation Grounds"] = "Campo de Formación"
	L.SUBZONES["Razorscale's Aerie"] = "Nidal de Tajoescama"
	L.SUBZONES["Silver Covenant Pavilion"] = "Pabellón de El Pacto de Plata"
	L.SUBZONES["Sunreaver Pavilion"] = "Pabellón Atracasol"
	L.SUBZONES["The Alliance Valiants' Ring"] = "La Liza de los Valerosos de la Alianza"
	L.SUBZONES["The Argent Valiants' Ring"] = "La Liza de los Valerosos Argenta"
	L.SUBZONES["The Aspirants' Ring"] = "La Liza de los Aspirantes"
	L.SUBZONES["The Assembly of Iron"] = "La Asamblea de Hierro"
	L.SUBZONES["The Celestial Planetarium"] = "El Planetario Celestial"
	L.SUBZONES["The Clash of Thunder"] = "El Fragor del Trueno"
	L.SUBZONES["The Colossal Forge"] = "La Forja Colosal"
	L.SUBZONES["The Conservatory of Life"] = "El Invernadero de Vida"
	L.SUBZONES["The Descent into Madness"] = "El Descenso a la Locura"
	L.SUBZONES["The Halls of Winter"] = "Las Cámaras del Invierno"
	L.SUBZONES["The Horde Valiants' Ring"] = "La Liza de los Valerosos de la Horda"
	L.SUBZONES["The Observation Ring"] = "El Circulo de Observación"
	L.SUBZONES["The Prison of Yogg-Saron"] = "La Prisión de Yogg-Saron"
	L.SUBZONES["The Ring of Champions"] = "La Liza de los Campeones"
	L.SUBZONES["The Scrapyard"] = "La Chatarrería"
	L.SUBZONES["The Shattered Walkway"] = "La Pasarela Devastada"
	L.SUBZONES["The Spark of Imagination"] = "Chispa de Imaginación"



	if (locale == "esMX") then  -- Spanish (Mexican)
-- Tabs
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDED_TODAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_DATETIME"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_DAYS"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_HOURS"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_MINUTES"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ENDS_TIME"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_HELP"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_ONGOING"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_STARTED_TODAY"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_STARTS_HOURS"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_STARTS_MINUTES"] = ""--]] 
--[[Translation missing --]]
--[[ L["EVENTNOTICE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_BASE"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_CLOSE"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_FILTERED_OUT"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_HELP"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_RECURSIVE"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_RECURSIVE_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_RESULTS"] = ""--]] 
--[[Translation missing --]]
--[[ L["RELATED_TAB"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_ANY"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_CRITERIA"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_DESC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_FILTERED_OUT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_FULLLIST"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_FULLLIST_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_HELP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_NAME"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_RESET"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_RESULTS"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_REWARD"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_SEARCHING"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_SUBMIT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_TAB"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_TYPE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_TYPE_ALL"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_TYPE_GUILD"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_TYPE_INDIV"] = ""--]] 
--[[Translation missing --]]
--[[ L["SEARCH_TYPE_OTHER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKEDLOCATION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_DIFFICULTY"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_DIFFICULTY_AUTO"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_DIFFICULTY_HEROIC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_DIFFICULTY_MYTHIC"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_DIFFICULTY_NORMAL"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_EMPTY"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_EMPTY_OVERRIDE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_EMPTY_TRADESKILL"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_EARNED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_HELP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_HIDDENLOCATION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_LOCATION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_LOCATION_NOSUBZONE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_LOCATION_SUBZONE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_LOCATION_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_LOCATION_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_RAIDSIZE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_RAIDSIZE_10"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_RAIDSIZE_25"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_RAIDSIZE_AUTO"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_REFRESH"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_RESULTS"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_RESULTS_HIDDEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_RESULTS_TRADESKILL"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_RESULTS_TRADESKILL_HIDDEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_SHOWHIDDEN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_SHOWHIDDEN_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_SHOWHIDDEN_TIP2"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_TAB"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_KYRIAN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NECROLORD"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NIGHTFAE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_VENTHYR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_DALARAN_BROKENISLES"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_DALARAN_NORTHREND"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_KARAZHAN_LEGION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_NAGRAND_DRAENOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_NAGRAND_OUTLAND"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_DRAENOR"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_OUTLAND"] = ""--]] 
--[[Translation missing --]]
--[[ L["TAB_HELP"] = ""--]] 
--[[Translation missing --]]
--[[ L["TAB_HELP_LESS"] = ""--]] 
--[[Translation missing --]]
--[[ L["TAB_SORT"] = ""--]] 
--[[Translation missing --]]
--[[ L["TAB_SORT_COMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["TAB_SORT_ID"] = ""--]] 
--[[Translation missing --]]
--[[ L["TAB_SORT_NAME"] = ""--]] 
--[[Translation missing --]]
--[[ L["TAB_SORT_POINTS"] = ""--]] 
--[[Translation missing --]]
--[[ L["TAB_SORT_RELATION"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_CLEAR"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_COPY"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_COPY_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_DEFAULTLIST"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_DEFAULTLIST_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_DELETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_DISPLAYEDLIST"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_EMPTY"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_EMPTY_SHORT"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_ERR_INVALIDID"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_FILTERED_OUT"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_HELP"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_LIST_GLOBAL"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_LIST_PERCHAR"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_NEW"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_POPUP_CLEARLIST"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_POPUP_DELETELIST"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_POPUP_NEWLIST"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_TAB"] = ""--]] 

-- Tabs/SUBZONES
	--[[Translation missing --]]
	--[[ L.SUBZONES["Argent Pavilion"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["Argent Tournament Grounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["Formation Grounds"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["Razorscale's Aerie"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["Silver Covenant Pavilion"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["Sunreaver Pavilion"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Alliance Valiants' Ring"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Argent Valiants' Ring"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Aspirants' Ring"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Assembly of Iron"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Celestial Planetarium"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Clash of Thunder"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Colossal Forge"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Conservatory of Life"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Descent into Madness"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Halls of Winter"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Horde Valiants' Ring"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Observation Ring"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Prison of Yogg-Saron"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Ring of Champions"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Scrapyard"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Shattered Walkway"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Spark of Imagination"] = ""--]] 

	end


elseif (locale == "ptBR") then  -- Brazilian Portuguese
-- Tabs
L["EVENTNOTICE_ENDED_TODAY"] = "|cffff2020Este evento terminou|r hoje mais cedo."
L["EVENTNOTICE_ENDS_DATETIME"] = "Acaba em %1$02d/%2$d às %3$s (horário do servidor)."
L["EVENTNOTICE_ENDS_DAYS"] = "Termina em|cffff2020 %s |4dia:dias;|r."
L["EVENTNOTICE_ENDS_HOURS"] = "Termina em|cffff2020 %s |4hora:horas;|r."
L["EVENTNOTICE_ENDS_MINUTES"] = "Termina em|cffff2020 %s |4minuto:minutos;|r."
L["EVENTNOTICE_ENDS_TIME"] = "Termina hoje às %3$s (horário do servidor)."
L["EVENTNOTICE_HELP"] = "|cffffffffClique|r para ver conquistas relacionadas.|n|cffffffffCtrl+clique|r para abrir o calendário.|n|cffffffffShift+clique|r para ocultar este aviso temporariamente."
L["EVENTNOTICE_ONGOING"] = "Este evento está acontecendo agora."
L["EVENTNOTICE_STARTED_TODAY"] = "Este evento começou hoje mais cedo."
L["EVENTNOTICE_STARTS_HOURS"] = "Este evento começa em|cff7eff00 %s |4hora:horas;|r."
L["EVENTNOTICE_STARTS_MINUTES"] = "Este evento começa em|cff7eff00 %s |4minuto:minutos;|r."
L["EVENTNOTICE_TIP"] = "Segure |cffffffffShift|r para mais detalhes."
L["RELATED_BASE"] = "Conquista base:"
L["RELATED_CLOSE"] = "Fechar"
--[[Translation missing --]]
--[[ L["RELATED_FILTERED_OUT"] = ""--]] 
L["RELATED_HELP"] = "Esta aba mostra conquistas que estão relacionadas entre si. Uma conquista foi escolhida como a base. O resto está na mesma série que a base, é um dos critérios da base ou de outra conquista na série, ou então tem como um se seus próprios critérios a conquista base ou uma na série da conquista base."
L["RELATED_RECURSIVE"] = "Estendida"
L["RELATED_RECURSIVE_TIP"] = "Faz uma busca recursiva para incluir também todas as conquistas que estão indiretamente relacionadas à conquista base."
L["RELATED_RESULTS"] = "%s |4conquista encontrada:conquistas encontradas;."
L["RELATED_TAB"] = "Relacionadas"
L["SEARCH_ANY"] = "Qualquer acima:"
L["SEARCH_CRITERIA"] = "Critérios:"
L["SEARCH_DESC"] = "Descrição:"
--[[Translation missing --]]
--[[ L["SEARCH_FILTERED_OUT"] = ""--]] 
L["SEARCH_FULLLIST"] = "Incluir conquistas|nocultas"
L["SEARCH_FULLLIST_TIP"] = "Inclui na busca conquistas que não são normalmente listadas na página padrão, como aquelas exclusivas à facção oposta, Proezas Memoráveis não obtidas, etc."
L["SEARCH_HELP"] = "Use essa aba para pesquisar conquistas. Voce também pode pesquisar conquistas por nome ou ID usando comandos de barra. Veja o arquivo readme.txt do Overachiever para detalhes."
L["SEARCH_NAME"] = "Nome ou ID:"
L["SEARCH_RESET"] = "Reiniciar"
L["SEARCH_RESULTS"] = "%s |4conquista encontrada:conquistas encontradas;."
L["SEARCH_REWARD"] = "Recompensa:"
L["SEARCH_SEARCHING"] = "Pesquisando..."
L["SEARCH_SUBMIT"] = "Pesquisar"
L["SEARCH_TAB"] = "Pesquisar"
L["SEARCH_TYPE"] = "Tipo:"
L["SEARCH_TYPE_ALL"] = "Todas"
L["SEARCH_TYPE_GUILD"] = "De Guilda"
L["SEARCH_TYPE_INDIV"] = "Pessoais"
L["SEARCH_TYPE_OTHER"] = "Outro"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKEDLOCATION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP2"] = ""--]] 
L["SUGGESTIONS_DIFFICULTY"] = "Dificuldade da instância:"
L["SUGGESTIONS_DIFFICULTY_AUTO"] = "Detectar autom."
L["SUGGESTIONS_DIFFICULTY_HEROIC"] = "Heroica"
L["SUGGESTIONS_DIFFICULTY_MYTHIC"] = "Mítica"
L["SUGGESTIONS_DIFFICULTY_NORMAL"] = "Normal"
L["SUGGESTIONS_EMPTY"] = "O Overachiever não tem sugestões para você neste momento."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_EMPTY_OVERRIDE"] = ""--]] 
L["SUGGESTIONS_EMPTY_TRADESKILL"] = "%s: O Overachiever não tem sugestões para você neste momento."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_EARNED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_INCOMPLETE"] = ""--]] 
L["SUGGESTIONS_HELP"] = "As conquistas sugeridas listadas aqui são baseadas em seu local atual. Também estão listadas todas as conquistas \"Recentemente Lembradas\".|n|n|cffffffffShift+botão direito|r em uma conquista sugerida para ocultá-la. (Este é um atributo específico e afeta todas os locais.)."
L["SUGGESTIONS_HIDDENLOCATION"] = "ocultas"
L["SUGGESTIONS_LOCATION"] = "Local:"
L["SUGGESTIONS_LOCATION_NOSUBZONE"] = "(não especificado)"
L["SUGGESTIONS_LOCATION_SUBZONE"] = "Subzona:"
L["SUGGESTIONS_LOCATION_TIP"] = "Substituir Zona/Instância Atual"
L["SUGGESTIONS_LOCATION_TIP2"] = "Deixe em branco para mostrar sugestões para seu local atual ou comece a digitar para mostrar sugestões com base no nome de uma zona ou instância. Pressione |cffffffffTab|r para alternar entre locais que correspondem ao texto à esquerda do cursor. |cffffffffShift+Tab|r alterna na ordem inversa. Se o cursor estiver na posição mais à esquerda, alterna entre todos os locais válidos."
L["SUGGESTIONS_RAIDSIZE"] = "Tamanho do raide:"
L["SUGGESTIONS_RAIDSIZE_10"] = "10 jogadores"
L["SUGGESTIONS_RAIDSIZE_25"] = "25 jogadores"
L["SUGGESTIONS_RAIDSIZE_AUTO"] = "Detectar autom."
L["SUGGESTIONS_REFRESH"] = "Atualizar"
L["SUGGESTIONS_RESULTS"] = "%d |4sugestão encontrada:sugestões encontradas;."
L["SUGGESTIONS_RESULTS_HIDDEN"] = "%d |4sugestão encontrada:sugestões encontradas;.|n(%d |4está oculta:estão ocultas;.)"
L["SUGGESTIONS_RESULTS_TRADESKILL"] = "%s: %d |4sugestão encontrada:sugestões encontradas;."
L["SUGGESTIONS_RESULTS_TRADESKILL_HIDDEN"] = "%s: %d |4sugestão encontrada:sugestões encontradas;.|n(%d |4está oculta:estão ocultas;.)"
L["SUGGESTIONS_SHOWHIDDEN"] = "Mostrar ocultas"
L["SUGGESTIONS_SHOWHIDDEN_TIP"] = "Marque para mostrar sugestões ocultas para este local."
L["SUGGESTIONS_SHOWHIDDEN_TIP2"] = "Se você quer ver todas as sugestões ocultas independentemente de localização, insira \"ocultas\" no campo Localização acima.|n|n|cffffffffShift+clique-direito|r em uma conquista a oculta ou exibe."
L["SUGGESTIONS_TAB"] = "Sugestões"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_KYRIAN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NECROLORD"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NIGHTFAE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_VENTHYR"] = ""--]] 
L["SUGGESTIONS_ZONERENAME_DALARAN_BROKENISLES"] = "Dalaran (Ilhas Partidas)"
L["SUGGESTIONS_ZONERENAME_DALARAN_NORTHREND"] = "Dalaran (Nortúndria)"
L["SUGGESTIONS_ZONERENAME_KARAZHAN_LEGION"] = "Retorno a Karazhan"
L["SUGGESTIONS_ZONERENAME_NAGRAND_DRAENOR"] = "Nagrand (Draenor)"
L["SUGGESTIONS_ZONERENAME_NAGRAND_OUTLAND"] = "Nagrand (Terralém)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_DRAENOR"] = "Vale da Lua Negra (Draenor)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_OUTLAND"] = "Vale da Lua Negra (Terralém)"
L["TAB_HELP"] = "|cffffffffCtrl-clique|r em uma conquista para ir ao seu lugar na página padrão.|n|nUm |cfffffffffundo azul|r significa que é parte de uma série da qual você não completou um passo anterior.|n|nUm |cfffffffffundo vermelho|r significa que não pode ser encontrada na página padrão para este personagem por ser exclusiva à facção oposta ou por ser uma Proeza Memorável não conquistada.|n|nUm |cfffffffffundo verde|r significa que um lembrete desta conquista foi exibido numa dica de tela recentemente ou tem um cronômetro que começou recentemente."
--[[Translation missing --]]
--[[ L["TAB_HELP_LESS"] = ""--]] 
L["TAB_SORT"] = "Classificar por:"
L["TAB_SORT_COMPLETE"] = "Data completada"
L["TAB_SORT_ID"] = "ID"
L["TAB_SORT_NAME"] = "Nome"
L["TAB_SORT_POINTS"] = "Valor de pontos"
L["TAB_SORT_RELATION"] = "Relação"
L["WATCH_CLEAR"] = "Limpar"
L["WATCH_COPY"] = "Copiar Para:"
L["WATCH_COPY_TIP"] = "Quando ativado, se você |cffffffffshift+alt+clicar|r em uma conquista nesta aba, ela será adicionada à lista de vigia especificada. "
L["WATCH_DEFAULTLIST"] = "Lista Padrão:"
L["WATCH_DEFAULTLIST_TIP"] = "A lista especificada será a Lista Exibida no início de cada sessão."
L["WATCH_DELETE"] = "Excluir"
L["WATCH_DISPLAYEDLIST"] = "Lista Exibida:"
L["WATCH_EMPTY"] = "Sua lista de conquistas vigiadas está vazia. Alt+clique em uma conquista em outra aba ou em um link para uma conquista em uma conversa para vigiá-la."
L["WATCH_EMPTY_SHORT"] = "Lista Vazia"
L["WATCH_ERR_INVALIDID"] = "\"%s\" foi removida da Lista de Conquistas Vigiadas: Uma conquista com este ID não pôde ser encontrada."
--[[Translation missing --]]
--[[ L["WATCH_FILTERED_OUT"] = ""--]] 
L["WATCH_HELP"] = "Crie sua lista de conquistas vigiadas dando um |cffffffffalt+clique|r em conquistas nas outras abas ou em links de conquistas em uma conversa. |cffffffffAlt+clique|r em uma mostrada aqui para deixar de vigiá-la."
L["WATCH_LIST_GLOBAL"] = "Global"
L["WATCH_LIST_PERCHAR"] = "Este personagem"
L["WATCH_NEW"] = "Nova"
L["WATCH_POPUP_CLEARLIST"] = "Tem certeza de que deseja limpar o conteúdo da lista de conquistas vigiadas atual?"
L["WATCH_POPUP_DELETELIST"] = "Tem certeza de que deseja excluir permanentemente a lista de conquistas vigiadas atual?"
L["WATCH_POPUP_NEWLIST"] = "Digite o nome da sua nova lista de conquistas vigiadas:"
L["WATCH_TAB"] = "Vigiar"

-- Tabs/SUBZONES
	L.SUBZONES["Argent Pavilion"] = "Pavilhão Argênteo"
	L.SUBZONES["Argent Tournament Grounds"] = "Campos do Torneio Argênteo"
	L.SUBZONES["Formation Grounds"] = "Campos de Formação"
	L.SUBZONES["Razorscale's Aerie"] = "Refúgio da Navalhada"
	L.SUBZONES["Silver Covenant Pavilion"] = "Pavilhão do Pacto de Prata"
	L.SUBZONES["Sunreaver Pavilion"] = "Pavilhão Fendessol"
	L.SUBZONES["The Alliance Valiants' Ring"] = "Arena dos Valentes da Aliança"
	L.SUBZONES["The Argent Valiants' Ring"] = "Arena dos Valentes Argênteos"
	L.SUBZONES["The Aspirants' Ring"] = "Arena dos Aspirantes"
	L.SUBZONES["The Assembly of Iron"] = "A Assembleia de Ferro"
	L.SUBZONES["The Celestial Planetarium"] = "O Planetário Celestial"
	L.SUBZONES["The Clash of Thunder"] = "Estrondo do Trovão"
	L.SUBZONES["The Colossal Forge"] = "Forja Colossal"
	L.SUBZONES["The Conservatory of Life"] = "Reserva Biológica"
	L.SUBZONES["The Descent into Madness"] = "A Espiral da Loucura"
	L.SUBZONES["The Halls of Winter"] = "Os Salões do Inverno"
	L.SUBZONES["The Horde Valiants' Ring"] = "Arena dos Valentes da Horda"
	L.SUBZONES["The Observation Ring"] = "Campos de Observação"
	L.SUBZONES["The Prison of Yogg-Saron"] = "Prisão de Yogg-Saron"
	L.SUBZONES["The Ring of Champions"] = "Arena dos Campeões"
	L.SUBZONES["The Scrapyard"] = "O Ferro Velho"
	L.SUBZONES["The Shattered Walkway"] = "A Passarela Despedaçada"
	L.SUBZONES["The Spark of Imagination"] = "Centelha da Imaginação"



elseif (locale == "itIT") then  -- Italian
-- Tabs
L["EVENTNOTICE_ENDED_TODAY"] = "|cffff2020Questo evento si è concluso|r oggi."
L["EVENTNOTICE_ENDS_DATETIME"] = "Terminerà il %1$02d/%2$d alle %3$s (ora del server)."
L["EVENTNOTICE_ENDS_DAYS"] = "Terminerà tra|cffff2020 %s |4giorno:giorni;|r."
L["EVENTNOTICE_ENDS_HOURS"] = "Terminerà tra|cffff2020 %s |4ora:ore;|r."
L["EVENTNOTICE_ENDS_MINUTES"] = "Terminerà tra|cffff2020 %s |4minuto:minuti;|r."
L["EVENTNOTICE_ENDS_TIME"] = "Terminerà oggi alle %3$s (ora del server)."
L["EVENTNOTICE_HELP"] = "|cffffffffClicca|r per vedere le imprese relative.|n|cffffffffCtrl+click|r per aprire il calendario.|n|cffffffffShift+Click Destro|r nascondere temporaneamente questo avviso."
L["EVENTNOTICE_ONGOING"] = "Questo evento è in corso."
L["EVENTNOTICE_STARTED_TODAY"] = "Questo evento è iniziato oggi."
L["EVENTNOTICE_STARTS_HOURS"] = "Questo evento inizierà tra|cff7eff00 %s |4ora:ore;|r."
L["EVENTNOTICE_STARTS_MINUTES"] = "Questo evento inizierà tra|cff7eff00 %s |4minuto:minuti;|r."
L["EVENTNOTICE_TIP"] = "Tieni premuto |cffffffffShift|r per maggiori dettagli."
L["RELATED_BASE"] = "Impresa di Base:"
L["RELATED_CLOSE"] = "Chiudi"
--[[Translation missing --]]
--[[ L["RELATED_FILTERED_OUT"] = ""--]] 
L["RELATED_HELP"] = "Questa scheda mostra le imprese che sono correlate l'una all'altra. Si seleziona un'impresa di base. Vengono mostrate le imprese della stessa serie, quelle necessarie alla base o alle altre della serie, o che hanno tra i loro criteri l'impresa base o una della sua serie."
L["RELATED_RECURSIVE"] = "Estesa"
L["RELATED_RECURSIVE_TIP"] = "Esegui una ricerca ricorsiva in modo da includere tutte le imprese indirettamente correlate all'impresa di base."
L["RELATED_RESULTS"] = "|4Trovata:Trovate; %s |4impresa:imprese;."
L["RELATED_TAB"] = "Correlate"
L["SEARCH_ANY"] = "Ovunque:"
L["SEARCH_CRITERIA"] = "Criteri:"
L["SEARCH_DESC"] = "Descrizione:"
--[[Translation missing --]]
--[[ L["SEARCH_FILTERED_OUT"] = ""--]] 
L["SEARCH_FULLLIST"] = "Includi imprese|nfuori lista"
L["SEARCH_FULLLIST_TIP"] = "Includi nella ricerca le imprese normalmente non visibili nell'Interfaccia, come quelle esclusive della fazione opposta, le prove di forza non ottenute, ecc..."
L["SEARCH_HELP"] = "Usa questa scheda per ricercare le imprese. Puoi cercare le imprese anche per nome o per ID usando i comandi slash. Leggi il file readme.txt di Overachiever per ulteriori dettagli"
L["SEARCH_NAME"] = "Nome o ID:"
L["SEARCH_RESET"] = "Svuota"
L["SEARCH_RESULTS"] = "Trovato %s |4impresa:imprese;."
L["SEARCH_REWARD"] = "Premio"
--[[Translation missing --]]
--[[ L["SEARCH_SEARCHING"] = ""--]] 
L["SEARCH_SUBMIT"] = "Cerca"
L["SEARCH_TAB"] = "Cerca"
L["SEARCH_TYPE"] = "Tipo:"
L["SEARCH_TYPE_ALL"] = "Tutti"
L["SEARCH_TYPE_GUILD"] = "Gilda"
L["SEARCH_TYPE_INDIV"] = "Personale"
--[[Translation missing --]]
--[[ L["SEARCH_TYPE_OTHER"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKEDLOCATION"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_AUTOTRACKING_TIP2"] = ""--]] 
L["SUGGESTIONS_DIFFICULTY"] = "Difficoltà Spedizioni:"
L["SUGGESTIONS_DIFFICULTY_AUTO"] = "Automatica"
L["SUGGESTIONS_DIFFICULTY_HEROIC"] = "Eroica"
L["SUGGESTIONS_DIFFICULTY_MYTHIC"] = "Mitica"
L["SUGGESTIONS_DIFFICULTY_NORMAL"] = "Normale"
L["SUGGESTIONS_EMPTY"] = "Al momento Overachiever non ha suggerimenti per te."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_EMPTY_OVERRIDE"] = ""--]] 
L["SUGGESTIONS_EMPTY_TRADESKILL"] = "%s: Overachiever non ha consigli per te al momento."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_EARNED"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_FILTERED_OUT_INCOMPLETE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_HELP"] = ""--]] 
L["SUGGESTIONS_HIDDENLOCATION"] = "nascosto"
L["SUGGESTIONS_LOCATION"] = "Luogo:"
L["SUGGESTIONS_LOCATION_NOSUBZONE"] = "(non specificata)"
L["SUGGESTIONS_LOCATION_SUBZONE"] = "Sottozona:"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_LOCATION_TIP"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_LOCATION_TIP2"] = ""--]] 
L["SUGGESTIONS_RAIDSIZE"] = "Dimensione Incursione:"
L["SUGGESTIONS_RAIDSIZE_10"] = "10 giocatori"
L["SUGGESTIONS_RAIDSIZE_25"] = "25 giocatori"
L["SUGGESTIONS_RAIDSIZE_AUTO"] = "Automatica"
L["SUGGESTIONS_REFRESH"] = "Aggiorna"
L["SUGGESTIONS_RESULTS"] = "%d |4suggerimento trovato:suggerimenti trovati;."
L["SUGGESTIONS_RESULTS_HIDDEN"] = "%d |4suggerimento trovato:suggerimenti trovati;.|n(%d |4nascosto:nascosti;.)"
L["SUGGESTIONS_RESULTS_TRADESKILL"] = "%s: %d |4suggerimento trovato:suggerimenti trovati;."
L["SUGGESTIONS_RESULTS_TRADESKILL_HIDDEN"] = "%s: %d |4suggerimento trovato:suggerimenti trovati;.|n(%d |4nascosto:nascosti;.)"
L["SUGGESTIONS_SHOWHIDDEN"] = "Mostra Nascoste"
L["SUGGESTIONS_SHOWHIDDEN_TIP"] = "Seleziona per mostrare i suggerimenti nascosti di questo luogo."
--[[Translation missing --]]
--[[ L["SUGGESTIONS_SHOWHIDDEN_TIP2"] = ""--]] 
L["SUGGESTIONS_TAB"] = "Suggerimenti"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_KYRIAN"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NECROLORD"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_NIGHTFAE"] = ""--]] 
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_COVENANT_VENTHYR"] = ""--]] 
L["SUGGESTIONS_ZONERENAME_DALARAN_BROKENISLES"] = "Dalaran (Isole Disperse)"
L["SUGGESTIONS_ZONERENAME_DALARAN_NORTHREND"] = "Dalaran (Nordania)"
--[[Translation missing --]]
--[[ L["SUGGESTIONS_ZONERENAME_KARAZHAN_LEGION"] = ""--]] 
L["SUGGESTIONS_ZONERENAME_NAGRAND_DRAENOR"] = "Nagrand (Draenor)"
L["SUGGESTIONS_ZONERENAME_NAGRAND_OUTLAND"] = "Nagrand (Terre Esterne)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_DRAENOR"] = "Valle di Torvaluna (Draenor)"
L["SUGGESTIONS_ZONERENAME_SHADOWMOONVALLEY_OUTLAND"] = "Valle di Torvaluna (Terre Esterne)"
--[[Translation missing --]]
--[[ L["TAB_HELP"] = ""--]] 
--[[Translation missing --]]
--[[ L["TAB_HELP_LESS"] = ""--]] 
L["TAB_SORT"] = "Ordina per:"
L["TAB_SORT_COMPLETE"] = "Data completamento"
L["TAB_SORT_ID"] = "ID"
L["TAB_SORT_NAME"] = "Nome"
L["TAB_SORT_POINTS"] = "Punti ottenuti"
L["TAB_SORT_RELATION"] = "Relazione"
L["WATCH_CLEAR"] = "Svuota"
L["WATCH_COPY"] = "Copia In:"
--[[Translation missing --]]
--[[ L["WATCH_COPY_TIP"] = ""--]] 
L["WATCH_DEFAULTLIST"] = "Lista Predefinita:"
--[[Translation missing --]]
--[[ L["WATCH_DEFAULTLIST_TIP"] = ""--]] 
L["WATCH_DELETE"] = "Elimina"
--[[Translation missing --]]
--[[ L["WATCH_DISPLAYEDLIST"] = ""--]] 
L["WATCH_EMPTY"] = "La tua lista è vuota. Usa alt+click su un'impresa in un'altra scheda o collegamento alla chat per osservarlo."
L["WATCH_EMPTY_SHORT"] = "Lista vuota"
--[[Translation missing --]]
--[[ L["WATCH_ERR_INVALIDID"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_FILTERED_OUT"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_HELP"] = ""--]] 
L["WATCH_LIST_GLOBAL"] = "Scheda Globale"
L["WATCH_LIST_PERCHAR"] = "Personaggio specifico"
L["WATCH_NEW"] = "Nuova"
--[[Translation missing --]]
--[[ L["WATCH_POPUP_CLEARLIST"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_POPUP_DELETELIST"] = ""--]] 
--[[Translation missing --]]
--[[ L["WATCH_POPUP_NEWLIST"] = ""--]] 
L["WATCH_TAB"] = "Osserva"

-- Tabs/SUBZONES
	L.SUBZONES["Argent Pavilion"] = "Padiglione d'argento"
	L.SUBZONES["Argent Tournament Grounds"] = "Campi del Torneo d'Argento"
	L.SUBZONES["Formation Grounds"] = "Campi di Formazione"
	--[[Translation missing --]]
	--[[ L.SUBZONES["Razorscale's Aerie"] = ""--]] 
	--[[Translation missing --]]
	--[[ L.SUBZONES["Silver Covenant Pavilion"] = ""--]] 
	L.SUBZONES["Sunreaver Pavilion"] = "Padiglione dei Predatori del Sole"
	L.SUBZONES["The Alliance Valiants' Ring"] = "Arena dei Valorosi dell'Alleanza"
	L.SUBZONES["The Argent Valiants' Ring"] = "Arena dei Valorosi d'Argento"
	L.SUBZONES["The Aspirants' Ring"] = "Arena degli Aspiranti"
	L.SUBZONES["The Assembly of Iron"] = "Adunanza del Ferro"
	L.SUBZONES["The Celestial Planetarium"] = "Planetario Celeste"
	L.SUBZONES["The Clash of Thunder"] = "Sala del Tuono"
	L.SUBZONES["The Colossal Forge"] = "Forgia Colossale"
	L.SUBZONES["The Conservatory of Life"] = "Serra della Vita"
	L.SUBZONES["The Descent into Madness"] = "Discesa nella Follia"
	L.SUBZONES["The Halls of Winter"] = "Sale dell'Inverno"
	L.SUBZONES["The Horde Valiants' Ring"] = "Arena dei Valorosi dell'Orda"
	--[[Translation missing --]]
	--[[ L.SUBZONES["The Observation Ring"] = ""--]] 
	L.SUBZONES["The Prison of Yogg-Saron"] = "Prigione di Yogg-Saron"
	L.SUBZONES["The Ring of Champions"] = "Arena dei Campioni"
	L.SUBZONES["The Scrapyard"] = "Cantiere di Demolizione"
	L.SUBZONES["The Shattered Walkway"] = "Passaggio Infranto"
	L.SUBZONES["The Spark of Imagination"] = "Scintilla dell'Immaginazione"



end
