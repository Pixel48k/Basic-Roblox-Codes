# ProximityPrompt ATM

This example gives Money only when a player activates a ProximityPrompt, such as by pressing E.

## Explorer setup

```text
Workspace
└── ATMPart (Part)
    ├── ProximityPrompt
    └── ATM (Script)

ServerScriptService
└── Modules
    └── RewardService (ModuleScript)
```

Paste `ATM.server.lua` into the normal Script inside the same Part as the ProximityPrompt.

Do not use a `.Touched` money script on the ATM Part, otherwise touching it can still give Money.

## Optional Attributes on ATMPart

Create these while not in Play mode:

- `RewardAmount` (Number), for example `500`
- `Cooldown` (Number), for example `5`

If they do not exist, the script falls back to 500 Money and a 5 second cooldown.

The cooldown is tracked per player, so one player using the ATM does not block another player from using it.
