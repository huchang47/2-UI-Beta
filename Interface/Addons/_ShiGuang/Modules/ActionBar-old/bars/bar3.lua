local _, ns = ...
local M, R, U, I = unpack(ns)
local Bar = M:GetModule("Actionbar")

local _G = _G
local tinsert = tinsert
local cfg = R.Bars.bar3
local margin, padding = R.Bars.margin, R.Bars.padding

function Bar:CreateBar3()
	local num = NUM_ACTIONBAR_BUTTONS
	local buttonList = {}

	local frame = CreateFrame("Frame", "UI_ActionBar3", UIParent, "SecureHandlerStateTemplate")
	frame.mover = M.Mover(frame, U["Actionbar"].."3L", "Bar3L", {"RIGHT", _G.UI_ActionBar1, "TOPLEFT", -margin, -padding/2})
	local child = CreateFrame("Frame", nil, frame)
	child:SetSize(1, 1)
	child.mover = M.Mover(child, U["Actionbar"].."3R", "Bar3R", {"LEFT", _G.UI_ActionBar1, "TOPRIGHT", margin, -padding/2})
	frame.child = child

	Bar.movers[3] = frame.mover
	Bar.movers[4] = child.mover

	MultiBarBottomRight:SetParent(frame)
	MultiBarBottomRight:EnableMouse(false)
	MultiBarBottomRight.QuickKeybindGlow:SetTexture("")

	for i = 1, num do
		local button = _G["MultiBarBottomRightButton"..i]
		tinsert(buttonList, button)
		tinsert(Bar.buttons, button)
	end
	frame.buttons = buttonList

	frame.frameVisibility = "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists][shapeshift] hide; show"
	RegisterStateDriver(frame, "visibility", frame.frameVisibility)

	if cfg.fader then
		Bar.CreateButtonFrameFader(frame, buttonList, cfg.fader)
	end
end