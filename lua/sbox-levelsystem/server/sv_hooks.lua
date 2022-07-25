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
	level.checkPlayerDatabase(ply)
    level.addXPToPlayer(ply, xp_connections)
    level.updatePlayerName(ply)

    ply:SetNWInt("sbox_ls_level", level.getLevelPlayer(ply))
    ply:SetNWInt("sbox_ls_xp", level.getXPPlayer(ply))

	return
end)


----------------------------------
-------------- Kills -------------
----------------------------------
hook.Add("PlayerDeath", "SboxLS_Death", function(victim, inflictor, attacker)
    level.checkPlayerDatabase(victim)
    level.addXPToPlayer(victim, xp_deaths)
    level.updatePlayerName(victim)

    victim:SetNWInt("sbox_ls_level", level.getLevelPlayer(victim))
    victim:SetNWInt("sbox_ls_xp", level.getXPPlayer(victim))

	if inflictor:IsPlayer() and (victim ~= attacker) then
        level.checkPlayerDatabase(attacker)
        level.addXPToPlayer(attacker, xp_kills)
        level.updatePlayerName(attacker)

        attacker:SetNWInt("sbox_ls_level", level.getLevelPlayer(attacker))
        attacker:SetNWInt("sbox_ls_xp", level.getXPPlayer(attacker))
	end

	return
end)

----------------------------------
-------------- Chats -------------
----------------------------------
hook.Add("PlayerSay", "SboxLS_Chat", function(ply)
    level.checkPlayerDatabase(ply)
    level.addXPToPlayer(ply, xp_chats)
    level.updatePlayerName(ply)

    ply:SetNWInt("sbox_ls_level", level.getLevelPlayer(ply))
    ply:SetNWInt("sbox_ls_xp", level.getXPPlayer(ply))

    return
end)

----------------------------------
------------- Physgun ------------
----------------------------------
hook.Add("PhysgunPickup", "SboxLS_Physgun", function(ply)
    level.checkPlayerDatabase(ply)
    level.addXPToPlayer(ply, xp_physgun)
    level.updatePlayerName(ply)

    ply:SetNWInt("sbox_ls_level", level.getLevelPlayer(ply))
    ply:SetNWInt("sbox_ls_xp", level.getXPPlayer(ply))

    return
end)

----------------------------------
------------- Noclip -------------
----------------------------------
hook.Add("PlayerNoClip", "SboxLS_Noclip", function(ply)
    level.checkPlayerDatabase(ply)
    level.addXPToPlayer(ply, xp_noclip)
    level.updatePlayerName(ply)

    ply:SetNWInt("sbox_ls_level", level.getLevelPlayer(ply))
    ply:SetNWInt("sbox_ls_xp", level.getXPPlayer(ply))

    return
end)

----------------------------------
--------- Player LevelUp ---------
----------------------------------
--[[
hook.Add("onPlayerLevelUp", "SboxLS_LevelUp", function(ply)
    print(ply .. " has leveled up to level " .. level.getLevelPlayer(ply))
    return
end)
--]]