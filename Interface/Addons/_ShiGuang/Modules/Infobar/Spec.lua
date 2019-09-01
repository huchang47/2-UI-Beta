﻿local _, ns = ...
local M, R, U, I = unpack(ns)
if not R.Infobar.Spec then return end

local module = M:GetModule("Infobar")
local info = module:RegisterInfobar("Spec", R.Infobar.SpecPos)
info.text:SetFont(unpack(R.Infobar.TTFonts))
local format, wipe, select, next = string.format, table.wipe, select, next
local SPECIALIZATION, TALENTS_BUTTON, MAX_TALENT_TIERS = SPECIALIZATION, TALENTS_BUTTON, MAX_TALENT_TIERS
local SHOW_PVP_TALENT_LEVEL, PVP_TALENTS, LOOT_SPECIALIZATION_DEFAULT = SHOW_PVP_TALENT_LEVEL, PVP_TALENTS, LOOT_SPECIALIZATION_DEFAULT
local GetSpecialization, GetSpecializationInfo, GetLootSpecialization, GetSpecializationInfoByID = GetSpecialization, GetSpecializationInfo, GetLootSpecialization, GetSpecializationInfoByID
local GetTalentInfo, UnitLevel, GetCurrencyInfo, GetPvpTalentInfoByID, SetLootSpecialization, SetSpecialization = GetTalentInfo, UnitLevel, GetCurrencyInfo, GetPvpTalentInfoByID, SetLootSpecialization, SetSpecialization
local C_SpecializationInfo_GetAllSelectedPvpTalentIDs = C_SpecializationInfo.GetAllSelectedPvpTalentIDs

local function addIcon(texture)
	texture = texture and "|T"..texture..":13:15:0:0:50:50:4:46:4:46|t" or ""
	return texture
end

--local menuFrame = CreateFrame("Frame", "SpecInfobarMenu", info, "UIDropDownMenuTemplate")
local menuFrame = MSA_DropDownMenu_Create("SpecInfobarMenu", info)
local menuList = {
	{text = CHOOSE_SPECIALIZATION, isTitle = true, notCheckable = true},
	{text = SPECIALIZATION, hasArrow = true, notCheckable = true},
	{text = SELECT_LOOT_SPECIALIZATION, hasArrow = true, notCheckable = true},
}

info.eventList = {
	"PLAYER_ENTERING_WORLD",
	"ACTIVE_TALENT_GROUP_CHANGED",
	"PLAYER_LOOT_SPEC_UPDATED",
}

info.onEvent = function(self)
	if GetSpecialization() then
		local _, name, _, icon = GetSpecializationInfo(GetSpecialization())
		if not name then return end
		local specID = GetLootSpecialization()
		if specID == 0 then
			icon = addIcon(icon)
		else
			icon = addIcon(select(4, GetSpecializationInfoByID(specID)))
		end
		self.text:SetText(I.MyColor..icon)  --I.MyColor..name..icon
	else
		self.text:SetText(SPECIALIZATION..": "..I.MyColor..NONE)
	end
end

--[[local pvpTalents
info.onEnter = function(self)
	if not GetSpecialization() then return end
	GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 15)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(TALENTS_BUTTON, 0,.6,1)
	GameTooltip:AddLine(" ")

	local _, specName, _, specIcon = GetSpecializationInfo(GetSpecialization())
	GameTooltip:AddLine(addIcon(specIcon).." "..specName, .6,.8,1)

	for t = 1, MAX_TALENT_TIERS do
		for c = 1, 3 do
			local _, name, icon, selected = GetTalentInfo(t, c, 1)
			if selected then
				GameTooltip:AddLine(addIcon(icon).." "..name, 1,1,1)
			end
		end
	end

	if UnitLevel("player") >= SHOW_PVP_TALENT_LEVEL then
		pvpTalents = C_SpecializationInfo_GetAllSelectedPvpTalentIDs()

		if #pvpTalents > 0 then
			local texture = select(3, GetCurrencyInfo(104))
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(addIcon(texture).." "..PVP_TALENTS, .6,.8,1)
			for _, talentID in next, pvpTalents do
				local _, name, icon, _, _, _, unlocked = GetPvpTalentInfoByID(talentID)
				if name and unlocked then
					GameTooltip:AddLine(addIcon(icon).." "..name, 1,1,1)
				end
			end
		end

		wipe(pvpTalents)
	end

	GameTooltip:AddDoubleLine(" ", I.LineString)
	GameTooltip:AddDoubleLine(" ", I.LeftButton.."SpecPanel".." ", 1,1,1, .6,.8,1)
	GameTooltip:AddDoubleLine(" ", I.RightButton.."Change Spec".." ", 1,1,1, .6,.8,1)
	GameTooltip:Show()
end

info.onLeave = M.HideTooltip]]

local function clickFunc(i, isLoot)
	if not i then return end
	if isLoot then
		SetLootSpecialization(i)
	else
		SetSpecialization(i)
	end
	MSA_DropDownList1:Hide()
end

info.onMouseUp = function(self, btn)
	if not GetSpecialization() then return end
		menuList[2].menuList = {{}, {}, {}, {}}
		menuList[3].menuList = {{}, {}, {}, {}, {}}
		local specList, lootList = menuList[2].menuList, menuList[3].menuList
		local spec, specName = GetSpecializationInfo(GetSpecialization())
		local lootSpec = GetLootSpecialization()
		lootList[1] = {text = format(LOOT_SPECIALIZATION_DEFAULT, specName), func = function() clickFunc(0, true) end, checked = lootSpec == 0 and true or false}

		for i = 1, 4 do
			local id, name = GetSpecializationInfo(i)
			if id then
				specList[i].text = name
				if id == spec then
					specList[i].func = function() clickFunc() end
					specList[i].checked = true
				else
					specList[i].func = function() clickFunc(i) end
					specList[i].checked = false
				end
				lootList[i+1] = {text = name, func = function() clickFunc(id, true) end, checked = id == lootSpec and true or false}
			else
				specList[i] = nil
				lootList[i+1] = nil
			end
		end

		EasyMenu(menuList, menuFrame, self, -80, 100, "MENU", 1)
		GameTooltip:Hide()
end