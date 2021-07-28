﻿--"Release Version Jan 2021 for Patch 9.0.2" by Wyr3d

local vars, Ld, La = {},{}, {}
vars.L = setmetatable({},{
    __index = function(t, s) return La[s] or Ld[s] or rawget(t,s) or s end
})
-- Ld means default (english) if no translation found. So we don't need a translation for "enUS" or "enGB".
Ld["Agi"] = "Agi"
Ld["Crit"] = "Crit"
Ld["Haste"] = "Haste"
Ld["Int"] = "Int"
Ld["Mastery"] = "Mastery"
Ld["Sta"] = "Stam"
Ld["Str"] = "Str"
Ld["Vers"] = "Vers"
Ld["Armor"] = "Armor"

if GetLocale() == "zhCN" then do end
	La["Agi"] = "敏捷"
	La["Haste"] = "急速"
	La["Crit"] = "暴击"
	La["Int"] = "智力"
	La["Mastery"] = "精通"
	La["Sta"] = "耐力"
	La["Str"] = "力量"
	La["Vers"] = "全能"
	La["Armor"] = "盔甲"
elseif GetLocale() == "zhTW" then do end
	La["Agi"] = "敏捷"
	La["Haste"] = "加速"
	La["Crit"] = "致命"
	La["Int"] = "智力"
	La["Mastery"] = "精通"
	La["Sta"] = "耐力"
	La["Str"] = "力量"
	La["Vers"] = "臨機"
	La["Armor"] = "盔甲"
end

local Wyr3d_StatTable = {}
Wyr3d_StatTable["DEATHKNIGHT-250"] = "[Str]：ilvl > Vers > Haste > Crit > Mast"
Wyr3d_StatTable["DEATHKNIGHT-251"] = "[Str]：Mast > Crit > Haste > Vers"
Wyr3d_StatTable["DEATHKNIGHT-252"] = "[Str]：Mast > Haste > Crit > Vers"

Wyr3d_StatTable["DRUID-102"] = "Int > Mast > Haste > Vers > Crit"
Wyr3d_StatTable["DRUID-103"] = "Agil > Crit > Mast > Vers > Haste"
Wyr3d_StatTable["DRUID-104"] = "[Survival]: ilvl > Armor = Agil = Stam > Vers > Mast > Haste > Crit \n [Damage]: Agil > Vers >= Haste >= Crit > Mast"
Wyr3d_StatTable["DRUID-105"] = "[Raid]: Int > Haste > Mast = Crit = Vers > Int \n [Dungeon]: Int > Mast = Haste > Vers > Crit"

Wyr3d_StatTable["HUNTER-253"] = "[Agil]：Crit > Haste = Vers > Mast"
Wyr3d_StatTable["HUNTER-254"] = "[Agil]：Mast > Crit > Vers > Haste"
Wyr3d_StatTable["HUNTER-255"] = "[Agil]：Haste > Vers = Crit > Mast"

Wyr3d_StatTable["MAGE-62"] = "Int > Crit > Mast > Vers > Haste"
Wyr3d_StatTable["MAGE-63"] = "Int > Haste > Vers > Mast > Crit"
Wyr3d_StatTable["MAGE-64"] = "Int > Crit 33% > Haste > Vers > Mast"

Wyr3d_StatTable["MONK-268"] = "Defense: Vers = Mast = Crit > Haste \n Offense: Vers = Crit > Haste > Mast"
Wyr3d_StatTable["MONK-269"] = "Weapon Dam > Agi > Vers > Mast > Crit > Haste"
Wyr3d_StatTable["MONK-270"] = "[Raid]: Int > Crit > Vers > Haste > Mast \n [Mythic]: Int > Crit ≥ Mast = Vers ≥ Haste"

Wyr3d_StatTable["PALADIN-65"] = "[Raid]: Int > Haste > Mast > Vers > Crit \n [Mythic]: Int > Haste > Vers > Crit > Mast"
Wyr3d_StatTable["PALADIN-66"] = "Haste > Mast = Vers > Crit"
Wyr3d_StatTable["PALADIN-70"] = "Str > Crit ≈ Vers ≈ Mast ≈ Haste"

Wyr3d_StatTable["PRIEST-256"] = "Int > Haste > Crit > Vers > Mas"
Wyr3d_StatTable["PRIEST-257"] = "[Raid]: Int > Mast = Crit > Vers > Haste \n [Dungeon]: Int > Crit > Haste > Vers > Mast"
Wyr3d_StatTable["PRIEST-258"] = "Int > Haste = Mast > Crit > Vers"

Wyr3d_StatTable["ROGUE-259"] = "[Raid]: Haste > Crit > Vers > Mast \n [Dungeon]: Crit > Mast > Haste > Vers"
Wyr3d_StatTable["ROGUE-260"] = "[Raid]: Vers > Haste > Crit > Mast \n [Dungeon]: Vers > Crit > Haste > Mast"
Wyr3d_StatTable["ROGUE-261"] = "Solo: Vers > Crit > Haste > Mast \n Multi: Crit > Vers > Mast > Haste"

Wyr3d_StatTable["SHAMAN-262"] = "Int > Vers > Crit > Haste > Mast"
Wyr3d_StatTable["SHAMAN-263"] = "Agil > Haste > Crit = Vers > Mast"
Wyr3d_StatTable["SHAMAN-264"] = "[Heal]: Int > Vers = Crit > Haste = Mast \n [Damage]: Int > Vers = Haste > Crit > Mast" 

Wyr3d_StatTable["WARLOCK-265"] = "Int > Mast > Haste > Crit > Vers"
Wyr3d_StatTable["WARLOCK-266"] = "Solo: Int > Haste > Mast > Crit ≈ Vers \n Multi: Int > Haste = Mast > Crit ≈ Vers"
Wyr3d_StatTable["WARLOCK-267"] = "Int > Haste ≥ Mast > Crit > Vers"

Wyr3d_StatTable["WARRIOR-71"] = "Str > Crit > Mast > Vers > Haste"
Wyr3d_StatTable["WARRIOR-72"] = "Str > Haste > Mast > Crit > Vers"
Wyr3d_StatTable["WARRIOR-73"] = "[General]: Str > Haste > Vers > Mast > Crit \n [Mythic]: Str > Haste > Vers ≥ Crit > Mast"

Wyr3d_StatTable["DEMONHUNTER-577"] = "Agil > Haste = Vers > Crit > Mast"
Wyr3d_StatTable["DEMONHUNTER-581"] = "Agil > Haste ≥ Vers > Crit > Mast"

local Wyr3d_STATS = CreateFrame("Frame",Wyr3d_STATS,UIParent, BackdropTemplateMixin and "BackdropTemplate")

function Wyr3d_STATS:CreateWin()
    if PaperDollFrame:IsVisible() then
        if not Wyr3d_STATSwin then
            Wyr3d_STATSwin = CreateFrame("Frame",Wyr3d_STATSwin,Wyr3d_STATS)
            --Wyr3d_STATS:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 1, right = 1, top = 1, bottom = 1 }}) 
            --Wyr3d_STATS:SetBackdropColor(0,0,0,1)
            Wyr3d_STATS:SetFrameStrata("TOOLTIP")
            Wyr3d_STATS:SetWidth(PaperDollFrame:GetWidth()-50) 
            Wyr3d_STATS:SetHeight(21)
    	    Wyr3d_STATStxt = Wyr3d_STATS:CreateFontString(nil,"OVERLAY","GameFontWhite")
			local ft = Wyr3d_STATStxt 
			ft:ClearAllPoints()
			ft:SetAllPoints(Wyr3d_STATS) 
			ft:SetJustifyH("CENTER")
			ft:SetJustifyV("CENTER")
            Wyr3d_STATS:ClearAllPoints()
            Wyr3d_STATS:SetPoint("BOTTOMRIGHT",PaperDollFrame,"TOPRIGHT",0,0)
            Wyr3d_STATS:SetParent(PaperDollFrame)
            Wyr3d_STATS:Show()            
        end
        return true
    end
    return false
end

function Wyr3d_STATS:Update()
    if Wyr3d_STATS:CreateWin() then
        local _, className = UnitClass("player")
        local sId, specName = GetSpecializationInfo(GetSpecialization())
        local s = Wyr3d_StatTable[className .. "-" .. sId]
        if s then
            s = gsub(s,"Strength","Str")
            s = gsub(s,"Agility","Agi")
            s = gsub(s,"Intellect","Int")
            s = gsub(s,"Stamina","Stam")
            s = gsub(s,"Versatility","Vers")
      -- H.Sch For multiple language
			s = gsub(s,"Int", vars.L["Int"])
			s = gsub(s,"Crit", vars.L["Crit"])
			s = gsub(s,"Str", vars.L["Str"])
			s = gsub(s,"Agi", vars.L["Agi"])
			s = gsub(s,"Stam", vars.L["Sta"])
			s = gsub(s,"Vers", vars.L["Vers"])
			s = gsub(s,"Haste", vars.L["Haste"])
			s = gsub(s,"Mast", vars.L["Mastery"])
			s = gsub(s,"Armor", vars.L["Armor"])
            Wyr3d_STATStxt:SetText(s) 
        end               
    end
end

--Wyr3d_STATS:RegisterEvent("SPELLS_CHANGED") 
Wyr3d_STATS:RegisterEvent("ADDON_LOADED") 
Wyr3d_STATS:SetScript("OnEvent", function(self, event)
    if event == "ADDON_LOADED" then
        Wyr3d_STATS:Update()
        PaperDollFrame:HookScript("OnShow", function() Wyr3d_STATS:Update() end)
    end
    --if event == "SPELLS_CHANGED" then
            --Wyr3d_STATS:Update()
    --end
end)