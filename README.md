# Basic Roblox Codes

A reusable Roblox/Luau learning repository for the systems built during the Roblox Game Development project.

Every concept folder contains a `README.md` that explains every code/example file in that folder, where it belongs in Roblox Studio, required setup, dependencies, and common mistakes.

## Current project architecture

The current money/ATM stack is:

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

StarterGui
└── MoneyNotification (LocalScript)
```

ATMs use the `Interactable` tag plus Attributes such as `InteractionType`, `RewardAmount`, and `Cooldown`. The newer `11-Interaction-Framework` replaces the older standalone ATM system for the active project.

## Folders

- `01-Leaderstats/` — basic non-saving leaderstats example
- `02-Coin-System/` — touch coin reward plus hover/rotation example
- `03-Money-GUI/` — adaptive animated money display
- `04-RemoteEvents/` — basic client/server RemoteEvent learning examples
- `05-CollectionService-Tags/` — one script managing many tagged coins
- `06-DataStore-Saving/` — persistent Money loading/saving
- `07-Coin-To-GUI-Animation/` — client pickup particles moving toward the money UI
- `08-Basic-Structures/` — Explorer hierarchy/reference notes
- `09-ModuleScripts/` — reusable `RewardService` and test script
- `10-Attributes/` — configurable values stored on Roblox Instances
- `10-RemoteEvents/` — current floating money notification client
- `11-ProximityPrompt-ATM/` — older standalone ATM lesson/reference
- `11-Interaction-Framework/` — current reusable tagged interaction framework

## Naming convention

- `*.server.lua` = normal server `Script`
- `*.client.lua` = `LocalScript`
- `*.lua` = usually a reusable `ModuleScript` or example

## Important project rules

Do not run two systems that create `leaderstats.Money`. If `06-DataStore-Saving/PlayerData.server.lua` is active, do not also run the basic `01-Leaderstats` script.

Do not run both the older standalone ATM system and the newer `11-Interaction-Framework` for the same ATM, or rewards can be processed twice.

For DataStores, publish the experience and enable **Studio Access to API Services** before testing.