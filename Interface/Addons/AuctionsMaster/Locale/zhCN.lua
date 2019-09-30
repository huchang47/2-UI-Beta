﻿local L = LibStub("AceLocale-3.0"):NewLocale("AuctionLite", "zhCN");
if not L then return end

L["AuctionLite Options"] = "|cff69ccf0[拍卖]|r购售助手"
L["%dh"] = "%dh"
L["(none set)"] = "（没有设置）"
L["|cff00ff00Scanned %d listings.|r"] = "|cff00ff00搜索到 %d 项。|r"
L["|cff00ff00Using previous price.|r"] = "|cff00ff00使用之前的价格。|r"
L["|cff808080(per item)|r"] = "|cff808080(每件)|r"
L["|cff808080(per stack)|r"] = "|cff808080(每组)|r"
L["|cff8080ffData for %s x%d|r"] = "|cff8080ff数据: %s x%d|r"
L["|cffff0000[Error]|r Insufficient funds."] = "|cffff0000[错误]|r 资金不足。"
L["|cffff0000[Warning]|r Skipping your own auctions.  You might want to cancel them instead."] = "|cffff0000[警告]|r 跳过你自己的拍卖。  也许你打算取消掉他们。"
L["|cffff0000Buyout less than bid.|r"] = "|cffff0000一口价低于竞标价。|r"
L["|cffff0000Buyout less than vendor price.|r"] = "|cffff0000一口价低于商人售价。|r"
L["|cffff0000Invalid stack size/count.|r"] = "|cffff0000无效的堆叠数。|r"
L["|cffff0000No bid price set.|r"] = "|cffff0000没有设置竞标价。|r"
L["|cffff0000Not enough cash for deposit.|r"] = "|cffff0000没有足够的现金。|r"
L["|cffff0000Not enough items available.|r"] = "|cffff0000没有足够的物品。|r"
L["|cffff0000Stack size too large.|r"] = "|cffff0000堆叠数量太大.|r"
L["|cffff0000Using %.3gx vendor price.|r"] = "|cffff0000使用 %.3gx 商店价格.|r"
L["|cffff7030Buyout less than vendor price.|r"] = "|cffff7030一口价低于商人价格。|r"
L["|cffff7030Stack %d will have %d |4item:items;.|r"] = "|cffff7030堆叠 %d 将有 %d |4物品:物品;.|r"
L["|cffffd000Using historical data.|r"] = "|cffffd000使用历史数据。|r"
L["|cffffff00Scanning: %d%%|r"] = "|cffffff00搜索中：%d%%|r"
L["Accept"] = "接受"
L["Add a new item to a favorites list by entering the name here."] = "在这输入要添加的新的物品名字来添加到收藏列表。"
L["Add an Item"] = "增加一件物品"
L["Advanced"] = "高级"
L["Always"] = "总是"
L["Amount to multiply by vendor price to get default sell price."] = "默认售价等于商人出售乘以你设置的倍数。"
L["Approve"] = "确认购买"
L["Auction"] = "拍卖"
L["Auction creation is already in progress."] = "正在发布拍卖中。"
L["Auction house data cleared."] = "拍卖行资料已清除。"
L["Auction scan skipped (control key is down)"] = "按CTRL键拍卖时不查询。"
L["AuctionLite"] = "|cff69ccf0[拍卖]|r购售助手"
L["AuctionLite - Buy"] = "竞标助手"
L["AuctionLite - Sell"] = "拍卖助手"
L["AuctionLite Buy"] = "AuctionLite 购买"
L["AuctionLite Sell"] = "AuctionLite 出售"
L["AuctionLite v%s loaded!"] = "AuctionLite v%s 已经载入！"
L["Batch %d: %d at %s"] = "批量 %d: %d 在 %s"
L["Below AH"] = "拍卖窗口下方"
L["Bid cost for %d:"] = "竞标价花费 %d:"
L["Bid on %dx %s (%d |4listing:listings; at %s)."] = "竞标价在 %dx %s (%d |4项:项; 在 %s)。"
L["Bid Per Item"] = "竞标价/件"
L["Bid Price"] = "出价"
L["Bid Total"] = "竞标价"
L["Bid Undercut"] = "竞标价压低(百分比)"
L["Bid Undercut (Fixed)"] = "竞标价压低(固定值)"
L["Bought %dx %s (%d |4listing:listings; at %s)."] = "购买 %dx %s (%d |4项:项; 在 %s)。"
L["Buy Tab"] = "购买标签"
L["Buyout cannot be less than starting bid."] = "一口价不能低于竞标价。"
L["Buyout cost for %d:"] = "一口价购买%d件总计:"
L["Buyout Per Item"] = "一口价/件"
L["Buyout Price"] = "一口价"
L["Buyout Total"] = "一口价"
L["Buyout Undercut"] = "一口价压低(百分比)"
L["Buyout Undercut (Fixed)"] = "一口价压低(固定值)"
L["Cancel"] = "取消"
L["Cancel All"] = "取消全部"
L["Cancel All Auctions"] = "取消所有拍卖"
L["Cancel Unbid"] = "取消没有出价的"
L["Cancel Undercut Auctions"] = "取消削价的拍卖"
L["CANCEL_CONFIRM_TEXT"] = "你的一些拍卖已经有了出价。你是否想要取消所有拍卖，取消没有出价的拍卖，或不做任何操作？"
L["CANCEL_NOTE"] = [=[因为游戏的限制，每按一次 AuctionLite 只能取消一件物品，所以你的拍卖物品中只有一件被取消。

若要解决此问题，你可以继续点“取消”按钮直到所有需要取消的拍卖物品被取消。]=]
L["CANCEL_TOOLTIP"] = [=[|cffffffff点击:|r 取消所有拍卖
|cffffffffCtrl-点击:|r 取消削价的拍卖]=]
L["Cancelled %d |4listing:listings; of %s."] = "已取消%d|4项:项; 的%s。"
L["Cancelled %d listings of %s"] = "取消 %d 在 %s 项"
L["Choose a favorites list to edit."] = "选择一个收藏列表来编辑"
L["Choose which tab is selected when opening the auction house."] = "选择打开拍卖行时显示的标签。"
L["Clear All"] = "清除所有"
L["Clear all auction house price data."] = "清除所有拍卖行价钱资料。"
L["Clear All Data"] = "清除所有资料"
L["CLEAR_DATA_WARNING"] = "你真的想要用 AuctionLite 删除所有拍卖行收集到的价钱资料？"
L["Competing Auctions"] = "相抵触的拍卖"
L["Configure"] = "设置"
L["Configure AuctionLite"] = "设置拍卖助手"
L["Consider resale value of excess items when filling an order on the \"Buy\" tab."] = "考虑转售价值过剩的物品在在\"购买\"标签上填写订单时。"
L["Consider Resale Value When Buying"] = "购买时考虑转售价值"
L["Create a new favorites list."] = "建立一个新的收藏列表."
L["Created %d |4auction:auctions; of %s x%d (%s total)."] = "新增 %d |4拍卖:拍卖; : %s x%d (%s 总共)."
L["Created %d |4auction:auctions; of %s x%d."] = "新增 %d |4拍卖:拍卖; : %s x%d."
L["Current: %s (%.2fx historical)"] = "目前:%s(%.2fx 历史)"
L["Current: %s (%.2fx historical, %.2fx vendor)"] = "目前:%s(%.2fx 历史,%.2fx 商店)"
L["Current: %s (%.2fx vendor)"] = "目前: %s (%.2fx 商店)"
L["Deals must be below the historical price by this much gold."] = "必须比历史价格低这么多金"
L["Deals must be below the historical price by this percentage."] = "必须比历史价格低这么多百分率"
L["Default"] = "默认"
L["Default Number of Stacks"] = "预设堆叠数目"
L["Default Stack Size"] = "预设堆叠大小"
L["Delete"] = "删除"
L["Delete the selected favorites list."] = "删除已选择的收藏列表"
L["Disable"] = "禁用"
L["Disenchant"] = "分解"
L["Do it!"] = "完成它！"
L["Do Nothing"] = "无操作"
L["Enable"] = "启用"
L["Enter item name and click \"Search\""] = [[输入物品名称并点击“搜索”
按住SHIFT点击物品可直接搜索]]
L["Enter the name of the new favorites list:"] = "输入新的收藏列表的名字:"
L["Error locating item in bags.  Please try again!"] = "在背包中定位物品错误，请重试！"
L["Error when creating auctions."] = "发布拍卖时出现错误。"
L["Fast Auction Scan"] = "快速扫描"
L["Fast auction scan disabled."] = "快速扫描已停用。"
L["Fast auction scan enabled."] = "快速扫描已启用。"
L["FAST_SCAN_AD"] = [=[AuctionLite 快速扫描功能将在几秒钟之内扫描拍卖行。

但是，快速扫描可能会引起掉线问题。如果发生了掉线，请关闭 AuctionLite 快速扫描选项。

启用快速扫描？]=]
L["Favorites"] = "收藏"
L["Fixed amount to undercut market value for bid prices (e.g., 1g 2s 3c)."] = "设置竞标价为当前最低价再减去固定值，比如要压价1金2银3铜就输入'1g 2s 3c'，必须把上面的百分比压价设置为0才生效"
L["Fixed amount to undercut market value for buyout prices (e.g., 1g 2s 3c)."] = "设置一口价当前最低价再减去固定值，比如要压价1金2银3铜就输入'1g 2s 3c'，必须把上面的百分比压价设置为0才生效"
L["Full Scan"] = "完整扫描"
L["Full Stack"] = "完整堆叠"
L["Hide Tooltips"] = "隐藏提示"
L["Historical Price"] = "历史价格"
L["Historical price for %d:"] = "购买%d件的历史价格："
L["Historical: %s (%d |4listing:listings;/scan, %d |4item:items;/scan)"] = "历史: %s (%d |4项:项;/扫描, %d |4物品:物品;/扫描)"
L["If Applicable"] = "如果可用"
L["Invalid starting bid."] = "无效的竞标价。"
L["Item"] = "物品"
L["Item Summary"] = "物品摘要"
L["Items"] = "物品"
L["Last Used Tab"] = "最后使用的标签"
L["Listing %d of %d"] = "请选择第%d件/共%d件"
L["Listings"] = "列表"
L["Market Price"] = "市场价"
L["Max Stacks"] = "最大堆叠"
L["Max Stacks + Excess"] = "最大堆叠 + 剩余"
L["Member Of"] = "成员"
L["Minimum Profit (Gold)"] = "最小利润（金）"
L["Minimum Profit (Pct)"] = "最小利润（百分率）"
L["Mouse Cursor"] = "跟随鼠标"
L["Name"] = "名称"
L["Net cost for %d:"] = "%d的成本:"
L["Never"] = "从不"
L["New..."] = "新的..."
L["No current auctions"] = "目前没有拍卖"
L["No deals found"] = "没有发现交易"
L["No items found"] = "未找到物品"
L["Not enough cash for deposit."] = "没有足够的金币。"
L["Not enough items available."] = "没有足够的物品。"
L["Note: %d |4listing:listings; of %d |4item was:items were; not purchased."] = "注意: %d |4项:项; 的 %d |4物品:物品; 没有购买."
L["Number of Items"] = "物品数量"
L["Number of Items |cff808080(max %d)|r"] = "物品数量 |cff808080(最大 %d)|r"
L["Number of stacks suggested when an item is first placed in the \"Sell\" tab."] = "建议堆叠数目当物品首先放置在\"出售\"标签。"
L["On the summary view, show how many listings/items are yours."] = "在总结检视中，显示多少项/物品是你的"
L["One Item"] = "一件物品"
L["One Stack"] = "一堆叠"
L["Open All Bags at AH"] = "打开所有背包"
L["Open all your bags when you visit the auction house."] = "当你打开拍卖行时自动打开所有背包。"
L["Open configuration dialog"] = "打开设置界面"
L["per item"] = "每个"
L["per stack"] = "每组"
L["Percent to undercut market value for bid prices (0-100)."] = "根据目前其他人拍卖的价格，压低一个百分比后设置为本次出售的竞标价。"
L["Percent to undercut market value for buyout prices (0-100)."] = "根据目前其他人拍卖的价格，压低一个百分比后设置为本次出售的一口价。"
L["Placement of tooltips in \"Buy\" and \"Sell\" tabs."] = "布置在\"购买\"和\"出售\"标签提示"
L["Potential Profit"] = "盈利潜力"
L["Pricing Method"] = "价格模式"
L["Print Detailed Price Data"] = "显示详细的价格数据"
L["Print detailed price data when selling an item."] = "当出售某物品时，显示详细的价格数据。"
L["Profiles"] = "配置"
L["Qty"] = "数量"
L["Remove Items"] = "移除物品"
L["Remove the selected items from the current favorites list."] = "从当前的收藏列表中移除已选择的物品"
L["Resell %d:"] = "再卖 %d:"
L["Right Side of AH"] = "拍卖窗口右方"
L["Round all prices to this granularity, or zero to disable (0-1)."] = "将卖价进行取整，数值越高，取整越粗略。0为关闭该功能（0-1）。"
L["Round Prices"] = "价格取整"
L["Save All"] = "保存所有"
L["Saved Item Settings"] = "已保存物品设置"
L["Scan complete.  Try again later to find deals!"] = "扫描完成. 稍后再尝试寻找交易！"
L["Scanning..."] = "扫描中……"
L["Scanning:"] = "扫描中："
L["Search"] = "搜索"
L["Searching:"] = "搜索中："
L["Select a Favorites List"] = "选择一个物品列表"
L["Selected Stack Size"] = "已选择堆叠大小"
L["Sell Tab"] = "出售标签"
L["Shift-click to search for the exact name. Normal click to perform a regular search."] = "Shift-单击搜索准确名称。点击进行常规搜索。"
L["Show auction house value in tooltips."] = "在鼠标提示中显示拍卖行价格。"
L["Show Auction Value"] = "显示拍卖行价格"
L["Show Deals"] = "显示交易"
L["Show Disenchant Value"] = "显示附魔等级"
L["Show expected disenchant value in tooltips."] = "显示分解该物品所需的附魔技能等级。"
L["Show Favorites"] = "显示收藏夹"
L["Show Full Stack Price"] = "堆叠价格"
L["Show full stack prices in tooltips (shift toggles on the fly)."] = "显示堆叠价格。"
L["Show How Many Listings are Mine"] = "显示有多少项是我的"
L["Show My Auctions"] = "显示我的拍卖"
L["Show Vendor Price"] = "显示商人价格"
L["Show vendor sell price in tooltips."] = "在鼠标提示中显示商人的价格。"
L["Stack Count"] = "堆叠计数"
L["Stack Size"] = "堆叠大小"
L["Stack size suggested when an item is first placed in the \"Sell\" tab."] = "建议堆叠大小当物品首先放置在\"出售\"标签。"
L["Stack size too large."] = "堆叠数量太大。"
L["stacks of"] = "组/每组"
L["Start Tab"] = "初始标签"
L["Store Price Data"] = "储存价钱资料"
L["Store price data for all items seen (disable to save memory)."] = "储存所有已见过的物品价钱资料(禁用以节省内存)."
L["Time Elapsed:"] = "花费时间："
L["Time Remaining:"] = "剩余时间："
L["Tooltip Location"] = "鼠标提示位置"
L["Tooltips"] = "鼠标提示"
L["Use Coin Icons in Tooltips"] = "显示钱币图标"
L["Use fast method for full scans (may cause disconnects)."] = "使用快速模式扫描拍卖行（可能会引起掉线）。"
L["Uses the standard gold/silver/copper icons in tooltips."] = "在鼠标提示中使用图标代替 金、银、铜字样。"
L["Vendor"] = "商人"
L["Vendor Multiplier"] = "商人倍数"
L["Vendor: %s"] = "商人：%s"
L["VENDOR_WARNING"] = "你的一口价价格低于商人价格，你是否仍然要建立这个拍卖？"
L["Window Corner"] = "右下角"
L["APPEARANCES"] = "幻化物品"

-------------------Advanced
L["ADVANCED_TRUNC"] = "高级"
L["ADVANCED"] = "高级功能"
L["ADVANCED_DESC"] = "AuctionLite的高级功能。"

L["USE"] = "可用"
L["USE_DESC"] = "仅查找您的角色可以使用的道具。"
L["CATEGORY"] = "分类"
L["CATEGORY_DESC"] = [[请选择您想要搜索的道具分类。/n/n您可以在此菜单中设置稀有道具的过滤。]]
L["LEVEL_MIN"] = "最低等级"
L["LEVEL_MIN_DESC"] = [[请选择您想要搜索的最低等级要求。

留空则不使用此过滤。]]
L["LEVEL_MAX"] = "最高等级"
L["LEVEL_MAX_DESC"] = [[请选择您想要搜索的最高等级要求。

留空则不使用此过滤。]]
L["RESET"] = "重置过滤器"
L["RESET_DESC"] = "点击后重置所有的过滤设置"
L["NAME"] = "名称"
L["NAME_DESC"] = [[输入您想要搜索的道具名称。

留空则搜索所有适配的道具。]]
L["QUANTITY"] = "数量"
L["QUANTITY_DESC"] = "选择您想要购买的数量。"
L["SEARCH"] = "搜索"
L["SEARCH_DESC"] = [[点击后开始根据过滤设置搜索拍卖行。

按住Shift键点击则完全匹配搜索的名称。]]
L["FULLSCAN"] = "全局扫描"
L["FULLSCAN_DESC"] = [[点击后开始对拍卖行中所有商品的全局扫描。

此功能每15分钟只能使用一次。]]

L["RARITY"] = "稀有程度"
L["RARITY_DESC"] = "选择您要搜索的道具的最低稀有程度。"
L["RARITY_LABEL"] = "稀有程度: %s"
L["CLEARCATEGORY"] = "重置该类别过滤器"
L["CLEARCATEGORY_DESC"] = "重置该类别过滤器，以便搜索所有类别。"


--CollectionShop
L["Select an auction to buy or click \"Buy All\""] = "请选择要购买的拍卖项，或点击 \"全部购买\""
L["%sEach result is the lowest buyout auction for an|r %s"] = "%s每个结果最低的一口价|r %s"
L["Appearance"] = "外观"
L["Appearance Source"] = "外观来源"
L["Remember when leaving %s to equip or use auctions won to update your Collections for future Shop results."] = "当您使用或装备拍卖成功商品后将更新您的藏品，可用于以后的商店显示结果。"
L["Max Item Price: %s"] = "最高商品价格: %s"
L["Ready"] = "就绪"
L["Auction House data required"] = "拍卖行所需数据"
L["Press \"Scan\" to perform a GetAll scan"] = "点击 \"扫描\" 执行全局扫描操作"
L["Press \"Shop\""] = "点击 \"商店\""
L["Choose Collection Mode"] = "选择藏品模式"
L["Requires Level"] = "等级可用"
L["Requires Profession"] = "职业可用"
L["Requires Riding Skill"] = "骑术可用"
L["Include"] = "包含"
L["Group By Species"] = "按种类分组"
L["Toggle Pet Families"] = "切换宠物类型"
L["Toggle Categories"] = "切换分类"
L["Live"] = "实时"
L["Time since last scan: %s"] = "距上次扫描: %s"
L["Appearance Sources"] = "外观来源"
L["Buyouts"] = "一口价"
L["Selection ignored, buying"] = "购买时忽略选项"
L["Selection ignored, scanning"] = "扫描时忽略选项"
L["No additional auctions matched your settings"] = "没有任何拍卖物品符合您的设置"
L["Selecting %s for %s, same %s."] = "已选择 %s 售价 %s, 类似 %s。"
L["Selecting %s for %s, next cheapest."] = "已选择 %s 售价 %s, 同类中最便宜的。"
L["appearance"] = "外观"
L["source"] = "来源"
L["Scanning Auction House"] = "拍卖行扫描中"
L["Request sent, waiting on auction data... This can take a minute, please wait..."] = "请求已发送，等待返回数据中...可能需要耗时1分钟，请耐心等待..."
L["Shopping"] = "扫描中"
L["You must check at least one rarity filter"] = "你至少需要选择一个过滤器"
L["You must check at least one %s filter"] = "你至少需要选择 %s 过滤器"
L["Pet Family"] = "宠物类型"
L["Auction Category"] = "拍卖分类"
L["Appearance Category"] = "外观分类"
L["You must check at least one Collected filter"] = "你至少需要选择一个藏品过滤器"
L["You must check at least one Level filter"] = "你至少需要选择一个等级过滤器"
L["Could not query Auction House after several attempts. Please try again later."] = "数次尝试后仍无法查询拍卖行。请稍后再试。"
L["Blizzard allows a GetAll scan once every 15 minutes. Please try again later."] = "暴雪仅允许15分钟内执行1次全局扫描。请稍后再试。"
L["Scanning %s: Page %d of %d"] = "%s 扫描中: 第 %d 页/总 %d 页"
L["%s remaining auctions...\n\nCollecting auction item links for all modes."] = "%s 额外拍卖商品...\n\n收集所有模式的拍卖商品链接。"
L["Updating Collection"] = "更新藏品中"
L["%s items remaining..."] = "%s 商品额外扫描中..."
L["%s remaining items..."] = "%s 额外商品加载中..."
L["Filtering, one moment please..."] = "过滤中，请稍等..."
L["%s for %s is no longer available and has been removed"] = "%s 在 %s 中已不再可用，已被移除"
L["%s cannot be previewed, no model data. Please report to addon developer"] = "%s 无法预览，没有模型数据。请向插件开发者报告。"
L["No auctions were found that matched your settings"] = "没有找到满足您设置的拍卖商品"
L["Auction House scan complete. Ready"] = "拍卖行扫描已完成。准备就绪。"
L["Blizzard allows a GetAll scan once every %s. Press \"Shop\""] = "暴雪仅允许 %s 内执行1次全局扫描。请点击 \"商店\""
L["That auction is no longer available and has been removed"] = "该拍卖已经不再可用，已被移除。"
L["That auction belonged to a character on your account and has been removed"] = "该拍卖属于您账户中的另一个角色，已被移除。"
L["No additional auctions matched your settings"] = "没有找到满足您设置的额外拍卖商品"
L["Realm: %s, UniqueItemIds: %d, Auctions: %d, Appearance Sources: %d"] = "服务器: %s, 唯一物品ID: %d, 拍卖: %d, 外观来源: %d"
L["Realm: %s, No data"] = "服务器: %s, 没有数据"
L["%s auction house tab must be shown."] = "拍卖行标签 %s 必须显示"
L["%s, item not found"] = "%s ，道具没有找到"
L["%s, invType missing"] = "%s ，类型丢失"
L["%s, slotId missing"] = "%s ，栏位ID丢失"
L["%s, appearanceID or sourceID missing"] = "%s ，外观ID或来源ID丢失"
L["%s, model malfunction, data mismatch"] = "%s ，模型错误，数据不匹配"
L["ItemID: %s, invType: %s, slotId: %s"] = "道具ID: %s, 类型: %s, 栏位Id: %s"
L["AppearanceID: %s, SourceID: %s, |T%s:32|t %s"] = "外观ID: %s, 来源ID: %s, |T%s:32|t %s"
L["Unknown command, opening Help"] = "未知指令，请查阅帮助文件"
L["Use either slash command, /cs or /collectionshop"] = "使用指令 /cs 或者 /collectionshop"
L["Undress Character"] = "脱光角色"
L["Show character with\nselected item only"] = "角色仅穿戴选择的道具"
L["Category"] = "分类"
L["Item Price"] = "商品价格"
L["% Item Value"] = "% 物品价值"
L["Buy All"] = "全部购买"
L["Buy All has been stopped. %s"] = "停止时全部购买。 %s"
L["Stop"] = "停止"
L["Scanning..."] = "扫描中..."
L["Shop"] = "商店"
L["Scan"] = "扫描"
L["Selection ignored, busy scanning or buying an auction"] = "扫描时或购买时忽略选项"
L["Scan Auction House live when\npressing \"Shop\" instead of\nusing GetAll scan data\n\nLive scans only search\nthe pages required for the\nfilters you checked and may\nbe faster in certain modes or\nwhen using a low max price"] = "通过点击\"商店\"扫描拍卖行，\n比使用全局扫描获取您筛选的信息会更快捷。"
L["Options"] = "选项"
L["Choose Collection Mode"] = "选择藏品分类"
L["Selection ignored, busy scanning or buying an auction"] = "扫描时或购买时忽略选项"
L["Buyouts"] = "一口价"
L["Shop Filters"] = "商店过滤器"
L["Uncheck All"] = "全部不选"
L["Check All"] = "全部选中"
L["These options apply to all characters on your account.\nMaking changes will interupt or reset %s Auction House scans."] = "这些选项适用于你帐号下的所有角色。\n进行更改将中断或重置当前的拍卖行搜索。"
L["Auctions Won Reminder"] = "拍卖成功提醒"
L["Remind me to use or\nequip auctions I've won\nafter leaving %s."] = "在我赢得拍卖后提醒我使用或装备。"
L["Max Item Prices"] = "最大商品价格"
L["Hide auctions above this Item Price, 0 to show all."] = "隐藏超过此价格的拍卖，0则显示全部。"
L["Item Value Source"] = "物品价值来源"
L["TradeSkillMaster price source or custom price source. For a list of price sources type /tsm sources."] = "通过TradeSkillMaster获取价格来源或自定义价格来源。通过/tsm查询价格来源类型。"
L["Not a valid price source or custom price source."] = "不是有效的价格来源或自定义价格来源。"
L["(adds Item Value % column to results, leave blank to disable)"] = "(添加商品价值 % 列到结果中，留空则禁用)"
L["Item Price"] = "商品价格"
L["Mode"] = "模式"
L["Refresh"] = "刷新"
L["Buyouts Refreshed"] = "一口价已刷新"
L["%s\n%sBuyout tracking is reset when closing %s|r"] = "%s\n%s关闭时重置一口价跟踪 %s|r"
L["GetAll Scan Data"] = "全局扫描数据"
L["No GetAll scan data for any realms."] = "所有服务器中均无法获得全局扫描数据"
L["Realm:"] = "服务器:"
L["ago"] = "之前"
L["Delete Data"] = "删除数据"
L["Delete GetAll scan data? %s\n\nThis will interupt or reset %s Auction House scans"] = "确定要删除全局扫描数据吗？ %s\n\n这将中断或重置拍卖行扫描。"
L["GetAll scan data deleted: %s"] = "全局扫描数据已删除： %s"
L["%s version %s"] = "%s 版本 %s"
L["%sSlash Commands|r"] = "%s斜杠命令|r"
L["%s/cs|r - Opens options frame to \"Options\"\n" ..
						"%s/cs buyouts|r - Opens options frame to \"Buyouts\"\n" ..
						"%s/cs getallscandata|r - Opens options frame to \"GetAll Scan Data\"\n" ..
						"%s/cs help|r - Opens options frame to \"Help\"\n" ..
						"%s/cs buyoutbuttonclick|r - Clicks the Buyout button on the Auction House tab.\n                                     Use in a Macro for fast key or mouse bound buying."] = "%s/cs|r - 在设置界面中打开\"设置页\"\n" ..
						"%s/cs buyouts|r - 在选项框中打开\"一口价\"\n" ..
						"%s/cs getallscandata|r - 在设置界面中打开\"全局扫描数据\"\n" ..
						"%s/cs help|r - 在设置界面中打开 \"帮助页\"\n" ..
						"%s/cs buyoutbuttonclick|r - 在设置界面中打开\"一口价页\"\n                                           可在宏中使用快捷键或鼠标绑定购买。"
L["%sNeed More Help?|r"] = "%s需要更多帮助？|r"
L["%sQuestions, Comments, Bugs, and Suggestions|r\n\n" ..
						"https://mods.curse.com/addons/wow/collectionshop"] = "%s问题、错误、意见和建议，请访问|r\n\n" ..
						"https://mods.curse.com/addons/wow/collectionshop"