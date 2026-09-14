-- Example visual animation for a coin.
-- Best placed in a LocalScript that has access to the coin Part.

local RunService = game:GetService("RunService")

local coin = script.Parent
local startPosition = coin.Position
local timePassed = 0

RunService.RenderStepped:Connect(function(dt)
    timePassed += dt

    local hoverOffset = math.sin(timePassed * 2) * 0.35
    coin.CFrame = CFrame.new(startPosition + Vector3.new(0, hoverOffset, 0))
        * CFrame.Angles(0, math.rad(timePassed * 90), 0)
end)
