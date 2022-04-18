--========================================================--
--               SEquipment CN Locale                     --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/04/12                              --
--========================================================--

--========================================================--
Scorpio             "BaseConfig.Locale.zhCN"              ""
--========================================================--
local L = _Locale("zhCN")
-----------------------------------------------------------
--                      Locale                           --
-----------------------------------------------------------

if not L then return end

L["Home"]                           = "主页"
L["General"]                        = "常规"
    L["Font Set"]                   = "字体设置"
        L["Font"]                   = "字体"
        L["Frame Scale"]            = "界面大小"
    L["Level Set"]                  = "装等设置"
        L["Show"]                   = "显示"
        L["Size"]                   = "大小"
        L["Location"]               = "位置"
        L["Level Self"]             = "自身"
        L["Level Target"]           = "目标"
        L["Level Bag"]              = "背包"
        L["Level Bank"]             = "银行"
        L["Level Guild"]            = "公会"
        L["Level GB"]               = "公会银行"
        L["Level Chat"]             = "聊天框"
L["Player"]                         = "玩家"
    L["Show List Module"]           = "显示列表模块儿"
    L["Show Level Module"]          = "显示装等模块儿"
    L["Show Specialization"]        = "显示专精模块儿"
    L["Show Slots"]                 = "显示部位模块儿"
    L["Show Stats Icon"]            = "显示属性类型模块儿"
    L["Show GemEnchant"]            = "显示宝石情况模块儿"
    L["Show Attributes"]            = "显示装备绿字模块儿"
    L["Show Attributes Percent"]    = "显示绿字百分比模块儿"
L["Target"]                         = "目标"
    L["Show Target Module"]         = "显示目标模块儿"
    L["Show Self Simultaneously"]   ="观察目标的同时显示自身装备列表面板"
L["Exit"]                           = "退出"
L["DEFAULT"]                        = "默认"
L["Crit"]                           = "爆"
L["Haste"]                          = "急"
L["Mastery"]                        = "精"
L["Versatility"]                    = "全"
L["CritLong"]                       = "爆击"
L["HasteLong"]                      = "急速"
L["MasteryLong"]                    = "精通"
L["VersatilityLong"]                = "全能"
L["Head"]                           = "头部"
L["Neck"]                           = "项链"
L["Shoulders"]                      = "肩膀"
L["Chest"]                          = "胸甲"
L["Waist"]                          = "腰带"
L["Legs"]                           = "腿部"
L["Feet"]                           = "鞋子"
L["Wrist"]                          = "护腕"
L["Hands"]                          = "手套"
L["Finger"]                         = "戒指"
L["Trinket"]                        = "饰品"
L["Back"]                           = "披风"
L["Main Hand"]                      = "主手"
L["Off Hand"]                       = "副手"
L["TOP"]                            = "顶部"
L["BOTTOM"]                         = "底部"
L["LEFT"]                           = "左侧"
L["RIGHT"]                          = "右侧"
L["CENTER"]                         = "居中"
L["TOPLEFT"]                        = "左上"
L["TOPRIGHT"]                       = "右上"
L["BOTTOMLEFT"]                     = "左下"
L["BOTTOMRIGHT"]                    = "右下"
L["Gem"]                            = "宝石"
L["Suit"]                           = "套装数量"
L["Empty GemSlot"]                  = "空宝石槽"




--------------------------------------------------
--                   ChangeLog                  --
--------------------------------------------------
L["Log"]                            = "更新日志\n"
L["Log1 Time"]                      = "2022/4/14"
L["Log1 Version"]                   = "V2.1.5\n"
L["Log1 Text"]    = "1.解决了插件污染blz的问题,切换自身面板时候会不正常\n"
    -- .. "2.稍微调整了一下边框,现在信息稍微内嵌了一点,这也是V1.0.0开始做的事情\n"
    -- .. "3.修正了宝石附魔信息的显示规则\n"
    -- .. "4.更改套装显示样式,现在显示套装数量,而不是套装激活件数\n"
    -- .. "5.整合了玩家与目标的选项,现在他们使用统一选项\n"
    -- .. "6.更新版本号V2.1.0,此版本为中版本更新,修复大量错误以及代码冗余\n"
