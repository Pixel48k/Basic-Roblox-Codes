-- Place this LocalScript inside the ScreenGui that contains MoneyLabel.
-- MoneyLabel should be a TextLabel.
--
-- This version uses ONE animation worker. If Money changes again while the
-- counter is still animating, it simply updates the target instead of
-- starting another competing animation.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local moneyLabel = script.Parent:WaitForChild("MoneyLabel")

local leaderstats = player:WaitForChild("leaderstats")
local money = leaderstats:WaitForChild("Money")

local PREFIX = "MONEY: "

-- Use UIScale for the small pop effect so the TextLabel's actual Size does
-- not get corrupted by overlapping tweens.
local uiScale = moneyLabel:FindFirstChildOfClass("UIScale")
if not uiScale then
    uiScale = Instance.new("UIScale")
    uiScale.Scale = 1
    uiScale.Parent = moneyLabel
end

local displayedValue = money.Value
local targetValue = money.Value
local animationRunning = false

local function updateText(value)
    moneyLabel.Text = PREFIX .. tostring(value)
end

local function playPop()
    local grow = TweenService:Create(
        uiScale,
        TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Scale = 1.08}
    )

    local shrink = TweenService:Create(
        uiScale,
        TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Scale = 1}
    )

    grow:Play()
    grow.Completed:Wait()
    shrink:Play()
    shrink.Completed:Wait()
end

local function runCounter()
    if animationRunning then
        return
    end

    animationRunning = true

    while true do
        -- Always chase the newest target value.
        while displayedValue ~= targetValue do
            local difference = targetValue - displayedValue
            local distance = math.abs(difference)

            if difference > 0 then
                displayedValue += 1
            else
                displayedValue -= 1
            end

            updateText(displayedValue)

            -- Large gaps count very quickly; small gaps remain readable.
            local delayPerNumber = math.clamp(0.08 / math.max(distance, 1), 0.002, 0.02)
            task.wait(delayPerNumber)
        end

        playPop()

        -- Money may have changed while the pop animation was playing.
        if displayedValue == targetValue then
            break
        end
    end

    animationRunning = false

    -- Protect against a value change in the tiny gap before the flag reset.
    if displayedValue ~= targetValue then
        task.defer(runCounter)
    end
end

-- On join, immediately show the already-loaded DataStore value.
-- We do NOT count from 0 to the saved amount.
updateText(displayedValue)

money:GetPropertyChangedSignal("Value"):Connect(function()
    targetValue = money.Value
    runCounter()
end)
