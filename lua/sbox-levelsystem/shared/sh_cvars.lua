----------------------------------
------------- Convars ------------
----------------------------------

local function addCV(str, int, desc)
    CreateConVar(str, int, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, desc)
end

addCV("sbox_ls_connections",    15, "The amount of xp to get when a player connects.")
addCV("sbox_ls_kills",          15, "The amount of xp to get when a player kills someone.")
addCV("sbox_ls_deaths",          3, "The amount of xp to get when a player dies.")
addCV("sbox_ls_chats",           1, "The amount of xp to get when a player talks.")
addCV("sbox_ls_physgun",         2, "The amount of xp to get when a player uses the physgun.")
addCV("sbox_ls_noclip",          2, "The amount of xp to get when a player uses noclip.")
addCV("sbox_ls_npc_killed",      5, "The amount of xp to get when a player kills an NPC.")
addCV("sbox_ls_spawned_vehicle", 2, "The amount of xp to get when a player spawns a vehicle.")
addCV("sbox_ls_spawned_npc",     2, "The amount of xp to get when a player spawns a npc.")
addCV("sbox_ls_spawned_prop",    1, "The amount of xp to get when a player spawns a prop.")
addCV("sbox_ls_spawned_sent",    2, "The amount of xp to get when a player spawns a SENT.")
addCV("sbox_ls_spawned_ragdoll", 2, "The amount of xp to get when a player spawns a ragdoll.")

------------------------
---- Credits Module ----
------------------------
addCV("sbox_ls_module_credits",  0, "Enable the credits module.")
addCV("sbox_ls_module_credits_onlevelup", 4000, "Amount of credit to given to players.")

------------------------
----- Maths Module -----
------------------------
addCV("sbox_ls_module_maths",    0, "Enable the maths module.")
addCV("sbox_ls_module_maths_answered", 20, "Amount of xp to given to players.")

------------------------
------ Perk Module -----
------------------------
addCV("sbox_ls_module_perk",                  0, "Enable the perk module.")
addCV("sbox_ls_module_perk_health_min",      50, "The level minimum to get the health perk.")
addCV("sbox_ls_module_perk_armor_min",       50, "The level minimum to get the armor perk.")
addCV("sbox_ls_module_perk_jump_min",       100, "The level minimum to get the jump perk.")
addCV("sbox_ls_module_perk_speed_min",      100, "The level minimum to get the speed perk.")
addCV("sbox_ls_module_perk_delay",            1, "Delay to apply changes to the player")