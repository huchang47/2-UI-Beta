local addonName, _ = ... ---@type string, table
local addon = LibStub('AceAddon-3.0'):GetAddon(addonName)

---@class Client: AceModule
local Client = addon:NewModule("Client")

Client.Version = select(4, GetBuildInfo())

function Client:IsRetail()
    return Client.Version > 110000
end

function Client:IsWlk()
    return Client.Version == 30403
end