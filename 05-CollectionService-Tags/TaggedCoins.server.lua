-- Place this Script in ServerScriptService.
-- Tag coin Parts with the tag "Coin" using Roblox Studio's Tag Editor.

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local COIN_TAG = "Coin"
local REWARD = 1
local RESPAWN_TIME = 3

local connections = {}

local function setupCoin(coin)
    if not coin:IsA("BasePart") or connections[coin] then
        return
    end

    local busy = false

    connections[coin] = coin.Touched:Connect(function(hit)
        if busy then
            return
        end

        local character = hit.Parent
        local player = character and Players:GetPlayerFromCharacter(character)
        if not player then
            return
        end

        local leaderstats = player:FindFirstChild("leaderstats")
        local money = leaderstats and leaderstats:FindFirstChild("Money")
        if not money then
            return
        end

        busy = true
        money.Value += REWARD

        coin.Transparency = 1
        coin.CanTouch = false
        coin.CanCollide = false

        task.wait(RESPAWN_TIME)

        if coin.Parent then
            coin.Transparency = 0
            coin.CanTouch = true
            busy = false
        end
    end)
end

local function cleanupCoin(coin)
    if connections[coin] then
        connections[coin]:Disconnect()
        connections[coin] = nil
    end
end

for _, coin in CollectionService:GetTagged(COIN_TAG) do
    setupCoin(coin)
end

CollectionService:GetInstanceAddedSignal(COIN_TAG):Connect(setupCoin)
CollectionService:GetInstanceRemovedSignal(COIN_TAG):Connect(cleanupCoin)
