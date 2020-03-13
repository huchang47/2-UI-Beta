local _, ns = ...
local M, R, U, I = unpack(ns)
local TT = M:GetModule("Tooltip")

local ITEM_MOD_CORRUPTION = ITEM_MOD_CORRUPTION
local IsCorruptedItem, GetSpellInfo = IsCorruptedItem, GetSpellInfo
local select, strmatch, gmatch, format = select, strmatch, gmatch, format

local corruptionData = {
	-- Credit: CorruptionNameTooltips
	["6455"] = {spellID = 315607, level = "I"},
	["6483"] = {spellID = 315607, level = "I"},
	["6484"] = {spellID = 315608, level = "II"},
	["6485"] = {spellID = 315609, level = "III"},
	["6474"] = {spellID = 315544, level = "I"},
	["6475"] = {spellID = 315545, level = "II"},
	["6476"] = {spellID = 315546, level = "III"},
	["6471"] = {spellID = 315529, level = "I"},
	["6472"] = {spellID = 315530, level = "II"},
	["6473"] = {spellID = 315531, level = "III"},
	["6480"] = {spellID = 315554, level = "I"},
	["6481"] = {spellID = 315557, level = "II"},
	["6482"] = {spellID = 315558, level = "III"},
	["6477"] = {spellID = 315549, level = "I"},
	["6478"] = {spellID = 315552, level = "II"},
	["6479"] = {spellID = 315553, level = "III"},
	["6493"] = {spellID = 315590, level = "I"},
	["6494"] = {spellID = 315591, level = "II"},
	["6495"] = {spellID = 315592, level = "III"},
	["6437"] = {spellID = 315277, level = "I"},
	["6438"] = {spellID = 315281, level = "II"},
	["6439"] = {spellID = 315282, level = "III"},
	["6555"] = {spellID = 318266, level = "I"},
	["6559"] = {spellID = 318492, level = "II"},
	["6560"] = {spellID = 318496, level = "III"},
	["6556"] = {spellID = 318268, level = "I"},
	["6561"] = {spellID = 318493, level = "II"},
	["6562"] = {spellID = 318497, level = "III"},
	["6558"] = {spellID = 318270, level = "I"},
	["6565"] = {spellID = 318495, level = "II"},
	["6566"] = {spellID = 318499, level = "III"},
	["6557"] = {spellID = 318269, level = "I"},
	["6563"] = {spellID = 318494, level = "II"},
	["6564"] = {spellID = 318498, level = "III"},
	["6549"] = {spellID = 318280, level = "I"},
	["6550"] = {spellID = 318485, level = "II"},
	["6551"] = {spellID = 318486, level = "III"},
	["6552"] = {spellID = 318274, level = "I"},
	["6553"] = {spellID = 318487, level = "II"},
	["6554"] = {spellID = 318488, level = "III"},
	["6547"] = {spellID = 318303, level = "I"},
	["6548"] = {spellID = 318484, level = "II"},
	["6537"] = {spellID = 318276, level = "I"},
	["6538"] = {spellID = 318477, level = "II"},
	["6539"] = {spellID = 318478, level = "III"},
	["6543"] = {spellID = 318481, level = "I"},
	["6544"] = {spellID = 318482, level = "II"},
	["6545"] = {spellID = 318483, level = "III"},
	["6540"] = {spellID = 318286, level = "I"},
	["6541"] = {spellID = 318479, level = "II"},
	["6542"] = {spellID = 318480, level = "III"},
	["6573"] = {spellID = 318272, level = ""},
	["6546"] = {spellID = 318239, level = ""},
	["6571"] = {spellID = 318293, level = ""},
	["6572"] = {spellID = 316651, level = ""},
	["6567"] = {spellID = 318294, level = ""},
	["6568"] = {spellID = 316780, level = ""},
	["6570"] = {spellID = 318299, level = ""},
	["6569"] = {spellID = 317290, level = ""},
}

-- fixed weapon bonuses for EJ
CorruptionDateW = {
    ["172199"] = "6571", -- Faralos, Empire's Dream
    ["172200"] = "6572", -- Sk'shuul Vaz
    ["172191"] = "6567", -- An'zig Vra
    ["172193"] = "6568", -- Whispering Eldritch Bow
    ["172198"] = "6570", -- Mar'kowa, the Mindpiercer
    ["172197"] = "6569", -- Unguent Caress
    ["172227"] = "6544", -- Shard of the Black Empire
    ["172196"] = "6541", -- Vorzz Yoq'al
    ["174106"] = "6550", -- Qwor N'lyeth
    ["172189"] = "6548", -- Eyestalk of Il'gynoth
    ["174108"] = "6553", -- Shgla'yos, Astral Malignity
    ["172187"] = "6539", -- Devastation's Hour
}

local linkCache = {}
function TT:Corruption_Search(link)
	local value = linkCache[link]
	if not value then
		local itemString = strmatch(link, "item:([%-?%d:]+)")
		for index in gmatch(itemString, "%d+") do
			if corruptionData[index] then
				value = corruptionData[index]
				linkCache[link] = value
				break
			end
		end
	end
	return value
end

local function getIconString(icon)
	return format("|T%s:14:14:0:0:64:64:5:59:5:59|t ", icon)
end

function TT:Corruption_Convert(name, icon, level)
	for i = 5, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text and strmatch(text, ITEM_MOD_CORRUPTION) then
			line:SetText(text.." / "..getIconString(icon)..name.." "..level)
			return
		end
	end
end

function TT:Corruption_Update()
	local link = select(2, self:GetItem())
	if link and IsCorruptedItem(link) then
		local value = TT:Corruption_Search(link)
		if value then
			if not value.name or not value.icon then
				value.name, _, value.icon = GetSpellInfo(value.spellID)
			end
			TT.Corruption_Convert(self, value.name, value.icon, value.level)
		end
	end
end

function TT:CorruptionRank()
	if not MaoRUIPerDB["Tooltip"]["CorruptionRank"] then return end
	if IsAddOnLoaded("CorruptionTooltips") then return end
	if IsAddOnLoaded("CorruptionNameTooltips") then return end

	GameTooltip:HookScript("OnTooltipSetItem", TT.Corruption_Update)
	ItemRefTooltip:HookScript("OnTooltipSetItem", TT.Corruption_Update)
	ShoppingTooltip1:HookScript("OnTooltipSetItem", TT.Corruption_Update)
	ShoppingTooltip2:HookScript("OnTooltipSetItem", TT.Corruption_Update)
	EmbeddedItemTooltip:HookScript("OnTooltipSetItem", TT.Corruption_Update)
end