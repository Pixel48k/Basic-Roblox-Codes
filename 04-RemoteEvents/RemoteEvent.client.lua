-- Example LocalScript.
-- This demonstrates firing a RemoteEvent from the client.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local addMoneyEvent = ReplicatedStorage:WaitForChild("AddMoney")

-- Example only. In a real game, fire this from an interaction/button.
addMoneyEvent:FireServer(1)
