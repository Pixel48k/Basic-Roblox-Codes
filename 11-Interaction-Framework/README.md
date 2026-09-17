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

Each ATM can be a BasePart or Model containing a ProximityPrompt. Put the `Interactable` tag and the Attributes on the same ATM object that the framework should treat as the interactable.

Required ATM Attributes:

- `InteractionType` (String) = `ATM`
- `RewardAmount` (Number) = desired reward
- `Cooldown` (Number) = desired cooldown

Delete/disable the old `ServerScriptService/ATMSystem` before testing, otherwise the ATM may be processed twice.

## Troubleshooting

If Output shows:

```text
Infinite yield possible on 'ServerScriptService.Modules:WaitForChild("InteractionHandlers")'
```

then the required `InteractionHandlers` Folder is missing or is in the wrong place. Stop Play mode, create a **Folder** named exactly `InteractionHandlers` inside `ServerScriptService > Modules`, then move the `ATMHandler` **ModuleScript** inside it.

The exact hierarchy must be:

```text
ServerScriptService
└── Modules
    ├── RewardService
    └── InteractionHandlers
        └── ATMHandler
```

After restarting Play mode, Output should include `Loaded interaction handler: ATM` and `Connected interactable: ... Type: ATM`.

## Why this architecture matters

`InteractionSystem` handles discovery, distance validation, cooldowns, and routing. Feature-specific behavior lives in small handler modules. New interaction types such as doors, chests, terminals, or shops can later be added by creating another handler instead of rewriting the central system.
