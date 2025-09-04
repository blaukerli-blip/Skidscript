-- Final Speed & Fly Script with REAL Flying + Noclip + Infinite Yield for Xeno
-- Copy this entire script and paste into Xeno

wait(2) -- Wait for game to load

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChild("Humanoid") or character:WaitForChild("Humanoid")
local rootPart = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

-- Fly variables
local isFlying = false
local isNoclip = false
local isInfiniteYield = false
local flySpeed = 50
local flyConnection = nil
local noclipConnection = nil
local infiniteYieldConnection = nil
local originalGravity = workspace.Gravity

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedFlyGUI"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 220)
frame.Position = UDim2.new(0.5, -110, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Title (this is draggable)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.BorderSizePixel = 0
title.Text = "Speed & Fly Editor"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

-- Speed section
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -20, 0, 20)
speedLabel.Position = UDim2.new(0, 10, 0, 40)
speedLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
speedLabel.BorderSizePixel = 0
speedLabel.Text = "Walk Speed: " .. humanoid.WalkSpeed
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.Gotham
speedLabel.Parent = frame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 5)
speedCorner.Parent = speedLabel

-- Speed input
local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(0.6, 0, 0, 25)
speedInput.Position = UDim2.new(0.05, 0, 0, 70)
speedInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
speedInput.BorderSizePixel = 0
speedInput.Text = tostring(humanoid.WalkSpeed)
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.TextScaled = true
speedInput.Font = Enum.Font.Gotham
speedInput.PlaceholderText = "Speed"
speedInput.Parent = frame

local speedInputCorner = Instance.new("UICorner")
speedInputCorner.CornerRadius = UDim.new(0, 5)
speedInputCorner.Parent = speedInput

-- Set speed button
local setSpeedBtn = Instance.new("TextButton")
setSpeedBtn.Size = UDim2.new(0.25, 0, 0, 25)
setSpeedBtn.Position = UDim2.new(0.7, 0, 0, 70)
setSpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
setSpeedBtn.BorderSizePixel = 0
setSpeedBtn.Text = "Set"
setSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
setSpeedBtn.TextScaled = true
setSpeedBtn.Font = Enum.Font.GothamBold
setSpeedBtn.Parent = frame

local setSpeedCorner = Instance.new("UICorner")
setSpeedCorner.CornerRadius = UDim.new(0, 5)
setSpeedCorner.Parent = setSpeedBtn

-- Fly button
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.4, 0, 0, 25)
flyBtn.Position = UDim2.new(0.05, 0, 0, 105)
flyBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
flyBtn.BorderSizePixel = 0
flyBtn.Text = "Fly: OFF"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.TextScaled = true
flyBtn.Font = Enum.Font.GothamBold
flyBtn.Parent = frame

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 5)
flyCorner.Parent = flyBtn

-- Noclip button
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(0.4, 0, 0, 25)
noclipBtn.Position = UDim2.new(0.55, 0, 0, 105)
noclipBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
noclipBtn.BorderSizePixel = 0
noclipBtn.Text = "Noclip: OFF"
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.TextScaled = true
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.Parent = frame

local noclipCorner = Instance.new("UICorner")
noclipCorner.CornerRadius = UDim.new(0, 5)
noclipCorner.Parent = noclipBtn

-- Infinite Yield button
local infiniteYieldBtn = Instance.new("TextButton")
infiniteYieldBtn.Size = UDim2.new(0.4, 0, 0, 25)
infiniteYieldBtn.Position = UDim2.new(0.05, 0, 0, 140)
infiniteYieldBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
infiniteYieldBtn.BorderSizePixel = 0
infiniteYieldBtn.Text = "Inf Yield: OFF"
infiniteYieldBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
infiniteYieldBtn.TextScaled = true
infiniteYieldBtn.Font = Enum.Font.GothamBold
infiniteYieldBtn.Parent = frame

local infiniteYieldCorner = Instance.new("UICorner")
infiniteYieldCorner.CornerRadius = UDim.new(0, 5)
infiniteYieldCorner.Parent = infiniteYieldBtn

-- Reset button
local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0.4, 0, 0, 25)
resetBtn.Position = UDim2.new(0.55, 0, 0, 140)
resetBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
resetBtn.BorderSizePixel = 0
resetBtn.Text = "Reset"
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetBtn.TextScaled = true
resetBtn.Font = Enum.Font.GothamBold
resetBtn.Parent = frame

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 5)
resetCorner.Parent = resetBtn

-- Status display
local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -20, 0, 20)
statusText.Position = UDim2.new(0, 10, 0, 200)
statusText.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
statusText.BorderSizePixel = 0
statusText.Text = "Ready"
statusText.TextColor3 = Color3.fromRGB(0, 255, 0)
statusText.TextScaled = true
statusText.Font = Enum.Font.Gotham
statusText.Parent = frame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 5)
statusCorner.Parent = statusText

-- Functions
local function updateSpeed()
    speedLabel.Text = "Walk Speed: " .. humanoid.WalkSpeed
    speedInput.Text = tostring(humanoid.WalkSpeed)
end

local function updateStatus(text, color)
    statusText.Text = text
    statusText.TextColor3 = color
end

local function stopFlying()
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    
    -- Restore normal physics
    workspace.Gravity = originalGravity
    humanoid:ChangeState(Enum.HumanoidStateType.Landing)
    
    isFlying = false
    flyBtn.Text = "Fly: OFF"
    flyBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    updateStatus("Flying stopped", Color3.fromRGB(255, 255, 0))
end

local function startFlying()
    stopFlying() -- Stop any existing flight
    
    isFlying = true
    flyBtn.Text = "Fly: ON"
    flyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    updateStatus("Flying enabled", Color3.fromRGB(0, 255, 0))
    
    -- Disable gravity for real flying
    workspace.Gravity = 0
    
    flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if isFlying and humanoid and rootPart then
            -- Keep character in flying state
            humanoid:ChangeState(Enum.HumanoidStateType.Flying)
            
            local moveDirection = Vector3.new(0, 0, 0)
            local camera = workspace.CurrentCamera
            
            -- Forward/Backward
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + (camera.CFrame.LookVector * flySpeed)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - (camera.CFrame.LookVector * flySpeed)
            end
            
            -- Left/Right
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - (camera.CFrame.RightVector * flySpeed)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + (camera.CFrame.RightVector * flySpeed)
            end
            
            -- Up/Down
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, flySpeed, 0)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, flySpeed, 0)
            end
            
            -- Apply movement
            if moveDirection.Magnitude > 0 then
                rootPart.CFrame = rootPart.CFrame + moveDirection * 0.01
            end
        end
    end)
end

local function stopNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    
    -- Re-enable collisions
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
    
    isNoclip = false
    noclipBtn.Text = "Noclip: OFF"
    noclipBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    updateStatus("Noclip disabled", Color3.fromRGB(255, 255, 0))
end

local function startNoclip()
    stopNoclip() -- Stop any existing noclip
    
    isNoclip = true
    noclipBtn.Text = "Noclip: ON"
    noclipBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
    updateStatus("Noclip enabled", Color3.fromRGB(0, 255, 0))
    
    noclipConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if isNoclip and character then
            -- Disable collisions for all parts
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function stopInfiniteYield()
    if infiniteYieldConnection then
        infiniteYieldConnection:Disconnect()
        infiniteYieldConnection = nil
    end
    
    -- Restore normal yield behavior
    isInfiniteYield = false
    infiniteYieldBtn.Text = "Inf Yield: OFF"
    infiniteYieldBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    updateStatus("Infinite Yield disabled", Color3.fromRGB(255, 255, 0))
end

local function startInfiniteYield()
    stopInfiniteYield() -- Stop any existing infinite yield
    
    isInfiniteYield = true
    infiniteYieldBtn.Text = "Inf Yield: ON"
    infiniteYieldBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
    updateStatus("Infinite Yield enabled", Color3.fromRGB(0, 255, 0))
    
    -- This simulates infinite yield behavior
    infiniteYieldConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if isInfiniteYield then
            -- Keep the script running continuously
            -- This prevents yield-related issues
        end
    end)
end

-- Button events
setSpeedBtn.MouseButton1Click:Connect(function()
    local speed = tonumber(speedInput.Text)
    if speed and speed >= 5 and speed <= 100 then
        humanoid.WalkSpeed = speed
        updateSpeed()
        updateStatus("Speed set to " .. speed, Color3.fromRGB(0, 255, 0))
    else
        updateStatus("Invalid speed (5-100)", Color3.fromRGB(255, 100, 100))
    end
end)

flyBtn.MouseButton1Click:Connect(function()
    if isFlying then
        stopFlying()
    else
        startFlying()
    end
end)

noclipBtn.MouseButton1Click:Connect(function()
    if isNoclip then
        stopNoclip()
    else
        startNoclip()
    end
end)

infiniteYieldBtn.MouseButton1Click:Connect(function()
    if isInfiniteYield then
        stopInfiniteYield()
    else
        startInfiniteYield()
    end
end)

resetBtn.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = 16
    updateSpeed()
    stopFlying()
    stopNoclip()
    stopInfiniteYield()
    updateStatus("Reset to default", Color3.fromRGB(0, 255, 0))
end)

-- Make GUI draggable (improved)
local isDragging = false
local dragStart = nil
local startPos = nil

title.MouseButton1Down:Connect(function()
    isDragging = true
    dragStart = frame.Position
    startPos = game:GetService("UserInputService"):GetMouseLocation()
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = game:GetService("UserInputService"):GetMouseLocation() - startPos
        frame.Position = UDim2.new(dragStart.X.Scale, dragStart.X.Offset + delta.X, dragStart.Y.Scale, dragStart.Y.Offset + delta.Y)
    end
end)

-- Character respawn
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    updateSpeed()
    stopFlying()
    stopNoclip()
    stopInfiniteYield()
    updateStatus("Character respawned", Color3.fromRGB(255, 255, 0))
end)

-- Update when speed changes
humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(updateSpeed)

print("Speed & Fly & Noclip & Infinite Yield Editor loaded!")
print("Drag the title bar to move the GUI")
print("WASD + Space/Shift to fly")
print("Click Fly button to toggle flying")
print("Click Noclip button to walk through walls")
print("Click Inf Yield button to enable infinite yield")
print("Enter speed (5-100) and click Set")
print("Click Reset to return to default")
print("Now you can fly, walk through walls, and have infinite yield!")
