-- Simple Fly GUI with Password for Own Game Server
-- Copy this entire script and paste into your executor

wait(2) -- Wait for game to load

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChild("Humanoid") or character:WaitForChild("Humanoid")
local rootPart = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

-- Variables
local isFlyEnabled = false
local isNoclipEnabled = false
local isSpinEnabled = false
local flyConnection = nil
local noclipConnection = nil
local spinConnection = nil
local originalGravity = workspace.Gravity
local originalWalkSpeed = humanoid.WalkSpeed
local flySpeed = 50
local spinSpeed = 5
local isUnlocked = false

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SimpleFlyGUI"
if syn and syn.protect_gui then
	syn.protect_gui(gui)
end
gui.Parent = player:FindFirstChildOfClass("PlayerGui") or player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 360)
frame.Position = UDim2.new(1, -240, 0, 20) -- Top right corner
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Title (draggable)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.BorderSizePixel = 0
title.Text = "Fly Panel"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

-- Password section
local passwordLabel = Instance.new("TextLabel")
passwordLabel.Size = UDim2.new(1, -20, 0, 20)
passwordLabel.Position = UDim2.new(0, 10, 0, 40)
passwordLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
passwordLabel.BorderSizePixel = 0
passwordLabel.Text = "Enter Password:"
passwordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
passwordLabel.TextScaled = true
passwordLabel.Font = Enum.Font.Gotham
passwordLabel.Parent = frame

local passwordLabelCorner = Instance.new("UICorner")
passwordLabelCorner.CornerRadius = UDim.new(0, 5)
passwordLabelCorner.Parent = passwordLabel

local passwordInput = Instance.new("TextBox")
passwordInput.Size = UDim2.new(0.6, 0, 0, 25)
passwordInput.Position = UDim2.new(0.05, 0, 0, 70)
passwordInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
passwordInput.BorderSizePixel = 0
passwordInput.Text = ""
passwordInput.TextColor3 = Color3.fromRGB(255, 255, 255)
passwordInput.TextScaled = true
passwordInput.Font = Enum.Font.Gotham
passwordInput.PlaceholderText = "Password"
passwordInput.Parent = frame

local passwordInputCorner = Instance.new("UICorner")
passwordInputCorner.CornerRadius = UDim.new(0, 5)
passwordInputCorner.Parent = passwordInput

local unlockBtn = Instance.new("TextButton")
unlockBtn.Size = UDim2.new(0.25, 0, 0, 25)
unlockBtn.Position = UDim2.new(0.7, 0, 0, 70)
unlockBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
unlockBtn.BorderSizePixel = 0
unlockBtn.Text = "Unlock"
unlockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
unlockBtn.TextScaled = true
unlockBtn.Font = Enum.Font.GothamBold
unlockBtn.Parent = frame

local unlockCorner = Instance.new("UICorner")
unlockCorner.CornerRadius = UDim.new(0, 5)
unlockCorner.Parent = unlockBtn

-- Speed section (hidden until unlocked)
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -20, 0, 20)
speedLabel.Position = UDim2.new(0, 10, 0, 105)
speedLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
speedLabel.BorderSizePixel = 0
speedLabel.Text = "Speed: " .. humanoid.WalkSpeed
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.Gotham
speedLabel.Parent = frame
speedLabel.Visible = false

local speedLabelCorner = Instance.new("UICorner")
speedLabelCorner.CornerRadius = UDim.new(0, 5)
speedLabelCorner.Parent = speedLabel

local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(0.6, 0, 0, 25)
speedInput.Position = UDim2.new(0.05, 0, 0, 135)
speedInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
speedInput.BorderSizePixel = 0
speedInput.Text = tostring(humanoid.WalkSpeed)
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.TextScaled = true
speedInput.Font = Enum.Font.Gotham
speedInput.PlaceholderText = "Speed"
speedInput.Parent = frame
speedInput.Visible = false

local speedInputCorner = Instance.new("UICorner")
speedInputCorner.CornerRadius = UDim.new(0, 5)
speedInputCorner.Parent = speedInput

local setSpeedBtn = Instance.new("TextButton")
setSpeedBtn.Size = UDim2.new(0.25, 0, 0, 25)
setSpeedBtn.Position = UDim2.new(0.7, 0, 0, 135)
setSpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
setSpeedBtn.BorderSizePixel = 0
setSpeedBtn.Text = "Set"
setSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
setSpeedBtn.TextScaled = true
setSpeedBtn.Font = Enum.Font.GothamBold
setSpeedBtn.Parent = frame
setSpeedBtn.Visible = false

local setSpeedCorner = Instance.new("UICorner")
setSpeedCorner.CornerRadius = UDim.new(0, 5)
setSpeedCorner.Parent = setSpeedBtn

-- Fly button
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.9, 0, 0, 30)
flyBtn.Position = UDim2.new(0.05, 0, 0, 170)
flyBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
flyBtn.BorderSizePixel = 0
flyBtn.Text = "Fly: OFF"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.TextScaled = true
flyBtn.Font = Enum.Font.GothamBold
flyBtn.Parent = frame
flyBtn.Visible = false

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 5)
flyCorner.Parent = flyBtn

-- Noclip button
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(0.9, 0, 0, 30)
noclipBtn.Position = UDim2.new(0.05, 0, 0, 210)
noclipBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
noclipBtn.BorderSizePixel = 0
noclipBtn.Text = "Noclip: OFF"
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.TextScaled = true
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.Parent = frame
noclipBtn.Visible = false

local noclipCorner = Instance.new("UICorner")
noclipCorner.CornerRadius = UDim.new(0, 5)
noclipCorner.Parent = noclipBtn

-- Spin button and speed
local spinBtn = Instance.new("TextButton")
spinBtn.Size = UDim2.new(0.55, 0, 0, 30)
spinBtn.Position = UDim2.new(0.05, 0, 0, 250)
spinBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
spinBtn.BorderSizePixel = 0
spinBtn.Text = "Spin: OFF"
spinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spinBtn.TextScaled = true
spinBtn.Font = Enum.Font.GothamBold
spinBtn.Parent = frame
spinBtn.Visible = false

local spinCorner = Instance.new("UICorner")
spinCorner.CornerRadius = UDim.new(0, 5)
spinCorner.Parent = spinBtn

local spinSpeedInput = Instance.new("TextBox")
spinSpeedInput.Size = UDim2.new(0.3, 0, 0, 30)
spinSpeedInput.Position = UDim2.new(0.65, 0, 0, 250)
spinSpeedInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
spinSpeedInput.BorderSizePixel = 0
spinSpeedInput.Text = tostring(spinSpeed)
spinSpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
spinSpeedInput.TextScaled = true
spinSpeedInput.Font = Enum.Font.Gotham
spinSpeedInput.PlaceholderText = "Spin"
spinSpeedInput.Parent = frame
spinSpeedInput.Visible = false

local spinSpeedCorner = Instance.new("UICorner")
spinSpeedCorner.CornerRadius = UDim.new(0, 5)
spinSpeedCorner.Parent = spinSpeedInput

-- Status display
local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -20, 0, 20)
statusText.Position = UDim2.new(0, 10, 0, 320)
statusText.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
statusText.BorderSizePixel = 0
statusText.Text = "Enter password to unlock"
statusText.TextColor3 = Color3.fromRGB(255, 255, 0)
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

local function unlockGUI()
	isUnlocked = true
	passwordLabel.Visible = false
	passwordInput.Visible = false
	unlockBtn.Visible = false
	speedLabel.Visible = true
	speedInput.Visible = true
	setSpeedBtn.Visible = true
	flyBtn.Visible = true
	noclipBtn.Visible = true
	spinBtn.Visible = true
	spinSpeedInput.Visible = true
	frame.Size = UDim2.new(0, 220, 0, 360)
	updateStatus("GUI unlocked!", Color3.fromRGB(0, 255, 0))
end

local function stopFlying()
	if flyConnection then
		flyConnection:Disconnect()
		flyConnection = nil
	end
	workspace.Gravity = originalGravity
	if humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Landing)
	end
	isFlyEnabled = false
	flyBtn.Text = "Fly: OFF"
	flyBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
	updateStatus("Flying stopped", Color3.fromRGB(255, 255, 0))
end

local function startFlying()
	-- ensure any prior state is stopped
	if flyConnection then
		flyConnection:Disconnect()
		flyConnection = nil
	end
	isFlyEnabled = true
	flyBtn.Text = "Fly: ON"
	flyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
	updateStatus("Flying enabled", Color3.fromRGB(0, 255, 0))
	workspace.Gravity = 0
	flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
		if not isFlyEnabled then return end
		if humanoid and rootPart then
			humanoid:ChangeState(Enum.HumanoidStateType.Flying)
			local moveDirection = Vector3.new()
			local camera = workspace.CurrentCamera
			local UIS = game:GetService("UserInputService")
			if UIS:IsKeyDown(Enum.KeyCode.W) then
				moveDirection = moveDirection + (camera.CFrame.LookVector * flySpeed)
			end
			if UIS:IsKeyDown(Enum.KeyCode.S) then
				moveDirection = moveDirection - (camera.CFrame.LookVector * flySpeed)
			end
			if UIS:IsKeyDown(Enum.KeyCode.A) then
				moveDirection = moveDirection - (camera.CFrame.RightVector * flySpeed)
			end
			if UIS:IsKeyDown(Enum.KeyCode.D) then
				moveDirection = moveDirection + (camera.CFrame.RightVector * flySpeed)
			end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then
				moveDirection = moveDirection + Vector3.new(0, flySpeed, 0)
			end
			if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
				moveDirection = moveDirection - Vector3.new(0, flySpeed, 0)
			end
			if moveDirection.Magnitude > 0 then
				rootPart.CFrame = rootPart.CFrame + (moveDirection * 0.01)
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
	noclipBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
	updateStatus("Noclip disabled", Color3.fromRGB(255, 255, 0))
end

local function startNoclip()
	if noclipConnection then
		noclipConnection:Disconnect()
		noclipConnection = nil
	end
	isNoclipEnabled = true
	noclipBtn.Text = "Noclip: ON"
	noclipBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
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

local function stopSpin()
	if spinConnection then
		spinConnection:Disconnect()
		spinConnection = nil
	end
	isSpinEnabled = false
	spinBtn.Text = "Spin: OFF"
	spinBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
	updateStatus("Spin stopped", Color3.fromRGB(255, 255, 0))
end

local function startSpin()
	if spinConnection then
		spinConnection:Disconnect()
		spinConnection = nil
	end
	isSpinEnabled = true
	spinBtn.Text = "Spin: ON"
	spinBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
	updateStatus("Spin enabled", Color3.fromRGB(0, 255, 0))
	spinConnection = game:GetService("RunService").Heartbeat:Connect(function()
		if isSpinEnabled and rootPart then
			rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
		end
	end)
end

-- Button events
unlockBtn.MouseButton1Click:Connect(function()
	if passwordInput.Text == "8080" then
		unlockGUI()
	else
		updateStatus("Wrong password!", Color3.fromRGB(255, 100, 100))
		passwordInput.Text = ""
	end
end)

passwordInput.FocusLost:Connect(function()
	if passwordInput.Text == "8080" then
		unlockGUI()
	end
end)

setSpeedBtn.MouseButton1Click:Connect(function()
	if not isUnlocked then return end
	local speed = tonumber(speedInput.Text)
	if speed then
		humanoid.WalkSpeed = speed
		speedLabel.Text = "Speed: " .. tostring(speed)
		updateStatus("Speed set to " .. tostring(speed), Color3.fromRGB(0, 255, 0))
	else
		updateStatus("Invalid speed", Color3.fromRGB(255, 100, 100))
	end
end)

spinSpeedInput.FocusLost:Connect(function()
	if not isUnlocked then return end
	local val = tonumber(spinSpeedInput.Text)
	if val then
		spinSpeed = val
		updateStatus("Spin speed = " .. tostring(spinSpeed), Color3.fromRGB(0, 255, 0))
	else
		updateStatus("Invalid spin speed", Color3.fromRGB(255, 100, 100))
	end
end)

flyBtn.MouseButton1Click:Connect(function()
	if not isUnlocked then return end
	if isFlyEnabled then
		stopFlying()
	else
		startFlying()
	end
end)

noclipBtn.MouseButton1Click:Connect(function()
	if not isUnlocked then return end
	if isNoclipEnabled then
		stopNoclip()
	else
		startNoclip()
	end
end)

spinBtn.MouseButton1Click:Connect(function()
	if not isUnlocked then return end
	if isSpinEnabled then
		stopSpin()
	else
		startSpin()
	end
end)

-- Character respawn
player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid = character:WaitForChild("Humanoid")
	rootPart = character:WaitForChild("HumanoidRootPart")
	originalWalkSpeed = humanoid.WalkSpeed
	speedLabel.Text = "Speed: " .. humanoid.WalkSpeed
	speedInput.Text = tostring(humanoid.WalkSpeed)
	stopFlying()
	stopNoclip()
	stopSpin()
	updateStatus("Character respawned", Color3.fromRGB(255, 255, 0))
end)

print("Simple Fly GUI loaded!")
print("Password is: 8080")
print("GUI is in top right corner")
print("WASD + Space/Shift to fly")
print("Click buttons to toggle features")
print("Use spin input to change spin speed")
