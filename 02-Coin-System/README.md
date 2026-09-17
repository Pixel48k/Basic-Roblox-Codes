# 02 — Coin System

## `Coin.server.lua`

A simple touch-to-collect coin Script. It awards Money, plays a pickup sound, hides the coin, waits 3 seconds, and respawns it.

### Put it here

```text
Workspace
└── Coin (Part)
    └── CoinScript (Script)
```

The player must already have `leaderstats > Money` from either the basic Leaderstats lesson or PlayerData.

Key settings near the top of the file are `RESPAWN_TIME`, `REWARD`, and `SOUND_ID`.

## `CoinHover.client.lua`

Demonstrates the hover + rotation math using `RenderStepped` and `CFrame`.

Important: LocalScripts do not normally execute when placed directly under arbitrary Parts in Workspace. Treat this file as the client-animation logic to adapt into a LocalScript that runs from a valid client location such as `StarterPlayerScripts`, or convert the idea to a server animation if every player should share the same movement.

It uses a sine wave for vertical hovering and continuous Y-axis rotation.