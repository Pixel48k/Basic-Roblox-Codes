# Money GUI Setup

Use `MoneyGui.client.lua` for the custom money display.

## Recommended hierarchy

```text
StarterGui
└── MoneyGui (ScreenGui)
    ├── MoneyLabel (TextLabel)
    └── MoneyGuiController (LocalScript)
```

The LocalScript may also be placed directly inside `MoneyLabel`; the script supports both layouts.

## Required player data

The server must create:

```text
Player
└── leaderstats
    └── Money (IntValue)
```

The DataStore example in `06-DataStore-Saving/PlayerData.server.lua` already creates this value.

## Important

Do not run two different LocalScripts that both write to the same money TextLabel. Keep one money GUI controller only.

The controller displays the loaded value immediately and then animates later Money changes one number at a time. It does not resize the label or add UIScale objects, so it will not alter the UI layout.