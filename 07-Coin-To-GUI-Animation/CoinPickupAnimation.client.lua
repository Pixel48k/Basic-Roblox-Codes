-- Place this LocalScript inside the ScreenGui containing MoneyLabel.
-- Expected RemoteEvent: ReplicatedStorage > CoinCollected
-- The server should fire CoinCollected to the collecting player.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local screenGui = script.Parent
local moneyLabel = screenGui:WaitForChild("MoneyLabel")
local coinCollected = ReplicatedStorage:WaitForChild("CoinCollected")

local function makeParticle(startPosition)
    local dot = Instance.new("Frame")
    dot.AnchorPoint = Vector2.new(0.5, 0.5)
    dot.Size = UDim2.fromOffset(10, 10)
    dot.Position = UDim2.fromOffset(startPosition.X, startPosition.Y)
    dot.BackgroundColor3 = Color3.fromRGB(255, 210, 50)
    dot.BorderSizePixel = 0
    dot.ZIndex = 50
    dot.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = dot

    return dot
end

local function getMoneyTarget()
    local absolutePosition = moneyLabel.AbsolutePosition
    local absoluteSize = moneyLabel.AbsoluteSize

    return Vector2.new(
        absolutePosition.X + absoluteSize.X / 2,
        absolutePosition.Y + absoluteSize.Y / 2
    )
end

local function playPickup(startPosition)
    local target = getMoneyTarget()

    for i = 1, 8 do
        task.delay((i - 1) * 0.035, function()
            local particle = makeParticle(startPosition)

            local offset = Vector2.new(math.random(-25, 25), math.random(-25, 25))
            particle.Position = UDim2.fromOffset(startPosition.X + offset.X, startPosition.Y + offset.Y)

            local tween = TweenService:Create(
                particle,
                TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {
                    Position = UDim2.fromOffset(target.X, target.Y),
                    Size = UDim2.fromOffset(4, 4),
                    BackgroundTransparency = 0.2,
                }
            )

            tween:Play()
            tween.Completed:Connect(function()
                particle:Destroy()
            end)
        end)
    end
end

coinCollected.OnClientEvent:Connect(function(screenPosition)
    if typeof(screenPosition) ~= "Vector2" then
        return
    end

    playPickup(screenPosition)
end)
