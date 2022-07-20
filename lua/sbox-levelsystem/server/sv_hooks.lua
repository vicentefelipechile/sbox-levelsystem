local function checkPlayerDatabase(ply)
	local data = sql.Query("SELECT * FROM sbox_levelsystem WHERE player = " .. ply:SteamID64() .. ";")
	if not data then
        sql.Query("INSERT INTO sbox_levelsystem (player, plyname) VALUES (" .. ply:SteamID64() .. ", " .. ply:Name() .. ");")
    end
end

----------------------------------
------------- Values -------------
----------------------------------
local xp_deaths = GetConVar("sbox_ls_deaths"):GetInt()
local xp_kills = GetConVar("sbox_ls_kills"):GetInt()
local xp_chats = GetConVar("sbox_ls_chats"):GetInt()
local xp_physgun = GetConVar("sbox_ls_physgun"):GetInt()
local xp_connections = GetConVar("sbox_ls_connections"):GetInt()
local xp_noclip = GetConVar("sbox_ls_noclip"):GetInt()

----------------------------------
----------- Connection -----------
----------------------------------
hook.Add("PlayerInitialSpawn", "SboxLS_connection", function(ply)
	checkPlayerDatabase(ply)
    local xp = tonumber(sql.QueryValue("SELECT xp FROM sbox_levelsystem WHERE player = " .. ply:SteamID64() .. ";")[1]["xp"]) + xp_connections
    local xp_total = SLS_getLevelExp(SLS_getLevelPlayer(ply))

    if xp > xp_total then
        sql.Query("UPDATE sbox_levelsystem SET level = " .. sql.SQLStr(SLS_getLevelPlayer(ply) + 1) .. ", xp = 0 WHERE player = " .. ply:SteamID64() .. ";")
        xp = 0
    end
    sql.Query("UPDATE sbox_levelsystem SET xp = " .. xp .. " WHERE player = " .. ply:SteamID64() .. ";")

    ply:SetNWInt("sbox_ls_level", SLS_getLevelPlayer(ply))
    ply:SetNWInt("sbox_levelsystem_xp", xp)

	sql.Query("UPDATE sbox_levelsystem SET plyname = " .. sql.SQLStr(ply:Name()) .. " WHERE player = " .. ply:SteamID64() .. ";")

	return
end)


----------------------------------
-------------- Kills -------------
----------------------------------
hook.Add("PlayerDeath", "SboxLS_Death", function(victim, inflictor, attacker)
	checkPlayerDatabase(victim)
    local Vxp = tonumber(sql.QueryValue("SELECT xp FROM sbox_levelsystem WHERE player = " .. victim:SteamID64() .. ";")[1]["xp"]) + xp_deaths
    local Vxp_total = SLS_getLevelExp(SLS_getLevelPlayer(victim))

    if Vxp > Vxp_total then
        sql.Query("UPDATE sbox_levelsystem SET level = " .. sql.SQLStr(SLS_getLevelPlayer(victim) + 1) .. ", xp = 0 WHERE player = " .. victim:SteamID64() .. ";")
        xp = 0
    end
    sql.Query("UPDATE sbox_levelsystem SET xp = " .. xp .. " WHERE player = " .. victim:SteamID64() .. ";")

    victim:SetNWInt("sbox_ls_level", SLS_getLevelPlayer(ply))
    victim:SetNWInt("sbox_levelsystem_xp", xp)

	if inflictor:IsPlayer() and (victim ~= attacker) then
        local Axp = tonumber(sql.QueryValue("SELECT xp FROM sbox_levelsystem WHERE player = " .. attacker:SteamID64() .. ";")[1]["xp"]) + xp_kills
        local Axp_total = SLS_getLevelExp(SLS_getLevelPlayer(attacker))
        
        if Axp > Axp_total then
            sql.Query("UPDATE sbox_levelsystem SET level = " .. sql.SQLStr(SLS_getLevelPlayer(attacker) + 1) .. ", xp = 0 WHERE player = " .. attacker:SteamID64() .. ";")
            xp = 0
        end
        sql.Query("UPDATE sbox_levelsystem SET xp = " .. xp .. " WHERE player = " .. attacker:SteamID64() .. ";")

        attacker:SetNWInt("sbox_ls_level", SLS_getLevelPlayer(ply))
        attacker:SetNWInt("sbox_levelsystem_xp", xp)
	end

	return
end)

----------------------------------
-------------- Chats -------------
----------------------------------
hook.Add("PlayerSay", "SboxLS_Chat", function(plyname)
    checkPlayerDatabase(ply)
    local xp = tonumber(sql.QueryValue("SELECT xp FROM sbox_levelsystem WHERE player = " .. ply:SteamID64() .. ";")[1]["xp"]) + xp_chats
    local xp_total = SLS_getLevelExp(SLS_getLevelPlayer(ply))

    if xp > xp_total then
        sql.Query("UPDATE sbox_levelsystem SET level = " .. sql.SQLStr(SLS_getLevelPlayer(ply) + 1) .. ", xp = 0 WHERE player = " .. ply:SteamID64() .. ";")
        xp = 0
    end
    sql.Query("UPDATE sbox_levelsystem SET xp = " .. xp .. " WHERE player = " .. ply:SteamID64() .. ";")

    ply:SetNWInt("sbox_ls_level", SLS_getLevelPlayer(ply))
    ply:SetNWInt("sbox_levelsystem_xp", xp)
    return
end)

----------------------------------
------------- Physgun ------------
----------------------------------
hook.Add("PhysgunPickup", "SboxLS_Physgun", function(ply)
    checkPlayerDatabase(ply)
    local xp = tonumber(sql.QueryValue("SELECT xp FROM sbox_levelsystem WHERE player = " .. ply:SteamID64() .. ";")[1]["xp"]) + xp_physgun
    local xp_total = SLS_getLevelExp(SLS_getLevelPlayer(ply))

    if xp > xp_total then
        sql.Query("UPDATE sbox_levelsystem SET level = " .. sql.SQLStr(SLS_getLevelPlayer(ply) + 1) .. ", xp = 0 WHERE player = " .. ply:SteamID64() .. ";")
        xp = 0
    end
    sql.Query("UPDATE sbox_levelsystem SET xp = " .. xp .. " WHERE player = " .. ply:SteamID64() .. ";")

    ply:SetNWInt("sbox_ls_level", SLS_getLevelPlayer(ply))
    ply:SetNWInt("sbox_levelsystem_xp", xp)
    return
end)

----------------------------------
------------- Noclip -------------
----------------------------------
hook.Add("PlayerNoclip", "SboxLS_Noclip", function(ply)
    checkPlayerDatabase(ply)
    local xp = tonumber(sql.QueryValue("SELECT xp FROM sbox_levelsystem WHERE player = " .. ply:SteamID64() .. ";")[1]["xp"]) + xp_noclip
    local xp_total = SLS_getLevelExp(SLS_getLevelPlayer(ply))

    if xp > xp_total then
        sql.Query("UPDATE sbox_levelsystem SET level = " .. sql.SQLStr(SLS_getLevelPlayer(ply) + 1) .. ", xp = 0 WHERE player = " .. ply:SteamID64() .. ";")
        xp = 0
    end
    sql.Query("UPDATE sbox_levelsystem SET xp = " .. xp .. " WHERE player = " .. ply:SteamID64() .. ";")

    ply:SetNWInt("sbox_ls_level", SLS_getLevelPlayer(ply))
    ply:SetNWInt("sbox_levelsystem_xp", xp)
    return
end)