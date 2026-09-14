--[[
    BASIC LEADERSTATS EXAMPLE
    Place this Script in ServerScriptService.

    Use this only when you are NOT using the DataStore example.
    If you use 06-DataStore-Saving/PlayerData.server.lua, disable/delete this
    script because the DataStore script already creates leaderstats > Money.
]]

local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local money = Instance.new("IntValue")
    money.Name = "Money"
    money.Value = 0
    money.Parent = leaderstats
end)
