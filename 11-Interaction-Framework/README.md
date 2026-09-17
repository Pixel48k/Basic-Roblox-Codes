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

Each ATM can be a BasePart or Model containing a ProximityPrompt. Put the `Interactable` tag and all ATM Attributes on the **same exact ATM object** that the framework should treat as the interactable.

Required ATM Attributes on that same tagged object:

- `InteractionType` (String) = `ATM`
- `RewardAmount` (Number) = desired reward
- `Cooldown` (Number) = desired cooldown

The `ProximityPrompt` may be inside a descendant BasePart of the tagged Model/Part.

Example:

```text
Workspace
└── ATM                     [Tag: Interactable]
    Attributes:
      InteractionType = ATM
      RewardAmount = 100
      Cooldown = 0
    └── Body
        └── ProximityPrompt
```

Do not put the tag on the Model while putting `RewardAmount` on a child Part, or vice versa. The handler reads the Attributes from the exact object carrying the `Interactable` tag.

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

After restarting Play mode, Output should include:

```text
Loaded interaction handler: ATM
Connected interactable: Workspace.ATM Type: ATM
```

If `Loaded interaction handler: ATM` appears but no `Connected interactable` line appears, the ATM probably does not have the `Interactable` tag.

If `Connected interactable` appears but using the prompt gives no reward, verify that the exact tagged object has `InteractionType = ATM`, `RewardAmount` as a Number greater than 0, and `Cooldown` as a Number.

## Why this architecture matters

`InteractionSystem` handles discovery, distance validation, cooldowns, and routing. Feature-specific behavior lives in small handler modules. New interaction types such as doors, chests, terminals, or shops can later be added by creating another handler instead of rewriting the central system.
