--[[
    PLAYER MONEY DATASTORE
    Place this Script inside ServerScriptService.

    IMPORTANT:
    - Publish the experience before testing DataStores.
    - Enable Studio Access to API Services.
    - Do NOT run a separate Leaderstats script at the same time.
      This script creates leaderstats and Money for you.
]]

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local MoneyStore = DataStoreService:GetDataStore("PlayerMoney_v1")

local DEFAULT_MONEY = 0
local AUTOSAVE_INTERVAL = 60

local function getKey(player)
    return "Player_" .. player.UserId
end

local function createLeaderstats(player, startingMoney)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local money = Instance.new("IntValue")
    money.Name = "Money"
    money.Value = startingMoney
    money.Parent = leaderstats
end

local function loadPlayer(player)
    local success, savedMoney = pcall(function()
        return MoneyStore:GetAsync(getKey(player))
    end)

    if success then
        if typeof(savedMoney) == "number" then
            createLeaderstats(player, savedMoney)
            print("Loaded", player.Name, "with", savedMoney, "Money")
        else
            createLeaderstats(player, DEFAULT_MONEY)
            print("No saved data for", player.Name, "- starting at", DEFAULT_MONEY)
        end
    else
        warn("Could not load data for", player.Name, savedMoney)
        createLeaderstats(player, DEFAULT_MONEY)
    end
end

local function savePlayer(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    local money = leaderstats and leaderstats:FindFirstChild("Money")

    if not money then
        return
    end

    local moneyToSave = money.Value

    local success, err = pcall(function()
        MoneyStore:UpdateAsync(getKey(player), function()
            return moneyToSave
        end)
    end)

    if success then
        print("Saved", player.Name, "with", moneyToSave, "Money")
    else
        warn("Could not save data for", player.Name, err)
    end
end

Players.PlayerAdded:Connect(loadPlayer)
Players.PlayerRemoving:Connect(savePlayer)

-- Autosave while the server is running.
task.spawn(function()
    while true do
        task.wait(AUTOSAVE_INTERVAL)

        for _, player in Players:GetPlayers() do
            task.spawn(savePlayer, player)
        end
    end
end)

-- Save everyone when the server shuts down.
game:BindToClose(function()
    for _, player in Players:GetPlayers() do
        savePlayer(player)
    end
end)
