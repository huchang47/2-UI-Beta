--------------------nReputation--------------------------------------------------------------------## Author: Grimsbain  ## Version: 1.4-release
local nRep = {}
function nRep:SetWatched(newFaction)
    if ( running ) then return end
    running = true
    local i = 1
    local wasCollapsed = {}
    local watchedFaction = select(1,GetWatchedFactionInfo())
    while i <= GetNumFactions() do
        local name, _, _, _, _, _, _, _, isHeader, isCollapsed, _, _, _, _, _, _ = GetFactionInfo(i)
        if ( isHeader ) then
            if ( name == FACTION_INACTIVE ) then break end
            if ( isCollapsed ) then ExpandFactionHeader(i) wasCollapsed[name] = true end
        end
        if ( name == newFaction ) then
            if ( watchedFaction ~= newFaction ) then SetWatchedFactionIndex(i) end
            break
        end
        i = i + 1
    end
    i = 1
    while i <= GetNumFactions() do
        local name, _, _, _, _, _, _, _, isHeader, isCollapsed, _, _, _, _, _, _ = GetFactionInfo(i)
        if ( isHeader and not isCollapsed and wasCollapsed[name] ) then
            CollapseFactionHeader(i)
            wasCollapsed[name] = nil
        end
        i = i + 1
    end
    running = nil
end
function nReputation_OnLoad(self) self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE") end
function nReputation_OnEvent(self, event, ...)
	if ( event == "CHAT_MSG_COMBAT_FACTION_CHANGE" ) then
		local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = ...
		local pattern_standing_inc = string.gsub(string.gsub(FACTION_STANDING_INCREASED, "(%%s)", "(.+)"), "(%%d)", "(%%d+)")
		local s1, e1, faction, amount = string.find(arg1, pattern_standing_inc)
		if ( s1 ~= nil and amount ~= nil ) then
			if ( faction ~= GUILD ) then nRep:SetWatched(faction) end
		end
	end
end