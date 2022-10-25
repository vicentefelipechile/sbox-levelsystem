# Sandbox Level System
a simple system that adds levels to the sandbox (may be compatible with other game modes)

### Cvars Server-side
| CVAR                  | Value | Description   | 
| -------------         | :---: | ------------- |
| sbox_ls_connections   | 15    | The amount of xp to get when a player connects.           |
| sbox_ls_kills         | 15    | The amount of xp to get when a player kills someone.      |
| sbox_ls_deaths        | 3     | The amount of xp to get when a player dies.               |
| sbox_ls_chats         | 1     | The amount of xp to get when a player talks.              |
| sbox_ls_physgun       | 2     | The amount of xp to get when a player uses the physgun.   |
| sbox_ls_noclip        | 2     | The amount of xp to get when a player uses noclip.        |
| sbox_ls_npc_killed    | 5     | The amount of xp to get when a player kills an NPC.       |
| sbox_ls_spawned_vehicle| 2    | The amount of xp to get when a player spawns a vehicle.   |
| sbox_ls_spawned_npc   | 2     | The amount of xp to get when a player spawns a NPC.       |
| sbox_ls_spawned_prop  | 1     | The amount of xp to get when a player spawns a prop.      |
| sbox_ls_spawned_sent  | 2     | The amount of xp to get when a player spawns a SENT.      |
| sbox_ls_spawned_ragdoll| 2    | The amount of xp to get when a player spawns a ragdoll.   |

### Cvars Client-side
| CVAR                  | Value | Description   | 
| -------------         | :---: | ------------- |
| sbox_ls_notify        | 1     | Should the player be notified when they level up? |
| sbox_ls_notify_sound  | 1     | Should the player be notified with a sound when they level up? |
| sbox_ls_notify_chat   | 0     | Should the player be notified with a chat message when they level up? |

# Global Functions
you can find all functions in [this file](https://github.com/SuperCALIENTITO/sbox-levelsystem/blob/main/lua/sbox-levelsystem/shared/sh_core.lua)

```lua
SLS.getPlayerLevel(ply)

-- returns the current level of the player,
-- if the level exceeds the number of existing levels,
-- the last level will be returned as value
```

```lua
SLS.getPlayerXP(ply)

-- returns the player's current experience
```

```lua
SLS.getLevelXP(level)

-- returns the amount of experience for the level
```

```lua
SLS.checkPlayerDatabase(ply)

-- check if the player exists in the database,
-- if it doesn't exist, it adds it.
-- doesn't return any value
```

```lua
SLS.addXPToPlayer(ply, xp)

-- add the player an amount of XP with the xp arg
```

```lua
SLS.updatePlayerName(ply)

-- update the name of the player in the database
```

# Global Meta Statements
you can find all statements in [this file](https://github.com/SuperCALIENTITO/sbox-levelsystem/blob/main/lua/sbox-levelsystem/shared/sh_meta.lua)

```lua
ply:GetPlayerLevel()

-- returns the player level
```

```lua
ply:GetPlayerXP()

-- returns the current xp of player
```

```lua
ply:GetPlayerXPToNextLevel()

-- returns the amount needed to level up
```

```lua
ply:IsPlayerLevelEqualTo(level)

-- (boolean)
-- returns if the player is in the same level
```

```lua
ply:IsPlayerLevelMoreThan(level)

-- (boolean)
-- returns if the player is equal or greater than the level
```

```lua
ply:IsPlayerLevelLessThan(level)

-- (boolean)
-- returns if the player is less than the level
```


# Mapping Latam

- [Github](https://github.com/mapping-latam)
- [Discord](https://github.com/mapping-latam)
