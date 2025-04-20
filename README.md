# Checks armour and applies correct task (Updated to Agents of Sabotage DLC)

The purpose of this script is to add a visual component when the player has armour. Works with vanilla components, addon components can be added.

Client side script.

For addon clothing, select the used release within tasklist.lua and input the most suitable task model for each new jbib.
Available models:
-male: 1 to 11 ( 0 for no visible model).
-female: 1 to 13 , and 32 ( 0 for no visible model).
You can test it setting the value as -1 and checking possible combinations within a clothing store script (fe. illenium-appearance).

If you have addon tasks that you want them to be permanent, add them to the exceptionlist.lua within the used build and ped model

If you want a specific addon task for a specific addon jbib, add the drawableid of the task within tasklist.lua.

If you want to change the texture of the task model (5 possible textures), input the conditions within the specified space in main.lua


## Install
1. Download the [latest version]
2. Extract `taskchecker.zip` and copy the `taskchecker` into your `resources` folder.
3. Add `start taskchecker` to your your `server.cfg` file.

## Changelog

---
20/04/2025 - 1.0.0
- Initial release

