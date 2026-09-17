# 09 — ModuleScripts / RewardService

ModuleScripts let multiple systems reuse the same functions instead of duplicating logic.

## `RewardService.lua`

Create a ModuleScript here:

```text
ServerScriptService
└── Modules
    └── RewardService
```

`RewardService.AddMoney(player, amount)` validates the Player and amount, finds `leaderstats.Money`, adds the reward, and returns `true` on success or `false` on failure.

This is the reward API used by the newer ATM interaction framework.

## `RewardTest.server.lua`

Temporary learning/test Script. Put it in `ServerScriptService`; it requires RewardService and gives a small reward after the player joins so you can confirm the module works.

Delete or disable the test Script after testing. Keep `Modules > RewardService`.

### Reuse example

```lua
local ServerScriptService = game:GetService("ServerScriptService")
local RewardService = require(ServerScriptService.Modules.RewardService)

RewardService.AddMoney(player, 100)
```

Currency rewards should be decided by server-side code, not trusted directly from a client.