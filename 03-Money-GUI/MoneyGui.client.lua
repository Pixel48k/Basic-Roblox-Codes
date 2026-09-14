-- Robust + adaptive Money GUI controller.
-- Works whether this LocalScript is directly inside the Money TextLabel
-- or anywhere inside the same ScreenGui.
--
-- Small money changes count almost one-by-one.
-- Large money changes automatically use bigger steps so the GUI catches up
-- quickly instead of taking many seconds.

local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function findMoneyLabel()
    if script.Parent:IsA("TextLabel") then
        return script.Parent
    end

    local screenGui = script:FindFirstAncestorOfClass("ScreenGui")

    if screenGui then
        local named = screenGui:FindFirstChild("MoneyLabel", true)

        if named and named:IsA("TextLabel") then
            return named
        end

        for _, object in screenGui:GetDescendants() do
            if object:IsA("TextLabel") then
                local nameLooksRight = string.find(string.lower(object.Name), "money", 1, true) ~= nil
                local textLooksRight = string.find(string.upper(object.Text), "MONEY", 1, true) ~= nil

                if nameLooksRight or textLooksRight then
                    return object
                end
            end
        end
    end

    local named = playerGui:FindFirstChild("MoneyLabel", true)

    if named and named:IsA("TextLabel") then
        return named
    end

    for _, object in playerGui:GetDescendants() do
        if object:IsA("TextLabel") then
            local nameLooksRight = string.find(string.lower(object.Name), "money", 1, true) ~= nil
            local textLooksRight = string.find(string.upper(object.Text), "MONEY", 1, true) ~= nil

            if nameLooksRight or textLooksRight then
                return object
            end
        end
    end

    return nil
end

local moneyLabel = findMoneyLabel()

if not moneyLabel then
    warn("Money GUI: could not find a TextLabel for the money display")
    return
end

local leaderstats = player:WaitForChild("leaderstats")
local money = leaderstats:WaitForChild("Money")

local PREFIX = "MONEY: "

-- Maximum number of visible counter updates for one large jump.
-- Smaller value = faster large rewards.
-- Larger value = smoother large rewards.
local MAX_VISIBLE_STEPS = 45

-- Delay between visible updates.
local STEP_DELAY = 0.012

local displayedValue = money.Value
local targetValue = money.Value
local workerRunning = false

local function updateText()
    moneyLabel.Text = PREFIX .. tostring(displayedValue)
end

local function getAdaptiveStep(distance)
    -- Small rewards still count one-by-one.
    if distance <= 25 then
        return 1
    end

    -- For larger jumps, choose a step size that finishes in roughly
    -- MAX_VISIBLE_STEPS updates or fewer.
    return math.max(1, math.ceil(distance / MAX_VISIBLE_STEPS))
end

local function runCounter()
    if workerRunning then
        return
    end

    workerRunning = true

    while displayedValue ~= targetValue do
        local difference = targetValue - displayedValue
        local distance = math.abs(difference)
        local step = getAdaptiveStep(distance)

        if difference > 0 then
            displayedValue = math.min(displayedValue + step, targetValue)
        else
            displayedValue = math.max(displayedValue - step, targetValue)
        end

        updateText()
        task.wait(STEP_DELAY)
    end

    workerRunning = false

    -- Handles a Money change occurring in the tiny gap after the loop ends.
    if displayedValue ~= targetValue then
        task.defer(runCounter)
    end
end

-- Immediately show the already-loaded DataStore value on join.
updateText()

money:GetPropertyChangedSignal("Value"):Connect(function()
    targetValue = money.Value
    runCounter()
end)
