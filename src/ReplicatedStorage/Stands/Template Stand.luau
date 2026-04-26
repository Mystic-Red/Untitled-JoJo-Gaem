local StandConfig = {
    Name = "Template Stand",
    Keybinds = {
        Summon = Enum.KeyCode.Q,
        Barrage = Enum.KeyCode.E,
        Punch = Enum.UserInputType.MouseButton1,
        HeavyPunch = Enum.KeyCode.R,
        Ability1 = Enum.KeyCode.T,
        Ability2 = Enum.KeyCode.G,
        Ability3 = Enum.KeyCode.H,
        Ability4 = Enum.KeyCode.Z,
        Ability5 = Enum.KeyCode.X, --you can change the keybinds to whatever you want
    },
    Stats = {
        Damage = 0,
        Speed = 0,
        Range = 0,
        Stat1 = 0,
        Stat2 = 0,
        Stat3 = 0,
        Stat4 = 0,
        Stat5 = 0, -- Add more stats as needed. Add them in the same order as the keybinds. also, you need to change the 0 to the number you want
    },
    Cooldowns = {
        Barrage = 0,
        Ability1 = 0,
        Ability2 = 0,
        Ability3 = 0,
        Ability4 = 0,
        Ability5 = 0, -- Add more cooldowns as needed. Add them in the same order as the keybinds
    },
    Animations = {
        Summon = "rbxassetid://",
        Idle = "rbxassetid://",
        Barrage = "rbxassetid://",
        Punch = "rbxassetid://",  -- you can use a table for multiple animations
        HeavyPunch = "rbxassetid://",
        Ability1 = "rbxassetid://",
        Ability2 = "rbxassetid://",
        Ability3 = "rbxassetid://",
        Ability4 = "rbxassetid://",
        Ability5 = "rbxassetid://", -- Add more animations as needed. Add them in the same order as the keybinds
    },
    Attributes = {
        Barrage = {
            CanBeCancelled = false,
            Blockable = true,
            Interruptible = false,
            CanClash = true,
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
        },
        Ability1 = {
            CanBeCancelled = false,
            Blockable = false,
            Interruptible = false,
        },
        Ability2 = {
            CanBeCancelled = false,
            Blockable = false,
            Interruptible = false,
        },
        Ability3 = {
            CanBeCancelled = false,
            Blockable = false,
            Interruptible = false,
        },
        Ability4 = {
            CanBeCancelled = false,
            Blockable = false,
            Interruptible = false,
        },
        Ability5 = {
            CanBeCancelled = false,
            Blockable = false,
            Interruptible = false, -- add more attributes/abilities as needed
        },
    },
    Damage = {
        Barrage = 0,
        Ability1 = 0,
        Ability2 = 0,
        Ability3 = 0,
        Ability4 = 0,
        Ability5 = 0, -- add more damage values as needed
    },
    SFX = {
        Summon = "rbxassetid://",
        Idle = "rbxassetid://",
        Barrage = "rbxassetid://",
        Punch = "rbxassetid://",
        HeavyPunch = "rbxassetid://",
        Ability1 = "rbxassetid://",
        Ability2 = "rbxassetid://",
        Ability3 = "rbxassetid://",
        Ability4 = "rbxassetid://",
        Ability5 = "rbxassetid://", -- add more SFX as needed
    },
    Requirements = {
        Punch = 0,
        Barrage = 0,
        HeavyPunch = 0,
        Ability1 = 0,
        Ability2 = 0,
        Ability3 = 0,
        Ability4 = 0,
        Ability5 = 0, -- add more requirements as needed
    },
}

return StandConfig