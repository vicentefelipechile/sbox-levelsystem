----------------------------------
------------ Functions -----------
----------------------------------

local query = sql.Query
local qValue = sql.QueryValue

----------------------------------
-------------- Util --------------
----------------------------------
function SLS.getPlayerLevel(ply)
    return tonumber( qValue("SELECT level FROM " .. sbox_ls.db .. " WHERE player = " .. ply:SteamID64()) )
end

function SLS.getPlayerXP(ply)
    local player_xp = tonumber( qValue("SELECT xp FROM " .. sbox_ls.db .. " WHERE player = " .. ply:SteamID64()) )
    local levels_xp = sbox_ls.levels[ SLS.getPlayerLevel(ply) ]

    if levels_xp == nil then
        SLS.setPlayerLevel(ply, #sbox_ls.levels)
        levels_xp = #sbox_ls.levels
    end

    return
        player_xp > levels_xp and levels_xp - 100 or
        player_xp < 0 and 1 or
        player_xp

end

function SLS.setPlayerLevel(ply, level)
    SLS.setData(ply, "level", level)
end

function SLS.setPlayerXP(ply, xp)
    SLS.setData(ply, "xp", xp)
end

function SLS.getLevelXP(level)
    local level_exists = #sbox_ls.levels > level and sbox_ls.levels[level]

    return level_exists or sbox_ls.levels[#sbox_ls[level]]
end

function SLS.getData(ply, datatype)
    return tonumber( qValue("SELECT " .. datatype .. " FROM " .. sbox_ls.db .. " WHERE player = " .. ply:SteamID64()) )
end

function SLS.setData(ply, datatype, value)
    query("UPDATE " .. sbox_ls.db .. " SET " .. sql.SQLStr(datatype) .. " = " .. sql.SQLStr(value) .. " WHERE player = " .. ply:SteamID64())
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
            hook.Run("onPlayerLevelUp", ply, level)
        end

    else

        hook.Run("onPlayerGetXP", ply, xp)
        SLS.setPlayerXP(ply, xp)

    end
end

function SLS.simpleAddXp(ply, val)
    SLS.checkPlayerDatabase(ply)
    SLS.addXPToPlayer(ply, SLS.getVar(val))

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
    if not level or isnumber(level) then return nil end

    return #sbox_ls["levels"] > level and level >= 1
end

function SLS.XPValues(xp_type)
    return sbox_ls.xp[xp_type]
end

function SLS.getVar(xp_type)
    return GetConVar("sbox_ls_config"):GetBool() and sbox_ls.config["sbox_ls_" .. xp_type] or GetConVar("sbox_ls_" .. xp_type):GetInt() or 0
end

function SLS.configVar(var)
    if ( #sbox_ls.config ~= 0 ) and GetConVar("sbox_ls_config"):GetBool() then
        return sbox_ls.config[var] or 1
    end

    return GetConVar("sbox_ls_" .. var)
end