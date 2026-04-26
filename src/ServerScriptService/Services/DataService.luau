--!strict
-- DataService: Manages player data using ProfileService

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)
local ProfileService = require(ReplicatedStorage.Modules.ProfileService)
-- Profile type imported from ProfileService

local DataService = Knit.CreateService {
	Name = "DataService",
	Client = {
		DataChanged = Knit.CreateSignal(),
	},
}

-- Profile store template
local ProfileTemplate = {
	Cash = 0,
	Stand = "None",
	Race = "Human",
	FightingStyle = "None",
	Level = 1,
	StandMastery = 0,
	Inventory = {},
}

-- Profile store configuration
local profileStore = ProfileService.GetProfileStore(
	"PlayerData_v1",
	ProfileTemplate
)

-- Active profiles cache
local profiles: { [Player]: any } = {}

function DataService:KnitInit()
	-- Player added handling
	Players.PlayerAdded:Connect(function(player)
		self:LoadProfile(player)
	end)
	
	-- Player removing handling
	Players.PlayerRemoving:Connect(function(player)
		self:ReleaseProfile(player)
	end)
	
	-- Load existing players (for hot reloads)
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			self:LoadProfile(player)
		end)
	end
end

function DataService:LoadProfile(player: Player)
	local profile: any = (profileStore :: any):LoadProfileAsync("Player_" .. player.UserId, "ForceLoad")
	
	if profile then
		profile:Reconcile() -- Fill in missing data from template
		profile:ListenToRelease(function()
			profiles[player] = nil
		end)
		
		profiles[player] = profile
		
		-- Notify client that data is ready
		self.Client.DataChanged:Fire(player, profile.Data)
		
		print("[DataService] Loaded profile for " .. player.Name)
	else
		warn("[DataService] Failed to load profile for " .. player.Name)
	end
end

function DataService:ReleaseProfile(player: Player)
	local profile = profiles[player]
	if profile then
		profile:Release()
	end
end

function DataService:GetProfile(player: Player): any
	return profiles[player]
end

function DataService:GetPlayerData(player: Player, key: string): any?
	local profile = profiles[player]
	if profile then
		return profile.Data[key]
	end
	return nil
end

function DataService:SetPlayerData(player: Player, key: string, value: any)
	local profile = profiles[player]
	if profile then
		profile.Data[key] = value
		self.Client.DataChanged:Fire(player, profile.Data)
	end
end

-- Client API
function DataService.Client:Get(player: Player, key: string): any
	return self.Server:GetPlayerData(player, key)
end

return DataService
