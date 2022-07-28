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

    local data = tonumber(sql.Query("SELECT level FROM " .. sbox_ls.db .. " WHERE player = " .. ply:SteamID64() .. ";")[1].level)
    if #sbox_ls["levels"] > data then
        return tonumber(data)
    else
        return tonumber(#sbox_ls["levels"])
    end
end

function SLS_getLevelXP(level)
    local xp = sbox_ls["levels"][tonumber(level)]
    return tonumber(xp)
end

function SLS_getPlayerXP(ply)
    return tonumber(sql.Query("SELECT xp FROM " .. sbox_ls.db .. " WHERE player = " .. ply:SteamID64() .. ";")[1].xp)
end

function SLS_setPlayerLevel(ply, level)
    sql.Query("UPDATE " .. sbox_ls.db .. " SET level = " .. sql.SQLStr(level) .. " WHERE player = " .. ply:SteamID64() .. ";")
end

function SLS_setPlayerXP(ply, xp)
    sql.Query("UPDATE " .. sbox_ls.db .. " SET xp = " .. sql.SQLStr(xp) .. " WHERE player = " .. ply:SteamID64() .. ";")
end

function SLS_addXPToPlayer(ply, xp)
    local level = ply:GetPlayerLevel()
    local xp = ply:GetPlayerXP() + xp
    local xp_total = ply:GetPlayerXPToNextLevel()

    if level == #sbox_ls["levels"] then
        SLS_setData(ply, "level", #sbox_ls["levels"])
        SLS_setData(ply, "xp", xp-xp_total)
        level = #sbox_ls["levels"]
    end

    if xp > xp_total then
        ply:SetPlayerLevel(level+1)
        ply:SetPlayerXP(xp-xp_total)
        hook.Call("SLS_LevelUp", nil, ply, SLS_getPlayerLevel(ply))
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