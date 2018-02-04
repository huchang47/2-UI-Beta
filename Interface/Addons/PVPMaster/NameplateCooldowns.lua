﻿local locales = {
	["enUS"] = {
		["Always display CD icons at full opacity (ReloadUI is needed)"] = "Always display CD icons at full opacity (ReloadUI is needed)",
		["Click on icon to enable/disable tracking"] = "Click on icon to enable/disable tracking",
		Copy = "Copy",
		["Copy other profile to current profile:"] = "Copy other profile to current profile:",
		["Current profile: [%s]"] = "Current profile: [%s]",
		["Data from '%s' has been successfully copied to '%s'"] = "Data from '%s' has been successfully copied to '%s'",
		Delete = "Delete",
		["Delete profile:"] = "Delete profile:",
		["Disable test mode"] = "Disable test mode",
		["Enable test mode (need at least one visible nameplate)"] = "Enable test mode (need at least one visible nameplate)",
		General = "General",
		["Icon size"] = "Icon size",
		["Icon X-coord offset"] = "Icon X-coord offset",
		["Icon Y-coord offset"] = "Icon Y-coord offset",
		MISC = "Misc",
		["New spell has been added: %s"] = "New spell has been added: %s",
		["Options are not available in combat!"] = "Options are not available in combat!",
		Profiles = "Profiles",
		["Profile '%s' has been successfully deleted"] = "Profile '%s' has been successfully deleted",
		["Show border around interrupts"] = "Show border around interrupts",
		["Show border around trinkets"] = "Show border around trinkets",
		["Unknown spell: %s"] = "Unknown spell: %s",
		["Value must be a number"] = "Value must be a number",
		["Font:"] = "Font:",
	},
	
	["zhCN"] = {
		["Always display CD icons at full opacity (ReloadUI is needed)"] = "总是置顶显示CD图标(需要重载UI)", -- Requires localization
		["Click on icon to enable/disable tracking"] = "点击图标启用/禁用跟踪", -- Needs review
		Copy = "复制", -- Needs review
		["Copy other profile to current profile:"] = "复制其他配置文件至当前配置文件：", -- Needs review
		["Current profile: [%s]"] = "当前配置文件： [%s]", -- Needs review
		["Data from '%s' has been successfully copied to '%s'"] = "从' %s'的数据已被成功复制到“%s”", -- Needs review
		Delete = "删除", -- Needs review
		["Delete profile:"] = "删除配置文件", -- Needs review
		["Disable test mode"] = "关闭测试模式", -- Needs review
		["Enable test mode (need at least one visible nameplate)"] = "启用测试模式（至少需要一个可见的姓名板）", -- Needs review
		General = "综合", -- Needs review
		["Icon size"] = "图标大小", -- Needs review
		["Icon X-coord offset"] = "图标的X坐标偏移", -- Needs review
		["Icon Y-coord offset"] = "图标的y坐标偏移", -- Needs review
		MISC = "杂项", -- Needs review
		["New spell has been added: %s"] = "新的法术已添加", -- Needs review
		["Options are not available in combat!"] = "选项不可用在战斗！", -- Needs review
		Profiles = "配置", -- Needs review
		["Profile '%s' has been successfully deleted"] = "已删除配置文件", -- Needs review
		["Show border around interrupts"] = "打断技能显示边框", -- Requires localization
		["Show border around trinkets"] = "饰品使用显示边框", -- Requires localization
		["Unknown spell: %s"] = "未知的法术： %s", -- Needs review
		["Value must be a number"] = "值必须是数字", -- Needs review
		["Font:"] = "字体:",
	},
	["zhTW"] = {
		["Always display CD icons at full opacity (ReloadUI is needed)"] = "Always display CD icons at full opacity (ReloadUI is needed)", -- Requires localization
		["Click on icon to enable/disable tracking"] = "点击图标开启/关闭监视", -- Needs review
		Copy = "复制", -- Needs review
		["Copy other profile to current profile:"] = "将一个已保存的配置文件复制到当前配置文件:", -- Needs review
		["Current profile: [%s]"] = "当前配置文件: [%s]", -- Needs review
		["Data from '%s' has been successfully copied to '%s'"] = "已成功复制数据'%s'", -- Needs review
		Delete = "删除", -- Needs review
		["Delete profile:"] = "删除配置文件:", -- Needs review
		["Disable test mode"] = "关闭测试模式", -- Needs review
		["Enable test mode (need at least one visible nameplate)"] = "开启测试模式 （屏幕范围内要有至少一个姓名板）", -- Needs review
		General = "通用", -- Needs review
		["Icon size"] = "图标大小", -- Needs review
		["Icon X-coord offset"] = "X偏移量", -- Needs review
		["Icon Y-coord offset"] = "Y偏移量", -- Needs review
		MISC = "种族技能", -- Needs review
		["New spell has been added: %s"] = "已添加新的法术: %s", -- Needs review
		["Options are not available in combat!"] = "不能在战斗状态下进行设置！", -- Needs review
		Profiles = "配置文件", -- Needs review
		["Profile '%s' has been successfully deleted"] = "成功删除配置文件 '%s'", -- Needs review
		["Show border around interrupts"] = "Show border around interrupts", -- Requires localization
		["Show border around trinkets"] = "Show border around trinkets", -- Requires localization
		["Unknown spell: %s"] = "未知的法术: %s", -- Needs review
		["Value must be a number"] = "必须填写数字", -- Needs review
		["Font:"] = "字体:",
	},
};

local localizedClasses = {};
FillLocalizedClassList(localizedClasses);
for _, localeTable in pairs(locales) do
	for classToken, localizedClassName in pairs(localizedClasses) do
		localeTable[classToken] = localizedClassName;
	end
end

local _, addonTable = ...;

------------ spell ------------
local L = locales[GetLocale()];
addonTable.CDs = {
	[L["MISC"]] = {
		[28730] = 120,				--"Arcane Torrent",
		[50613] = 120,				--"Arcane Torrent",
		[80483] = 120,				--"Arcane Torrent",
		[25046] = 120,				--"Arcane Torrent",
		[69179] = 120,				--"Arcane Torrent",
		[20572] = 120,				--"Blood Fury",
		[33702] = 120,				--"Blood Fury",
		[33697] = 120,				--"Blood Fury",
		[59543] = 180,				--"Gift of the Naaru",
		[69070] = 120,				--"Rocket Jump",
		[26297] = 180,				--"Berserking",
		[20594] = 120,				--"Stoneform",
		[58984] = 120,				--"Shadowmeld",
		[20589] = 90,				--"Escape Artist",
		[59752] = 120,				--"Every Man for Himself",
		[7744] = 120,				--"Will of the Forsaken",
		[68992] = 120,				--"Darkflight",
		[50613] = 120,				--"Arcane Torrent",
		[11876] = 120,				--"War Stomp",
		[69041] = 120,				--"Rocket Barrage",
		[42292] = 120,				--"PvP Trinket",
		[195710] = 180,				-- // �������� ��������
		[208683] = 120,				-- // �������� ����������
	},
	[L["HUNTER"]] = { -- // OK
		[186257] = 180,					-- // Aspect of the Cheetah
		[186265] = 180,					-- // Aspect of the Turtle
		[205691] = 120,					-- // Dire Beast: Basilisk
		[209789] = 30,					-- // Freezing Arrow
		[213691] = 20,					-- // Scatter Shot
		[53271] = 45,					-- // Master's Call
		[19574] = 90,					-- // Bestial Wrath
		[147362] = 24,					-- // Counter Shot
		[781] = 20,						-- // Disengage
		[109304] = 120,					-- // Exhilaration
		[186387] = 30,					-- // Bursting Shot
		[193526] = 180,					-- // Trueshot
		[186289] = 120,					-- // Aspect of the Eagle
		[187650] = 25,					-- // Freezing Trap - 15%
		[187707] = 15,					-- // Muzzle
		[109248] = 45,					-- // Binding Shot
		[19577] = 60,					-- // Intimidation
		[19386] = 45,					-- // Wyvern Sting
		[199483] = 60,					-- // Camouflage
		[200108] = 60,					-- // Ranger's Net
		[201078] = 120,					-- // Snake Hunter
	},
	[L["WARLOCK"]] = { -- // OKSOGOOD
		[48020] = 30,				-- // Demonic Circle: Teleport
		[6789] = 45,				-- // Mortal Coil
		[5484] = 40,				--"Howl of Terror",
		[108359] = 120,				--"Dark Regeneration",
		[108416] = 60,				-- // Dark Pact
		[30283] = 30,				--"Shadowfury",
		[104773] = 150,				-- Unending Resolve [-30sec]
		[19647] = 24,				--"Spell Lock",
		[7812] = 60,				--"Sacrifice",
		[89766] = 30,				--"Axe Toss"
		[89751] = 45,				--"Felstorm",
		[115781] = 24,				-- Optical Blast
		[212295] = 45,				-- // Nether Ward
		[1122] = 60,				-- // Summon Infernal [-120sec]
		[18540] = 180,				-- // Summon Doomguard
		[212459] = 90,				-- // Call Fel Lord
		[212284] = 45,				-- // Firestone
	},
	[L["MAGE"]] = { -- // OK
		[122] = 30,					-- // Frost Nova
		[1953] = 15,				-- // Blink
		[11426] = 25,				-- // Ice Barrier
		[45438] = 300,				-- // Ice Block
		[2139] = 24,				-- // Counterspell
		[12042] = 90,				-- // Arcane Power
		[195676] = 24,				-- // Displacement
		[12051] = 90,				-- // Evocation
		[110959] = 75,				-- // Greater Invisibility
		[190319] = 120,				-- // Combustion
		[31661] = 20,				-- // Dragon's Breath
		[66] = 300,					-- // Invisibility
		[84714] = 60,				-- // Frozen Orb
		[12472] = 180,				-- // Icy Veins
		[31687] = 60,				-- // Summon Water Elemental
		[157980] = 25,				-- // Supernova
		[157997] = 25,				-- // Ice Nova
		[235219] = 300,				-- // Cold Snap
	},
	[L["DEATHKNIGHT"]] = { -- // OK
		[47476] = 60,				--"Strangulate",
		[108194] = 45,				-- Asphyxiate
		[48707] = 60,				--"Anti-Magic Shell",
		[49576] = 25,				--"Death Grip",	
		[47528] = 15,				--"Mind Freeze",
		[108201] = 120,				--"Desecrated Ground",
		[108199] = 90,				--"Gorefiend's Grasp", (talent: Tightening Grasp)
		[49039] = 120,				--"Lichborne",
		[51271] = 60,				--"Pillar of Frost",
		[51052] = 120,				--"Anti-Magic Zone",
		[49206] = 180,				--"Summon Gargoyle",
		[48792] = 180,				--"Icebound Fortitude",
		[48743] = 120,				--"Death Pact",
		[77606] = 60,				-- Dark Simulacrum
		[221562] = 45,				-- // Asphyxiate
		[49028] = 180,				-- // Dancing Rune Weapon
		[42650] = 600,				-- // Army of the Dead
		[63560] = 60,				-- // Dark Transformation
		[206977] = 120,				-- // Blood Mirror
		[219809] = 60,				-- // Tombstone
		[207167] = 60, 				-- // Blinding Sleet
		[207319] = 60,				-- // Corpse Shield
		[207349] = 120,				-- // Dark Arbiter
	},
	[L["DRUID"]] = { -- // OK
		[1850] = 180,				-- // Dash
		[20484] = 600,				-- // Rebirth
		[200851] = 90,				-- // Rage of the Sleeper
		[208253] = 90,				-- // Essence of G'Hanir
		[209749] = 30,				-- // Faerie Swarm
		[202246] = 15,				-- // Overrun
		[22812] = 60,				-- // Barkskin
		[194223] = 180,				-- // Celestial Alignment
		[78675] = 30,				-- // Solar Beam
		[106951] = 180,				-- // Berserk
		[22570] = 10,				-- // Maim
		[61336] = 180,				-- // Survival Instincts x2
		[5217] = 30,				-- // Tiger's Fury
		[102342] = 90,				-- // Ironbark
		[740] = 120,				-- // Tranquility
		[102793] = 60,				-- // Ursol's Vortex
		[205636] = 60,				-- // Force of Nature
		[102560] = 180,				-- // Incarnation: Chosen of Elune
		[108238] = 90,				-- // Renewal
		[102543] = 180,				-- // Incarnation: King of the Jungle
		[102558] = 180,				-- // Incarnation: Guardian of Ursoc
		[33891] = 180,				-- // Incarnation: Tree of Life
		[106839] = 15,				-- // Skull Bash
	},
	[L["MONK"]] = { -- // OK
		[202162] = 45,			-- // Guard
		[202370] = 60,			-- // Mighty Ox Kick
		[201318] = 90,			-- // Fortifying Elixir
		[201325] = 180,			-- // Zen Meditation
		[216113] = 45,			-- // Way of the Crane
		[115181] = 15,			-- // Breath of Fire
		[115203] = 210,			-- // Fortifying Brew
		[116705] = 15,			-- // Spear Hand Strike
		[115176] = 150,			-- // Zen Meditation
		[137639] = 90,			-- // Storm, Earth, and Fire
		[115080] = 60,			-- // Touch of Death
		[122470] = 90,			-- // Touch of Karma
		[116849] = 90,			-- // Life Cocoon
		[115310] = 180,			-- // Revival
		[132578] = 180,			-- // Invoke Niuzao, the Black Ox	
		[123904] = 180,			-- // Invoke Xuen, the White Tiger
		[198664] = 180,			-- // Invoke Chi-Ji, the Red Crane
		[198898] = 15,			-- // Song of Chi-Ji
		[115078] = 15,			-- // Paralysis
		[119996] = 25,			-- // Transcendence: Transfer
		[152173] = 90,			-- // Serenity
		[122278] = 120,			-- // Dampen Harm
		[122783] = 90,			-- // Diffuse Magic
	},
	[L["PALADIN"]] = { -- // OKSOGOOD
		[642] = 240,			-- // Божественный щит
		[1044] = 25,			-- // Благословенная свобода
		[633] = 600,			-- // Возложение рук
		[216331] = 60,			-- // Рыцарь-мститель
		[228049] = 180,			-- // Страж забытой королевы
		[210256] = 25,			-- // Благословение святилища
		[1022] = 135,			-- // Благословение защиты
		[31821] = 180,			-- // Владение аурами
		[498] = 60,				-- // Божественная защита
		[31842] = 120,			-- // Гнев карателя
		[6940] = 75,			-- // Жертвенное благословение
		[853] = 60,				-- // Молот правосудия
		[190784] = 45,			-- // Божественный скакун
		[31884] = 120,			-- // Гнев карателя
		[86659] = 300,			-- // Защитник древних королей
		[31850] = 110,			-- // Ревностный защитник
		[96231] = 15,			-- // Укор
		[31884] = 120,			-- // Гнев карателя
		[105809] = 90,			-- // Святой каратель
		[204018] = 180,			-- // Благословение защиты от заклинаний
		[204150] = 180,			-- // Эгида Света
		[205191] = 60,			-- // Око за око
		[224668] = 120,			-- // Священная война
	},
	[L["PRIEST"]] = { -- // OKSOGOOD
		[64044] = 45,				--"Psychic Horror",
		[8122] = 30,				--"Psychic Scream", [-30sec]
		[15487] = 45,				--"Silence",
		[47585] = 120,				--"Dispersion",
		[33206] = 210,				--"Pain Suppression", [-30sec]
		[123040] = 60,				--"Mindbender",
		[10060] = 120,				--"Power Infusion",
		[88625] = 60,				--"Holy Word: Chastise",
		[64843] = 180,				--"Divine Hymn",
		[73325] = 45,				--"Leap of Faith",
		[19236] = 90,				--"Desperate Prayer",
		[62618] = 120,				--"Power Word: Barrier", [-60sec]
		[47788] = 60,				-- Guardian Spirit [-60%] [max=120sec]
		[215769] = 300,				-- // Дух воздаяния
		[108968] = 300,				-- // Вхождение в Бездну
		[213602] = 30,				-- // Улучшенный уход в тень
		[205369] = 30,				-- // Мыслебомба
		[204263] = 45,				-- // Сияющая мощь
	},
	[L["ROGUE"]] = { -- // OKSOGOOD
		[2094] = 120,				--"Blind",
		[1766] = 15,				--"Kick",
		[31224] = 81,				--"Cloak of Shadows" [-9sec]
		[1856] = 30,				-- Исчезновение [-90sec]
		[1776] = 10,				--"Gouge",
		[2983] = 51,				--"Sprint" [-9sec]
		[36554] = 30,				--"Shadowstep",
		[5277] = 120,				--"Evasion",
		[408] = 20,					--"Kidney Shot",
		[76577] = 180,				--"Smoke Bomb",
		[51690] = 120,				--"Killing Spree",
		[79140] = 90,				--"Vendetta", [-30sec]
		[13750] = 150,				-- Adrenaline Rush [-30sec]
		[195457] = 30,				-- // Абордажный крюк
		[199743] = 20,				-- // Парламентер
		[31230] = 360,				-- // Обман смерти
		[207777] = 45,				-- // Долой оружие
		[207736] = 120,				-- // Дуэль в тенях
		[212182] = 180,				-- // Дымовая шашка
		[198529] = 120,				-- // Кража доспехов
		[199804] = 20,				-- // Промеж глаз
		[121471] = 180,				-- // Теневые клинки
	},
	[L["SHAMAN"]] = {
		[57994] = 12,				--"Wind Shear",
		[51490] = 45,				--"Thunderstorm",
		[51485] = 30,				--"Earthbind Totem",
		[108280] = 180,				--"Healing Tide Totem",
		[98008] = 180,				--"Spirit Link Totem",
		[32182] = 300,				--"Heroism",
		[2825] = 300,				--"Bloodlust",
		[51533] = 120,				--"Feral Spirit",
		[79206] = 60,				--"Spiritwalker's Grace", [-60sec]
		[16166] = 120,				--"Elemental Mastery",
		[114050] = 180,				-- Elemental Ascendance
		[114051] = 180,				-- Enhancement Ascendance
		[114052] = 180,				-- Restoration Ascendance
		[108271] = 90,				-- // Астральный сдвиг
		[51514] = 10,				--"Hex", [-20sec]
		[210873] = 10,				-- // Hex [-20sec]
		[211004] = 10,				-- // Hex [-20sec]
		[211010] = 10,				-- // Hex [-20sec]
		[211015] = 10,				-- // Hex [-20sec]
		[210918] = 45,				-- // Астральный облик
		[204437] = 30,				-- // Духовная связь
		[204336] = 30,				-- // Молния-лассо
		[204331] = 45,				-- // Тотем заземления
		[192063] = 15,				-- // Тотем контрудара
		[196884] = 30,				-- // Порыв ветра
		[196932] = 30,				-- // Свирепый выпад
		[192058] = 45,				-- // Тотем вуду
		[207399] = 300,					-- // Тотем выброса тока
	},
	[L["WARRIOR"]] = { -- // OKSOGOOD
		[100] = 17,					--"Charge", [-3sec (talent)]
		[6552] = 15,				--"Pummel",
		[23920] = 25,				--"Spell Reflection",
		[46924] = 60,				--"Bladestorm",
		[46968] = 40,				--"Shockwave",
		[107574] = 90,				--"Avatar",
		[12292] = 30, 				--"Bloodbath",
		[5246] = 90,				--"Intimidating Shout",
		[871] = 240,				--"Shield Wall",	
		[118038] = 180,				--"Die by the Sword",
		[1719] = 35,				-- // Battle Cry [-10sec (arti)] [-15sec (htalent)]
		[3411] = 30,				--"Intervene",
		[6544] = 39,				--"Heroic Leap", [-6sec]
		[12975] = 180,				--"Last Stand",
		[114028] = 30,				-- Mass Spell Reflection
		[18499] = 60,				-- Berserker Rage
		[107570] = 30,				-- Storm Bolt
		[198758] = 17,				-- // Intercept [-3sec (talent)]
		[216890] = 25,				-- // Spell Reflection
		[213915] = 30,				-- // Mass Spell Reflection
		[227847] = 60,				-- // Bladestorm
		[184364] = 120,				-- // Enraged Regeneration
		[198304] = 17,				-- // Intercept [-3sec (talent)]
		[206572] = 20,				-- // Dragon Charge
		[236077] = 30,				-- // Disarm
	},
	[L["DEMONHUNTER"]] = { -- // OK
		[198589] = 60,					-- // Blur
		[179057] = 60,					-- // Chaos Nova
		[183752] = 15,					-- // Consume Magic
		[196718] = 180,					-- // Darkness
		[191427] = 180,					-- // Metamorphosis
		[200166] = 180,					-- // Metamorphosis (leap) (custom icon)
		[188501] = 30,					-- // Spectral Sight
		[218256] = 20,					-- // Empower Wards
		[187827] = 180,					-- // Metamorphosis
		[202138] = 54,					-- // Sigil of Chains
		[207684] = 36,					-- // Sigil of Misery
		[202137] = 36,					-- // Sigil of Silence
		[211048] = 120,					-- // Chaos Blades
		[211881] = 30,					-- // Fel Eruption
		[206491] = 120,					-- // Nemesis
		[207810] = 120,					-- // Nether Bond
		[196555] = 120,					-- // Netherwalk
		[205629] = 30,					-- // Demonic Trample
		[205604] = 60,					-- // Reverse Magic
		[206803] = 60,					-- // Rain from Above
		[205630] = 60,					-- // Illidan's Grasp
		[206650] = 45,					-- // ���� ���������
	},
};

addonTable.Interrupts = {
	47528,	-- Mind Freeze
	80964,	-- Skull Bash (bear)
	80965,	-- Skull Bash (cat)
	2139,	-- Counterspell
	96231,	-- Rebuke
	15487,	-- Silence
	1766,	-- Kick
	57994,	-- Wind Shear
	6552,	-- Pummel
	24259,	-- Spell Lock
	147362,	-- Counter Shot
	116705, -- Spear Hand Strike
	115781,	-- Optical Blast
	183752,	-- Consume Magic
	187707, -- // Muzzle
};

addonTable.Resets = {
	[195676] = {	-- // Displacement
		1953,			-- // Blink
	},
	[235219] = {	-- // Cold Snap
		122,			-- // Frost Nova
		120,			-- // Cone of Cold
		11426,			-- // Ice Barrier
		45438,			-- // Ice Block
	},
};

addonTable.Trinkets = {
	42292,
	59752,
	7744,
	195710,				-- // Почетный медальон
	208683,				-- // Медальон гладиатора
};
------------------------------
------------ TODO ------------
------------------------------
-- Custom icons sorting?
-- More advanced profile manager
------------------------------
local CDs = addonTable.CDs;
local Interrupts = addonTable.Interrupts;
local Resets = addonTable.Resets;
local Trinkets = addonTable.Trinkets;

local SML = LibStub("LibSharedMedia-3.0");
SML:Register("font", "NC_TeenBold", STANDARD_TEXT_FONT, 255);

local SPELL_PVPADAPTATION = 195901;
local SPELL_PVPTRINKET = 42292;

NameplateCooldownsDB = {};
local charactersDB = {};
local CDTimeCache = {};
local CDEnabledCache = {};
local SpellTextureByID = setmetatable({
	[SPELL_PVPTRINKET] =	1322720,
	[200166] =				1247262,
}, {
	__index = function(t, key)
		local texture = GetSpellTexture(key);
		t[key] = texture;
		return texture;
	end
});
local ElapsedTimer = 0;
local Nameplates = {};
local NameplatesVisible = {};
local WorldFrameNumChildren = 0;
local LocalPlayerFullName = UnitName("player").." - "..GetRealmName();
local GUIFrame, EventFrame, TestFrame, db;

local _G, pairs, select, WorldFrame, string_match, string_gsub, string_find, bit_band, GetTime, table_contains_value, math_ceil =
	  _G, pairs, select, WorldFrame, strmatch,	   gsub,		strfind,	 bit.band, GetTime, tContains,			  ceil;
	  
local OnStartup, InitializeDB, AddButtonToBlizzOptions;
local AllocateIcon, ReallocateAllIcons, InitializeFrame, UpdateOnlyOneNameplate, Nameplate_SetBorder, Nameplate_SetCooldown, Nameplate_SortAuras, HideCDIcon, ShowCDIcon;
local OnUpdate;
local PLAYER_ENTERING_WORLD, COMBAT_LOG_EVENT_UNFILTERED, NAME_PLATE_UNIT_ADDED, NAME_PLATE_UNIT_REMOVED;
local EnableTestMode, DisableTestMode;
local ShowGUI, InitializeGUI, GUICategory_1, GUICategory_2, GUICategory_Other, OnGUICategoryClick, ShowGUICategory, RebuildDropdowns, CreateGUICategory, GUICreateSlider, GUICreateButton;
local Print, deepcopy, table_contains_key;

-- // consts: you should not change existing values
local CONST_SORT_MODES = { "none", "trinket-interrupt-other", "interrupt-trinket-other", "trinket-other", "interrupt-other" };
local CONST_SORT_MODES_L = {
	[CONST_SORT_MODES[1]] = "none",
	[CONST_SORT_MODES[2]] = "trinkets, then interrupts, then other spells",
	[CONST_SORT_MODES[3]] = "interrupts, then trinkets, then other spells",
	[CONST_SORT_MODES[4]] = "trinkets, then other spells",
	[CONST_SORT_MODES[5]] = "interrupts, then other spells",
};

-------------------------------------------------------------------------------------------------
----- Initialize
-------------------------------------------------------------------------------------------------
do

	function OnStartup()
		InitializeDB();
		-- // remove non-existent spells
		local badSkills = {};
		for _, k in pairs(CDs) do
			for spellID in pairs(k) do
				if (GetSpellLink(spellID) == nil) then
					db.CDsTable[spellID] = nil;
					table.insert(badSkills, spellID);
					Print("This spell doesn't exist -->> "..spellID);
				end
			end
		end
		-- // add new spells to user's db
		for _, k in pairs(CDs) do
			for spellID in pairs(k) do
				if (db.CDsTable[spellID] == nil and not table_contains_value(badSkills, spellID)) then
					db.CDsTable[spellID] = true;
					--Print(format(L["New spell has been added: %s"], GetSpellLink(spellID)));
				end
			end
		end
		-- // cache initialisation
		for _, k in pairs(CDs) do
			for spellID, timeInSec in pairs(k) do
				if (db.CDsTable[spellID] == true) then
					CDEnabledCache[spellID] = true;
				end
				CDTimeCache[spellID] = timeInSec;
			end
		end
		-- // starting OnUpdate()
		EventFrame:SetScript("OnUpdate", function(self, elapsed)
			ElapsedTimer = ElapsedTimer + elapsed;
			if (ElapsedTimer >= 1) then
				OnUpdate();
				ElapsedTimer = 0;
			end
		end);
		-- // starting listening for events
		EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		EventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED");
		EventFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED");
		AddButtonToBlizzOptions();
		SLASH_NAMEPLATECOOLDOWNS1 = '/nc';
		SlashCmdList["NAMEPLATECOOLDOWNS"] = function(msg, editBox)
			if (msg == "t" or msg == "ver") then
				local c = UNKNOWN;
				if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
					c = "INSTANCE_CHAT";
				elseif (IsInRaid()) then
					c = "RAID";
				else
					c = "GUILD";
				end
				Print("Waiting for replies from " .. c);
				SendAddonMessage("NC_prefix", "requesting", c);
			else
				ShowGUI();
			end
		end
		OnStartup = nil;
	end

	function InitializeDB()
		if (NameplateCooldownsDB[LocalPlayerFullName] == nil) then
			NameplateCooldownsDB[LocalPlayerFullName] = { };
		end
		local defaults = {
			CDsTable = { },
			IconSize = 21,
			IconXOffset = 0,
			IconYOffset = -36,
			FullOpacityAlways = false,
			ShowBorderTrinkets = true,
			ShowBorderInterrupts = true,
			BorderInterruptsColor = {1, 0.35, 0},
			BorderTrinketsColor = {1, 0.843, 0},
			Font = "NC_TeenBold",
			IconSortMode = CONST_SORT_MODES[1],
			AddonEnabled = true,
		};
		for key, value in pairs(defaults) do
			if (NameplateCooldownsDB[LocalPlayerFullName][key] == nil) then
				NameplateCooldownsDB[LocalPlayerFullName][key] = value;
			end
		end
		db = NameplateCooldownsDB[LocalPlayerFullName];
	end
		
	function AddButtonToBlizzOptions()
		local frame = CreateFrame("Frame", "NC_BlizzOptionsFrame", UIParent);
		frame.name = "|cFF99CC01[PVP]|r敌技能CD(血条)";
		InterfaceOptions_AddCategory(frame);
		local button = GUICreateButton("NC_BlizzOptionsButton", frame, "点击我设置敌对血条上技能CD监控的图标位置和大小");
		button:SetWidth(480);
		button:SetHeight(43);
		button:SetPoint("CENTER", frame, "CENTER", 0, 0);
		button:SetScript("OnClick", function(self, ...)
			ShowGUI();
			if (GUIFrame) then
				InterfaceOptionsFrameCancel:Click();
			end
		end);
	end
	
end

-------------------------------------------------------------------------------------------------
----- Nameplates
-------------------------------------------------------------------------------------------------
do

	function AllocateIcon(frame)
		if (not frame.NCFrame) then
			frame.NCFrame = CreateFrame("frame", nil, db.FullOpacityAlways and WorldFrame or frame);
			frame.NCFrame:SetWidth(db.IconSize);
			frame.NCFrame:SetHeight(db.IconSize);
			frame.NCFrame:SetPoint("TOPLEFT", frame, db.IconXOffset, db.IconYOffset);
			frame.NCFrame:Show();
		end
		local texture = frame.NCFrame:CreateTexture(nil, "BORDER");
		texture:SetPoint("LEFT", frame.NCFrame, frame.NCIconsCount * db.IconSize, 0);
		texture:SetWidth(db.IconSize);
		texture:SetHeight(db.IconSize);
		texture:Hide();
		texture.cooldown = frame.NCFrame:CreateFontString(nil, "OVERLAY");
		texture.cooldown:SetTextColor(0.7, 1, 0);
		texture.cooldown:SetAllPoints(texture);
		texture.cooldown:SetFont(SML:Fetch("font", db.Font), math_ceil(db.IconSize - db.IconSize / 2), "OUTLINE");
		texture.border = frame.NCFrame:CreateTexture(nil, "OVERLAY");
		texture.border:SetTexture("Interface\\AddOns\\PVPMaster\\Images\\CooldownFrameBorder.tga");
		texture.border:SetVertexColor(1, 0.35, 0);
		texture.border:SetAllPoints(texture);
		texture.border:Hide();
		frame.NCIconsCount = frame.NCIconsCount + 1;
		tinsert(frame.NCIcons, texture);
	end
	
	function ReallocateAllIcons(clearSpells)
		for frame in pairs(Nameplates) do
			if (frame.NCFrame) then
				frame.NCFrame:SetPoint("TOPLEFT", frame, db.IconXOffset, db.IconYOffset);
				local counter = 0;
				for _, icon in pairs(frame.NCIcons) do
					icon:SetWidth(db.IconSize);
					icon:SetHeight(db.IconSize);
					icon:SetPoint("LEFT", frame.NCFrame, counter * db.IconSize, 0);
					icon.cooldown:SetFont(SML:Fetch("font", db.Font), math_ceil(db.IconSize - db.IconSize / 2), "OUTLINE");
					if (clearSpells) then
						HideCDIcon(icon);
					end
					counter = counter + 1;
				end
			end
		end
		if (clearSpells) then
			OnUpdate();
		end
	end
	
	function UpdateOnlyOneNameplate(frame, name)
		local counter = 1;
		if (charactersDB[name]) then
			local currentTime = GetTime();
			local sortedCDs = Nameplate_SortAuras(charactersDB[name]);
			for _, spellInfo in pairs(sortedCDs) do
				local spellID = spellInfo.spellID;
				if (spellInfo.expires > currentTime) then
					if (counter > frame.NCIconsCount) then
						AllocateIcon(frame);
					end
					local icon = frame.NCIcons[counter];
					if (icon.spellID ~= spellID) then
						icon:SetTexture(SpellTextureByID[spellID]);
						icon.spellID = spellID;
						Nameplate_SetBorder(icon, spellID);
					end
					local remain = spellInfo.expires - currentTime;
					Nameplate_SetCooldown(icon, remain)
					if (not icon.shown) then
						ShowCDIcon(icon);
					end
					counter = counter + 1;
				else
					charactersDB[name][spellID] = nil;
				end
			end
		end
		for k = counter, frame.NCIconsCount do
			local icon = frame.NCIcons[k];
			if (icon.shown) then
				HideCDIcon(icon);
			end
		end
	end
	
	function Nameplate_SetBorder(icon, spellID)
		if (db.ShowBorderInterrupts and table_contains_value(Interrupts, spellID)) then
			if (icon.borderState ~= 1) then
				icon.border:SetVertexColor(unpack(db.BorderInterruptsColor));
				icon.border:Show();
				icon.borderState = 1;
			end
		elseif (db.ShowBorderTrinkets and table_contains_value(Trinkets, spellID)) then
			if (icon.borderState ~= 2) then
				icon.border:SetVertexColor(unpack(db.BorderTrinketsColor));
				icon.border:Show();
				icon.borderState = 2;
			end
		elseif (icon.borderState ~= nil) then
			icon.border:Hide();
			icon.borderState = nil;
		end
	end
	
	function Nameplate_SetCooldown(icon, remain)
		if (remain >= 60) then
			icon.cooldown:SetText(math_ceil(remain/60).."m");
		else
			icon.cooldown:SetText(math_ceil(remain));
		end
	end
	
	function Nameplate_SortAuras(cds)
		local t = { };
		for spellID, spellInfo in pairs(cds) do
			if (spellID ~= nil) then
				table.insert(t, spellInfo);
			end
		end
		if (db.IconSortMode == CONST_SORT_MODES[1]) then
			-- // do nothing
		elseif (db.IconSortMode == CONST_SORT_MODES[2]) then
			table.sort(t, function(item1, item2)
				if (table_contains_value(Trinkets, item1.spellID)) then
					if (table_contains_value(Trinkets, item2.spellID)) then
						return item1.expires < item2.expires;
					else
						return true;
					end
				elseif (table_contains_value(Trinkets, item2.spellID)) then
					return false;
				elseif (table_contains_value(Interrupts, item1.spellID)) then
					if (table_contains_value(Interrupts, item2.spellID)) then
						return item1.expires < item2.expires;
					else
						return true;
					end
				elseif (table_contains_value(Interrupts, item2.spellID)) then
					return false;
				else
					return item1.expires < item2.expires;
				end
			end);
		elseif (db.IconSortMode == CONST_SORT_MODES[3]) then
			table.sort(t, function(item1, item2)
				if (table_contains_value(Interrupts, item1.spellID)) then
					if (table_contains_value(Interrupts, item2.spellID)) then
						return item1.expires < item2.expires;
					else
						return true;
					end
				elseif (table_contains_value(Interrupts, item2.spellID)) then
					return false;
				elseif (table_contains_value(Trinkets, item1.spellID)) then
					if (table_contains_value(Trinkets, item2.spellID)) then
						return item1.expires < item2.expires;
					else
						return true;
					end
				elseif (table_contains_value(Trinkets, item2.spellID)) then
					return false;
				else
					return item1.expires < item2.expires;
				end
			end);
		elseif (db.IconSortMode == CONST_SORT_MODES[4]) then
			table.sort(t, function(item1, item2)
				if (table_contains_value(Trinkets, item1.spellID)) then
					if (table_contains_value(Trinkets, item2.spellID)) then
						return item1.expires < item2.expires;
					else
						return true;
					end
				elseif (table_contains_value(Trinkets, item2.spellID)) then
					return false;
				else
					return item1.expires < item2.expires;
				end
			end);
		elseif (db.IconSortMode == CONST_SORT_MODES[5]) then
			table.sort(t, function(item1, item2)
				if (table_contains_value(Interrupts, item1.spellID)) then
					if (table_contains_value(Interrupts, item2.spellID)) then
						return item1.expires < item2.expires;
					else
						return true;
					end
				elseif (table_contains_value(Interrupts, item2.spellID)) then
					return false;
				else
					return item1.expires < item2.expires;
				end
			end);
		end
		return t;
	end
	
	function HideCDIcon(icon)
		icon.border:Hide();
		icon.borderState = nil;
		icon.cooldown:Hide();
		icon:Hide();
		icon.shown = false;
		icon.spellID = 0;
	end
	
	function ShowCDIcon(icon)
		icon.cooldown:Show();
		icon:Show();
		icon.shown = true;
	end
	
end

-------------------------------------------------------------------------------------------------
----- OnUpdates
-------------------------------------------------------------------------------------------------
do

	function OnUpdate()
		for frame, unitName in pairs(NameplatesVisible) do
			UpdateOnlyOneNameplate(frame, unitName);
		end
	end
	
end

-------------------------------------------------------------------------------------------------
----- Events
-------------------------------------------------------------------------------------------------
do
	
	local COMBATLOG_OBJECT_IS_HOSTILE = COMBATLOG_OBJECT_REACTION_HOSTILE;
	
	function PLAYER_ENTERING_WORLD()
		if (OnStartup) then
			OnStartup();
		end
		wipe(charactersDB);
	end
	
	function COMBAT_LOG_EVENT_UNFILTERED(...)
		local cTime = GetTime();
		local _, eventType, _, _, srcName, srcFlags, _, _, _, _, _, spellID = ...;
		if (bit_band(srcFlags, COMBATLOG_OBJECT_IS_HOSTILE) ~= 0) then
			if (CDEnabledCache[spellID]) then
				if (eventType == "SPELL_CAST_SUCCESS" or eventType == "SPELL_AURA_APPLIED" or eventType == "SPELL_MISSED" or eventType == "SPELL_SUMMON") then
					local Name = string_match(srcName, "[%P]+");
					if (not charactersDB[Name]) then
						charactersDB[Name] = {};
					end
					local duration = CDTimeCache[spellID];
					local expires = cTime + duration;
					charactersDB[Name][spellID] = { ["spellID"] = spellID, ["duration"] = duration, ["expires"] = expires };
					for frame, charName in pairs(NameplatesVisible) do
						if (charName == Name) then
							UpdateOnlyOneNameplate(frame, charName);
							break;
						end
					end
				end
			end
			-- // resets
			if (table_contains_key(Resets, spellID)) then
				if (eventType == "SPELL_CAST_SUCCESS") then
					local Name = string_match(srcName, "[%P]+");
					if (charactersDB[Name]) then
						for _, v in pairs(Resets[spellID]) do
							charactersDB[Name][v] = nil;
						end
						for frame, charName in pairs(NameplatesVisible) do
							if (charName == Name) then
								UpdateOnlyOneNameplate(frame, charName);
								break;
							end
						end
					end
				end
			elseif (spellID == 102060) then	-- // let's start cd of spellid:6552 if warrior have used spellid:102060
				if (CDEnabledCache[6552] and eventType == "SPELL_CAST_SUCCESS") then
					local Name = string_match(srcName, "[%P]+");
					if (not charactersDB[Name]) then
						charactersDB[Name] = {};
					end
					local duration = CDTimeCache[6552];
					local expires = cTime + duration;
					charactersDB[Name][6552] = { ["spellID"] = 6552, ["duration"] = duration, ["expires"] = expires };
					for frame, charName in pairs(NameplatesVisible) do
						if (charName == Name) then
							UpdateOnlyOneNameplate(frame, charName);
							break;
						end
					end
				end
			elseif (spellID == SPELL_PVPADAPTATION) then -- // pvptier 1/2 used, correcting cd of PvP trinket
				if (CDEnabledCache[SPELL_PVPTRINKET] and eventType == "SPELL_AURA_APPLIED") then
					local Name = string_match(srcName, "[%P]+");
					if (charactersDB[Name]) then
						charactersDB[Name][SPELL_PVPTRINKET] = { ["spellID"] = SPELL_PVPTRINKET, ["duration"] = 60, ["expires"] = cTime + 60 };
						for frame, charName in pairs(NameplatesVisible) do
							if (charName == Name) then
								UpdateOnlyOneNameplate(frame, charName);
								break;
							end
						end
					end
				end
			end
		end
	end

	function NAME_PLATE_UNIT_ADDED(...)
		local unitID = ...;
		local nameplate = C_NamePlate.GetNamePlateForUnit(unitID);
		local unitName = UnitName(unitID);
		NameplatesVisible[nameplate] = unitName;
		if (not Nameplates[nameplate]) then
			nameplate.NCIcons = {};
			nameplate.NCIconsCount = 0;	-- // it's faster than #nameplate.NCIcons
			Nameplates[nameplate] = true;
		end
		UpdateOnlyOneNameplate(nameplate, unitName);
		if (db.FullOpacityAlways and nameplate.NCFrame) then
			nameplate.NCFrame:Show();
		end
	end
	
	function NAME_PLATE_UNIT_REMOVED(...)
		local unitID = ...;
		local nameplate = C_NamePlate.GetNamePlateForUnit(unitID);
		NameplatesVisible[nameplate] = nil;
		if (db.FullOpacityAlways and nameplate.NCFrame) then
			nameplate.NCFrame:Hide();
		end
	end
	
end

-------------------------------------------------------------------------------------------------
----- Test mode
-------------------------------------------------------------------------------------------------
do

	local _t = 0;
	local _charactersDB;
	local _spellIDs = {2139, 108194, 100};
	
	local function refreshCDs()
		local cTime = GetTime();
		for _, unitName in pairs(NameplatesVisible) do
			if (not charactersDB[unitName]) then
				charactersDB[unitName] = {};
			end
			charactersDB[unitName][SPELL_PVPTRINKET] = { ["spellID"] = SPELL_PVPTRINKET, ["duration"] = CDTimeCache[SPELL_PVPTRINKET], ["expires"] = cTime + CDTimeCache[SPELL_PVPTRINKET] }; -- // 2m test
			for _, spellID in pairs(_spellIDs) do
				if (not charactersDB[unitName][spellID]) then
					charactersDB[unitName][spellID] = { ["spellID"] = spellID, ["duration"] = CDTimeCache[spellID], ["expires"] = cTime + CDTimeCache[spellID] };
				else
					if (cTime - charactersDB[unitName][spellID]["expires"] > 0) then
						charactersDB[unitName][spellID] = { ["spellID"] = spellID, ["duration"] = CDTimeCache[spellID], ["expires"] = cTime + CDTimeCache[spellID] };
					end
				end
			end
		end
	end
	
	function EnableTestMode()
		_charactersDB = deepcopy(charactersDB);
		if (not TestFrame) then
			TestFrame = CreateFrame("frame");
		end
		TestFrame:SetScript("OnUpdate", function(self, elapsed)
			_t = _t + elapsed;
			if (_t >= 2) then
				refreshCDs();
				_t = 0;
			end
		end);
		refreshCDs(); 	-- // for instant start
		OnUpdate();		-- // for instant start
	end
	
	function DisableTestMode()
		TestFrame:SetScript("OnUpdate", nil);
		charactersDB = deepcopy(_charactersDB);
		OnUpdate();		-- // for instant start
	end
	
end

-------------------------------------------------------------------------------------------------
----- GUI
-------------------------------------------------------------------------------------------------
do

	local function GUICreateCheckBox(x, y, text, func, publicName)
		local checkBox = CreateFrame("CheckButton", publicName, GUIFrame);
		checkBox:SetHeight(20);
		checkBox:SetWidth(20);
		checkBox:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", x, y);
		checkBox:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
		checkBox:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down");
		checkBox:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight");
		checkBox:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled");
		checkBox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
		checkBox.Text = checkBox:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		checkBox.Text:SetPoint("LEFT", 20, 0);
		checkBox.Text:SetText(text);
		checkBox:EnableMouse(true);
		checkBox:SetScript("OnClick", func);
		checkBox:Hide();
		return checkBox;
	end
	
	local function GUICreateCheckBoxWithColorPicker(publicName, x, y, text, checkedChangedCallback)
		local checkBox = GUICreateCheckBox(x, y, text, checkedChangedCallback, publicName);
		checkBox.Text:SetPoint("LEFT", 40, 0);
		
		checkBox.ColorButton = CreateFrame("Button", nil, checkBox);
		checkBox.ColorButton:SetPoint("LEFT", 19, 0);
		checkBox.ColorButton:SetWidth(20);
		checkBox.ColorButton:SetHeight(20);
		checkBox.ColorButton:Hide();

		checkBox.ColorButton:EnableMouse(true);

		checkBox.ColorButton.colorSwatch = checkBox.ColorButton:CreateTexture(nil, "OVERLAY");
		checkBox.ColorButton.colorSwatch:SetWidth(19);
		checkBox.ColorButton.colorSwatch:SetHeight(19);
		checkBox.ColorButton.colorSwatch:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch");
		checkBox.ColorButton.colorSwatch:SetPoint("LEFT");
		checkBox.ColorButton.SetColor = checkBox.ColorButton.colorSwatch.SetVertexColor;

		checkBox.ColorButton.texture = checkBox.ColorButton:CreateTexture(nil, "BACKGROUND");
		checkBox.ColorButton.texture:SetWidth(16);
		checkBox.ColorButton.texture:SetHeight(16);
		checkBox.ColorButton.texture:SetTexture(1, 1, 1);
		checkBox.ColorButton.texture:SetPoint("CENTER", checkBox.ColorButton.colorSwatch);
		checkBox.ColorButton.texture:Show();

		checkBox.ColorButton.checkers = checkBox.ColorButton:CreateTexture(nil, "BACKGROUND");
		checkBox.ColorButton.checkers:SetWidth(14);
		checkBox.ColorButton.checkers:SetHeight(14);
		checkBox.ColorButton.checkers:SetTexture("Tileset\\Generic\\Checkers");
		checkBox.ColorButton.checkers:SetTexCoord(.25, 0, 0.5, .25);
		checkBox.ColorButton.checkers:SetDesaturated(true);
		checkBox.ColorButton.checkers:SetVertexColor(1, 1, 1, 0.75);
		checkBox.ColorButton.checkers:SetPoint("CENTER", checkBox.ColorButton.colorSwatch);
		checkBox.ColorButton.checkers:Show();
		
		checkBox:HookScript("OnShow", function(self) self.ColorButton:Show(); end);
		checkBox:HookScript("OnHide", function(self) self.ColorButton:Hide(); end);
		
		return checkBox;
	end

	function ShowGUI()
		if (not InCombatLockdown()) then
			if (not GUIFrame) then
				InitializeGUI();
			end
			GUIFrame:Show();
			OnGUICategoryClick(GUIFrame.CategoryButtons[1]);
		else
			Print(L["Options are not available in combat!"]);
		end
	end
	
	function InitializeGUI()
		GUIFrame = CreateFrame("Frame", "NC_GUIFrame", UIParent);
		GUIFrame:SetHeight(350);
		GUIFrame:SetWidth(500);
		GUIFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 80);
		GUIFrame:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = 1,
			tileSize = 16,
			edgeSize = 16,
			insets = { left = 3, right = 3, top = 3, bottom = 3 } 
		});
		GUIFrame:SetBackdropColor(0.25, 0.24, 0.32, 1);
		GUIFrame:SetBackdropBorderColor(0.1,0.1,0.1,1);
		GUIFrame:EnableMouse(1);
		GUIFrame:SetMovable(1);
		GUIFrame:SetFrameStrata("DIALOG");
		GUIFrame:SetToplevel(1);
		GUIFrame:SetClampedToScreen(1);
		GUIFrame:SetScript("OnMouseDown", function() GUIFrame:StartMoving(); end);
		GUIFrame:SetScript("OnMouseUp", function() GUIFrame:StopMovingOrSizing(); end);
		GUIFrame:Hide();
		
		GUIFrame.CategoryButtons = {};
		GUIFrame.ActiveCategory = 1;
		
		local header = GUIFrame:CreateFontString("NC_GUIHeader", "ARTWORK", "GameFontHighlight");
		header:SetFont(GameFontNormal:GetFont(), 22, "THICKOUTLINE");
		header:SetPoint("CENTER", GUIFrame, "CENTER", 0, 185);
		header:SetText("NameplateCooldowns");
		
		GUIFrame.outline = CreateFrame("Frame", nil, GUIFrame);
		GUIFrame.outline:SetBackdrop({
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = 1,
			tileSize = 16,
			edgeSize = 16,
			insets = { left = 4, right = 4, top = 4, bottom = 4 }
		});
		GUIFrame.outline:SetBackdropColor(0.1, 0.1, 0.2, 1);
		GUIFrame.outline:SetBackdropBorderColor(0.8, 0.8, 0.9, 0.4);
		GUIFrame.outline:SetPoint("TOPLEFT", 12, -12);
		GUIFrame.outline:SetPoint("BOTTOMLEFT", 12, 12);
		GUIFrame.outline:SetWidth(100);
		
		local closeButton = CreateFrame("Button", "NC_GUICloseButton", GUIFrame, "UIPanelButtonTemplate");
		closeButton:SetWidth(24);
		closeButton:SetHeight(24);
		closeButton:SetPoint("TOPRIGHT", 0, 22);
		closeButton:SetScript("OnClick", function() GUIFrame:Hide(); end);
		closeButton.text = closeButton:CreateFontString(nil, "ARTWORK", "GameFontNormal");
		closeButton.text:SetPoint("CENTER", closeButton, "CENTER", 1, -1);
		closeButton.text:SetText("X");
		
		local scrollFramesTipText = GUIFrame:CreateFontString("NC_GUIScrollFramesTipText", "OVERLAY", "GameFontNormal");
		scrollFramesTipText:SetPoint("CENTER", GUIFrame, "LEFT", 300, 130);
		scrollFramesTipText:SetText(L["Click on icon to enable/disable tracking"]);
		
		GUIFrame.Categories = {};
		GUIFrame.SpellIcons = {};
		
		for index, value in pairs({L["General"], L["Profiles"], L["WARRIOR"], L["DRUID"], L["PRIEST"], L["MAGE"], L["MONK"], L["HUNTER"], L["PALADIN"], L["ROGUE"], L["DEATHKNIGHT"], L["WARLOCK"], L["SHAMAN"], L["DEMONHUNTER"], L["MISC"]}) do
			local b = CreateGUICategory();
			b.index = index;
			b.text:SetText(value);
			if (index == 1) then
				b:LockHighlight();
				b.text:SetTextColor(1, 1, 1);
				b:SetPoint("TOPLEFT", GUIFrame.outline, "TOPLEFT", 5, -6);
			elseif (index == 2) then
				b:SetPoint("TOPLEFT",GUIFrame.outline,"TOPLEFT", 5, -24);
			else
				b:SetPoint("TOPLEFT",GUIFrame.outline,"TOPLEFT", 5, -18 * (index - 1) - 26);
			end
			
			GUIFrame.Categories[index] = {};
			
			if (index == 1) then
				GUICategory_1(index, value);
			elseif (index == 2) then
				GUICategory_2(index, value);
			else
				GUICategory_Other(index, value);
			end
		end
	end

	function GUICategory_1(index, value)
		local buttonEnableDisableAddon = GUICreateButton("test123", GUIFrame, db.AddonEnabled and L["options:general:disable-addon-btn"] or L["options:general:enable-addon-btn"]);
		buttonEnableDisableAddon:SetWidth(340);
		buttonEnableDisableAddon:SetHeight(20);
		buttonEnableDisableAddon:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 130, -15);
		buttonEnableDisableAddon:SetScript("OnClick", function(self, ...)
			if (db.AddonEnabled) then
				EventFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
				wipe(charactersDB);
			else
				EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			end
			OnUpdate();
			db.AddonEnabled = not db.AddonEnabled;
			buttonEnableDisableAddon.Text:SetText(db.AddonEnabled and L["options:general:disable-addon-btn"] or L["options:general:enable-addon-btn"]);
			Print(db.AddonEnabled and L["chat:addon-is-enabled"] or L["chat:addon-is-disabled"]);
		end);
		table.insert(GUIFrame.Categories[index], buttonEnableDisableAddon);
	
		local buttonSwitchTestMode = GUICreateButton("NC_GUIGeneralButtonSwitchTestMode", GUIFrame, L["Enable test mode (need at least one visible nameplate)"]);
		buttonSwitchTestMode:SetWidth(340);
		buttonSwitchTestMode:SetHeight(20);
		buttonSwitchTestMode:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 130, -40);
		buttonSwitchTestMode:SetScript("OnClick", function(self, ...)
			if (not TestFrame or not TestFrame:GetScript("OnUpdate")) then
				EnableTestMode();
				self.Text:SetText(L["Disable test mode"]);
			else
				DisableTestMode();
				self.Text:SetText(L["Enable test mode (need at least one visible nameplate)"]);
			end
		end);
		table.insert(GUIFrame.Categories[index], buttonSwitchTestMode);
		
		local sliderIconSize = GUICreateSlider(GUIFrame, 130, -70, 340, "NC_GUIGeneralSliderIconSize");
		sliderIconSize.label:SetText(L["Icon size"]);
		sliderIconSize.slider:SetValueStep(1);
		sliderIconSize.slider:SetMinMaxValues(1, 50);
		sliderIconSize.slider:SetValue(db.IconSize);
		sliderIconSize.slider:SetScript("OnValueChanged", function(self, value)
			sliderIconSize.editbox:SetText(tostring(math_ceil(value)));
			db.IconSize = math_ceil(value);
			ReallocateAllIcons(false);
		end);
		sliderIconSize.editbox:SetText(tostring(db.IconSize));
		sliderIconSize.editbox:SetScript("OnEnterPressed", function(self, value)
			if (sliderIconSize.editbox:GetText() ~= "") then
				local v = tonumber(sliderIconSize.editbox:GetText());
				if (v == nil) then
					sliderIconSize.editbox:SetText(tostring(db.IconSize));
					Print(L["Value must be a number"]);
				else
					if (v > 50) then
						v = 50;
					end
					if (v < 1) then
						v = 1;
					end
					sliderIconSize.slider:SetValue(v);
				end
				sliderIconSize.editbox:ClearFocus();
			end
		end);
		sliderIconSize.lowtext:SetText("1");
		sliderIconSize.hightext:SetText("50");
		table.insert(GUIFrame.Categories[index], sliderIconSize);
		
		local sliderIconXOffset = GUICreateSlider(GUIFrame, 130, -125, 155, "NC_GUIGeneralSliderIconXOffset");
		sliderIconXOffset.label:SetText(L["Icon X-coord offset"]);
		sliderIconXOffset.slider:SetValueStep(1);
		sliderIconXOffset.slider:SetMinMaxValues(-200, 200);
		sliderIconXOffset.slider:SetValue(db.IconXOffset);
		sliderIconXOffset.slider:SetScript("OnValueChanged", function(self, value)
			sliderIconXOffset.editbox:SetText(tostring(math_ceil(value)));
			db.IconXOffset = math_ceil(value);
			ReallocateAllIcons(false);
		end);
		sliderIconXOffset.editbox:SetText(tostring(db.IconXOffset));
		sliderIconXOffset.editbox:SetScript("OnEnterPressed", function(self, value)
			if (sliderIconXOffset.editbox:GetText() ~= "") then
				local v = tonumber(sliderIconXOffset.editbox:GetText());
				if (v == nil) then
					sliderIconXOffset.editbox:SetText(tostring(db.IconXOffset));
					Print(L["Value must be a number"]);
				else
					if (v > 200) then
						v = 200;
					end
					if (v < -200) then
						v = -200;
					end
					sliderIconXOffset.slider:SetValue(v);
				end
				sliderIconXOffset.editbox:ClearFocus();
			end
		end);
		sliderIconXOffset.lowtext:SetText("-200");
		sliderIconXOffset.hightext:SetText("200");
		table.insert(GUIFrame.Categories[index], sliderIconXOffset);
		
		local sliderIconYOffset = GUICreateSlider(GUIFrame, 315, -125, 155, "NC_GUIGeneralSliderIconYOffset");
		sliderIconYOffset.label:SetText(L["Icon Y-coord offset"]);
		sliderIconYOffset.slider:SetValueStep(1);
		sliderIconYOffset.slider:SetMinMaxValues(-200, 200);
		sliderIconYOffset.slider:SetValue(db.IconYOffset);
		sliderIconYOffset.slider:SetScript("OnValueChanged", function(self, value)
			sliderIconYOffset.editbox:SetText(tostring(math_ceil(value)));
			db.IconYOffset = math_ceil(value);
			ReallocateAllIcons(false);
		end);
		sliderIconYOffset.editbox:SetText(tostring(db.IconYOffset));
		sliderIconYOffset.editbox:SetScript("OnEnterPressed", function(self, value)
			if (sliderIconYOffset.editbox:GetText() ~= "") then
				local v = tonumber(sliderIconYOffset.editbox:GetText());
				if (v == nil) then
					sliderIconYOffset.editbox:SetText(tostring(db.IconYOffset));
					Print(L["Value must be a number"]);
				else
					if (v > 200) then
						v = 200;
					end
					if (v < -200) then
						v = -200;
					end
					sliderIconYOffset.slider:SetValue(v);
				end
				sliderIconYOffset.editbox:ClearFocus();
			end
		end);
		sliderIconYOffset.lowtext:SetText("-200");
		sliderIconYOffset.hightext:SetText("200");
		table.insert(GUIFrame.Categories[index], sliderIconYOffset);
		
		local checkBoxFullOpacityAlways = GUICreateCheckBox(130, -195, L["Always display CD icons at full opacity (ReloadUI is needed)"], function(this)
			db.FullOpacityAlways = this:GetChecked();
		end, "NC_GUI_General_CheckBoxFullOpacityAlways");
		checkBoxFullOpacityAlways:SetChecked(db.FullOpacityAlways);
		table.insert(GUIFrame.Categories[index], checkBoxFullOpacityAlways);
		
		local checkBoxBorderTrinkets = GUICreateCheckBoxWithColorPicker("NC_GUI_General_CheckBoxBorderTrinkets", 130, -225, L["Show border around trinkets"], function(this)
			db.ShowBorderTrinkets = this:GetChecked();
			ReallocateAllIcons(true);
		end);
		checkBoxBorderTrinkets:SetChecked(db.ShowBorderTrinkets);
		checkBoxBorderTrinkets.ColorButton.colorSwatch:SetVertexColor(unpack(db.BorderTrinketsColor));
		checkBoxBorderTrinkets.ColorButton:SetScript("OnClick", function()
			ColorPickerFrame:Hide();
			local function callback(restore)
				local r, g, b;
				if (restore) then
					r, g, b = unpack(restore);
				else
					r, g, b = ColorPickerFrame:GetColorRGB();
				end
				db.BorderTrinketsColor = {r, g, b};
				checkBoxBorderTrinkets.ColorButton.colorSwatch:SetVertexColor(unpack(db.BorderTrinketsColor));
				ReallocateAllIcons(true);
			end
			ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = callback, callback, callback;
			ColorPickerFrame:SetColorRGB(unpack(db.BorderTrinketsColor));
			ColorPickerFrame.hasOpacity = false;
			ColorPickerFrame.previousValues = { unpack(db.BorderTrinketsColor) };
			ColorPickerFrame:Show();
		end);
		table.insert(GUIFrame.Categories[index], checkBoxBorderTrinkets);
		
		local checkBoxBorderInterrupts = GUICreateCheckBoxWithColorPicker("NC_GUI_General_CheckBoxBorderInterrupts", 130, -245, L["Show border around interrupts"], function(this)
			db.ShowBorderInterrupts = this:GetChecked();
			ReallocateAllIcons(true);
		end);
		checkBoxBorderInterrupts:SetChecked(db.ShowBorderInterrupts);
		checkBoxBorderInterrupts.ColorButton.colorSwatch:SetVertexColor(unpack(db.BorderInterruptsColor));
		checkBoxBorderInterrupts.ColorButton:SetScript("OnClick", function()
			ColorPickerFrame:Hide();
			local function callback(restore)
				local r, g, b;
				if (restore) then
					r, g, b = unpack(restore);
				else
					r, g, b = ColorPickerFrame:GetColorRGB();
				end
				db.BorderInterruptsColor = {r, g, b};
				checkBoxBorderInterrupts.ColorButton.colorSwatch:SetVertexColor(unpack(db.BorderInterruptsColor));
				ReallocateAllIcons(true);
			end
			ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = callback, callback, callback;
			ColorPickerFrame:SetColorRGB(unpack(db.BorderInterruptsColor));
			ColorPickerFrame.hasOpacity = false;
			ColorPickerFrame.previousValues = { unpack(db.BorderInterruptsColor) };
			ColorPickerFrame:Show();
		end);
		table.insert(GUIFrame.Categories[index], checkBoxBorderInterrupts);
		
		local dropdownIconSortMode = CreateFrame("Frame", "NC.GUI.General.DropdownIconSortMode", GUIFrame, "UIDropDownMenuTemplate");
		UIDropDownMenu_SetWidth(dropdownIconSortMode, 300);
		dropdownIconSortMode:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 116, -275);
		local info = {};
		dropdownIconSortMode.initialize = function()
			wipe(info);
			for _, sortMode in pairs(CONST_SORT_MODES) do
				info.text = CONST_SORT_MODES_L[sortMode];
				info.value = sortMode;
				info.func = function(self)
					db.IconSortMode = self.value;
					_G[dropdownIconSortMode:GetName().."Text"]:SetText(self:GetText());
				end
				info.checked = (db.IconSortMode == info.value);
				UIDropDownMenu_AddButton(info);
			end
		end
		_G[dropdownIconSortMode:GetName().."Text"]:SetText(CONST_SORT_MODES_L[db.IconSortMode]);
		dropdownIconSortMode.text = dropdownIconSortMode:CreateFontString("NC.GUI.General.DropdownIconSortMode.Label", "ARTWORK", "GameFontNormalSmall");
		dropdownIconSortMode.text:SetPoint("LEFT", 20, 15);
		dropdownIconSortMode.text:SetText("Sort mode:"); -- // todo:localize
		table.insert(GUIFrame.Categories[index], dropdownIconSortMode);
		
		local dropdownFont = CreateFrame("Frame", "NC_GUI_General_DropdownFont", GUIFrame, "UIDropDownMenuTemplate");
		UIDropDownMenu_SetWidth(dropdownFont, 300);
		dropdownFont:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 116, -310);
		local info = {};
		dropdownFont.initialize = function()
			wipe(info);
			for idx, font in next, LibStub("LibSharedMedia-3.0"):List("font") do
				info.text = font;
				info.value = font;
				info.func = function(self)
					db.Font = self.value;
					ReallocateAllIcons(false);
					NC_GUI_General_DropdownFontText:SetText(self:GetText());
				end
				info.checked = font == db.Font;
				UIDropDownMenu_AddButton(info);
			end
		end
		NC_GUI_General_DropdownFontText:SetText(db.Font);
		dropdownFont.text = dropdownFont:CreateFontString("NC_GUI_General_DropdownFontNoteText", "ARTWORK", "GameFontNormalSmall");
		dropdownFont.text:SetPoint("LEFT", 20, 15);
		dropdownFont.text:SetText(L["Font:"]);
		table.insert(GUIFrame.Categories[index], dropdownFont);
	end
	
	function GUICategory_2(index, value)
		local textProfilesCurrentProfile = GUIFrame:CreateFontString("NC_GUIProfilesTextCurrentProfile", "OVERLAY", "GameFontNormal");
		textProfilesCurrentProfile:SetPoint("CENTER", GUIFrame, "LEFT", 300, 130);
		textProfilesCurrentProfile:SetText(format(L["Current profile: [%s]"], LocalPlayerFullName));
		table.insert(GUIFrame.Categories[index], textProfilesCurrentProfile);
		
		local dropdownCopyProfile = CreateFrame("Frame", "NC_GUIProfilesDropdownCopyProfile", GUIFrame, "UIDropDownMenuTemplate");
		UIDropDownMenu_SetWidth(dropdownCopyProfile, 210);
		dropdownCopyProfile:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 120, -80);
		dropdownCopyProfile.text = dropdownCopyProfile:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
		dropdownCopyProfile.text:SetPoint("LEFT", 20, 20);
		dropdownCopyProfile.text:SetText(L["Copy other profile to current profile:"]);
		table.insert(GUIFrame.Categories[index], dropdownCopyProfile);
		
		local buttonCopyProfile = GUICreateButton("NC_GUIProfilesButtonCopyProfile", GUIFrame, L["Copy"]);
		buttonCopyProfile:SetWidth(90);
		buttonCopyProfile:SetHeight(24);
		buttonCopyProfile:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 380, -82);
		buttonCopyProfile:SetScript("OnClick", function(self, ...)
			if (dropdownCopyProfile.myvalue ~= nil) then
				NameplateCooldownsDB[LocalPlayerFullName] = deepcopy(NameplateCooldownsDB[dropdownCopyProfile.myvalue]);
				db = NameplateCooldownsDB[LocalPlayerFullName];
				Print(format(L["Data from '%s' has been successfully copied to '%s'"], dropdownCopyProfile.myvalue, LocalPlayerFullName));
				RebuildDropdowns();
				NC_GUIGeneralSliderIconSize.slider:SetValue(db.IconSize);
				NC_GUIGeneralSliderIconSize.editbox:SetText(tostring(db.IconSize));
				NC_GUIGeneralSliderIconXOffset.slider:SetValue(db.IconXOffset);
				NC_GUIGeneralSliderIconXOffset.editbox:SetText(tostring(db.IconXOffset));
				NC_GUIGeneralSliderIconYOffset.slider:SetValue(db.IconYOffset);
				NC_GUIGeneralSliderIconYOffset.editbox:SetText(tostring(db.IconYOffset));
				for _, v in pairs(GUIFrame.SpellIcons) do
					if (db.CDsTable[v.spellID] == true) then
						v.tex:SetAlpha(1.0);
					else
						v.tex:SetAlpha(0.3);
					end
				end
			end
		end);
		table.insert(GUIFrame.Categories[index], buttonCopyProfile);
		
		local dropdownDeleteProfile = CreateFrame("Frame", "NC_GUIProfilesDropdownDeleteProfile", GUIFrame, "UIDropDownMenuTemplate");
		UIDropDownMenu_SetWidth(dropdownDeleteProfile, 210);
		dropdownDeleteProfile:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 120, -120);
		dropdownDeleteProfile.text = dropdownDeleteProfile:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
		dropdownDeleteProfile.text:SetPoint("LEFT", 20, 20);
		dropdownDeleteProfile.text:SetText(L["Delete profile:"]);
		table.insert(GUIFrame.Categories[index], dropdownDeleteProfile);
		
		local buttonDeleteProfile = GUICreateButton("NC_GUIProfilesButtonDeleteProfile", GUIFrame, L["Delete"]);
		buttonDeleteProfile:SetWidth(90);
		buttonDeleteProfile:SetHeight(24);
		buttonDeleteProfile:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 380, -122);
		buttonDeleteProfile:SetScript("OnClick", function(self, ...)
			if (dropdownDeleteProfile.myvalue ~= nil) then
				NameplateCooldownsDB[dropdownDeleteProfile.myvalue] = nil;
				Print(format(L["Profile '%s' has been successfully deleted"], dropdownDeleteProfile.myvalue));
				RebuildDropdowns();
			end
		end);
		table.insert(GUIFrame.Categories[index], buttonDeleteProfile);
		
		RebuildDropdowns();
	end
	
	function GUICategory_Other(index, value)
		local scrollAreaBackground = CreateFrame("Frame", "NC_GUIScrollFrameBackground_"..tostring(index - 1), GUIFrame);
		scrollAreaBackground:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 120, -60);
		scrollAreaBackground:SetPoint("BOTTOMRIGHT", GUIFrame, "BOTTOMRIGHT", -30, 15);
		scrollAreaBackground:SetBackdrop({
			--bgFile = "Interface\\AddOns\\PVPMaster\\Images\\Smudge.tga",
			edgeFile = "Interface\\AddOns\\PVPMaster\\Images\\Border",
			tile = true, edgeSize = 3, tileSize = 1,
			insets = { left = 3, right = 3, top = 3, bottom = 3 }
		});
		local bRed, bGreen, bBlue = GUIFrame:GetBackdropColor();
		scrollAreaBackground:SetBackdropColor(bRed, bGreen, bBlue, 0.8)
		scrollAreaBackground:SetBackdropBorderColor(0.3, 0.3, 0.5, 1);
		scrollAreaBackground:Hide();
		table.insert(GUIFrame.Categories[index], scrollAreaBackground);
		
		local scrollArea = CreateFrame("ScrollFrame", "NC_GUIScrollFrame_"..tostring(index - 1), scrollAreaBackground, "UIPanelScrollFrameTemplate");
		scrollArea:SetPoint("TOPLEFT", scrollAreaBackground, "TOPLEFT", 5, -5);
		scrollArea:SetPoint("BOTTOMRIGHT", scrollAreaBackground, "BOTTOMRIGHT", -5, 5);
		scrollArea:Show();
		
		local scrollAreaChildFrame = CreateFrame("Frame", "NC_GUIScrollFrameChildFrame_"..tostring(index - 1), scrollArea);
		scrollArea:SetScrollChild(scrollAreaChildFrame);
		scrollAreaChildFrame:SetPoint("CENTER", GUIFrame, "CENTER", 0, 1);
		scrollAreaChildFrame:SetWidth(288);
		scrollAreaChildFrame:SetHeight(288);
		
		local spells = { };
		for spellID in pairs(CDs[value]) do
			local spellName, _, spellIcon = GetSpellInfo(spellID);
			if (spellName ~= nil) then
				table.insert(spells, { ["spellID"] = spellID, ["spellName"] = spellName, ["spellIcon"] = spellIcon });
			else
				Print(format(L["Unknown spell: %s"], spellID));
			end
		end
		table.sort(spells, function(item1, item2) return item1.spellName < item2.spellName end);
		
		local iterator = 1;
		for _, spellInfo in pairs(spells) do
			local spellItem = CreateFrame("button", nil, scrollAreaChildFrame, "SecureActionButtonTemplate");
			spellItem:SetHeight(20);
			spellItem:SetWidth(20);
			spellItem:SetPoint("TOPLEFT", 3, ((iterator - 1) * -22) - 10);
			
			spellItem.tex = spellItem:CreateTexture();
			spellItem.tex:SetAllPoints(spellItem);
			spellItem.tex:SetHeight(20);
			spellItem.tex:SetWidth(20);
			spellItem.tex:SetTexture(spellInfo.spellIcon);
			
			spellItem.Text = spellItem:CreateFontString(nil, "OVERLAY", "GameFontNormal");
			spellItem.Text:SetPoint("LEFT", 22, 0);
			spellItem.Text:SetText(spellInfo.spellName);
			spellItem:EnableMouse(true);
			
			spellItem:SetScript("OnEnter", function(self, ...)
				GameTooltip:SetOwner(spellItem, "ANCHOR_TOPRIGHT");
				GameTooltip:SetSpellByID(spellInfo.spellID);
				GameTooltip:Show();
			end)
			spellItem:SetScript("OnLeave", function(self, ...)
				GameTooltip:Hide();
			end)
			spellItem:SetScript("OnClick", function(self, ...)
				if (self.tex:GetAlpha() > 0.5) then
					db.CDsTable[spellInfo.spellID] = false;
					CDEnabledCache[spellInfo.spellID] = nil;
					self.tex:SetAlpha(0.3);
				else
					db.CDsTable[spellInfo.spellID] = true;
					CDEnabledCache[spellInfo.spellID] = true;
					self.tex:SetAlpha(1.0);
				end
			end)
			if (db.CDsTable[spellInfo.spellID] == true) then
				spellItem.tex:SetAlpha(1.0);
			else
				spellItem.tex:SetAlpha(0.3);
			end
			iterator = iterator + 1;
			spellItem.spellID = spellInfo.spellID;
			tinsert(GUIFrame.SpellIcons, spellItem);
		end
	end
	
	function OnGUICategoryClick(self, ...)
		GUIFrame.CategoryButtons[GUIFrame.ActiveCategory].text:SetTextColor(1, 0.82, 0);
		GUIFrame.CategoryButtons[GUIFrame.ActiveCategory]:UnlockHighlight();
		GUIFrame.ActiveCategory = self.index;
		self.text:SetTextColor(1, 1, 1);
		self:LockHighlight();
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
		ShowGUICategory(GUIFrame.ActiveCategory);
	end
	
	function ShowGUICategory(index)
		for i, v in pairs(GUIFrame.Categories) do
			for k, l in pairs(v) do
				l:Hide();
			end
		end
		for i, v in pairs(GUIFrame.Categories[index]) do
			v:Show();
		end
		if (index > 2) then
			NC_GUIScrollFramesTipText:Show();
		else
			NC_GUIScrollFramesTipText:Hide();
		end
	end
	
	function RebuildDropdowns()
		local info = {};
		NC_GUIProfilesDropdownCopyProfile.myvalue = nil;
		UIDropDownMenu_SetText(NC_GUIProfilesDropdownCopyProfile, "");
		local initCopyProfile = function()
			wipe(info);
			for index in pairs(NameplateCooldownsDB) do
				if (index ~= LocalPlayerFullName) then
					info.text = index;
					info.func = function(self)
						NC_GUIProfilesDropdownCopyProfile.myvalue = index;
						UIDropDownMenu_SetText(NC_GUIProfilesDropdownCopyProfile, index);
					end
					info.notCheckable = true;
					UIDropDownMenu_AddButton(info);
				end
			end
		end
		UIDropDownMenu_Initialize(NC_GUIProfilesDropdownCopyProfile, initCopyProfile);
		
		NC_GUIProfilesDropdownDeleteProfile.myvalue = nil;
		UIDropDownMenu_SetText(NC_GUIProfilesDropdownDeleteProfile, "");
		local initDeleteProfile = function()
			wipe(info);
			for index in pairs(NameplateCooldownsDB) do
				info.text = index;
				info.func = function(self)
					NC_GUIProfilesDropdownDeleteProfile.myvalue = index;
					UIDropDownMenu_SetText(NC_GUIProfilesDropdownDeleteProfile, index);
				end
				info.notCheckable = true;
				UIDropDownMenu_AddButton(info);
			end
		end
		UIDropDownMenu_Initialize(NC_GUIProfilesDropdownDeleteProfile, initDeleteProfile);
	end
	
	function CreateGUICategory()
		local b = CreateFrame("Button", nil, GUIFrame.outline);
		b:SetWidth(92);
		b:SetHeight(18);
		b:SetScript("OnClick", OnGUICategoryClick);
		b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
		b:GetHighlightTexture():SetAlpha(0.7);
		b.text = b:CreateFontString(nil, "ARTWORK", "GameFontNormal");
		b.text:SetPoint("LEFT", 3, 0);
		GUIFrame.CategoryButtons[#GUIFrame.CategoryButtons + 1] = b;
		return b;
	end
	
	function GUICreateSlider(parent, x, y, size, publicName)
		local frame = CreateFrame("Frame", publicName, parent);
		frame:SetHeight(100);
		frame:SetWidth(size);
		frame:SetPoint("TOPLEFT", x, y);

		frame.label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		frame.label:SetPoint("TOPLEFT");
		frame.label:SetPoint("TOPRIGHT");
		frame.label:SetJustifyH("CENTER");
		frame.label:SetHeight(15);
		
		frame.slider = CreateFrame("Slider", nil, frame);
		frame.slider:SetOrientation("HORIZONTAL")
		frame.slider:SetHeight(15)
		frame.slider:SetHitRectInsets(0, 0, -10, 0)
		frame.slider:SetBackdrop({
			bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
			edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
			tile = true, tileSize = 8, edgeSize = 8,
			insets = { left = 3, right = 3, top = 6, bottom = 6 }
		});
		frame.slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
		frame.slider:SetPoint("TOP", frame.label, "BOTTOM")
		frame.slider:SetPoint("LEFT", 3, 0)
		frame.slider:SetPoint("RIGHT", -3, 0)

		frame.lowtext = frame.slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		frame.lowtext:SetPoint("TOPLEFT", frame.slider, "BOTTOMLEFT", 2, 3)

		frame.hightext = frame.slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		frame.hightext:SetPoint("TOPRIGHT", frame.slider, "BOTTOMRIGHT", -2, 3)

		frame.editbox = CreateFrame("EditBox", nil, frame)
		frame.editbox:SetAutoFocus(false)
		frame.editbox:SetFontObject(GameFontHighlightSmall)
		frame.editbox:SetPoint("TOP", frame.slider, "BOTTOM")
		frame.editbox:SetHeight(14)
		frame.editbox:SetWidth(70)
		frame.editbox:SetJustifyH("CENTER")
		frame.editbox:EnableMouse(true)
		frame.editbox:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
			tile = true, edgeSize = 1, tileSize = 5,
		});
		frame.editbox:SetBackdropColor(0, 0, 0, 0.5)
		frame.editbox:SetBackdropBorderColor(0.3, 0.3, 0.30, 0.80)
		frame.editbox:SetScript("OnEscapePressed", function() frame.editbox:ClearFocus(); end)
		frame:Hide();
		return frame;
	end
	
	function GUICreateButton(publicName, parentFrame, text)
		-- After creation we need to set up :SetWidth, :SetHeight, :SetPoint, :SetScript
		local button = CreateFrame("Button", publicName, parentFrame);
		button.Background = button:CreateTexture(nil, "BORDER");
		button.Background:SetPoint("TOPLEFT", 1, -1);
		button.Background:SetPoint("BOTTOMRIGHT", -1, 1);
		button.Background:SetColorTexture(0, 0, 0, 1);

		button.Border = button:CreateTexture(nil, "BACKGROUND");
		button.Border:SetPoint("TOPLEFT", 0, 0);
		button.Border:SetPoint("BOTTOMRIGHT", 0, 0);
		button.Border:SetColorTexture(unpack({0.73, 0.26, 0.21, 1}));

		button.Normal = button:CreateTexture(nil, "ARTWORK");
		button.Normal:SetPoint("TOPLEFT", 2, -2);
		button.Normal:SetPoint("BOTTOMRIGHT", -2, 2);
		button.Normal:SetColorTexture(unpack({0.38, 0, 0, 1}));
		button:SetNormalTexture(button.Normal);

		button.Disabled = button:CreateTexture(nil, "OVERLAY");
		button.Disabled:SetPoint("TOPLEFT", 3, -3);
		button.Disabled:SetPoint("BOTTOMRIGHT", -3, 3);
		button.Disabled:SetColorTexture(0.6, 0.6, 0.6, 0.2);
		button:SetDisabledTexture(button.Disabled);

		button.Highlight = button:CreateTexture(nil, "OVERLAY");
		button.Highlight:SetPoint("TOPLEFT", 3, -3);
		button.Highlight:SetPoint("BOTTOMRIGHT", -3, 3);
		button.Highlight:SetColorTexture(0.6, 0.6, 0.6, 0.2);
		button:SetHighlightTexture(button.Highlight);

		button.Text = button:CreateFontString(publicName.."Text", "OVERLAY", "GameFontNormal");
		button.Text:SetPoint("CENTER", 0, 0);
		button.Text:SetJustifyH("CENTER");
		button.Text:SetTextColor(1, 0.82, 0, 1);
		button.Text:SetText(text);

		button:SetScript("OnMouseDown", function(self) self.Text:SetPoint("CENTER", 1, -1) end);
		button:SetScript("OnMouseUp", function(self) self.Text:SetPoint("CENTER", 0, 0) end);
		return button;
	end
	
end

-------------------------------------------------------------------------------------------------
----- Useful stuff
-------------------------------------------------------------------------------------------------
do

	function Print(...)
		local text = "";
		for i = 1, select("#", ...) do
			text = text..tostring(select(i, ...)).." "
		end
		DEFAULT_CHAT_FRAME:AddMessage(format("NameplateCooldowns: %s", text), 0, 128, 128);
	end

	function deepcopy(object)
		local lookup_table = {}
		local function _copy(object)
			if type(object) ~= "table" then
				return object
			elseif lookup_table[object] then
				return lookup_table[object]
			end
			local new_table = {}
			lookup_table[object] = new_table
			for index, value in pairs(object) do
				new_table[_copy(index)] = _copy(value)
			end
			return setmetatable(new_table, getmetatable(object))
		end
		return _copy(object)
	end
	
	function table_contains_key(t, key)
		for index in pairs(t) do
			if (index == key) then
				return true;
			end
		end
		return false;
	end
	
end

-------------------------------------------------------------------------------------------------
----- Frame for events
-------------------------------------------------------------------------------------------------
EventFrame = CreateFrame("Frame");
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
EventFrame:SetScript("OnEvent", function(self, event, ...)
	if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		COMBAT_LOG_EVENT_UNFILTERED(...);
	elseif (event == "PLAYER_ENTERING_WORLD") then
		PLAYER_ENTERING_WORLD();
	elseif (event == "NAME_PLATE_UNIT_ADDED") then
		NAME_PLATE_UNIT_ADDED(...);
	elseif (event == "NAME_PLATE_UNIT_REMOVED") then
		NAME_PLATE_UNIT_REMOVED(...);
	end
end);

-------------------------------------------------------------------------------------------------
----- Frame for fun
-------------------------------------------------------------------------------------------------
local funFrame = CreateFrame("Frame");
funFrame:RegisterEvent("CHAT_MSG_ADDON");
funFrame:SetScript("OnEvent", function(self, event, ...)
	local prefix, message, channel, sender = ...;
	if (prefix == "NC_prefix") then
		if (string_find(message, "reporting")) then
			local _, toWhom = strsplit(":", message, 2);
			local myName = UnitName("player").."-"..string_gsub(GetRealmName(), " ", "");
			if (toWhom == myName and sender ~= myName) then
				Print(sender.." is using NC");
			end
		elseif (string_find(message, "requesting")) then
			SendAddonMessage("NC_prefix", "reporting:"..sender, channel);
		end
	end
end);
RegisterAddonMessagePrefix("NC_prefix");
