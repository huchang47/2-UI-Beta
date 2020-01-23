﻿local _, ns = ...
local M, R, U, I = unpack(ns)
local S = M:RegisterModule("Skins")

function S:OnLogin()
	PlayerFrame:SetScale(MaoRUIDB["UFs"]["PlayerFrameScale"]) 
	TargetFrame:SetScale(MaoRUIDB["UFs"]["PlayerFrameScale"])

   ----BOTTOM
   if MaoRUIDB["Skins"]["InfobarLine"] then
   local Bottomline = CreateFrame("Frame", nil, UIParent) 
   Bottomline:SetFrameLevel(0) 
   Bottomline:SetFrameStrata("BACKGROUND")
   Bottomline:SetHeight(16)
   Bottomline:SetWidth(UIParent:GetWidth())
   Bottomline:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 0) 
   Bottomline:SetBackdrop({bgFile = "Interface\\AddOns\\_ShiGuang\\Media\\Modules\\line"}) 
   Bottomline:SetBackdropColor(I.r, I.g, I.b, 0.8)
   end
   
	-- Add Skins
	self:QuestTracker()
	self:QuestTrackerSkinTitle()
	self:PetBattleUI()
	self:DBMSkin()
	self:SkadaSkin()
	self:BigWigsSkin()
	self:LootEx()		-- 拾取增强
	-- Register skin
	local media = LibStub and LibStub("LibSharedMedia-3.0", true)
	if media then
		media:Register("statusbar", "normTex", I.normTex)
		media:Register("statusbar", "ShiGuang",		  [[Interface\Addons\_ShiGuang\Media\Modules\Raid\ColorBar]])
		media:Register("statusbar", "HalfStyle",		[[Interface\Addons\_ShiGuang\Media\Modules\Skada\YaSkada05]])
		media:Register("statusbar", "AtlzSkada",		[[Interface\Addons\_ShiGuang\Media\Modules\Skada\AtlzSkada]])
		media:Register("statusbar", "Yaskada",		  [[Interface\Addons\_ShiGuang\Media\Modules\Skada\Yaskada]])
		media:Register("statusbar", "Yaskada02",		[[Interface\Addons\_ShiGuang\Media\Modules\Skada\Yaskada02]])
		media:Register("statusbar", "Yaskada03",		[[Interface\Addons\_ShiGuang\Media\Modules\Skada\Yaskada03]])
		media:Register("statusbar", "Yaskada04",		[[Interface\Addons\_ShiGuang\Media\Modules\Skada\Yaskada04]])
		media:Register("statusbar", "Rainbow",			[[Interface\Addons\_ShiGuang\Media\Modules\Skada\Rainbow]])
		media:Register("statusbar", "None",		      [[Interface\Addons\_ShiGuang\Media\backdrop]])
		media:Register("font", "Vera Serif",			  [[Interface\Addons\_ShiGuang\Media\Fonts\Pixel.ttf]])
	end
	  local function noop() end
    local function DisableBlizzardFrame(frame)
	     frame.RegisterEvent = noop
	     frame.Show = noop
	     frame:UnregisterAllEvents()
	     frame:Hide()
    end
	if MaoRUIDB["Skins"]["CastBarstyle"] then --DisableBlizzardFrame(CastingBarFrame) 
	DisableBlizzardFrame(TargetFrameSpellBar) DisableBlizzardFrame(FocusFrameSpellBar) DisableBlizzardFrame(PetCastingBarFrame) return end
end

function S:GetToggleDirection()
	local direc = MaoRUIDB["Skins"]["ToggleDirection"]
	if direc == 1 then
		return ">", "<", "RIGHT", "LEFT", -2, 0, 20, 80
	elseif direc == 2 then
		return "<", ">", "LEFT", "RIGHT", 2, 0, 20, 80
	elseif direc == 3 then
		return "∨", "∧", "BOTTOM", "TOP", 0, 2, 80, 20
	else
		return "∧", "∨", "TOP", "BOTTOM", 0, -2, 80, 20
	end
end

local toggleFrames = {}

local function CreateToggleButton(parent)
	local bu = CreateFrame("Button", nil, parent)
	bu:SetSize(20, 80)
	bu.text = M.CreateFS(bu, 18, nil, true)
	--M.ReskinMenuButton(bu)

	return bu
end

function S:CreateToggle(frame)
	local close = CreateToggleButton(frame)
	frame.closeButton = close

	local open = CreateToggleButton(UIParent)
	open:Hide()
	frame.openButton = open

	open:SetScript("OnClick", function()
		open:Hide()
	end)
	close:SetScript("OnClick", function()
		open:Show()
	end)

	S:SetToggleDirection(frame)
	tinsert(toggleFrames, frame)

	return open, close
end

function S:SetToggleDirection(frame)
	local str1, str2, rel1, rel2, x, y, width, height = S:GetToggleDirection()
	local parent = frame.bg
	local close = frame.closeButton
	local open = frame.openButton
	close:ClearAllPoints()
	close:SetPoint(rel1, parent, rel2, x, y)
	close:SetSize(width, height)
	close.text:SetText(str1)
	open:ClearAllPoints()
	open:SetPoint(rel1, parent, rel1, -x, -y)
	open:SetSize(width, height)
	open.text:SetText(str2)
end

function S:RefreshToggleDirection()
	for _, frame in pairs(toggleFrames) do
		S:SetToggleDirection(frame)
	end
end

function S:LoadWithAddOn(addonName, value, func)
	local function loadFunc(event, addon)
		if not MaoRUIDB["Skins"][value] then return end

		if event == "PLAYER_ENTERING_WORLD" then
			M:UnregisterEvent(event, loadFunc)
			if IsAddOnLoaded(addonName) then
				func()
				M:UnregisterEvent("ADDON_LOADED", loadFunc)
			end
		elseif event == "ADDON_LOADED" and addon == addonName then
			func()
			M:UnregisterEvent(event, loadFunc)
		end
	end

	M:RegisterEvent("PLAYER_ENTERING_WORLD", loadFunc)
	M:RegisterEvent("ADDON_LOADED", loadFunc)
end
