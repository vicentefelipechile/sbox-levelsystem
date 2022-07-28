----------------------------------
------------ Functions -----------
----------------------------------
function SLS_getData(ply, datatype)
    return tonumber(sql.Query("SELECT " .. sql.SQLStr(datatype) .. " FROM " .. sbox_ls.db .. " WHERE steamid = " .. ply:SteamID() .. ";")[1][datatype])
end

function SLS_setData(ply, datatype, value)
    sql.Query("UPDATE " .. sbox_ls.db .. " SET " .. sql.SQLStr(datatype) .. " = " .. sql.SQLStr(value) .. " WHERE steamid = " .. ply:SteamID() .. ";")
end

function SLS_getPlayerLevel(ply)
    if ( not ply:IsPlayer() ) then return 1 end

    local data = SLS_getData(ply, "level")
    if #sbox_ls["levels"] > data then
        return tonumber(data)
    else
        return tonumber(#sbox_ls["levels"])
    end
end

function SLS_getPlayerXP(ply)
    local data = SLS_getData(ply, "xp")
    return tonumber(data)
end

function SLS_getLevelExp(level)
    local xp = sbox_ls["levels"][tonumber(level)]
    return tonumber(xp)
end

function SLS_addXPToPlayer(ply, xp)
    local xp = SLS_getData(ply, "xp") + xp
    local level = SLS_getLevelPlayer(ply)
    local xp_total = SLS_getLevelExp(level)

    if level == #sbox_ls["levels"] then
        SLS_setData(ply, "level", #sbox_ls["levels"])
        SLS_setData(ply, "xp", xp-xp_total)
        level = #sbox_ls["levels"]
    end

    if xp > xp_total then
        sql.Query("UPDATE " .. sbox_ls.db .. " SET level = " .. sql.SQLStr(SLS_getLevelPlayer(ply) + 1) .. " player = " .. ply:SteamID64() .. ";")
        sql.Query("UPDATE " .. sbox_ls.db .. " SET xp = " .. sql.SQLStr(xp-xp_total) .. " WHERE player = " .. ply:SteamID64() .. ";")
    else
        sql.Query("UPDATE " .. sbox_ls.db .. " SET xp = " .. xp .. " WHERE player = " .. ply:SteamID64() .. ";")
    end
end

function SLS_updatePlayerName(ply)
    sql.Query("UPDATE " .. sbox_ls.db .. " SET plyname = " .. sql.SQLStr(ply:Name()) .. " WHERE player = " .. ply:SteamID64() .. ";")
end

function SLS_checkPlayerDatabase(ply)
    local data = sql.Query("SELECT * FROM " .. sbox_ls.db .. " WHERE player = " .. ply:SteamID64() .. ";")
    if not data then
        sql.Query("INSERT INTO " .. sbox_ls.db .. " (player, plyname) VALUES (" .. ply:SteamID64() .. ", " .. sql.SQLStr(ply:Name()) .. ");")
    end
end