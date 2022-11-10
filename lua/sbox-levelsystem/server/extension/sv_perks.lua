-- Original idea: MLGLuigi Gamer

SLS.perks_default = {
    ["perk1"] = 100, -- Health
    ["perk2"] = 100, -- Armor
    ["perk3"] = 200, -- Jump
    ["perk4"] = 400, -- speed
}

net.Receive("sandbox_levelsystem_perks", function(_, ply)
    local enabled = net.ReadBool()
    local perk1 = net.ReadInt()
    local perk2 = net.ReadInt()
    local perk3 = net.ReadInt()
    local perk4 = net.ReadInt()

    if enabled and GetConVar("sbox_ls_module_perk"):GetBool() then
        ply:SetNWBool("sbox_ls_perks_enabled", true)

        ply:SetNWInt("sbox_ls_perks_health", perk1)
        ply:SetNWInt("sbox_ls_perks_armor",  perk2)
        ply:SetNWInt("sbox_ls_perks_jump",   perk3)
        ply:SetNWInt("sbox_ls_perks_speed",  perk4)

        if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_module_perk_health_min"):GetInt()) then
            ply:SetMaxHealth(SLS.perks_default["perk1"] + perk1)
        end

        if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_module_perk_armor_min"):GetInt()) then
            ply:SetMaxArmor(SLS.perks_default["perk2"] + perk2)
        end

        if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_module_perk_jump_min"):GetInt()) then
            ply:SetJumpPower(SLS.perks_default["perk3"] + perk3)
        end

        if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_module_perk_speed_min"):GetInt()) then
            ply:SetRunSpeed(SLS.perks_default["perk4"] + perk4)
            ply:SetMaxSpeed(SLS.perks_default["perk4"] + perk4)
        end
    else
        ply:SetNWBool("sbox_ls_perks_enabled", false)

        ply:SetMaxHealth( SLS.perks_default["perk1"] )
        ply:SetMaxArmor(  SLS.perks_default["perk2"] )
        ply:SetJumpPower( SLS.perks_default["perk3"] )
        ply:SetMaxSpeed(  SLS.perks_default["perk4"] )
        ply:SetRunSpeed(  SLS.perks_default["perk4"] )
    end
end)

net.Receive("sandbox_levelsystem_perks_admin", function(_, ply)
    local data = net.ReadBool()

    if not ply:IsSuperAdmin() then return end

    return data and RunConsoleCommand("sbox_ls_module_perk", "1") or RunConsoleCommand("sbox_ls_module_perk", "0")
end)

hook.Add("PlayerSpawn", "SboxLS_perksSpawn", function(ply)
    local enabled   = ply:GetNWBool("sbox_ls_perks_enabled")
    local health    = ply:GetNWInt("sbox_ls_perks_health")
    local armor     = ply:GetNWInt("sbox_ls_perks_armor")
    local jump      = ply:GetNWInt("sbox_ls_perks_jump")
    local speed     = ply:GetNWInt("sbox_ls_perks_speed")

    if enabled and GetConVar("sbox_ls_module_perk"):GetBool() then

        timer.Simple(GetConVar("sbox_ls_module_perk_delay"):GetInt(), function()
            if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_module_perk_health_min"):GetInt()) then
                hook.Call("playerSetUpPerks", nil, ply, "health", health)
                ply:SetHealth(SLS.perks_default["perk1"] + health)
                ply:SetArmor(SLS.perks_default["perk1"] + armor)
            end
            
            if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_module_perk_armor_min"):GetInt()) then
                hook.Call("playerSetUpPerks", nil, ply, "armor", armor)
                ply:SetMaxHealth(SLS.perks_default["perk2"] + health)
                ply:SetMaxArmor(SLS.perks_default["perk2"] + armor)
            end
            
            if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_module_perk_jump_min"):GetInt()) then
                hook.Call("playerSetUpPerks", nil, ply, "jump", jump)
                ply:SetJumpPower(SLS.perks_default["perk3"] + jump)
            end

            if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_module_perk_speed_min"):GetInt()) then
                hook.Call("playerSetUpPerks", nil, ply, "speed", speed)
                ply:SetRunSpeed(SLS.perks_default["perk4"] + speed)
                ply:SetMaxSpeed(SLS.perks_default["perk4"] + speed)
            end
        end)
    end
end)