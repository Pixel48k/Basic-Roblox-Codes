# Basic Roblox Codes

A reusable Roblox/Luau code library for learning and building games.

This repository contains the core systems we have used in our Roblox project so far, with clear Explorer placement notes and reusable examples.

## Contents

- `01-Leaderstats/` — basic player currency/leaderstats setup
- `02-Coin-System/` — collectible coin logic, respawning, hover/rotation, and pickup sound
- `03-Money-GUI/` — displaying money and animating number changes
- `04-RemoteEvents/` — basic client/server communication examples
- `05-CollectionService-Tags/` — using tags to manage groups of objects
- `06-DataStore-Saving/` — saving/loading player money
- `07-Coin-To-GUI-Animation/` — polished client-side pickup feedback
- `08-Basic-Structures/` — Roblox Explorer hierarchy reference

## Naming convention

- `*.server.lua` = normal `Script` running on the server
- `*.client.lua` = `LocalScript` running on the client
- `*.lua` = reusable Luau code/module/example

## Important

DataStores only work correctly in a published experience. In Roblox Studio, enable **Game Settings > Security > Enable Studio Access to API Services** before testing DataStore code.

The examples are intentionally separated by concept so they are easy to learn from and reuse.