----------------------------------
----------- Connection -----------
----------------------------------
hook.Add("PlayerInitialSpawn", "SboxLS_connection", function(ply)
    SLS.simpleAddXp(ply, "connections")
end)
----------------------------------
-------------- Kills -------------
----------------------------------
hook.Add("PlayerDeath", "SboxLS_Death", function(victim, inflictor, attacker)
    SLS.simpleAddXp(victim, "deaths")

	if inflictor:IsPlayer() and (victim ~= attacker) then
        SLS.simpleAddXp(attacker, "kills")
	end
end)

----------------------------------
-------------- Chats -------------
----------------------------------
hook.Add("PlayerSay", "SboxLS_Chat", function(ply)
    SLS.simpleAddXp(ply, "chats")
end)

----------------------------------
------------- Physgun ------------
----------------------------------
hook.Add("PhysgunPickup", "SboxLS_Physgun", function(ply, ent)
    if not ent:IsPlayer() then
        SLS.simpleAddXp(ply, "physgun")
    end
end)

----------------------------------
------------- Noclip -------------
----------------------------------
hook.Add("PlayerNoClip", "SboxLS_Noclip", function(ply)
    SLS.simpleAddXp(ply, "noclip")
end)

----------------------------------
----------- NPC Killed -----------
----------------------------------
hook.Add("OnNPCKilled", "SboxLS_NPCKilled", function(npc, attacker, inflictor)
    if inflictor:IsPlayer() and ( npc:IsNPC() or npc:IsNextBot() ) then
        SLS.simpleAddXp(attacker, "npc_killed")
    end
end)

----------------------------------
--------- Vehicle Spawned --------
----------------------------------
hook.Add("PlayerSpawnedVehicle", "SboxLS_SpawnedVehicle", function(ply)
    SLS.simpleAddXp(ply, "spawned_vehicle")
end)

----------------------------------
----------- NPC Spawned ----------
----------------------------------
hook.Add("PlayerSpawnedNPC", "SboxLS_SpawnedNPC", function(ply)
    SLS.simpleAddXp(ply, "spawned_npc")
end)

----------------------------------
---------- Prop Spawned ----------
----------------------------------
hook.Add("PlayerSpawnedProp", "SboxLS_SpawnedProp", function(ply)
    SLS.simpleAddXp(ply, "spawned_vehicle")
end)

----------------------------------
---------- SENT Spawned ----------
----------------------------------
hook.Add("PlayerSpawnedSENT", "SboxLS_SpawnedSENT", function(ply)
    SLS.simpleAddXp(ply, "spawned_sent")
end)

----------------------------------
--------- Ragdoll Spawned --------
----------------------------------
hook.Add("PlayerSpawnedRagdoll", "SboxLS_SpawnedRagdoll", function(ply)
    SLS.simpleAddXp(ply, "spawned_ragdoll")
end)