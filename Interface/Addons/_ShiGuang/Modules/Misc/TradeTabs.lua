local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

local pairs, unpack, tinsert, select = pairs, unpack, tinsert, select
local GetSpellCooldown, GetSpellInfo, GetItemCooldown, GetItemCount, GetItemInfo = GetSpellCooldown, GetSpellInfo, GetItemCooldown, GetItemCount, GetItemInfo
local IsPassiveSpell, IsCurrentSpell, IsPlayerSpell, UseItemByName = IsPassiveSpell, IsCurrentSpell, IsPlayerSpell, UseItemByName
local GetProfessions, GetProfessionInfo, GetSpellBookItemInfo = GetProfessions, GetProfessionInfo, GetSpellBookItemInfo
local PlayerHasToy, C_ToyBox_IsToyUsable, C_ToyBox_GetToyInfo = PlayerHasToy, C_ToyBox.IsToyUsable, C_ToyBox.GetToyInfo
local C_TradeSkillUI_GetRecipeInfo, C_TradeSkillUI_GetTradeSkillLine = C_TradeSkillUI.GetRecipeInfo, C_TradeSkillUI.GetTradeSkillLine
local C_TradeSkillUI_GetOnlyShowSkillUpRecipes, C_TradeSkillUI_SetOnlyShowSkillUpRecipes = C_TradeSkillUI.GetOnlyShowSkillUpRecipes, C_TradeSkillUI.SetOnlyShowSkillUpRecipes
local C_TradeSkillUI_GetOnlyShowMakeableRecipes, C_TradeSkillUI_SetOnlyShowMakeableRecipes = C_TradeSkillUI.GetOnlyShowMakeableRecipes, C_TradeSkillUI.SetOnlyShowMakeableRecipes

local BOOKTYPE_PROFESSION = BOOKTYPE_PROFESSION
local RUNEFORGING_ID = 53428
local PICK_LOCK = 1804
local CHEF_HAT = 134020
local THERMAL_ANVIL = 87216
local ENCHANTING_VELLUM = 38682
local tabList = {}

local onlyPrimary = {
	[171] = true, -- Alchemy
	[202] = true, -- Engineering
	[182] = true, -- Herbalism
	[393] = true, -- Skinning
	[356] = true, -- Fishing
}

function MISC:UpdateProfessions()
	local prof1, prof2, _, fish, cook = GetProfessions()
	local profs = {prof1, prof2, fish, cook}

	if I.MyClass == "DEATHKNIGHT" then
		MISC:TradeTabs_Create(RUNEFORGING_ID)
	elseif I.MyClass == "ROGUE" and IsPlayerSpell(PICK_LOCK) then
		MISC:TradeTabs_Create(PICK_LOCK)
	end

	local isCook
	for _, prof in pairs(profs) do
		local _, _, _, _, numSpells, spelloffset, skillLine = GetProfessionInfo(prof)
		if skillLine == 185 then isCook = true end

		numSpells = onlyPrimary[skillLine] and 1 or numSpells
		if numSpells > 0 then
			for i = 1, numSpells do
				local slotID = i + spelloffset
				if not IsPassiveSpell(slotID, BOOKTYPE_PROFESSION) then
					local spellID = select(2, GetSpellBookItemInfo(slotID, BOOKTYPE_PROFESSION))
					if i == 1 then
						MISC:TradeTabs_Create(spellID)
					else
						MISC:TradeTabs_Create(spellID)
					end
				end
			end
		end
	end

	if isCook and PlayerHasToy(CHEF_HAT) and C_ToyBox_IsToyUsable(CHEF_HAT) then
		MISC:TradeTabs_Create(nil, CHEF_HAT)
	end
	if GetItemCount(THERMAL_ANVIL) > 0 then
		MISC:TradeTabs_Create(nil, nil, THERMAL_ANVIL)
	end
end

function MISC:TradeTabs_Update()
	for _, tab in pairs(tabList) do
		local spellID = tab.spellID
		local itemID = tab.itemID

		if IsCurrentSpell(spellID) then
			tab:SetChecked(true)
			tab.cover:Show()
		else
			tab:SetChecked(false)
			tab.cover:Hide()
		end

		local start, duration
		if itemID then
			start, duration = GetItemCooldown(itemID)
		else
			start, duration = GetSpellCooldown(spellID)
		end
		if start and duration and duration > 1.5 then
			tab.CD:SetCooldown(start, duration)
		end
	end
end

local index = 1
function MISC:TradeTabs_Create(spellID, toyID, itemID)
	local name, _, texture
	if toyID then
		_, name, texture = C_ToyBox_GetToyInfo(toyID)
	elseif itemID then
		name, _, _, _, _, _, _, _, _, texture = GetItemInfo(itemID)
	else
		name, _, texture = GetSpellInfo(spellID)
	end
	if not name then return end -- precaution

	local parent = I.isNewPatch and ProfessionsFrame or TradeSkillFrame

	local tab = CreateFrame("CheckButton", nil, parent, "SpellBookSkillLineTabTemplate, SecureActionButtonTemplate")
	tab.tooltip = name
	tab.spellID = spellID
	tab.itemID = toyID or itemID
	tab.type = (toyID and "toy") or (itemID and "item") or "spell"
	tab:RegisterForClicks("AnyDown")
	if spellID == 818 then -- cooking fire
		tab:SetAttribute("type", "macro")
		tab:SetAttribute("macrotext", "/cast [@player]"..name)
	else
		tab:SetAttribute("type", tab.type)
		tab:SetAttribute(tab.type, spellID or name)
	end
	tab:SetNormalTexture(texture)
	tab:GetHighlightTexture():SetColorTexture(1, 1, 1, .25)
	tab:Show()

	tab.CD = CreateFrame("Cooldown", nil, tab, "CooldownFrameTemplate")
	tab.CD:SetAllPoints()

	tab.cover = CreateFrame("Frame", nil, tab)
	tab.cover:SetAllPoints()
	tab.cover:EnableMouse(true)

	tab:SetPoint("TOPLEFT", parent, "TOPRIGHT", 3, -index*42)
	tinsert(tabList, tab)
	index = index + 1
end

function MISC:TradeTabs_FilterIcons()
	local buttonList = {
		[1] = {"Atlas:bags-greenarrow", TRADESKILL_FILTER_HAS_SKILL_UP, C_TradeSkillUI_GetOnlyShowSkillUpRecipes, C_TradeSkillUI_SetOnlyShowSkillUpRecipes},
		[2] = {"Interface\\RAIDFRAME\\ReadyCheck-Ready", CRAFT_IS_MAKEABLE, C_TradeSkillUI_GetOnlyShowMakeableRecipes, C_TradeSkillUI_SetOnlyShowMakeableRecipes},
	}

	local function filterClick(self)
		local value = self.__value
		if value[3]() then
			value[4](false)
			M.SetBorderColor(self.bg)
		else
			value[4](true)
			self.bg:SetBackdropBorderColor(1, .8, 0)
		end
	end

	local parent = I.isNewPatch and ProfessionsFrame.CraftingPage or TradeSkillFrame

	local buttons = {}
	for index, value in pairs(buttonList) do
		local bu = CreateFrame("Button", nil, parent, "BackdropTemplate")
		bu:SetSize(22, 22)
		if I.isNewPatch then
			bu:SetPoint("BOTTOMRIGHT", ProfessionsFrame.CraftingPage.RecipeList.FilterButton, "TOPRIGHT", -(index-1)*27, 10)
		else
			bu:SetPoint("RIGHT", TradeSkillFrame.FilterButton, "LEFT", -5 - (index-1)*27, 0)
		end
		M.PixelIcon(bu, value[1], true)
		M.AddTooltip(bu, "ANCHOR_TOP", value[2])
		bu.__value = value
		bu:SetScript("OnClick", filterClick)

		buttons[index] = bu
	end

	local function updateFilterStatus()
		for index, value in pairs(buttonList) do
			if value[3]() then
				buttons[index].bg:SetBackdropBorderColor(1, .8, 0)
			else
				M.SetBorderColor(buttons[index].bg)
			end
		end
	end
	M:RegisterEvent("TRADE_SKILL_LIST_UPDATE", updateFilterStatus)
end

local init
function MISC:TradeTabs_OnLoad()
	init = true

	MISC:UpdateProfessions()

	MISC:TradeTabs_Update()
	M:RegisterEvent("TRADE_SKILL_SHOW", MISC.TradeTabs_Update)
	M:RegisterEvent("TRADE_SKILL_CLOSE", MISC.TradeTabs_Update)
	M:RegisterEvent("CURRENT_SPELL_CAST_CHANGED", MISC.TradeTabs_Update)
	MISC:TradeTabs_FilterIcons()
	MISC:TradeTabs_QuickEnchanting()

	M:UnregisterEvent("PLAYER_REGEN_ENABLED", MISC.TradeTabs_OnLoad)
end

local isEnchanting
local tooltipString = "|cffffffff%s(%d)"
local function IsRecipeEnchanting(self)
	isEnchanting = nil

	local recipeID = self.selectedRecipeID
	local recipeInfo = recipeID and C_TradeSkillUI_GetRecipeInfo(recipeID)
	if recipeInfo and recipeInfo.alternateVerb then
		local parentSkillLineID = select(6, C_TradeSkillUI_GetTradeSkillLine())
		if parentSkillLineID == 333 then
			isEnchanting = true
			self.CreateButton.tooltip = format(tooltipString, U["UseVellum"], GetItemCount(ENCHANTING_VELLUM))
		end
	end
end

function MISC:TradeTabs_QuickEnchanting()
	if I.isNewPatch then
		if ProfessionsFrame.CraftingPage.ValidateControls then
			hooksecurefunc(ProfessionsFrame.CraftingPage, "ValidateControls", function(self)
				isEnchanting = nil
				local currentRecipeInfo = self.SchematicForm:GetRecipeInfo()
				if currentRecipeInfo and currentRecipeInfo.alternateVerb then
					local professionInfo = ProfessionsFrame:GetProfessionInfo()
					if professionInfo and professionInfo.parentProfessionID == 333 then
						isEnchanting = true
						self.CreateButton.tooltipText = format(tooltipString, U["UseVellum"], GetItemCount(ENCHANTING_VELLUM))
					end
				end
			end)
		end
	
		local createButton = ProfessionsFrame.CraftingPage.CreateButton
		createButton:RegisterForClicks("AnyUp")
		createButton:HookScript("OnClick", function(_, btn)
			if btn == "RightButton" and isEnchanting then
				UseItemByName(ENCHANTING_VELLUM)
			end
		end)
	else
		if not TradeSkillFrame then return end
	
		local detailsFrame = TradeSkillFrame.DetailsFrame
		hooksecurefunc(detailsFrame, "RefreshDisplay", IsRecipeEnchanting)
	
		local createButton = detailsFrame.CreateButton
		createButton:RegisterForClicks("AnyUp")
		createButton:HookScript("OnClick", function(_, btn)
			if btn == "RightButton" and isEnchanting then
				UseItemByName(ENCHANTING_VELLUM)
			end
		end)
	end
end

function MISC:TradeTabs()
	if not R.db["Misc"]["TradeTabs"] then return end
	if not ProfessionsFrame then return end

	ProfessionsFrame:HookScript("OnShow", function()
		if init then return end
		if InCombatLockdown() then
			M:RegisterEvent("PLAYER_REGEN_ENABLED", MISC.TradeTabs_OnLoad)
		else
			MISC:TradeTabs_OnLoad()
		end
	end)
end
MISC:RegisterMisc("TradeTabs", MISC.TradeTabs)