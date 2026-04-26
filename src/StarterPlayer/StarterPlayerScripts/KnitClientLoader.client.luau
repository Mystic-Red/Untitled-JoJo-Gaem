--!strict
-- KnitClientLoader: Initializes Knit and loads all client controllers

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit.KnitClient)

-- Add controllers from PlayerScripts path
local localPlayer = Players.LocalPlayer
local playerScripts = localPlayer:WaitForChild("PlayerScripts")
Knit.AddControllers(playerScripts:WaitForChild("Controllers"))

-- Start Knit
Knit.Start():andThen(function()
	print("[KnitClient] Started successfully")
end):catch(function(err)
	warn("[KnitClient] Failed to start: " .. tostring(err))
end)
