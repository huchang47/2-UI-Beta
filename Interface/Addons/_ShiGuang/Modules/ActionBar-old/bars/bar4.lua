local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local _G = _G
local tinsert = tinsert
local InCombatLockdown = InCombatLockdown
local cfg = R.Bars.bar4

local function updateVisibility(event)
	if InCombatLockdown() then
		M:RegisterEvent("PLAYER_REGEN_ENABLED", updateVisibility)
	else
		InterfaceOptions_UpdateMultiActionBars()
		M:UnregisterEvent(event, updateVisibility)
	end
end

function Bar:FixSizebarVisibility()
	M:RegisterEvent("PET_BATTLE_OVER", updateVisibility)
	M:RegisterEvent("PET_BATTLE_CLOSE", updateVisibility)
	M:RegisterEvent("UNIT_EXITED_VEHICLE", updateVisibility)
	M:RegisterEvent("UNIT_EXITING_VEHICLE", updateVisibility)
end

function Bar:ToggleBarFader(name)
	local frame = _G["UI_Action"..name]
	if not frame then return end

	frame.isDisable = not R.db["Actionbar"][name.."Fader"]
	if frame.isDisable then
		Bar:StartFadeIn(frame)
	else
		Bar:StartFadeOut(frame)
	end
end

function Bar:UpdateFrameClickThru()
	local showBar4, showBar5

	local function updateClickThru()
		_G.UI_ActionBar4:EnableMouse(showBar4)
		_G.UI_ActionBar5:EnableMouse((not showBar4 and showBar4) or (showBar4 and showBar5))
	end

	hooksecurefunc("SetActionBarToggles", function(_, _, bar3, bar4)
		showBar4 = not not bar3
		showBar5 = not not bar4
		if InCombatLockdown() then
			M:RegisterEvent("PLAYER_REGEN_ENABLED", updateClickThru)
		else
			updateClickThru()
		end
	end)
end

function Bar:CreateBar4()
	local num = NUM_ACTIONBAR_BUTTONS
	local buttonList = {}

	local frame = CreateFrame("Frame", "UI_ActionBar4", UIParent, "SecureHandlerStateTemplate")
	frame.mover = M.Mover(frame, U["Actionbar"].."4", "Bar4", {"RIGHT", UIParent, "RIGHT", -1, 0})
	Bar.movers[5] = frame.mover

	MultiBarRight:SetParent(frame)
	MultiBarRight:EnableMouse(false)
	MultiBarRight.QuickKeybindGlow:SetTexture("")

	for i = 1, num do
		local button = _G["MultiBarRightButton"..i]
		tinsert(buttonList, button)
		tinsert(Bar.buttons, button)
	end
	frame.buttons = buttonList

	frame.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists][shapeshift] hide; show"
	RegisterStateDriver(frame, "visibility", frame.frameVisibility)

	if cfg.fader then
		frame.isDisable = not R.db["Actionbar"]["Bar4Fader"]
		Bar.CreateButtonFrameFader(frame, buttonList, cfg.fader)
	end

	-- Fix visibility when leaving vehicle or petbattle
	Bar:FixSizebarVisibility()
	Bar:UpdateFrameClickThru()
end