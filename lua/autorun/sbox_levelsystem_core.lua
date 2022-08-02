sbox_ls = {}
sbox_ls.language = {}
sbox_ls.db = "sbox_levelsystem"
sbox_ls.display_level = true
sbox_ls.prefix = "[SBOX-LS] "

-- resource.AddWorkshop("2829026660")

----------------------------------
------------- Convars ------------
----------------------------------
if SERVER then
CreateConVar("sbox_ls_connections", "15", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player connects.")
CreateConVar("sbox_ls_kills", "15", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player kills someone.")
CreateConVar("sbox_ls_deaths", "3", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player dies.")
CreateConVar("sbox_ls_chats", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player talks.")
CreateConVar("sbox_ls_physgun", "2", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player uses the physgun.")
CreateConVar("sbox_ls_noclip", "2", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player uses noclip.")
CreateConVar("sbox_ls_npc_killed", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player kills an NPC.")
end

if CLIENT then
CreateClientConVar("sbox_ls_notify", "1", true, true, "Should the player be notified when they level up?")
CreateClientConVar("sbox_ls_notify_sound", "1", true, true, "Should the player be notified with a sound when they level up?")
CreateClientConVar("sbox_ls_notify_chat", "0", true, true, "Should the player be notified with a chat message when they level up?")
end

if SERVER and not sql.TableExists(sbox_ls.db) then
    sql.Query([[CREATE TABLE IF NOT EXISTS ]] .. sbox_ls.db .. [[ (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        player INTEGER NOT NULL,
        plyname VARCHAR(255) NOT NULL,
        level INTEGER NOT NULL DEFAULT 1,
        xp INTEGER NOT NULL DEFAULT 0
    )]])
end

----------------------------------
------------ Functions -----------
----------------------------------

local function AddFile(file, dir)
    local prefix = string.lower(string.Left(file, 3))
    if SERVER and (prefix == "sv_") then
        include(dir .. file)
        print("[SBOX-LS] SERVER INCLUDE: " .. dir .. file)
    elseif (prefix == "sh_") then
        if SERVER then
            AddCSLuaFile(dir .. file)
            print("[SBOX-LS] SHARED ADDCS: " .. dir .. file)
        end
        include(dir .. file)
        print("[SBOX-LS] SHARED INCLUDE: " .. dir .. file)
    elseif (prefix == "cl_") then
        if SERVER then
            AddCSLuaFile(dir .. file)
            print("[SBOX-LS] CLIENT ADDCS: " .. dir .. file)
        elseif CLIENT then
            include(dir .. file)
            print("[SBOX-LS] CLIENT INCLUDE: " .. dir .. file)
        end
    end
end

local function AddDir(dir)
    dir = dir .. "/"

    local files, directories = file.Find(dir .. "*", "LUA")
    for _, v in ipairs(files) do
        if string.EndsWith(v, ".lua") then
            AddFile(v, dir)
        end
    end

    for _, v in ipairs(directories) do AddDir(dir .. v) end
end
AddDir("sbox-levelsystem")


----------------------------------
----------- Extensions -----------
----------------------------------

-- GDR
-- https://github.com/44lr/gdr_addon
sbox_ls.gdr_enable = false -- Enable/disable the GDR addon.
sbox_ls.gdr_picture = "https://i.imgur.com/EKHWx6Y.png"
sbox_ls.gdr_name = "Sandbox Level System"
sbox_ls.gdr_message = " has reached level "

-- Gmod Stats
-- https://steamcommunity.com/sharedfiles/filedetails/?id=2829026660
sbox_ls.gmodstats_enable = true -- Enable/Disable the gmodstats integration.
sbox_ls.gmodstats_db = "stats_mp"

-- Math Problems
-- https://steamcommunity.com/sharedfiles/filedetails/?id=2805623775
sbox_ls.maths_enable = true -- Enable/Disable the maths integration.
sbox_ls.math_db = "math_points"