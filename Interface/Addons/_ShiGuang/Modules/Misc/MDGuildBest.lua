local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

local format, strsplit, tonumber, pairs, wipe = format, strsplit, tonumber, pairs, wipe
local Ambiguate = Ambiguate
local C_ChallengeMode_GetMapUIInfo = C_ChallengeMode.GetMapUIInfo
local C_ChallengeMode_GetGuildLeaders = C_ChallengeMode.GetGuildLeaders
local C_MythicPlus_GetOwnedKeystoneLevel = C_MythicPlus.GetOwnedKeystoneLevel
local C_MythicPlus_GetOwnedKeystoneChallengeMapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID
local CHALLENGE_MODE_POWER_LEVEL = CHALLENGE_MODE_POWER_LEVEL
local CHALLENGE_MODE_GUILD_BEST_LINE = CHALLENGE_MODE_GUILD_BEST_LINE
local CHALLENGE_MODE_GUILD_BEST_LINE_YOU = CHALLENGE_MODE_GUILD_BEST_LINE_YOU

local hasAngryKeystones
local frame

function MISC:GuildBest_UpdateTooltip()
	local leaderInfo = self.leaderInfo
	if not leaderInfo then return end

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	local name = C_ChallengeMode_GetMapUIInfo(leaderInfo.mapChallengeModeID)
	GameTooltip:SetText(name, 1, 1, 1)
	GameTooltip:AddLine(format(CHALLENGE_MODE_POWER_LEVEL, leaderInfo.keystoneLevel))
	for i = 1, #leaderInfo.members do
		local classColorStr = I.ClassColors[leaderInfo.members[i].classFileName].colorStr
		GameTooltip:AddLine(format(CHALLENGE_MODE_GUILD_BEST_LINE, classColorStr,leaderInfo.members[i].name));
	end
	GameTooltip:Show()
end

function MISC:GuildBest_Create()
	frame = CreateFrame("Frame", nil, ChallengesFrame, "BackdropTemplate")
	frame:SetPoint("BOTTOMRIGHT", -8, 75)
	frame:SetSize(170, 105)
	M.CreateBD(frame, .25)
	M.CreateFS(frame, 16, GUILD, "system", "TOPLEFT", 16, -6)

	frame.entries = {}
	for i = 1, 4 do
		local entry = CreateFrame("Frame", nil, frame)
		entry:SetPoint("LEFT", 10, 0)
		entry:SetPoint("RIGHT", -10, 0)
		entry:SetHeight(18)
		entry.CharacterName = M.CreateFS(entry, 14, "", false, "LEFT", 6, 0)
		entry.CharacterName:SetPoint("RIGHT", -30, 0)
		entry.CharacterName:SetJustifyH("LEFT")
		entry.Level = M.CreateFS(entry, 14, "", "system")
		entry.Level:SetJustifyH("LEFT")
		entry.Level:ClearAllPoints()
		entry.Level:SetPoint("LEFT", entry, "RIGHT", -22, 0)
		entry:SetScript("OnEnter", self.GuildBest_UpdateTooltip)
		entry:SetScript("OnLeave", M.HideTooltip)
		if i == 1 then
			entry:SetPoint("TOP", frame, 0, -26)
		else
			entry:SetPoint("TOP", frame.entries[i-1], "BOTTOM")
		end

		frame.entries[i] = entry
	end

	if not hasAngryKeystones then
		ChallengesFrame.WeeklyInfo.Child.Description:SetPoint("CENTER", 0, 20)
	end
end

function MISC:GuildBest_SetUp(leaderInfo)
	self.leaderInfo = leaderInfo
	local str = CHALLENGE_MODE_GUILD_BEST_LINE
	if leaderInfo.isYou then
		str = CHALLENGE_MODE_GUILD_BEST_LINE_YOU
	end

	local classColorStr = I.ClassColors[leaderInfo.classFileName].colorStr
	self.CharacterName:SetText(format(str, classColorStr, leaderInfo.name))
	self.Level:SetText(leaderInfo.keystoneLevel)
end

local resize
function MISC:GuildBest_Update()
	if not frame then MISC:GuildBest_Create() end
	if self.leadersAvailable then
		local leaders = C_ChallengeMode_GetGuildLeaders()
		if leaders and #leaders > 0 then
			for i = 1, #leaders do
				MISC.GuildBest_SetUp(frame.entries[i], leaders[i])
			end
			frame:Show()
		else
			frame:Hide()
		end
	end

	if not resize and hasAngryKeystones then
		local schedule = AngryKeystones.Modules.Schedule.AffixFrame
		frame:SetWidth(246)
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT", schedule, "TOPLEFT", 0, 10)

		self.WeeklyInfo.Child.ThisWeekLabel:SetPoint("TOP", -135, -25)
		local affix = self.WeeklyInfo.Child.Affixes[1]
		if affix then
			affix:ClearAllPoints()
			affix:SetPoint("TOPLEFT", 20, -55)
		end

		resize = true
	end
end

function MISC.GuildBest_OnLoad(event, addon)
	if addon == "Blizzard_ChallengesUI" then
		hooksecurefunc("ChallengesFrame_Update", MISC.GuildBest_Update)
		MISC:KeystoneInfo_Create()

		M:UnregisterEvent(event, MISC.GuildBest_OnLoad)
	end
end

-- Keystone Info
local myFullName = I.MyName.."-"..I.MyRealm
local iconColor = I.QualityColors[LE_ITEM_QUALITY_EPIC or 4]

function MISC:KeystoneInfo_Create()
	local texture = select(10, GetItemInfo(158923)) or 525134
	local button = CreateFrame("Frame", nil, ChallengesFrame.WeeklyInfo, "BackdropTemplate")
	button:SetPoint("BOTTOMLEFT", 2, 67)
	button:SetSize(35, 35)
	M.PixelIcon(button, texture, true)
	button.bg:SetBackdropBorderColor(iconColor.r, iconColor.g, iconColor.b)
	button:SetScript("OnEnter", function(self)
		GameTooltip:ClearLines()
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine(U["Account Keystones"])
		for fullName, info in pairs(MaoRUIDB["KeystoneInfo"]) do
			local name = Ambiguate(fullName, "none")
			local mapID, level, class, faction = strsplit(":", info)
			local color = M.HexRGB(M.ClassColor(class))
			local factionColor = faction == "Horde" and "|cffff5040" or "|cff00adf0"
			local dungeon = C_ChallengeMode_GetMapUIInfo(tonumber(mapID))
			GameTooltip:AddDoubleLine(format(color.."%s:|r", name), format("%s%s(%s)|r", factionColor, dungeon, level))
		end
		--GameTooltip:AddDoubleLine(" ", I.LineString)
		GameTooltip:AddDoubleLine(" ", I.ScrollButton..U["Reset Gold"].." ", 1,1,1, .6,.8,1)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", M.HideTooltip)
	button:SetScript("OnMouseUp", function(_, btn)
		if btn == "MiddleButton" then
			wipe(MaoRUIDB["KeystoneInfo"])
		end
	end)
end

function MISC:KeystoneInfo_UpdateBag()
	local keystoneMapID = C_MythicPlus_GetOwnedKeystoneChallengeMapID()
	if keystoneMapID then
		return keystoneMapID, C_MythicPlus_GetOwnedKeystoneLevel()
	end
end

function MISC:KeystoneInfo_Update()
	local mapID, keystoneLevel = MISC:KeystoneInfo_UpdateBag()
	if mapID then
		MaoRUIDB["KeystoneInfo"][myFullName] = mapID..":"..keystoneLevel..":"..I.MyClass..":"..I.MyFaction
	else
		MaoRUIDB["KeystoneInfo"][myFullName] = nil
	end
end

function MISC:GuildBest()
	hasAngryKeystones = IsAddOnLoaded("AngryKeystones")
	M:RegisterEvent("ADDON_LOADED", MISC.GuildBest_OnLoad)

	MISC:KeystoneInfo_Update()
	M:RegisterEvent("BAG_UPDATE", MISC.KeystoneInfo_Update)
end
MISC:RegisterMisc("GuildBest", MISC.GuildBest)