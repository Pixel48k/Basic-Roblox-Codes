# DataStore Money Saving Setup

Use `PlayerData.server.lua` as the only script that creates `leaderstats` and `Money`.

## Roblox Studio setup

1. Publish the experience.
2. Open Game Settings.
3. Open Security.
4. Enable **Studio Access to API Services**.
5. In `ServerScriptService`, disable or delete the old standalone Leaderstats script.
6. Add a new `Script` to `ServerScriptService` named `PlayerData`.
7. Paste the contents of `PlayerData.server.lua` into it.

Expected Explorer structure:

```text
ServerScriptService
└── PlayerData (Script)

Workspace
└── Coins / your existing coin objects

StarterGui
└── MoneyGui
    └── your existing money GUI LocalScript
```

The DataStore script creates this automatically for each player:

```text
Player
└── leaderstats
    └── Money (IntValue)
```

## Test

1. Press Play.
2. Collect some coins and confirm `Money` increases.
3. Stop the test completely.
4. Press Play again.
5. Your previous Money value should load.

Open **View > Output** while testing. Successful saves/loads print messages such as:

```text
Saved PlayerName with 15 Money
Loaded PlayerName with 15 Money
```

## Important

Do not test by resetting the character. Resetting only respawns the character; it does not simulate the player leaving the server. Stop the Play session and start it again.
