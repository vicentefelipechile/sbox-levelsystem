----------------------------------
------------- Values -------------
----------------------------------
local xp_deaths = GetConVar("sbox_ls_deaths"):GetInt()
local xp_kills = GetConVar("sbox_ls_kills"):GetInt()
local xp_chats = GetConVar("sbox_ls_chats"):GetInt()
local xp_physgun = GetConVar("sbox_ls_physgun"):GetInt()
local xp_connections = GetConVar("sbox_ls_connections"):GetInt()
local xp_noclip = GetConVar("sbox_ls_noclip"):GetInt()
local xp_npc_killed = GetConVar("sbox_ls_npc_killed"):GetInt()

----------------------------------
----------- Connection -----------
----------------------------------
hook.Add("PlayerInitialSpawn", "SboxLS_connection", function(ply)
	SLS_checkPlayerDatabase(ply)
    SLS_addXPToPlayer(ply, xp_connections)
    SLS_updatePlayerName(ply)

    ply:SetNWInt("sbox_ls_level", SLS_getPlayerLevel(ply))
    ply:SetNWInt("sbox_ls_xp", SLS_getPlayerXP(ply))

	return
end)


----------------------------------
-------------- Kills -------------
----------------------------------
hook.Add("PlayerDeath", "SboxLS_Death", function(victim, inflictor, attacker)
    SLS_checkPlayerDatabase(victim)
    SLS_addXPToPlayer(victim, xp_deaths)
    SLS_updatePlayerName(victim)

    victim:SetNWInt("sbox_ls_level", SLS_getPlayerLevel(victim))
    victim:SetNWInt("sbox_ls_xp", SLS_getPlayerXP(victim))

	if inflictor:IsPlayer() and (victim ~= attacker) then
        SLS_checkPlayerDatabase(attacker)
        SLS_addXPToPlayer(attacker, xp_kills)
        SLS_updatePlayerName(attacker)

        attacker:SetNWInt("sbox_ls_level", SLS_getPlayerLevel(attacker))
        attacker:SetNWInt("sbox_ls_xp", SLS_getPlayerXP(attacker))
	end

	return
end)

----------------------------------
-------------- Chats -------------
----------------------------------
hook.Add("PlayerSay", "SboxLS_Chat", function(ply)
    SLS_checkPlayerDatabase(ply)
    SLS_addXPToPlayer(ply, xp_chats)
    SLS_updatePlayerName(ply)

    ply:SetNWInt("sbox_ls_level", SLS_getPlayerLevel(ply))
    ply:SetNWInt("sbox_ls_xp", SLS_getPlayerXP(ply))

    return
end)

----------------------------------
------------- Physgun ------------
----------------------------------
hook.Add("PhysgunPickup", "SboxLS_Physgun", function(ply, ent)
    if not ent:IsPlayer() then
        SLS_checkPlayerDatabase(ply)
        SLS_addXPToPlayer(ply, xp_physgun)
        SLS_updatePlayerName(ply)

        ply:SetNWInt("sbox_ls_level", SLS_getPlayerLevel(ply))
        ply:SetNWInt("sbox_ls_xp", SLS_getPlayerXP(ply))
    end

    return
end)

----------------------------------
------------- Noclip -------------
----------------------------------
hook.Add("PlayerNoClip", "SboxLS_Noclip", function(ply)
    SLS_checkPlayerDatabase(ply)
    SLS_addXPToPlayer(ply, xp_noclip)
    SLS_updatePlayerName(ply)

    ply:SetNWInt("sbox_ls_level", SLS_getPlayerLevel(ply))
    ply:SetNWInt("sbox_ls_xp", SLS_getPlayerXP(ply))

    return
end)

----------------------------------
--------- NPC Killed ---------
----------------------------------
hook.Add("OnNPCKilled", "SboxLS_NPCKilled", function(npc, attacker, inflictor)
    if inflictor:IsPlayer() and ( npc:IsNPC() or npc:IsNextBot() ) then
        SLS_checkPlayerDatabase(attacker)
        SLS_addXPToPlayer(attacker, xp_kills)
        SLS_updatePlayerName(attacker)

        attacker:SetNWInt("sbox_ls_level", SLS_getPlayerLevel(attacker))
        attacker:SetNWInt("sbox_ls_xp", SLS_getPlayerXP(attacker))
    end

    return
end)