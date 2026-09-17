# 01 — Leaderstats

## `Leaderstats.server.lua`

Creates Roblox's standard `leaderstats` Folder and a `Money` IntValue for every joining player.

### Put it here

```text
ServerScriptService
└── Leaderstats (Script)
```

Paste the contents of `Leaderstats.server.lua` into that Script.

### What it does

When a player joins it creates:

```text
Player
└── leaderstats
    └── Money (IntValue) = 0
```

Roblox automatically shows values inside a Folder named exactly `leaderstats` on the player list.

### Important

This is the basic non-saving version. Do **not** use it at the same time as `06-DataStore-Saving/PlayerData.server.lua`, because PlayerData already creates `leaderstats.Money` and also loads/saves it.