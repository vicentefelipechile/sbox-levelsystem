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
        ply:AddPercentageXP(50)
        self:Remove()
        
        print("[SBOX-LS] Added 50% XP to " .. ply:Nick())
    end
end