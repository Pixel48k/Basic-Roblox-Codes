local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local MoneyCollected = ReplicatedStorage:WaitForChild("MoneyCollected")

local screenGui = playerGui:FindFirstChild("MoneyNotificationGui")

if not screenGui then
	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MoneyNotificationGui"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.Parent = playerGui
end

-- Position settings
local X_POSITION = 0.86
local START_Y = 0.78
local END_Y = 0.50

local RISE_TIME = 1.15
local FADE_START = 0.70

local function createNotification(amount)
	local notification = Instance.new("TextLabel")
	notification.Name = "MoneyPopup"
	notification.AnchorPoint = Vector2.new(0.5, 0.5)
	notification.Size = UDim2.fromOffset(220, 52)
	notification.Position = UDim2.fromScale(X_POSITION, START_Y)
	notification.BackgroundTransparency = 1
	notification.Text = "+$" .. tostring(amount)
	notification.TextScaled = true
	notification.Font = Enum.Font.GothamBold
	notification.TextTransparency = 0
	notification.Parent = screenGui

	-- Every collection creates its own independent popup.
	local riseTween = TweenService:Create(
		notification,
		TweenInfo.new(
			RISE_TIME,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		),
		{
			Position = UDim2.fromScale(
				X_POSITION,
				END_Y
			)
		}
	)

	riseTween:Play()

	-- Let it travel most of the way before fading.
	task.delay(RISE_TIME * FADE_START, function()
		if not notification.Parent then
			return
		end

		local remainingTime = RISE_TIME * (1 - FADE_START)

		local fadeTween = TweenService:Create(
			notification,
			TweenInfo.new(
				remainingTime,
				Enum.EasingStyle.Linear
			),
			{
				TextTransparency = 1
			}
		)

		fadeTween:Play()
	end)

	riseTween.Completed:Once(function()
		notification:Destroy()
	end)
end

MoneyCollected.OnClientEvent:Connect(function(amount)
	if typeof(amount) ~= "number" then
		return
	end

	createNotification(amount)
end)
