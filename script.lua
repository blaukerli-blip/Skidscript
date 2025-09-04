-- ERLC Utility Script for Own Game Server
-- Copy this entire script and paste into your executor

wait(2) -- Wait for game to load

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChild("Humanoid") or character:WaitForChild("Humanoid")
local rootPart = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

-- Variables
local isESPEnabled = false
local isSpeedEnabled = false
local isFlyEnabled = false
local isNoclipEnabled = false
local espConnection = nil
local speedConnection = nil
local flyConnection = nil
local noclipConnection = nil
local originalGravity = workspace.Gravity
local originalWalkSpeed = humanoid.WalkSpeed
local flySpeed = 50
local speedMultiplier = 2

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ERLCUtilityGUI"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 350)
frame.Position = UDim2.new(0.5, -125, 0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Title (draggable)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.BorderSizePixel = 0
title.Text = "ERLC Utility Panel"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

-- ESP Section
local espLabel = Instance.new("TextLabel")
espLabel.Size = UDim2.new(1, -20, 0, 25)
espLabel.Position = UDim2.new(0, 10, 0, 45)
espLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
espLabel.BorderSizePixel = 0
espLabel.Text = "ESP Features"
espLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
espLabel.TextScaled = true
espLabel.Font = Enum.Font.GothamBold
espLabel.Parent = frame

local espLabelCorner = Instance.new("UICorner")
espLabelCorner.CornerRadius = UDim.new(0, 5)
espLabelCorner.Parent = espLabel

-- ESP Buttons
local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0.45, 0, 0, 30)
espBtn.Position = UDim2.new(0.025, 0, 0, 80)
espBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
espBtn.BorderSizePixel = 0
espBtn.Text = "ESP: OFF"
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.TextScaled = true
espBtn.Font = Enum.Font.GothamBold
espBtn.Parent = frame

local espCorner = Instance.new("UICorner")
espCorner.CornerRadius = UDim.new(0, 5)
espCorner.Parent = espBtn

local boxEspBtn = Instance.new("TextButton")
boxEspBtn.Size = UDim2.new(0.45, 0, 0, 30)
boxEspBtn.Position = UDim2.new(0.525, 0, 0, 80)
boxEspBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 100)
boxEspBtn.BorderSizePixel = 0
boxEspBtn.Text = "Box ESP: OFF"
boxEspBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
boxEspBtn.TextScaled = true
boxEspBtn.Font = Enum.Font.GothamBold
boxEspBtn.Parent = frame

local boxEspCorner = Instance.new("UICorner")
boxEspCorner.CornerRadius = UDim.new(0, 5)
boxEspCorner.Parent = boxEspBtn

local nameEspBtn = Instance.new("TextButton")
nameEspBtn.Size = UDim2.new(0.45, 0, 0, 30)
nameEspBtn.Position = UDim2.new(0.025, 0, 0, 120)
nameEspBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
nameEspBtn.BorderSizePixel = 0
nameEspBtn.Text = "Name ESP: OFF"
nameEspBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
nameEspBtn.TextScaled = true
nameEspBtn.Font = Enum.Font.GothamBold
nameEspBtn.Parent = frame

local nameEspCorner = Instance.new("UICorner")
nameEspCorner.CornerRadius = UDim.new(0, 5)
nameEspCorner.Parent = nameEspBtn

-- Movement Section
local movementLabel = Instance.new("TextLabel")
movementLabel.Size = UDim2.new(1, -20, 0, 25)
movementLabel.Position = UDim2.new(0, 10, 0, 160)
movementLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
movementLabel.BorderSizePixel = 0
movementLabel.Text = "Movement Features"
movementLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
movementLabel.TextScaled = true
movementLabel.Font = Enum.Font.GothamBold
movementLabel.Parent = frame

local movementLabelCorner = Instance.new("UICorner")
movementLabelCorner.CornerRadius = UDim.new(0, 5)
movementLabelCorner.Parent = movementLabel

-- Movement Buttons
local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0.45, 0, 0, 30)
speedBtn.Position = UDim2.new(0.025, 0, 0, 195)
speedBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
speedBtn.BorderSizePixel = 0
speedBtn.Text = "Speed: OFF"
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.TextScaled = true
speedBtn.Font = Enum.Font.GothamBold
speedBtn.Parent = frame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 5)
speedCorner.Parent = speedBtn

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.45, 0, 0, 30)
flyBtn.Position = UDim2.new(0.525, 0, 0, 195)
flyBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
flyBtn.BorderSizePixel = 0
flyBtn.Text = "Fly: OFF"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.TextScaled = true
flyBtn.Font = Enum.Font.GothamBold
flyBtn.Parent = frame

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 5)
flyCorner.Parent = flyBtn

local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(0.45, 0, 0, 30)
noclipBtn.Position = UDim2.new(0.025, 0, 0, 235)
noclipBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
noclipBtn.BorderSizePixel = 0
noclipBtn.Text = "Noclip: OFF"
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.TextScaled = true
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.Parent = frame

local noclipCorner = Instance.new("UICorner")
noclipCorner.CornerRadius = UDim.new(0, 5)
noclipCorner.Parent = noclipBtn

-- Reset Button
local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0.45, 0, 0, 30)
resetBtn.Position = UDim2.new(0.525, 0, 0, 235)
resetBtn.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
resetBtn.BorderSizePixel = 0
resetBtn.Text = "Reset All"
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetBtn.TextScaled = true
resetBtn.Font = Enum.Font.GothamBold
resetBtn.Parent = frame

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 5)
resetCorner.Parent = resetBtn

-- Status Display
local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -20, 0, 25)
statusText.Position = UDim2.new(0, 10, 0, 280)
statusText.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
statusText.BorderSizePixel = 0
statusText.Text = "Ready - Drag title to move"
statusText.TextColor3 = Color3.fromRGB(0, 255, 0)
statusText.TextScaled = true
statusText.Font = Enum.Font.Gotham
statusText.Parent = frame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 5)
statusCorner.Parent = statusText

-- Functions
local function updateStatus(text, color)
    statusText.Text = text
    statusText.TextColor3 = color
end

local function stopESP()
    if espConnection then
        espConnection:Disconnect()
        espConnection = nil
    end
    
    -- Remove ESP elements
    for _, obj in pairs(game:GetService("CoreGui"):GetDescendants()) do
        if obj.Name == "ESPBox" or obj.Name == "ESPName" then
            obj:Destroy()
        end
    end
    
    isESPEnabled = false
    espBtn.Text = "ESP: OFF"
    espBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    boxEspBtn.Text = "Box ESP: OFF"
    boxEspBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 100)
    nameEspBtn.Text = "Name ESP: OFF"
    nameEspBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
    updateStatus("ESP disabled", Color3.fromRGB(255, 255, 0))
end

local function startESP()
    stopESP() -- Stop any existing ESP
    
    isESPEnabled = true
    espBtn.Text = "ESP: ON"
    espBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    updateStatus("ESP enabled", Color3.fromRGB(0, 255, 0))
    
    espConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if isESPEnabled then
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local rootPart = player.Character.HumanoidRootPart
                    local head = player.Character:FindFirstChild("Head")
                    
                    if rootPart and head then
                        -- Box ESP
                        local box = game:GetService("CoreGui"):FindFirstChild("ESPBox_" .. player.Name)
                        if not box then
                            box = Instance.new("Frame")
                            box.Name = "ESPBox_" .. player.Name
                            box.Size = UDim2.new(0, 100, 0, 200)
                            box.Position = UDim2.new(0, 0, 0, 0)
                            box.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                            box.BorderSizePixel = 2
                            box.BorderColor3 = Color3.fromRGB(255, 255, 255)
                            box.Parent = game:GetService("CoreGui")
                        end
                        
                        -- Name ESP
                        local nameLabel = game:GetService("CoreGui"):FindFirstChild("ESPName_" .. player.Name)
                        if not nameLabel then
                            nameLabel = Instance.new("TextLabel")
                            nameLabel.Name = "ESPName_" .. player.Name
                            nameLabel.Size = UDim2.new(0, 100, 0, 20)
                            nameLabel.Position = UDim2.new(0, 0, 0, 0)
                            nameLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                            nameLabel.BorderSizePixel = 1
                            nameLabel.BorderColor3 = Color3.fromRGB(255, 255, 255)
                            nameLabel.Text = player.Name
                            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            nameLabel.TextScaled = true
                            nameLabel.Font = Enum.Font.GothamBold
                            nameLabel.Parent = game:GetService("CoreGui")
                        end
                        
                        -- Update positions
                        local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position)
                        if onScreen then
                            box.Position = UDim2.new(0, screenPos.X - 50, 0, screenPos.Y - 100)
                            nameLabel.Position = UDim2.new(0, screenPos.X - 50, 0, screenPos.Y - 120)
                            box.Visible = true
                            nameLabel.Visible = true
                        else
                            box.Visible = false
                            nameLabel.Visible = false
                        end
                    end
                end
            end
        end
    end)
end

local function stopSpeed()
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
    
    humanoid.WalkSpeed = originalWalkSpeed
    isSpeedEnabled = false
    speedBtn.Text = "Speed: OFF"
    speedBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    updateStatus("Speed disabled", Color3.fromRGB(255, 255, 0))
end

local function startSpeed()
    stopSpeed() -- Stop any existing speed
    
    isSpeedEnabled = true
    speedBtn.Text = "Speed: ON"
    speedBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    updateStatus("Speed enabled", Color3.fromRGB(0, 255, 0))
    
    humanoid.WalkSpeed = originalWalkSpeed * speedMultiplier
    
    speedConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if isSpeedEnabled then
            humanoid.WalkSpeed = originalWalkSpeed * speedMultiplier
        end
    end)
end

local function stopFlying()
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    
    workspace.Gravity = originalGravity
    humanoid:ChangeState(Enum.HumanoidStateType.Landing)
    
    isFlyEnabled = false
    flyBtn.Text = "Fly: OFF"
    flyBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
    updateStatus("Flying stopped", Color3.fromRGB(255, 255, 0))
end

local function startFlying()
    stopFlying() -- Stop any existing flight
    
    isFlyEnabled = true
    flyBtn.Text = "Fly: ON"
    flyBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
    updateStatus("Flying enabled", Color3.fromRGB(0, 255, 0))
    
    workspace.Gravity = 0
    
    flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if isFlyEnabled and humanoid and rootPart then
            humanoid:ChangeState(Enum.HumanoidStateType.Flying)
            
            local moveDirection = Vector3.new(0, 0, 0)
            local camera = workspace.CurrentCamera
            
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + (camera.CFrame.LookVector * flySpeed)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - (camera.CFrame.LookVector * flySpeed)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - (camera.CFrame.RightVector * flySpeed)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + (camera.CFrame.RightVector * flySpeed)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, flySpeed, 0)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, flySpeed, 0)
            end
            
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
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
    
    isNoclipEnabled = false
    noclipBtn.Text = "Noclip: OFF"
    noclipBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
    updateStatus("Noclip disabled", Color3.fromRGB(255, 255, 0))
end

local function startNoclip()
    stopNoclip() -- Stop any existing noclip
    
    isNoclipEnabled = true
    noclipBtn.Text = "Noclip: ON"
    noclipBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
    updateStatus("Noclip enabled", Color3.fromRGB(0, 255, 0))
    
    noclipConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if isNoclipEnabled and character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function resetAll()
    stopESP()
    stopSpeed()
    stopFlying()
    stopNoclip()
    updateStatus("All features reset", Color3.fromRGB(0, 255, 0))
end

-- Button events
espBtn.MouseButton1Click:Connect(function()
    if isESPEnabled then
        stopESP()
    else
        startESP()
    end
end)

boxEspBtn.MouseButton1Click:Connect(function()
    if isESPEnabled then
        stopESP()
    else
        startESP()
    end
end)

nameEspBtn.MouseButton1Click:Connect(function()
    if isESPEnabled then
        stopESP()
    else
        startESP()
    end
end)

speedBtn.MouseButton1Click:Connect(function()
    if isSpeedEnabled then
        stopSpeed()
    else
        startSpeed()
    end
end)

flyBtn.MouseButton1Click:Connect(function()
    if isFlyEnabled then
        stopFlying()
    else
        startFlying()
    end
end)

noclipBtn.MouseButton1Click:Connect(function()
    if isNoclipEnabled then
        stopNoclip()
    else
        startNoclip()
    end
end)

resetBtn.MouseButton1Click:Connect(function()
    resetAll()
end)

-- Make GUI draggable
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
    originalWalkSpeed = humanoid.WalkSpeed
    resetAll()
    updateStatus("Character respawned", Color3.fromRGB(255, 255, 0))
end)

print("ERLC Utility Script loaded!")
print("Features: ESP, Speed, Fly, Noclip")
print("Drag the title bar to move the GUI")
print("WASD + Space/Shift to fly")
print("Click buttons to toggle features")
print("Click Reset All to disable everything")
