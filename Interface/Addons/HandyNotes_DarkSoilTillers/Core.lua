--[[
                                ----o----(||)----oo----(||)----o----

                                              Dark Soil

                                       v1.06 - 20th March 2022
                                Copyright (C) Taraezor / Chris Birch

                                ----o----(||)----oo----(||)----o----
]]

local myName, ns = ...
ns.db = {}
-- From Data.lua
ns.points = {}
ns.textures = {}
ns.scaling = {}
ns.texturesSpecial = {}
ns.scalingSpecial = {}
-- Brown theme
ns.colour = {}
ns.colour.prefix	= "\124cFFD2691E"	-- X11Chocolate
ns.colour.highlight = "\124cFFF4A460"	-- X11SandyBrown
ns.colour.plaintext = "\124cFFDEB887"	-- X11BurlyWood
-- Map IDs
ns.pandaria = 424
ns.votfw = 376

--ns.author = true

local defaults = { profile = { icon_scale = 1.4, icon_alpha = 0.8, icon_choice = 10, icon_choiceSpecial = 1, 
								icon_choiceBonus = 8, showCoords = true } }
local continents = {}
local pluginHandler = {}

-- upvalues
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetFriendshipReputation = GetFriendshipReputation
local IsControlKeyDown = _G.IsControlKeyDown
local LibStub = _G.LibStub
local UIParent = _G.UIParent
local format = _G.format
local next = _G.next
local select = _G.select

local HandyNotes = _G.HandyNotes

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
	L["Dark Soil"] = "Dunkle Erde"
	L["Under the foliage"] = "Unter dem Laub"
	L["Under the hut"] = "Unter der Hütte"
	L["Under the hut's\nnorthern side ramp"] = "Unter der Nordseite der Hütte"
	L["Under the trees.\nVery difficult to see"] = "Unter den Bäumen.\nSehr schwer zu sehen"
	L["Under the tree, at\nthe edge of the lake"] = "Unter dem Baum,\nam Rande des Sees"
	L["Under the water tower"] = "Unter dem Wasserturm"
	L["Under the tree.\nIn front of Thunder"] = "Unter dem Baum.\nVor Thunnnder"
	L["Under the bridge"] = "Unter der Brücke"
	L["Inside the building"] = "Im Gebäude"
	L["Sho"] = "Sho"
	L["Old Hillpaw"] = "Der alte Hügelpranke"
	L["Ella"] = "Ella"
	L["Chee Chee"] = "Chi-Chi"
	L["Fish Fellreed"] = "Fischi Rohrroder"
	L["Haohan Mudclaw"] = "Haohan Lehmkrall"
	L["Tina Mudclaw"] = "Tina Lehmkrall"
	L["Farmer Fung"] = "Bauer Fung"
	L["Jogu the Drunk"] = "Jogu der Betrunkene"
	L["Gina Mudclaw"] = "Gina Lehmkrall"
	L["Crystal of Insanity"] = "Kristall des Wahnsinns"
	L["Blackhoof"] = "Schwarzhuf"
	L["Battle Horn"] = "Schlachthorn"
	L["Ghostly Pandaren Craftsman"] = "Geisterhafter Pandarenhandwerker"
	L["AddOn Description"] = "Hilft dir, die " ..ns.colour.highlight .."Dunkle Erde" .."\124r zu finden"
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
	L["Options"] = "Optionen"
	L["NPC"] = "NSC"
	L["Gold Ring"] = "Goldener Ring"
	L["Red Cross"] = "Rotes Kreuz"
	L["Undo"] = "Rückgängig machen"
	L["White Diamond"] = "Weißer Diamant"
	L["Copper Diamond"] = "Kupfer Diamant"
	L["Red Ring"] = "Roter Ring"
	L["Blue Ring"] = "Blauer Ring"
	L["Green Ring"] = "Grüner Ring"
	L["Show Coordinates"] = "Koordinaten anzeigen"
	L["Show Coordinates Description"] = "Zeigen sie die " ..ns.colour.highlight 
		.."koordinaten\124r in QuickInfos auf der Weltkarte und auf der Minikarte an"
	
elseif ns.locale == "esES" or ns.locale == "esMX" then
	L["Dark Soil"] = "Tierra Oscura"
	L["Under the foliage"] = "Bajo el follaje"
	L["Under the hut"] = "Bajo la choza"
	L["Under the hut's\nnorthern side ramp"] = "Bajo la rampa del lado\nnorte de la choza"
	L["Under the trees.\nVery difficult to see"] = "Bajo los árboles.\nMuy difícil de ver"
	L["Under the tree, at\nthe edge of the lake"] = "Bajo el árbol,\nen el borde del lago"
	L["Under the water tower"] = "Bajo la torre de agua"
	L["Under the tree.\nIn front of Thunder"] = "Debajo del árbol. Delante de Trueno"
	L["Under the bridge"] = "Bajo el puente"
	L["Inside the building"] = "Dentro del edificio"
	L["Sho"] = "Sho"
	L["Old Hillpaw"] = "Viejo Zarpa Collado"
	L["Ella"] = "Ella"
	L["Chee Chee"] = "Chee Chee"
	L["Fish Fellreed"] = "Pez Junco Talado"
	L["Haohan Mudclaw"] = "Haohan Zarpa Fangosa"
	L["Tina Mudclaw"] = "Tina Zarpa Fangosa"
	L["Farmer Fung"] = "Granjero Fung"
	L["Jogu the Drunk"] = "Jogu el Ebrio"
	L["Gina Mudclaw"] = "Gina Zarpa Fangosa"
	L["Crystal of Insanity"] = "Cristal de locura"
	L["Blackhoof"] = "Pezuña Negra"
	L["Battle Horn"] = "Cuerno de batalla"
	L["Ghostly Pandaren Craftsman"] = "Artesano pandaren fantasmal"
	L["AddOn Description"] = "Ayuda a encontrar los " ..ns.colour.highlight .."Tierra Oscura"
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
	L["Options"] = "Opciones"
	L["NPC"] = "PNJ"
	L["Gold Ring"] = "Anillo de oro"
	L["Red Cross"] = "Rotes kreuz"
	L["Undo"] = "Deshacer"
	L["White Diamond"] = "Diamante blanco"
	L["Copper Diamond"] = "Diamante de cobre"
	L["Red Ring"] = "Rojo Anillo"
	L["Blue Ring"] = "Azul Anillo"
	L["Green Ring"] = "Verde Anillo"	
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Mostrar " ..ns.colour.highlight
		.."coordenadas\124r en información sobre herramientas en el mapa del mundo y en el minimapa"

elseif ns.locale == "frFR" then
	L["Dark Soil"] = "Terre Sombre"
	L["Under the foliage"] = "Sous le feuillage"
	L["Under the hut"] = "Sous la cabane"
	L["Under the hut's\nnorthern side ramp"] = "Sous la rampe côté\nnord de la cabane"
	L["Under the trees.\nVery difficult to see"] = "Sous les arbres.\nTrès difficile à voir"
	L["Under the tree, at\nthe edge of the lake"] = "Sous l'arbre,\nau bord du lac"
	L["Under the water tower"] = "Sous la tour d'eau"
	L["Under the tree.\nIn front of Thunder"] = "Sous l'arbre. Devant Tonnerre"
	L["Under the bridge"] = "Sous le pont"
	L["Inside the building"] = "À l'intérieur du bâtiment"
	L["Sho"] = "Sho"
	L["Old Hillpaw"] = "Vieux Patte des Hauts"
	L["Ella"] = "Ella"
	L["Chee Chee"] = "Chii Chii"
	L["Fish Fellreed"] = "Marée Pelage de Roseau"
	L["Haohan Mudclaw"] = "Haohan Griffe de Tourbe"
	L["Tina Mudclaw"] = "Tina Griffe de Tourbe"
	L["Farmer Fung"] = "Fermier Fung"
	L["Jogu the Drunk"] = "Jogu l’Ivrogne"
	L["Gina Mudclaw"] = "Gina Griffe de Tourbe"
	L["Crystal of Insanity"] = "Cristal de démence"
	L["Blackhoof"] = "Sabot d’Encre"
	L["Battle Horn"] = "Cor de bataille"
	L["Ghostly Pandaren Craftsman"] = "Artisan pandaren fantomatique"
	L["AddOn Description"] = "Aide à trouver les " ..ns.colour.highlight .."Terre Sombre"
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
	L["Options"] = "Options"
	L["NPC"] = "PNJ"
	L["Gold Ring"] = "Bague en or"
	L["Red Cross"] = "Croix rouge"
	L["Undo"] = "Annuler"
	L["White Diamond"] = "Diamant blanc"
	L["Copper Diamond"] = "Diamant de cuivre"
	L["Red Ring"] = "Anneau rouge"
	L["Blue Ring"] = "Anneau bleue"
	L["Green Ring"] = "Anneau vert"	
	L["Show Coordinates"] = "Afficher les coordonnées"
	L["Show Coordinates Description"] = "Afficher " ..ns.colour.highlight
		.."les coordonnées\124r dans les info-bulles sur la carte du monde et la mini-carte"

elseif ns.locale == "itIT" then
	L["Dark Soil"] = "Terreno Smosso"
	L["Under the foliage"] = "Sotto il fogliame"
	L["Under the hut"] = "Sotto la capanna"
	L["Under the hut's\nnorthern side ramp"] = "Sotto la rampa laterale nord della capanna"
	L["Under the trees.\nVery difficult to see"] = "Sotto gli alberi.\nMolto difficile da vedere"
	L["Under the tree, at\nthe edge of the lake"] = "Sotto l'albero,\nai margini del lago"
	L["Under the water tower"] = "Sotto la torre dell'acqua"
	L["Under the tree.\nIn front of Thunder"] = "Sotto l'albero.\nDi fronte a Tuono"
	L["Under the bridge"] = "Sotto il ponte"
	L["Inside the building"] = "All'interno dell'edificio"
	L["Sho"] = "Sho"
	L["Old Hillpaw"] = "Vecchio Zampa Brulla"
	L["Ella"] = "Ella"
	L["Chee Chee"] = "Ghi Ghi"
	L["Fish Fellreed"] = "Trota Mezza Canna"
	L["Haohan Mudclaw"] = "Haohan Palmo Florido"
	L["Tina Mudclaw"] = "Tina Palmo Florido"
	L["Farmer Fung"] = "Contadino Fung"
	L["Jogu the Drunk"] = "Jogu l'Ubriaco"
	L["Gina Mudclaw"] = "Gina Palmo Florido"
	L["Crystal of Insanity"] = "Cristallo della Pazzia"
	L["Blackhoof"] = "Zoccolo Nero"
	L["Battle Horn"] = "Corno da Battaglia"
	L["Ghostly Pandaren Craftsman"] = "Artigiano Spettrale Pandaren"
	L["AddOn Description"] = "Aiuta a trovare le " ..ns.colour.highlight .."Terreno Smosso"
	L["Icon settings"] = "Impostazioni icona"
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
	L["Options"] = "Opzioni"
	L["NPC"] = "PNG"
	L["Gold Ring"] = "Anello d'oro"
	L["Red Cross"] = "Croce rossa"
	L["Undo"] = "Disfare"
	L["White Diamond"] = "Diamante bianco"
	L["Copper Diamond"] = "Diamante di rame"
	L["Red Ring"] = "Anello rosso"
	L["Blue Ring"] = "Anello blu"
	L["Green Ring"] = "Anello verde"
	L["Show Coordinates"] = "Mostra coordinate"
	L["Show Coordinates Description"] = "Visualizza " ..ns.colour.highlight
		.."le coordinate\124r nelle descrizioni comandi sulla mappa del mondo e sulla minimappa"

elseif ns.locale == "koKR" then
	L["Dark Soil"] = "검은 토양"
	L["Under the foliage"] = "단풍 아래서"
	L["Under the hut"] = "오두막 아래서"
	L["Under the hut's\nnorthern side ramp"] = "오두막의 북쪽 경사로 아래"
	L["Under the trees.\nVery difficult to see"] = "나무 밑. 보기가 매우 어렵다."
	L["Under the tree, at\nthe edge of the lake"] = "나무 밑. 호수 가장자리."
	L["Under the water tower"] = "수상 탑 아래"
	L["Under the tree.\nIn front of Thunder"] = "나무 아래. 우레 앞에서."
	L["Under the bridge"] = "다리 아래"
	L["Inside the building"] = "건물 내부"
	L["Sho"] = "쇼"
	L["Old Hillpaw"] = "늙은 힐포우"
	L["Ella"] = "엘라"
	L["Chee Chee"] = "치 치"
	L["Fish Fellreed"] = "피시 펠리드"
	L["Haohan Mudclaw"] = "하오한 머드클로"
	L["Tina Mudclaw"] = "티나 머드클로"
	L["Farmer Fung"] = "농부 펑"
	L["Jogu the Drunk"] = "주정뱅이 조구"
	L["Gina Mudclaw"] = "지나 머드클로"
	L["Sulik'shor"] = "술리크쇼르"
	L["Crystal of Insanity"] = "광기의 수정"
	L["Blackhoof"] = "블랙후프"
	L["Battle Horn"] = "전투 뿔피리"
	L["Ghostly Pandaren Craftsman"] = "유령 판다렌 장인"
	L["AddOn Description"] = ns.colour.highlight .."검은 토양\124r 를 찾을 수 있도록 도와줍니다"
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
	L["Options"] = "설정"
	L["Gold Ring"] = "금반지"
	L["Red Cross"] = "국제 적십자사"
	L["Undo"] = "끄르다"
	L["White Diamond"] = "화이트 다이아몬드"
	L["Copper Diamond"] = "구리 다이아몬드"
	L["Red Ring"] = "빨간 반지"
	L["Blue Ring"] = "파란색 반지"
	L["Green Ring"] = "녹색 반지"
	L["Show Coordinates"] = "좌표 표시"
	L["Show Coordinates Description"] = "세계지도 및 미니지도의 도구 설명에 좌표를 표시합니다."

elseif ns.locale == "ptBR" or ns.locale == "ptPT" then
	L["Dark Soil"] = "Solo Negro"
	L["Under the foliage"] = "Sob a folhagem"
	L["Under the hut"] = "Debaixo da cabana"
	L["Under the hut's\nnorthern side ramp"] = "Sob a rampa do lado norte da cabana"
	L["Under the trees.\nVery difficult to see"] = "Sob as árvores.\nMuito difícil de ver"
	L["Under the tree, at\nthe edge of the lake"] = "Debaixo da árvore,\nà beira do lago"
	L["Under the water tower"] = "Sob a torre de água"
	L["Under the tree.\nIn front of Thunder"] = "Debaixo da árvore. Na frente de Trovão"
	L["Under the bridge"] = "Debaixo da ponte"
	L["Inside the building"] = "Dentro do prédio"
	L["Sho"] = "Sho"
	L["Old Hillpaw"] = "Velho Pata do Monte"
	L["Ella"] = "Ella"
	L["Chee Chee"] = "Tchi Tchi"
	L["Fish Fellreed"] = "Peixe Cana Alta"
	L["Haohan Mudclaw"] = "Haohan Garra de Barro"
	L["Tina Mudclaw"] = "Tina Garra de Barro"
	L["Farmer Fung"] = "Fazendeiro Fung"
	L["Jogu the Drunk"] = "Be Bum, o Ébrio"
	L["Gina Mudclaw"] = "Gina Garra de Barro"
	L["Crystal of Insanity"] = "Cristal da Insanidades"
	L["Blackhoof"] = "Casco Negro"
	L["Battle Horn"] = "Trombeta de Batalha"
	L["Ghostly Pandaren Craftsman"] = "Artesão Pandaren Fantasmagórico"
	L["AddOn Description"] = "Ajuda você a localizar " ..ns.colour.highlight .."Solo Negro"
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
	L["Options"] = "Opções"
	L["NPC"] = "PNJ"
	L["Gold Ring"] = "Anel de ouro"
	L["Red Cross"] = "Cruz vermelha"
	L["Undo"] = "Desfazer"
	L["White Diamond"] = "Diamante branco"
	L["Copper Diamond"] = "Diamante de cobre"
	L["Red Ring"] = "Anel vermelho"
	L["Blue Ring"] = "Anel azul"
	L["Green Ring"] = "Anel verde"
	L["Show Coordinates"] = "Mostrar coordenadas"
	L["Show Coordinates Description"] = "Exibir " ..ns.colour.highlight
		.."coordenadas\124r em dicas de ferramentas no mapa mundial e no minimapa"

elseif ns.locale == "ruRU" then
	L["Dark Soil"] = "Темная Земля"
	L["Under the foliage"] = "Под листвой"
	L["Under the hut"] = "Под хижиной"
	L["Under the hut's\nnorthern side ramp"] = "Под пандусом северной стороны хижины"
	L["Under the trees.\nVery difficult to see"] = "Под деревьями.\nОчень сложно увидеть"
	L["Under the tree, at\nthe edge of the lake"] = "Под деревом,\nна краю озера"
	L["Under the water tower"] = "Под водонапорной башней"
	L["Under the tree.\nIn front of Thunder"] = "Под деревом.\nПеред Гром"
	L["Under the bridge"] = "Под мостом"
	L["Inside the building"] = "Внутри здания"
	L["Sho"] = "Шо"
	L["Old Hillpaw"] = "Старик Горная Лапа"
	L["Ella"] = "Элла"
	L["Chee Chee"] = "Чи-Чи"
	L["Fish Fellreed"] = "Рыба Тростниковая Шкура"
	L["Haohan Mudclaw"] = "Хаохань Грязный Коготь"
	L["Tina Mudclaw"] = "Тина Грязный Коготь"
	L["Farmer Fung"] = "Фермер Фун"
	L["Jogu the Drunk"] = "Йогу Пьяный"
	L["Gina Mudclaw"] = "Джина Грязный Коготь"
	L["Sulik'shor"] = "Сулик'шор"
	L["Crystal of Insanity"] = "Кристалл безумия"
	L["Blackhoof"] = "Черное Копыто"
	L["Battle Horn"] = "Боевой рог"
	L["Ghostly Pandaren Craftsman"] = "Призрачный пандарен-ремесленник"
	L["AddOn Description"] = "Помогает найти " ..ns.colour.highlight .."Темная Земля"
	L["Icon settings"] = "Настройки Значков"
	L["Icon Scale"] = "Масштаб Значок"
	L["The scale of the icons"] = "Масштаб для Значков"
	L["Icon Alpha"] = "Альфа Значок"
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
	L["Options"] = "Параметры"
	L["Gold Ring"] = "Золотое кольцо"
	L["Red Cross"] = "Красный Крест"
	L["Undo"] = "Расстегивать"
	L["White Diamond"] = "Белый бриллиант"
	L["Copper Diamond"] = "Медный бриллиант"
	L["Red Ring"] = "Красное кольцо"
	L["Blue Ring"] = "Синее кольцо"
	L["Green Ring"] = "Зеленое кольцо"
	L["Show Coordinates"] = "Показать Координаты"
	L["Show Coordinates Description"] = "Отображает " ..ns.colour.highlight
		.."координаты\124r во всплывающих подсказках на карте мира и мини-карте"

elseif ns.locale == "zhCN" then
	L["Dark Soil"] = "黑色泥土"
	L["Under the foliage"] = "在树叶下"
	L["Under the hut"] = "在小屋下面"
	L["Under the hut's\nnorthern side ramp"] = "在小屋的北侧坡道下"
	L["Under the trees.\nVery difficult to see"] = "在树下。很难看"
	L["Under the tree, at\nthe edge of the lake"] = "在树下，在湖边"
	L["Under the water tower"] = "在水塔下"
	L["Under the tree.\nIn front of Thunder"] = "在树下。在雷霆前面"
	L["Under the bridge"] = "在桥下"
	L["Inside the building"] = "建筑物内"
	L["Sho"] = "阿烁"
	L["Old Hillpaw"] = "老农山掌"
	L["Ella"] = "艾拉"
	L["Chee Chee"] = "吱吱"
	L["Fish Fellreed"] = "玉儿·采苇"
	L["Haohan Mudclaw"] = "郝瀚·泥爪"
	L["Tina Mudclaw"] = "迪娜·泥爪"
	L["Farmer Fung"] = "农夫老方"
	L["Jogu the Drunk"] = "醉鬼贾古"
	L["Gina Mudclaw"] = "吉娜·泥爪"
	L["Sulik'shor"] = "苏里克夏"
	L["Crystal of Insanity"] = "狂乱水晶"
	L["Blackhoof"] = "黑蹄"
	L["Battle Horn"] = "战斗号角"
--	L["Ghostly Pandaren Craftsman"] = "Wowhead broken at the time"
	L["AddOn Description"] = "帮助你找寻" ..ns.colour.highlight .."黑色泥土"
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
	L["Options"] = "选项"
	L["Gold Ring"] = "金戒指"
	L["Red Cross"] = "红十字"
	L["Undo"] = "解开"
	L["White Diamond"] = "白钻石"
	L["Copper Diamond"] = "铜钻石"
	L["Red Ring"] = "红环"
	L["Blue Ring"] = "蓝环"
	L["Green Ring"] = "绿色戒指"
	L["Show Coordinates"] = "显示坐标"
	L["Show Coordinates Description"] = "在世界地图和迷你地图上的工具提示中" ..ns.colour.highlight .."显示坐标"

elseif ns.locale == "zhTW" then
	L["Dark Soil"] = "黑色泥土"
	L["Under the foliage"] = "在樹葉下"
	L["Under the hut"] = "在小屋下面"
	L["Under the hut's\nnorthern side ramp"] = "在小屋的北側坡道下"
	L["Under the trees.\nVery difficult to see"] = "在樹下。很難看"
	L["Under the tree, at\nthe edge of the lake"] = "在樹下。在湖邊"
	L["Under the water tower"] = "在水塔下"
	L["Under the tree.\nIn front of Thunder"] = "在樹下。在雷霆前面"
	L["Under the bridge"] = "在橋下"
	L["Inside the building"] = "建築物內"
	L["Sho"] = "阿爍"
	L["Old Hillpaw"] = "老農山掌"
	L["Ella"] = "艾拉"
	L["Chee Chee"] = "吱吱"
	L["Fish Fellreed"] = "玉儿·採葦"
	L["Haohan Mudclaw"] = "郝瀚·泥爪"
	L["Tina Mudclaw"] = "迪娜·泥爪"
	L["Farmer Fung"] = "農夫老方"
	L["Jogu the Drunk"] = "醉鬼賈古"
	L["Gina Mudclaw"] = "吉娜·泥爪"
	L["Sulik'shor"] = "蘇里克夏"
	L["Crystal of Insanity"] = "狂亂水晶"
	L["Blackhoof"] = "黑蹄"
	L["Battle Horn"] = "戰鬥號角"
--	L["Ghostly Pandaren Craftsman"] = "Wowhead broken at the time"
	L["AddOn Description"] = "幫助你找尋" ..ns.colour.highlight .."黑色泥土"
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
	L["Options"] = "選項"
	L["Gold Ring"] = "金戒指"
	L["Red Cross"] = "紅十字"
	L["Undo"] = "解開"
	L["White Diamond"] = "白鑽石"
	L["Copper Diamond"] = "銅鑽石"
	L["Red Ring"] = "紅環"
	L["Blue Ring"] = "藍環"
	L["Green Ring"] = "綠色戒指"
	L["Show Coordinates"] = "顯示坐標"
	L["Show Coordinates Description"] = "在世界地圖和迷你地圖上的工具提示中" ..ns.colour.highlight .."顯示坐標"
	
else
	if ns.locale == "enUS" then
		L["Grey"] = "Gray"
	end
	L["AddOn Description"] = "Helps you find the Dark Soil"
	L["Show Coordinates Description"] = "Display coordinates in tooltips on the world map and the mini map"
end

-- I use this for debugging
local function printPC( message )
	if message then
		DEFAULT_CHAT_FRAME:AddMessage( ns.colour.prefix ..L["Dark Soil"] ..": " ..ns.colour.plaintext
			..message .."\124r" )
	end
end

-- Plugin handler for HandyNotes
local function infoFromCoord(mapFile, coord)
	local point = ns.points[mapFile] and ns.points[mapFile][coord]
	return point[1], point[2], point[3]
end

function pluginHandler:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local dataType, first, second, third = infoFromCoord(mapFile, coord)
	
	if dataType == "N" then
		GameTooltip:SetText(ns.colour.prefix ..L[second])
		local _, rawRep, _, _, _, _, currentStanding, minCurrentStanding, maxCurrentStanding = GetFriendshipReputation( first )
		if maxCurrentStanding then
			GameTooltip:AddLine(ns.colour.highlight ..currentStanding ..ns.colour.plaintext .." ("
						..( rawRep - minCurrentStanding ) .." / " ..( maxCurrentStanding - minCurrentStanding ) ..")")
		else
			GameTooltip:AddLine(ns.colour.highlight ..currentStanding)
		end
		if third then
			GameTooltip:AddLine( ns.colour.plaintext ..L[third] )
		end
	elseif dataType == "B" then
		GameTooltip:SetText( ns.colour.prefix ..L[first] )
		if type(second) == "number" then
			-- If we get to here with a quest number then don't need to show anything in addition to the title
		else
			GameTooltip:AddLine(ns.colour.plaintext ..L[second]) -- the item the player is probably farming
		end
	else
		GameTooltip:SetText( ns.colour.prefix ..L["Dark Soil"] )
		if first then
			if first == "Author" then			
				if second then
					GameTooltip:AddLine(ns.colour.plaintext ..L[second])
				end
			else
				GameTooltip:AddLine(ns.colour.plaintext ..L[first])
			end
		end
	end

	if ns.db.showCoords == true then
		local mX, mY = HandyNotes:getXY(coord)
		mX, mY = mX*100, mY*100
		GameTooltip:AddLine( ns.colour.highlight .."(" ..format( "%.02f", mX ) .."," ..format( "%.02f", mY ) ..")" )
	end

	GameTooltip:Show()
end

function pluginHandler:OnLeave()
	GameTooltip:Hide()
end

do
	continents[ns.pandaria] = true
	local function iterator(t, prev)
		if not t or ns.CurrentMap == ns.pandaria then return end
		local coord, v = next(t, prev)
		local aId, completed, iconIndex, quest
		while coord do
			if v then
				if v[1] == "N" then
					return coord, nil, ns.texturesSpecial[ns.db.icon_choiceSpecial],
							ns.db.icon_scale * ns.scalingSpecial[ns.db.icon_choiceSpecial], ns.db.icon_alpha
				elseif v[1] == "B" then
					quest = tonumber(v[3])
					if quest then
						if C_QuestLog.IsQuestFlaggedCompleted(quest) == true then
							-- don't bother showing
						else
							return coord, nil, ns.texturesSpecial[ns.db.icon_choiceBonus],
									ns.db.icon_scale * ns.scaling[ns.db.icon_choiceBonus], ns.db.icon_alpha
						end
					else
						return coord, nil, ns.texturesSpecial[ns.db.icon_choiceBonus],
								ns.db.icon_scale * ns.scaling[ns.db.icon_choiceBonus], ns.db.icon_alpha
					end
				elseif ns.author then
					if v[2] and v[2] == "Author" then
						return coord, nil, ns.textures[10],
								ns.db.icon_scale * ns.scaling[10], ns.db.icon_alpha
					else
						return coord, nil, ns.textures[ns.db.icon_choice],
								ns.db.icon_scale * ns.scaling[ns.db.icon_choice], ns.db.icon_alpha
					end
				else
					return coord, nil, ns.textures[ns.db.icon_choice],
							ns.db.icon_scale * ns.scaling[ns.db.icon_choice], ns.db.icon_alpha
				end
			end
			coord, v = next(t, coord)
		end
	end
	function pluginHandler:GetNodes2(mapID)
		ns.CurrentMap = mapID
		return iterator, ns.points[mapID]
	end
end

-- Interface -> Addons -> Handy Notes -> Plugins -> Dark Soil options
ns.options = {
	type = "group",
	name = L["Dark Soil"],
	desc = L["AddOn Description"],
	get = function(info) return ns.db[info[#info]] end,
	set = function(info, v)
		ns.db[info[#info]] = v
		pluginHandler:Refresh()
	end,
	args = {
		icon = {
			type = "group",
			-- Add a " " to force this to be before the first group. HN arranges alphabetically on local language
			name = " " ..L["Icon settings"],
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
				icon_choiceSpecial = {
					type = "range",
					name = L["Icon"] .." (" ..L["NPC"] ..")",
					desc = "1 = " ..L["Gold Ring"] .."\n2 = " ..L["Red Cross"] .."\n3 = " ..L["Undo"] .."\n4 = " 
							..L["White Diamond"] .."\n5 = " ..L["Copper Diamond"] .."\n6 = " ..L["Red Ring"] 
							.."\n7 = " ..L["Blue Ring"] .."\n8 = " ..L["Green Ring"], 
					min = 1, max = 8, step = 1,
					arg = "icon_choiceSpecial",
					order = 5,
				},
				icon_choiceBonus = {
					type = "range",
					name = L["Icon"] .." (" ..L["Blackhoof"] .."++)",
					desc = "1 = " ..L["Gold Ring"] .."\n2 = " ..L["Red Cross"] .."\n3 = " ..L["Undo"] .."\n4 = " 
							..L["White Diamond"] .."\n5 = " ..L["Copper Diamond"] .."\n6 = " ..L["Red Ring"] 
							.."\n7 = " ..L["Blue Ring"] .."\n8 = " ..L["Green Ring"], 
					min = 1, max = 8, step = 1,
					arg = "icon_choiceBonus",
					order = 6,
				},
				showCoords = {
					name = L["Show Coordinates"],
					desc = L["Show Coordinates Description"] 
							..ns.colour.highlight .."\n(xx.xx,yy.yy)",
					type = "toggle",
					width = "full",
					arg = "showCoords",
					order = 7,
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
	HandyNotes:RegisterPluginDB("DarkSoilTillers", pluginHandler, ns.options)
	ns.db = LibStub("AceDB-3.0"):New("HandyNotes_DarkSoilDB", defaults, "Default").profile
	pluginHandler:Refresh()
end

function pluginHandler:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "DarkSoilTillers")
end

LibStub("AceAddon-3.0"):NewAddon(pluginHandler, "HandyNotes_DarkSoilDB", "AceEvent-3.0")