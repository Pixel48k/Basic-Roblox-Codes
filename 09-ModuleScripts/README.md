# ModuleScripts — RewardService

ModuleScripts let multiple scripts share the same functions and logic. Instead of every coin, quest, job, or property script directly editing Money, they can call one reusable service.

## Roblox Studio hierarchy

```text
ServerScriptService
├── PlayerData
├── Modules
│   └── RewardService      (ModuleScript)
└── RewardTest             (Script, temporary for testing)
```

## Step 1 — Create the module

Inside `ServerScriptService`, create a Folder named `Modules`. Inside it, create a `ModuleScript` named `RewardService` and paste the contents of `RewardService.lua`.

## Step 2 — Test it

Create a normal Script named `RewardTest` in `ServerScriptService` and paste `RewardTest.server.lua`.

When you press Play, wait about 3 seconds. The script should add 25 Money. Because it changes the same `leaderstats.Money` IntValue used by PlayerData, your GUI should update and the new amount will be saved by the existing DataStore system.

## Step 3 — Remove the test script

After confirming it works, delete or disable `RewardTest`. Keep `Modules > RewardService`; future systems will reuse it.

## Reusing the module

Any server Script can use:

```lua
local ServerScriptService = game:GetService("ServerScriptService")
local RewardService = require(ServerScriptService.Modules.RewardService)

RewardService.AddMoney(player, 10)
```

Never trust a client LocalScript to decide how much Money a player should receive. Award currency from server-side code.
