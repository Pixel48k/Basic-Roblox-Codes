-- Script
-- Place in ServerScriptService while testing, then delete/disable it.
-- Expected hierarchy:
-- ServerScriptService
-- ├── Modules
-- │   └── RewardService (ModuleScript)
-- └── RewardTest (Script)

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local RewardService = require(
	ServerScriptService:WaitForChild("Modules"):WaitForChild("RewardService")
)

Players.PlayerAdded:Connect(function(player)
	player:WaitForChild("leaderstats")
	player.leaderstats:WaitForChild("Money")

	task.wait(3)

	local success = RewardService.AddMoney(player, 25)

	if success then
		print("RewardService test: gave", player.Name, "25 Money")
	end
end)
