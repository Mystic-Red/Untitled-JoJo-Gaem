local TheWorldConfig = {
	Name = "The World",
	Keybinds = {
		Summon = Enum.KeyCode.Q,
		Barrage = Enum.KeyCode.E,
		Punch = Enum.UserInputType.MouseButton1,
		HeavyPunch = Enum.KeyCode.R,
		KnifeThrow = Enum.KeyCode.T,
		ZAWARUDO = Enum.KeyCode.G,
		ROLOROLADAAA = Enum.KeyCode.H,
		Fly = Enum.KeyCode.Z,
		SHINEI = Enum.KeyCode.X,
	},
	Stats = {
		Damage = 15,
		Speed = 1,
		Range = 5,
		TimeStopDuration = 5,
		FlySpeed = 10,
		FlyDuration = 10,
		VampireMultiplier = 0.5,
	},
	Cooldowns = {
		Barrage = 5,
		Punch = 0.3,
		HeavyPunch = 2,
		KnifeThrow = 3,
		ZAWARUDO = 90,
		ROLOROLADAAA = 60,
		Fly = 35,
		SHINEI = 20,
	},
	Animations = {
		Summon = "rbxassetid://75569716167998",
		Idle = "rbxassetid://104254833934061",
		Barrage = "rbxassetid://128311074523798",
		Punch = {
			[1] = "rbxassetid://119968933020396",
			[2] = "rbxassetid://134781337441667",
			[3] = "rbxassetid://89543857795473",
			[4] = "rbxassetid://120763772114495",
			[5] = "rbxassetid://113517539598430",
		},
		HeavyPunch = "rbxassetid://117329678597738",
		KnifeThrow = "rbxassetid://ID",
		ZAWARUDO = "rbxassetid://ID",
		ROLOROLADAAA = "rbxassetid://ID",
		Fly = "rbxassetid://ID",
		SHINEI = "rbxassetid://ID",
	},
	Attributes = {
		Barrage = {
			CanBeCancelled = false,
			Blockable = true,
			Interruptible = false,
			CanClash = true, -- like in YBA, you can "barrage the barrage", and if you are far enough, you can do the barrage clash like in All Stars Battle (https://www.youtube.com/watch?v=NawnMAD_OFs)
		},
		Punch = {
			CanBeCancelled = true,
			Blockable = true,
			Interruptible = false,
			LastPunchStun = 0.5,
		},
		HeavyPunch = {
			CanBeCancelled = false,
			Blockable = false,
			Interruptible = false,
			StunDuration = 1,
			BlockStun = 2,
			CanParry = true,
		},
		KnifeThrow = {
			CanBeCancelled = false,
			Blockable = false,
			Interruptible = false,
			StunDuration = 1,
			BlockStun = 2.5,
			BlockDamage = 2,
			CanPierce = true,
			BleedDamage = 0.5, -- 0.5 damage per second until 4 seconds
		},
		ZAWARUDO = {
			CanBeCancelled = false,
			Blockable = false,
			Interruptible = false,
			CanClash = true,
		},
		ROLOROLADAAA = {
			CanBeCancelled = false,
			Blockable = false,
			Interruptible = false,
			CanClash = true, -- in terms of barrage (like in the anime) so you take less damage, not an actual clash
			StunDuration = 3,
			TimeStopStun = 2.5,
		},
		Fly = {
			CanBeCancelled = false,
			Blockable = false,
			Interruptible = false,
			CanClash = false,
		},
		SHINEI = {
			CanBeCancelled = false,
			Blockable = false,
			Interruptible = false,
			CanClash = false,
			StunDuration = 2,
		},
	},
	Damage = {
		Barrage = 15,
		Punch = 12, -- in total (2, 2, 2, 2, 4)
		HeavyPunch = 20,
		KnifeThrow = 25, -- plus BleedDamage = 27
		ZAWARUDO = 0, -- its a time stop, it cant damage you
		ROLOROLADAAA = 60,
		Fly = 0, -- same that zawarudo, but now its a fly, not time stop
		SHINEI = 45,
	},
	SFX = {
		Summon = "rbxassetid://7042767974",
		Barrage = "rbxassetid://133522494006990",
		Punch = "rbxassetid://71456836477878",
		HeavyPunch = "rbxassetid://126616897036860",
		KnifeThrow = "rbxassetid://ID",
		ZAWARUDO = "rbxassetid://99680674381285",
		ROLOROLADAAA = "rbxassetid://119610008744641",
		Fly = "rbxassetid://ID",
		SHINEI = "rbxassetid://137430960574239",
	},
	Requirements = {
		Punch = 0,
		Barrage = 0,
		HeavyPunch = 15,
		KnifeThrow = 30,
		ZAWARUDO = 75,
		ROLOROLADAAA = 75,
		Fly = 50,
		SHINEI = 25,  --these are all levels
	},
}

return TheWorldConfig
