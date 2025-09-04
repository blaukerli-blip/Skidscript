local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- GUI erstellen
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "SpeedGui"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0, 100, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local SpeedButton = Instance.new("TextButton", Frame)
SpeedButton.Size = UDim2.new(1, 0, 0.5, 0)
SpeedButton.Position = UDim2.new(0, 0, 0, 0)
SpeedButton.Text = "Set Speed 50"
SpeedButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
SpeedButton.TextColor3 = Color3.new(1, 1, 1)
SpeedButton.Font = Enum.Font.SourceSansBold
SpeedButton.TextSize = 24

local ResetButton = Instance.new("TextButton", Frame)
ResetButton.Size = UDim2.new(1, 0, 0.5, 0)
ResetButton.Position = UDim2.new(0, 0, 0.5, 0)
ResetButton.Text = "Reset Speed"
ResetButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
ResetButton.TextColor3 = Color3.new(1, 1, 1)
ResetButton.Font = Enum.Font.SourceSansBold
ResetButton.TextSize = 24

SpeedButton.MouseButton1Click:Connect(function()
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 50
    end
end)

ResetButton.MouseButton1Click:Connect(function()
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 16
    end
end)
