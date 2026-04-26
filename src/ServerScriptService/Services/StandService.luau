--!strict
-- StandService: Manages Stand spawning/despawning and server-side logic

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Knit = require(ReplicatedStorage.Packages.Knit)

local StandService = Knit.CreateService {
	Name = "StandService",
	Client = {
		SummonStand = Knit.CreateSignal(),
		UnsummonStand = Knit.CreateSignal(),
	},
}

-- Internal state tracking
local playerStands: { [Player]: Model } = {}
local playerStandConfigs: { [Player]: { [string]: any } } = {}

-- Configuration module cache
local standConfigs: { [string]: any } = {}

-- Helper to bypass type checker on dynamic requires
local function loadConfig(module): any
	return (require :: any)(module)
end

function StandService:KnitInit()
	-- Load all stand configs
	local standsFolder = ReplicatedStorage:WaitForChild("Stands")
	for _, configModule in ipairs(standsFolder:GetChildren()) do
		if configModule:IsA("ModuleScript") then
			standConfigs[configModule.Name] = loadConfig(configModule)
		end
	end
end

function StandService:KnitStart()
	-- Handle player leaving
	Players.PlayerRemoving:Connect(function(player)
		self:UnsummonStand(player)
	end)
end

function StandService:GetStandConfig(standName: string): { [string]: any }?
	return standConfigs[standName]
end

function StandService:GetPlayerStand(player: Player): Model?
	return playerStands[player]
end

function StandService:IsStandSummoned(player: Player): boolean
	return playerStands[player] ~= nil
end

function StandService:SummonStand(player: Player, standName: string?): boolean
	if not player.Character then return false end
	
	local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return false end
	
	-- Already summoned? Unsummon first
	if playerStands[player] then
		self:UnsummonStand(player)
		return true -- Toggle off
	end
	
	-- Get player data to determine which stand they have
	local dataService = Knit.GetService("DataService")
	local equippedStand = standName or dataService:GetPlayerData(player, "Stand") or "None"
	
	if equippedStand == "None" then return false end
	
	local config = standConfigs[equippedStand]
	if not config then
		warn("Stand config not found for: " .. tostring(equippedStand))
		return false
	end
	
	-- Spawn the stand model
	local standModel = self:CreateStandModel(player, equippedStand, config)
	if not standModel then return false end
	
	playerStands[player] = standModel :: Model
	playerStandConfigs[player] = config
	
	-- Notify client to play summon animation
	self.Client.SummonStand:Fire(player, equippedStand)
	
	return true
end

function StandService:UnsummonStand(player: Player): boolean
	local stand = playerStands[player]
	if not stand then return false end
	
	-- Notify client first
	self.Client.UnsummonStand:Fire(player)
	
	-- Clean up the model
	stand:Destroy()
	playerStands[player] = nil
	playerStandConfigs[player] = nil
	
	return true
end

function StandService:CreateStandModel(player: Player, standName: string, config): Model?
	local assetsFolder = ReplicatedStorage:WaitForChild("Assets")
	local standsFolder = assetsFolder:WaitForChild("Stands")
	local standTemplate = standsFolder:FindFirstChild(standName) :: Model?
	
	if not standTemplate then
		warn("Stand model not found in assets: " .. standName)
		return nil
	end
	
	local stand = standTemplate:Clone()
	stand.Name = player.Name .. "_" .. standName
	
	-- Set up positioning behind player
	local character = player.Character
	if not character then return nil end
	
	local hrp = character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not hrp then return nil end
	
	-- Initial position behind player
	local offset = hrp.CFrame.LookVector * -3.5 + hrp.CFrame.RightVector * 2
	stand:PivotTo(CFrame.new(hrp.Position + offset) * CFrame.Angles(0, math.atan2(offset.X, offset.Z) + math.pi, 0))
	
	-- Parent to workspace
	stand.Parent = workspace
	
	-- Set up collision group
	for _, part in ipairs(stand:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CollisionGroup = "Stands"
		end
	end
	
	-- Create weld to follow player
	self:SetupStandMovement(player, stand)
	
	return stand
end

function StandService:SetupStandMovement(player: Player, stand: Model)
	local runService = game:GetService("RunService")
	local connection: RBXScriptConnection?
	
	local function updatePosition()
		if not player.Character or not playerStands[player] then
			if connection then
				connection:Disconnect()
			end
			return
		end
		
		local hrp = player.Character:FindFirstChild("HumanoidRootPart") :: BasePart?
		if not hrp then return end
		
		local standHrp = stand:FindFirstChild("HumanoidRootPart") or stand:FindFirstChild("Torso") or stand:FindFirstChildWhichIsA("BasePart")
		if not standHrp then return end
		
		-- Position behind and to the side of player
		local targetOffset = hrp.CFrame.LookVector * -3.5 + hrp.CFrame.RightVector * 2.5
		local targetPos = hrp.Position + targetOffset
		local targetCFrame = CFrame.new(targetPos, hrp.Position + hrp.CFrame.LookVector * 10) :: CFrame
		
		-- Smooth lerp
		local currentCFrame = stand:GetPivot()
		local newCFrame = currentCFrame:Lerp(targetCFrame, 0.15)
		stand:PivotTo(newCFrame)
	end
	
	connection = runService.Heartbeat:Connect(updatePosition)
end

-- Client RPC handlers
function StandService.Client:RequestSummon(player: Player): boolean
	return self.Server:SummonStand(player)
end

return StandService
