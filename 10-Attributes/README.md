# 10 — Attributes

Attributes are custom values stored directly on Roblox Instances and editable in the Properties window.

## `AttributeRewardPad.server.lua`

A learning example showing how one Script can read configuration from Attributes rather than hardcoding every value.

Typical Attributes:

```text
RewardAmount = 100   (Number)
Cooldown = 2         (Number)
```

Create them in **Edit mode** from the object's Properties > Attributes section, then place the Script according to the setup expected by the example.

The code reads values using:

```lua
object:GetAttribute("RewardAmount")
object:GetAttribute("Cooldown")
```

### Why this matters

The active ATM system uses the same idea. Different ATMs can have different `RewardAmount` and `Cooldown` values without editing their Lua code.

Changes made by game scripts while Play mode is running are runtime changes and disappear when the test ends; create permanent Studio Attributes while not playing.