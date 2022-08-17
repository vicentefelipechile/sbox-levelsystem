----------------------------------
----------- Connection -----------
----------------------------------
hook.Add("PlayerInitialSpawn", "SboxLS_connection", function(ply)
	SLS.checkPlayerDatabase(ply)
    SLS.addXPToPlayer(ply, SLS.getVar("connections"))
    SLS.updatePlayerName(ply)

    ply:SetNWInt("sbox_ls_level", SLS.getPlayerLevel(ply))
    ply:SetNWInt("sbox_ls_xp", SLS.getPlayerXP(ply))

	return
end)
----------------------------------
-------------- Kills -------------
----------------------------------
hook.Add("PlayerDeath", "SboxLS_Death", function(victim, inflictor, attacker)
    SLS.checkPlayerDatabase(victim)
    SLS.addXPToPlayer(victim, SLS.getVar("deaths"))
    SLS.updatePlayerName(victim)

    victim:SetNWInt("sbox_ls_level", SLS.getPlayerLevel(victim))
    victim:SetNWInt("sbox_ls_xp", SLS.getPlayerXP(victim))

	if inflictor:IsPlayer() and (victim ~= attacker) then
        SLS.checkPlayerDatabase(attacker)
        SLS.addXPToPlayer(attacker, SLS.getVar("kills"))
        SLS.updatePlayerName(attacker)

        attacker:SetNWInt("sbox_ls_level", SLS.getPlayerLevel(attacker))
        attacker:SetNWInt("sbox_ls_xp", SLS.getPlayerXP(attacker))
	end

	return
end)

----------------------------------
-------------- Chats -------------
----------------------------------
hook.Add("PlayerSay", "SboxLS_Chat", function(ply)
    SLS.checkPlayerDatabase(ply)
    SLS.addXPToPlayer(ply, SLS.getVar("chats"))
    SLS.updatePlayerName(ply)

    ply:SetNWInt("sbox_ls_level", SLS.getPlayerLevel(ply))
    ply:SetNWInt("sbox_ls_xp", SLS.getPlayerXP(ply))

    return
end)

----------------------------------
------------- Physgun ------------
----------------------------------
hook.Add("PhysgunPickup", "SboxLS_Physgun", function(ply, ent)
    if not ent:IsPlayer() then
        SLS.checkPlayerDatabase(ply)
        SLS.addXPToPlayer(ply, SLS.getVar("physgun"))
        SLS.updatePlayerName(ply)

        ply:SetNWInt("sbox_ls_level", SLS.getPlayerLevel(ply))
        ply:SetNWInt("sbox_ls_xp", SLS.getPlayerXP(ply))
    end

    return
end)

----------------------------------
------------- Noclip -------------
----------------------------------
hook.Add("PlayerNoClip", "SboxLS_Noclip", function(ply)
    SLS.checkPlayerDatabase(ply)
    SLS.addXPToPlayer(ply, SLS.getVar("noclip"))
    SLS.updatePlayerName(ply)

    ply:SetNWInt("sbox_ls_level", SLS.getPlayerLevel(ply))
    ply:SetNWInt("sbox_ls_xp", SLS.getPlayerXP(ply))

    return
end)

----------------------------------
--------- NPC Killed ---------
----------------------------------
hook.Add("OnNPCKilled", "SboxLS_NPCKilled", function(npc, attacker, inflictor)
    if inflictor:IsPlayer() and ( npc:IsNPC() or npc:IsNextBot() ) then
        SLS.checkPlayerDatabase(attacker)
        SLS.addXPToPlayer(attacker, SLS.getVar("npc_killed"))
        SLS.updatePlayerName(attacker)

        attacker:SetNWInt("sbox_ls_level", SLS.getPlayerLevel(attacker))
        attacker:SetNWInt("sbox_ls_xp", SLS.getPlayerXP(attacker))
    end

    return
end)