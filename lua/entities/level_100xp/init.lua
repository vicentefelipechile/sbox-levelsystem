AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
end

function ENT:Use(ply, caller)
    if ply:IsPlayer() then
        ply:SetPlayerLevel(tonumber(ply:GetPlayerLevel()) + 1)
        self:Remove()
        
        hook.Call("onPlayerLevelUp", nil, ply, SLS.getPlayerLevel(ply))
        print("[SBOX-LS] Level UP to " .. ply:Nick())
    end
end