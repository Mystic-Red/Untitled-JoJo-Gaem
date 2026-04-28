local StarPlatinumConfig = {
	Name = "Star Platinum",
	Keybinds = {
		Summon = Enum.KeyCode.Q,
		Barrage = Enum.KeyCode.E,
		Punch = Enum.UserInputType.MouseButton1,
		HeavyPunch = Enum.KeyCode.R,
		PrecisionStrike = Enum.KeyCode.T,
		OraBarrage = Enum.KeyCode.G,
		Suck = Enum.KeyCode.C,
		Fly = Enum.KeyCode.Z,
		StarFinger = Enum.KeyCode.X,
	},
	Stats = {
		Damage = 15.5,
		Speed = 0.9,
		Range = 5.5,
		TimeStopDuration = 5,
		FlySpeed = 10,
		FlyDuration = 10,
		HumanMultiplier = 0.5,
		PrecisionStrikeCanBeParriedWith = {
			Vampire = true,
			Cream = true,
		},
	},
	Cooldowns = {
		Barrage = 5,
		Punch = 0.3,
		HeavyPunch = 2,
		PrecisionStrike = 3,
		OraBarrage = 90,
		Suck = 60,
		Fly = 35,
		StarFinger = 20,
	},
	Animations = {
		Summon = "rbxassetid://ID",
		Idle = "rbxassetid://ID",
		Barrage = "rbxassetid://ID",
		Punch = {
			[1] = "rbxassetid://ID",
			[2] = "rbxassetid://ID",
			[3] = "rbxassetid://ID",
			[4] = "rbxassetid://ID",
			[5] = "rbxassetid://ID",
		},
		HeavyPunch = "rbxassetid://ID",
		PrecisionStrike = "rbxassetid://ID",
		OraBarrage = "rbxassetid://ID",
		Suck = "rbxassetid://ID",
		Fly = "rbxassetid://ID",
		StarFinger = "rbxassetid://ID",
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
		PrecisionStrike = {
			CanBeCancelled = false,
			Blockable = false,
			Interruptible = false,
			StunDuration = 1,
			BlockStun = 2.5,
			BlockDamage = 2,
			CanPierce = true,
			BleedDamage = 0.5, -- 0.5 damage per second until 4 seconds
			CanBeParried = true, --detailed in the stats
		},
		OraBarrage = {
			CanBeCancelled = false,
			Blockable = false,
			Interruptible = false,
			CanClash = false,
		},
		Suck = {
			CanBeCancelled = false,
			Blockable = true, --it only pulls you towards the enemy slower, but you still run out of oxygen
			Interruptible = false,
			CanClash = false,
			StunDuration = 0.5,
			DrownDamage = 2, -- 2 damage per second
		},
		Fly = {
			CanBeCancelled = false,
			Blockable = false,
			Interruptible = false,
			CanClash = false,
		},
		StarFinger = {
			CanBeCancelled = false,
			Blockable = false,
			Interruptible = false,
			CanClash = false,
			StunDuration = 2,
			BlockStunDuration = 2.5,
		},
	},
	Damage = {
		Barrage = 15,
		Punch = 12, -- in total (2, 2, 2, 2, 4)
		HeavyPunch = 20,
		PrecisionStrike = 25,
		OraBarrage = 60,
		Suck = 0, -- but the other person gains the effect of drowning that deals 3 damage per second and you pull them towards you so you can combo it with the ora barrage cuz uh, stun of 0.5 seconds yay!!!11!!!!
		Fly = 0, -- you are flying, you cant damage people while flying
		StarFinger = 35,
	},
	SFX = {
		Summon = "rbxassetid://ID",
		Barrage = "rbxassetid://ID",
		Punch = "rbxassetid://ID",
		HeavyPunch = "rbxassetid://ID",
		PrecisionStrike = "rbxassetid://ID",
		OraBarrage = "rbxassetid://ID",
		Suck = "rbxassetid://ID",
		Fly = "rbxassetid://ID",
		StarFinger = "rbxassetid://ID",
	},
	Requirements = {
		Punch = 0,
		Barrage = 0,
		HeavyPunch = 15,
		PrecisionStrike = 30,
		OraBarrage = 75,
		Suck = 35,
		Fly = 50,
		StarFinger = 25,  --these are all levels
	},
	Milestones = {
		StarPlatinum = 0,
		StarPlatinumTheWorld = 50,
		StarPlatinumPart6 = 100,
	},
}

return StarPlatinumConfig
