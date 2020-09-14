﻿--## Author: Caerdon ## SavedVariables: CaerdonWardrobeConfig  ## Version: v2.8.0

if GetLocale() == "zhCN" then
  CaerdonWardrobeBoA = "|cffe6cc80战网|r";
  CaerdonWardrobeBoE = "|cff1eff00装绑|r";
elseif GetLocale() == "zhTW" then
  CaerdonWardrobeBoA = "|cffe6cc80战网|r";
  CaerdonWardrobeBoE = "|cff1eff00装绑|r";
else
  CaerdonWardrobeBoA = "|cffe6cc80BoA|r";
  CaerdonWardrobeBoE = "|cff1eff00BoE|r";
end

local isBagUpdate = false
local ignoreDefaultBags = false

local version, build, date, tocversion = GetBuildInfo()
local isShadowlands = tonumber(build) > 35700

CaerdonWardrobeNS = {}
CaerdonWardrobe = {}
CaerdonWardrobeMixin = {}

function CaerdonWardrobeMixin:OnLoad()
	self:RegisterEvent("ADDON_LOADED")
	self:RegisterEvent("PLAYER_LOGOUT")
	self:RegisterEvent("AUCTION_HOUSE_BROWSE_RESULTS_UPDATED")
	self:RegisterEvent("AUCTION_HOUSE_SHOW")
	self:RegisterEvent("BAG_OPEN")
	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("BAG_UPDATE_DELAYED")
	self:RegisterEvent("BANKFRAME_OPENED")
	-- self:RegisterEvent("GET_ITEM_INFO_RECEIVED")
	self:RegisterEvent("TRANSMOG_COLLECTION_UPDATED")
	-- self:RegisterEvent("TRANSMOG_COLLECTION_ITEM_UPDATE")
	self:RegisterEvent("EQUIPMENT_SETS_CHANGED")
	self:RegisterEvent("UPDATE_EXPANSION_LEVEL")
	self:RegisterEvent("MERCHANT_UPDATE")
	self:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")
	self:RegisterEvent("PLAYER_LOGIN")
end
local bindTextTable = {
	[ITEM_ACCOUNTBOUND]        = CaerdonWardrobeBoA,
	[ITEM_BNETACCOUNTBOUND]    = CaerdonWardrobeBoA,
	[ITEM_BIND_TO_ACCOUNT]     = CaerdonWardrobeBoA,
	[ITEM_BIND_TO_BNETACCOUNT] = CaerdonWardrobeBoA,
	--[ITEM_BIND_ON_EQUIP]       = CaerdonWardrobeBoE,
	--[ITEM_BIND_ON_USE]         = CaerdonWardrobeBoE,
	[ITEM_SOULBOUND]           = "|cFF00DDFF    _|r",  -- 拾取后绑定
	[ITEM_BIND_ON_PICKUP]      = "|cFF00DDFF    _|r",
}

local InventorySlots = {
    ['INVTYPE_HEAD'] = INVSLOT_HEAD,
    ['INVTYPE_SHOULDER'] = INVSLOT_SHOULDER,
    ['INVTYPE_BODY'] = INVSLOT_BODY,
    ['INVTYPE_CHEST'] = INVSLOT_CHEST,
    ['INVTYPE_ROBE'] = INVSLOT_CHEST,
    ['INVTYPE_WAIST'] = INVSLOT_WAIST,
    ['INVTYPE_LEGS'] = INVSLOT_LEGS,
    ['INVTYPE_FEET'] = INVSLOT_FEET,
    ['INVTYPE_WRIST'] = INVSLOT_WRIST,
    ['INVTYPE_HAND'] = INVSLOT_HAND,
    ['INVTYPE_CLOAK'] = INVSLOT_BACK,
    ['INVTYPE_WEAPON'] = INVSLOT_MAINHAND,
    ['INVTYPE_SHIELD'] = INVSLOT_OFFHAND,
    ['INVTYPE_2HWEAPON'] = INVSLOT_MAINHAND,
    ['INVTYPE_WEAPONMAINHAND'] = INVSLOT_MAINHAND,
    ['INVTYPE_RANGED'] = INVSLOT_MAINHAND,
    ['INVTYPE_RANGEDRIGHT'] = INVSLOT_MAINHAND,
    ['INVTYPE_WEAPONOFFHAND'] = INVSLOT_OFFHAND,
    ['INVTYPE_HOLDABLE'] = INVSLOT_OFFHAND,
    ['INVTYPE_TABARD'] = INVSLOT_TABARD
}

local model = CreateFrame('DressUpModel')

local function GetItemID(itemLink)
	if not itemLink then
		return nil
	end

	return tonumber(itemLink:match("item:(%d+)") or itemLink:match("battlepet:(%d+)"))
end

local function IsConduit(itemLink)
	return isShadowlands and C_Soulbinds.IsItemConduitByItemInfo(itemLink)
end

local function IsPetLink(itemLink)
	local isPet = LinkUtil.IsLinkType(itemLink, "battlepet")
	local itemID = GetItemID(itemLink)
	if isPet then
		return true
	elseif itemID == 82800 then
		return true -- It's showing up as [Pet Cage] for whatever reason
	elseif( itemLink ) then 
		local _, _, _, linkType, linkID, _, _, _, _, _, battlePetID, battlePetDisplayID = strsplit(":|H", itemLink);
		if ( linkType == "item") then
			local _, _, _, creatureID, _, _, _, _, _, _, _, displayID, speciesID = C_PetJournal.GetPetInfoByItemID(tonumber(linkID));
			if (creatureID and displayID) then
				return true;
			end
		elseif ( linkType == "battlepet" ) then
			if battlePetID and battlePetID ~= "" and battlePetID ~= "0" then
				local speciesID, _, _, _, _, displayID, _, _, _, _, creatureID = C_PetJournal.GetPetInfoByPetID(battlePetID);
				if ( speciesID == tonumber(linkID)) then
					if (creatureID and displayID) then
						return true;
					end	
				else
					speciesID = tonumber(linkID);
					local _, _, _, creatureID, _, _, _, _, _, _, _, displayID = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
					displayID = (battlePetDisplayID and battlePetDisplayID ~= "0") and battlePetDisplayID or displayID;
					if (creatureID and displayID) then
						return true;
					end	
				end
			else
				-- Mostly in place as a hack for bad battlepet links from addons
				speciesID = tonumber(linkID);
				local _, _, _, creatureID, _, _, _, _, _, _, _, displayID = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
				displayID = (battlePetDisplayID and battlePetDisplayID ~= "0") and battlePetDisplayID or displayID;
				if (creatureID and displayID) then
					return true;
				end	
			end
		end
	end

	return false
end

local function IsMountLink(itemLink)
	local isMount = false
	local itemName, itemLinkInfo, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, 
isCraftingReagent = GetItemInfo(itemLink)
	if itemClassID == LE_ITEM_CLASS_MISCELLANEOUS and itemSubClassID == LE_ITEM_MISCELLANEOUS_MOUNT then
		isMount = true
	end

	return isMount
end

local function IsToyLink(itemLink)
	local isToy = false
	local itemID = GetItemID(itemLink)
	if itemID then
		local itemIDInfo, toyName, icon = C_ToyBox.GetToyInfo(itemID)
	  	if (itemIDInfo and toyName) then
			isToy = true
		end
	end

	return isToy
end

local function IsRecipeLink(itemLink)
	local isRecipe = false
	local itemName, itemLinkInfo, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, 
isCraftingReagent = GetItemInfo(itemLink)

	if itemClassID == LE_ITEM_CLASS_RECIPE then
		isRecipe = true
	end

	return isRecipe
end

local function IsCollectibleLink(itemLink)
	return IsPetLink(itemLink) or IsMountLink(itemLink) or IsToyLink(itemLink) or IsRecipeLink(itemLink)
end

local function IsDressableItemCheck(itemID, itemLink)
	local isDressable = true
	local shouldRetry = false
	local slot

	local _, _, _, slotName = GetItemInfoInstant(itemID)
	if slotName and slotName ~= "" then -- make sure it's a supported slot
		slot = InventorySlots[slotName]
		if not slot then
			isDressable = false
		elseif not IsDressableItem(itemLink) then
			-- IsDressableItem can return false instead of true for
			-- an item that is actually dressable (seems to happen
			-- most often during item caching).  Adding some
			-- retry tags to the cache if IsDressableItem says its
			-- not but transmog says it can be a source
			local canBeChanged, noChangeReason, canBeSource, noSourceReason = C_Transmog.GetItemInfo(itemID)
			isDressable = false
			if canBeSource then
				shouldRetry = true
			end
		end
	else
		isDressable = false
	end

	return isDressable, shouldRetry, slot
end

local function GetItemSource(itemID, itemLink)
	local itemSources
	local isDressable, shouldRetry, slot = IsDressableItemCheck(itemID, itemLink)
	if not shouldRetry then
		if isDressable then
			-- Looks like I can use this now.  Keeping the old code around for a bit just in case.
			-- Actually, still seeing problems with this...try it first but fallback to model
			-- I've tried several times to remove this.  Seems to work at first.. but then...
			local appearanceID, sourceID, arg1, arg2 = C_TransmogCollection.GetItemInfo(itemLink)
			if sourceID then
				itemSources = sourceID
			else
			    model:SetUnit('player')
			    model:Undress()
			    model:TryOn(itemLink, slot)
			    itemSources = model:GetSlotTransmogSources(slot)
			end
		end
	end

	return itemSources, shouldRetry
end

local function GetItemAppearance(itemID, itemLink)
	local categoryID, appearanceID, canEnchant, texture, isCollected, sourceItemLink
	local sourceID, shouldRetry = GetItemSource(itemID, itemLink)

    if sourceID and sourceID ~= NO_TRANSMOG_SOURCE_ID then
        categoryID, appearanceID, canEnchant, texture, isCollected, sourceItemLink, _, _, appearanceSubclass = C_TransmogCollection.GetAppearanceSourceInfo(sourceID)
		if sourceItemLink then
			local _, _, quality = GetItemInfo(sourceItemLink)
			-- Skip artifact weapons and common for now
			if quality == Enum.ItemQuality.Common then
	 			appearanceID = nil
	 			isCollected = false
	 			sourceID = NO_TRANSMOG_SOURCE_ID
			end
		end
	end

    return appearanceID, isCollected, sourceID, shouldRetry
end

local function PlayerHasAppearance(appearanceID)
	local hasAppearance = false

    local sources = C_TransmogCollection.GetAllAppearanceSources(appearanceID)
    local matchedSource
    if sources then
		for i, sourceID in pairs(sources) do
			if sourceID and sourceID ~= NO_TRANSMOG_SOURCE_ID then
				local categoryID, appearanceID, canEnchant, texture, isCollected, sourceItemLink = C_TransmogCollection.GetAppearanceSourceInfo(sourceID)

				if isCollected then
					matchedSource = source
					hasAppearance = true
					break
				end
			end
        end
    end

    return hasAppearance, matchedSource
end
 
local function PlayerCanCollectAppearance(sourceID, appearanceID, itemID, itemLink)
	local _, _, quality, _, reqLevel, itemClass, itemSubClass, _, equipSlot, _, _, itemClassID, itemSubClassID = GetItemInfo(itemID)
	local playerLevel = UnitLevel("player")
	local canCollect = false
	local isInfoReady
	local matchedSource
	local shouldRetry

	local playerClass = select(2, UnitClass("player"))

	local classArmor;
	if playerClass == "MAGE" or 
		playerClass == "PRIEST" or 
		playerClass == "WARLOCK" then
		classArmor = LE_ITEM_ARMOR_CLOTH
	elseif playerClass == "DEMONHUNTER" or
		playerClass == "DRUID" or 
		playerClass == "MONK" or
		playerClass == "ROGUE" then
		classArmor = LE_ITEM_ARMOR_LEATHER
	elseif playerClass == "DEATHKNIGHT" or
		playerClass == "PALADIN" or
		playerClass == "WARRIOR" then
		classArmor = LE_ITEM_ARMOR_PLATE
	elseif playerClass == "HUNTER" or 
		playerClass == "SHAMAN" then
		classArmor = LE_ITEM_ARMOR_MAIL
	end

	-- if playerLevel >= reqLevel then
		isInfoReady, canCollect = C_TransmogCollection.PlayerCanCollectSource(sourceID)
		matchedSource = source
	    -- local sources = C_TransmogCollection.GetAppearanceSources(appearanceID)
	    -- if sources then
	    --     for i, source in pairs(sources) do
		-- 		isInfoReady, canCollect = C_TransmogCollection.PlayerCanCollectSource(source.sourceID)
	    --         if isInfoReady then
	    --         	if canCollect then
		--             	matchedSource = source
		--             end
	    --             break
	    --         else
	    --         	shouldRetry = true
	    --         end
	    --     end
		-- else
		-- end
	-- end

	if equipSlot ~= "INVTYPE_CLOAK"
		and itemClassID == LE_ITEM_CLASS_ARMOR and 
		(	itemSubClassID == LE_ITEM_ARMOR_CLOTH or 
			itemSubClassID == LE_ITEM_ARMOR_LEATHER or 
			itemSubClassID == LE_ITEM_ARMOR_MAIL or
			itemSubClassID == LE_ITEM_ARMOR_PLATE)
		and itemSubClassID ~= classArmor then 
			canCollect = false
	end

    return canCollect, matchedSource, shouldRetry
end

local function GetItemKey(bag, slot, itemLink)
	local itemKey
	if bag == "AuctionFrame" then
		itemKey = itemLink .. slot.index
	elseif bag == "MerchantFrame" then
		itemKey = itemLink .. slot
	elseif bag == "GuildBankFrame" then
		itemKey = itemLink .. slot.tab .. slot.index
	elseif bag == "EncounterJournal" then
		itemKey = itemLink .. bag .. slot.index
	elseif bag == "QuestButton" then
		itemKey = itemLink .. bag
	elseif bag == "LootFrame" or bag == "GroupLootFrame" then
		itemKey = itemLink
	elseif bag == "OpenMailFrame" or bag == "SendMailFrame" or bag == "InboxFrame" then
		itemKey = itemLink .. slot
	elseif bag == "BlackMarketScrollFrame" then
		itemKey = itemLink .. slot
	else
		itemKey = itemLink .. tostring(bag) .. tostring(slot)
	end

	return itemKey
end

local equipLocations = {}

local function GetBindingStatus(bag, slot, itemID, itemLink)
	local scanTip = CaerdonWardrobeFrameTooltip
	scanTip:ClearLines()
	-- Weird bug with scanning tooltips - have to disable showing
	-- transmog info during the scan
	C_TransmogCollection.SetShowMissingSourceInItemTooltips(false)
	SetCVar("missingTransmogSourceInItemTooltips", 0)
	local originalAlwaysCompareItems = GetCVarBool("alwaysCompareItems")
	SetCVar("alwaysCompareItems", 0)

	local itemKey = GetItemKey(bag, slot, itemLink)

	local binding
	local bindingText, needsItem, hasUse

    local isInEquipmentSet = false
	local isBindOnPickup = false
	local isBindOnUse = false
	local isSoulbound = false
	local isCompletionistItem = false
	local matchesLootSpec = true
	local unusableItem = false
	local skillTooLow = false
	local foundRedRequirements = false
	local isDressable, shouldRetry
	local isLocked = false
	
	local tooltipSpeciesID = 0

	local isCollectionItem = IsCollectibleLink(itemLink)
	local isRecipe = IsRecipeLink(itemLink)
	local isPetLink = IsPetLink(itemLink)

    local shouldCheckEquipmentSet = false

   	if isCollectionItem then
		isDressable = false
		shouldRetry = false
	else
		isDressable, shouldRetry = IsDressableItemCheck(itemID, itemLink)
	end

	local playerSpec = GetSpecialization();
	local playerClassID = select(3, UnitClass("player")) 
	local playerSpecID = -1
	if (playerSpec) then
		playerSpecID = GetSpecializationInfo(playerSpec, nil, nil, nil, UnitSex("player"));
	end
	local playerLootSpecID = GetLootSpecialization()
	if playerLootSpecID == 0 then
		playerLootSpecID = playerSpecID
	end

	if not shouldRetry then
		needsItem = true
		if bag == "AuctionFrame" then
			local itemKey = slot.itemKey
			scanTip:SetItemKey(itemKey.itemID, itemKey.itemLevel, itemKey.itemSuffix)
			tooltipSpeciesID = itemKey.battlePetSpeciesID
		elseif bag == "MerchantFrame" then
			if MerchantFrame.selectedTab == 1 then
         		scanTip:SetMerchantItem(slot)
			else
         		scanTip:SetBuybackItem(slot)
			end
		elseif bag == "ItemLink" then
			scanTip:SetHyperlink(itemLink)
		elseif bag == BANK_CONTAINER then
			local hasItem, hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name = scanTip:SetInventoryItem("player", BankButtonIDToInvSlotID(slot))
			tooltipSpeciesID = speciesID
		   	if not isCollectionItem then
				shouldCheckEquipmentSet = true
			end
		elseif bag == REAGENTBANK_CONTAINER then
			local hasItem, hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name = scanTip:SetInventoryItem("player", ReagentBankButtonIDToInvSlotID(slot))
		elseif bag == "GuildBankFrame" then
			local speciesID, level, breedQuality, maxHealth, power, speed, name = scanTip:SetGuildBankItem(slot.tab, slot.index)
			tooltipSpeciesID = speciesID
		elseif bag == "LootFrame" then
			scanTip:SetLootItem(slot.index)
		elseif bag == "GroupLootFrame" then
			scanTip:SetLootRollItem(slot.index)
		elseif bag == "OpenMailFrame" then
			local hasCooldown, speciesID, level, breedQuality, maxHealth, power, speed, name = scanTip:SetInboxItem(InboxFrame.openMailID, slot)
			tooltipSpeciesID = speciesID
		elseif bag == "SendMailFrame" then
			local hasCooldown, speciesID, level, breedQuality, maxHealth, power, speed, name = scanTip:SetSendMailItem(slot)
			tooltipSpeciesID = speciesID
		elseif bag == "InboxFrame" then
			local hasCooldown, speciesID, level, breedQuality, maxHealth, power, speed, name = scanTip:SetInboxItem(slot);
			tooltipSpeciesID = speciesID
		elseif bag == "BlackMarketScrollFrame" then
			scanTip:SetHyperlink(itemLink)
		elseif bag == "EncounterJournal" then
			local classID, specID = EJ_GetLootFilter();
			if (specID == 0) then
				if (playerSpec and classID == playerClassID) then
					specID = playerSpecID
				else
					specID = -1;
				end
			end
			scanTip:SetHyperlink(itemLink, classID, specID)

			local specTable = GetItemSpecInfo(itemLink)
			if specTable then
				for specIndex = 1, #specTable do
					matchesLootSpec = false

					local validSpecID = GetSpecializationInfo(specIndex, nil, nil, nil, UnitSex("player"));
					if validSpecID == playerLootSpecID then
						matchesLootSpec = true
						break
					end
				end
			end
		elseif bag == "QuestButton" then
			if slot.questItem ~= nil and slot.questItem.type ~= nil then
				if QuestInfoFrame.questLog then
					scanTip:SetQuestLogItem(slot.questItem.type, slot.index, slot.questID)
				else
					scanTip:SetQuestItem(slot.questItem.type, slot.index, slot.questID)
				end
			else
				GameTooltip_AddQuestRewardsToTooltip(scanTip, slot.questID)
				scanTip = scanTip.ItemTooltip.Tooltip
			end
		else
			local hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name = scanTip:SetBagItem(bag, slot)
			tooltipSpeciesID = speciesID
			if not isCollectionItem then
				shouldCheckEquipmentSet = true
			end
		end

		local itemName, itemLinkInfo, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
		itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, 
		isCraftingReagent = GetItemInfo(itemLink)

		isBindOnPickup = bindType == 1
		if bindType == 1 then -- BoP
			isBindOnPickup = true
		elseif bindType == 2 then -- BoE
			bindingText = CaerdonWardrobeBoE
		elseif bindType == 3 then -- BoU
			isBindOnUse = true
			bindingText = CaerdonWardrobeBoE
		elseif bindType == 4 then -- Quest
			bindingText = ""
		end

		local isConduit = false
		if IsConduit(itemLink) then
			shouldCheckEquipmentSet = false

			isConduit = true

			local conduitTypes = { 
				Enum.SoulbindConduitType.Potency,
				Enum.SoulbindConduitType.Endurance,
				Enum.SoulbindConduitType.Finesse
			}

			local conduitKnown = false
			for conduitTypeIndex = 1, #conduitTypes do
				local conduitCollection = C_Soulbinds.GetConduitCollection(conduitTypes[conduitTypeIndex])
				for conduitCollectionIndex = 1, #conduitCollection do
					local conduitData = conduitCollection[conduitCollectionIndex]
					if conduitData.conduitItemID == itemID then
						conduitKnown = true
					end
				end
			end

			if not conduitKnown then
				-- TODO: May need to consider spec / class?  Not sure yet
				needsItem = true
			end
		end
		
		if shouldCheckEquipmentSet then
		   -- Use equipment set for binding text if it's assigned to one
			if itemEquipLoc ~= "" and C_EquipmentSet.CanUseEquipmentSets() then

				-- Flag to ensure flagging multiple set membership
				local isBindingTextDone = false

				for setIndex=1, C_EquipmentSet.GetNumEquipmentSets() do
			        local equipmentSetIDs = C_EquipmentSet.GetEquipmentSetIDs()
			        local equipmentSetID = equipmentSetIDs[setIndex]
							name, icon, setID, isEquipped, numItems, numEquipped, numInventory, numMissing, numIgnored = C_EquipmentSet.GetEquipmentSetInfo(equipmentSetID)

			        local equipLocations = C_EquipmentSet.GetItemLocations(equipmentSetID)
			        if equipLocations then
						for locationIndex=INVSLOT_FIRST_EQUIPPED , INVSLOT_LAST_EQUIPPED do
							local location = equipLocations[locationIndex]
							if location ~= nil then
							    local isPlayer, isBank, isBags, isVoidStorage, equipSlot, equipBag, equipTab, equipVoidSlot = EquipmentManager_UnpackLocation(location)
							    equipSlot = tonumber(equipSlot)
							    equipBag = tonumber(equipBag)

							    if isVoidStorage then
							    	-- Do nothing for now
							    elseif isBank and not isBags then -- player or bank
									if bag == BANK_CONTAINER and BankButtonIDToInvSlotID(slot) == equipSlot then
							    		needsItem = false
										if bindingText then
											bindingText = "*" .. bindingText
											isBindingTextDone = true

											break
										else
											bindingText = name
											isInEquipmentSet = true
										end
							    	end
							    else
								    if equipSlot == slot and equipBag == bag then
										needsItem = false
										if bindingText then
											bindingText = "*" .. bindingText
											isBindingTextDone = true
											break
										else
											bindingText = name
											isInEquipmentSet = true
										end
									end
								end
							end
						end

						if isBindingTextDone then
							break
						end
					end
				end
			end
		end

		local canBeChanged, noChangeReason, canBeSource, noSourceReason = C_Transmog.GetItemInfo(itemID)
		if not isCollectionItem and not isConduit and canBeSource then
			local appearanceID, isCollected, sourceID
			appearanceID, isCollected, sourceID, shouldRetry = GetItemAppearance(itemID, itemLink)

			if sourceID and sourceID ~= NO_TRANSMOG_SOURCE_ID then 
				local hasTransmog = C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(sourceID)
				if hasTransmog then
					needsItem = false
				else
					if CaerdonWardrobeConfig.Icon.ShowLearnable.SameLookDifferentItem then
						isCompletionistItem = true
					end
				end
			else
				needsItem = false
			end
		elseif not isCollectionItem and not isConduit then
	    	needsItem = false
	    end

		local numLines = scanTip:NumLines()
		if not isCollectionItem and not noSourceReason and numLines == 0 then
			shouldRetry = true
		end

		if not shouldRetry then
			local isPetKnown = false
			local PET_KNOWN = strmatch(ITEM_PET_KNOWN, "[^%(]+")
			local foundTradeskillMatch = false

			for lineIndex = 1, numLines do
				local scanName = scanTip:GetName()
				local line = _G[scanName .. "TextLeft" .. lineIndex]
				local lineText = line:GetText()
				if lineText then
					-- TODO: Look at switching to GetItemSpell
					if strmatch(lineText, USE_COLON) or strmatch(lineText, ITEM_SPELL_TRIGGER_ONEQUIP) or strmatch(lineText, string.format(ITEM_SET_BONUS, "")) then -- it's a recipe or has a "use" effect or belongs to a set
						if not isCollectionItem and not isConduit then
							hasUse = true
						end
						if isRecipe and strmatch(lineText, "Use: Re%-learn .*") then
							needsItem = false
						end
					end

					if not bindingText then
						bindingText = bindTextTable[lineText]
					end

					if lineText == RETRIEVING_ITEM_INFO then
						shouldRetry = true
						break
					elseif lineText == ITEM_SOULBOUND then
						isSoulbound = true
						isBindOnPickup = true
					-- TODO: Don't think we need these anymore?
					-- elseif lineText == TRANSMOGRIFY_TOOLTIP_ITEM_UNKNOWN_APPEARANCE_KNOWN then
					-- 	if CaerdonWardrobeConfig.Icon.ShowLearnable.SameLookDifferentItem then
					-- 		isCompletionistItem = true
					-- 		print("Completion 1: " .. itemLink .. lineText)
					-- 	else
					-- 		needsItem = false
					-- 	end
					-- 	break
					-- elseif lineText == TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN then
					-- 	if CaerdonWardrobeConfig.Icon.ShowLearnable.SameLookDifferentItem then
					-- 		isCompletionistItem = true
					-- 		print("Completion 2: " .. itemLink .. lineText)
					-- 	end
					elseif lineText == ITEM_SPELL_KNOWN then
						needsItem = false
					elseif lineText == LOCKED then
						isLocked = true
					elseif lineText == TOOLTIP_SUPERCEDING_SPELL_NOT_KNOWN then
						unusableItem = true
						skillTooLow = true
					elseif isPetLink and strmatch(lineText, PET_KNOWN) then
						isPetKnown = true
					end 

					-- TODO: Should possibly only look for "Classes:" but could have other reasons for not being usable
					local r, g, b = line:GetTextColor()
					hex = string.format("%02x%02x%02x", r*255, g*255, b*255)
					-- TODO: Provide option to show stars on BoE recipes that aren't for current toon
					-- TODO: Surely there's a better way than checking hard-coded color values for red-like things
						if isRecipe then
							if hex == "fe1f1f" then
								foundRedRequirements = true
							end

							-- TODO: Cooking and fishing are not represented in trade skill lines right now
							-- Assuming all toons have cooking for now.

							-- TODO: Some day - look into saving toon skill lines / ranks into a DB and showing
							-- which toons could learn a recipe.

							-- local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions()
							local replaceSkill = "%w"
							local skillCheck = string.gsub(ITEM_MIN_SKILL, "%%s", "%(.+%)")
							skillCheck = string.gsub(skillCheck, "%(%%d%)", "%%%(%(%%d+%)%%%)")
							if strmatch(lineText, skillCheck) then
								local _, _, requiredSkill, requiredRank = string.find(lineText, skillCheck)
								local skillLines = C_TradeSkillUI.GetAllProfessionTradeSkillLines()
								for skillLineIndex = 1, #skillLines do
									local skillLineID = skillLines[skillLineIndex]
									local name, rank, maxRank, modifier, parentSkillLineID = C_TradeSkillUI.GetTradeSkillLineInfoByID(skillLineID)
									if requiredSkill == name then
										foundTradeskillMatch = true
										if not rank or rank < tonumber(requiredRank) then
											-- Toon either doesn't have profession or isn't high enough level.
											unusableItem = true
											if isBindOnPickup then
												if not rank or rank == 0 then
													needsItem = false
												end
											end

											if rank and rank > 0 then -- has skill but isn't high enough
												skillTooLow = true
												needsItem = true -- still need this but need to rank up
											else
												needsItem = false
											end
										else
											break
										end
									end
								end
							end		
						-- elseif isBindOnPickup then
						-- 	unusableItem = true
						-- 	if not bag == "EncounterJournal" then
						-- 		needsItem = false
						-- 		isCompletionistItem = false
						-- 	end
						end
					-- end
				end
			end

			if foundRedRequirements then
				unusableItem = true
				skillTooLow = true
			end

			if bindingText then
				if isSoulbound and bindingText == CaerdonWardrobeBoE then
					bindingText = nil
				end
			elseif isCollectionItem or isLocked or isOpenable then
				if not isBindOnPickup then
					bindingText = CaerdonWardrobeBoE
				end
			end

			if isCollectionItem and not unusableItem then
				if isPetLink then
					if not tooltipSpeciesID then
						-- Attempt to grab it from itemLink
						-- TODO: This is almost a complete copy of the logic in IsPetLink - clean up
						local _, _, _, linkType, linkID, _, _, _, _, _, battlePetID, battlePetDisplayID = strsplit(":|H", itemLink);
						if ( linkType == "item") then
							local _, _, _, creatureID, _, _, _, _, _, _, _, displayID, speciesID = C_PetJournal.GetPetInfoByItemID(tonumber(linkID));
							if (creatureID and displayID) then
								tooltipSpeciesID = tonumber(speciesID)
							end
						elseif ( linkType == "battlepet" ) then
							if battlePetID and battlePetID ~= "" and battlePetID ~= "0" then
								local speciesID, _, _, _, _, displayID, _, _, _, _, creatureID = C_PetJournal.GetPetInfoByPetID(battlePetID);
								if ( speciesID == tonumber(linkID)) then
									if (creatureID and displayID) then
										tooltipSpeciesID = tonumber(speciesID)
									end	
								else
									speciesID = tonumber(linkID);
									local _, _, _, creatureID, _, _, _, _, _, _, _, displayID = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
									displayID = (battlePetDisplayID and battlePetDisplayID ~= "0") and battlePetDisplayID or displayID;
									if (creatureID and displayID) then
										tooltipSpeciesID = tonumber(speciesID)
									end	
								end
							else
								-- Mostly in place as a hack for bad battlepet links from addons
								speciesID = tonumber(linkID);
								local _, _, _, creatureID, _, _, _, _, _, _, _, displayID = C_PetJournal.GetPetInfoBySpeciesID(speciesID);
								displayID = (battlePetDisplayID and battlePetDisplayID ~= "0") and battlePetDisplayID or displayID;
								if (creatureID and displayID) then
									tooltipSpeciesID = tonumber(speciesID)
								end	
							end
						end
					end

					if tooltipSpeciesID and tooltipSpeciesID > 0 then
						-- Pet cages have some magic info that comes back from tooltip setup
						local numCollected = C_PetJournal.GetNumCollectedInfo(tooltipSpeciesID)
						if numCollected == nil then
							needsItem = false
						elseif numCollected > 0 then
							needsItem = false
						else
							needsItem = true
						end
					elseif isPetKnown then
						needsItem = false
					else
						needsItem = true
					end
				end
			elseif isCollectionItem then
				if not isRecipe then
					needsItem = false
				end
			end
		end

		C_TransmogCollection.SetShowMissingSourceInItemTooltips(true)
		SetCVar("missingTransmogSourceInItemTooltips", 1)
		SetCVar("alwaysCompareItems", originalAlwaysCompareItems)
	end

	return { 
		bindingText = bindingText, 
		needsItem = needsItem, 
		hasUse = hasUse, 
		isDressable = isDressable, 
		isInEquipmentSet = isInEquipmentSet, 
		isBindOnPickup = isBindOnPickup, 
		isCompletionistItem = isCompletionistItem, 
		shouldRetry = shouldRetry, 
		unusableItem = unusableItem, 
		matchesLootSpec = matchesLootSpec, 
		isLocked = isLocked, 
		skillTooLow = skillTooLow
	}
end

local waitingOnItemData = {}

local function IsGearSetStatus(status, item)
	return status and status ~= CaerdonWardrobeBoA and status ~= CaerdonWardrobeBoE
end

-- TODO: Fix this to make more flexible and consistent - getting crazy and wrong I'm sure
local function SetIconPositionAndSize(icon, startingPoint, offset, size, iconOffset, scaleAdjustment)
	scaleAdjustment = scaleAdjustment or 1
	sizeAdjustment = size - (size * scaleAdjustment)
	offset = offset - (sizeAdjustment / 2)
	iconOffset = iconOffset + (sizeAdjustment / 2)

	icon:ClearAllPoints()

	icon:SetSize(size - sizeAdjustment, size - sizeAdjustment)

	local offsetSum = (offset - iconOffset) * scaleAdjustment
	if startingPoint == "TOPRIGHT" then
		icon:SetPoint("TOPRIGHT", offsetSum, offsetSum)
	elseif startingPoint == "TOPLEFT" then
		icon:SetPoint("TOPLEFT", offsetSum * -1, offsetSum)
	elseif startingPoint == "BOTTOMRIGHT" then
		icon:SetPoint("BOTTOMRIGHT", offsetSum, offsetSum * -1)
	elseif startingPoint == "BOTTOMLEFT" then
		icon:SetPoint("BOTTOMLEFT", offsetSum * -1, offsetSum * -1)
	elseif startingPoint == "RIGHT" then
		icon:SetPoint("RIGHT", iconOffset, 0)
	elseif startingPoint == "LEFT" then
		icon:SetPoint("LEFT", iconOffset, 0)
	end

end

local function AddRotation(group, order, degrees, duration, smoothing, startDelay, endDelay)
	local anim = group:CreateAnimation("Rotation")
	group["anim" .. order] = anim
	anim:SetDegrees(degrees)
    anim:SetDuration(duration)
	anim:SetOrder(order)
	anim:SetSmoothing(smoothing)

	if startDelay then
		anim:SetStartDelay(startDelay)
	end

	if endDelay then
		anim:SetEndDelay(endDelay)
	end
end

local function IsBankOrBags(bag)
	local isBankOrBags = false

	if bag ~= "AuctionFrame" and 
	   bag ~= "MerchantFrame" and 
	   bag ~= "GuildBankFrame" and
	   bag ~= "EncounterJournal" and
	   bag ~= "QuestButton" and
	   bag ~= "LootFrame" and
	   bag ~= "GroupLootFrame" and
	   bag ~= "OpenMailFrame" and
	   bag ~= "SendMailFrame" and 
	   bag ~= "InboxFrame" and
	   bag ~= "ItemLink" and
	   bag ~= "BlackMarketScrollFrame" then
		isBankOrBags = true
	end

	return isBankOrBags
end

local function ShouldHideBindingStatus(bag, bindingStatus)
	local shouldHide = false

	if bag == "AuctionFrame" then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Binding.ShowStatus.BankAndBags and IsBankOrBags(bag) then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Binding.ShowStatus.GuildBank and bag == "GuildBankFrame" then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Binding.ShowStatus.Merchant and bag == "MerchantFrame" then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Binding.ShowBoA and bindingStatus == CaerdonWardrobeBoA then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Binding.ShowBoE and bindingStatus == CaerdonWardrobeBoE then
		shouldHide = true
	end

	return shouldHide
end

local function ShouldHideOwnIcon(bag)
	local shouldHide = false

	if not CaerdonWardrobeConfig.Icon.ShowLearnable.BankAndBags and IsBankOrBags(bag) then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Icon.ShowLearnable.GuildBank and bag == "GuildBankFrame" then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Icon.ShowLearnable.Merchant and bag == "MerchantFrame" then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Icon.ShowLearnable.Auction and bag == "AuctionFrame" then
		shouldHide = true
	end

	return shouldHide
end

local function ShouldHideOtherIcon(bag)
	local shouldHide = false

	if not CaerdonWardrobeConfig.Icon.ShowLearnableByOther.BankAndBags and IsBankOrBags(bag) then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Icon.ShowLearnableByOther.GuildBank and bag == "GuildBankFrame" then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Icon.ShowLearnableByOther.Merchant and bag == "MerchantFrame" then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Icon.ShowLearnableByOther.Auction and bag == "AuctionFrame" then
		shouldHide = true
	end

	return shouldHide
end

local function ShouldHideQuestIcon(bag)
	local shouldHide = false

	if bag == "AuctionFrame" then
		shouldHide = true
	end

	return shouldHide
end

local function ShouldHideOldExpansionIcon(bag)
	local shouldHide = false

	if bag == "AuctionFrame" then
		shouldHide = not CaerdonWardrobeConfig.Icon.ShowOldExpansion.Auction
	elseif
		bag == "MerchantFrame" then -- distracting to show in merchant frame - maybe buyback?
		shouldHide = true
	end

	return shouldHide
end

local function ShouldHideSellableIcon(bag)
	local shouldHide = false

	if not CaerdonWardrobeConfig.Icon.ShowSellable.BankAndBags and IsBankOrBags(bag) then
		shouldHide = true
	end

	if not CaerdonWardrobeConfig.Icon.ShowSellable.GuildBank and bag == "GuildBankFrame" then
		shouldHide = true
	end

	if bag == "MerchantFrame" then
		shouldHide = true
	end

	if bag == "AuctionFrame" then
		shouldHide = true
	end

	return shouldHide
end

local function SetItemButtonMogStatusFilter(originalButton, isFiltered)
	local button = originalButton.caerdonButton
	if button then
		local mogStatus = button.mogStatus
		if mogStatus then
			if isFiltered then
				mogStatus:SetAlpha(0.3)
			else
				mogStatus:SetAlpha(mogStatus.assignedAlpha)
			end
		end
	end
end

local function SetItemButtonMogStatus(originalButton, item, bag, slot, options, status, bindingStatus)
	local button = originalButton.caerdonButton

	if not button then
		button = CreateFrame("Frame", nil, originalButton)
		button:SetAllPoints()
		button.searchOverlay = originalButton.searchOverlay
		originalButton.caerdonButton = button
	end

	button:SetFrameLevel(originalButton:GetFrameLevel() + 100)

	local mogStatus = button.mogStatus
	local mogAnim = button.mogAnim
	local iconPosition, showSellables, isSellable
	local iconSize = 43
	local otherIcon = "Interface\\Store\\category-icon-placeholder"
	local otherIconSize = 43
	local otherIconOffset = 0
	local iconOffset = 0

	if options then 
		showSellables = options.showSellables
		isSellable = options.isSellable
		if options.iconSize then
			iconSize = options.iconSize
		end
		if options.iconOffset then
			iconOffset = options.iconOffset
			otherIconOffset = iconOffset
		end

		if options.otherIcon then
			otherIcon = options.otherIcon
		end

		if options.otherIconSize then
			otherIconSize = options.otherIconSize
		else
			otherIconSize = iconSize
		end

		if options.otherIconOffset then
			otherIconOffset = options.otherIconOffset
		end
	else
		options = {}
	end

	if options.overridePosition then -- for Encounter Journal so far
		iconPosition = options.overridePosition
	else
		iconPosition = CaerdonWardrobeConfig.Icon.Position
	end

	if not status then
		if mogAnim and mogAnim:IsPlaying() then
			mogAnim:Stop()
		end
		if mogStatus then
			mogStatus:SetTexture("")
		end

		-- Keep processing to handle gear set icon
		-- return
	end

	if not mogStatus then
		mogStatus = button:CreateTexture(nil, "OVERLAY", nil, 2)
		SetIconPositionAndSize(mogStatus, iconPosition, 15, iconSize, iconOffset)
		button.mogStatus = mogStatus
	end

	-- local mogFlash = button.mogFlash
	-- if not mogFlash then
	-- 	mogFlash = button:CreateTexture(nil, "OVERLAY")
	-- 	mogFlash:SetAlpha(0)
	-- 	mogFlash:SetBlendMode("ADD")
	-- 	mogFlash:SetAtlas("bags-glow-flash", true)
	-- 	mogFlash:SetPoint("CENTER")

	-- 	button.mogFlash = mogFlash
	-- end

	local showAnim = false
	if status == "waiting" then
		showAnim = true

		if mogAnim and not button.isWaitingIcon then
			if mogAnim:IsPlaying() then
				mogAnim:Finish()
			end

			mogAnim = nil
			button.mogAnim = nil
			button.isWaitingIcon = false
		end

		if not mogAnim or not button.isWaitingIcon then
			mogAnim = mogStatus:CreateAnimationGroup()

			AddRotation(mogAnim, 1, 360, 0.5, "IN_OUT")

		    mogAnim:SetLooping("REPEAT")
			button.mogAnim = mogAnim
			button.isWaitingIcon = true
		end
	else
		if status == "own" or status == "ownPlus" or status == "otherSpec" or status == "otherSpecPlus" or status == "refundable" or status == "openable" or status == "locked" then
			showAnim = true

			if mogAnim and button.isWaitingIcon then
				if mogAnim:IsPlaying() then
					mogAnim:Finish()
				end

				mogAnim = nil
				button.mogAnim = nil
				button.isWaitingIcon = false
			end

			if not mogAnim then
				mogAnim = mogStatus:CreateAnimationGroup()

				AddRotation(mogAnim, 1, 110, 0.2, "OUT")
				AddRotation(mogAnim, 2, -155, 0.2, "OUT")
				AddRotation(mogAnim, 3, 60, 0.2, "OUT")
				AddRotation(mogAnim, 4, -15, 0.1, "OUT", 0, 2)

			    mogAnim:SetLooping("REPEAT")
				button.mogAnim = mogAnim
				button.isWaitingIcon = false
			end
		else
			showAnim = false
		end
	end

	-- 	if not mogAnim then
	-- 		mogAnim = button:CreateAnimationGroup()
	-- 		mogAnim:SetToFinalAlpha(true)
	-- 		mogAnim.alpha1 = mogAnim:CreateAnimation("Alpha")
	-- 		mogAnim.alpha1:SetChildKey("mogFlash")
	-- 		mogAnim.alpha1:SetSmoothing("OUT");
	-- 		mogAnim.alpha1:SetDuration(0.6)
	-- 		mogAnim.alpha1:SetOrder(1)
	-- 		mogAnim.alpha1:SetFromAlpha(1);
	-- 		mogAnim.alpha1:SetToAlpha(0);

	-- 		button.mogAnim = mogAnim
	-- 	end

	local alpha = 1
	mogStatus:SetVertexColor(1, 1, 1)
	-- TODO: Add options to hide these statuses
	if status == "refundable" then
		SetIconPositionAndSize(mogStatus, iconPosition, 3, 15, iconOffset)
		alpha = 0.9
		mogStatus:SetTexture("Interface\\COMMON\\mini-hourglass")
	elseif status == "openable" then
		SetIconPositionAndSize(mogStatus, iconPosition, 15, iconSize, iconOffset)
		mogStatus:SetTexture("Interface\\Store\\category-icon-free")
	elseif status == "lowSkill" then
		SetIconPositionAndSize(mogStatus, iconPosition, 10, 30, iconOffset)
		mogStatus:SetTexture("Interface\\Store\\category-icon-scroll")  --Interface\\WorldMap\\Gear_64Grey
		-- mogStatus:SetTexture("Interface\\QUESTFRAME\\SkillUp-BG")
		-- mogStatus:SetTexture("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew")
		-- mogStatus:SetTexture("Interface\\Buttons\\JumpUpArrow")
	elseif status == "locked" then
		SetIconPositionAndSize(mogStatus, iconPosition, 15, iconSize, iconOffset)
		mogStatus:SetTexture("Interface\\Store\\category-icon-key")
	elseif status == "oldexpansion" and not ShouldHideOldExpansionIcon(bag) then
		SetIconPositionAndSize(mogStatus, iconPosition, 10, 30, iconOffset)
		alpha = 0.9
		mogStatus:SetTexture("Interface\\Store\\category-icon-hot")
	elseif status == "own" or status == "ownPlus" then
		if not ShouldHideOwnIcon(bag) then
			SetIconPositionAndSize(mogStatus, iconPosition, 15, iconSize, iconOffset)
			mogStatus:SetTexture("Interface\\Store\\category-icon-featured")
			if status == "ownPlus" then
				mogStatus:SetVertexColor(0.4, 1, 0)
			end
		else
			mogStatus:SetTexture("")
		end
	elseif status == "other" or status == "otherPlus" then
		if not ShouldHideOtherIcon(bag) then
			SetIconPositionAndSize(mogStatus, iconPosition, 15, otherIconSize, otherIconOffset)
			mogStatus:SetTexture(otherIcon)
			if status == "otherPlus" then
				mogStatus:SetVertexColor(0.4, 1, 0)
			end
		else
			mogStatus:SetTexture("")
		end
	elseif status == "otherSpec" or status == "otherSpecPlus" then
		if not ShouldHideOtherIcon(bag) then
			SetIconPositionAndSize(mogStatus, iconPosition, 15, otherIconSize, otherIconOffset)
			mogStatus:SetTexture("Interface\\COMMON\\icon-noloot")
			if status == "otherSpecPlus" then
				mogStatus:SetVertexColor(0.4, 1, 0)
			end
		else
			mogStatus:SetTexture("")
		end
	elseif status == "quest" and not ShouldHideQuestIcon(bag) then
		SetIconPositionAndSize(mogStatus, iconPosition, 10, 30, iconOffset)
		mogStatus:SetTexture("Interface\\Store\\category-icon-ticket")
	elseif status == "collected" then
		if not IsGearSetStatus(bindingStatus, item) and showSellables and isSellable and not ShouldHideSellableIcon(bag) then -- it's known and can be sold
			SetIconPositionAndSize(mogStatus, iconPosition, 10, 30, iconOffset)
			alpha = 0.9
			mogStatus:SetTexture("Interface\\Store\\category-icon-bag")
		elseif IsGearSetStatus(bindingStatus, item) and CaerdonWardrobeConfig.Binding.ShowGearSetsAsIcon then
			SetIconPositionAndSize(mogStatus, iconPosition, 10, 30, iconOffset)
			mogStatus:SetTexture("Interface\\Store\\category-icon-clothes")
		else
			mogStatus:SetTexture("")
		end
	elseif status == "waiting" then
		alpha = 0.5
		SetIconPositionAndSize(mogStatus, iconPosition, 10, 30, iconOffset)
		mogStatus:SetTexture("Interface\\Common\\StreamCircle")
	elseif IsGearSetStatus(bindingStatus, item) and CaerdonWardrobeConfig.Binding.ShowGearSetsAsIcon then
		SetIconPositionAndSize(mogStatus, iconPosition, 10, 30, iconOffset)
		mogStatus:SetTexture("Interface\\Store\\category-icon-clothes")
	end

	mogStatus:SetAlpha(alpha)
	mogStatus.assignedAlpha = alpha

	C_Timer.After(0, function() 
		if(button.searchOverlay and button.searchOverlay:IsShown()) then
			mogStatus:SetAlpha(0.3)
		end
	end)

	if showAnim and CaerdonWardrobeConfig.Icon.EnableAnimation then
		if mogAnim and not mogAnim:IsPlaying() then
			mogAnim:Play()
		end
	else
		if mogAnim and mogAnim:IsPlaying() then
			mogAnim:Finish()
		end
	end
end

local function SetItemButtonBindType(button, mogStatus, bindingStatus, options, bag)
	local bindsOnText = button.bindsOnText

	if not bindingStatus and not bindsOnText then return end
	if not bindingStatus or ShouldHideBindingStatus(bag, bindingStatus) then
		if bindsOnText then
			bindsOnText:SetText("")
		end
		return
	end

	if not bindsOnText then
		bindsOnText = button:CreateFontString(nil, "BORDER", "SystemFont_Outline_Small") 
		button.bindsOnText = bindsOnText
	end

	bindsOnText:ClearAllPoints()
	bindsOnText:SetWidth(button:GetWidth())

	local bindingPosition = options.overrideBindingPosition or CaerdonWardrobeConfig.Binding.Position
	local bindingOffset = options.bindingOffset or 2

	if bindingPosition == "BOTTOM" then
		bindsOnText:SetPoint("BOTTOMRIGHT", bindingOffset, 2)
		if bindingStatus == CaerdonWardrobeBoA then
			local offset = options.itemCountOffset or 15
			if (button.count and button.count > 1) then
				bindsOnText:SetPoint("BOTTOMRIGHT", 0, offset)
			end
		end
	elseif bindingPosition == "CENTER" then
		bindsOnText:SetPoint("CENTER", 0, 0)
	elseif bindingPosition == "TOP" then
		bindsOnText:SetPoint("TOPRIGHT", 0, -2)
	else
		bindsOnText:SetPoint(bindingPosition, options.bindingOffsetX or 2, options.bindingOffsetY or 2)
	end
	if(options.bindingScale) then
		bindsOnText:SetScale(options.bindingScale)
	end

	local bindingText
	if IsGearSetStatus(bindingStatus) then -- is gear set
		if CaerdonWardrobeConfig.Binding.ShowGearSets and not CaerdonWardrobeConfig.Binding.ShowGearSetsAsIcon then
			bindingText = "|cFFFFFFFF" .. bindingStatus .. "|r"
		end
	else
		if mogStatus == "own" then
			if bindingStatus == CaerdonWardrobeBoA then
				local color = BAG_ITEM_QUALITY_COLORS[Enum.ItemQuality.Heirloom]
				bindsOnText:SetTextColor(color.r, color.g, color.b, 1)
				bindingText = bindingStatus
			else
				bindingText = "|cFF00FF00" .. bindingStatus .. "|r"
			end
		elseif mogStatus == "other" then
			bindingText = "|cFFFF0000" .. bindingStatus .. "|r"
		elseif mogStatus == "collected" then
			if bindingStatus == CaerdonWardrobeBoA then
				local color = BAG_ITEM_QUALITY_COLORS[Enum.ItemQuality.Heirloom]
				bindsOnText:SetTextColor(color.r, color.g, color.b, 1)
				bindingText = bindingStatus
			elseif bindingStatus == CaerdonWardrobeBoE then
				bindingText = "|cFF00FF00" .. bindingStatus .. "|r"
			else
				bindingText = bindingStatus
			end
		else
			if bindingStatus == CaerdonWardrobeBoA then
				local color = BAG_ITEM_QUALITY_COLORS[Enum.ItemQuality.Heirloom]
				bindsOnText:SetTextColor(color.r, color.g, color.b, 1)
				bindingText = bindingStatus
			else
				bindingText = "|cFF00FF00" .. bindingStatus .. "|r"
			end
		end
	end

	bindsOnText:SetText(bindingText)
end

local function QueueProcessItem(itemLink, bag, slot, button, options)
	C_Timer.After(0.1, function()
		CaerdonWardrobe:UpdateButtonLink(itemLink, bag, slot, button, options)
	end)
end

local function ItemIsSellable(itemID, itemLink)
	local isSellable = true
	if itemID == 23192 then -- Tabard of the Scarlet Crusade needs to be worn for a vendor at Darkmoon Faire
		isSellable = false
	elseif itemID == 116916 then -- Gorepetal's Gentle Grasp allows faster herbalism in Draenor
		isSellable = false
	end
	return isSellable
end

local function GetBankContainer(button)
	local containerID = button:GetParent():GetID();
	if( button.isBag ) then
		containerID = -ITEM_INVENTORY_BANK_BAG_OFFSET;
		return
	end

	return containerID
end

local function ProcessItem(item, bag, slot, button, options)
	local bindingText
	local mogStatus = nil

   	if not options then
   		options = {}
   	end

	local showMogIcon = options.showMogIcon
	local showBindStatus = options.showBindStatus
	local showSellables = options.showSellables

	local itemLink = item:GetItemLink()
	if not itemLink then
		-- Requiring an itemLink for now unless I find a reason not to
		return
	end

	local itemID = item:GetItemID() or GetItemID(itemLink)
	if not itemID then
		return
	end

	local canBeChanged, noChangeReason, canBeSource, noSourceReason = C_Transmog.GetItemInfo(itemLink)

	local appearanceID, isCollected, sourceID

	local bindingResult = GetBindingStatus(bag, slot, itemID, itemLink)
	local shouldRetry = bindingResult.shouldRetry
	if shouldRetry then
		QueueProcessItem(itemLink, bag, slot, button, options)
		return
	end

	local itemName, itemLinkInfo, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
	itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, 
	isCraftingReagent = GetItemInfo(itemLink)

	local playerLevel = UnitLevel("player")

	if IsCollectibleLink(itemLink) or IsConduit(itemLink) then
   		shouldRetry = false
	else
		local expansionID = expacID
		if expansionID and expansionID >= 0 and expansionID < GetExpansionLevel() then 
			local shouldShowExpansion = false

			if expansionID > 0 or CaerdonWardrobeConfig.Icon.ShowOldExpansion.Unknown then
				if isCraftingReagent and CaerdonWardrobeConfig.Icon.ShowOldExpansion.Reagents then
					shouldShowExpansion = true
				elseif bindingResult.hasUse and CaerdonWardrobeConfig.Icon.ShowOldExpansion.Usable then
					shouldShowExpansion = true
				elseif not isCraftingReagent and not bindingResult.hasUse and CaerdonWardrobeConfig.Icon.ShowOldExpansion.Other then
					shouldShowExpansion = true
				end
			end

			if shouldShowExpansion then
				mogStatus = "oldexpansion"
			end
		end
		
		appearanceID, isCollected, sourceID, shouldRetry = GetItemAppearance(itemID, itemLink)
		if shouldRetry then
			QueueProcessItem(itemLink, bag, slot, button, options)
			return
		end
	end

	local isQuestItem = itemClassID == LE_ITEM_CLASS_QUESTITEM
	if isQuestItem and CaerdonWardrobeConfig.Icon.ShowQuestItems then
		mogStatus = "quest"
	end

	if appearanceID then
		local canCollect, matchedSource, shouldRetry = PlayerCanCollectAppearance(sourceID, appearanceID, itemID, itemLink)
		if shouldRetry then
			QueueProcessItem(itemLink, bag, slot, button, options)
			return
		end

		if(bindingResult.needsItem and not isCollected and not PlayerHasAppearance(appearanceID)) then
			if canCollect and not bindingResult.unusableItem then
				if itemMinLevel and playerLevel < itemMinLevel then
					mogStatus = "lowSkill"
				else
					mogStatus = "own"
				end
			else
				if bindingResult.bindingText then
					mogStatus = "other"
				elseif (bag == "EncounterJournal" or bag == "QuestButton") then
					mogStatus = "other"
				elseif (bag == "LootFrame" or bag == "GroupLootFrame") and not bindingResult.isBindOnPickup then
					mogStatus = "other"
				elseif bindingResult.unusableItem then
					mogStatus = "collected"
				end
			end

			if not bindingResult.matchesLootSpec and bag == "EncounterJournal" then
				mogStatus = "otherSpec"
			end
		else

			if bindingResult.isCompletionistItem then
				if canCollect then
					mogStatus = "ownPlus"
				elseif bindingResult.isBindOnPickup then
					mogStatus = "otherSpecPlus"
				else
					mogStatus = "otherPlus"
				end

				if not bindingResult.matchesLootSpec and bag == "EncounterJournal" then
					mogStatus = "otherSpecPlus"
				end

				if bindingResult.unusableItem then
					mogStatus = "otherPlus"
				end

			-- If an item isn't flagged as a source or has a usable effect,
			-- then don't mark it as sellable right now to avoid accidents.
			-- May need to expand this to account for other items, too, for now.
			elseif canBeSource and not bindingResult.isInEquipmentSet then
				if bindingResult.isDressable and not shouldRetry then -- don't flag items for sale that have use effects for now
					if IsBankOrBags(bag) then
					 	local money, itemCount, refundSec, currencyCount, hasEnchants = GetContainerItemPurchaseInfo(bag, slot, isEquipped);
						if bindingResult.hasUse and refundSec then
							mogStatus = "refundable"
						elseif not bindingResult.hasUse then
							mogStatus = "collected"
						end
					else 
						mogStatus = "collected"
					end
				end
			end
			-- TODO: Decide how to expose this functionality
			-- Hide anything that doesn't match
			-- if button then
			-- 	--button.IconBorder:SetVertexColor(100, 255, 50)
			-- 	button.searchOverlay:Show()
			-- end

		end
	elseif bindingResult.needsItem then
		if ((canBeSource and bindingResult.isDressable) or IsMountLink(itemLink)) and not shouldRetry then
			if not itemMinLevel or playerLevel >= itemMinLevel then
				mogStatus = "own"
			else
				mogStatus = "other"
			end
		elseif IsPetLink(itemLink) or IsToyLink(itemLink) then
			if bindingResult.unusableItem then
				mogStatus = "other"
			else
				mogStatus = "own"
			end
		elseif IsRecipeLink(itemLink) then
			if bindingResult.unusableItem then
				if bindingResult.skillTooLow then
					mogStatus = "lowSkill"
				end
				-- Don't show these for now
				-- mogStatus = "other"
			else
				mogStatus = "own"
			end

			-- Let's just ignore the Librams for now until I decide what to do about them
			if itemID == 11732 or 
			   itemID == 11733 or
			   itemID == 11734 or 
			   itemID == 11736 or 
			   itemID == 11737 or
			   itemID == 18332 or
			   itemID == 18333 or
			   itemID == 18334 or
			   itemID == 21288 then
				if CaerdonWardrobeConfig.Icon.ShowOldExpansion.Usable then
					mogStatus = "oldexpansion"
				else
					mogStatus = nil
				end
			end
		elseif IsConduit(itemLink) then
			mogStatus = "own"
		end
	else
		if canBeSource then
	        local hasTransmog = C_TransmogCollection.PlayerHasTransmog(itemID)
	        if hasTransmog and not bindingResult.hasUse and bindingResult.isDressable then
	        	-- Tabards don't have an appearance ID and will end up here.
	        	mogStatus = "collected"
	        end
	    end

	    if(IsBankOrBags(bag)) then	    	
	    	local containerID = bag
	    	local containerSlot = slot

			local texture, itemCount, locked, quality, readable, lootable, _ = GetContainerItemInfo(containerID, containerSlot);
			if lootable then
				local startTime, duration, isEnabled = GetContainerItemCooldown(containerID, containerSlot)
				if duration > 0 and not isEnabled then
					mogStatus = "refundable" -- Can't open yet... show timer
				else
					if bindingResult.isLocked then
						mogStatus = "locked"
					else
						mogStatus = "openable"
					end
				end
			end

		elseif bag == "MerchantFrame" then
			if (MerchantFrame.selectedTab == 1) then
				-- TODO: If I can ever figure out how to process pets in the MerchantFrame
			else
			end
		end

		-- Hide anything that doesn't match
		-- if button then
		-- 	--button.IconBorder:SetVertexColor(100, 255, 50)
		-- 	button.searchOverlay:Show()
		-- end
	end

	if mogStatus == "collected" and 
		ItemIsSellable(itemID, itemLink) and not bindingResult.isInEquipmentSet then
       	-- Anything that reports as the player having should be safe to sell
       	-- unless it's in an equipment set or needs to be excluded for some
       	-- other reason
		options.isSellable = true
	end

	if button then
		SetItemButtonMogStatus(button, item, bag, slot, options, mogStatus, bindingResult.bindingText)
		SetItemButtonBindType(button, mogStatus, bindingResult.bindingText, options, bag)
	end
end

local function ProcessOrWaitItemLink(itemLink, bag, slot, button, options)
	CaerdonWardrobe:UpdateButtonLink(itemLink, bag, slot, button, options)
end

local registeredAddons = {}
local registeredBagAddons = {}
local bagAddonCount = 0

function CaerdonWardrobe:GetItemID(itemLink)
	return GetItemID(itemLink)
end

function CaerdonWardrobe:RegisterAddon(name, addonOptions)
	local options = {
		isBag = true	
	}

	if addonOptions then
		for key, value in pairs(addonOptions) do
			options[key] = value
		end
	end

	registeredAddons[name] = options

	if options.isBag then
		registeredBagAddons[name] = options
		bagAddonCount = bagAddonCount + 1
		if bagAddonCount > 1 then
			for key in pairs(registeredBagAddons) do
				if addonList then
					addonList = addonList .. ", " .. key
				else
					addonList = key
				end	
			end
			--StaticPopup_Show("CAERDON_WARDROBE_MULTIPLE_BAG_ADDONS", addonList)
			RaidNotice_AddMessage(RaidWarningFrame, "It looks like multiple bag addons are currently running! You should only have one bag addon enabled!", ChatTypeInfo["RAID_WARNING"])
		end
		if not options.hookDefaultBags then
			ignoreDefaultBags = true
		end
	end
end

function CaerdonWardrobe:ClearButton(button, item, bag, slot, options)
	SetItemButtonMogStatus(button, item, bag, slot, options, nil)
	SetItemButtonBindType(button, nil)
end

function CaerdonWardrobe:UpdateButtonLink(itemLink, bag, slot, button, options)
	if not itemLink then
		CaerdonWardrobe:ClearButton(button)
		return
	end

	local item = Item:CreateFromItemLink(itemLink)
	SetItemButtonMogStatus(button, item, bag, slot, options, "waiting", nil)

	-- TODO: May have to look into cancelable continue to avoid timing issues
	-- Need to figure out how to key this correctly (could have multiple of item in bags, for instance)
	-- but in cases of rapid data update (AH scroll), we don't want to update an old button
	-- Look into ContinuableContainer
	if item:IsItemEmpty() then -- not sure what this represents?  Seems to happen for caged pet - assuming item is ready.
		SetItemButtonMogStatus(button, item, bag, slot, options, nil)
		ProcessItem(item, bag, slot, button, options)
	else
		item:ContinueOnItemLoad(function ()
			SetItemButtonMogStatus(button, item, bag, slot, options, nil)
			ProcessItem(item, bag, slot, button, options)
		end)
	end
end

local function OnContainerUpdate(self, asyncUpdate)
	local bagID = self:GetID()

	for buttonIndex = 1, self.size do
		local button = _G[self:GetName() .. "Item" .. buttonIndex]
		local slot = button:GetID()

		local itemLink = GetContainerItemLink(bagID, slot)
		CaerdonWardrobe:UpdateButtonLink(itemLink, bagID, slot, button, { showMogIcon = true, showBindStatus = true, showSellables = true })
	end
end

local waitingOnBagUpdate = {}
local function OnBagUpdate_Coroutine()
    local processQueue = {}
    for frameID, shouldUpdate in pairs(waitingOnBagUpdate) do
      processQueue[frameID] = shouldUpdate
      waitingOnBagUpdate[frameID] = nil
    end

    for frameID, shouldUpdate in pairs(processQueue) do
      local frame = _G["ContainerFrame".. frameID]

      if frame:IsShown() then
        OnContainerUpdate(frame, true)
      end
      coroutine.yield()
    end

	-- waitingOnBagUpdate = {}
end

local function AddBagUpdateRequest(bagID)
	local foundBag = false
	for i=1, NUM_CONTAINER_FRAMES, 1 do
		local frame = _G["ContainerFrame"..i];
		if ( frame:GetID() == bagID ) then
			waitingOnBagUpdate[tostring(i)] = true
			foundBag = true
		end
	end
end

local function ScheduleContainerUpdate(frame)
	local bagID = frame:GetID()
	AddBagUpdateRequest(bagID)
end

local function OnBankItemUpdate(button)
	local bag = GetBankContainer(button)
	local slot = button:GetID()

	if bag and slot then
		local itemLink = GetContainerItemLink(bag, slot)
		CaerdonWardrobe:UpdateButtonLink(itemLink, bag, slot, button, { showMogIcon=true, showBindStatus=true, showSellables=true })
	end
end

hooksecurefunc("BankFrameItemButton_Update", OnBankItemUpdate)

local isGuildBankFrameUpdateRequested = false

local function OnGuildBankFrameUpdate_Coroutine()
	if( GuildBankFrame.mode == "bank" ) then
		local tab = GetCurrentGuildBankTab();
		local button, index, column;
		local texture, itemCount, locked, isFiltered, quality;

		for i=1, MAX_GUILDBANK_SLOTS_PER_TAB do
			index = mod(i, NUM_SLOTS_PER_GUILDBANK_GROUP);
			if ( index == 0 ) then
				index = NUM_SLOTS_PER_GUILDBANK_GROUP;

				coroutine.yield()
			end

			if isGuildBankFrameUpdateRequested then
				return
			end

			column = ceil((i-0.5)/NUM_SLOTS_PER_GUILDBANK_GROUP);
			button = _G["GuildBankColumn"..column.."Button"..index];

			local bag = "GuildBankFrame"
			local slot = {tab = tab, index = i}

			local options = {
				showMogIcon = true,
				showBindStatus = true,
				showSellables = true
			}

			local itemLink = GetGuildBankItemLink(tab, i)
			CaerdonWardrobe:UpdateButtonLink(itemLink, bag, slot, button, options)
		end
	end
end

local function OnGuildBankFrameUpdate()
	isGuildBankFrameUpdateRequested = true
end

local auctionTimer
local auctionContinuableContainer = ContinuableContainer:Create();

local function OnAuctionBrowseUpdate()
	-- Event pump since first load won't have UI ready
	if not AuctionHouseFrame:IsVisible() then
		return
	end

	if auctionTimer then
		auctionTimer:Cancel()
	end

	-- TODO: Battle Pet scans are not clean, yet.
	auctionContinuableContainer:Cancel()

	local buttons = HybridScrollFrame_GetButtons(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollFrame);
	for i, button in ipairs(buttons) do
		CaerdonWardrobe:ClearButton(button)
	end

	auctionTimer = C_Timer.NewTimer(0.1, function() 
		local browseResults = C_AuctionHouse.GetBrowseResults()
		local offset = AuctionHouseFrame.BrowseResultsFrame.ItemList:GetScrollOffset();

		local buttons = HybridScrollFrame_GetButtons(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollFrame);
		for i, button in ipairs(buttons) do
			local bag = "AuctionFrame"
			local slot = i + offset

			local _, itemLink

			local browseResult = browseResults[slot]
			if browseResult then
				local item = Item:CreateFromItemID(browseResult.itemKey.itemID)
				-- TODO: Do we need to check if slot has changed for buttons?  Could do something here...
				-- item:ContinueOnItemLoad(function ()
				-- 	print(item:GetItemLink())
				-- end)
				if not item:IsItemEmpty() then
					auctionContinuableContainer:AddContinuable(item)
				end
			end
		end

		auctionContinuableContainer:ContinueOnLoad(function()
			local checkOffset = AuctionHouseFrame.BrowseResultsFrame.ItemList:GetScrollOffset();
			-- TODO: Not sure if this is actually doing anything - hasn't been triggered, yet.
			if checkOffset ~= offset then 
				return
			end

			for i, button in ipairs(buttons) do
				local bag = "AuctionFrame"
				local slot = i + offset
	
				local _, itemLink
	
				local browseResult = browseResults[slot]
				if browseResult then
					local item = Item:CreateFromItemID(browseResult.itemKey.itemID)
					local itemKeyInfo = C_AuctionHouse.GetItemKeyInfo(browseResult.itemKey)
	
					if itemKeyInfo and itemKeyInfo.battlePetLink then
						itemLink = itemKeyInfo.battlePetLink
					else
						itemLink = item:GetItemLink()
					end
	
					-- From AuctionHouseTableBuilder
					local PRICE_DISPLAY_WIDTH = 120;
					local PRICE_DISPLAY_WITH_CHECKMARK_WIDTH = 140;
					local PRICE_DISPLAY_PADDING = 0;
					local BUYOUT_DISPLAY_PADDING = 0;
					local STANDARD_PADDING = 10;

					local iconSize = 30
					-- From AuctionHouseTableBuilder.GetBrowseListLayout
					local iconOffset = 
						PRICE_DISPLAY_PADDING + 146 - (iconSize / 2)
					if itemLink and button then
						CaerdonWardrobe:UpdateButtonLink(itemLink, bag, { index = slot, itemKey = browseResult.itemKey }, button,  
						{
							overridePosition = "LEFT",
							iconOffset = iconOffset,
							iconSize = iconSize,				
							showMogIcon=true, 
							showBindStatus=false, 
							showSellables=false
						})
					end
				end
			end
		end)
	end, 1)
end

local function OnAuctionBrowseClick(self, buttonName, isDown)
	if (buttonName == "LeftButton" and isDown) then
		OnAuctionBrowseUpdate()
	end
end

local function OnMerchantUpdate()
	for i=1, MERCHANT_ITEMS_PER_PAGE, 1 do
		local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i)

		local button = _G["MerchantItem"..i.."ItemButton"];

		local bag = "MerchantFrame"
		local slot = index

		local itemLink = GetMerchantItemLink(index)
		CaerdonWardrobe:UpdateButtonLink(itemLink, bag, slot, button, { 
			showMogIcon=true, showBindStatus=true, showSellables=false, 
			otherIconSize = 20, otherIconOffset = 10,	
		})
	end
end

local function OnBuybackUpdate()
	local numBuybackItems = GetNumBuybackItems();

	for index=1, BUYBACK_ITEMS_PER_PAGE, 1 do -- Only 1 actual page for buyback right now
		if index <= numBuybackItems then
			local button = _G["MerchantItem"..index.."ItemButton"];

			local bag = "MerchantFrame"
			local slot = index

			local itemLink = GetBuybackItemLink(index)
			CaerdonWardrobe:UpdateButtonLink(itemLink, bag, slot, button, { showMogIcon=true, showBindStatus=true, showSellables=false})
		end
	end
end

hooksecurefunc("MerchantFrame_UpdateMerchantInfo", OnMerchantUpdate)
hooksecurefunc("MerchantFrame_UpdateBuybackInfo", OnBuybackUpdate)

function CaerdonWardrobeMixin:OnEvent(event, ...)
	local handler = self[event]
	if(handler) then
		handler(self, ...)
	end
end

local timeSinceLastGuildBankUpdate = nil
local timeSinceLastBagUpdate = nil
local GUILDBANKFRAMEUPDATE_INTERVAL = 0.1
local BAGUPDATE_INTERVAL = 0.1
local ITEMUPDATE_INTERVAL = 0.1

function CaerdonWardrobeMixin:OnUpdate(elapsed)
	if self.itemUpdateCoroutine then
		if coroutine.status(self.itemUpdateCoroutine) ~= "dead" then
			local ok, result = coroutine.resume(self.itemUpdateCoroutine)
			if not ok then
				error(result)
			end
		else
			self.itemUpdateCoroutine = nil
		end
		return
	end

	if(self.bagUpdateCoroutine) then
		if coroutine.status(self.bagUpdateCoroutine) ~= "dead" then
			local ok, result = coroutine.resume(self.bagUpdateCoroutine)
			if not ok then
				error(result)
			end
		else
			self.bagUpdateCoroutine = nil
		end
		return
	end

	if(self.guildBankUpdateCoroutine) then
		if coroutine.status(self.guildBankUpdateCoroutine) ~= "dead" then
			local ok, result = coroutine.resume(self.guildBankUpdateCoroutine)
			if not ok then
				error(result)
			end
		else
			self.guildBankUpdateCoroutine = nil
		end
		return
	end

	if isGuildBankFrameUpdateRequested then
		isGuildBankFrameUpdateRequested = false
		timeSinceLastGuildBankUpdate = 0
	elseif timeSinceLastGuildBankUpdate then
		timeSinceLastGuildBankUpdate = timeSinceLastGuildBankUpdate + elapsed
	end

	if isBagUpdateRequested then
		isBagUpdateRequested = false
		timeSinceLastBagUpdate = 0
	elseif timeSinceLastBagUpdate then
		timeSinceLastBagUpdate = timeSinceLastBagUpdate + elapsed
	end

	if( timeSinceLastGuildBankUpdate ~= nil and (timeSinceLastGuildBankUpdate > GUILDBANKFRAMEUPDATE_INTERVAL) ) then
		timeSinceLastGuildBankUpdate = nil
		self.guildBankUpdateCoroutine = coroutine.create(OnGuildBankFrameUpdate_Coroutine)
	end

	if( timeSinceLastBagUpdate ~= nil and (timeSinceLastBagUpdate > BAGUPDATE_INTERVAL) ) then
		timeSinceLastBagUpdate = nil
		self.bagUpdateCoroutine = coroutine.create(OnBagUpdate_Coroutine)
	end
end

local function OnEncounterJournalSetLootButton(item)
	local itemID, encounterID, name, icon, slot, armorType, itemLink;
	if isShadowlands then
		local itemInfo = C_EncounterJournal.GetLootInfoByIndex(item.index);
		itemLink = itemInfo.link
	else
		itemID, encounterID, name, icon, slot, armorType, itemLink = EJ_GetLootInfoByIndex(item.index);
	end
	
	local options = {
		iconOffset = 8,
		otherIcon = "Interface\\Buttons\\UI-GroupLoot-Pass-Up",
		otherIconSize = 21,
		otherIconOffset = 16,
		overridePosition = "TOPRIGHT"
	}

	CaerdonWardrobe:UpdateButtonLink(itemLink, "EncounterJournal", item, item, options)
end

function CaerdonWardrobeNS:GetDefaultConfig()
	return {
		Version = 8,
		Icon = {
			EnableAnimation = true,
			Position = "TOPRIGHT",

			ShowLearnable = {
				BankAndBags = true,
				GuildBank = true,
				Merchant = true,
				Auction = true,
				SameLookDifferentItem = false,
			},

			ShowLearnableByOther = {
				BankAndBags = true,
				GuildBank = true,
				Merchant = true,
				Auction = true,
				EncounterJournal = true,
				SameLookDifferentItem = false,
			},

			ShowSellable = {
				BankAndBags = true,
				GuildBank = true
			},

			ShowOldExpansion = {
				Unknown = false,
				Reagents = true,
				Usable = false,
				Other = false,
				Auction = true
			},

			ShowQuestItems = true
		},

		Binding = {
			ShowStatus = {
				BankAndBags = true,
				GuildBank = true,
				Merchant = true,
			},

			ShowBoA = true,
			ShowBoE = true,
			ShowGearSets = true,
			ShowGearSetsAsIcon = false,
			Position = "BOTTOM",
		}
	}
end

local function ProcessSettings()
	if not CaerdonWardrobeConfig or CaerdonWardrobeConfig.Version ~= CaerdonWardrobeNS:GetDefaultConfig().Version then
		CaerdonWardrobeConfig = CaerdonWardrobeNS:GetDefaultConfig()
	end
end

function CaerdonWardrobeMixin:PLAYER_LOGOUT()
end

function CaerdonWardrobeMixin:ADDON_LOADED(name)
	if name == "Combuctor" then
		ProcessSettings()
		CaerdonWardrobeNS:FireConfigLoaded()
	elseif name == "Blizzard_GuildBankUI" then
		hooksecurefunc("GuildBankFrame_Update", OnGuildBankFrameUpdate)
	elseif name == "Blizzard_EncounterJournal" then
		hooksecurefunc("EncounterJournal_SetLootButton", OnEncounterJournalSetLootButton)
	-- elseif name == "TradeSkillMaster" then
	-- 	print("HOOKING TSM")
	-- 	hooksecurefunc (TSM.UI.AuctionScrollingTable, "_SetRowData", function (self, row, data)
	-- 		print("Row: " .. row:GetField("auctionId"))
	-- 	end)
	end
end

function CaerdonWardrobeMixin:PLAYER_LOGIN(...)
	-- Show missing info in tooltips
	-- NOTE: This causes a bug with tooltip scanning, so we disable
	--   briefly and turn it back on with each scan.
	C_TransmogCollection.SetShowMissingSourceInItemTooltips(true)
	SetCVar("missingTransmogSourceInItemTooltips", 1)
end

function CaerdonWardrobeMixin:AUCTION_HOUSE_BROWSE_RESULTS_UPDATED()
	OnAuctionBrowseUpdate()
end

local function OnSelectBrowseResult(self, browseResult)
	local itemLink
	local item = Item:CreateFromItemID(browseResult.itemKey.itemID)
	local itemKeyInfo = C_AuctionHouse.GetItemKeyInfo(browseResult.itemKey)

	if itemKeyInfo and itemKeyInfo.battlePetLink then
		itemLink = itemKeyInfo.battlePetLink
	else
		itemLink = item:GetItemLink()
	end

	CaerdonWardrobe:UpdateButtonLink(itemLink, "ItemLink", nil, AuctionHouseFrame.ItemBuyFrame.ItemDisplay.ItemButton,  
	{
		overridePosition = "TOPLEFT",
		iconOffset = -5,
		iconSize = 50,				
		showMogIcon=true, 
		showBindStatus=false, 
		showSellables=false
	})
end


local hookAuction = true
function CaerdonWardrobeMixin:AUCTION_HOUSE_SHOW()
	if (hookAuction) then
		hookAuction = false
		AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollFrame.scrollBar:HookScript("OnValueChanged", OnAuctionBrowseUpdate)
		hooksecurefunc(AuctionHouseFrame, "SelectBrowseResult", OnSelectBrowseResult)
	end
end

function RefreshMainBank()
	if not ignoreDefaultBags then
		for i=1, NUM_BANKGENERIC_SLOTS, 1 do
			button = BankSlotsFrame["Item"..i];
			OnBankItemUpdate(button);
		end
	end
end

local refreshTimer
local function RefreshItems()
	if refreshTimer then
		refreshTimer:Cancel()
	end

	refreshTimer = C_Timer.NewTimer(0.1, function ()
		if MerchantFrame:IsShown() then 
			if MerchantFrame.selectedTab == 1 then
				OnMerchantUpdate()
			else
				OnBuybackUpdate()
			end
		end

		if AuctionFrame and AuctionFrame:IsShown() then
			OnAuctionBrowseUpdate()
		end

		if BankFrame:IsShown() then
			RefreshMainBank()
		end

		for i=1, NUM_CONTAINER_FRAMES, 1 do
			local frame = _G["ContainerFrame"..i];
			waitingOnBagUpdate[tostring(i)] = true
			isBagUpdateRequested = true
		end
	end, 1)
end

local function OnContainerFrameUpdateSearchResults(frame)
	local id = frame:GetID();
	local name = frame:GetName().."Item";
	local itemButton;
	local _, isFiltered;
	
	for i=1, frame.size, 1 do
		itemButton = _G[name..i] or frame["Item"..i];
		_, _, _, _, _, _, _, isFiltered = GetContainerItemInfo(id, itemButton:GetID())
		SetItemButtonMogStatusFilter(itemButton, isFiltered)
	end
end

hooksecurefunc("ContainerFrame_UpdateSearchResults", OnContainerFrameUpdateSearchResults)

local function OnEquipPendingItem()
	-- TODO: Bit of a hack... wait a bit and then update...
	--       Need to figure out a better way.  Otherwise,
	--		 you end up with BoE markers on things you've put on.
	C_Timer.After(1, function() RefreshItems() end)
end

hooksecurefunc("EquipPendingItem", OnEquipPendingItem)

local function OnOpenBag(bagID)
	if not ignoreDefaultBags then
		for i=1, NUM_CONTAINER_FRAMES, 1 do
			local frame = _G["ContainerFrame"..i];
			if ( frame:IsShown() and frame:GetID() == bagID ) then
				waitingOnBagUpdate[tostring(i)] = true
				isBagUpdateRequested = true
				break
			end
		end
	end
end

local function OnOpenBackpack()
	if not ignoreDefaultBags then
		isBagUpdateRequested = true
	end
end

hooksecurefunc("OpenBag", OnOpenBag)
hooksecurefunc("OpenBackpack", OnOpenBackpack)
hooksecurefunc("ToggleBag", OnOpenBag)

function CaerdonWardrobeMixin:BAG_UPDATE(bagID)
	AddBagUpdateRequest(bagID)
end

function CaerdonWardrobeMixin:BAG_UPDATE_DELAYED()
	local count = 0
	for _ in pairs(waitingOnBagUpdate) do 
		count = count + 1
	end

	if count == 0 then
		RefreshItems()
	else
		isBagUpdateRequested = true
	end
end

function CaerdonWardrobeMixin:PLAYER_LOOT_SPEC_UPDATED()
	if EncounterJournal then
		EncounterJournal_LootUpdate()
	end
end

function CaerdonWardrobeMixin:TRANSMOG_COLLECTION_ITEM_UPDATE()
	-- RefreshItems()
end

function CaerdonWardrobeMixin:UNIT_SPELLCAST_SUCCEEDED(unitTarget, castGUID, spellID)
	if unitTarget == "player" then
		-- Tracking unlock spells to know to refresh
		-- May have to add some other abilities but this is a good place to start.
		if spellID == 1804 then
			RefreshItems(true)
		end
	end
end

function CaerdonWardrobeMixin:TRANSMOG_COLLECTION_UPDATED()
	RefreshItems()
end

function CaerdonWardrobeMixin:MERCHANT_UPDATE()
	RefreshItems()
end

function CaerdonWardrobeMixin:EQUIPMENT_SETS_CHANGED()
	RefreshItems()
end

function CaerdonWardrobeMixin:UPDATE_EXPANSION_LEVEL()
	-- Can change while logged in!
	RefreshItems()
end

function CaerdonWardrobeMixin:BANKFRAME_OPENED()
	-- RefreshMainBank()
end

local configFrame
local isConfigLoaded = false

function CaerdonWardrobeNS:RegisterConfigFrame(frame)
	configFrame = frame
	if isConfigLoaded then
		CaerdonWardrobeNS:FireConfigLoaded()
	end
end

function CaerdonWardrobeNS:FireConfigLoaded()
	isConfigLoaded = true
	if configFrame then
		configFrame:OnConfigLoaded()
	end
end

local LootMixin, Loot = {}

function LootMixin:OnLoad()
    hooksecurefunc("LootFrame_UpdateButton", function(...) Loot:OnLootFrameUpdateButton(...) end)
end

function LootMixin:OnLootFrameUpdateButton(index)
	local numLootItems = LootFrame.numLootItems;
	local numLootToShow = LOOTFRAME_NUMBUTTONS;

	if LootFrame.AutoLootTable then
		numLootItems = #LootFrame.AutoLootTable
	end

	if numLootItems > LOOTFRAME_NUMBUTTONS then
		numLootToShow = numLootToShow - 1
	end

	local button = _G["LootButton"..index];
	local slot = (numLootToShow * (LootFrame.page - 1)) + index;
	if slot <= numLootItems then
		if ((LootSlotHasItem(slot) or (LootFrame.AutoLootTable and LootFrame.AutoLootTable[slot])) and index <= numLootToShow) then
			link = GetLootSlotLink(slot)
			CaerdonWardrobe:UpdateButtonLink(link, "LootFrame", { index = slot, link = link }, button, nil)
		end
	end
end


Loot = CreateFromMixins(LootMixin)
Loot:OnLoad()


local GroupLootMixin, GroupLoot = {}

function GroupLootMixin:OnLoad()
    GroupLootFrame1:HookScript("OnShow", function(...) GroupLoot:OnGroupLootFrameShow(...) end)
    GroupLootFrame2:HookScript("OnShow", function(...) GroupLoot:OnGroupLootFrameShow(...) end)
    GroupLootFrame3:HookScript("OnShow", function(...) GroupLoot:OnGroupLootFrameShow(...) end)
    GroupLootFrame4:HookScript("OnShow", function(...) GroupLoot:OnGroupLootFrameShow(...) end)
end

function GroupLootMixin:OnGroupLootFrameShow(frame)
	local itemLink = GetLootRollItemLink(frame.rollID)
	CaerdonWardrobe:UpdateButtonLink(itemLink, "GroupLootFrame", { index = frame.rollID, link = itemLink}, frame.IconFrame, nil)
end

GroupLoot = CreateFromMixins(GroupLootMixin)
GroupLoot:OnLoad()


local MailMixin, Mail = {}

function MailMixin:OnLoad()
    hooksecurefunc("OpenMailFrame_UpdateButtonPositions", function(...) Mail:OnMailFrameUpdateButtonPositions(...) end)
    hooksecurefunc("SendMailFrame_Update", function(...) Mail:OnSendMailFrameUpdate(...) end)
    hooksecurefunc("InboxFrame_Update", function(...) Mail:OnInboxFrameUpdate(...) end)
end

function MailMixin:OnMailFrameUpdateButtonPositions(letterIsTakeable, textCreated, stationeryIcon, money)
	for i=1, ATTACHMENTS_MAX_RECEIVE do
		local attachmentButton = OpenMailFrame.OpenMailAttachments[i];
		if HasInboxItem(InboxFrame.openMailID, i) then
			-- local name, itemID, itemTexture, count, quality, canUse = GetInboxItem(InboxFrame.openMailID, i);
			local itemLink = GetInboxItemLink(InboxFrame.openMailID, i)
			CaerdonWardrobe:UpdateButtonLink(itemLink, "OpenMailFrame", i, attachmentButton, nil)
		else
            CaerdonWardrobe:ClearButton(attachmentButton)
		end
	end
end

function MailMixin:OnSendMailFrameUpdate()
	for i=1, ATTACHMENTS_MAX_SEND do
		local attachmentButton = SendMailFrame.SendMailAttachments[i];

		if HasSendMailItem(i) then
			local itemLink = GetSendMailItemLink(i)
			CaerdonWardrobe:UpdateButtonLink(itemLink, "SendMailFrame", i, attachmentButton, nil)
		else
            CaerdonWardrobe:ClearButton(attachmentButton)
		end
	end
end

function MailMixin:OnInboxFrameUpdate()
	local numItems, totalItems = GetInboxNumItems();

	for i=1, INBOXITEMS_TO_DISPLAY do
		local index = ((InboxFrame.pageNum - 1) * INBOXITEMS_TO_DISPLAY) + i;

		button = _G["MailItem"..i.."Button"];
		if ( index <= numItems ) then
			-- Setup mail item
			local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, itemCount, wasRead, x, y, z, isGM, firstItemQuantity, firstItemLink = GetInboxHeaderInfo(index);
			CaerdonWardrobe:UpdateButtonLink(firstItemLink, "InboxFrame", index, button, nil)
		else
            CaerdonWardrobe:ClearButton(button)
		end
	end
end

Mail = CreateFromMixins(MailMixin)
Mail:OnLoad()

local QuestMixin, Quest = {}

local version, build, date, tocversion = GetBuildInfo()
local isShadowlands = tonumber(build) > 35700

-- TODO: Consider setting up a callback framework via RegisterAddon
local frame = CreateFrame("frame")
frame:RegisterEvent("QUEST_DATA_LOAD_RESULT")
frame:SetScript("OnEvent", function(this, event, ...)
    Quest[event](Quest, ...)
end)

function QuestMixin:OnLoad()
    self.latestDataRequestQuestID = nil

	-- self:RegisterEvent("QUEST_DATA_LOAD_RESULT")
    hooksecurefunc("QuestInfo_Display", function(...) Quest:OnQuestInfoDisplay(...) end)
end

function QuestMixin:OnQuestInfoDisplay(template, parentFrame)
	-- Hooking OnQuestInfoDisplay instead of OnQuestInfoShowRewards directly because it seems to work
	-- and I was having some problems.  :)
	local i = 1
	while template.elements[i] do
		if template.elements[i] == QuestInfo_ShowRewards then self:OnQuestInfoShowRewards(template, parentFrame) return end
		i = i + 3
	end
end

function QuestMixin:GetQuestID()
	if ( QuestInfoFrame.questLog ) then
		if (isShadowlands) then
			return C_QuestLog.GetSelectedQuest();
		else
			return select(8, GetQuestLogTitle(GetQuestLogSelection()));
		end
	else
		return GetQuestID();
	end
end

function QuestMixin:OnQuestInfoShowRewards(template, parentFrame)
	local numQuestRewards = 0;
	local numQuestChoices = 0;
	local rewardsFrame = QuestInfoFrame.rewardsFrame;
	local questID = self:GetQuestID()

	if questID == 0 then return end -- quest abandoned

	-- if ( template.canHaveSealMaterial ) then
	-- 	local questFrame = parentFrame:GetParent():GetParent();
	-- 	if ( template.questLog ) then
	-- 		questID = questFrame.questID;
	-- 	else
	-- 		questID = GetQuestID();
	-- 	end
	-- end

	local spellGetter;

	if ( QuestInfoFrame.questLog ) then
		if C_QuestLog.ShouldShowQuestRewards(questID) then
			numQuestRewards = GetNumQuestLogRewards();
			numQuestChoices = GetNumQuestLogChoices(questID, true);
			-- playerTitle = GetQuestLogRewardTitle();
			-- numSpellRewards = GetNumQuestLogRewardSpells();
			-- spellGetter = GetQuestLogRewardSpell;
		end
	else
		if ( QuestFrameRewardPanel:IsShown() or C_QuestLog.ShouldShowQuestRewards(questID) ) then
			numQuestRewards = GetNumQuestRewards();
			numQuestChoices = GetNumQuestChoices();
			-- playerTitle = GetRewardTitle();
			-- numSpellRewards = GetNumRewardSpells();
			-- spellGetter = GetRewardSpell;
		end
	end

	if not HaveQuestRewardData(questID) then
		-- HACK: Force load and handle in QUEST_DATA_LOAD_RESULT
		-- Not needed if Blizzard fixes showing of rewards in follow-up quests
		self.latestDataRequestQuestID = questID
		C_QuestLog.RequestLoadQuestByID(questID)
		return
	end

	local options = {
		iconOffset = 0,
		iconSize = 40,
		overridePosition = "TOPLEFT",
		overrideBindingPosition = "TOPLEFT",
		bindingOffsetX = -53,
		bindingOffsetY = -16
	}

	local questItem, name, texture, quality, isUsable, numItems, itemID;
	local rewardsCount = 0;
	if ( numQuestChoices > 0 ) then
		local index;
		local itemLink;
		local baseIndex = rewardsCount;
		for i = 1, numQuestChoices do
			index = i + baseIndex;
			questItem = QuestInfo_GetRewardButton(rewardsFrame, index);
			if ( QuestInfoFrame.questLog ) then
				name, texture, numItems, quality, isUsable, itemID = GetQuestLogChoiceInfo(i);

				if itemID then
					_, itemLink = GetItemInfo(itemID)
				end
			else
				name, texture, numItems, quality, isUsable = GetQuestItemInfo(questItem.type, i);
				itemLink = GetQuestItemLink(questItem.type, i);
			end
			rewardsCount = rewardsCount + 1;

			CaerdonWardrobe:UpdateButtonLink(itemLink, "QuestButton", { itemID = itemID, questID = questID, index = i, questItem = questItem }, questItem, options)
		end
	end

	if ( numQuestRewards > 0) then
		local index;
		local itemLink;
		local baseIndex = rewardsCount;
		local buttonIndex = 0;
		for i = 1, numQuestRewards, 1 do
			buttonIndex = buttonIndex + 1;
			index = i + baseIndex;
			questItem = QuestInfo_GetRewardButton(rewardsFrame, index);
			questItem.type = "reward";
			questItem.objectType = "item";
			if ( QuestInfoFrame.questLog ) then
				name, texture, numItems, quality, isUsable, itemID = GetQuestLogRewardInfo(i);
				if itemID then
					_, itemLink = GetItemInfo(itemID)
				end
			else
				name, texture, numItems, quality, isUsable = GetQuestItemInfo(questItem.type, i);
				itemLink = GetQuestItemLink(questItem.type, i);
			end
			rewardsCount = rewardsCount + 1;

			CaerdonWardrobe:UpdateButtonLink(itemLink, "QuestButton", { itemID = itemID, questID = questID, index = i, questItem = questItem }, questItem, options)
		end
	end
end

function QuestMixin:QUEST_DATA_LOAD_RESULT(questID, success)
	if success then
		-- Total hack until Blizzard fixes quest rewards not loading
		if questID == self.latestDataRequestQuestID then
			self.latestDataRequestQuestID = nil

			if QuestFrameDetailPanel:IsShown() then
				QuestFrameDetailPanel:Hide();
				QuestFrameDetailPanel:Show();
			end
		end
	end
end

Quest = CreateFromMixins(QuestMixin)
Quest:OnLoad()

local WorldMapMixin, WorldMap = {}

function WorldMapMixin:OnLoad()
	hooksecurefunc (WorldMap_WorldQuestPinMixin, "RefreshVisuals", function (self)
		if not IsModifiedClick("COMPAREITEMS") and not ShoppingTooltip1:IsShown() then
			WorldMap:UpdatePin(self);
		end
	end)
end

function WorldMapMixin:UpdatePin(pin)
	local options = {
		iconOffset = -5,
		iconSize = 60,
		overridePosition = "TOPRIGHT",
		-- itemCountOffset = 10,
		-- bindingScale = 0.9
	}

	local itemLink, itemName, itemTexture, numItems, quality, isUsable, itemID

	if GetNumQuestLogRewards(pin.questID) > 0 then
		itemName, itemTexture, numItems, quality, isUsable, itemID = GetQuestLogRewardInfo(1, pin.questID)

		if itemID then
			_, itemLink = GetItemInfo(itemID)
		end
	end
			
	CaerdonWardrobe:UpdateButtonLink(itemLink, "QuestButton", { itemID = itemID, questID = pin.questID }, pin, options)
end

WorldMap = CreateFromMixins(WorldMapMixin)
WorldMap:OnLoad()


local BlackMarketMixin, BlackMarket = {}

local frame = CreateFrame("frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(this, event, ...)
    BlackMarket[event](Quest, ...)
end)

function BlackMarketMixin:OnLoad()
end

function BlackMarketMixin:ADDON_LOADED(name)
	if name == "Blizzard_BlackMarketUI" then
		frame:RegisterEvent("BLACK_MARKET_ITEM_UPDATE")
	end
end

function BlackMarketMixin:UpdateBlackMarketItems()
	local numItems = C_BlackMarket.GetNumItems();
	
	if (not numItems) then
		numItems = 0;
	end
	
	local scrollFrame = BlackMarketScrollFrame;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local buttons = scrollFrame.buttons;
	local numButtons = #buttons;

	for i = 1, numButtons do
		local button = buttons[i];
		local index = offset + i; -- adjust index

		if ( index <= numItems ) then
			local name, texture, quantity, itemType, usable, level, levelType, sellerName, minBid, minIncrement, currBid, youHaveHighBid, numBids, timeLeft, link, marketID, quality = C_BlackMarket.GetItemInfoByIndex(index);
			CaerdonWardrobe:UpdateButtonLink(link, "BlackMarketScrollFrame", index, button, nil)
		else
            CaerdonWardrobe:ClearButton(button)
		end
	end
end

function BlackMarketMixin:UpdateBlackMarketHotItem()
	local button = BlackMarketFrame.HotDeal.Item
	local name, texture, quantity, itemType, usable, level, levelType, sellerName, minBid, minIncrement, currBid, youHaveHighBid, numBids, timeLeft, link, marketID, quality = C_BlackMarket.GetHotItem();
	CaerdonWardrobe:UpdateButtonLink(link, "BlackMarketScrollFrame", "HotItem", button, nil)
end

function BlackMarketMixin:BLACK_MARKET_ITEM_UPDATE()
	BlackMarket:UpdateBlackMarketItems()
	BlackMarket:UpdateBlackMarketHotItem()
end

BlackMarket = CreateFromMixins(BlackMarketMixin)
BlackMarket:OnLoad()
