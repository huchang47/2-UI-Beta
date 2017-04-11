﻿

if GetLocale() ~= "zhCN" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "距离监视（动态）：$spell:119622",
	SetIconOnMC			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(119622)
})

L:SetMiscLocalization({
	Pull				= "没错, 没错! 释放你的怒火! 试着击败我!"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetMiscLocalization({
	Pull				= "把他们的尸体带给我!"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	RangeFrame			= "距离监视：$spell:137511"
})

L:SetMiscLocalization({
	Pull				= "你们竟敢打扰我的准备工作!赞达拉这次不会在被阻止了！"
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

L:SetOptionLocalization({
	RangeFrame			= "距离监视（10码）：$spell:136340"
})

L:SetMiscLocalization({
	Pull				= "你感受到寒意了么? The storm is coming..."
})

---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	SetIconOnBeacon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144473),
	BeaconArrow				= "当有人中了 $spell:144473 时显示DBM箭头"
})

L:SetMiscLocalization({
	Pull					= "那我们开始吧.",
	Victory					= "你的希望闪耀, 尤其在团结后更是璀璨. 即使在最黑暗的地方，它也会照亮你的路途."
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

L:SetOptionLocalization({
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(11, 144532)
})

L:SetMiscLocalization({
	Pull					= "试炼开始!",
	Wave1					= "别让你们的判断被困境蒙蔽!",
	Wave2					= "倾听你内心的声音，找出真相!",
	Wave3					= "时刻考虑你行动的后果!",
	Victory					= "你的智慧帮助你度过了考验，希望智慧能在黑暗中照亮你的道路."
})

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

L:SetMiscLocalization({
	Pull					= "拭目以待.",
	Victory					= "虽然被难以想象的敌人包围, 你的坚毅会让你坚持下去. 在未来要记得这一点.",
	VictoryDem				= "Rakkas shi alar re pathrebosh il zila rethule kiel shi shi belaros rikk kanrethad adare revos shi xi thorje Rukadare zila te lok zekul melar "--Cover all bases and all
})

---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

L:SetOptionLocalization({
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(3, 144642)
})

L:SetMiscLocalization({
	Pull					= "哈哈! 试炼开始吧!",
	Victory					= "你很强大, 比你认知的还要强大. 带着这个信念迎接前方的黑暗, 让它保护你."
})

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)

L:SetOptionLocalization({
	SetIconOnBurningSoul	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(144689),
	RangeFrame				= DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(8, 144689)
})

L:SetMiscLocalization({
	Pull					= "你将代替我永恒的燃烧."
})

-----------------
--  Zandalari  --
-----------------
L = DBM:GetModLocalization("Zandalari")

L:SetGeneralLocalization({
	name =	"赞达拉"
})
