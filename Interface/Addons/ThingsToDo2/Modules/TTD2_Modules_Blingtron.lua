if(ThingsToDo2 == nil) then
	ThingsToDo2 = {}
end
local ttd2 = ThingsToDo2

if(ttd2.lib == nil) then
	ttd2.lib = {}
end
local lib = ttd2.lib

if(ttd2.options == nil) then
	ttd2.options = {}
end
local options = ttd2.options

if(ttd2.mod == nil) then
	ttd2.mod = {}
end
local mod = ttd2.mod

--this module
ttd2.Blingtron = {}
local this = ttd2.Blingtron
this.Name = "Blingtron"

--[[
The purpose of this module is to check all the various collectibles from Blingtrons
]]

this.private = { set = false }
function this.private.Validate()
	if(this.private.set == false) then
		this.private.Init()
		this.private.set = true
	end
	
	return
end

function this.private.Init()
	if(this.private.set) then
		return
	end
	
	this.private.data =
	{
		achievementId = 9071,
		questId = 34774
	}
	
	return
end

function this.private.update()
	this.private.Validate()
	
	local out = lib.chat.output
	out.ClearBuffer()
	
	--[[
	--]]
	
	--out.StoreDone("PLACEHOLDER!")
	
	return
end

function this.CheckStatus()
	this.private.Validate()
	
	this.private.update()
	if(lib.chat.output.GetNumLines() == 0) then
		return false
	end
	
	return true
end

function this.Script()
	this.private.Validate()
	
	this.private.update()
	lib.chat.output.PrintmyModule(this.Name)
	
	return
end

mod[#mod+1] =
{
	CheckStatus	= this.CheckStatus,
	Text		= this.Name,
	Script		= this.Script
}