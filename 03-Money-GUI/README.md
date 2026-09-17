# 03 — Money GUI

## `MoneyGui.client.lua`

Controls the player's custom Money TextLabel and animates changes instead of instantly jumping between values.

### Recommended Studio setup

```text
StarterGui
└── MoneyGui (ScreenGui)
    ├── MoneyLabel (TextLabel)
    └── MoneyGuiController (LocalScript)
```

Paste `MoneyGui.client.lua` into the LocalScript. It can also sit directly inside the money TextLabel.

### Required data

The player must have:

```text
Player
└── leaderstats
    └── Money (IntValue)
```

`06-DataStore-Saving/PlayerData.server.lua` creates this automatically.

### What it does

It finds the Money label, immediately displays the loaded value, listens for Money changes, and animates toward the new value. Small changes count nearly one-by-one; large changes automatically use larger steps so the UI catches up quickly.

Tune `MAX_VISIBLE_STEPS` and `STEP_DELAY` to adjust speed/smoothness.

### Important

Keep only one LocalScript writing to the same Money TextLabel.