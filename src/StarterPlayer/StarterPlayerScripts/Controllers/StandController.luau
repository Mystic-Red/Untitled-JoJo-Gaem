--!strict
-- StandController: Handles all client-side Stand functionality including summoning and input

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local KnitS = require(ReplicatedStorage.Packages.Knit.KnitServer)
local KnitC = require(ReplicatedStorage.Packages.Knit.KnitClient)

local localPlayer = Players.LocalPlayer

local StandController = KnitC.CreateController {
	Name = "StandController",
}

-- Local state
local _currentStand: Model?
local _currentStandName: string?
local _currentAnimationTrack: AnimationTrack?
local isSummoning: boolean = false

-- Configuration cache
local standConfigs: { [string]: { [string]: any } } = {}

function StandController:KnitInit()
	-- Load stand configs
	local standsFolder = ReplicatedStorage:WaitForChild("Stands")
	for _, configModule in ipairs(standsFolder:GetChildren()) do
		if configModule:IsA("ModuleScript") then
			standConfigs[configModule.Name] = require(configModule) :: { [string]: any }
		end
	end
end

function StandController:KnitStart()
	local standService = KnitS.GetService("StandService")

	-- Listen for server signals
	standService.SummonStand:Connect(function(standName: string)
		self:OnStandSummoned(standName)
	end)

	standService.UnsummonStand:Connect(function()
		self:OnStandUnsummoned()
	end)

	-- Setup input handling
	self:SetupInput()

	-- Clean up on death
	local function onCharacterAdded(character: Model)
		local humanoid = character:WaitForChild("Humanoid", 5) :: Humanoid?
		if humanoid then
			humanoid.Died:Connect(function()
				self:Cleanup()
			end)
		end
	end

	if localPlayer.Character then
		onCharacterAdded(localPlayer.Character)
	end
	localPlayer.CharacterAdded:Connect(onCharacterAdded)
end

function StandController:SetupInput()
	UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessed: boolean)
		if gameProcessed then return end
		if isSummoning then return end

		local standService = KnitS.GetService("StandService")
		local equippedStand = self:GetEquippedStand()

		if not equippedStand or equippedStand == "None" then return end

		local config = standConfigs[equippedStand]
		if not config then return end

		-- Check for summon key (Q by default for The World)
		if input.KeyCode == config.Keybinds.Summon then
			isSummoning = true

			-- Request summon from server
			local _success = standService:RequestSummon()

			-- Reset flag after a short delay to prevent spam
			task.delay(0.5, function()
				isSummoning = false
			end)
		end
	end)
end

function StandController:GetEquippedStand(): string
	-- For now, default to "The World" for testing
	-- In production, this should come from player data
	local dataService = KnitS.GetService("DataService")
	local stand = dataService:Get("Stand")

	-- Fallback for testing
	if not stand or stand == "None" then
		return "The World"
	end

	return stand
end

function StandController:OnStandSummoned(standName: string)
	_currentStandName = standName

	local config = standConfigs[standName]
	if not config then return end

	-- Play summon animation and effects
	self:PlaySummonEffects(config)

	print("[StandController] Summoned " .. standName)
end

function StandController:OnStandUnsummoned()
	self:Cleanup()
	print("[StandController] Stand unsummoned")
end

function StandController:PlaySummonEffects(config)
	local character = localPlayer.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	-- Play summon sound
	if config.SFX and config.SFX.Summon then
		local summonSound = Instance.new("Sound")
		summonSound.SoundId = config.SFX.Summon :: string
		summonSound.Volume = 0.8
		summonSound.Parent = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character.PrimaryPart
		summonSound:Play()
		summonSound.Ended:Connect(function()
			summonSound:Destroy()
		end)
	end

	-- Play summon animation
	if config.Animations and config.Animations.Summon then
		local animator: Animator? = humanoid:FindFirstChildOfClass("Animator")
		if not animator then
			animator = Instance.new("Animator")
			animator.Parent = humanoid
		end

		if not animator then return end

		local summonAnim = Instance.new("Animation")
		summonAnim.AnimationId = config.Animations.Summon :: string
		summonAnim.Parent = script

		local track = animator:LoadAnimation(summonAnim)
		_currentAnimationTrack = track

		-- Configure the animation
		track.Priority = Enum.AnimationPriority.Action4
		track:Play()

		-- Clean up after animation completes
		track.Ended:Connect(function()
			summonAnim:Destroy()
		end)
	end
end

function StandController:Cleanup()
	if _currentAnimationTrack then
		_currentAnimationTrack:Stop()
		_currentAnimationTrack = nil
	end

	_currentStand = nil
	_currentStandName = nil
end

return StandController
