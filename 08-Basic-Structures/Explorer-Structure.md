# Basic Roblox Explorer Structures

Use this as a reference for where common objects should live.

## 1. Leaderstats + DataStore

```text
ServerScriptService
└── PlayerData (Script)
```

The script creates this at runtime:

```text
Players
└── Player
    └── leaderstats
        └── Money (IntValue)
```

If you use the DataStore script, you do **not** also need a separate leaderstats script creating the same `Money` value.

---

## 2. Basic coin setup

```text
Workspace
└── Coin (Part)
    ├── Coin (Script)
    └── CollectSound (Sound) [optional; script can create it]
```

Suggested Part properties:

- Anchored = true
- CanCollide = false
- CanTouch = true
- Shape/material/mesh as desired

---

## 3. Money GUI

```text
StarterGui
└── MoneyGui (ScreenGui)
    ├── MoneyLabel (TextLabel)
    └── MoneyGui (LocalScript)
```

The LocalScript reads `Players.LocalPlayer.leaderstats.Money` and updates `MoneyLabel`.

---

## 4. RemoteEvent setup

```text
ReplicatedStorage
└── AddMoney (RemoteEvent)

ServerScriptService
└── RemoteEventServer (Script)

StarterPlayer
└── StarterPlayerScripts
    └── RemoteEventClient (LocalScript)
```

Use RemoteEvents when the client and server need to communicate.

Important: the server must validate information sent by clients.

---

## 5. Tagged coins with CollectionService

```text
Workspace
├── Coin1 (Part) [Tag: Coin]
├── Coin2 (Part) [Tag: Coin]
└── Coin3 (Part) [Tag: Coin]

ServerScriptService
└── TaggedCoins (Script)
```

Instead of putting the same Script inside every coin, one central Script handles every object tagged `Coin`.

This pattern scales much better for larger games.

---

## 6. Coin pickup animation

```text
ReplicatedStorage
└── CoinCollected (RemoteEvent)

StarterGui
└── MoneyGui (ScreenGui)
    ├── MoneyLabel (TextLabel)
    └── CoinPickupAnimation (LocalScript)
```

The server should tell only the player who collected the coin to play the visual effect.

Visual effects should usually be client-side, while money/rewards should be controlled by the server.

---

# Core Roblox service guide

## Workspace
3D objects that physically exist in the game world.

## ServerScriptService
Server-only gameplay logic. Ideal for DataStores, rewards, validation, NPC systems, etc.

## ReplicatedStorage
Objects shared between server and clients. Common location for RemoteEvents, RemoteFunctions, ModuleScripts, and shared assets.

## StarterGui
GUI copied into each player's `PlayerGui` when they join.

## StarterPlayerScripts
LocalScripts that should run for every player.

## ServerStorage
Server-only stored models/assets that clients should not directly access.

# Rule of thumb

- Permanent game data/rewards: **server**
- DataStore access: **server only**
- UI and visual effects: **client**
- Client/server communication: **RemoteEvents/RemoteFunctions**
- Shared reusable code: **ModuleScripts**
