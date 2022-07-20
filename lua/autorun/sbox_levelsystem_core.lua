sbox_ls = {}
sbox_ls.language = {}

-- Convars to set xp to get
CreateConVar("sbox_ls_connections", "15", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player connects.")
CreateConVar("sbox_ls_kills", "15", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player kills someone.")
CreateConVar("sbox_ls_deaths", "3", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player dies.")
CreateConVar("sbox_ls_chats", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player talks.")
CreateConvar("sbox_ls_physgun", "2", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player uses the physgun.")


if SERVER and not sql.TableExists("sbox_levelsystem") then
    sql.Query([[CREATE TABLE IF NOT EXISTS stats_mp (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        player INTEGER NOT NULL,
        plyname VARCHAR(255) NOT NULL,
        level INTEGER NOT NULL DEFAULT 1,
        xp INTEGER NOT NULL DEFAULT 0,
    )]])
end

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