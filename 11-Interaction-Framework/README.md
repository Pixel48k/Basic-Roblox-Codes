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

The current teaching version has `DEBUG = true`, so Output shows exactly where an interaction succeeds or gets rejected. Once the system is stable you can change it to `false`.

### `ATMHandler.lua`

Create as:

```text
ServerScriptService
└── Modules
    └── InteractionHandlers
        └── ATMHandler (ModuleScript)
```

It defines `Type = "ATM"`, validates `RewardAmount`, calls `RewardService.AddMoney`, and fires `ReplicatedStorage.MoneyCollected` so the player's notification appears.

If `MoneyCollected` does not exist, the current handler creates the RemoteEvent automatically on the server. If an object named `MoneyCollected` exists but is not a RemoteEvent, the module reports an error.

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
└── MoneyCollected (RemoteEvent; created automatically if missing)
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

When setup is correct, Play mode should show messages similar to:

```text
[InteractionSystem] Loaded handler: ATM
[InteractionSystem] Connected interactable: Workspace.ATM Type: ATM
```

When the player presses the prompt, a successful ATM interaction should then show:

```text
[InteractionSystem] Prompt triggered: Workspace.ATM by PlayerName
ATM reward successful: PlayerName received 100 from Workspace.ATM
[InteractionSystem] Interaction completed: Workspace.ATM
```

These messages are useful for finding exactly where a broken interaction stops.

### Common failure messages

`Infinite yield possible on ServerScriptService.Modules:WaitForChild("InteractionHandlers")`

Create the missing `InteractionHandlers` Folder and put `ATMHandler` inside it.

`No handler exists for InteractionType: ATM`

Verify `ATMHandler` is a ModuleScript inside `ServerScriptService > Modules > InteractionHandlers` and that it returns `ATMHandler` at the bottom.

`Interaction rejected by distance check`

The prompt triggered, but the server thought the character was too far from the Part containing the ProximityPrompt. Check the prompt location and `MaxActivationDistance`.

`ATM has an invalid RewardAmount`

Make sure `RewardAmount` is a Number Attribute greater than 0 on the same object carrying the `Interactable` tag.

`ATM reward failed for player`

The interaction reached `RewardService`, but `leaderstats.Money` could not be found or was not the expected value type. Verify `PlayerData` is creating `leaderstats > Money`.

Do not run the old standalone `ATMSystem` for the same ATM at the same time.
