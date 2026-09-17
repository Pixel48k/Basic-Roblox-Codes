# 07 — Coin-to-GUI Animation

## `CoinPickupAnimation.client.lua`

Creates a burst of small UI particles that fly from a supplied screen position toward `MoneyLabel`.

### Put it here

```text
StarterGui
└── MoneyGui (ScreenGui)
    ├── MoneyLabel (TextLabel)
    └── CoinPickupAnimation (LocalScript)
```

Create this RemoteEvent:

```text
ReplicatedStorage
└── CoinCollected (RemoteEvent)
```

### What it does

When the LocalScript receives a `Vector2` screen position through `CoinCollected.OnClientEvent`, it creates eight small circles, offsets them slightly, Tweens them toward the center of the Money label, then destroys them.

### Important dependency

The event must provide a valid client screen-space `Vector2`. A server cannot directly know a player's viewport coordinates, so the surrounding pickup system must obtain/project the visual position on the client or otherwise provide a suitable screen position.