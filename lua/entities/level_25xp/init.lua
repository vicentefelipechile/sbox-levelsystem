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
        local xp = math.Round(sbox_ls["levels"][ply:GetPlayerLevel()]*0.25)
        ply:AddXP(xp)
        self:Remove()
        
        print("[SBOX-LS] Added 25% XP to " .. ply:Nick())
    end
end