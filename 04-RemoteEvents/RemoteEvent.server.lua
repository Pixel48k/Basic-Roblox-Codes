-- Place this Script in ServerScriptService.
-- Create a RemoteEvent named "AddMoney" inside ReplicatedStorage first.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local addMoneyEvent = ReplicatedStorage:WaitForChild("AddMoney")

addMoneyEvent.OnServerEvent:Connect(function(player, amount)
    if typeof(amount) ~= "number" then
        return
    end

    -- Never trust the client blindly.
    amount = math.clamp(math.floor(amount), 0, 10)

    local leaderstats = player:FindFirstChild("leaderstats")
    local money = leaderstats and leaderstats:FindFirstChild("Money")

    if money then
        money.Value += amount
    end
end)
