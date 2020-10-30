local _, ns = ...
local M, R, U, I = unpack(ns)
local MISC = M:GetModule("Misc")

local strmatch, strfind, gsub, format = string.match, string.find, string.gsub, string.format
local wipe, mod, tonumber, pairs, floor = wipe, mod, tonumber, pairs, math.floor
local IsPartyLFG, IsInRaid, IsInGroup, PlaySound, SendChatMessage = IsPartyLFG, IsInRaid, IsInGroup, PlaySound, SendChatMessage
local C_QuestLog_GetInfo = C_QuestLog.GetInfo
local C_QuestLog_IsComplete = C_QuestLog.IsComplete
local C_QuestLog_IsWorldQuest = C_QuestLog.IsWorldQuest
local C_QuestLog_GetQuestTagInfo = C_QuestLog.GetQuestTagInfo
local C_QuestLog_GetTitleForQuestID = C_QuestLog.GetTitleForQuestID
local C_QuestLog_GetQuestIDForLogIndex = C_QuestLog.GetQuestIDForLogIndex
local C_QuestLog_GetNumQuestLogEntries = C_QuestLog.GetNumQuestLogEntries
local C_QuestLog_GetLogIndexForQuestID = C_QuestLog.GetLogIndexForQuestID
local soundKitID = SOUNDKIT.ALARM_CLOCK_WARNING_3
local QUEST_COMPLETE = QUEST_COMPLETE
local LE_QUEST_TAG_TYPE_PROFESSION = Enum.QuestTagType.Profession
local LE_QUEST_FREQUENCY_DAILY = Enum.QuestFrequency.Daily

local completedQuest, initComplete = {}

local function acceptText(title, daily)
	if daily then
		return format("|cFFFFFF00[%s]|r%s-%s", DAILY, GARRISON_START_MISSION, title)
	else
		return format("%s-%s", ACCEPT..GARRISON_MISSIONS, title)  --"→"
	end
end

local function completeText(title)
	PlaySound(soundKitID, "Master")  --PlaySoundFile("Interface\\Addons\\_ShiGuang\\Media\\Sounds\\QuestNotifier.ogg", "Master")
	return format("%s-%s", QUEST_COMPLETE, title)  --"✓"
end

local function sendQuestMsg(msg)
	if MaoRUIPerDB["Misc"]["OnlyCompleteRing"] then return end

	if IsPartyLFG() then
		SendChatMessage(msg, "INSTANCE_CHAT")
	--elseif IsInRaid() then
		--SendChatMessage(msg, "RAID")
	elseif IsInGroup() and not IsInRaid() then
		SendChatMessage(msg, "PARTY")
	end
end

local function getPattern(pattern)
	pattern = gsub(pattern, "%(", "%%%1")
	pattern = gsub(pattern, "%)", "%%%1")
	pattern = gsub(pattern, "%%%d?$?.", "(.+)")
	return format("^%s$", pattern)
end

local questMatches = {
	["Found"] = getPattern(ERR_QUEST_ADD_FOUND_SII),
	["Item"] = getPattern(ERR_QUEST_ADD_ITEM_SII),
	["Kill"] = getPattern(ERR_QUEST_ADD_KILL_SII),
	["PKill"] = getPattern(ERR_QUEST_ADD_PLAYER_KILL_SII),
	["ObjectiveComplete"] = getPattern(ERR_QUEST_OBJECTIVE_COMPLETE_S),
	["QuestComplete"] = getPattern(ERR_QUEST_COMPLETE_S),
	["QuestFailed"] = getPattern(ERR_QUEST_FAILED_S),
}

function MISC:FindQuestProgress(_, msg)
	if not MaoRUIPerDB["Misc"]["QuestProgress"] then return end
	if MaoRUIPerDB["Misc"]["OnlyCompleteRing"] then return end

	for _, pattern in pairs(questMatches) do
		if strmatch(msg, pattern) then
			local _, _, _, cur, max = strfind(msg, "(.*)[:]%s*([-%d]+)%s*/%s*([-%d]+)%s*$")
			cur, max = tonumber(cur), tonumber(max)
			if cur and max and max >= 10 then
				if mod(cur, floor(max/5)) == 0 then
					sendQuestMsg(msg)
				end
			else
				sendQuestMsg(msg)
			end
			break
		end
	end
end

function MISC:FindQuestAccept(questID)
	local tagInfo = C_QuestLog_GetQuestTagInfo(questID)
	if tagInfo and tagInfo.worldQuestType == LE_QUEST_TAG_TYPE_PROFESSION then return end

	local questLogIndex = C_QuestLog_GetLogIndexForQuestID(questID)
	if questLogIndex then
		local info = C_QuestLog_GetInfo(questLogIndex)
		if info then
			sendQuestMsg(acceptText(info.title, info.frequency == LE_QUEST_FREQUENCY_DAILY))
		end
	end
end

function MISC:FindQuestComplete()
	for i = 1, C_QuestLog_GetNumQuestLogEntries() do
		local questID = C_QuestLog_GetQuestIDForLogIndex(i)
		local title = C_QuestLog_GetTitleForQuestID(questID)
		local isComplete = C_QuestLog_IsComplete(questID)
		local isWorldQuest = C_QuestLog_IsWorldQuest(questID)
		if title and isComplete and not completedQuest[questID] and not isWorldQuest then
			if initComplete then
				sendQuestMsg(completeText(title))
			end
			completedQuest[questID] = true
		end
	end
	initComplete = true
end

function MISC:FindWorldQuestComplete(questID)
	if C_QuestLog_IsWorldQuest(questID) then
		local title = C_QuestLog_GetTitleForQuestID(questID)
		if title and not completedQuest[questID] then
			sendQuestMsg(completeText(title))
			completedQuest[questID] = true
		end
	end
end

function MISC:QuestNotification()
	if MaoRUIPerDB["Misc"]["QuestNotification"] then
		M:RegisterEvent("QUEST_ACCEPTED", MISC.FindQuestAccept)
		M:RegisterEvent("QUEST_LOG_UPDATE", MISC.FindQuestComplete)
		M:RegisterEvent("QUEST_TURNED_IN", MISC.FindWorldQuestComplete)
		M:RegisterEvent("UI_INFO_MESSAGE", MISC.FindQuestProgress)
	else
		wipe(completedQuest)
		M:UnregisterEvent("QUEST_ACCEPTED", MISC.FindQuestAccept)
		M:UnregisterEvent("QUEST_LOG_UPDATE", MISC.FindQuestComplete)
		M:UnregisterEvent("QUEST_TURNED_IN", MISC.FindWorldQuestComplete)
		M:UnregisterEvent("UI_INFO_MESSAGE", MISC.FindQuestProgress)
	end
end
MISC:RegisterMisc("QuestNotification", MISC.QuestNotification)