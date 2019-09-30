﻿local _, ns = ...
local M, R, U, I = unpack(ns)
if not R.Infobar.Gold then return end

local module = M:GetModule("Infobar")
local info = module:RegisterInfobar("Gold", R.Infobar.GoldPos)

local format, pairs, wipe, unpack, floor = string.format, pairs, table.wipe, unpack, floor
local GOLD_AMOUNT_SYMBOL, CLASS_ICON_TCOORDS = GOLD_AMOUNT_SYMBOL, CLASS_ICON_TCOORDS
local GetMoney, GetMoneyString, GetNumWatchedTokens, GetBackpackCurrencyInfo, GetCurrencyInfo = GetMoney, GetMoneyString, GetNumWatchedTokens, GetBackpackCurrencyInfo, GetCurrencyInfo
local GetContainerNumSlots, GetContainerItemLink, GetItemInfo, GetContainerItemInfo, UseContainerItem = GetContainerNumSlots, GetContainerItemLink, GetItemInfo, GetContainerItemInfo, UseContainerItem
local C_Timer_After, IsControlKeyDown, IsShiftKeyDown = C_Timer.After, IsControlKeyDown, IsShiftKeyDown

local profit, spent, oldMoney = 0, 0, 0
local myName, myRealm = UnitName("player"), GetRealmName()

local function formatTextMoney(money)
	--return format("%.0f|cffffd700%s|r", money * .0001, GOLD_AMOUNT_SYMBOL)
	return format("%.0f", money * 0.0001)
end

local function getClassIcon(class)
	local c1, c2, c3, c4 = unpack(CLASS_ICON_TCOORDS[class])
	c1, c2, c3, c4 = (c1+.03)*50, (c2-.03)*50, (c3+.03)*50, (c4-.03)*50
	local classStr = "|TInterface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes:13:15:0:-1:50:50:"..c1..":"..c2..":"..c3..":"..c4.."|t "
	return classStr or ""
end

info.eventList = {
	"PLAYER_MONEY",
	"SEND_MAIL_MONEY_CHANGED",
	"SEND_MAIL_COD_CHANGED",
	"PLAYER_TRADE_MONEY",
	"TRADE_MONEY_CHANGED",
	"PLAYER_ENTERING_WORLD",
}

info.onEvent = function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		oldMoney = GetMoney()
		self:UnregisterEvent(event)
	end

	local newMoney = GetMoney()
	local change = newMoney - oldMoney	-- Positive if we gain money
	if oldMoney > newMoney then			-- Lost Money
		spent = spent - change
	else								-- Gained Moeny
		profit = profit + change
	end
	self.text:SetText(formatTextMoney(newMoney))

	if not MaoRUIDB["totalGold"][myRealm] then MaoRUIDB["totalGold"][myRealm] = {} end
	MaoRUIDB["totalGold"][myRealm][myName] = {GetMoney(), I.MyClass}

	oldMoney = newMoney
end

StaticPopupDialogs["RESETGOLD"] = {
	text = U["Are you sure to reset the gold count?"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		wipe(MaoRUIDB["totalGold"][myRealm])
		MaoRUIDB["totalGold"][myRealm][myName] = {GetMoney(), I.MyClass}
	end,
	whileDead = 1,
}

info.onMouseUp = function(self, btn)
	if IsControlKeyDown() then
		MaoRUIDB["AutoSell"] = not MaoRUIDB["AutoSell"]
		self:GetScript("OnEnter")
	elseif btn == "RightButton" then
		StaticPopup_Show("RESETGOLD")
	else
		if InCombatLockdown() then UIErrorsFrame:AddMessage(I.InfoColor..ERR_NOT_IN_COMBAT) return end
		ToggleCharacter("TokenFrame")
	end
end

local function getGoldString(number)
	local money = format("%.0f", number/1e4)
	return GetMoneyString(money*1e4)
end

info.onEnter = function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 6)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(CURRENCY, 0,.6,1)
	GameTooltip:AddLine(" ")

	GameTooltip:AddLine(U["Session"], .6,.8,1)
	GameTooltip:AddDoubleLine(U["Earned"], GetMoneyString(profit), 1,1,1, 1,1,1)
	GameTooltip:AddDoubleLine(U["Spent"], GetMoneyString(spent), 1,1,1, 1,1,1)
	if profit < spent then
		GameTooltip:AddDoubleLine(U["Deficit"], GetMoneyString(spent-profit), 1,0,0, 1,1,1)
	elseif profit > spent then
		GameTooltip:AddDoubleLine(U["Profit"], GetMoneyString(profit-spent), 0,1,0, 1,1,1)
	end
	GameTooltip:AddLine(" ")

	local totalGold = 0
	GameTooltip:AddLine(U["Character"], .6,.8,1)
	local thisRealmList = MaoRUIDB["totalGold"][myRealm]
	for k, v in pairs(thisRealmList) do
		local gold, class = unpack(v)
		local r, g, b = M.ClassColor(class)
		GameTooltip:AddDoubleLine(getClassIcon(class)..k, getGoldString(gold), r,g,b, 1,1,1)
		totalGold = totalGold + gold
	end
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(TOTAL..":", getGoldString(totalGold), .6,.8,1, 1,1,1)

	for i = 1, GetNumWatchedTokens() do
		local name, count, icon, currencyID = GetBackpackCurrencyInfo(i)
		if name and i == 1 then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(CURRENCY..":", .6,.8,1)
		end
		if name and count then
			local _, _, _, _, _, total = GetCurrencyInfo(currencyID)
			local iconTexture = " |T"..icon..":13:15:0:0:50:50:4:46:4:46|t"
			if total > 0 then
				GameTooltip:AddDoubleLine(name, count.."/"..total..iconTexture, 1,1,1, 1,1,1)
			else
				GameTooltip:AddDoubleLine(name, count..iconTexture, 1,1,1, 1,1,1)
			end
		end
	end
  GameTooltip:AddDoubleLine(" ","--------------",1,1,1,0.5,0.5,0.5)
	GameTooltip:AddDoubleLine(" ",U["AutoSell Junk"]..": "..(MaoRUIDB["AutoSell"] and "|cff55ff55"..VIDEO_OPTIONS_ENABLED or "|cffff5555"..VIDEO_OPTIONS_DISABLED),1,1,1,.6,.8,1)
	GameTooltip:Show()
end

info.onLeave = M.HideTooltip

-- Auto selljunk
local sellCount, stop, cache = 0, true, {}
local errorText = _G.ERR_VENDOR_DOESNT_BUY

local function stopSelling(tell)
	stop = true
	if sellCount > 0 and tell then
		print(format("|cff99CCFF%s|r %s", U["Selljunk Calculate"], GetMoneyString(sellCount)))
	end
	sellCount = 0
end

local function startSelling()
	if stop then return end
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			if stop then return end
			local link = GetContainerItemLink(bag, slot)
			if link then
				local price = select(11, GetItemInfo(link))
				local _, count, _, quality = GetContainerItemInfo(bag, slot)
				if quality == 0 and price > 0 and not cache["b"..bag.."s"..slot] then
					sellCount = sellCount + price*count
					cache["b"..bag.."s"..slot] = true
					UseContainerItem(bag, slot)
					--C_Timer_After(.2, startSelling)
					startSelling()
					return
				end
			end
		end
	end
end

local function updateSelling(event, ...)
	if not MaoRUIDB["AutoSell"] then return end

	local _, arg = ...
	if event == "MERCHANT_SHOW" then
		if IsShiftKeyDown() then return end
		stop = false
		wipe(cache)
		startSelling()
		M:RegisterEvent("UI_ERROR_MESSAGE", updateSelling)
	elseif event == "UI_ERROR_MESSAGE" and arg == errorText then
		stopSelling(false)
	elseif event == "MERCHANT_CLOSED" then
		stopSelling(true)
	end
end
M:RegisterEvent("MERCHANT_SHOW", updateSelling)
M:RegisterEvent("MERCHANT_CLOSED", updateSelling)