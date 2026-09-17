# 06 — DataStore Saving

## `PlayerData.server.lua`

This is the project's persistent Money system. Put it in `ServerScriptService` as a normal Script.

It creates `leaderstats > Money`, loads saved Money when a player joins, saves when they leave, autosaves every 60 seconds, and saves all players during server shutdown.

It uses DataStore name:

```text
PlayerMoney_v1
```

and keys in the form `Player_<UserId>`.

### Important

Do not also run `01-Leaderstats/Leaderstats.server.lua`; PlayerData already creates the leaderstats structure.

## `SETUP.md`

Contains the Studio setup/testing checklist for DataStores, including publishing the experience and enabling Studio Access to API Services.

### Recommended hierarchy

```text
ServerScriptService
└── PlayerData (Script)
```

If Output says data cannot be loaded/saved while testing, verify the experience is published and API access is enabled.