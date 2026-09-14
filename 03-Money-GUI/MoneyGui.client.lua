-- Robust Money GUI controller.
-- This version works whether the LocalScript is:
--   1) directly inside the Money TextLabel, OR
--   2) anywhere inside the same ScreenGui.
--
-- It never changes the label's Size or adds UIScale, so it will not clip or
-- distort the existing UI. It also uses only one counter worker, preventing
-- overlapping animations from desynchronizing the displayed value.

local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function findMoneyLabel()
    -- Best case: the LocalScript is directly inside the TextLabel.
    if script.Parent:IsA("TextLabel") then
        return script.Parent
    end

    -- Search the script's nearest ScreenGui first.
    local screenGui = script:FindFirstAncestorOfClass("ScreenGui")

    if screenGui then
        local named = screenGui:FindFirstChild("MoneyLabel", true)
        if named and named:IsA("TextLabel") then
            return named
        end

        -- Fallback: find a TextLabel whose name or text looks like the money UI.
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

    -- Last fallback: search all PlayerGui descendants.
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
local STEP_DELAY = 0.012

local displayedValue = money.Value
local targetValue = money.Value
local workerRunning = false

local function updateText()
    moneyLabel.Text = PREFIX .. tostring(displayedValue)
end

local function runCounter()
    if workerRunning then
        return
    end

    workerRunning = true

    while displayedValue ~= targetValue do
        if displayedValue < targetValue then
            displayedValue += 1
        else
            displayedValue -= 1
        end

        updateText()
        task.wait(STEP_DELAY)
    end

    workerRunning = false

    -- If Money changed in the tiny gap after the loop ended, continue again.
    if displayedValue ~= targetValue then
        task.defer(runCounter)
    end
end

-- Show the already-loaded DataStore value immediately when the player joins.
updateText()

money:GetPropertyChangedSignal("Value"):Connect(function()
    targetValue = money.Value
    runCounter()
end)
