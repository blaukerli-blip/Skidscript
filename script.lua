-- Walk Speed Editor GUI Script
-- This script creates a GUI that allows players to adjust their walk speed

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Default walk speed values
local DEFAULT_WALK_SPEED = 16
local MIN_WALK_SPEED = 5
local MAX_WALK_SPEED = 50

-- Create the main GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WalkSpeedEditor"
screenGui.Parent = player.PlayerGui

-- Create the main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Add corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- Create title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "Walk Speed Editor"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- Add corner radius to title
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleLabel

-- Create current speed display
local currentSpeedLabel = Instance.new("TextLabel")
currentSpeedLabel.Name = "CurrentSpeedLabel"
currentSpeedLabel.Size = UDim2.new(1, -20, 0, 30)
currentSpeedLabel.Position = UDim2.new(0, 10, 0, 50)
currentSpeedLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
currentSpeedLabel.BorderSizePixel = 0
currentSpeedLabel.Text = "Current Speed: " .. humanoid.WalkSpeed
currentSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
currentSpeedLabel.TextScaled = true
currentSpeedLabel.Font = Enum.Font.Gotham
currentSpeedLabel.Parent = mainFrame

-- Add corner radius to current speed label
local currentSpeedCorner = Instance.new("UICorner")
currentSpeedCorner.CornerRadius = UDim.new(0, 6)
currentSpeedCorner.Parent = currentSpeedLabel

-- Create slider frame
local sliderFrame = Instance.new("Frame")
sliderFrame.Name = "SliderFrame"
sliderFrame.Size = UDim2.new(1, -20, 0, 40)
sliderFrame.Position = UDim2.new(0, 10, 0, 90)
sliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
sliderFrame.BorderSizePixel = 0
sliderFrame.Parent = mainFrame

-- Add corner radius to slider frame
local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 6)
sliderCorner.Parent = sliderFrame

-- Create slider background
local sliderBackground = Instance.new("Frame")
sliderBackground.Name = "SliderBackground"
sliderBackground.Size = UDim2.new(0.8, 0, 0, 4)
sliderBackground.Position = UDim2.new(0.1, 0, 0.5, -2)
sliderBackground.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
sliderBackground.BorderSizePixel = 0
sliderBackground.Parent = sliderFrame

-- Add corner radius to slider background
local sliderBgCorner = Instance.new("UICorner")
sliderBgCorner.CornerRadius = UDim.new(0, 2)
sliderBgCorner.Parent = sliderBackground

-- Create slider fill
local sliderFill = Instance.new("Frame")
sliderFill.Name = "SliderFill"
sliderFill.Size = UDim2.new(0, 0, 1, 0)
sliderFill.Position = UDim2.new(0, 0, 0, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
sliderFill.BorderSizePixel = 0
sliderFill.Parent = sliderBackground

-- Add corner radius to slider fill
local sliderFillCorner = Instance.new("UICorner")
sliderFillCorner.CornerRadius = UDim.new(0, 2)
sliderFillCorner.Parent = sliderFill

-- Create slider button
local sliderButton = Instance.new("TextButton")
sliderButton.Name = "SliderButton"
sliderButton.Size = UDim2.new(0, 20, 0, 20)
sliderButton.Position = UDim2.new(0, 0, 0.5, -10)
sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sliderButton.BorderSizePixel = 0
sliderButton.Text = ""
sliderButton.Parent = sliderFrame

-- Add corner radius to slider button
local sliderButtonCorner = Instance.new("UICorner")
sliderButtonCorner.CornerRadius = UDim.new(0, 10)
sliderButtonCorner.Parent = sliderButton

-- Create input field
local inputFrame = Instance.new("Frame")
inputFrame.Name = "InputFrame"
inputFrame.Size = UDim2.new(0.4, 0, 0, 30)
inputFrame.Position = UDim2.new(0.05, 0, 0, 140)
inputFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
inputFrame.BorderSizePixel = 0
inputFrame.Parent = mainFrame

-- Add corner radius to input frame
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = inputFrame

-- Create input text box
local inputTextBox = Instance.new("TextBox")
inputTextBox.Name = "InputTextBox"
inputTextBox.Size = UDim2.new(1, -10, 1, -10)
inputTextBox.Position = UDim2.new(0, 5, 0, 5)
inputTextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
inputTextBox.BorderSizePixel = 0
inputTextBox.Text = tostring(humanoid.WalkSpeed)
inputTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputTextBox.TextScaled = true
inputTextBox.Font = Enum.Font.Gotham
inputTextBox.PlaceholderText = "Speed"
inputTextBox.Parent = inputFrame

-- Add corner radius to input text box
local inputTextBoxCorner = Instance.new("UICorner")
inputTextBoxCorner.CornerRadius = UDim.new(0, 4)
inputTextBoxCorner.Parent = inputTextBox

-- Create set button
local setButton = Instance.new("TextButton")
setButton.Name = "SetButton"
setButton.Size = UDim2.new(0.4, 0, 0, 30)
setButton.Position = UDim2.new(0.55, 0, 0, 140)
setButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
setButton.BorderSizePixel = 0
setButton.Text = "Set Speed"
setButton.TextColor3 = Color3.fromRGB(255, 255, 255)
setButton.TextScaled = true
setButton.Font = Enum.Font.GothamBold
setButton.Parent = mainFrame

-- Add corner radius to set button
local setButtonCorner = Instance.new("UICorner")
setButtonCorner.CornerRadius = UDim.new(0, 6)
setButtonCorner.Parent = setButton

-- Create reset button
local resetButton = Instance.new("TextButton")
resetButton.Name = "ResetButton"
resetButton.Size = UDim2.new(0.4, 0, 0, 30)
resetButton.Position = UDim2.new(0.3, 0, 0, 175)
resetButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
resetButton.BorderSizePixel = 0
resetButton.Text = "Reset"
resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
resetButton.TextScaled = true
resetButton.Font = Enum.Font.GothamBold
resetButton.Parent = mainFrame

-- Add corner radius to reset button
local resetButtonCorner = Instance.new("UICorner")
resetButtonCorner.CornerRadius = UDim.new(0, 6)
resetButtonCorner.Parent = resetButton

-- Variables for slider functionality
local isDragging = false
local currentValue = (humanoid.WalkSpeed - MIN_WALK_SPEED) / (MAX_WALK_SPEED - MIN_WALK_SPEED)

-- Update slider visual
local function updateSlider(value)
    currentValue = math.clamp(value, 0, 1)
    sliderFill.Size = UDim2.new(currentValue, 0, 1, 0)
    sliderButton.Position = UDim2.new(currentValue, -10, 0.5, -10)
    
    local walkSpeed = math.floor(MIN_WALK_SPEED + (currentValue * (MAX_WALK_SPEED - MIN_WALK_SPEED)))
    currentSpeedLabel.Text = "Current Speed: " .. walkSpeed
    inputTextBox.Text = tostring(walkSpeed)
end

-- Initialize slider
updateSlider(currentValue)

-- Slider button events
sliderButton.MouseButton1Down:Connect(function()
    isDragging = true
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local sliderPos = sliderFrame.AbsolutePosition
        local sliderSize = sliderFrame.AbsoluteSize
        
        local relativeX = (mousePos.X - sliderPos.X) / sliderSize.X
        updateSlider(relativeX)
    end
end)

-- Set button functionality
setButton.MouseButton1Click:Connect(function()
    local newSpeed = tonumber(inputTextBox.Text)
    if newSpeed and newSpeed >= MIN_WALK_SPEED and newSpeed <= MAX_WALK_SPEED then
        humanoid.WalkSpeed = newSpeed
        currentValue = (newSpeed - MIN_WALK_SPEED) / (MAX_WALK_SPEED - MIN_WALK_SPEED)
        updateSlider(currentValue)
    else
        inputTextBox.Text = tostring(humanoid.WalkSpeed)
    end
end)

-- Reset button functionality
resetButton.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = DEFAULT_WALK_SPEED
    currentValue = (DEFAULT_WALK_SPEED - MIN_WALK_SPEED) / (MAX_WALK_SPEED - MIN_WALK_SPEED)
    updateSlider(currentValue)
end)

-- Update when character respawns
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    currentValue = (humanoid.WalkSpeed - MIN_WALK_SPEED) / (MAX_WALK_SPEED - MIN_WALK_SPEED)
    updateSlider(currentValue)
end)

-- Update current speed display when walk speed changes
humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    currentSpeedLabel.Text = "Current Speed: " .. humanoid.WalkSpeed
end)

-- Make GUI draggable
local isDraggingGui = false
local dragStart = nil
local startPos = nil

titleLabel.MouseButton1Down:Connect(function()
    isDraggingGui = true
    dragStart = mainFrame.Position
    startPos = UserInputService:GetMouseLocation()
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDraggingGui = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDraggingGui and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = UserInputService:GetMouseLocation() - startPos
        mainFrame.Position = UDim2.new(dragStart.X.Scale, dragStart.X.Offset + delta.X, dragStart.Y.Scale, dragStart.Y.Offset + delta.Y)
    end
end)

print("Walk Speed Editor GUI loaded successfully!")
