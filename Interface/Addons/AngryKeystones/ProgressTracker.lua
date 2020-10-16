local ADDON, Addon = ...
local Mod = Addon:NewModule('ProgressTracker')
Mod.playerDeaths = {}

local lastQuantity
local lastDied
local lastDiedName
local lastDiedTime
local lastAmount
local lastAmountTime
local lastQuantity

local PRIDEFUL_AFFIX_ID = 121

local progressPresets = {
	-- ͨ��ս��
	[166264] = 1, -- ���ò���
	[166266] = 1, -- ���ò���
	[165138] = 1, -- ����֮��
	[163623] = 3, -- ���²���
	[163622] = 3, -- ���ٲп�
	[162729] = 4, -- ����ά��ʿ��
	[165597] = 4, -- ����ά��ʿ��
	[163128] = 4, -- ������ķ˹��ʦ
	[163619] = 4, -- ������ķ˹�̹���
	[165222] = 4, -- ������ķ˹������
	[166302] = 4, -- ʬ���ո���
	[163121] = 5, -- ����ȷ�
	[173016] = 5, -- ʬ��ɼ���
	[165872] = 5, -- Ѫ�⹤��
	[165911] = 5, -- �ҳϵ�����
	[165137] = 6, -- ������ķ˹������
	[165919] = 6, -- ���ý�����
	[163618] = 8, -- ������ķ˹ͨ��ʦ
	[173044] = 8, -- �������
	[167731] = 8, -- ��������
	[172981] = 8, -- ������������
	[163620] = 8, -- ����
	[163621] = 8, -- ����
	[165824] = 10, -- �����
	[165197] = 10, -- ���Ǿ޹�
	-- ��������
	[166411] = 1, -- ���Ĵ�λ��
	[163503] = 2, -- ��̫������
	[163457] = 4, -- �����ȷ�
	[163459] = 4, -- ����������
	[163458] = 4, -- ����Ǵ����
	[163506] = 4, -- ����Ǳצʨ
	[163501] = 4, -- ����ɢ��
	[168420] = 4, -- ������ʿ
	[168418] = 4, -- �������й�
	[168718] = 4, -- ���Ŀ�����
	[168717] = 4, -- ���Ĳþ���
	[163524] = 5, -- ������ڰ��ö���
	[163520] = 6, -- ����С�ӳ�
	[168681] = 6, -- ���Ķ��
	[168318] = 8, -- ���ĸ�����
	[168425] = 8, -- ���ļ�����
	[168658] = 8, -- ���Ļ�����
	[168843] = 12, -- ������˹
	[168844] = 12, -- ������˹
	[168845] = 12, -- ��˹��ŵ˹
	-- ���ž糡
	[163089] = 1, -- ���ĵĲ���
	[169875] = 2, -- ����֮��
	[170838] = 4, -- �����Ĳ�����
	[174197] = 4, -- ս����ʦ
	[164510] = 4, -- ���ǵ�����
	[167994] = 4, -- �ǻ���Ԯ��
	[170690] = 4, -- Ⱦ����ħ
	[174210] = 4, -- ��������������
	[160495] = 4, -- ���ȵĸ�����
	[170882] = 4, -- �׹�ħ��ʦ
	[164506] = 5, -- �ϹŶӳ�
	[169927] = 5, -- �ȳ�����
	[169893] = 6, -- ���ӵİ�����
	[170850] = 7, -- ��ŭ��Ѫ��
	[163086] = 8, -- ���������ҹ�
	[167998] = 8, -- ����������
	[162763] = 8, -- �����׹Ǳ�֯��
	[167538] = 20, -- �б��߶����
	[167536] = 20, -- ��Ѫ�Ĺ�³����
	[167534] = 20, -- ���������
	-- �˽�
	[170486] = 1, -- �����������
	[170488] = 1, -- ����֮��
	[171341] = 1, -- ��๳���
	[168986] = 3, -- ����Ѹ����
	[171342] = 3, -- �������ĵ¹
	[164857] = 3, -- �ֹ�������
	[164861] = 3, -- �ֹ�Ƥ��
	[168949] = 4, -- ����������սʿ
	[168992] = 4, -- �����ļ�ʦ
	[164862] = 4, -- ��Ұ˸���
	[171181] = 4, -- �����๺�
	[170490] = 5, -- �������߽׼�˾
	[170480] = 5, -- ��������������
	[167963] = 5, -- ��ͷ���ն˻�
	[167965] = 5, -- ����
	[164873] = 5, -- ��Ƿ���ĵ¹
	[169905] = 6, -- �����Ķ���
	[168942] = 6, -- ������
	[170572] = 6, -- �������ֶ�����ʦ
	[171343] = 6, -- ��๺�ĸ
	[168934] = 7, -- ��ŭ֮��
	[167962] = 8, -- ʧ�������
	[167964] = 8, -- 4.RF-4.RF
	[171184] = 12, -- ��˹��ʲ�����֮צ
	-- �������
	[167610] = 1, -- ʯħ������
	[165415] = 2, -- �Ϳ�Ĺ���Ա
	[165515] = 4, -- ����ĺڰ���ʿ
	[164563] = 4, -- а��ļӶ���
	[164562] = 4, -- �����ѱȮ��
	[165414] = 4, -- ����ļ�����
	[174175] = 4, -- �ҳϵ�ʯ��ħ
	[165529] = 4, -- ������Ѽ���
	[167611] = 4, -- ʯ���޹���
	[167612] = 6, -- ʯ���Ӷ���
	[167607] = 7, -- ʯ���и���
	[164557] = 10, -- ��������˹����Ƭ
	[167876] = 20, -- ���й����Ӷ�
	-- �����Ԩ
	[168058] = 1, -- ע�ܵ�����
	[168457] = 1, -- ʯǽ�Ӷ���
	[171455] = 1, -- ʯǽ�Ӷ���
	[162056] = 1, -- ��ʯ�Ҿ�
	[167955] = 1, -- ���ѧԱ
	[162046] = 1, -- ������ʭ��
	[169753] = 1, -- ������ʭ��
	[167956] = 1, -- �ڰ�����
	[162051] = 2, -- ����ʳʬ��
	[162041] = 2, -- ����Ľ�����
	[171448] = 4, -- �ֲ������Դ�ʦ
	[172265] = 4, -- ��ŭ����
	[162049] = 4, -- ���ǲм�
	[171384] = 4, -- �о�����ʦ
	[171805] = 4, -- �о�����ʦ
	[165076] = 4, -- ̰ʳ��ʭ��
	[166396] = 4, -- ����ɢ��
	[162039] = 4, -- а�����ѹ��
	[168591] = 4, -- ̰���Ŀ־���
	[162057] = 7, -- �����ڱ�
	[162040] = 7, -- ��ල��
	[171799] = 7, -- ��Ԩ����
	[162038] = 7, -- �ʼ�������
	[164852] = 7, -- �ʼ�������
	[162047] = 7, -- ̰ʳ������
	[171376] = 10, -- ��ϯ�����߼Ӹ���
	-- ���֮��
	[168969] = 1, -- �籡����
	[163857] = 4, -- �򸿿�����
	[163892] = 6, -- ���õ��Һ֮צ
	[164705] = 6, -- ��Ⱦ����
	[163891] = 6, -- ��������
	[164707] = 6, -- ��������
	[169696] = 8, -- ���ʿ��
	[168580] = 8, -- �����
	[168361] = 8, -- ���Ӵ�Ʒ�
	[168578] = 8, -- ������ʿ
	[168572] = 8, -- ����͹���
	[168574] = 8, -- �������ո���
	[168891] = 8, -- �����ݵ������
	[168627] = 8, -- ħҩ������
	[167493] = 8, -- �綾�ѻ���
	[174802] = 8, -- �綾�ѻ���
	[163862] = 8, -- ���۷�����
	[163915] = 10, -- �׷�֮��
	[168022] = 10, -- ���ഥ��
	[168310] = 12, -- �������
	[168153] = 12, -- �������
	[168393] = 12, -- ħҩ������
	[168396] = 12, -- ħҩ������
	[173360] = 12, -- ħҩ������
	[163894] = 12, -- �����鼹��
	[164737] = 12, -- ��Ⱥ������
	[163882] = 14, -- ���õ�Ѫ�����
	[168886] = 25, -- ά³����˹ħҩ��֯��
	[169861] = 25, -- ���¶�������
	-- �������ֵ�����
	[167117] = 1, -- ׶���׳�
	[165111] = 2, -- ��³˹�ض�צ��
	[164920] = 4, -- ��³˹��ն����
	[172991] = 4, -- ��³˹��ն����
	[164921] = 4, -- ��³˹���ո���
	[163058] = 4, -- ɴ�������
	[171772] = 4, -- ɴ�������
	[166299] = 4, -- ɴ���տ���
	[166301] = 4, -- ɴ��׷����
	[166275] = 4, -- ɴ��������
	[166304] = 4, -- ɴ���̶�
	[166276] = 4, -- ɴ���ػ���
	[167113] = 4, -- ׶��������
	[172312] = 4, -- ׶��������
	[167116] = 4, -- ׶���Ӷ���
	[167111] = 5, -- ׶��¹�Ǿ޳�
	[164926] = 6, -- ��³˹����֦��
	[164929] = 7, -- ��ľ�־���(Ѫ��������80%)
	[173720] = 16, -- ɴ���ɺ���
	[173714] = 16, -- ɴ��ҹ��
--	[] = 16, -- ɴ����ĸ
}

local function ProcessLasts()
	if lastDied and lastDiedTime and lastAmount and lastAmountTime then
		if abs(lastAmountTime - lastDiedTime) < 0.1 then
			if not AngryKeystones_Data.progress[lastDied] then AngryKeystones_Data.progress[lastDied] = {} end
			if AngryKeystones_Data.progress[lastDied][lastAmount] then
				AngryKeystones_Data.progress[lastDied][lastAmount] = AngryKeystones_Data.progress[lastDied][lastAmount] + 1
			else
				AngryKeystones_Data.progress[lastDied][lastAmount] = 1
			end
			lastDied, lastDiedTime, lastAmount, lastAmountTime, lastDiedName = nil, nil, nil, nil, nil
		end
	end
end

function Mod:COMBAT_LOG_EVENT_UNFILTERED()
	local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10 = CombatLogGetCurrentEventInfo()
	if event == "UNIT_DIED" then
		if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_NPC) > 0
				and bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_NPC) > 0
				and (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 or bit.band(destFlags, COMBATLOG_OBJECT_REACTION_NEUTRAL) > 0) then
			local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", destGUID)
			lastDied = tonumber(npc_id)
			lastDiedTime = GetTime()
			lastDiedName = destName
			ProcessLasts()
		end
		if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
			if UnitIsFeignDeath(destName) then
				-- Feign Death
			elseif Mod.playerDeaths[destName] then
				Mod.playerDeaths[destName] = Mod.playerDeaths[destName] + 1
			else
				Mod.playerDeaths[destName] = 1
			end
			--Addon.ObjectiveTracker:UpdatePlayerDeaths()
		end
	end
end

function Mod:SCENARIO_CRITERIA_UPDATE()
	local scenarioType = select(10, C_Scenario.GetInfo())
	if scenarioType == LE_SCENARIO_TYPE_CHALLENGE_MODE then
		local numCriteria = select(3, C_Scenario.GetStepInfo())
		for criteriaIndex = 1, numCriteria do
			local criteriaString, criteriaType, _, quantity, totalQuantity, _, _, quantityString, _, _, _, _, isWeightedProgress = C_Scenario.GetCriteriaInfo(criteriaIndex)
			if isWeightedProgress then
				local currentQuantity = quantityString and tonumber( strsub(quantityString, 1, -2) )
				if lastQuantity and currentQuantity < totalQuantity and currentQuantity > lastQuantity then
					lastAmount = currentQuantity - lastQuantity
					lastAmountTime = GetTime()
					ProcessLasts()
				end
				lastQuantity = currentQuantity
			end
		end
	end
end

local function StartTime()
	Mod:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	local numCriteria = select(3, C_Scenario.GetStepInfo())
	for criteriaIndex = 1, numCriteria do
		local criteriaString, criteriaType, _, quantity, totalQuantity, _, _, quantityString, _, _, _, _, isWeightedProgress = C_Scenario.GetCriteriaInfo(criteriaIndex)
		if isWeightedProgress then
			local quantityString = select(8, C_Scenario.GetCriteriaInfo(criteriaIndex))
			lastQuantity = quantityString and tonumber( strsub(quantityString, 1, -2) )
		end
	end
end

local function StopTime()
	Mod:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

local function CheckTime(...)
	for i = 1, select("#", ...) do
		local timerID = select(i, ...)
		local _, elapsedTime, type = GetWorldElapsedTime(timerID)
		if type == LE_WORLD_ELAPSED_TIMER_TYPE_CHALLENGE_MODE then
			local mapID = C_ChallengeMode.GetActiveChallengeMapID()
			if mapID then
				StartTime()
				return
			end
		end
	end
	StopTime()
end

local function OnTooltipSetUnit(tooltip)
	local scenarioType = select(10, C_Scenario.GetInfo())
	if scenarioType == LE_SCENARIO_TYPE_CHALLENGE_MODE and Addon.Config.progressTooltip then
		local name, unit = tooltip:GetUnit()
		local guid = unit and UnitGUID(unit)
		if guid then
			local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-", guid)
			npc_id = tonumber(npc_id)
			local info = AngryKeystones_Data.progress[npc_id]
			local preset = progressPresets[npc_id]
			if info or preset then
				local numCriteria = select(3, C_Scenario.GetStepInfo())
				local total
				local progressName
				for criteriaIndex = 1, numCriteria do
					local criteriaString, _, _, quantity, totalQuantity, _, _, quantityString, _, _, _, _, isWeightedProgress = C_Scenario.GetCriteriaInfo(criteriaIndex)
					if isWeightedProgress then
						progressName = criteriaString
						total = totalQuantity
					end
				end

				local value, valueCount
				if info then
					for amount, count in pairs(info) do
						if not valueCount or count > valueCount or (count == valueCount and amount < value) then
							value = amount
							valueCount = count
						end
					end
				end
				if preset and (not value or valueCount == 1) then
					value = preset
				end
				if value and total then
					local forcesFormat = format(" - %s: %%s", progressName)
					local text
					if Addon.Config.progressFormat == 1 or Addon.Config.progressFormat == 4 then
						text = format( format(forcesFormat, "+%.2f%%"), value/total*100)
					elseif Addon.Config.progressFormat == 2 or Addon.Config.progressFormat == 5 then
						text = format( format(forcesFormat, "+%d"), value)
					elseif Addon.Config.progressFormat == 3 or Addon.Config.progressFormat == 6 then
						text = format( format(forcesFormat, "+%.2f%% - +%d"), value/total*100, value)
					end

					if text then
						local matcher = format(forcesFormat, "%d+%%")
						for i=2, tooltip:NumLines() do
							local tiptext = _G["GameTooltipTextLeft"..i]
							local linetext = tiptext and tiptext:GetText()

							if linetext and linetext:match(matcher) then
								tiptext:SetText(text)
								tooltip:Show()
							end
						end
					end
				end
			end
		end
	end
end

function Mod:GeneratePreset()
	local ret = {}
	for npcID, info in pairs(AngryKeystones_Data.progress) do
		local value, valueCount
		for amount, count in pairs(info) do
			if not valueCount or count > valueCount or (count == valueCount and amount < value) then
				value = amount
				valueCount = count
			end
		end
		ret[npcID] = value
	end
	AngryKeystones_Data.preset = ret
	return ret
end

function Mod:PLAYER_ENTERING_WORLD(...) CheckTime(GetWorldElapsedTimers()) end
function Mod:WORLD_STATE_TIMER_START(...) local timerID = ...; CheckTime(timerID) end
function Mod:WORLD_STATE_TIMER_STOP(...) local timerID = ...; StopTime(timerID) end
function Mod:CHALLENGE_MODE_START(...) CheckTime(GetWorldElapsedTimers()) end
function Mod:CHALLENGE_MODE_RESET(...) wipe(Mod.playerDeaths) end

local function ProgressBar_SetValue(self, percent)
	if self.criteriaIndex then
		local _, _, _, _, totalQuantity, _, _, quantityString, _, _, _, _, _ = C_Scenario.GetCriteriaInfo(self.criteriaIndex)
		local currentQuantity = quantityString and tonumber( strsub(quantityString, 1, -2) )
		if currentQuantity and totalQuantity then
			if Addon.Config.progressFormat == 1 then
				self.Bar.Label:SetFormattedText("%.2f%%", currentQuantity/totalQuantity*100)
			elseif Addon.Config.progressFormat == 2 then
				self.Bar.Label:SetFormattedText("%d/%d", currentQuantity, totalQuantity)
			elseif Addon.Config.progressFormat == 3 then
				self.Bar.Label:SetFormattedText("%.2f%% - %d/%d", currentQuantity/totalQuantity*100, currentQuantity, totalQuantity)
			elseif Addon.Config.progressFormat == 4 then
				self.Bar.Label:SetFormattedText("%.2f%% (%.2f%%)", currentQuantity/totalQuantity*100, (totalQuantity-currentQuantity)/totalQuantity*100)
			elseif Addon.Config.progressFormat == 5 then
				self.Bar.Label:SetFormattedText("%d/%d (%d)", currentQuantity, totalQuantity, totalQuantity - currentQuantity)
			elseif Addon.Config.progressFormat == 6 then
				self.Bar.Label:SetFormattedText("%.2f%% (%.2f%%) - %d/%d (%d)", currentQuantity/totalQuantity*100, (totalQuantity-currentQuantity)/totalQuantity*100, currentQuantity, totalQuantity, totalQuantity - currentQuantity)
			end
		end

		local isPridefulActive = false
		local _, affixes = C_ChallengeMode.GetActiveKeystoneInfo()
		if affixes then
			for i = 1, #affixes do
				if affixes[i] == PRIDEFUL_AFFIX_ID then
					isPridefulActive = true
				end
			end
		end

		if isPridefulActive and currentQuantity < totalQuantity then
			if not self.ReapingFrame then
				local reapingFrame = CreateFrame("Frame", nil, self)
				reapingFrame:SetSize(56, 16)
				reapingFrame:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 0, 0)
		
				reapingFrame.Icon = CreateFrame("Frame", nil, reapingFrame, "ScenarioChallengeModeAffixTemplate")
				reapingFrame.Icon:SetPoint("LEFT", reapingFrame, "LEFT", 0, 0)
				reapingFrame.Icon:SetSize(14, 14)
				reapingFrame.Icon.Portrait:SetSize(12, 12)
				reapingFrame.Icon:SetUp(PRIDEFUL_AFFIX_ID)

				reapingFrame.Text = reapingFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
				reapingFrame.Text:SetPoint("LEFT", reapingFrame.Icon, "RIGHT", 4, 0)

				self.ReapingFrame = reapingFrame

				self:HookScript("OnShow", function(self) self.ReapingFrame:Show(); self.ReapingFrame.Icon:Show() end )
				self:HookScript("OnHide", function(self) self.ReapingFrame:Hide(); self.ReapingFrame.Icon:Hide() end )
			end
			local threshold = totalQuantity / 5
			local current = currentQuantity
			local value = threshold - current % threshold
			local total = totalQuantity
			if Addon.Config.progressFormat == 1 or Addon.Config.progressFormat == 4 then
				self.ReapingFrame.Text:SetFormattedText("%.2f%%", value/total*100)
			elseif Addon.Config.progressFormat == 2 or Addon.Config.progressFormat == 5 then
				self.ReapingFrame.Text:SetFormattedText("%d", ceil(value))
			elseif Addon.Config.progressFormat == 3 or Addon.Config.progressFormat == 6 then
				self.ReapingFrame.Text:SetFormattedText("%.2f%% - %d", value/total*100, ceil(value))
			else
				self.ReapingFrame.Text:SetFormattedText("%d%%", value/total*100)
			end
			self.ReapingFrame:Show()
			self.ReapingFrame.Icon:Show()
		elseif self.ReapingFrame then
			self.ReapingFrame:Hide()
			self.ReapingFrame.Icon:Hide()
		end
	end
end

local function DeathCount_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:SetText(CHALLENGE_MODE_DEATH_COUNT_TITLE:format(self.count), 1, 1, 1)
	GameTooltip:AddLine(CHALLENGE_MODE_DEATH_COUNT_DESCRIPTION:format(SecondsToClock(self.timeLost, false)))

	GameTooltip:AddLine(" ")
	local list = {}
	local deathsCount = 0
	for unit,count in pairs(Mod.playerDeaths) do
		local _, class = UnitClass(unit)
		deathsCount = deathsCount + count
		table.insert(list, { count = count, unit = unit, class = class })
	end
	table.sort(list, function(a, b)
		if a.count ~= b.count then
			return a.count > b.count
		else
			return a.unit < b.unit
		end
	end)

	for _,item in ipairs(list) do
		local color = RAID_CLASS_COLORS[item.class] or HIGHLIGHT_FONT_COLOR
		GameTooltip:AddDoubleLine(item.unit, item.count, color.r, color.g, color.b, HIGHLIGHT_FONT_COLOR:GetRGB())
	end
	GameTooltip:Show()
end

function Mod:Blizzard_ObjectiveTracker()
	ScenarioChallengeModeBlock.DeathCount:SetScript("OnEnter", DeathCount_OnEnter)
end

function Mod:Startup()
	if not AngryKeystones_Data then
		AngryKeystones_Data = {}
	end
	if not AngryKeystones_Data.progress then
		AngryKeystones_Data = { progress = AngryKeystones_Data }
	end
	if not AngryKeystones_Data.state then AngryKeystones_Data.state = {} end
	local mapID = C_ChallengeMode.GetActiveChallengeMapID()
	if select(10, C_Scenario.GetInfo()) == LE_SCENARIO_TYPE_CHALLENGE_MODE and mapID and mapID == AngryKeystones_Data.state.mapID and AngryKeystones_Data.state.playerDeaths then
		Mod.playerDeaths = AngryKeystones_Data.state.playerDeaths
	else
		AngryKeystones_Data.state.mapID = nil
		AngryKeystones_Data.state.playerDeaths = Mod.playerDeaths
	end

	self:RegisterEvent("SCENARIO_CRITERIA_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("WORLD_STATE_TIMER_START")
	self:RegisterEvent("WORLD_STATE_TIMER_STOP")
	self:RegisterEvent("CHALLENGE_MODE_START")
	self:RegisterEvent("CHALLENGE_MODE_RESET")
	self:RegisterAddOnLoaded("Blizzard_ObjectiveTracker")
	CheckTime(GetWorldElapsedTimers())
	GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)

	Addon.Config:RegisterCallback('progressFormat', function()
		local usedBars = SCENARIO_TRACKER_MODULE.usedProgressBars[ScenarioObjectiveBlock] or {}
		for _, bar in pairs(usedBars) do
			ProgressBar_SetValue(bar)
		end
	end)
end

hooksecurefunc("ScenarioTrackerProgressBar_SetValue", ProgressBar_SetValue)
