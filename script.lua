-- Walk Speed Editor for Xeno Executor (GitHub Raw Compatible)
-- This script is optimized for executors and raw loading

-- Wait for game to load
wait(1)

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Get player and character
local player = Players.LocalPlayer
if not player then
    print("Player not found!")
    return
end

local character = player.Character
if not character then
    character = player.CharacterAdded:Wait()
end

local humanoid = character:FindFirstChild("Humanoid")
if not humanoid then
    humanoid = character:WaitForChild("Humanoid")
end

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WalkSpeedGUI"
screenGui.Parent = player.PlayerGui

-- Main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 150)
frame.Position = UDim2.new(0.5, -125, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Title bar
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
title.BorderSizePixel = 0
title.Text = "Walk Speed Editor"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

-- Speed display
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -20, 0, 25)
speedLabel.Position = UDim2.new(0, 10, 0, 40)
speedLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
speedLabel.BorderSizePixel = 0
speedLabel.Text = "Current Speed: " .. humanoid.WalkSpeed
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.Gotham
speedLabel.Parent = frame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 5)
speedCorner.Parent = speedLabel

-- Input box
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0.6, 0, 0, 25)
inputBox.Position = UDim2.new(0.05, 0, 0, 75)
inputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
inputBox.BorderSizePixel = 0
inputBox.Text = tostring(humanoid.WalkSpeed)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.TextScaled = true
inputBox.Font = Enum.Font.Gotham
inputBox.PlaceholderText = "Speed"
inputBox.Parent = frame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 5)
inputCorner.Parent = inputBox

-- Set button
local setButton = Instance.new("TextButton")
setButton.Size = UDim2.new(0.25, 0, 0, 25)
setButton.Position = UDim2.new(0.7, 0, 0, 75)
setButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
setButton.BorderSizePixel = 0
setButton.Text = "Set"
setButton.TextColor3 = Color3.fromRGB(255, 255, 255)
setButton.TextScaled = true
setButton.Font = Enum.Font.GothamBold
setButton.Parent = frame

local setCorner = Instance.new("UICorner")
setCorner.CornerRadius = UDim.new(0, 5)
setCorner.Parent = setButton

-- Reset button
local resetButton = Instance.new("TextButton")
resetButton.Size = UDim2.new(0.4, 0, 0, 25)
resetButton.Position = UDim2.new(0.3, 0, 0, 110)
resetButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
resetButton.BorderSizePixel = 0
resetButton.Text = "Reset to 16"
resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
resetButton.TextScaled = true
resetButton.Font = Enum.Font.GothamBold
resetButton.Parent = frame

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 5)
resetCorner.Parent = resetButton

-- Update function
local function updateSpeed()
    if humanoid then
        speedLabel.Text = "Current Speed: " .. humanoid.WalkSpeed
        inputBox.Text = tostring(humanoid.WalkSpeed)
    end
end

-- Button events
setButton.MouseButton1Click:Connect(function()
    local newSpeed = tonumber(inputBox.Text)
    if newSpeed and newSpeed >= 5 and newSpeed <= 100 and humanoid then
        humanoid.WalkSpeed = newSpeed
        updateSpeed()
    else
        inputBox.Text = tostring(humanoid.WalkSpeed or 16)
    end
end)

resetButton.MouseButton1Click:Connect(function()
    if humanoid then
        humanoid.WalkSpeed = 16
        updateSpeed()
    end
end)

-- Character respawn
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    updateSpeed()
end)

-- Update when walk speed changes
if humanoid then
    humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(updateSpeed)
end

-- Make draggable
local isDragging = false
local dragStart = nil
local startPos = nil

title.MouseButton1Down:Connect(function()
    isDragging = true
    dragStart = frame.Position
    startPos = UserInputService:GetMouseLocation()
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = UserInputService:GetMouseLocation() - startPos
        frame.Position = UDim2.new(dragStart.X.Scale, dragStart.X.Offset + delta.X, dragStart.Y.Scale, dragStart.Y.Offset + delta.Y)
    end
end)

-- Keep script alive
RunService.Heartbeat:Connect(function()
    -- Script stays active
end)

print("Walk Speed Editor loaded successfully!")
print("Drag the title bar to move the GUI")
print("Enter a speed (5-100) and click Set")
print("Click Reset to return to default speed (16)")
