# 11 — Standalone ProximityPrompt ATM (Older Lesson)

This folder is kept as a learning/reference version of an ATM implemented without the newer central interaction framework.

## `ATM.server.lua`

A standalone server Script for an ATM using a ProximityPrompt and reward/cooldown logic.

Use it only when following this older lesson or building a completely independent ATM. For the current project, prefer `11-Interaction-Framework`.

### Typical structure

```text
Workspace
└── ATM
    ├── ProximityPrompt
    └── ATM Script
```

The ATM requires `leaderstats.Money`/RewardService according to the code version used in the file.

### Important

Do **not** run this standalone ATM logic and the central `InteractionSystem + ATMHandler` on the same ATM. Two systems listening to the same interaction can cause duplicate rewards or confusing behavior.