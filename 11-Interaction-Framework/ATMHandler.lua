local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local RewardService = require(
	ServerScriptService
		:WaitForChild("Modules")
		:WaitForChild("RewardService")
)

-- Create the RemoteEvent automatically if it does not already exist.
-- This prevents ATMHandler from getting stuck forever on WaitForChild.
local MoneyCollected = ReplicatedStorage:FindFirstChild("MoneyCollected")

if not MoneyCollected then
	MoneyCollected = Instance.new("RemoteEvent")
	MoneyCollected.Name = "MoneyCollected"
	MoneyCollected.Parent = ReplicatedStorage
elseif not MoneyCollected:IsA("RemoteEvent") then
	error("ReplicatedStorage.MoneyCollected must be a RemoteEvent")
end

local ATMHandler = {}
ATMHandler.Type = "ATM"

function ATMHandler.CanInteract(player, atm)
	local rewardAmount = atm:GetAttribute("RewardAmount")

	if typeof(rewardAmount) ~= "number" or rewardAmount <= 0 then
		warn(
			"ATM has an invalid RewardAmount:",
			atm:GetFullName(),
			rewardAmount
		)
		return false
	end

	return true
end

function ATMHandler.Interact(player, atm)
	local rewardAmount = atm:GetAttribute("RewardAmount")
	rewardAmount = math.floor(rewardAmount)

	local success = RewardService.AddMoney(player, rewardAmount)

	if not success then
		warn(
			"ATM reward failed for player:",
			player.Name,
			"ATM:",
			atm:GetFullName()
		)
		return false
	end

	MoneyCollected:FireClient(player, rewardAmount)

	print(
		"ATM reward successful:",
		player.Name,
		"received",
		rewardAmount,
		"from",
		atm:GetFullName()
	)

	return true
end

return ATMHandler
