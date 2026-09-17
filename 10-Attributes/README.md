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

## Important: create the Attributes in Edit mode

Do **not** rely on a normal Script to create Attributes and then stop Play mode. Changes made by game scripts while Play mode is running are runtime changes and disappear when the test ends.

Instead, before pressing Play:

1. Select `Workspace > RewardPad`.
2. Open the **Properties** window.
3. Find the **Attributes** section near the bottom.
4. Click **Add Attribute** / the `+` button.
5. Create a **Number** attribute named `RewardAmount` and set it to `100`.
6. Create another **Number** attribute named `Cooldown` and set it to `2`.

You should then see:

```text
Attributes
RewardAmount    100
Cooldown        2
```

Paste `AttributeRewardPad.server.lua` into the Script inside `RewardPad`.

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

`SetAttribute` changes the attribute on the current running instance. To make an Attribute permanently visible in Studio, create it on the object while not in Play mode.
