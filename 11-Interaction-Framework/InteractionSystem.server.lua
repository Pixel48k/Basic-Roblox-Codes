local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")

local handlersFolder = ServerScriptService
	:WaitForChild("Modules")
	:WaitForChild("InteractionHandlers")

local INTERACTABLE_TAG = "Interactable"
local DISTANCE_TOLERANCE = 3

local handlers = {}
local connections = {}
local cooldowns = {}

local function loadHandlers()
	for _, moduleScript in ipairs(handlersFolder:GetChildren()) do
		if not moduleScript:IsA("ModuleScript") then
			continue
		end

		local ok, handler = pcall(require, moduleScript)

		if not ok then
			warn("Could not load interaction handler:", moduleScript.Name, handler)
			continue
		end

		if typeof(handler) ~= "table"
			or typeof(handler.Type) ~= "string"
			or typeof(handler.Interact) ~= "function" then

			warn("Invalid interaction handler:", moduleScript.Name)
			continue
		end

		handlers[handler.Type] = handler
		print("Loaded interaction handler:", handler.Type)
	end
end

local function getPlayerRoot(player)
	local character = player.Character

	if not character then
		return nil
	end

	return character:FindFirstChild("HumanoidRootPart")
end

local function getPromptPart(prompt)
	return prompt:FindFirstAncestorWhichIsA("BasePart")
end

local function isPlayerCloseEnough(player, prompt)
	local root = getPlayerRoot(player)
	local promptPart = getPromptPart(prompt)

	if not root or not promptPart then
		return false
	end

	local distance = (root.Position - promptPart.Position).Magnitude
	local allowedDistance = prompt.MaxActivationDistance + DISTANCE_TOLERANCE

	return distance <= allowedDistance
end

local function getCooldown(object)
	local value = object:GetAttribute("Cooldown")

	if typeof(value) ~= "number" then
		return 0
	end

	return math.max(0, value)
end

local function isOnCooldown(player, object)
	local playerCooldowns = cooldowns[player]

	if not playerCooldowns then
		return false
	end

	local readyAt = playerCooldowns[object]

	return readyAt ~= nil
		and os.clock() < readyAt
end

local function startCooldown(player, object)
	cooldowns[player] = cooldowns[player] or {}
	cooldowns[player][object] = os.clock() + getCooldown(object)
end

local function setupInteractable(object)
	if connections[object] then
		return
	end

	local prompt = object:FindFirstChildWhichIsA("ProximityPrompt", true)

	if not prompt then
		warn("Interactable has no ProximityPrompt:", object:GetFullName())
		return
	end

	if not getPromptPart(prompt) then
		warn("ProximityPrompt is not inside a BasePart:", prompt:GetFullName())
		return
	end

	local interactionType = object:GetAttribute("InteractionType")

	if typeof(interactionType) ~= "string" then
		warn("Interactable is missing InteractionType:", object:GetFullName())
		return
	end

	local handler = handlers[interactionType]

	if not handler then
		warn("No handler exists for InteractionType:", interactionType)
		return
	end

	connections[object] = prompt.Triggered:Connect(function(player)
		if not isPlayerCloseEnough(player, prompt) then
			return
		end

		if isOnCooldown(player, object) then
			return
		end

		if handler.CanInteract then
			local ok, canInteract = pcall(handler.CanInteract, player, object)

			if not ok then
				warn("CanInteract failed for:", interactionType, canInteract)
				return
			end

			if not canInteract then
				return
			end
		end

		local ok, success = pcall(handler.Interact, player, object)

		if not ok then
			warn("Interaction handler failed:", interactionType, success)
			return
		end

		if success == false then
			return
		end

		startCooldown(player, object)
	end)

	print("Connected interactable:", object:GetFullName(), "Type:", interactionType)
end

local function removeInteractable(object)
	local connection = connections[object]

	if connection then
		connection:Disconnect()
		connections[object] = nil
	end

	for _, playerCooldowns in pairs(cooldowns) do
		playerCooldowns[object] = nil
	end
end

loadHandlers()

for _, object in ipairs(CollectionService:GetTagged(INTERACTABLE_TAG)) do
	setupInteractable(object)
end

CollectionService:GetInstanceAddedSignal(INTERACTABLE_TAG):Connect(function(object)
	task.defer(setupInteractable, object)
end)

CollectionService:GetInstanceRemovedSignal(INTERACTABLE_TAG):Connect(removeInteractable)

Players.PlayerRemoving:Connect(function(player)
	cooldowns[player] = nil
end)
