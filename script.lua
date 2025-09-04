-- Sicherheitscheck
local ownerId = 8740149837 -- Deine UserId
if game.Players.LocalPlayer.UserId ~= ownerId then return end

-- Einfaches UI mit Fly und Speed

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")

-- UI bauen
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0, 100, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local FlyButton = Instance.new("TextButton", Frame)
FlyButton.Size = UDim2.new(1, 0, 0.5, 0)
FlyButton.Text = "Fly"

local SpeedButton = Instance.new("TextButton", Frame)
SpeedButton.Position = UDim2.new(0, 0, 0.5, 0)
SpeedButton.Size = UDim2.new(1, 0, 0.5, 0)
SpeedButton.Text = "Speed"

-- Fly-Funktion
local flying = false
local flySpeed = 50

function fly()
    local char = player.Character
    local HRP = char:WaitForChild("HumanoidRootPart")
    
    local BodyGyro = Instance.new("BodyGyro", HRP)
    local BodyVelocity = Instance.new("BodyVelocity", HRP)
    
    BodyGyro.P = 9e4
    BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    BodyGyro.cframe = HRP.CFrame

    BodyVelocity.velocity = Vector3.new(0, 0, 0)
    BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)

    flying = true

    game:GetService("RunService").Heartbeat:Connect(function()
        if not flying then return end
        BodyGyro.cframe = workspace.CurrentCamera.CFrame
        local direction = Vector3.new()
        if UIS:IsKeyDown(Enum.KeyCode.W) then direction = direction + workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then direction = direction - workspace.CurrentCamera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then direction = direction - workspace.CurrentCamera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then direction = direction + workspace.CurrentCamera.CFrame.RightVector end
        BodyVelocity.velocity = direction.unit * flySpeed
    end)
end

FlyButton.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        fly()
        FlyButton.Text = "Unfly"
    else
        -- Stop fly
        pcall(function()
            player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("BodyGyro"):Destroy()
            player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("BodyVelocity"):Destroy()
        end)
        FlyButton.Text = "Fly"
    end
end)

-- Speed-Funktion
local speedEnabled = false
local speedValue = 100

SpeedButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if speedEnabled then
            humanoid.WalkSpeed = speedValue
            SpeedButton.Text = "Normal Speed"
        else
            humanoid.WalkSpeed = 16
            SpeedButton.Text = "Speed"
        end
    end
end)
