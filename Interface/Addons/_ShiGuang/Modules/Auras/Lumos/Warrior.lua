local _, ns = ...
local M, R, U, I = unpack(ns)
local A = M:GetModule("Auras")

if I.MyClass ~= "WARRIOR" then return end

local function GetUnitAura(unit, spell, filter)
	return A:GetUnitAura(unit, spell, filter)
end

local function UpdateCooldown(button, spellID, texture)
	return A:UpdateCooldown(button, spellID, texture)
end

local function UpdateBuff(button, spellID, auraID, cooldown, glow)
	return A:UpdateAura(button, "player", auraID, "HELPFUL", spellID, cooldown, glow)
end

local function UpdateDebuff(button, spellID, auraID, cooldown, glow)
	return A:UpdateAura(button, "target", auraID, "HARMFUL", spellID, cooldown, glow)
end

local function UpdateSpellStatus(button, spellID)
	button.Icon:SetTexture(GetSpellTexture(spellID))
	if IsUsableSpell(spellID) then
		button.Icon:SetDesaturated(false)
	else
		button.Icon:SetDesaturated(true)
	end
end

function A:ChantLumos(self)
	if GetSpecialization() == 1 then
		do
			local button = self.lumos[1]
			local name, count, duration, expire = GetUnitAura("player", 7384, "HELPFUL")
			if name then
				if count == 0 then count = "" end
				button.Count:SetText(count)
				button.CD:SetCooldown(expire-duration, duration)
				button.CD:Show()
				button.Icon:SetDesaturated(false)
				button.Icon:SetTexture(GetSpellTexture(12294))
			else
				UpdateCooldown(button, 7384, true)
			end
		end

		do
			local button = self.lumos[2]
			UpdateCooldown(button, 163201)
			if IsPlayerSpell(281001) then
				UpdateSpellStatus(button, 281000)
			else
				UpdateSpellStatus(button, 163201)
			end
		end

		UpdateDebuff(self.lumos[3], 167105, 208086, true, true)
		UpdateBuff(self.lumos[4], 260708, 260708, true, "END")

		do
			local button = self.lumos[5]
			if IsPlayerSpell(152277) then
				UpdateCooldown(button, 152277, true)
			else
				UpdateBuff(button, 227847, 227847, true, true)
			end
		end
	elseif GetSpecialization() == 2 then
		UpdateCooldown(self.lumos[1], 23881, true)
		UpdateCooldown(self.lumos[2], 85288, true)

		do
			local button = self.lumos[3]
			UpdateCooldown(button, 5308)
			if IsPlayerSpell(206315) then
				UpdateSpellStatus(button, 280735)
			else
				UpdateSpellStatus(button, 5308)
			end
		end

		UpdateBuff(self.lumos[4], 184362, 184362, false, true)
		UpdateBuff(self.lumos[5], 1719, 1719, true, true)
	elseif GetSpecialization() == 3 then
		UpdateDebuff(self.lumos[1], 1160, 1160, true)

		do
			local button = self.lumos[2]
			local name, _, duration, expire = GetUnitAura("player", 132404, "HELPFUL")
			if name then
				button.Count:SetText("")
				button.CD:SetCooldown(expire-duration, duration)
				button.CD:Show()
				button.Icon:SetDesaturated(false)
			else
				UpdateCooldown(button, 2565)
				UpdateSpellStatus(button, 2565)
			end
		end

		UpdateBuff(self.lumos[3], 12975, 12975, true, true)
		UpdateBuff(self.lumos[4], 107574, 107574, true)
		UpdateBuff(self.lumos[5], 871, 871, true, true)
	end
end