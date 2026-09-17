-- Put this Script inside a Part in Workspace.
-- The Part becomes a configurable reward pad using Roblox Attributes.
-- Requires ServerScriptService > Modules > RewardService.

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local RewardService = require(
	ServerScriptService
		:WaitForChild("Modules")
		:WaitForChild("RewardService")
)

local pad = script.Parent

-- Create defaults only if the attributes do not exist yet.
if pad:GetAttribute("RewardAmount") == nil then
	pad:SetAttribute("RewardAmount", 100)
end

if pad:GetAttribute("Cooldown") == nil then
	pad:SetAttribute("Cooldown", 2)
end

local busy = false

pad.Touched:Connect(function(hit)
	if busy then
		return
	end

	local character = hit.Parent
	local player = character and Players:GetPlayerFromCharacter(character)

	if not player then
		return
	end

	local rewardAmount = pad:GetAttribute("RewardAmount")
	local cooldown = pad:GetAttribute("Cooldown")

	if typeof(rewardAmount) ~= "number" then
		warn("RewardAmount attribute must be a number")
		return
	end

	if typeof(cooldown) ~= "number" then
		warn("Cooldown attribute must be a number")
		return
	end

	busy = true

	RewardService.AddMoney(player, rewardAmount)

	-- Small visual feedback.
	local oldTransparency = pad.Transparency
	pad.Transparency = math.clamp(oldTransparency + 0.45, 0, 1)

	task.wait(math.max(cooldown, 0))

	pad.Transparency = oldTransparency
	busy = false
end)
