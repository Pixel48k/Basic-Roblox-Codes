# 10 — Money Notification RemoteEvent

## `MoneyNotification.client.lua`

This is the current client-side ATM reward popup system.

### Required setup

```text
ReplicatedStorage
└── MoneyCollected (RemoteEvent)

StarterGui
└── MoneyNotification (LocalScript)
```

Paste `MoneyNotification.client.lua` into the LocalScript.

### What it does

Every time the server fires:

```lua
MoneyCollected:FireClient(player, rewardAmount)
```

this LocalScript creates a **new independent** `+$amount` TextLabel. Rapid collections therefore show `+$100`, `+$100`, `+$100` separately instead of combining them.

Each popup starts on the right side, rises upward toward the middle height of the screen, fades, and destroys itself.

Tune `X_POSITION`, `START_Y`, `END_Y`, `RISE_TIME`, and `FADE_START` near the top of the file to change the animation.

The current `11-Interaction-Framework/ATMHandler.lua` fires this RemoteEvent after a successful server-side reward.