-- Place this LocalScript inside the ScreenGui that contains MoneyLabel.
-- MoneyLabel should be a TextLabel.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local moneyLabel = script.Parent:WaitForChild("MoneyLabel")

local leaderstats = player:WaitForChild("leaderstats")
local money = leaderstats:WaitForChild("Money")

local displayedValue = money.Value
moneyLabel.Text = tostring(displayedValue)

local function animateTo(target)
    local start = displayedValue
    local difference = target - start
    local steps = math.max(math.abs(difference), 1)
    local duration = math.clamp(steps * 0.025, 0.15, 0.8)

    for i = 1, steps do
        local alpha = i / steps
        displayedValue = math.round(start + difference * alpha)
        moneyLabel.Text = tostring(displayedValue)
        task.wait(duration / steps)
    end

    displayedValue = target
    moneyLabel.Text = tostring(target)

    local originalSize = moneyLabel.Size
    local grow = TweenService:Create(
        moneyLabel,
        TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = originalSize + UDim2.fromOffset(8, 8)}
    )
    grow:Play()
    grow.Completed:Wait()

    TweenService:Create(
        moneyLabel,
        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = originalSize}
    ):Play()
end

money:GetPropertyChangedSignal("Value"):Connect(function()
    animateTo(money.Value)
end)
