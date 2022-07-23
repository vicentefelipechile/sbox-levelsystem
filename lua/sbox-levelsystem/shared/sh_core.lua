----------------------------------
------------ Functions -----------
----------------------------------
function SLS_getLevelPlayer(ply)
    local data = sql.Query("SELECT level FROM " .. sbox_ls.db .. " WHERE player = " .. ply:SteamID64() .. ";")
    if #sbox_ls["levels"] > tonumber(data[1].level) then
        return tonumber(data[1].level)
    else
        return tonumber(#sbox_ls["levels"])
    end
end

function SLS_getLevelExp(level)
    local xp = sbox_ls["levels"][level]
    return tonumber(xp)
end

function SLS_checkPlayerDatabase(ply)
    local data = sql.Query("SELECT * FROM " .. sbox_ls.db .. " WHERE player = " .. ply:SteamID64() .. ";")
    if not data then
        sql.Query("INSERT INTO " .. sbox_ls.db .. " (player, plyname) VALUES (" .. ply:SteamID64() .. ", " .. sql.SQLStr(ply:Name()) .. ");")
    end
end

function SLS_levelUpPlayer(ply, xp_type)
    local xp = tonumber(sql.Query("SELECT xp FROM " .. sbox_ls.db .. " WHERE player = " .. ply:SteamID64() .. ";")[1]["xp"]) + xp_type
    local xp_total = SLS_getLevelExp(SLS_getLevelPlayer(ply))

    if xp > xp_total then
        sql.Query("UPDATE " .. sbox_ls.db .. " SET level = " .. sql.SQLStr(SLS_getLevelPlayer(ply) + 1) .. ", xp = 0 WHERE player = " .. ply:SteamID64() .. ";")
        sql.Query("UPDATE " .. sbox_ls.db .. " SET xp = " .. sql.SQLStr(xp-xp_total) .. " WHERE player = " .. ply:SteamID64() .. ";")
    else
        sql.Query("UPDATE " .. sbox_ls.db .. " SET xp = " .. xp .. " WHERE player = " .. ply:SteamID64() .. ";")
    end
end

function SLS_updatePlayerName(ply)
    sql.Query("UPDATE " .. sbox_ls.db .. " SET plyname = " .. sql.SQLStr(ply:Name()) .. " WHERE player = " .. ply:SteamID64() .. ";")
end