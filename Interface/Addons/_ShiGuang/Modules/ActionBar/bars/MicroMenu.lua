local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

-- Texture credit: 胡里胡涂
local _G = getfenv(0)
local tinsert, pairs, type = table.insert, pairs, type
local buttonList = {}

function Bar:MicroButton_SetupTexture(icon, texture)
	local r, g, b = I.r, I.g, I.b
	if not MaoRUIPerDB["Skins"]["ClassLine"] then r, g, b = 0, 0, 0 end

	icon:SetOutside(nil, 3, 3)
	if MaoRUIPerDB["Actionbar"]["MicroMenuStyle"] then
	icon:SetTexture(I.MicroTex..texture)
	icon:SetVertexColor(r, g, b)
	else	
	icon:SetTexture("Interface\\BUTTONS\\"..texture)
	icon:SetVertexColor(1, 1, 1)
	end
end

function Bar:MicroButton_Create(parent, data)
	local texture, method, tooltip = unpack(data)

	local bu = CreateFrame("Frame", nil, parent)
	tinsert(buttonList, bu)
	if MaoRUIPerDB["Actionbar"]["MicroMenuStyle"] then
	bu:SetSize(21, 21)
	else	
	bu:SetSize(16, 36)
	end

	local icon = bu:CreateTexture(nil, "ARTWORK")
	Bar:MicroButton_SetupTexture(icon, texture)

	if type(method) == "string" then
		local button = _G[method]
		button:SetHitRectInsets(0, 0, 0, 0)
		button:SetParent(bu)
		button:ClearAllPoints(bu)
		button:SetAllPoints(bu)
		button.SetPoint = M.Dummy
		button:UnregisterAllEvents()
		button:SetNormalTexture(nil)
		button:SetPushedTexture(nil)
		button:SetDisabledTexture(nil)
		if tooltip then M.AddTooltip(button, "ANCHOR_RIGHT", tooltip) end

		local hl = button:GetHighlightTexture()
		Bar:MicroButton_SetupTexture(hl, texture)
		if not MaoRUIPerDB["Skins"]["ClassLine"] then hl:SetVertexColor(1, 1, 1) end

		local flash = button.Flash
		Bar:MicroButton_SetupTexture(flash, texture)
		if not MaoRUIPerDB["Skins"]["ClassLine"] then flash:SetVertexColor(1, 1, 1) end
	else
		bu:SetScript("OnMouseUp", method)
		M.AddTooltip(bu, "ANCHOR_RIGHT", tooltip)

		local hl = bu:CreateTexture(nil, "HIGHLIGHT")
		hl:SetBlendMode("ADD")
		Bar:MicroButton_SetupTexture(hl, texture)
		if not MaoRUIPerDB["Skins"]["ClassLine"] then hl:SetVertexColor(1, 1, 1) end
	end
end

function Bar:MicroMenu()
	if not MaoRUIPerDB["Actionbar"]["MicroMenu"] then return end

	local menubar = CreateFrame("Frame", nil, UIParent)
	menubar:SetSize(21, 186)  --*MaoRUIPerDB["Map"]["MinimapScale"]
	M.Mover(menubar, U["Menubar"], "Menubar", R.Skins.MicroMenuPos)

	-- Generate Buttons
	local buttonInfo = {
		--{"UI-MicroButton-BStore-Up", "StoreMicroButton"},
		--{"UI-MicroButton-Help-Up", "MainMenuMicroButton", MicroButtonTooltipText(MAINMENU_BUTTON, "TOGGLEGAMEMENU")},
		--{"UI-MicroButton-Abilities-Up", function() ToggleAllBags() end, MicroButtonTooltipText(BAGSLOT, "OPENALLBAGS")},
		{"UI-MICROBUTTON-QUEST-UP", "QuestLogMicroButton"},
		{"UI-MicroButton-Spellbook-Up", "SpellbookMicroButton"},
		{"UI-MICROBUTTON-SOCIALS-UP", "GuildMicroButton"},
		{"UI-MicroButton-Achievement-Up", "AchievementMicroButton"},
		{"UI-MicroButton-LFG-Up", "LFDMicroButton"},
		{"UI-MicroButton-Talents-Up", "TalentMicroButton"},
		{"UI-MicroButton-Mounts-Up", "CollectionsMicroButton"},
		{"UI-MicroButton-EJ-Up", "EJMicroButton"},
		{"UI-MicroButton-Raid-Up", "CharacterMicroButton"},
	}
	for _, info in pairs(buttonInfo) do
		Bar:MicroButton_Create(menubar, info)
	end

	-- Order Positions
	for i = 1, #buttonList do
		if i == 1 then
			buttonList[i]:SetPoint("TOPRIGHT", menubar, "TOPRIGHT", 0, 16)
		--elseif i == 9 and MaoRUIPerDB["Map"]["MinimapScale"] > 1.1 then
		  		--buttonList[i]:SetPoint("BOTTOM", buttonList[i-1], "TOP", 0, -12)
		--elseif i == 10 and MaoRUIPerDB["Map"]["MinimapScale"] >= 1.3  then
		  		--buttonList[i]:SetPoint("BOTTOM", buttonList[i-1], "TOP", 0, -12)
		--elseif i >= 9 then
			--buttonList[i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMRIGHT", 1, -1)
		else
			buttonList[i]:SetPoint("CENTER", buttonList[i-1], "CENTER", 0, -21)
		end
	end

	-- Default elements
	M.HideObject(MicroButtonPortrait)
	M.HideObject(GuildMicroButtonTabard)
	M.HideObject(MainMenuBarDownload)
	M.HideObject(HelpOpenWebTicketButton)
	M.HideObject(MainMenuBarPerformanceBar)
	MainMenuMicroButton:SetScript("OnUpdate", nil)

	CharacterMicroButtonAlert:EnableMouse(false)
	M.HideOption(CharacterMicroButtonAlert)
	TalentMicroButtonAlert:EnableMouse(false)
	M.HideOption(TalentMicroButtonAlert)
end