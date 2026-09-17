# Central Interaction Framework

This lesson replaces separate per-feature interaction scripts with one server-side interaction router plus reusable handler ModuleScripts.

## Studio structure

```text
ServerScriptService
├── InteractionSystem              (Script)
└── Modules
    ├── RewardService              (existing ModuleScript)
    └── InteractionHandlers        (Folder)
        └── ATMHandler             (ModuleScript)

ReplicatedStorage
└── MoneyCollected                 (existing RemoteEvent)
```

Each ATM remains a BasePart with a ProximityPrompt. Tag the ATM BasePart with `Interactable` and give it these Attributes:

- `InteractionType` (String) = `ATM`
- `RewardAmount` (Number) = desired reward
- `Cooldown` (Number) = desired cooldown

Delete/disable the old `ServerScriptService/ATMSystem` before testing, otherwise the ATM may be processed twice.

## Why this architecture matters

`InteractionSystem` handles discovery, distance validation, cooldowns, and routing. Feature-specific behavior lives in small handler modules. New interaction types such as doors, chests, terminals, or shops can later be added by creating another handler instead of rewriting the central system.
