--!strict
-- KnitServerLoader: Initializes Knit and loads all server services

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

-- Add services folder
Knit.AddServices(game.ServerScriptService:WaitForChild("Services"))

-- Start Knit
Knit.Start():andThen(function()
	print("[KnitServer] Started successfully")
end):catch(function(err)
	warn("[KnitServer] Failed to start: " .. tostring(err))
end)
