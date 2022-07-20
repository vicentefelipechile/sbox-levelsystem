local function checkPlayerDatabase(ply)
	local data = sql.Query("SELECT * FROM sbox_levelsystem WHERE player = " .. ply:SteamID64() .. ";")
	if not data then
        sql.Query([[
            INSERT INTO sbox_levelsystem (player, plyname, level, xp) VALUES (]] .. ply:SteamID64() .. [[, ]] .. ply:Name() .. [[, 0, 0);
        ]])
    end
end

local function getPlayerLevel(ply)
    local data = sql.Query("SELECT level FROM sbox_levelsystem WHERE player = " .. ply:SteamID64() .. ";")
    return tonumber(data[1]["level"])
end

local function getLevelExp(level)
    local xp = sbox_ls["levels"][level]
    return xp
end

----------------------------------
------------- Values -------------
----------------------------------



----------------------------------
----------- Connection -----------
----------------------------------
hook.Add("PlayerInitialSpawn", "SboxLS_connection", function(ply)
	checkPlayerDatabase(ply)
    xp = tonumber(sql.Query("SELECT xp FROM sbox_levelsystem WHERE player = " .. ply:SteamID64() .. ";")[1]["xp"])
    xp_total = getLevelExp(getPlayerLevel(ply))

    sql.Query("UPDATE sbox_levelsystem SET xp = " .. xp[1]["xp"] + 15 .. " WHERE player = " .. ply:SteamID64() .. ";")
    if xp > xp_total then
        sql.Query("UPDATE sbox_levelsystem SET level = " .. sql.SQLStr(getPlayerLevel(ply) + 1) .. ", xp = 0 WHERE player = " .. ply:SteamID64() .. ";")
        xp = 0
    end

    ply:SetNWInt("sbox_levelsystem_xp", xp)


	sql.Query("UPDATE sbox_levelsystem SET plyname = " .. sql.SQLStr(ply:Name()) .. " WHERE player = " .. ply:SteamID64() .. ";")
	return
end)


----------------------------------
-------------- Kills -------------
----------------------------------
hook.Add("PlayerDeath", "StatsDeath", function(victim, inflictor, attacker)
	checkPlayerDatabase(victim)

    sql.Query("UPDATE sbox_levelsystem SET xp = " .. xp[1]["xp"] + 15 .. " WHERE player = " .. victim:SteamID64() .. ";")
	

	if inflictor:IsPlayer() and (victim ~= attacker) then
	end
	return
end)