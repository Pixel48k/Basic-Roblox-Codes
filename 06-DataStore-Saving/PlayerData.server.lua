-- Place this Script in ServerScriptService.
-- Publish the game and enable:
-- Game Settings > Security > Enable Studio Access to API Services

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local moneyStore = DataStoreService:GetDataStore("PlayerMoney_v1")

local DEFAULT_MONEY = 0

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
    local success, result = pcall(function()
        return moneyStore:GetAsync(getKey(player))
    end)

    local startingMoney = DEFAULT_MONEY

    if success then
        if typeof(result) == "number" then
            startingMoney = result
        end
    else
        warn("Failed to load data for", player.Name, result)
    end

    createLeaderstats(player, startingMoney)
end

local function savePlayer(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    local money = leaderstats and leaderstats:FindFirstChild("Money")

    if not money then
        return
    end

    local success, err = pcall(function()
        moneyStore:UpdateAsync(getKey(player), function()
            return money.Value
        end)
    end)

    if not success then
        warn("Failed to save data for", player.Name, err)
    end
end

Players.PlayerAdded:Connect(loadPlayer)
Players.PlayerRemoving:Connect(savePlayer)

game:BindToClose(function()
    for _, player in Players:GetPlayers() do
        savePlayer(player)
    end
end)
