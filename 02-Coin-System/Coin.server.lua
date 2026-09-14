-- Put this Script inside each coin Part, or adapt it for tagged coins.
-- Expected: the coin is a BasePart.

local Players = game:GetService("Players")

local coin = script.Parent
local RESPAWN_TIME = 3
local REWARD = 1
local SOUND_ID = "rbxassetid://75104361057574"

local busy = false

local sound = coin:FindFirstChild("CollectSound")
if not sound then
    sound = Instance.new("Sound")
    sound.Name = "CollectSound"
    sound.SoundId = SOUND_ID
    sound.Volume = 1
    sound.Parent = coin
end

local function setCoinVisible(isVisible)
    coin.Transparency = isVisible and 0 or 1
    coin.CanCollide = false
    coin.CanTouch = isVisible
end

coin.Touched:Connect(function(hit)
    if busy then
        return
    end

    local character = hit.Parent
    if not character then
        return
    end

    local player = Players:GetPlayerFromCharacter(character)
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

    sound:Play()
    setCoinVisible(false)

    task.wait(RESPAWN_TIME)

    setCoinVisible(true)
    busy = false
end)
