# Attributes

Roblox Attributes let you attach custom data directly to Instances and edit it from the Properties window.

## Lesson: configurable reward pad

Explorer setup:

```text
Workspace
└── RewardPad (Part)
    └── RewardPadScript (Script)

ServerScriptService
└── Modules
    └── RewardService (ModuleScript)
```

Paste `AttributeRewardPad.server.lua` into the Script inside `RewardPad`.

When you first run the game, the script creates two attributes on the Part if they do not already exist:

- `RewardAmount` = `100`
- `Cooldown` = `2`

You can edit those values in Studio without changing the script.

Examples:

- Bronze pad: `RewardAmount = 25`
- Gold pad: `RewardAmount = 500`
- Rare pad: `RewardAmount = 5000`

The same pattern can later be used for coins, properties, doors, NPCs, quests, upgrades, weapons, and interactable objects.

## Core API

```lua
part:SetAttribute("RewardAmount", 100)
local reward = part:GetAttribute("RewardAmount")
```

Attributes are useful when many copies of the same object should share one script but have different settings.
