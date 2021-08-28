
--[[
-------------------------------------------------------------------------------------------------------------------------------------------

TjBagWatch.lua
  by Tuhljin

An easy way to get useful notifications about what has changed in the player's bags. Notifications aren't sent when items are moved around,
only when they are lost or gained. (Items turning into other items count as "losing" the old item(s) and "gaining" the new one(s).) In
addition to the backpack and equipped bags, the the bank (including bank bags) are checked when applicable. (Equipped items are not checked.)

Note that battlepets in bags are ignored: No notifications indicating a new or lost "battlepet item" will be sent. This only applies to proper
battlepet items, not "normal" items that give you a battlepet when used. (You can tell a proper battlepet item by its special tooltip which
gives actual battlepet stats.)

TjBagWatch.RegisterFunc( func[, multiItem] )
  func		A function to be called when bag contents change. Note that multiple firings of the BAG_UPDATE event at essentially the same time
			are consolidated into a single call (or a single call per itemID that changed in count depending on the value used for the
			multiItem parameter) to registered functions.

			If the function was already registered, it is not "registered twice" - it will be called just as many times as it would have been
			were RegisterFunc called only once for that function. However, you can change a function registered as "multi-item" into a
			non-multi-item registration or vice versa by calling RegisterFunc again by using a different value for the multiItem parameter).

  multiItem	Registered functions are called in one of two ways. If multiItem is omitted or it evaluates to false, then the function is called
			in the following manner once per each item that was changed:
				func( itemID, oldCount, newCount )
			If multiItem evaluates to true, it is instead called in this manner:
				func( itemID1, oldCount1, newCount1 [, itemID2, oldCount2, newCount2 [, ...
					  itemIDX, oldCountX, newCountX ] ] )
			The itemID arguments give the item's ID while the oldCount and newCount arguments give the old number of that item in the
			inventory and the new number, respectively. For items that stack, the numbers from each stack are added together to give the
			count.

TjBagWatch.UnregisterFunc( func )
  func		A previously registered function that is no longer to be called by TjBagWatch.


-------------------------------------------------------------------------------------------------------------------------------------------
--]]


local THIS_VERSION = 0.09

if (TjBagWatch and TjBagWatch.Version >= THIS_VERSION) then  return;  end

TjBagWatch = TjBagWatch or {}
local TjBagWatch = TjBagWatch
TjBagWatch.Version = THIS_VERSION

TjBagWatch.regfunc = TjBagWatch.regfunc or {}
local regfunc = TjBagWatch.regfunc
TjBagWatch.regfunc_multiItem = TjBagWatch.regfunc_multiItem or {}
local regfunc_multiItem = TjBagWatch.regfunc_multiItem
TjBagWatch.ItemCount = TjBagWatch.ItemCount or {}
local ItemCount = TjBagWatch.ItemCount
TjBagWatch.ItemCount_InBag = TjBagWatch.ItemCount_InBag or {}
local ItemCount_InBag = TjBagWatch.ItemCount_InBag
TjBagWatch.NeedRecount = TjBagWatch.NeedRecount or {}
local NeedRecount = TjBagWatch.NeedRecount

TjBagWatch.regfunc_multiItem_num = TjBagWatch.regfunc_multiItem_num or 0

local tonumber = tonumber
local GetContainerNumSlots = GetContainerNumSlots
local GetContainerItemInfo = GetContainerItemInfo

local frame = TjBagWatch.frame
if (not frame) then
  frame = CreateFrame("Frame")
  TjBagWatch.frame = frame
  frame:Hide()
end

local UpdateCount
do
  --local prevcount
  local changes

  local function getCountFromBag(bagID)
    local tab, prev
    if (ItemCount_InBag[bagID]) then
      --[[
      prev = wipe(prevcount)
      tab = ItemCount_InBag[bagID]
      for k,v in pairs(tab) do  prev[k] = v;  end
      wipe(tab)
      --]]
      -- Not CPU efficient to wipe. Do it a different way:
      prev = ItemCount_InBag[bagID]
      tab = {}
      ItemCount_InBag[bagID] = tab
    else
      tab = {}
      ItemCount_InBag[bagID] = tab
    end

    -- Tally up number of items currently in the bag:
    local _, num, link, itemID, total
    for i=1,GetContainerNumSlots(bagID) do
      _, num, _, _, _, _, link = GetContainerItemInfo(bagID, i)
      if (link) then
        _, _, itemID = strfind(link, "item:(%d+)")
        itemID = tonumber(itemID)
        if (itemID) then  -- Ignores special objects not classified as normal items, like battlepets
          tab[itemID] = (tab[itemID] or 0) + num
        end
      end
    end
    -- Compare to number of these items previously in the bag:
    for itemID, num in pairs(tab) do
      total = (ItemCount[itemID] or 0) + num - (prev and prev[itemID] or 0)
		--if (itemID == 52183) then  print(ItemCount[itemID] or 0, '+', num, '-', prev and prev[itemID] or 0, '=', total);  end
      if (total == 0) then  total = nil;  end
      if (ItemCount[itemID] ~= total) then
        --print(bagID,select(2,GetItemInfo(itemID)) .. ' (' .. itemID .. ')',num,"total:",total) --Note that total here may be off if you're moving things between bags. It should be updated to be accurate later, though. Right?
        if (prev) then  changes[itemID] = (changes[itemID] or 0) + (total or 0) - (ItemCount[itemID] or 0);  end
        ItemCount[itemID] = total
      end
    end
    if (prev) then
    -- Account for items previously in the bag that now have a count of zero:
      for itemID, num in pairs(prev) do
        if (not tab[itemID]) then
          ItemCount[itemID] = (ItemCount[itemID] or 0) - num
          if (ItemCount[itemID] == 0) then  ItemCount[itemID] = nil;  end
          changes[itemID] = (changes[itemID] or 0) - num
        end
        --if (itemID == 52183) then  print("there", changes[itemID], ItemCount[itemID]);  end
      end
    end
  end

  function UpdateCount()
    --prevcount = prevcount or {}
    changes = {} --changes and wipe(changes) or {}
    --[[
    if (countAll) then
      getCountFromBag(BACKPACK_CONTAINER)
      for i=1,NUM_BAG_SLOTS do  getCountFromBag(i);  end
      getCountFromBag(KEYRING_CONTAINER)
      if (BankFrame:IsVisible()) then
        getCountFromBag(BANK_CONTAINER)
        for i=NUM_BAG_SLOTS + 1,NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do  getCountFromBag(i);  end
      end
    else
    --]]
    for bagID in pairs(NeedRecount) do
      getCountFromBag(bagID)
      NeedRecount[bagID] = nil
    end
    --end

    --return changes, (TjBagWatch.regfunc_multiItem_num > 0) and wipe(prevcount)
    return changes, (TjBagWatch.regfunc_multiItem_num > 0) and {}
  end
end

local timerActive = false

local function doUpdate()
  timerActive = nil
  local changes, tab = UpdateCount()
  local i, num = 1
  for itemID, diff in pairs(changes) do
    if (diff ~= 0) then
      num = ItemCount[itemID] or 0
      for func in pairs(regfunc) do  func(itemID, num - diff, num);  end
      if (tab) then
        tab[i], tab[i+1], tab[i+2] = itemID, num - diff, num
        i = i + 3
      end
    end
  end
  if (i > 1) then
    for func in pairs(regfunc_multiItem) do  func( unpack(tab) );  end
  end
end

local function queueUpdate()
  if (timerActive == nil) then
    C_Timer.After(0, doUpdate)
    timerActive = true
  elseif (not timerActive) then
    timerActive = 1
  end
end

frame:SetScript("OnEvent", function(self, event, arg1)
  if (event == "BAG_UPDATE") then
    if (not TjBagWatch.AllowBankCheck and (arg1 == BANK_CONTAINER or arg1 > NUM_BAG_SLOTS)) then
      return;  -- If this is a bank bag but we haven't been at the bank this session, ignore it.
    end
    NeedRecount[arg1] = true
  elseif (event == "PLAYERBANKSLOTS_CHANGED") then
    NeedRecount[BANK_CONTAINER] = true
  elseif (event == "BANKFRAME_OPENED") then
    frame:UnregisterEvent("BANKFRAME_OPENED")
    TjBagWatch.AllowBankCheck = true
    -- Scan the bank when it is visited for the first time:
    NeedRecount[BANK_CONTAINER] = true
    for i=NUM_BAG_SLOTS + 1,NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do  NeedRecount[i] = true;  end
  elseif (event == "PLAYER_ENTERING_WORLD") then
    frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
    -- Allow updates:
    if (timerActive == 1) then
      timerActive = nil
      queueUpdate()
    else
      timerActive = nil
    end
    return;
  end
  queueUpdate()
end)

function TjBagWatch.UnregisterFunc( func )
  if (func) then
    if (regfunc_multiItem[func]) then
      regfunc_multiItem[func] = nil
      TjBagWatch.regfunc_multiItem_num = TjBagWatch.regfunc_multiItem_num - 1
    else
      regfunc[func] = nil
    end
  end
end

local UpdateCount_ran
TjBagWatch.RegisterFunc = function(func, multiItem)
  assert(type(func) == "function", "Usage: TjBagWatch.RegisterFunc( function )")
  if (not UpdateCount_ran) then
    UpdateCount_ran = true
    frame:RegisterEvent("BAG_UPDATE")
    frame:RegisterEvent("PLAYERBANKSLOTS_CHANGED")

    NeedRecount[BACKPACK_CONTAINER] = true
    for i=1,NUM_BAG_SLOTS do  NeedRecount[i] = true;  end
    --Keyrings are no longer a thing --NeedRecount[KEYRING_CONTAINER] = true
    if (BankFrame:IsVisible()) then
      NeedRecount[BANK_CONTAINER] = true
      for i=NUM_BAG_SLOTS + 1,NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do  NeedRecount[i] = true;  end
      TjBagWatch.AllowBankCheck = true
    else
      frame:RegisterEvent("BANKFRAME_OPENED")
    end
    queueUpdate()
  end

  if (multiItem) then
    if (not regfunc_multiItem[func]) then
      regfunc[func] = nil
      regfunc_multiItem[func] = true
      TjBagWatch.regfunc_multiItem_num = TjBagWatch.regfunc_multiItem_num + 1
    end
  else
    regfunc[func] = true
    if (regfunc_multiItem[func]) then
      regfunc_multiItem[func] = nil
      TjBagWatch.regfunc_multiItem_num = TjBagWatch.regfunc_multiItem_num - 1
    end
  end
end

frame:RegisterEvent("PLAYER_ENTERING_WORLD")


--[[
function TjBagWatch.TEST()
TjBagWatch.RegisterFunc( function(itemID, old, new)
  local _, link = GetItemInfo(itemID)
  print(">|cff00ffff", link, old, new)
end)

TjBagWatch.RegisterFunc( function(...)
  local itemID, old, new, _, link
  local msg = ""
  for i=1,select("#", ...),3 do
    itemID, old, new = select(i, ...)
    _, link = GetItemInfo(itemID)
    msg = msg.."* "..link..", "..old..", "..new.." "
  end
  print(msg)
end, true )
end
--]]
