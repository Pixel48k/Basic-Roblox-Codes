-- Put this Script in the same Part that contains the ProximityPrompt.
-- Requires ServerScriptService > Modules > RewardService.
-- The ATM gives money ONLY when the ProximityPrompt is triggered.

local ServerScriptService = game:GetService("ServerScriptService")

local RewardService = require(
	ServerScriptService
		:WaitForChild("Modules")
		:WaitForChild("RewardService")
)

local atmPart = script.Parent
local prompt = atmPart:WaitForChild("ProximityPrompt")

local DEFAULT_REWARD = 500
local DEFAULT_COOLDOWN = 5

-- Per-player cooldowns so one player using the ATM does not block everyone else.
local onCooldown = {}

local function getRewardAmount()
	local amount = atmPart:GetAttribute("RewardAmount")

	if typeof(amount) ~= "number" then
		return DEFAULT_REWARD
	end

	return math.max(0, math.floor(amount))
end

local function getCooldown()
	local cooldown = atmPart:GetAttribute("Cooldown")

	if typeof(cooldown) ~= "number" then
		return DEFAULT_COOLDOWN
	end

	return math.max(0, cooldown)
end

prompt.Triggered:Connect(function(player)
	if onCooldown[player] then
		return
	end

	local rewardAmount = getRewardAmount()
	local cooldown = getCooldown()

	if rewardAmount <= 0 then
		warn("ATM RewardAmount must be greater than 0")
		return
	end

	onCooldown[player] = true

	local success = RewardService.AddMoney(player, rewardAmount)

	if success then
		print(player.Name .. " received " .. rewardAmount .. " Money from the ATM")
	end

	task.delay(cooldown, function()
		onCooldown[player] = nil
	end)
end)
