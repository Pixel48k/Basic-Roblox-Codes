local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local RewardService = require(
	ServerScriptService
		:WaitForChild("Modules")
		:WaitForChild("RewardService")
)

local MoneyCollected = ReplicatedStorage:WaitForChild("MoneyCollected")

local ATMHandler = {}
ATMHandler.Type = "ATM"

function ATMHandler.CanInteract(player, atm)
	local rewardAmount = atm:GetAttribute("RewardAmount")

	return typeof(rewardAmount) == "number"
		and rewardAmount > 0
end

function ATMHandler.Interact(player, atm)
	local rewardAmount = atm:GetAttribute("RewardAmount") or 100
	rewardAmount = math.floor(rewardAmount)

	local success = RewardService.AddMoney(player, rewardAmount)

	if not success then
		return false
	end

	MoneyCollected:FireClient(player, rewardAmount)

	return true
end

return ATMHandler
