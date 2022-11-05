----------------------------------
------------ Functions -----------
----------------------------------


----------------------------------
-------------- Util --------------
----------------------------------
function SLS.getPlayerLevel(ply)
    return tonumber(sql.Query("SELECT level FROM " .. sbox_ls.db .. " WHERE player = " .. ply:SteamID64() .. ";")[1].level)
end

function SLS.getPlayerXP(ply)
    local xp = tonumber(sql.Query("SELECT xp FROM " .. sbox_ls.db .. " WHERE player = " .. ply:SteamID64() .. ";")[1].xp)
    local levels = sbox_ls["levels"][SLS.getPlayerLevel(ply)]

    if levels == nil then SLS.setPlayerLevel(ply, #sbox_ls["levels"]) levels = #sbox_ls["levels"] end

    if xp > levels then
        return levels-100
    elseif xp < 0 then
        return 1
    else
        return xp
    end
end

function SLS.setPlayerLevel(ply, level)
    SLS.setData(ply, "level", level)
end

function SLS.setPlayerXP(ply, xp)
    SLS.setData(ply, "xp", xp)
end

function SLS.getLevelXP(level)
    if ( #sbox_ls["levels"] > level ) then
        return tonumber(sbox_ls["levels"][level])
    else
        return tonumber(sbox_ls["levels"][#sbox_ls["levels"]])
    end
end

function SLS.getData(ply, datatype)
    return tonumber(sql.Query("SELECT " .. datatype .. " FROM " .. sbox_ls.db .. " WHERE player = " .. ply:SteamID64() .. ";")[1][datatype])
end

function SLS.setData(ply, datatype, value)
    sql.Query("UPDATE " .. sbox_ls.db .. " SET " .. sql.SQLStr(datatype) .. " = " .. sql.SQLStr(value) .. " WHERE player = " .. ply:SteamID64() .. ";")
end

function SLS.addXPToPlayer(ply, xp)
    local level = SLS.getPlayerLevel(ply)
    local xp = SLS.getPlayerXP(ply) + xp
    local xp_total = SLS.getLevelXP(level)

    if xp > xp_total then
        SLS.setPlayerXP(ply, xp-xp_total)
        hook.Run("onPlayerGetXP", ply, xp-xp_total)

        if #sbox_ls["levels"] > level then
            SLS.setData(ply, "level", level+1)
            hook.Run("onPlayerLevelUp", ply, level+1)
        else
            SLS.setData(ply, "level", level)
            SLS.setData(ply, "xp", 0)
            hook.Run("onPlayerLevelUp",  ply, level)
        end

    else
        hook.Run("onPlayerGetXP", ply, xp)
        SLS.setPlayerXP(ply, xp)
    end
end

function SLS.simpleAddXp(ply, val)
    SLS.checkPlayerDatabase(ply)
    SLS.addXPToPlayer(ply, SLS.getVar(val))
    SLS.updatePlayerName(ply)
    
    ply:SetNWInt("sbox_ls_level", SLS.getPlayerLevel(ply))
    ply:SetNWInt("sbox_ls_xp", SLS.getPlayerXP(ply))
end

----------------------------------
----------- Validators -----------
----------------------------------
function SLS.updatePlayerName(ply)
    SLS.setData(ply, "plyname", ply:Nick())
end

function SLS.checkPlayerDatabase(ply)
    local data = sql.Query("SELECT * FROM " .. sbox_ls.db .. " WHERE player = " .. ply:SteamID64() .. ";")
    if not data then
        sql.Query("INSERT INTO " .. sbox_ls.db .. " (player, plyname) VALUES (" .. ply:SteamID64() .. ", " .. sql.SQLStr(ply:Name()) .. ");")
    end
end

function SLS.levelExists(level)
    if not level then return false end
    if not isnumber(level) then return false end

    if #sbox_ls["levels"] > level and level >= 1 then
        return true
    else
        return false
    end
end

function SLS.XPValues(xp_type)
    return sbox_ls.xp[xp_type]
end

function SLS.getVar(xp_type)
    return GetConVar("sbox_ls_" .. xp_type):GetInt() or 0
end

function SLS.typeVar(var)
    return tobool(var) ~= nil and tobool(var) or tonumber(var) ~= nil and tonumber(var) or tostring(var)
end