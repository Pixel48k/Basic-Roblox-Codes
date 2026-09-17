# 11 — Central Interaction Framework

This is the **current recommended interaction architecture** for the project. It replaces separate scripts such as `ATMSystem`, `DoorSystem`, and `ChestSystem` with one router plus reusable handler ModuleScripts.

## Files

### `InteractionSystem.server.lua`

Put it in:

```text
ServerScriptService
└── InteractionSystem (Script)
```

It loads handler modules, finds objects tagged `Interactable`, finds their ProximityPrompt, validates player distance, applies per-player/per-object cooldowns, reads `InteractionType`, and routes the interaction to the correct handler.

It supports the `Interactable` tag on either a BasePart or a Model containing a descendant ProximityPrompt.

### `ATMHandler.lua`

Create as:

```text
ServerScriptService
└── Modules
    └── InteractionHandlers
        └── ATMHandler (ModuleScript)
```

It defines `Type = "ATM"`, validates `RewardAmount`, calls `RewardService.AddMoney`, and fires `ReplicatedStorage.MoneyCollected` so the player's notification appears.

## Required complete hierarchy

```text
ServerScriptService
├── PlayerData
├── InteractionSystem
└── Modules
    ├── RewardService
    └── InteractionHandlers
        └── ATMHandler

ReplicatedStorage
└── MoneyCollected
```

## ATM setup

Put the `Interactable` tag and all these Attributes on the **same ATM object**:

```text
InteractionType = "ATM"   (String)
RewardAmount = 100         (Number)
Cooldown = 0               (Number)
```

The ProximityPrompt can be inside a child Part:

```text
Workspace
└── ATM                     [Tag: Interactable]
    Attributes:
      InteractionType = ATM
      RewardAmount = 100
      Cooldown = 0
    └── Body (Part)
        └── ProximityPrompt
```

Do not put the tag on the Model while putting the Attributes on a different child Part.

## ProximityPrompt checklist

If the prompt itself does not appear, verify the ProximityPrompt is inside a physical BasePart/Attachment and check:

```text
Enabled = true
KeyboardKeyCode = E
MaxActivationDistance = 10
HoldDuration = 0
RequiresLineOfSight = false   (recommended while testing)
```

The interaction framework listens to `Triggered`; it does not hide or disable the visual prompt.

## Expected Output

When setup is correct, Play mode should show:

```text
Loaded interaction handler: ATM
Connected interactable: Workspace.ATM Type: ATM
```

If you see `Infinite yield possible on ServerScriptService.Modules:WaitForChild("InteractionHandlers")`, create the missing `InteractionHandlers` Folder and put `ATMHandler` inside it.

If the handler loads but no interactable connects, check the `Interactable` tag.

Do not run the old standalone `ATMSystem` for the same ATM at the same time.