--[[
                                ----o----(||)----oo----(||)----o----

                                     Adorable Raptor Hatchlings

                                       v1.05 - 20th March 2022
                                Copyright (C) Taraezor / Chris Birch

                                ----o----(||)----oo----(||)----o----
]]

local myName, ns = ...
ns.db = {}
-- From Data.lua
ns.points = {}
ns.textures = {}
ns.scaling = {}
-- Purple theme
ns.colour = {}
ns.colour.prefix	= "\124cFF8258FA"
ns.colour.highlight = "\124cFFB19EFF"
ns.colour.plaintext = "\124cFF819FF7"
-- Map IDs. The nests were added in WotLK, even though the locations are original zones
ns.dustwallowMarshID = 70
ns.northernBarrensID = 10
ns.unGoroCraterID = 78
ns.wetlandsID = 56

local defaults = { profile = { icon_scale = 1.4, icon_alpha = 0.8, icon_choice = 1, showCoords = true } }
local continents = {}
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetSubZoneText = _G.GetSubZoneText
local IsControlKeyDown = _G.IsControlKeyDown
local IsIndoors = _G.IsIndoors
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local next = _G.next

local HandyNotes = _G.HandyNotes
local TomTom = _G.TomTom

-- Localisation
ns.locale = GetLocale()
local L = {}
setmetatable( L, { __index = function( L, key ) return key end } )
local realm = GetNormalizedRealmName() -- On a fresh login this will return null
ns.oceania = { AmanThul = true, Barthilas = true, Caelestrasz = true, DathRemar = true,
			Dreadmaul = true, Frostmourne = true, Gundrak = true, JubeiThos = true, 
			Khazgoroth = true, Nagrand = true, Saurfang = true, Thaurissan = true}			
if ns.oceania[realm] then
	ns.locale = "enGB"
end

if ns.locale == "deDE" then
	L["Adorable Raptor Hatchling"] = "Entzückendes Velociraptor-Jungtier"
	L["Adorable Raptor Hatchlings"] = "Entzückende Velociraptor-Jungtiere"
	L["AddOn Description"] = "Hilft Ihnen, die Nester der entzückenden kleinen Velociraptoren zu finden"	
	L["Icon settings"] = "Symboleinstellungen"
	L["Icon Scale"] = "Symbolskalierung"
	L["The scale of the icons"] = "Die Skalierung der Symbole"
	L["Icon Alpha"] = "Symboltransparenz"
	L["The alpha transparency of the icons"] = "Die Transparenz der Symbole"
	L["Icon"] = "Symbol"
	L["Phasing"] = "Synchronisieren"
	L["Raptor egg"] = "Raptor-Ei"
	L["Stars"] = "Sternen"
	L["Purple"] = "Lila"
	L["White"] = "Weiß"
	L["Mana Orb"] = "Manakugel"
	L["Cogwheel"] = "Zahnrad"
	L["Frost"] = "Frost"
	L["Diamond"] = "Diamant"
	L["Red"] = "Rot"
	L["Yellow"] = "Gelb"
	L["Green"] = "Grün"
	L["Screw"] = "Schraube"
	L["Grey"] = "Grau"
	L["Dart's Nest"] = "Pfeils Nest"
	L["Leaping Hatchling"] = "Springendes Jungtier"
	L["Takk's Nest"] = "Takks Nest"
	L["Darting Hatchling"] = "Pfeilschnelles Jungtier"
	L["Under the foliage"] = "Unter dem Laub"
	L["Ravasaur Matriarch's Nest"] = "Nest der Ravasaurusmatriarchin"
	L["Ravasaur Hatchling"] = "Ravasaurusjungtier"
	L["Cave Entrance"] = "Höhle Eingang"
	L["Raptor Ridge"] = "Raptorgrat"
	L["Veer to the right"] = "Biegen Sie nach rechts ab, wenn Sie die Höhle betreten.\nGreifen Sie von rechts auf das Nest zu"
	L["Razormaw Matriarch's Nest"] = "Nest der Scharfzahnmatriarchin"
	L["Razormaw Hatchling"] = "Scharfzähniges Jungtier"
	L["Options"] = "Optionen"
	L["Show Coordinates"] = "Koordinaten anzeigen"
	L["Show Coordinates Description"] = "Zeigen sie die " ..ns.colour.highlight 
		.."koordinaten\124r in QuickInfos auf der Weltkarte und auf der Minikarte an"

elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["Adorable Raptor Hatchling"] = "Adorable cría de Velociraptor"
	L["Adorable Raptor Hatchlings"] = "Adorables crías de Velociraptor"
	L["AddOn Description"] = "Te ayuda a encontrar los nidos de los adorables velociraptores"
	L["Icon settings"] = "Configuración de iconos"
	L["Icon Scale"] = "Escala de icono"
	L["The scale of the icons"] = "La escala de los iconos"
	L["Icon Alpha"] = "Transparencia del icono"
	L["The alpha transparency of the icons"] = "La transparencia alfa de los iconos"
	L["Icon"] = "El icono"
	L["Phasing"] = "Sincronización"	
	L["Raptor egg"] = "Huevo de raptor"	
	L["Stars"] = "Estrellas"
	L["Purple"] = "Púrpura"
	L["White"] = "Blanco"
	L["Mana Orb"] = "Orbe de maná"
	L["Cogwheel"] = "Rueda dentada"
	L["Frost"] = "Escarcha"
	L["Diamond"] = "Diamante"
	L["Red"] = "Rojo"
	L["Yellow"] = "Amarillo"
	L["Green"] = "Verde"
	L["Screw"] = "Tornillo"
	L["Grey"] = "Gris"
	L["Dart's Nest"] = "Nido de Dardo"
	L["Leaping Hatchling"] = "Prole saltarina"
	L["Takk's Nest"] = "Nido de Takk"
	L["Darting Hatchling"] = "Prole flechada"
	L["Under the foliage"] = "Bajo el follaje"
	L["Ravasaur Matriarch's Nest"] = "Nido de matriarca ravasaurio"
	L["Ravasaur Hatchling"] = "Prole de ravasaurio"
	L["Cave Entrance"] = "Entrada de la cueva"
	L["Raptor Ridge"] = "Colina del Raptor"
	L["Veer to the right"] = "Ve a la derecha al entrar en la cueva.\nAccede al nido desde el lado derecho."
	L["Razormaw Matriarch's Nest"] = "Nido de matriarca Tajobuche"
	L["Razormaw Hatchling"] = "Prole Tajobuche"
	L["Options"] = "Opciones"
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Mostrar " ..ns.colour.highlight
		.."coordenadas\124r en información sobre herramientas en el mapa del mundo y en el minimapa"

elseif ns.locale == "frFR" then
	L["Adorable Raptor Hatchling"] = "Adorable vélociraptor petit"
	L["Adorable Raptor Hatchlings"] = "Adorables vélociraptors petits"
	L["AddOn Description"] = "Vous aide à trouver les nids des adorables petits vélociraptors"
	L["Icon settings"] = "Paramètres des icônes"
	L["Icon Scale"] = "Echelle de l’icône"
	L["The scale of the icons"] = "L'échelle des icônes"
	L["Icon Alpha"] = "Transparence de l'icône"
	L["The alpha transparency of the icons"] = "La transparence des icônes"
	L["Icon"] = "L'icône"
	L["Phasing"] = "Synchronisation"
	L["Raptor egg"] = "Œuf de Rapace"
	L["Stars"] = "Étoiles"
	L["Purple"] = "Violet"
	L["White"] = "Blanc"
	L["Mana Orb"] = "Orbe de mana"
	L["Cogwheel"] = "Roue dentée"
	L["Frost"] = "Givre"
	L["Diamond"] = "Diamant"
	L["Red"] = "Rouge"
	L["Yellow"] = "Jaune"
	L["Green"] = "Vert"
	L["Screw"] = "Vis"
	L["Grey"] = "Gris"
	L["Dart's Nest"] = "Nid de Flèche"
	L["Leaping Hatchling"] = "Jeune raptor sauteur"
	L["Takk's Nest"] = "Nid de Takk"
	L["Darting Hatchling"] = "Jeune raptor véloce"
	L["Under the foliage"] = "Sous le feuillage"
	L["Ravasaur Matriarch's Nest"] = "Nid de matriarche ravasaure"
	L["Ravasaur Hatchling"] = "Jeune ravasaure"
	L["Cave Entrance"] = "Entrée Cave"
	L["Raptor Ridge"] = "Crête des Raptors"
	L["Veer to the right"] = "Tournez à droite en entrant dans la grotte.\nAccéder au nid du côté droit"
	L["Razormaw Matriarch's Nest"] = "Nest der Scharfzahnmatriarchin"
	L["Razormaw Hatchling"] = "Scharfzähniges Jungtier"
	L["Options"] = "Options"
	L["Show Coordinates"] = "Afficher les coordonnées"
	L["Show Coordinates Description"] = "Afficher " ..ns.colour.highlight
		.."les coordonnées\124r dans les info-bulles sur la carte du monde et la mini-carte"

elseif ns.locale == "itIT" then
	L["Adorable Raptor Hatchling"] = "Adorabile cucciolo di velociraptor"
	L["Adorable Raptor Hatchlings"] = "adorabili cuccioli di velociraptor"
	L["AddOn Description"] = "Ti aiuta a trovare i nidi degli adorabili piccoli velociraptor"
	L["Icon settings"] = "아이콘 설정"
	L["Icon Scale"] = "Scala delle icone"
	L["The scale of the icons"] = "La scala delle icone"
	L["Icon Alpha"] = "Icona alfa"
	L["The alpha transparency of the icons"] = "La trasparenza alfa delle icone"
	L["Icon"] = "Icona"
	L["Phasing"] = "Sincronizzazione"
	L["Raptor egg"] = "Raptor Uovo"
	L["Stars"] = "Stelle"
	L["Purple"] = "Viola"
	L["White"] = "Bianca"
	L["Mana Orb"] = "Globo di Mana"
	L["Cogwheel"] = "Ruota dentata"
	L["Frost"] = "Gelo"
	L["Diamond"] = "Diamante"
	L["Red"] = "Rosso"
	L["Yellow"] = "Giallo"
	L["Green"] = "Verde"
	L["Screw"] = "Vite"
	L["Grey"] = "Grigio"
	L["Dart's Nest"] = "Nido di Dart"
	L["Leaping Hatchling"] = "Cucciolo Saltante"
	L["Takk's Nest"] = "Nido di Takk"
	L["Darting Hatchling"] = "Miniraptor"
	L["Under the foliage"] = "Sotto il fogliame"
	L["Ravasaur Matriarch's Nest"] = "Nido della Matriarca Devasauro"
	L["Ravasaur Hatchling"] = "Cucciolo di Devasauro"
	L["Cave Entrance"] = "Entrata della grotta"
	L["Raptor Ridge"] = "Dorsale dei Raptor"
	L["Veer to the right"] = "Vira a destra mentre entri nella caverna.\nAccedi al nido dal lato destro"
	L["Razormaw Matriarch's Nest"] = "Nido della Matriarca Boccaguzza"
	L["Razormaw Hatchling"] = "Cucciolo di Boccaguzza"
	L["Options"] = "Opzioni"
	L["Show Coordinates"] = "Mostra coordinate"
	L["Show Coordinates Description"] = "Visualizza " ..ns.colour.highlight
		.."le coordinate\124r nelle descrizioni comandi sulla mappa del mondo e sulla minimappa"

elseif ns.locale == "koKR" then
	L["Adorable Raptor Hatchling"] = "사랑스러운 작은 랩터"
	L["Adorable Raptor Hatchlings"] = "사랑스러운 작은 랩터"
	L["AddOn Description"] = "사랑스러운 작은 벨로시 랩터의 둥지를 찾도록 도와줍니다."
	L["Icon settings"] = "아이콘 설정"
	L["Icon Scale"] = "아이콘 크기 비율"
	L["The scale of the icons"] = "아이콘의 크기 비율입니다"
	L["Icon Alpha"] = "아이콘 투명도"
	L["The alpha transparency of the icons"] = "아이콘의 투명도입니다"
	L["Icon"] = "아이콘"
	L["Phasing"] = "동기화 중"
	L["Raptor egg"] = "랩터의 알"
	L["Stars"] = "별"
	L["Purple"] = "보라색"
	L["White"] = "화이트"
	L["Mana Orb"] = "마나 보주"
	L["Cogwheel"] = "톱니 바퀴"
	L["Frost"] = "냉기"
	L["Diamond"] = "다이아몬드"
	L["Red"] = "빨간"
	L["Yellow"] = "노랑"
	L["Green"] = "녹색"
	L["Screw"] = "나사"
	L["Grey"] = "회색"
	L["Dart's Nest"] = "바람뿔의 둥지"
	L["Leaping Hatchling"] = "새끼 도약랩터"
	L["Takk's Nest"] = "타크의 둥지"
	L["Darting Hatchling"] = "새끼 화살랩터"
	L["Under the foliage"] = "언더 리프"
	L["Ravasaur Matriarch's Nest"] = "우두머리 라바사우루스 둥지"
	L["Ravasaur Hatchling"] = "새끼 라바사우루스"
	L["Cave Entrance"] = "동굴 입구"
	L["Raptor Ridge"] = "랩터 마루"
	L["Veer to the right"] = "동굴에 들어서 자 오른쪽으로 향하십시오.\n오른쪽에서 둥지에 액세스하십시오."
	L["Razormaw Matriarch's Nest"] = "무쇠턱 우두머리랩터의 둥지"
	L["Razormaw Hatchling"] = "새끼 고원랩터"
	L["Options"] = "설정"
	L["Show Coordinates"] = "좌표 표시"
	L["Show Coordinates Description"] = "세계지도 및 미니지도의 도구 설명에 " ..ns.colour.highlight .."좌표를\124r 표시합니다."
		
elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["Adorable Raptor Hatchling"] = "Adorável ​​filhote velociraptore"
	L["Adorable Raptor Hatchlings"] = "adoráveis ​​filhotes velociraptores"
	L["AddOn Description"] = "Ajuda você a encontrar os ninhos dos adoráveis ​​pequenos velociraptors"
	L["Icon settings"] = "Configurações de ícone"
	L["Icon Scale"] = "Escala de Ícone"
	L["The scale of the icons"] = "A escala dos ícones"
	L["Icon Alpha"] = "Ícone Alpha"
	L["The alpha transparency of the icons"] = "A transparência alfa dos ícones"
	L["Icon"] = "Ícone"
	L["Phasing"] = "Sincronização"
	L["Raptor egg"] = "Ovo de raptor"
	L["Stars"] = "Estrelas"
	L["Purple"] = "Roxa"
	L["White"] = "Branco"
	L["Mana Orb"] = "Orbe de Mana"
	L["Cogwheel"] = "Roda dentada"
	L["Frost"] = "Gélido"
	L["Diamond"] = "Diamante"
	L["Red"] = "Vermelho"
	L["Yellow"] = "Amarelo"
	L["Green"] = "Verde"
	L["Screw"] = "Parafuso"
	L["Grey"] = "Cinzento"
	L["Dart's Nest"] = "Ninho da Saltadora"
	L["Leaping Hatchling"] = "Raptinho Saltitante"
	L["Takk's Nest"] = "Ninho de Takk"
	L["Darting Hatchling"] = "Dartinho"
	L["Under the foliage"] = "Sob as folhas"
	L["Ravasaur Matriarch's Nest"] = "Ninho da Matriarca Ravassauro"
	L["Ravasaur Hatchling"] = "Ravassaurinho"
	L["Cave Entrance"] = "Entrada da caverna"
	L["Raptor Ridge"] = "Serra dos Raptores"
	L["Veer to the right"] = "Vire para a direita ao entrar na caverna.\nAcesse o ninho pelo lado direito"
	L["Razormaw Matriarch's Nest"] = "Ninho da Matriarca Rasgaqueixo"
	L["Razormaw Hatchling"] = "Raptinho Rasgaqueixo"
	L["Options"] = "Opções"
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Exibir " ..ns.colour.highlight
		.."coordenadas\124r em dicas de ferramentas no mapa mundial e no minimapa"

elseif ns.locale == "ruRU" then
	L["Adorable Raptor Hatchling"] = "Очаровательный Mаленький Велоцираптор"
	L["Adorable Raptor Hatchlings"] = "Очаровательные Mаленькие Велоцирапторы"
	L["AddOn Description"] = "Помогает найти гнезда очаровательных маленьких велоцирапторов"
	L["Icon settings"] = "Настройки Значков"
	L["Icon Scale"] = "Масштаб Значок"
	L["The scale of the icons"] = "Масштаб для Значков"
	L["Icon Alpha"] = "Альфа Значок"
	L["The alpha transparency of the icons"] = "Альфа-прозрачность для Значков"
	L["Icon"] = "Значок"
	L["Phasing"] = "Синхронизация"
	L["Raptor egg"] = "Яйцо ящера"
	L["Stars"] = "Звезды"
	L["Purple"] = "Пурпурный"
	L["White"] = "белый"
	L["Mana Orb"] = "Cфера маны"
	L["Cogwheel"] = "Зубчатое колесо"
	L["Frost"] = "Лед"
	L["Diamond"] = "Ромб"
	L["Red"] = "Красный"
	L["Yellow"] = "Желтый"
	L["Green"] = "Зеленый"
	L["Screw"] = "Винт"
	L["Grey"] = "Серый"
	L["Dart's Nest"] = "Гнездо Дарта"
	L["Leaping Hatchling"] = "Прыгающий детеныш"
	L["Takk's Nest"] = "Гнездо Такка"
	L["Darting Hatchling"] = "Стремительный детеныш"
	L["Under the foliage"] = "Под листьями"
	L["Ravasaur Matriarch's Nest"] = "Гнездо равазавра-матриарха"
	L["Ravasaur Hatchling"] = "Детеныш равазавра"
	L[ "Cave Entrance" ] = "Вход в пещеру"
	L["Raptor Ridge"] = "Гряда Ящеров"
	L["Veer to the right"] = "Поверните направо, когда вы входите в пещеру.\nДоступ к гнезду с правой стороны"
	L["Razormaw Matriarch's Nest"] = "Гнездо острозуба-матриарха"
	L["Razormaw Hatchling"] = "Детеныш острозуба"
	L["Options"] = "Параметры"
	L["Show Coordinates"] = "Показать Координаты"
	L["Show Coordinates Description"] = "Отображает " ..ns.colour.highlight
		.."координаты\124r во всплывающих подсказках на карте мира и мини-карте"

elseif ns.locale == "zhCN" then
	L["Adorable Raptor Hatchling"] = "可爱的迅猛龙宝宝"
	L["Adorable Raptor Hatchlings"] = "可爱的迅猛龙宝宝"
	L["AddOn Description"] = "帮助您找到可爱的小迅猛龙的巢."
	L["Icon settings"] = "图标设置"
	L["Icon Scale"] = "图示大小"
	L["The scale of the icons"] = "图示的大小"
	L["Icon Alpha"] = "图示透明度"
	L["The alpha transparency of the icons"] = "图示的透明度"
	L["Icon"] = "图示"
	L["Phasing"] = "同步"
	L["Raptor egg"] = "迅猛龙蛋"
	L["Stars"] = "星星"
	L["Purple"] = "紫色"
	L["White"] = "白色"
	L["Mana Orb"] = "法力球"
	L["Cogwheel"] = "齿轮"
	L["Frost"] = "冰霜"
	L["Diamond"] = "钻石"
	L["Red"] = "红"
	L["Yellow"] = "黄色"
	L["Green"] = "绿色"
	L["Screw"] = "拧"
	L["Grey"] = "灰色"
	L["Dart's Nest"] = "达尔特的巢"
	L["Leaping Hatchling"] = "小塔克"
	L["Takk's Nest"] = "塔克的巢"
	L["Darting Hatchling"] = "小达尔特"
	L["Under the foliage"] = "在树叶下"
	L["Ravasaur Matriarch's Nest"] = "暴掠龙女王的巢"
	L["Ravasaur Hatchling"] = "暴掠幼龙"
	L["Cave Entrance"] = "洞入口"
	L["Raptor Ridge"] = "恐龙岭"
	L["Veer to the right"] = "当你进入洞穴时向右转。\n从右侧进入巢穴"
	L["Razormaw Matriarch's Nest"] = "刺喉雌龙的巢"
	L["Razormaw Hatchling"] = "刺喉幼龙"
	L["Options"] = "选项"
	L["Show Coordinates"] = "显示坐标"
	L["Show Coordinates Description"] = "在世界地图和迷你地图上的工具提示中" ..ns.colour.highlight .."显示坐标"

elseif ns.locale == "zhTW" then
	L["Adorable Raptor Hatchling"] = "可愛的迅猛龍寶寶"
	L["Adorable Raptor Hatchlings"] = "可愛的迅猛龍寶寶"
	L["AddOn Description"] = "幫助您找到可愛的小迅猛龍的巢."
	L["Icon settings"] = "圖標設置"
	L["Icon Scale"] = "圖示大小"
	L["The scale of the icons"] = "圖示的大小"
	L["Icon Alpha"] = "圖示透明度"
	L["The alpha transparency of the icons"] = "圖示的透明度"
	L["Icon"] = "圖示"
	L["Phasing"] = "同步"
	L["Raptor egg"] = "迅猛龍蛋"
	L["Stars"] = "星星"
	L["Purple"] = "紫色"
	L["White"] = "白色"
	L["Mana Orb"] = "法力球"
	L["Cogwheel"] = "齒輪"
	L["Frost"] = "霜"
	L["Diamond"] = "钻石"
	L["Red"] = "紅"
	L["Yellow"] = "黃色"
	L["Green"] = "綠色"
	L["Screw"] = "擰"
	L["Grey"] = "灰色"
	L["Dart's Nest"] = "達爾特的巢"
	L["Leaping Hatchling"] = "小塔克"
	L["Takk's Nest"] = "塔克的巢"
	L["Darting Hatchling"] = "小達爾特"
	L["Under the foliage"] = "在樹葉下"
	L["Ravasaur Matriarch's Nest"] = "暴掠龍女王的巢"
	L["Ravasaur Hatchling"] = "暴掠幼龍"
	L["Cave Entrance"] = "洞入口"
	L["Raptor Ridge"] = "恐龍嶺"
	L["Veer to the right"] = "當你進入洞穴時向右轉。\n從右側進入巢穴"
	L["Razormaw Matriarch's Nest"] = "刺喉雌龍的巢"
	L["Razormaw Hatchling"] = "刺喉幼龍"
	L["Options"] = "選項"
	L["Show Coordinates"] = "顯示坐標"
	L["Show Coordinates Description"] = "在世界地圖和迷你地圖上的工具提示中" ..ns.colour.highlight .."顯示坐標"
	
else
	if ns.locale == "enUS" then
		L["Grey"] = "Gray"
	end
	L["AddOn Description"] = "Helps you find the nests of the adorable little velociraptors"
	L["Veer to the right"] = "Veer to the right as you enter the cave.\nAccess the nest from the right side"
	L["Show Coordinates Description"] = "Display coordinates in tooltips on the world map and the mini map"
	
end

-- I use this for debugging
local function printPC( message )
	if message then
		DEFAULT_CHAT_FRAME:AddMessage( ns.colour.prefix .."ARH" ..": " ..ns.colour.plaintext
			..message.. "\124r" )
	end
end

-- Plugin handler for HandyNotes
local function infoFromCoord(mapFile, coord)
	local point = ns.points[mapFile] and ns.points[mapFile][coord]
	return point[1], point[2], point[3], point[4]
end

function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local nest, hatchling, eggID, tip = infoFromCoord(mapFile, coord)

	GameTooltip:SetText( ns.colour.prefix ..L[nest] )
	GameTooltip:AddLine( ns.colour.highlight ..L[hatchling] )
	if tip then
		GameTooltip:AddLine( L[tip] )
	end
	
	if ns.db.showCoords == true then
		local mX, mY = HandyNotes:getXY(coord)
		mX, mY = mX*100, mY*100
		GameTooltip:AddLine( ns.colour.highlight .."(" ..format( "%.02f", mX ) .."," ..format( "%.02f", mY ) ..")" )
	end

	if TomTom then
		GameTooltip:AddLine("Right-click to set a waypoint", 1, 1, 1)
		GameTooltip:AddLine("Control-Right-click to set waypoints to every " ..L["Adorable Raptor Hatchling"], 1, 1, 1)
	end

	GameTooltip:Show()
end

function pluginHandler:OnLeave()
	GameTooltip:Hide()
end

local function createWaypoint(mapID, coord)
	local x, y = HandyNotes:getXY(coord)
	TomTom:AddWaypoint(mapID, x, y, { title = L["Adorable Raptor Hatchling"], persistent = nil, minimap = true, world = true })
end

local function createAllWaypoints()
	for mapFile, coords in next, ns.points do
		if not continents[mapFile] then
			for coord in next, coords do
				if coord then
					createWaypoint(mapFile, coord)
				end
			end
		end
	end
	TomTom:SetClosestWaypoint()
end

function pluginHandler:OnClick(button, down, mapFile, coord)
	if TomTom and button == "RightButton" and not down then
		if IsControlKeyDown() then
			createAllWaypoints()
		else
			createWaypoint(mapFile, coord)
		end
	end
end

do
	continents[12] = true	-- Kalimdor
	continents[13] = true	-- Eastern Kingdoms

    local bucket = CreateFrame("Frame")
    bucket.elapsed = 0
    bucket:SetScript("OnUpdate", function(self, elapsed)
        self.elapsed = self.elapsed + elapsed
        if self.elapsed > 1.5 then
            self.elapsed = 0
			local insideCave = ( GetSubZoneText() == L["Raptor Ridge"] and IsIndoors() ) and true or false
			if ns.insideCave == nil then
				ns.insideCave = insideCave
			elseif ns.insideCave ~= insideCave then
				ns.insideCave = insideCave
				pluginHandler:Refresh()
			end
        end
    end)

	if ns.insideCave == nil then
		ns.insideCave = ( GetSubZoneText() == L["Raptor Ridge"] and IsIndoors() ) and true or false
	end

	local function iterator(t, prev)
		if not t then return end
		local coord, v = next(t, prev)
		while coord do
			if v then
				-- Wetlands special: Show the cave entrance if outside the cave, otherwise show the actual location once inside the cave
				if v[1] == "Razormaw Matriarch's Nest" then
					if ns.insideCave == true then
						return coord, nil, ns.textures[ns.db.icon_choice], ns.db.icon_scale * ns.scaling[ns.db.icon_choice], ns.db.icon_alpha
					end
				elseif v[1] == "Cave Entrance" then
					if ns.insideCave == false then
						return coord, nil, ns.textures[ns.db.icon_choice], ns.db.icon_scale * ns.scaling[ns.db.icon_choice], ns.db.icon_alpha
					end
				else
					if ns.insideCave == false then
						return coord, nil, ns.textures[ns.db.icon_choice], ns.db.icon_scale * ns.scaling[ns.db.icon_choice], ns.db.icon_alpha
					end
				end
			end
			coord, v = next(t, coord)
		end
	end
	function pluginHandler:GetNodes2(mapID)
		return iterator, ns.points[mapID]
	end
end

-- Interface -> Addons -> Handy Notes -> Plugins -> Adorable Raptor Hatchlings options
ns.options = {
	type = "group",
	name = L["Adorable Raptor Hatchlings"],
	desc = L["AddOn Description"],
	get = function(info) return ns.db[info[#info]] end,
	set = function(info, v)
		ns.db[info[#info]] = v
		pluginHandler:Refresh()
	end,
	args = {
		icon = {
			type = "group",
			name = L["Icon settings"],
			inline = true,
			args = {
				icon_scale = {
					type = "range",
					name = L["Icon Scale"],
					desc = L["The scale of the icons"],
					min = 0.25, max = 2, step = 0.01,
					arg = "icon_scale",
					order = 2,
				},
				icon_alpha = {
					type = "range",
					name = L["Icon Alpha"],
					desc = L["The alpha transparency of the icons"],
					min = 0, max = 1, step = 0.01,
					arg = "icon_alpha",
					order = 3,
				},
				icon_choice = {
					type = "range",
					name = L["Icon"],
					desc = "1 = " ..L["Phasing"] .."\n2 = " ..L["Raptor egg"] .."\n3 = " ..L["Stars"] .."\n4 = " ..L["Purple"] 
							.."\n5 = " ..L["White"] .."\n6 = " ..L["Mana Orb"] .."\n7 = " ..L["Cogwheel"] .."\n8 = " ..L["Frost"] 
							.."\n9 = " ..L["Diamond"] .."\n10 = " ..L["Red"] .."\n11 = " ..L["Yellow"] .."\n12 = " ..L["Green"] 
							.."\n13 = " ..L["Screw"] .."\n14 = " ..L["Grey"],
					min = 1, max = 14, step = 1,
					arg = "icon_choice",
					order = 4,
				},
			},
		},
		options = {
			type = "group",
			name = L["Options"],
			inline = true,
			args = {
				showCoords = {
					name = L["Show Coordinates"],
					desc = L["Show Coordinates Description"] 
							..ns.colour.highlight .."\n(xx.xx,yy.yy)",
					type = "toggle",
					width = "full",
					arg = "showCoords",
					order = 5,
				},
			},
		},
	},
}

function pluginHandler:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then
		printPC("HandyNotes is out of date")
		return
	end
	for continentMapID in next, continents do
		local children = C_Map.GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			local coords = ns.points[map.mapID]
			if coords then
				for coord, criteria in next, coords do
					local mx, my = HandyNotes:getXY(coord)
					local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, map.mapID, continentMapID)
					if cx and cy then
						ns.points[continentMapID] = ns.points[continentMapID] or {}
						ns.points[continentMapID][HandyNotes:getCoord(cx, cy)] = criteria
					end
				end
			end
		end
	end
	HandyNotes:RegisterPluginDB("AdorableRaptorHatchlings", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_AdorableRaptorHatchlingsDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "AdorableRaptorHatchlings")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_AdorableRaptorHatchlingsDB", "AceEvent-3.0")