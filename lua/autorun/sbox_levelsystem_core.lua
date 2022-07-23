sbox_ls = {}
sbox_ls.language = {}
sbox_ls.db = "sbox_levelsystem"

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
end

CreateClientConVar("sbox_ls_notify", "1", true, true, "Should the player be notified when they level up?")
CreateClientConVar("sbox_ls_notify_sound", "1", true, true, "Should the player be notified with a sound when they level up?")
CreateClientConVar("sbox_ls_notify_chat", "0", true, true, "Should the player be notified with a chat message when they level up?")


if SERVER and not sql.TableExists(sbox_ls.db) then
    sql.Query([[CREATE TABLE IF NOT EXISTS ]] .. sbox_ls.db .. [[(
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
        print("[SBOX-LS] SERVER INCLUDE: " .. file)
    elseif (prefix == "sh_") then
        if SERVER then
            AddCSLuaFile(dir .. file)
            print("[SBOX-LS] SHARED ADDCS: " .. file)
        end
        include(dir .. file)
        print("[SBOX-LS] SHARED INCLUDE: " .. file)
    elseif (prefix == "cl_") then
        if SERVER then
            AddCSLuaFile(dir .. file)
            print("[SBOX-LS] CLIENT ADDCS: " .. file)
        elseif CLIENT then
            include(dir .. file)
            print("[SBOX-LS] CLIENT INCLUDE: " .. file)
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