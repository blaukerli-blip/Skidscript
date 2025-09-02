-- Setzt die WalkSpeed des Spielers auf 800 (50x schneller als normal)

local Players = game:GetService("Players")

local player = Players.LocalPlayer or Players.PlayerAdded:Wait()
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid.WalkSpeed = 800
