local _, addonTable = ...
local E, L, C = addonTable.E, addonTable.L, addonTable.C

-- Lua
local _G = getfenv(0)

-- Blizz
local C_MountJournal = _G.C_MountJournal
local C_PetJournal = _G.C_PetJournal
local C_ToyBox = _G.C_ToyBox

-- Mine
local function Toast_OnClick(self)
	local data = self._data

	if data and not InCombatLockdown() then
		if not CollectionsJournal then
			CollectionsJournal_LoadUI()
		end

		if CollectionsJournal then
			if data.is_mount then
				SetCollectionsJournalShown(true, COLLECTIONS_JOURNAL_TAB_INDEX_MOUNTS)
				MountJournal_SelectByMountID(data.collection_id)
			elseif data.is_pet then
				SetCollectionsJournalShown(true, COLLECTIONS_JOURNAL_TAB_INDEX_PETS)
				PetJournal_SelectPet(PetJournal, data.collection_id)
			elseif data.is_toy then
				SetCollectionsJournalShown(true, COLLECTIONS_JOURNAL_TAB_INDEX_TOYS)

				local page = ToyBox_FindPageForToyID(data.collection_id)
				if page then
					ToyBox.PagingFrame:SetCurrentPage(page)
				end
			end
		end
	end
end

local function PostSetAnimatedValue(self, value)
	self:SetText(value == 1 and "" or value)
end

local function Toast_SetUp(event, ID, isMount, isPet, isToy)
	local toast, isNew, isQueued = E:GetToast(event, "collection_id", ID)
	local color, name, icon, _

	if isNew then
		if isMount then
			name, _, icon = C_MountJournal.GetMountInfoByID(ID)
		elseif isPet then
			local customName, rarity
			_, _, _, _, rarity = C_PetJournal.GetPetStats(ID)
			_, customName, _, _, _, _, _, name, icon = C_PetJournal.GetPetInfoByPetID(ID)
			color = ITEM_QUALITY_COLORS[(rarity or 2) - 1]
			name = customName or name
		elseif isToy then
			_, name, icon = C_ToyBox.GetToyInfo(ID)
		end

		if not name then
			return toast:Recycle()
		end

		toast.IconText1.PostSetAnimatedValue = PostSetAnimatedValue

		if color and C.db.profile.colors.name then
			toast.Text:SetTextColor(color.r, color.g, color.b)
		end

		if color and C.db.profile.colors.border then
			toast.Border:SetVertexColor(color.r, color.g, color.b)
		end

		if color and C.db.profile.colors.icon_border then
			toast.IconBorder:SetVertexColor(color.r, color.g, color.b)
		end

		toast.Title:SetText(L["YOU_EARNED"])
		toast.Text:SetText(name)
		toast.BG:SetTexture("Interface\\AddOns\\_ShiGuang\\Media\\Modules\\IsToasts\\toast-bg-collection")
		toast.Icon:SetTexture(icon)
		toast.IconBorder:Show()
		toast.IconText1:SetAnimatedValue(1, true)

		toast._data = {
			collection_id = ID,
			count = 1,
			event = event,
			is_mount = isMount,
			is_pet = isPet,
			is_toy = isToy,
			sound_file = 31578, -- SOUNDKIT.UI_EPICLOOT_TOAST
		}

		if C.db.profile.types.collection.left_click then
			toast:HookScript("OnClick", Toast_OnClick)
		end

		toast:Spawn(C.db.profile.types.collection.dnd)
	else
		if isQueued then
			toast._data.count = toast._data.count + 1
			toast.IconText1:SetAnimatedValue(toast._data.count, true)
		else
			toast._data.count = toast._data.count + 1
			toast.IconText1:SetAnimatedValue(toast._data.count)

			toast.IconText2:SetText("+1")
			toast.IconText2.Blink:Stop()
			toast.IconText2.Blink:Play()

			toast.AnimOut:Stop()
			toast.AnimOut:Play()
		end
	end
end

local function NEW_MOUNT_ADDED(mountID)
	Toast_SetUp("NEW_MOUNT_ADDED", mountID, true)
end

local function NEW_PET_ADDED(petID)
	Toast_SetUp("NEW_PET_ADDED", petID, nil, true)
end

local function TOYS_UPDATED(toyID, isNew)
	if toyID and isNew then
		Toast_SetUp("TOYS_UPDATED", toyID, nil, nil, true)
	end
end

local function Enable()
	if C.db.profile.types.collection.enabled then
		E:RegisterEvent("NEW_MOUNT_ADDED", NEW_MOUNT_ADDED)
		E:RegisterEvent("NEW_PET_ADDED", NEW_PET_ADDED)
		E:RegisterEvent("TOYS_UPDATED", TOYS_UPDATED)
	end
end

local function Disable()
	E:UnregisterEvent("NEW_MOUNT_ADDED", NEW_MOUNT_ADDED)
	E:UnregisterEvent("NEW_PET_ADDED", NEW_PET_ADDED)
	E:UnregisterEvent("TOYS_UPDATED", TOYS_UPDATED)
end

local function Test()
	-- Golden Gryphon
	Toast_SetUp("MOUNT_TEST", 129, true)

	-- Pet
	local petID = C_PetJournal.GetPetInfoByIndex(1)

	if petID then
		Toast_SetUp("PET_TEST", petID, nil, true)
	end

	-- A Tiny Set of Warglaves
	Toast_SetUp("TOY_TEST", 147537, nil, nil, true)
end

E:RegisterOptions("collection", {
	left_click = false,
	enabled = true,
	dnd = false,
}, {
	name = L["TYPE_COLLECTION"],
	args = {
		desc = {
			order = 1,
			type = "description",
			name = L["TYPE_COLLECTION_DESC"],
		},
		enabled = {
			order = 2,
			type = "toggle",
			name = L["ENABLE"],
			get = function()
				return C.db.profile.types.collection.enabled
			end,
			set = function(_, value)
				C.db.profile.types.collection.enabled = value

				if value then
					Enable()
				else
					Disable()
				end
			end
		},
		dnd = {
			order = 3,
			type = "toggle",
			name = L["DND"],
			desc = L["DND_TOOLTIP"],
			get = function()
				return C.db.profile.types.collection.dnd
			end,
			set = function(_, value)
				C.db.profile.types.collection.dnd = value
			end
		},
		left_click = {
			order = 4,
			type = "toggle",
			name = L["HANDLE_LEFT_CLICK"],
			desc = L["COLLECTIONS_TAINT_WARNING"],
			image = "Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew",
			get = function()
				return C.db.profile.types.collection.left_click
			end,
			set = function(_, value)
				C.db.profile.types.collection.left_click = value
			end
		},
		test = {
			type = "execute",
			order = 99,
			width = "full",
			name = L["TEST"],
			func = Test,
		},
	},
})

E:RegisterSystem("collection", Enable, Disable, Test)
