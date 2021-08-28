
local L, locale = OVERACHIEVER_STRINGS, GetLocale()

L.TRADE_SKILLET_ACHSORT = "By Achievement";

if (locale == "enUS" or locale == "enGB") then  -- English
	-- !! NOTE: L.TRADE_COOKING_OBJRENAME IS DEPRECATED. DO NOT USE.
	--If an achievement's criteria list gives an incorrect name for an item to be cooked, correct it with
	--the string L.TRADE_COOKING_OBJRENAME using the format "<incorrect name>=<correct name>" (without
	--quotes), separating different items with a carriage return. Example usage (commented out because
	--it's no longer needed for English clients):
	--L.TRADE_COOKING_OBJRENAME = [[
--Rhinolicious Wyrmsteak=Rhinolicious Wormsteak
--Spiced Wyrm Burger=Spiced Worm Burger
--Wyrm Delight=Worm Delight
--]]

elseif (locale == "deDE") then  -- German
-- Trade
L["TRADE_COOKING_OBJRENAME"] = [=[Rhinoziöses Wyrmsteak=Rhinoziöses Wurmsteak
Würziger Wyrmburger=Würziger Wurmburger
Wyrmfrikadellen=Wurmfrikadellen
]=]
L["TRADE_SKILLET_ACHSORT"] = "Nach Erfolg"



elseif (locale == "frFR") then  -- French
-- Trade
L["TRADE_COOKING_OBJRENAME"] = [=[Steak de wyrm épicé=Steak de ver épicé
Steak de wyrm rhinolicieux=Steak de ver rhinolicieux
]=]
L["TRADE_SKILLET_ACHSORT"] = "Par haut fait"



elseif (locale == "zhTW") then  -- Traditional Chinese
-- Trade
L["TRADE_COOKING_OBJRENAME"] = [=[
犀蟲雜肉排=犀味蟲排
辣味巨蟲堡=辣味蟲蟲堡
蟲蟲點心=巨蟲點心
]=]
L["TRADE_SKILLET_ACHSORT"] = "的成就"



elseif (locale == "zhCN") then  -- Simplified Chinese
-- Trade
L["TRADE_COOKING_OBJRENAME"] = "交易"
L["TRADE_SKILLET_ACHSORT"] = "的成就"



elseif (locale == "ruRU") then  -- Russian
-- Trade
L["TRADE_COOKING_OBJRENAME"] = "Используйте это в кулинарной задаче которая дала неверное имя в списке достижений. Используйте формат \"<неправильное имя>=<правильное название вещи>\"."
L["TRADE_SKILLET_ACHSORT"] = "относится к достижению"



elseif (locale == "koKR") then  -- Korean
-- Trade
L["TRADE_COOKING_OBJRENAME"] = [=[매콤한 고룡 햄버거=매콤한 벌레 햄버거
업적 기준 목록에서 잘못된 업적 이름을 수정합니다. "<잘못된 이름>=<올바른 이름>" 형식으로 사용할 수 있습니다. 수정해야 할 아이템이 여러 개라면 여러 줄에 걸쳐 적으면 됩니다.]=]
L["TRADE_SKILLET_ACHSORT"] = "업적 순"



elseif (locale == "esES" or locale == "esMX") then  -- Spanish
-- Trade
L["TRADE_COOKING_OBJRENAME"] = "Hamburguesa de vermis especiada=Hamburguesa de gusano especiada"
L["TRADE_SKILLET_ACHSORT"] = "Por logro"



	if (locale == "esMX") then  -- Spanish (Mexican)
-- Trade
--[[Translation missing --]]
--[[ L["TRADE_COOKING_OBJRENAME"] = ""--]] 
--[[Translation missing --]]
--[[ L["TRADE_SKILLET_ACHSORT"] = ""--]] 


	end

elseif (locale == "ptBR") then  -- Brazilian Portuguese
-- Trade
L["TRADE_COOKING_OBJRENAME"] = [=[<Sopa Névoa Rodopiante>=<Sopa Névoa Rodopiante>
<Sopa Névoa Rodopiante>=<Sopa de Névoa Rodopiante>]=]
L["TRADE_SKILLET_ACHSORT"] = "Por Conquista"



elseif (locale == "itIT") then  -- Italian
-- Trade
--[[Translation missing --]]
--[[ L["TRADE_COOKING_OBJRENAME"] = ""--]] 
L["TRADE_SKILLET_ACHSORT"] = "Per Impresa"



end
