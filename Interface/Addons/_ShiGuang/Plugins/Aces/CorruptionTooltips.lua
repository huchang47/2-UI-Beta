--## Version: 1.3  ## Author: Anayanka (Defias Brotherhood - EU)
R = {
    ["6455"] = {"Avoidant", "I", 315607},
    ["6483"] = {"Avoidant", "I", 315607},
    ["6460"] = {"Avoidant", "II", 315608},
    ["6484"] = {"Avoidant", "II", 315608},
    ["6465"] = {"Avoidant", "III", 315609},
    ["6485"] = {"Avoidant", "III", 315609},
    ["6455"] = {"Expedient", "I", 315544},
    ["6474"] = {"Expedient", "I", 315544},
    ["6460"] = {"Expedient", "II", 315545},
    ["6475"] = {"Expedient", "II", 315545},
    ["6465"] = {"Expedient", "III", 315546},
    ["6476"] = {"Expedient", "III", 315546},
    ["6455"] = {"Masterful", "I", 315529},
    ["6471"] = {"Masterful", "I", 315529},
    ["6460"] = {"Masterful", "II", 315530},
    ["6472"] = {"Masterful", "II", 315530},
    ["6465"] = {"Masterful", "III", 315531},
    ["6473"] = {"Masterful", "III", 315531},
    ["6455"] = {"Severe", "I", 315554},
    ["6480"] = {"Severe", "I", 315554},
    ["6460"] = {"Severe", "II", 315557},
    ["6481"] = {"Severe", "II", 315557},
    ["6465"] = {"Severe", "III", 315558},
    ["6482"] = {"Severe", "III", 315558},
    ["6455"] = {"Versatile", "I", 315549},
    ["6477"] = {"Versatile", "I", 315549},
    ["6460"] = {"Versatile", "II", 315552},
    ["6478"] = {"Versatile", "II", 315552},
    ["6465"] = {"Versatile", "III", 315553},
    ["6479"] = {"Versatile", "III", 315553},
    ["6455"] = {"Siphoner", "I", 315590},
    ["6493"] = {"Siphoner", "I", 315590},
    ["6460"] = {"Siphoner", "II", 315591},
    ["6494"] = {"Siphoner", "II", 315591},
    ["6465"] = {"Siphoner", "III", 315592},
    ["6495"] = {"Siphoner", "III", 315592},
    ["6455"] = {"Strikethrough", "I", 315277},
    ["6437"] = {"Strikethrough", "I", 315277},
    ["6460"] = {"Strikethrough", "II", 315281},
    ["6438"] = {"Strikethrough", "II", 315281},
    ["6465"] = {"Strikethrough", "III", 315282},
    ["6439"] = {"Strikethrough", "III", 315282},
    ["6555"] = {"Racing Pulse", "I", 318266},
    ["6559"] = {"Racing Pulse", "II", 318492},
    ["6560"] = {"Racing Pulse", "III", 318496},
    ["6556"] = {"Deadly Momentum", "I", 318268},
    ["6561"] = {"Deadly Momentum", "II", 318493},
    ["6562"] = {"Deadly Momentum", "III", 318497},
    ["6558"] = {"Surging Vitality", "I", 318270},
    ["6565"] = {"Surging Vitality", "II", 318495},
    ["6566"] = {"Surging Vitality", "III", 318499},
    ["6557"] = {"Honed Mind", "I", 318269},
    ["6563"] = {"Honed Mind", "II", 318494},
    ["6564"] = {"Honed Mind", "III", 318498},
    ["6549"] = {"Echoing Void", "I", 318280},
    ["6550"] = {"Echoing Void", "II", 318485},
    ["6551"] = {"Echoing Void", "III", 318486},
    ["6552"] = {"Infinite Stars", "I", 318274},
    ["6553"] = {"Infinite Stars", "II", 318487},
    ["6554"] = {"Infinite Stars", "III", 318488},
    ["6547"] = {"Ineffable Truth", "I", 318303},
    ["6548"] = {"Ineffable Truth", "II", 318484},
    ["6537"] = {"Twilight Devastation", "I", 318276},
    ["6538"] = {"Twilight Devastation", "II", 318477},
    ["6539"] = {"Twilight Devastation", "III", 318478},
    ["6543"] = {"Twisted Appendage", "I", 318481},
    ["6544"] = {"Twisted Appendage", "II", 318482},
    ["6545"] = {"Twisted Appendage", "III", 318483},
    ["6540"] = {"Void Ritual", "I", 318286},
    ["6541"] = {"Void Ritual", "II", 318479},
    ["6542"] = {"Void Ritual", "III", 318480},
    ["6573"] = {"Gushing Wound", "", 318272},
    ["6546"] = {"Glimpse of Clarity", "", 318239},
    ["6571"] = {"Searing Flames", "", 318293},
    ["6572"] = {"Obsidian Skin", "", 316651},
    ["6567"] = {"Devour Vitality", "", 318294},
    ["6568"] = {"Whispered Truths", "", 316780},
    ["6570"] = {"Flash of Insight", "", 318299},
    ["6569"] = {"Lash of the Void", "", 317290},
}

CorruptionTooltips = LibStub("AceAddon-3.0"):NewAddon("Corruption Tooltips", "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0")

function CorruptionTooltips:OnEnable()
    self:SecureHookScript(GameTooltip, 'OnTooltipSetItem', 'TooltipHook')
    self:SecureHookScript(ItemRefTooltip, 'OnTooltipSetItem', 'TooltipHook')
    self:SecureHookScript(ShoppingTooltip1, 'OnTooltipSetItem', 'TooltipHook')
    self:SecureHookScript(EmbeddedItemTooltip, 'OnTooltipSetItem', 'TooltipHook')
end

local function GetItemSplit(itemLink)
  local itemString = string.match(itemLink, "item:([%-?%d:]+)")
  local itemSplit = {}

  -- Split data into a table
  for _, v in ipairs({strsplit(":", itemString)}) do
    if v == "" then
      itemSplit[#itemSplit + 1] = 0
    else
      itemSplit[#itemSplit + 1] = tonumber(v)
    end
  end

  return itemSplit
end

function CorruptionTooltips:CreateTooltip(self)
	local name, item = self:GetItem()
  	if not name then return end

  	if IsCorruptedItem(item) then

        local itemSplit = GetItemSplit(item)
        local bonuses = {}

        for index=1, itemSplit[13] do
            bonuses[#bonuses + 1] = itemSplit[13 + index]
        end

		local corruption = CorruptionTooltips:GetCorruption(bonuses)

		if corruption then
			local name = corruption[1]
			local icon = corruption[2]
			local line = '|T'..icon..':12:12:0:0|t '.."|cff956dd1"..name.."|r"
			if CorruptionTooltips:Append(self, line) ~= true then
                self:AddLine(" ")
                self:AddLine(line)
			end
		end
	end
end

function CorruptionTooltips:GetCorruption(bonuses)
    if #bonuses > 0 then
        for i, bonus_id in pairs(bonuses) do
            bonus_id = tostring(bonus_id)
            if R[bonus_id] ~= nil then
                local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(R[bonus_id][3])
                return {
                    name.." "..R[bonus_id][2],
                    icon,
                }
            end
        end
    end
end

function CorruptionTooltips:Append(tooltip, line)
    --if self.db.profile.append then
        local detected
        for i = 1, tooltip:NumLines() do
            local left = _G[tooltip:GetName().."TextLeft"..i]
            detected = string.match(left:GetText(), "+(%d+) "..ITEM_MOD_CORRUPTION)
            if detected ~= nil then
                left:SetText(left:GetText().." / "..line)
                return true
            end
        end
    --end
end

function CorruptionTooltips:TooltipHook(frame)
	self:CreateTooltip(frame)
end