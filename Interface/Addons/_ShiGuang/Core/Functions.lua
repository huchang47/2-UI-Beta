﻿local _, ns = ...
local M, R, U, I = unpack(ns)
local cr, cg, cb = I.r, I.g, I.b

local _G = _G
local type, pairs, tonumber, wipe, next, select, unpack = type, pairs, tonumber, table.wipe, next, select, unpack
local strmatch, gmatch, strfind, format, gsub = string.match, string.gmatch, string.find, string.format, string.gsub
local min, max, floor, rad = math.min, math.max, math.floor, math.rad

function SenduiCmd(cmd) ChatFrame1EditBox:SetText(""); ChatFrame1EditBox:Insert(cmd); ChatEdit_SendText(ChatFrame1EditBox); end
-- Math
do
	-- Numberize
	function M.Numb(n)
		if MaoRUIDB["NumberFormat"] == 1 then
			if n >= 1e12 then
				return format("%.2ft", n / 1e12)
			elseif n >= 1e9 then
				return format("%.2fb", n / 1e9)
			elseif n >= 1e6 then
				return format("%.2fm", n / 1e6)
			elseif n >= 1e3 then
				return format("%.1fk", n / 1e3)
			else
				return format("%.0f", n)
			end
		elseif MaoRUIDB["NumberFormat"] == 2 then
			if n >= 1e12 then
				return format("%.2f"..U["NumberCap3"], n / 1e12)
			elseif n >= 1e8 then
				return format("%.2f"..U["NumberCap2"], n / 1e8)
			elseif n >= 1e4 then
				return format("%.1f"..U["NumberCap1"], n / 1e4)
			else
				return format("%.0f", n)
			end
		else
			return format("%.0f", n)
		end
	end

	function M:Round(number, idp)
		idp = idp or 0
		local mult = 10 ^ idp
		return floor(number * mult + .5) / mult
	end

	-- Cooldown calculation
	local day, hour, minute = 86400, 3600, 60
	function M.FormatTime(s)
		if s >= day then
			return format("%d"..I.MyColor.."d", s/day), s%day
		elseif s >= hour then
			return format("%d"..I.MyColor.."h", s/hour), s%hour
		elseif s >= minute then
			return format("%d"..I.MyColor.."m", s/minute), s%minute
		elseif s > 10 then
			return format("|cffcccc33%d|r", s), s - floor(s)
		elseif s > 3 then
			return format("|cffffff00%d|r", s), s - floor(s)
		else
			if R.db["Actionbar"]["DecimalCD"] then
				return format("|cffff0000%.1f|r", s), s - format("%.1f", s)
			else
				return format("|cffff0000%d|r", s + .5), s - floor(s)
			end
		end
	end

	function M.FormatTimeRaw(s)
		if s >= day then
			return format("%dd", s/day)
		elseif s >= hour then
			return format("%dh", s/hour)
		elseif s >= minute then
			return format("%dm", s/minute)
		elseif s >= 3 then
			return floor(s)
		else
			return format("%d", s)
		end
	end

	function M:CooldownOnUpdate(elapsed, raw)
		local formatTime = raw and M.FormatTimeRaw or M.FormatTime
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= .1 then
			local timeLeft = self.expiration - GetTime()
			if timeLeft > 0 then
				local text = formatTime(timeLeft)
				self.timer:SetText(text)
			else
				self:SetScript("OnUpdate", nil)
				self.timer:SetText(nil)
			end
			self.elapsed = 0
		end
	end

	-- GUID to npcID
	function M.GetNPCID(guid)
		local id = tonumber(strmatch((guid or ""), "%-(%d-)%-%x-$"))
		return id
	end

	-- Table
	function M.CopyTable(source, target)
		for key, value in pairs(source) do
			if type(value) == "table" then
				if not target[key] then target[key] = {} end
				for k in pairs(value) do
					target[key][k] = value[k]
				end
			else
				target[key] = value
			end
		end
	end

	function M.SplitList(list, variable, cleanup)
		if cleanup then wipe(list) end
		for word in gmatch(variable, "%S+") do
			word = tonumber(word) or word -- use number if exists, needs review
			list[word] = true
		end
	end

	-- Atlas info
	function M:GetTextureStrByAtlas(info, sizeX, sizeY)
		local file = info and info.file
		if not file then return end

		local width, height, txLeft, txRight, txTop, txBottom = info.width, info.height, info.leftTexCoord, info.rightTexCoord, info.topTexCoord, info.bottomTexCoord
		local atlasWidth = width / (txRight-txLeft)
		local atlasHeight = height / (txBottom-txTop)

		return format("|T%s:%d:%d:0:0:%d:%d:%d:%d:%d:%d|t", file, (sizeX or 0), (sizeY or 0), atlasWidth, atlasHeight, atlasWidth*txLeft, atlasWidth*txRight, atlasHeight*txTop, atlasHeight*txBottom)
	end
end

-- Color
do
	function M.HexRGB(r, g, b)
		if r then
			if type(r) == "table" then
				if r.r then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
			end
			return format("|cff%02x%02x%02x", r*255, g*255, b*255)
		end
	end

	function M.ClassColor(class)
		local color = I.ClassColors[class]
		if not color then return 1, 1, 1 end
		return color.r, color.g, color.b
	end

	function M.UnitColor(unit)
		local r, g, b = 1, 1, 1
		if UnitIsPlayer(unit) then
			local class = select(2, UnitClass(unit))
			if class then
				r, g, b = M.ClassColor(class)
			end
		elseif UnitIsTapDenied(unit) then
			r, g, b = .6, .6, .6
		else
			local reaction = UnitReaction(unit, "player")
			if reaction then
				local color = FACTION_BAR_COLORS[reaction]
				r, g, b = color.r, color.g, color.b
			end
		end
		return r, g, b
	end
end

-- Itemlevel
do
	local iLvlDB = {}
	local itemLevelString = "^"..gsub(ITEM_LEVEL, "%%d", "")
	local enchantString = gsub(ENCHANTED_TOOLTIP_LINE, "%%s", "(.+)")
	local essenceTextureID = 2975691
	local essenceDescription = GetSpellDescription(277253)
	local ITEM_SPELL_TRIGGER_ONEQUIP = ITEM_SPELL_TRIGGER_ONEQUIP
	local RETRIEVING_ITEM_INFO = RETRIEVING_ITEM_INFO

	local tip = CreateFrame("GameTooltip", "UI_ScanTooltip", nil, "GameTooltipTemplate")
	M.ScanTip = tip

	function M:InspectItemTextures()
		if not tip.gems then
			tip.gems = {}
		else
			wipe(tip.gems)
		end

		if not tip.essences then
			tip.essences = {}
		else
			for _, essences in pairs(tip.essences) do
				wipe(essences)
			end
		end

		local step = 1
		for i = 1, 10 do
			local tex = _G[tip:GetName().."Texture"..i]
			local texture = tex and tex:IsShown() and tex:GetTexture()
			if texture then
				if texture == essenceTextureID then
					local selected = (tip.gems[i-1] ~= essenceTextureID and tip.gems[i-1]) or nil
					if not tip.essences[step] then tip.essences[step] = {} end
					tip.essences[step][1] = selected		--essence texture if selected or nil
					tip.essences[step][2] = tex:GetAtlas()	--atlas place 'tooltip-heartofazerothessence-major' or 'tooltip-heartofazerothessence-minor'
					tip.essences[step][3] = texture			--border texture placed by the atlas

					step = step + 1
					if selected then tip.gems[i-1] = nil end
				else
					tip.gems[i] = texture
				end
			end
		end

		return tip.gems, tip.essences
	end

	function M:InspectItemInfo(text, slotInfo)
		local itemLevel = strfind(text, itemLevelString) and strmatch(text, "(%d+)%)?$")
		if itemLevel then
			slotInfo.iLvl = tonumber(itemLevel)
		end

		local enchant = strmatch(text, enchantString)
		if enchant then
			slotInfo.enchantText = enchant
		end
	end

	function M:CollectEssenceInfo(index, lineText, slotInfo)
		local step = 1
		local essence = slotInfo.essences[step]
		if essence and next(essence) and (strfind(lineText, ITEM_SPELL_TRIGGER_ONEQUIP, nil, true) and strfind(lineText, essenceDescription, nil, true)) then
			for i = 5, 2, -1 do
				local line = _G[tip:GetName().."TextLeft"..index-i]
				local text = line and line:GetText()

				if text and (not strmatch(text, "^[ +]")) and essence and next(essence) then
					local r, g, b = line:GetTextColor()
					essence[4] = r
					essence[5] = g
					essence[6] = b

					step = step + 1
					essence = slotInfo.essences[step]
				end
			end
		end
	end

	function M.GetItemLevel(link, arg1, arg2, fullScan)
		if fullScan then
			tip:SetOwner(UIParent, "ANCHOR_NONE")
			tip:SetInventoryItem(arg1, arg2)

			if not tip.slotInfo then tip.slotInfo = {} else wipe(tip.slotInfo) end

			local slotInfo = tip.slotInfo
			slotInfo.gems, slotInfo.essences = M:InspectItemTextures()

			for i = 1, tip:NumLines() do
				local line = _G[tip:GetName().."TextLeft"..i]
				if not line then break end

				local text = line:GetText()
				if text then
					if i == 1 and text == RETRIEVING_ITEM_INFO then
						return "tooSoon"
					else
						M:InspectItemInfo(text, slotInfo)
						M:CollectEssenceInfo(i, text, slotInfo)
					end
				end
			end

			return slotInfo
		else
			if iLvlDB[link] then return iLvlDB[link] end

			tip:SetOwner(UIParent, "ANCHOR_NONE")
			if arg1 and type(arg1) == "string" then
				tip:SetInventoryItem(arg1, arg2)
			elseif arg1 and type(arg1) == "number" then
				tip:SetBagItem(arg1, arg2)
			else
				tip:SetHyperlink(link)
			end

			local firstLine = _G.UI_ScanTooltipTextLeft1:GetText()
			if firstLine == RETRIEVING_ITEM_INFO then
				return "tooSoon"
			end

			for i = 2, 5 do
				local line = _G[tip:GetName().."TextLeft"..i]
				if not line then break end

				local text = line:GetText()
				local found = text and strfind(text, itemLevelString)
				if found then
					local level = strmatch(text, "(%d+)%)?$")
					iLvlDB[link] = tonumber(level)
					break
				end
			end

			return iLvlDB[link]
		end
	end
end

-- Kill regions
do
	function M:Dummy()
		return
	end

	M.HiddenFrame = CreateFrame("Frame")
	M.HiddenFrame:Hide()

	function M:HideObject()
		if self.UnregisterAllEvents then
			self:UnregisterAllEvents()
			self:SetParent(M.HiddenFrame)
		else
			self.Show = self.Hide
		end
		self:Hide()
	end

	function M:HideOption()
		self:SetAlpha(0)
		self:SetScale(.0001)
	end

	local blizzTextures = {
		"Inset",
		"inset",
		"InsetFrame",
		"LeftInset",
		"RightInset",
		"NineSlice",
		"BG",
		"border",
		"Border",
		"Background",
		"BorderFrame",
		"bottomInset",
		"BottomInset",
		"bgLeft",
		"bgRight",
		"FilligreeOverlay",
		"PortraitOverlay",
		"ArtOverlayFrame",
		"Portrait",
		"portrait",
		"ScrollFrameBorder",
		"ScrollUpBorder",
		"ScrollDownBorder",
	}
	function M:StripTextures(kill)
		local frameName = self.GetName and self:GetName()
		for _, texture in pairs(blizzTextures) do
			local blizzFrame = self[texture] or (frameName and _G[frameName..texture])
			if blizzFrame then
				M.StripTextures(blizzFrame, kill)
			end
		end

		if self.GetNumRegions then
			for i = 1, self:GetNumRegions() do
				local region = select(i, self:GetRegions())
				if region and region.IsObjectType and region:IsObjectType("Texture") then
					if kill and type(kill) == "boolean" then
						M.HideObject(region)
					elseif tonumber(kill) then
						if kill == 0 then
							region:SetAlpha(0)
						elseif i ~= kill then
							region:SetTexture("")
							region:SetAtlas("")
						end
					else
						region:SetTexture("")
						region:SetAtlas("")
					end
				end
			end
		end
	end
end

-- UI widgets
do
	-- HelpTip
	function M.HelpInfoAcknowledge(callbackArg)
		MaoRUIDB["Help"][callbackArg] = true
	end

	-- Dropdown menu
	M.EasyMenu = CreateFrame("Frame", "UI_EasyMenu", UIParent, "UIDropDownMenuTemplate")

	-- Fontstring
	function M:CreateFS(size, text, color, anchor, x, y, r, g, b)
		local fs = self:CreateFontString(nil, "OVERLAY")
		fs:SetFont(I.Font[1], size, I.Font[3])
		fs:SetText(text)
		fs:SetWordWrap(false)
		if color and type(color) == "boolean" then
			fs:SetTextColor(cr, cg, cb)
		elseif color == "system" then
			fs:SetTextColor(1, .8, 0)
		elseif color == "Chatbar" then
		        fs:SetTextColor(r, g, b)
		end
		if anchor and x and y then
			fs:SetPoint(anchor, x, y)
		else
			fs:SetPoint("CENTER", 1, 0)
		end

		return fs
	end

	-- Gametooltip
	function M:HideTooltip()
		GameTooltip:Hide()
	end
	local function Tooltip_OnEnter(self)
		GameTooltip:SetOwner(self, self.anchor)
		GameTooltip:ClearLines()
		if self.title then
			GameTooltip:AddLine(self.title)
		end
		if tonumber(self.text) then
			GameTooltip:SetSpellByID(self.text)
		elseif self.text then
			local r, g, b = 1, 1, 1
			if self.color == "class" then
				r, g, b = cr, cg, cb
			elseif self.color == "system" then
				r, g, b = 1, .8, 0
			elseif self.color == "info" then
				r, g, b = .6, .8, 1
			end
			GameTooltip:AddLine(self.text, r, g, b, 1)
		end
		GameTooltip:Show()
	end
	function M:AddTooltip(anchor, text, color, showTips)
		self.anchor = anchor
		self.text = text
		self.color = color
		if showTips then self.title = U["Tips"] end
		self:SetScript("OnEnter", Tooltip_OnEnter)
		self:SetScript("OnLeave", M.HideTooltip)
	end

	-- Glow parent
	function M:CreateGlowFrame(size)
		local frame = CreateFrame("Frame", nil, self)
		frame:SetPoint("CENTER")
		frame:SetSize(size+8, size+8)

		return frame
	end

	-- Gradient texture
	local orientationAbbr = {
		["V"] = "Vertical",
		["H"] = "Horizontal",
	}
	function M:SetGradient(orientation, r, g, b, a1, a2, width, height)
		orientation = orientationAbbr[orientation]
		if not orientation then return end

		local tex = self:CreateTexture(nil, "BACKGROUND")
		tex:SetTexture(I.bdTex)
		tex:SetGradientAlpha(orientation, r, g, b, a1, r, g, b, a2)
		if width then tex:SetWidth(width) end
		if height then tex:SetHeight(height) end

		return tex
	end

	-- Background texture
	function M:CreateTex()
		if not R.db["Skins"]["BgTex"] then return end
		if self.__bgTex then return end

		local frame = self
		if self:IsObjectType("Texture") then frame = self:GetParent() end

		local tex = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
		tex:SetAllPoints(self)
		tex:SetTexture(I.bgTex, true, true)
		tex:SetHorizTile(true)
		tex:SetVertTile(true)
		tex:SetBlendMode("ADD")

		self.__bgTex = tex
	end

	-- Backdrop shadow
	local shadowBackdrop = {edgeFile = I.glowTex}

	function M:CreateSD(size, override)
		if not override and not R.db["Skins"]["Shadow"] then return end
		if self.__shadow then return end

		local frame = self
		if self:IsObjectType("Texture") then frame = self:GetParent() end

		shadowBackdrop.edgeSize = size or 5
		self.__shadow = CreateFrame("Frame", nil, frame, "BackdropTemplate")
		self.__shadow:SetOutside(self, size or 4, size or 4)
		self.__shadow:SetBackdrop(shadowBackdrop)
		self.__shadow:SetBackdropBorderColor(0, 0, 0, size and 1 or .4)
		self.__shadow:SetFrameLevel(1)

		return self.__shadow
	end
end

-- UI skins
do
	-- Setup backdrop
	R.frames = {}
	local defaultBackdrop = {bgFile = I.bdTex, edgeFile = I.bdTex}

	function M:SetBorderColor()
		if R.db["Skins"]["GreyBD"] then
			self:SetBackdropBorderColor(1, 1, 1, .2)
		else
			self:SetBackdropBorderColor(0, 0, 0)
		end
	end

	function M:CreateBD(a)
		defaultBackdrop.edgeSize = R.mult
		self:SetBackdrop(defaultBackdrop)
		self:SetBackdropColor(0, 0, 0, a or R.db["Skins"]["SkinAlpha"])
		M.SetBorderColor(self)
		if not a then tinsert(R.frames, self) end
	end

	function M:CreateGradient()
		local tex = self:CreateTexture(nil, "BORDER")
		tex:SetInside()
		tex:SetTexture(I.bdTex)
		if R.db["Skins"]["FlatMode"] then
			tex:SetVertexColor(.3, .3, .3, .25)
		else
			tex:SetGradientAlpha("Vertical", 0, 0, 0, .5, .3, .3, .3, .3)
		end

		return tex
	end

	-- Handle frame
	function M:CreateBDFrame(a, gradient)
		local frame = self
		if self:IsObjectType("Texture") then frame = self:GetParent() end
		local lvl = frame:GetFrameLevel()

		local bg = CreateFrame("Frame", nil, frame, "BackdropTemplate")
		bg:SetOutside(self)
		bg:SetFrameLevel(lvl == 0 and 0 or lvl - 1)
		M.CreateBD(bg, a)
		if gradient then
			self.__gradient = M.CreateGradient(bg)
		end

		return bg
	end

	function M:SetBD(a, x, y, x2, y2)
		local bg = M.CreateBDFrame(self, a)
		if x then
			bg:SetPoint("TOPLEFT", self, x, y)
			bg:SetPoint("BOTTOMRIGHT", self, x2, y2)
		end
		M.CreateSD(bg)
		M.CreateTex(bg)

		return bg
	end

	-- Handle icons
	function M:ReskinIcon(shadow)
		self:SetTexCoord(unpack(I.TexCoord))
		local bg = M.CreateBDFrame(self, .25) -- exclude from opacity control
		if shadow then M.CreateSD(bg) end
		return bg
	end

	function M:PixelIcon(texture, highlight)
		self.bg = M.CreateBDFrame(self)
		self.bg:SetAllPoints()
		self.Icon = self:CreateTexture(nil, "ARTWORK")
		self.Icon:SetInside()
		self.Icon:SetTexCoord(unpack(I.TexCoord))
		if texture then
			local atlas = strmatch(texture, "Atlas:(.+)$")
			if atlas then
				self.Icon:SetAtlas(atlas)
			else
				self.Icon:SetTexture(texture)
			end
		end
		if highlight and type(highlight) == "boolean" then
			self:EnableMouse(true)
			self.HL = self:CreateTexture(nil, "HIGHLIGHT")
			self.HL:SetColorTexture(1, 1, 1, .25)
			self.HL:SetInside()
		end
	end

	function M:AuraIcon(highlight)
		self.CD = CreateFrame("Cooldown", nil, self, "CooldownFrameTemplate")
		self.CD:SetInside()
		self.CD:SetReverse(true)
		M.PixelIcon(self, nil, highlight)
		M.CreateSD(self)
	end

	function M:CreateGear(name)
		local bu = CreateFrame("Button", name, self)
		bu:SetSize(24, 24)
		bu.Icon = bu:CreateTexture(nil, "ARTWORK")
		bu.Icon:SetAllPoints()
		bu.Icon:SetTexture(I.gearTex)
		bu.Icon:SetTexCoord(0, .5, 0, .5)
		bu.Icon:SetVertexColor(1, 0, 0, 1)
		bu:SetHighlightTexture(I.gearTex)
		bu:GetHighlightTexture():SetTexCoord(0, .5, 0, .5)

		return bu
	end

	function M:CreateHelpInfo(tooltip)
		local bu = CreateFrame("Button", nil, self)
		bu:SetSize(40, 40)
		bu.Icon = bu:CreateTexture(nil, "ARTWORK")
		bu.Icon:SetAllPoints()
		bu.Icon:SetTexture(616343)
		bu:SetHighlightTexture(616343)
		if tooltip then
			M.AddTooltip(bu, "ANCHOR_BOTTOMLEFT", tooltip, "info", true)
		end

		return bu
	end

	function M:CreateWatermark()
		local logo = self:CreateTexture(nil, "BACKGROUND")
		logo:SetPoint("BOTTOMRIGHT", 10, 0)
		logo:SetTexture(I.logoTex)
		logo:SetTexCoord(0, 1, 0, .75)
		logo:SetSize(200, 75)
		logo:SetAlpha(.3)
	end

	local AtlasToQuality = {
		["error"] = 99,
		["uncollected"] = LE_ITEM_QUALITY_POOR,
		["gray"] = LE_ITEM_QUALITY_POOR,
		["white"] = LE_ITEM_QUALITY_COMMON,
		["green"] = LE_ITEM_QUALITY_UNCOMMON,
		["blue"] = LE_ITEM_QUALITY_RARE,
		["purple"] = LE_ITEM_QUALITY_EPIC,
		["orange"] = LE_ITEM_QUALITY_LEGENDARY,
		["artifact"] = LE_ITEM_QUALITY_ARTIFACT,
		["account"] = LE_ITEM_QUALITY_HEIRLOOM,
	}
	local function updateIconBorderColorByAtlas(self, atlas)
		local atlasAbbr = atlas and strmatch(atlas, "%-(%w+)$")
		local quality = atlasAbbr and AtlasToQuality[atlasAbbr]
		local color = I.QualityColors[quality or 1]
		self.__owner.bg:SetBackdropBorderColor(color.r, color.g, color.b)
	end
	local function updateIconBorderColor(self, r, g, b)
		if not r or (r==.65882 and g==.65882 and b==.65882) or (r>.99 and g>.99 and b>.99) then
			r, g, b = 0, 0, 0
		end
		self.__owner.bg:SetBackdropBorderColor(r, g, b)
	end
	local function resetIconBorderColor(self, texture)
		if not texture then
			self.__owner.bg:SetBackdropBorderColor(0, 0, 0)
		end
	end
	function M:ReskinIconBorder(needInit, useAtlas)
		self:SetAlpha(0)
		self.__owner = self:GetParent()
		if not self.__owner.bg then return end
		if useAtlas or self.__owner.useCircularIconBorder then -- for auction item display
			hooksecurefunc(self, "SetAtlas", updateIconBorderColorByAtlas)
			hooksecurefunc(self, "SetTexture", resetIconBorderColor)
			if needInit then
				self:SetAtlas(self:GetAtlas()) -- for border with color before hook
			end
		else
			hooksecurefunc(self, "SetVertexColor", updateIconBorderColor)
			if needInit then
				self:SetVertexColor(self:GetVertexColor()) -- for border with color before hook
			end
		end
		hooksecurefunc(self, "Hide", resetIconBorderColor)
	end

	local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS
	function M:ClassIconTexCoord(class)
		local tcoords = CLASS_ICON_TCOORDS[class]
		self:SetTexCoord(tcoords[1] + .022, tcoords[2] - .025, tcoords[3] + .022, tcoords[4] - .025)
	end

	-- Handle statusbar
	function M:CreateSB(spark, r, g, b)
		self:SetStatusBarTexture(I.normTex)
		if r and g and b then
			self:SetStatusBarColor(r, g, b)
		else
			self:SetStatusBarColor(cr, cg, cb)
		end

		local bg = M.SetBD(self)
		self.__shadow = bg.__shadow

		if spark then
			self.Spark = self:CreateTexture(nil, "OVERLAY")
			self.Spark:SetTexture(I.sparkTex)
			self.Spark:SetBlendMode("ADD")
			self.Spark:SetAlpha(.8)
			self.Spark:SetPoint("TOPLEFT", self:GetStatusBarTexture(), "TOPRIGHT", -10, 10)
			self.Spark:SetPoint("BOTTOMRIGHT", self:GetStatusBarTexture(), "BOTTOMRIGHT", 10, -10)
		end
	end

	function M:CreateAndUpdateBarTicks(bar, ticks, numTicks)
		for i = 1, #ticks do
			ticks[i]:Hide()
		end

		if numTicks and numTicks > 0 then
			local width, height = bar:GetSize()
			local delta = width / numTicks
			for i = 1, numTicks-1 do
				if not ticks[i] then
					ticks[i] = bar:CreateTexture(nil, "OVERLAY")
					ticks[i]:SetTexture(I.normTex)
					ticks[i]:SetVertexColor(0, 0, 0, .7)
					ticks[i]:SetWidth(R.mult)
					ticks[i]:SetHeight(height)
				end
				ticks[i]:ClearAllPoints()
				ticks[i]:SetPoint("RIGHT", bar, "LEFT", delta * i, 0 )
				ticks[i]:Show()
			end
		end
	end

	-- Handle button
	local function Button_OnEnter(self)
		if not self:IsEnabled() then return end

		if R.db["Skins"]["FlatMode"] then
			self.__gradient:SetVertexColor(cr / 4, cg / 4, cb / 4)
		else
			self.__bg:SetBackdropColor(cr, cg, cb, .25)
		end
		self.__bg:SetBackdropBorderColor(cr, cg, cb)
	end
	local function Button_OnLeave(self)
		if R.db["Skins"]["FlatMode"] then
			self.__gradient:SetVertexColor(.3, .3, .3, .25)
		else
			self.__bg:SetBackdropColor(0, 0, 0, 0)
		end
		M.SetBorderColor(self.__bg)
	end

	local blizzRegions = {
		"Left",
		"Middle",
		"Right",
		"Mid",
		"LeftDisabled",
		"MiddleDisabled",
		"RightDisabled",
		"TopLeft",
		"TopRight",
		"BottomLeft",
		"BottomRight",
		"TopMiddle",
		"MiddleLeft",
		"MiddleRight",
		"BottomMiddle",
		"MiddleMiddle",
		"TabSpacer",
		"TabSpacer1",
		"TabSpacer2",
		"_RightSeparator",
		"_LeftSeparator",
		"Cover",
		"Border",
		"Background",
		"TopTex",
		"TopLeftTex",
		"TopRightTex",
		"LeftTex",
		"BottomTex",
		"BottomLeftTex",
		"BottomRightTex",
		"RightTex",
		"MiddleTex",
		"Center",
	}
	function M:Reskin(noHighlight, override)
		if self.SetNormalTexture and not override then self:SetNormalTexture("") end
		if self.SetHighlightTexture then self:SetHighlightTexture("") end
		if self.SetPushedTexture then self:SetPushedTexture("") end
		if self.SetDisabledTexture then self:SetDisabledTexture("") end

		local buttonName = self.GetName and self:GetName()
		for _, region in pairs(blizzRegions) do
			region = buttonName and _G[buttonName..region] or self[region]
			if region then
				region:SetAlpha(0)
				region:Hide()
			end
		end

		self.__bg = M.CreateBDFrame(self, 0, true)
		self.__bg:SetFrameLevel(self:GetFrameLevel())
		self.__bg:SetAllPoints()

		if not noHighlight then
			self:HookScript("OnEnter", Button_OnEnter)
			self:HookScript("OnLeave", Button_OnLeave)
		end
	end

	local function Menu_OnEnter(self)
		self.bg:SetBackdropBorderColor(cr, cg, cb)
	end
	local function Menu_OnLeave(self)
		M.SetBorderColor(self.bg)
	end
	local function Menu_OnMouseUp(self)
		self.bg:SetBackdropColor(0, 0, 0, R.db["Skins"]["SkinAlpha"])
	end
	local function Menu_OnMouseDown(self)
		self.bg:SetBackdropColor(cr, cg, cb, .25)
	end

	function M:ResetTabAnchor()
		local text = self.Text or (self.GetName and _G[self:GetName().."Text"])
		if text then
			text:SetPoint("CENTER", self)
		end
	end
	hooksecurefunc("PanelTemplates_SelectTab", M.ResetTabAnchor)
	hooksecurefunc("PanelTemplates_DeselectTab", M.ResetTabAnchor)

	-- Handle scrollframe
	local function GrabScrollBarElement(frame, element)
		local frameName = frame:GetDebugName()
		return frame[element] or frameName and (_G[frameName..element] or strfind(frameName, element)) or nil
	end

	function M:ReskinScroll()
		M.StripTextures(self:GetParent())
		M.StripTextures(self)

		local thumb = GrabScrollBarElement(self, "ThumbTexture") or GrabScrollBarElement(self, "thumbTexture") or self.GetThumbTexture and self:GetThumbTexture()
		if thumb then
			thumb:SetAlpha(0)
			thumb:SetWidth(16)
			local bg = M.CreateBDFrame(self, 0, true)
			bg:SetPoint("TOPLEFT", thumb, 0, -2)
			bg:SetPoint("BOTTOMRIGHT", thumb, 0, 4)
			bg:SetBackdropColor(cr, cg, cb, .75)
		end

		local up, down = self:GetChildren()
		M.ReskinArrow(up, "up")
		M.ReskinArrow(down, "down")
	end

	-- Handle close button
	function M:Texture_OnEnter()
		if self:IsEnabled() then
			if self.bg then
				self.bg:SetBackdropColor(cr, cg, cb, .25)
			else
				self.__texture:SetVertexColor(cr, cg, cb)
			end
		end
	end

	function M:Texture_OnLeave()
		if self.bg then
			self.bg:SetBackdropColor(0, 0, 0, .25)
		else
			self.__texture:SetVertexColor(1, 1, 1)
		end
	end
	-- Handle editbox
	function M:ReskinEditBox(height, width)
		local frameName = self.GetName and self:GetName()
		for _, region in pairs(blizzRegions) do
			region = frameName and _G[frameName..region] or self[region]
			if region then
				region:SetAlpha(0)
			end
		end

		local bg = M.CreateBDFrame(self, 0, true)
		bg:SetPoint("TOPLEFT", -2, 0)
		bg:SetPoint("BOTTOMRIGHT")

		if height then self:SetHeight(height) end
		if width then self:SetWidth(width) end
	end
	M.ReskinInput = M.ReskinEditBox -- Deprecated

	-- Handle arrows
	local arrowDegree = {
		["up"] = 0,
		["down"] = 180,
		["left"] = 90,
		["right"] = -90,
	}
	function M:SetupArrow(direction)
		self:SetTexture(I.ArrowUp)
		self:SetRotation(rad(arrowDegree[direction]))
	end

	function M:ReskinArrow(direction)
		self:SetSize(16, 16)
		--M.Reskin(self, true)

		self:SetDisabledTexture(I.bdTex)
		local dis = self:GetDisabledTexture()
		dis:SetVertexColor(0, 0, 0, .3)
		dis:SetDrawLayer("OVERLAY")
		dis:SetAllPoints()

		local tex = self:CreateTexture(nil, "ARTWORK")
		tex:SetAllPoints()
		M.SetupArrow(tex, direction)
		tex:SetVertexColor(1, 0, 0, 1)
		self.__texture = tex

		self:HookScript("OnEnter", M.Texture_OnEnter)
		self:HookScript("OnLeave", M.Texture_OnLeave)
	end

	function M:ReskinFilterButton()
		M.StripTextures(self)
		M.Reskin(self)
		if self.Text then
			self.Text:SetPoint("CENTER")
		end
		if self.Icon then
			M.SetupArrow(self.Icon, "right")
			self.Icon:SetPoint("RIGHT")
			self.Icon:SetSize(14, 14)
		end
	end

	function M:ReskinNavBar()
		if self.navBarStyled then return end

		local homeButton = self.homeButton
		local overflowButton = self.overflowButton

		self:GetRegions():Hide()
		self:DisableDrawLayer("BORDER")
		self.overlay:Hide()
		homeButton:GetRegions():Hide()
		M.Reskin(homeButton)
		M.Reskin(overflowButton, true)

		local tex = overflowButton:CreateTexture(nil, "ARTWORK")
		M.SetupArrow(tex, "left")
		tex:SetSize(14, 14)
		tex:SetPoint("CENTER")
		overflowButton.__texture = tex

		overflowButton:HookScript("OnEnter", M.Texture_OnEnter)
		overflowButton:HookScript("OnLeave", M.Texture_OnLeave)

		self.navBarStyled = true
	end
	-- Handle slider
	function M:ReskinSlider(vertical)
		self:SetBackdrop(nil)
		M.StripTextures(self)

		local bg = M.CreateBDFrame(self, 0, true)
		bg:SetPoint("TOPLEFT", 14, -2)
		bg:SetPoint("BOTTOMRIGHT", -15, 3)

		local thumb = self:GetThumbTexture()
		thumb:SetTexture(I.sparkTex)
		thumb:SetBlendMode("ADD")
		if vertical then thumb:SetRotation(rad(90)) end
	end
	local buttonNames = {"MaximizeButton", "MinimizeButton"}
	function M:ReskinMinMax()
		for _, name in next, buttonNames do
			local button = self[name]
			if button then
				button:SetSize(16, 16)
				button:ClearAllPoints()
				button:SetPoint("CENTER", -3, 0)
				M.Reskin(button)

				local tex = button:CreateTexture()
				tex:SetAllPoints()
				if name == "MaximizeButton" then
					M.SetupArrow(tex, "up")
				else
					M.SetupArrow(tex, "down")
				end
				button.__texture = tex

				button:SetScript("OnEnter", M.Texture_OnEnter)
				button:SetScript("OnLeave", M.Texture_OnLeave)
			end
		end
	end

	-- UI templates
	function M:ReskinPortraitFrame()
		M.StripTextures(self)
		local bg = M.SetBD(self)
		bg:SetAllPoints(self)
		local frameName = self.GetName and self:GetName()
		local portrait = self.PortraitTexture or self.portrait or (frameName and _G[frameName.."Portrait"])
		if portrait then
			portrait:SetAlpha(0)
		end
		local closeButton = self.CloseButton or (frameName and _G[frameName.."CloseButton"])
		--if closeButton then
			--M.ReskinClose(closeButton)
		--end
		return bg
	end
end

	function M:AffixesSetup()
		for _, frame in ipairs(self.Affixes) do
			frame.Border:SetTexture(nil)
			frame.Portrait:SetTexture(nil)
			if not frame.bg then
				frame.bg = M.ReskinIcon(frame.Portrait)
			end

			if frame.info then
				frame.Portrait:SetTexture(CHALLENGE_MODE_EXTRA_AFFIX_INFO[frame.info.key].texture)
			elseif frame.affixID then
				local _, _, filedataid = C_ChallengeMode.GetAffixInfo(frame.affixID)
				frame.Portrait:SetTexture(filedataid)
			end
		end
	end

	-- Role Icons
	function M:GetRoleTexCoord()
		if self == "TANK" then
			return .34/9.03, 2.85/9.03, 3.16/9.03, 5.67/9.03
		elseif self == "DPS" or self == "DAMAGER" then
			return 3.27/9.03, 5.78/9.03, 3.16/9.03, 5.67/9.03
		elseif self == "HEALER" then
			return 3.27/9.03, 5.78/9.03, .27/9.03, 2.78/9.03
		elseif self == "LEADER" then
			return .34/9.03, 2.85/9.03, .27/9.03, 2.78/9.03
		elseif self == "READY" then
			return 6.17/9.03, 8.68/9.03, .27/9.03, 2.78/9.03
		elseif self == "PENDING" then
			return 6.17/9.03, 8.68/9.03, 3.16/9.03, 5.67/9.03
		elseif self == "REFUSE" then
			return 3.27/9.03, 5.78/9.03, 6.04/9.03, 8.55/9.03
		end
	end

	function M:GetRoleTex()
		if self == "TANK" then
			return I.tankTex
		elseif self == "DPS" or self == "DAMAGER" then
			return I.dpsTex
		elseif self == "HEALER" then
			return I.healTex
		end
	end

	function M:ReskinSmallRole(role)
		self:SetTexture(M.GetRoleTex(role))
		self:SetTexCoord(0, 1, 0, 1)
	end

	function M:ReskinRole(role)
		if self.background then self.background:SetTexture("") end
		local cover = self.cover or self.Cover
		if cover then cover:SetTexture("") end
		local texture = self.GetNormalTexture and self:GetNormalTexture() or self.texture or self.Texture or (self.SetTexture and self) or self.Icon
		if texture then
			texture:SetTexture(I.rolesTex)
			texture:SetTexCoord(M.GetRoleTexCoord(role))
		end
		self.bg = M.CreateBDFrame(self)

		local checkButton = self.checkButton or self.CheckButton or self.CheckBox
		if checkButton then
			checkButton:SetFrameLevel(self:GetFrameLevel() + 2)
			checkButton:SetPoint("BOTTOMLEFT", -2, -2)
			M.ReskinCheck(checkButton)
		end

		local shortageBorder = self.shortageBorder
		if shortageBorder then
			shortageBorder:SetTexture("")
			local icon = self.incentiveIcon
			icon:SetPoint("BOTTOMRIGHT")
			icon:SetSize(14, 14)
			icon.texture:SetSize(14, 14)
			M.ReskinIcon(icon.texture)
			icon.border:SetTexture("")
		end
	end

-- GUI elements
do
	function M:CreateButton(width, height, text, fontSize)
		local bu = CreateFrame("Button", nil, self, "BackdropTemplate")
		bu:SetSize(width, height)
		if type(text) == "boolean" then
			M.PixelIcon(bu, fontSize, true)
		else
			M.Reskin(bu)
			bu.text = M.CreateFS(bu, fontSize or 14, text, true)
		end

		return bu
	end

	function M:CreateCheckBox()
		local cb = CreateFrame("CheckButton", nil, self, "InterfaceOptionsCheckButtonTemplate")
		cb:SetScript("OnClick", nil) -- reset onclick handler
		--M.ReskinCheck(cb)

		cb.Type = "CheckBox"
		return cb
	end

	local function editBoxClearFocus(self)
		self:ClearFocus()
	end

	function M:CreateEditBox(width, height)
		local eb = CreateFrame("EditBox", nil, self)
		eb:SetSize(width, height)
		eb:SetAutoFocus(false)
		eb:SetTextInsets(5, 5, 0, 0)
		eb:SetFont(I.Font[1], I.Font[2]+2, I.Font[3])
		eb.bg = M.CreateBDFrame(eb, .25, true)
		eb.bg:SetAllPoints()
		eb:SetScript("OnEscapePressed", editBoxClearFocus)
		eb:SetScript("OnEnterPressed", editBoxClearFocus)

		eb.Type = "EditBox"
		return eb
	end

	local function optOnClick(self)
		PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
		local opt = self.__owner.options
		for i = 1, #opt do
			if self == opt[i] then
				opt[i]:SetBackdropColor(1, .8, 0, .3)
				opt[i].selected = true
			else
				opt[i]:SetBackdropColor(0, 0, 0, .3)
				opt[i].selected = false
			end
		end
		self.__owner.Text:SetText(self.text)
		self:GetParent():Hide()
	end

	local function optOnEnter(self)
		if self.selected then return end
		self:SetBackdropColor(1, 1, 1, .25)
	end

	local function optOnLeave(self)
		if self.selected then return end
		self:SetBackdropColor(0, 0, 0)
	end

	local function buttonOnShow(self)
		self.__list:Hide()
	end

	local function buttonOnClick(self)
		PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK)
		M:TogglePanel(self.__list)
	end

	function M:CreateDropDown(width, height, data)
		local dd = CreateFrame("Frame", nil, self, "BackdropTemplate")
		dd:SetSize(width, height)
		M.CreateBD(dd)
		dd:SetBackdropBorderColor(1, 1, 1, .2)
		dd.Text = M.CreateFS(dd, 14, "", false, "LEFT", 5, 0)
		dd.Text:SetPoint("RIGHT", -5, 0)
		dd.options = {}

		local bu = CreateFrame("Button", nil, dd)
		bu:SetPoint("RIGHT", 12, 5)
		M.ReskinArrow(bu, "down")
		bu:SetSize(26, 26)
		local list = CreateFrame("Frame", nil, dd, "BackdropTemplate")
		list:SetPoint("TOP", dd, "BOTTOM", 0, -2)
		RaiseFrameLevel(list)
		M.CreateBD(list, 0.85)
		list:SetBackdropBorderColor(1, 1, 1, .85)
		list:Hide()
		bu.__list = list
		bu:SetScript("OnShow", buttonOnShow)
		bu:SetScript("OnClick", buttonOnClick)
		dd.button = bu

		local opt, index = {}, 0
		for i, j in pairs(data) do
			opt[i] = CreateFrame("Button", nil, list, "BackdropTemplate")
			opt[i]:SetPoint("TOPLEFT", 4, -4 - (i-1)*(height+2))
			opt[i]:SetSize(width - 8, height)
			M.CreateBD(opt[i])
			local text = M.CreateFS(opt[i], 14, j, false, "LEFT", 5, 0)
			text:SetPoint("RIGHT", -5, 0)
			opt[i].text = j
			opt[i].index = i
			opt[i].__owner = dd
			opt[i]:SetScript("OnClick", optOnClick)
			opt[i]:SetScript("OnEnter", optOnEnter)
			opt[i]:SetScript("OnLeave", optOnLeave)

			dd.options[i] = opt[i]
			index = index + 1
		end
		list:SetSize(width, index*(height+2) + 6)

		dd.Type = "DropDown"
		return dd
	end

	local function updatePicker()
		local swatch = ColorPickerFrame.__swatch
		local r, g, b = ColorPickerFrame:GetColorRGB()
		r = M:Round(r, 2)
		g = M:Round(g, 2)
		b = M:Round(b, 2)
		swatch.tex:SetVertexColor(r, g, b)
		swatch.color.r, swatch.color.g, swatch.color.b = r, g, b
	end

	local function cancelPicker()
		local swatch = ColorPickerFrame.__swatch
		local r, g, b = ColorPicker_GetPreviousValues()
		swatch.tex:SetVertexColor(r, g, b)
		swatch.color.r, swatch.color.g, swatch.color.b = r, g, b
	end

	local function openColorPicker(self)
		local r, g, b = self.color.r, self.color.g, self.color.b
		ColorPickerFrame.__swatch = self
		ColorPickerFrame.func = updatePicker
		ColorPickerFrame.previousValues = {r = r, g = g, b = b}
		ColorPickerFrame.cancelFunc = cancelPicker
		ColorPickerFrame:SetColorRGB(r, g, b)
		ColorPickerFrame:Show()
	end

	local function GetSwatchTexColor(tex)
		local r, g, b = tex:GetVertexColor()
		r = M:Round(r, 2)
		g = M:Round(g, 2)
		b = M:Round(b, 2)
		return r, g, b
	end

	local function resetColorPicker(swatch)
		local defaultColor = swatch.__default
		if defaultColor then
			ColorPickerFrame:SetColorRGB(defaultColor.r, defaultColor.g, defaultColor.b)
		end
	end

	local whiteColor = {r=1, g=1, b=1}
	function M:CreateColorSwatch(name, color)
		color = color or whiteColor

		local swatch = CreateFrame("Button", nil, self, "BackdropTemplate")
		swatch:SetSize(18, 18)
		M.CreateBD(swatch, 1)
		swatch.text = M.CreateFS(swatch, 14, name, false, "LEFT", 26, 0)
		local tex = swatch:CreateTexture()
		tex:SetInside()
		tex:SetTexture(I.bdTex)
		tex:SetVertexColor(color.r, color.g, color.b)
		tex.GetColor = GetSwatchTexColor

		swatch.tex = tex
		swatch.color = color
		swatch:SetScript("OnClick", openColorPicker)
		swatch:SetScript("OnDoubleClick", resetColorPicker)

		return swatch
	end

	local function updateSliderEditBox(self)
		local slider = self.__owner
		local minValue, maxValue = slider:GetMinMaxValues()
		local text = tonumber(self:GetText())
		if not text then return end
		text = min(maxValue, text)
		text = max(minValue, text)
		slider:SetValue(text)
		self:SetText(text)
		self:ClearFocus()
	end

	local function resetSliderValue(self)
		local slider = self.__owner
		if slider.__default then
			slider:SetValue(slider.__default)
		end
	end

	function M:CreateSlider(name, minValue, maxValue, step, x, y, width)
		local slider = CreateFrame("Slider", nil, self, "OptionsSliderTemplate")
		slider:SetPoint("TOPLEFT", x, y)
		slider:SetWidth(width or 200)
		slider:SetMinMaxValues(minValue, maxValue)
		slider:SetValueStep(step)
		slider:SetObeyStepOnDrag(true)
		slider:SetHitRectInsets(0, 0, 0, 0)
		M.ReskinSlider(slider)

		slider.Low:SetText(minValue)
		slider.Low:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 10, -2)
		slider.High:SetText(maxValue)
		slider.High:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", -10, -2)
		slider.Text:ClearAllPoints()
		slider.Text:SetPoint("CENTER", 0, 25)
		slider.Text:SetText(name)
		slider.Text:SetTextColor(1, .8, 0)
		slider.value = M.CreateEditBox(slider, 50, 20)
		slider.value:SetPoint("TOP", slider, "BOTTOM")
		slider.value:SetJustifyH("CENTER")
		slider.value.__owner = slider
		slider.value:SetScript("OnEnterPressed", updateSliderEditBox)

		slider.clicker = CreateFrame("Button", nil, slider)
		slider.clicker:SetAllPoints(slider.Text)
		slider.clicker.__owner = slider
		slider.clicker:SetScript("OnDoubleClick", resetSliderValue)

		return slider
	end

	function M:TogglePanel(frame)
		if frame:IsShown() then
			frame:Hide()
		else
			frame:Show()
		end
	end
end

-- Add API
do
	local function WatchPixelSnap(frame, snap)
		if (frame and not frame:IsForbidden()) and frame.PixelSnapDisabled and snap then
			frame.PixelSnapDisabled = nil
		end
	end

	local function DisablePixelSnap(frame)
		if (frame and not frame:IsForbidden()) and not frame.PixelSnapDisabled then
			if frame.SetSnapToPixelGrid then
				frame:SetSnapToPixelGrid(false)
				frame:SetTexelSnappingBias(0)
			elseif frame.GetStatusBarTexture then
				local texture = frame:GetStatusBarTexture()
				if texture and texture.SetSnapToPixelGrid then
					texture:SetSnapToPixelGrid(false)
					texture:SetTexelSnappingBias(0)
				end
			end

			frame.PixelSnapDisabled = true
		end
	end

	local function SetInside(frame, anchor, xOffset, yOffset, anchor2)
		xOffset = xOffset or R.mult
		yOffset = yOffset or R.mult
		anchor = anchor or frame:GetParent()

		DisablePixelSnap(frame)
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", anchor, "TOPLEFT", xOffset, -yOffset)
		frame:SetPoint("BOTTOMRIGHT", anchor2 or anchor, "BOTTOMRIGHT", -xOffset, yOffset)
	end

	local function SetOutside(frame, anchor, xOffset, yOffset, anchor2)
		xOffset = xOffset or R.mult
		yOffset = yOffset or R.mult
		anchor = anchor or frame:GetParent()

		DisablePixelSnap(frame)
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", anchor, "TOPLEFT", -xOffset, yOffset)
		frame:SetPoint("BOTTOMRIGHT", anchor2 or anchor, "BOTTOMRIGHT", xOffset, -yOffset)
	end

	local function HideBackdrop(frame)
		if frame.NineSlice then frame.NineSlice:SetAlpha(0) end
		if frame.SetBackdrop then frame:SetBackdrop(nil) end
	end

	local function addapi(object)
		local mt = getmetatable(object).__index
		if not object.SetInside then mt.SetInside = SetInside end
		if not object.SetOutside then mt.SetOutside = SetOutside end
		if not object.HideBackdrop then mt.HideBackdrop = HideBackdrop end
		if not object.DisabledPixelSnap then
			if mt.SetTexture then hooksecurefunc(mt, "SetTexture", DisablePixelSnap) end
			if mt.SetTexCoord then hooksecurefunc(mt, "SetTexCoord", DisablePixelSnap) end
			if mt.CreateTexture then hooksecurefunc(mt, "CreateTexture", DisablePixelSnap) end
			if mt.SetVertexColor then hooksecurefunc(mt, "SetVertexColor", DisablePixelSnap) end
			if mt.SetColorTexture then hooksecurefunc(mt, "SetColorTexture", DisablePixelSnap) end
			if mt.SetSnapToPixelGrid then hooksecurefunc(mt, "SetSnapToPixelGrid", WatchPixelSnap) end
			if mt.SetStatusBarTexture then hooksecurefunc(mt, "SetStatusBarTexture", DisablePixelSnap) end
			mt.DisabledPixelSnap = true
		end
	end

	local handled = {["Frame"] = true}
	local object = CreateFrame("Frame")
	addapi(object)
	addapi(object:CreateTexture())
	addapi(object:CreateMaskTexture())

	object = EnumerateFrames()
	while object do
		if not object:IsForbidden() and not handled[object:GetObjectType()] then
			addapi(object)
			handled[object:GetObjectType()] = true
		end

		object = EnumerateFrames(object)
	end
end

	-- Function --
function M:CreatStyleButton(id, parent, w, h, ap, frame, rp, x, y, l, alpha, bgF, r, g, b)
  local StyleButton = CreateFrame("Button", id, parent, "BackdropTemplate")
	StyleButton:SetWidth(w)
	StyleButton:SetHeight(h)
	StyleButton:SetPoint(ap, frame, rp, x, y)
	StyleButton:SetFrameStrata("HIGH")
	StyleButton:SetFrameLevel(l)
	StyleButton:SetAlpha(alpha)
	StyleButton:SetBackdrop({bgFile = bgF})
	StyleButton:SetBackdropColor(r, g, b)
	return StyleButton
end
function M:CreatStyleText(f, font, fontsize, fontmod, text, ap, frame, rp, x, y, r, g, b, k)
	local StyleText = f:CreateFontString(nil, "OVERLAY")
	StyleText:SetFont(font, fontsize, fontmod)
	StyleText:SetJustifyH("CENTER")
	StyleText:SetText(text)
	StyleText:SetPoint(ap, frame, rp, x, y)
	StyleText:SetTextColor(r, g, b, k or 1)
	return StyleText
end
-- Function end --