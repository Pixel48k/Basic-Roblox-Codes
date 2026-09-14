-- ModuleScript
-- Recommended location in Roblox Studio:
-- ServerScriptService > Modules > RewardService

local RewardService = {}

function RewardService.AddMoney(player, amount)
	if typeof(player) ~= "Instance" or not player:IsA("Player") then
		warn("RewardService.AddMoney expected a Player")
		return false
	end

	if typeof(amount) ~= "number" then
		warn("RewardService.AddMoney expected a number")
		return false
	end

	amount = math.floor(amount)

	if amount <= 0 then
		warn("RewardService.AddMoney amount must be greater than 0")
		return false
	end

	local leaderstats = player:FindFirstChild("leaderstats")
	local money = leaderstats and leaderstats:FindFirstChild("Money")

	if not money or not money:IsA("IntValue") then
		warn("RewardService could not find leaderstats.Money for " .. player.Name)
		return false
	end

	money.Value += amount
	return true
end

return RewardService
