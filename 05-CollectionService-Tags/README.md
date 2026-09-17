# 05 — CollectionService Tags

## `TaggedCoins.server.lua`

Shows how one central server Script can manage many coins instead of putting the same Script inside every coin.

### Put it here

```text
ServerScriptService
└── TaggedCoins (Script)
```

Tag each coin Part with:

```text
Coin
```

using Roblox Studio's Tags section/Tag Editor.

### What it does

The script finds all Instances tagged `Coin`, connects their `Touched` events, awards Money, hides the collected coin, respawns it after 3 seconds, and automatically connects coins that receive the tag later.

It also disconnects event connections when tagged coins are removed.

This same architecture later evolves into the reusable `11-Interaction-Framework`.