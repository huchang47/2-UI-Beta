﻿--[[ xMerchant Copyright (c) 2010-2014, Nils Ruesch All rights reserved. ]]

local buttons = {};
local knowns = {};
local errors = {};
-- DONEY
local factions = {};
local currencies = {};
local searching = "";
local RECIPE = GetItemClassInfo(LE_ITEM_CLASS_RECIPE); -- new API 7.0
local REQUIRES_LEVEL = "(%d+)";
local LEVEL = "%d";
local REQUIRES_REPUTATION = ".+ %- (.+)";
-- DONEY
local REQUIRES_REPUTATION_NAME = "(.+) %- .+";
local REQUIRES_SKILL = "(.+) %((%d+)%)";
local SKILL = "%1$s (%2$d)";
local REQUIRES = "(.+)";
local tooltip = CreateFrame("GameTooltip", "NuuhMerchantTooltip", UIParent, "GameTooltipTemplate");

-- DONEY
local ENABLE_DEBUG_DONEY = false;


-- DONEY
local XMERCHANT_DEBUG_TAGS = {};
XMERCHANT_DEBUG_TAGS["[GetError]"] = 0;
XMERCHANT_DEBUG_TAGS["[GetKnown]"] = 0;
XMERCHANT_DEBUG_TAGS["[AltCurrency]"] = 0;
XMERCHANT_DEBUG_TAGS["[CurrencyFrames]"] = 1;
XMERCHANT_DEBUG_TAGS["[CurrencyUpdate]"] = 0;
XMERCHANT_DEBUG_TAGS["[FactionsUpdate]"] = 0;
XMERCHANT_DEBUG_TAGS["[Faction]"] = 0;
XMERCHANT_DEBUG_TAGS["[MerchantItemInfo]"] = 0;

-- DONEY
local function XMERCHANT_LOG_DEBUG(msg)
	if (ENABLE_DEBUG_DONEY) then
		local pos = strfind(msg, " ");
		local tag = pos and pos > 0 and strsub(msg, 0, pos-1) or "";

		if not tag 
		or tag and not XMERCHANT_DEBUG_TAGS[tag] 
		or tag and XMERCHANT_DEBUG_TAGS[tag] and XMERCHANT_DEBUG_TAGS[tag] == 1 then
			DEFAULT_CHAT_FRAME:AddMessage("[xMer][D] "..msg);
		end
	end
end

local function GetError(link, isRecipe)
	if ( not link ) then
		return false;
	end
	
	local id = link:match("item:(%d+)");
	if ( errors[id] ) then
		XMERCHANT_LOG_DEBUG("[GetError]  "..link.."  @return errors[id]: "..errors[id]);
		return errors[id];
	end
	
	tooltip:SetOwner(UIParent, "ANCHOR_NONE");
	tooltip:SetHyperlink(link);
	
	local errormsg = "";
	for i=2, tooltip:NumLines() do
		local text = _G["NuuhMerchantTooltipTextLeft"..i];
		local r, g, b = text:GetTextColor();
		local gettext = text:GetText();
		if ( gettext and r >= 0.9 and g <= 0.2 and b <= 0.2 and gettext ~= RETRIEVING_ITEM_INFO ) then
			if ( errormsg ~= "" ) then
				errormsg = errormsg..", ";
			end
			
			local level = gettext:match(REQUIRES_LEVEL);
			if ( level ) then
				errormsg = errormsg..LEVEL:format(level);
			end
			
			local reputation = gettext:match(REQUIRES_REPUTATION);
			if ( reputation ) then
				errormsg = errormsg..reputation;
				-- DONEY
				local factionName = gettext:match(REQUIRES_REPUTATION_NAME);
				if ( factionName ) then
					local standingLabel = factions[factionName];
					if ( standingLabel ) then
						errormsg = errormsg.." ("..standingLabel..") - "..factionName;
					else
						errormsg = errormsg.." ("..factionName..")";
					end
				end
				XMERCHANT_LOG_DEBUG("RequireFaction  ".."  : "..(reputation or "").."  : "..(factionName or ""));
			end
			
			local skill, slevel = gettext:match(REQUIRES_SKILL);
			if ( skill and slevel ) then
				errormsg = errormsg..SKILL:format(skill, slevel);
			end
			
			local requires = gettext:match(REQUIRES);
			if ( not level and not reputation and not skill and requires ) then
				XMERCHANT_LOG_DEBUG("[GetError]  Line: "..i.."   REQUIRES: "..(requires or ""));
				errormsg = errormsg..requires;
			end
			
			if ( not level and not reputation and not skill and not requires ) then
				if ( errormsg ~= "" ) then
					errormsg = gettext..", "..errormsg;
				else
					errormsg = errormsg..gettext;
				end
			end
		end
		
		local text = _G["NuuhMerchantTooltipTextRight"..i];
		local r, g, b = text:GetTextColor();
		local gettext = text:GetText();
		if ( gettext and r >= 0.9 and g <= 0.2 and b <= 0.2 ) then
			if ( errormsg ~= "" ) then
				errormsg = errormsg..", ";
			end
			errormsg = errormsg..gettext;
		end
		
		XMERCHANT_LOG_DEBUG("[GetError]  Line: "..i.."   TooltipTextLeft: "..(_G["NuuhMerchantTooltipTextLeft"..i]:GetText() or ""));
		XMERCHANT_LOG_DEBUG("[GetError]  Line: "..i.."   TooltipTextRight: "..(_G["NuuhMerchantTooltipTextRight"..i]:GetText() or ""));
		
		if ( isRecipe and i == 5 ) then
			XMERCHANT_LOG_DEBUG("[GetError]  Line: "..i.."   isRecipe detail line");
			break;
		end
	end
	
	if ( errormsg == "" ) then
		return false;
	end
	
	errors[id] = errormsg;
	return errormsg;
end

local function GetKnown(link)
	if ( not link ) then
		return false;
	end
	
	local id = link:match("item:(%d+)");
	if ( knowns[id] ) then
		XMERCHANT_LOG_DEBUG("[GetKnown]  "..link.."  @return true");
		return true;
	end
	
	tooltip:SetOwner(UIParent, "ANCHOR_NONE");
	tooltip:SetHyperlink(link);
	
	for i=1, tooltip:NumLines() do
		if ( _G["NuuhMerchantTooltipTextLeft"..i]:GetText() == ITEM_SPELL_KNOWN ) then
			knowns[id] = true;
			return true;
		end
	end
	
	return false;
end

-- DONEY
local function FactionsUpdate()
	wipe(factions);
	
	for factionIndex = 1, GetNumFactions() do
		-- Patch 5.0.4 Added new return value: factionID
		local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID = GetFactionInfo(factionIndex);

		if name~=nil and factionID~=nil then
			-- Patch 5.1.0 Added API GetFriendshipReputation
			local friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel = GetFriendshipReputation(factionID)
			
			local standingLabel
		if isHeader == nil then

			if friendID ~= nil then
				standingLabel = friendTextLevel or "unkown"
			else
					standingLabel = (_G["FACTION_STANDING_LABEL"..tostring(standingId)] or "unkown")
				end
				factions[name] = standingLabel

				if friendID ~= nil then
					XMERCHANT_LOG_DEBUG("[FactionsUpdate]  " .. name .. " - " .. earnedValue .. " - " .. bottomValue .. " - " .. topValue .. " - " .. tostring(standingId) .. " " .. standingLabel);
				end
			end
	  end
	end
end

local function CurrencyUpdate()
	wipe(currencies);
	
	local limit = GetCurrencyListSize();
	XMERCHANT_LOG_DEBUG("[CurrencyUpdate] GetCurrencyListSize  limit: "..limit);
	
	for i=1, limit do
		-- DONEY note for 6.0   the itemID seemes not avail any more, while the http://wowpedia.org/API_GetCurrencyListInfo is out-dated, 2014-10-25
		local name, isHeader, _, _, _, count, icon, maximum, hasWeeklyLimit, currentWeeklyAmount, _, itemID = GetCurrencyListInfo(i);
		if ( not isHeader ) then
			XMERCHANT_LOG_DEBUG("[CurrencyUpdate]  ".."  name: "..(name or "nil").."  count: "..(count or "nil").."  maxi: "..(maximum or "nil")
				.."  itemID: "..(itemID or "nil"));
		end
		if ( not isHeader and itemID ) then
			currencies[tonumber(itemID)] = count;
			-- DONEY fix for 5.0 points
			if ( not isHeader and itemID and tonumber(itemID) <= 9 ) then
				currencies[name] = count;
			end
		elseif ( not isHeader and not itemID ) then
			currencies[name] = count;
			XMERCHANT_LOG_DEBUG("[CurrencyUpdate]  ".."  name: "..(name or "nil").."  not itemID");
		end
	end
	
	XMERCHANT_DEBUG_TAGS["CurrencyUpdate"] = 0;
	
	for i=INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED, 1 do
		local itemID = GetInventoryItemID("player", i);
		if ( itemID ) then
			currencies[tonumber(itemID)] = 1;
		end
	end
	
	for bagID=0, NUM_BAG_SLOTS, 1 do
		local numSlots = GetContainerNumSlots(bagID);
		for slotID=1, numSlots, 1 do
			local itemID = GetContainerItemID(bagID, slotID);
			if ( itemID ) then
				local count = select(2, GetContainerItemInfo(bagID, slotID));
				itemID = tonumber(itemID);
				local currency = currencies[itemID];
				if ( currency ) then
					currencies[itemID] = currency+count;
				else
					currencies[itemID] = count;
				end
			end
		end
	end
end

local function AltCurrencyFrame_Update(item, texture, cost, itemID, currencyName)
	if ( itemID ~= 0 or currencyName) then
		local currency = currencies[itemID] or currencies[currencyName];
		if ( currency and currency < cost or not currency ) then
			-- DONEY
			XMERCHANT_LOG_DEBUG("[AltCurrency]  currency: "..(currency or "nil").."  cost: "..(cost or "nil").."  itemID: "..(itemID or "nil").."  currencyName: "..(currencyName or "nil"));
			item.count:SetTextColor(1, 0, 0);
		else
			item.count:SetTextColor(1, 1, 1);
		end
	end
	
	item.count:SetText(cost);
	item.icon:SetTexture(texture);
	if ( item.pointType == HONOR_POINTS ) then
		item.count:SetPoint("RIGHT", item.icon, "LEFT", 1, 0);
		item.icon:SetTexCoord(0.03125, 0.59375, 0.03125, 0.59375);
	else
		item.count:SetPoint("RIGHT", item.icon, "LEFT", -2, 0);
		item.icon:SetTexCoord(0, 1, 0, 1);
	end
	local iconWidth = 17;
	item.icon:SetWidth(iconWidth);
	item.icon:SetHeight(iconWidth);
	item:SetWidth(item.count:GetWidth() + iconWidth + 4);
	item:SetHeight(item.count:GetHeight() + 4);
end

local function UpdateAltCurrency(button, index, i)
	XMERCHANT_LOG_DEBUG("[CurrencyFrames] UpdateAltCurrency  ".." index: "..index.." i: "..i);
	local currency_frames = {};
	local lastFrame;
	local honorPoints, arenaPoints, itemCount = GetMerchantItemCostInfo(index);
	
	if ( select(4, GetBuildInfo()) >= 40000 ) then
		itemCount, honorPoints, arenaPoints = honorPoints, 0, 0;
	end
	
	if ( itemCount > 0 ) then
		for i=1, MAX_ITEM_COST, 1 do
			local itemTexture, itemValue, itemLink, currencyName = GetMerchantItemCostItem(index, i);
			local item = button.item[i];
			item.index = index;
			item.item = i;
			if( currencyName ) then
				item.pointType = "Beta";
				item.itemLink = currencyName;
			else
				item.pointType = nil;
				item.itemLink = itemLink;
			end
			
			-- DONEY
			if i == 1 then
				XMERCHANT_LOG_DEBUG("[AltCurrency]  ".."  index: "..(index or "nil").."  itemLink: "..(itemLink or "nil").."  i: "..(i or "nil"));
			end
			local itemID = tonumber((itemLink or "item:0"):match("item:(%d+)"));
			AltCurrencyFrame_Update(item, itemTexture, itemValue, itemID, currencyName);

			if ( not itemTexture ) then
				item:Hide();
			else
				lastFrame = item;
				lastFrame._dbg_name = "item"..i
				table.insert(currency_frames, item)
				item:Show();
			end
		end
	else
		for i=1, MAX_ITEM_COST, 1 do
			button.item[i]:Hide();
		end
	end
	
	local arena = button.arena;
	if ( arenaPoints > 0 ) then
		arena.pointType = ARENA_POINTS;
		
		AltCurrencyFrame_Update(arena, "Interface\\PVPFrame\\PVP-ArenaPoints-Icon", arenaPoints);
		
		if ( GetArenaCurrency() < arenaPoints ) then
			arena.count:SetTextColor(1, 0, 0);
		else
			arena.count:SetTextColor(1, 1, 1);
		end
		
		lastFrame = arena;
		lastFrame._dbg_name = "arena"
		table.insert(currency_frames, arena)
		arena:Show();
	else
		arena:Hide();
	end
	
	local honor = button.honor;
	if ( honorPoints > 0 ) then
		honor.pointType = HONOR_POINTS;
		
		local factionGroup = UnitFactionGroup("player");
		local honorTexture = "Interface\\TargetingFrame\\UI-PVP-Horde";
		if ( factionGroup ) then
			honorTexture = "Interface\\TargetingFrame\\UI-PVP-"..factionGroup;
		end
		
		AltCurrencyFrame_Update(honor, honorTexture, honorPoints);
		
		if ( GetHonorCurrency() < honorPoints ) then
			honor.count:SetTextColor(1, 0, 0);
		else
			honor.count:SetTextColor(1, 1, 1);
		end
		
		lastFrame = honor;
		lastFrame._dbg_name = "honor"
		table.insert(currency_frames, arena)
		honor:Show();
	else
		honor:Hide();
	end

	button.money._dbg_name = "money"
	table.insert(currency_frames, button.money)

	-- DONEY
	lastFrame = nil
	for i,frame in ipairs(currency_frames) do
		if i == 1 then
			XMERCHANT_LOG_DEBUG("[CurrencyFrames]  i: "..i.."  "..frame._dbg_name.."  RIGHT +");
			frame:SetPoint("RIGHT", -2, 6);
		else
			if lastFrame then
				XMERCHANT_LOG_DEBUG("[CurrencyFrames]  i: "..i.."  "..frame._dbg_name.."  RIGHT to "..lastFrame._dbg_name);
				frame:SetPoint("RIGHT", lastFrame, "LEFT", -2, 0);
			else
				-- warning, lastFrame nil unexpected
				XMERCHANT_LOG_DEBUG("[CurrencyFrames]  i: "..i.."  "..frame._dbg_name.."  lastFrame nil unexpected!");
				frame:SetPoint("RIGHT", -2, 0);
			end
		end
		lastFrame = frame
	end
end

local function MerchantUpdate()
	XMERCHANT_LOG_DEBUG("[xMerchant][Debug] MerchantUpdate");
	local self = NuuhMerchantFrame;
	local numMerchantItems = GetMerchantNumItems();

	
	FauxScrollFrame_Update(self.scrollframe, numMerchantItems, 10, 29.4, nil, nil, nil, nil, nil, nil, 1);
	for i=1, 10, 1 do
		local offset = i+FauxScrollFrame_GetOffset(self.scrollframe);
		local button = buttons[i];
		button.hover = nil;
		if ( offset <= numMerchantItems ) then
			local name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(offset);
			local link = GetMerchantItemLink(offset);
			-- DONEY
			local name_text = name;
			local iteminfo_text = "";
			local r, g, b = 0.5, 0.5, 0.5;
			local _, itemRarity, itemType, itemSubType;
			local iLevel, iLevelText;
			if ( link ) then
				_, _, itemRarity, iLevel, _, itemType, itemSubType = GetItemInfo(link);
				if itemRarity then
					r, g, b = GetItemQualityColor(itemRarity);
					button.itemname:SetTextColor(r, g, b);
				end
				-- DONEY
				if itemSubType then
					iteminfo_text = itemSubType:gsub("%(OBSOLETE%)", "");
					if iLevel and iLevel > 1 then
						iLevelText = tostring(iLevel);
						iteminfo_text = iteminfo_text.." - "..iLevelText;
					end
				else
					iteminfo_text = ""
				end
				
				local alpha = 0.3;
				if ( searching == "" or searching == SEARCH:lower() or name:lower():match(searching) 
					or ( itemRarity and ( tostring(itemRarity):lower():match(searching) or _G["ITEM_QUALITY"..tostring(itemRarity).."_DESC"]:lower():match(searching) ) )
					or ( itemType and itemType:lower():match(searching) ) 
					or ( itemSubType and itemSubType:lower():match(searching) )
					) then
					alpha = 1;
				elseif ( self.tooltipsearching ) then
					tooltip:SetOwner(UIParent, "ANCHOR_NONE");
					tooltip:SetHyperlink(link);
					for i=1, tooltip:NumLines() do
						if ( _G["NuuhMerchantTooltipTextLeft"..i]:GetText():lower():match(searching) ) then
							alpha = 1;
							break;
						end
					end
				end
				button:SetAlpha(alpha);
			else

			end
			

			button.itemname:SetText((numAvailable >= 0 and "|cffffffff["..numAvailable.."]|r " or "")..(quantity > 1 and "|cffffffff"..quantity.."x|r " or "")..(name or "|cffff0000"..RETRIEVING_ITEM_INFO));
			button.icon:SetTexture(texture);
			
			UpdateAltCurrency(button, offset, i);
			if ( extendedCost and price <= 0 ) then
				button.price = nil;
				button.extendedCost = true;
				button.money:SetText("");
			elseif ( extendedCost and price > 0 ) then
				button.price = price;
				button.extendedCost = true;
				button.money:SetText(GetCoinTextureString(price));
			else
				button.price = price;
				button.extendedCost = nil;
				button.money:SetText(GetCoinTextureString(price));
			end
			
			if ( GetMoney() < price ) then
				button.money:SetTextColor(1, 0, 0);
			else
				button.money:SetTextColor(1, 1, 1);
			end
			
			if ( numAvailable == 0 ) then
				button.highlight:SetVertexColor(0.5, 0.5, 0.5, 0.5);
				button.highlight:Show();
				button.isShown = 1;
			elseif ( not isUsable ) then
				button.highlight:SetVertexColor(1, 0.2, 0.2, 0.5);
				button.highlight:Show();
				button.isShown = 1;
				
				local errors = GetError(link, itemType and itemType == RECIPE);
				if ( errors ) then
					-- DONEY
					iteminfo_text = "|cffd00000"..iteminfo_text.." - "..errors.."|r";
				end
			elseif ( itemType and itemType == RECIPE and not GetKnown(link) ) then
				button.highlight:SetVertexColor(0.2, 1, 0.2, 0.5);
				button.highlight:Show();
				button.isShown = 1;
			else
				button.highlight:SetVertexColor(r, g, b, 0.5);
				button.highlight:Hide();
				button.isShown = nil;
				-- DONEY
				local errors = GetError(link, itemType and itemType == RECIPE);
				if ( errors ) then
					iteminfo_text = "|cffd00000"..iteminfo_text.." - "..errors.."|r";
				end
			end

			if button.itemname:GetNumLines() <= 1 then
				button.iteminfo:SetText(iteminfo_text);
			else
				button.iteminfo:SetText(iteminfo_text);
			end
			
			button.r = r;
			button.g = g;
			button.b = b;
			button.link = GetMerchantItemLink(offset);
			button.hasItem = true;
			button.texture = texture;
			button:SetID(offset);
			button:Show();
		else
			button.price = nil;
			button.hasItem = nil;
			button:Hide();
		end
		if ( button.hasStackSplit == 1 ) then
			StackSplitFrame:Hide();
		end
	end
end

local function OnVerticalScroll(self, offset)
	XMERCHANT_LOG_DEBUG("[xMerchant][Debug] OnVerticalScroll");
	FauxScrollFrame_OnVerticalScroll(self, offset, 29.4, MerchantUpdate);
end

local function OnClick(self, button)
	if ( IsModifiedClick() ) then
		MerchantItemButton_OnModifiedClick(self, button);
	else
		MerchantItemButton_OnClick(self, button);
	end
end

local function OnEnter(self)
	if ( self.isShown and not self.hover ) then
		self.oldr, self.oldg, self.oldb, self.olda = self.highlight:GetVertexColor();
		self.highlight:SetVertexColor(self.r, self.g, self.b, self.olda);
		self.hover = 1;
	else
		self.highlight:Show();
	end
	MerchantItemButton_OnEnter(self);
end

local function OnLeave(self)
	if ( self.isShown ) then
		self.highlight:SetVertexColor(self.oldr, self.oldg, self.oldb, self.olda);
		self.hover = nil;
	else
		self.highlight:Hide();
	end
	GameTooltip:Hide();
	ResetCursor();
	MerchantFrame.itemHover = nil;
end

local function SplitStack(button, split)
	if ( button.extendedCost ) then
		MerchantFrame_ConfirmExtendedItemCost(button, split)
	elseif ( split > 0 ) then
		BuyMerchantItem(button:GetID(), split);
	end
end

local function Item_OnClick(self)
	HandleModifiedItemClick(self.itemLink);
end

local function Item_OnEnter(self)
	local parent = self:GetParent();
	if ( parent.isShown and not parent.hover ) then
		parent.oldr, parent.oldg, parent.oldb, parent.olda = parent.highlight:GetVertexColor();
		parent.highlight:SetVertexColor(parent.r, parent.g, parent.b, parent.olda);
		parent.hover = 1;
	else
		parent.highlight:Show();
	end
	
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if ( self.pointType == ARENA_POINTS ) then
		GameTooltip:SetText(ARENA_POINTS, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine(TOOLTIP_ARENA_POINTS, nil, nil, nil, 1);
		GameTooltip:Show();
	elseif ( self.pointType == HONOR_POINTS ) then
		GameTooltip:SetText(HONOR_POINTS, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine(TOOLTIP_HONOR_POINTS, nil, nil, nil, 1);
		GameTooltip:Show();
	elseif ( self.pointType == "Beta" ) then
		GameTooltip:SetText(self.itemLink, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:Show();
	else
		GameTooltip:SetHyperlink(self.itemLink);
	end
	if ( IsModifiedClick("DRESSUP") ) then
		ShowInspectCursor();
	else
		ResetCursor();
	end
end

local function Item_OnLeave(self)
	local parent = self:GetParent();
	if ( parent.isShown ) then
		parent.highlight:SetVertexColor(parent.oldr, parent.oldg, parent.oldb, parent.olda);
		parent.hover = nil;
	else
		parent.highlight:Hide();
	end
	GameTooltip:Hide();
	ResetCursor();
end

local function OnEvent(self, event)
		self:UnregisterEvent("ADDON_LOADED");
		local x = 0;
		if ( x ~= 0 ) then
			-- DONEY
			self.search:SetWidth(230-x);
			self.search:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 60-x, 9);
		end
		return;
end

local frame = CreateFrame("Frame", "NuuhMerchantFrame", MerchantFrame);
frame:RegisterEvent("ADDON_LOADED");
frame:SetScript("OnEvent", OnEvent);
frame:SetWidth(295);
frame:SetHeight(294);
-- DONEY
-- frame:SetPoint("TOPLEFT", 21, -76);
frame:SetPoint("TOPLEFT", 10, -65);

local function OnTextChanged(self)
	XMERCHANT_LOG_DEBUG("[xMerchant][Debug] OnTextChanged");
	searching = self:GetText():trim():lower();
	MerchantUpdate();
end

local function OnShow(self)
	self:SetText(SEARCH);
	searching = "";
end

local function OnEnterPressed(self)
	self:ClearFocus();
end

local function OnEscapePressed(self)
	self:ClearFocus();
	self:SetText(SEARCH);
	searching = "";
end

local function OnEditFocusLost(self)
	self:HighlightText(0, 0);
	if ( strtrim(self:GetText()) == "" ) then
		self:SetText(SEARCH);
		searching = "";
	end
end

local function OnEditFocusGained(self)
	XMERCHANT_LOG_DEBUG("[xMerchant][Debug] OnEditFocusGained");
	self:HighlightText();
	if ( self:GetText():trim():lower() == SEARCH:lower() ) then
		self:SetText("");
	end
end

local search = CreateFrame("EditBox", "$parentSearch", frame, "InputBoxTemplate");
frame.search = search;
-- DONEY
search:SetWidth(230);
search:SetHeight(24);
-- DONEY
search:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 60, 9);
search:SetAutoFocus(false);
search:SetFontObject(ChatFontSmall);
search:SetScript("OnTextChanged", OnTextChanged);
search:SetScript("OnShow", OnShow);
search:SetScript("OnEnterPressed", OnEnterPressed);
search:SetScript("OnEscapePressed", OnEscapePressed);
search:SetScript("OnEditFocusLost", OnEditFocusLost);
search:SetScript("OnEditFocusGained", OnEditFocusGained);
search:SetText(SEARCH);

local function Search_OnClick(self)
	if ( self:GetChecked() ) then
		PlaySound("igMainMenuOptionCheckBoxOn");
		frame.tooltipsearching = 1;
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
		frame.tooltipsearching = nil;
	end
	if ( searching ~= "" and searching ~= SEARCH:lower() ) then
		XMERCHANT_LOG_DEBUG("[xMerchant][Debug] Search_OnClick");
		MerchantUpdate();
	end
end

local function Search_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(xMerchant_Tobrowseitemtooltipstoo);
end

local tooltipsearching = CreateFrame("CheckButton", "$parentTooltipSearching", frame, "InterfaceOptionsSmallCheckButtonTemplate");
search.tooltipsearching = tooltipsearching;
tooltipsearching:SetWidth(21);
tooltipsearching:SetHeight(21);
tooltipsearching:SetPoint("LEFT", search, "RIGHT", 5, -2);
tooltipsearching:SetHitRectInsets(0, 0, 0, 0);
tooltipsearching:SetScript("OnClick", Search_OnClick);
tooltipsearching:SetScript("OnEnter", Search_OnEnter);
tooltipsearching:SetScript("OnLeave", GameTooltip_Hide);
tooltipsearching:SetChecked(false);

local scrollframe = CreateFrame("ScrollFrame", "NuuhMerchantScrollFrame", frame, "FauxScrollFrameTemplate");
frame.scrollframe = scrollframe;
-- DONEY
-- scrollframe:SetWidth(295);
scrollframe:SetWidth(284);
scrollframe:SetHeight(298);
-- DONEY
-- scrollframe:SetPoint("TOPLEFT", MerchantFrame, 22, -74);
scrollframe:SetPoint("TOPLEFT", MerchantFrame, 22, -65);
scrollframe:SetScript("OnVerticalScroll", OnVerticalScroll);

local top = frame:CreateTexture("$parentTop", "ARTWORK");
frame.top = top
top:SetWidth(31);
top:SetHeight(256);
top:SetPoint("TOPRIGHT", 30, 6);
top:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar");
top:SetTexCoord(0, 0.484375, 0, 1);

local bottom = frame:CreateTexture("$parentBottom", "ARTWORK");
frame.bottom = bottom
bottom:SetWidth(31);
bottom:SetHeight(108);
bottom:SetPoint("BOTTOMRIGHT", 30, -6);
bottom:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar");
bottom:SetTexCoord(0.515625, 1, 0, 0.421875);

for i=1, 10, 1 do
	local button = CreateFrame("Button", "NuuhMerchantFrame"..i, frame);
	button:SetWidth(frame:GetWidth());
	button:SetHeight(29.4);
	if ( i == 1 ) then
		button:SetPoint("TOPLEFT", 0, -1);
	else
		button:SetPoint("TOP", buttons[i-1], "BOTTOM");
	end
	button:RegisterForClicks("LeftButtonUp","RightButtonUp");
	button:RegisterForDrag("LeftButton");
	button.UpdateTooltip = OnEnter;
	button.SplitStack = SplitStack;
	button:SetScript("OnClick", OnClick);
	button:SetScript("OnDragStart", MerchantItemButton_OnClick);
	button:SetScript("OnEnter", OnEnter);
	button:SetScript("OnLeave", OnLeave);
	button:SetScript("OnHide", OnHide);
	
	local highlight = button:CreateTexture("$parentHighlight", "BACKGROUND"); -- better highlight
	button.highlight = highlight;
	highlight:SetAllPoints();
	highlight:SetBlendMode("ADD");
	highlight:SetTexture("Interface\\Buttons\\UI-Listbox-Highlight2");
	highlight:Hide();
	
	local itemname_fontsize = 16
	local iteminfo_fontsize = 14

	local itemname = button:CreateFontString("ARTWORK", "$parentItemName");
	button.itemname = itemname;
	itemname:SetFont(GameFontHighlight:GetFont(), itemname_fontsize)
	itemname:SetPoint("TOPLEFT", 30.4, 0);
	itemname:SetJustifyH("LEFT");
	itemname:SetWordWrap(false) 
	
	local iteminfo = button:CreateFontString("ARTWORK", "$parentItemInfo");
	button.iteminfo = iteminfo;
	iteminfo:SetFont(GameFontNormal:GetFont(), iteminfo_fontsize)
	iteminfo:SetPoint("BOTTOMLEFT", 35.4, 0);
	iteminfo:SetJustifyH("LEFT");
	iteminfo:SetTextColor(0.5, 0.5, 0.5);
	
	local icon = button:CreateTexture("$parentIcon", "BORDER");
	button.icon = icon;
	icon:SetWidth(25.4);
	icon:SetHeight(25.4);
	icon:SetPoint("LEFT", 2, 0);
	icon:SetTexture("Interface\\Icons\\temp");

	local money = button:CreateFontString("ARTWORK", "$parentMoney");
	button.money = money;
	money:SetFontObject(GameFontHighlight)
	money:SetPoint("RIGHT", -2, 0);
	money:SetJustifyH("RIGHT");
	itemname:SetPoint("RIGHT", money, "LEFT", -2, 0);
	
	button.item = {};
	for j=1, MAX_ITEM_COST, 1 do
		local item = CreateFrame("Button", "$parentItem"..j, button);
		button.item[j] = item;
		item:SetWidth(17);
		item:SetHeight(17);
		if ( j == 1 ) then
			item:SetPoint("RIGHT", -2, 0);
		else
			item:SetPoint("RIGHT", button.item[j-1], "LEFT", -2, 0);
		end
		item:RegisterForClicks("LeftButtonUp","RightButtonUp");
		item:SetScript("OnClick", Item_OnClick);
		item:SetScript("OnEnter", Item_OnEnter);
		item:SetScript("OnLeave", Item_OnLeave);
		item.hasItem = true;
		item.UpdateTooltip = Item_OnEnter;
		
		local icon = item:CreateTexture("$parentIcon", "BORDER");
		item.icon = icon;
		icon:SetWidth(17);
		icon:SetHeight(17);
		icon:SetPoint("RIGHT");
		
		local count = item:CreateFontString("ARTWORK", "$parentCount", "GameFontHighlight");
		item.count = count;
		count:SetPoint("RIGHT", icon, "LEFT", -2, 0);
	end
	
	local honor = CreateFrame("Button", "$parentHonor", button);
	button.honor = honor;
	honor.itemLink = select(2, GetItemInfo(43308)) or "\124cffffffff\124Hitem:43308:0:0:0:0:0:0:0:0\124h[Ehrenpunkte]\124h\124r";
	honor:SetWidth(17);
	honor:SetHeight(17);
	honor:SetPoint("RIGHT", -2, 0);
	honor:RegisterForClicks("LeftButtonUp","RightButtonUp");
	honor:SetScript("OnClick", Item_OnClick);
	honor:SetScript("OnEnter", Item_OnEnter);
	honor:SetScript("OnLeave", Item_OnLeave);
	honor.hasItem = true;
	honor.UpdateTooltip = Item_OnEnter;
	
	local icon = honor:CreateTexture("$parentIcon", "BORDER");
	honor.icon = icon;
	icon:SetWidth(17);
	icon:SetHeight(17);
	icon:SetPoint("RIGHT");
	
	local count = honor:CreateFontString("ARTWORK", "$parentCount", "GameFontHighlight");
	honor.count = count;
	count:SetPoint("RIGHT", icon, "LEFT", -2, 0);
	
	local arena = CreateFrame("Button", "$parentArena", button);
	button.arena = arena;
	arena.itemLink = select(2, GetItemInfo(43307)) or "\124cffffffff\124Hitem:43307:0:0:0:0:0:0:0:0\124h[Arenapunkte]\124h\124r";
	arena:SetWidth(17);
	arena:SetHeight(17);
	arena:SetPoint("RIGHT", -2, 0);
	arena:RegisterForClicks("LeftButtonUp","RightButtonUp");
	arena:SetScript("OnClick", Item_OnClick);
	arena:SetScript("OnEnter", Item_OnEnter);
	arena:SetScript("OnLeave", Item_OnLeave);
	arena.hasItem = true;
	arena.UpdateTooltip = Item_OnEnter;
	
	local icon = arena:CreateTexture("$parentIcon", "BORDER");
	arena.icon = icon;
	icon:SetWidth(17);
	icon:SetHeight(17);
	icon:SetPoint("RIGHT");
	
	local count = arena:CreateFontString("ARTWORK", "$parentCount", "GameFontHighlight");
	arena.count = count;
	count:SetPoint("RIGHT", icon, "LEFT", -2, 0);
	
	buttons[i] = button;
end

local function Update()
	if ( MerchantFrame.selectedTab == 1 ) then
		for i=1, 12, 1 do
			_G["MerchantItem"..i]:Hide();
		end
		frame:Show();
		XMERCHANT_LOG_DEBUG("[xMerchant][Debug] Update:  CurrencyUpdate");
		CurrencyUpdate();
		-- DONEY
		FactionsUpdate();
		XMERCHANT_LOG_DEBUG("[xMerchant][Debug] Update:  MerchantUpdate");
		MerchantUpdate();
	else
		frame:Hide();
		for i=1, 12, 1 do
			_G["MerchantItem"..i]:Show();
		end
		if ( StackSplitFrame:IsShown() ) then
			StackSplitFrame:Hide();
		end
	end
end
hooksecurefunc("MerchantFrame_Update", Update);

local function OnHide()
	wipe(errors);
	wipe(currencies);
end
hooksecurefunc("MerchantFrame_OnHide", OnHide);


MerchantBuyBackItem:ClearAllPoints();
-- DONEY
-- MerchantBuyBackItem:SetPoint("BOTTOMLEFT", 189, 90);
MerchantBuyBackItem:SetPoint("BOTTOMLEFT", 175, 32);

for _, frame in next, { MerchantNextPageButton, MerchantPrevPageButton, MerchantPageText } do
	frame:Hide()
	frame.Show = function() end;
end
