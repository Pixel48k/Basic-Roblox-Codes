# 04 — RemoteEvents Basics

These are learning examples for client ↔ server communication. They are not the current ATM implementation.

## Required setup

Create:

```text
ReplicatedStorage
└── AddMoney (RemoteEvent)
```

## `RemoteEvent.client.lua`

Example LocalScript that calls:

```lua
AddMoney:FireServer(1)
```

Use this pattern when a client action needs to request something from the server. In a real game, call it from a button, tool, or interaction instead of firing immediately on startup.

## `RemoteEvent.server.lua`

Place as a Script in `ServerScriptService`. It listens to `AddMoney.OnServerEvent`, validates that the amount is numeric, clamps it, and only then changes `leaderstats.Money`.

This demonstrates the security rule: **never trust values sent by the client without server validation**.

For the active ATM project, rewards are decided entirely by the server through `RewardService` and the interaction framework.