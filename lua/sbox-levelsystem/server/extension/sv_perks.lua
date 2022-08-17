-- Original idea: MLGLuigi Gamer

local var_default = {
    100, -- Health and armor
    200, -- Jump
    400, -- speed
    400, -- run
}

net.Receive("sandbox_levelsystem_perks", function(_, ply)
    local data = net.ReadTable()

    if data[1] == 1 and ( GetConVar("sbox_ls_perk_module"):GetInt() == 1 ) then
        ply:SetNWInt("sbox_ls_perks_enabled", 1)

        ply:SetNWInt("sbox_ls_perks_health", data[2])
        ply:SetNWInt("sbox_ls_perks_armor", data[3])
        ply:SetNWInt("sbox_ls_perks_jump", data[4])
        ply:SetNWInt("sbox_ls_perks_speed", data[5])

        if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_perk_module_health_min"):GetInt()) then
            ply:SetMaxHealth(var_default[1] + data[2])
        end

        if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_perk_module_armor_min"):GetInt()) then
            ply:SetMaxArmor(var_default[1] + data[3])
        end

        if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_perk_module_jump_min"):GetInt()) then
            ply:SetJumpPower(var_default[2] + data[5])
        end

        if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_perk_module_speed_min"):GetInt()) then
            ply:SetRunSpeed(var_default[3] + data[4])
            ply:SetMaxSpeed(var_default[3] + data[4])
        end
    else
        ply:SetNWInt("sbox_ls_perks_enabled", 0)

        ply:SetMaxHealth(var_default[1])
        ply:SetMaxArmor(var_default[1])
        ply:SetJumpPower(var_default[2])
        ply:SetMaxSpeed(var_default[2])
        ply:SetRunSpeed(var_default[3])
    end
end)

net.Receive("sandbox_levelsystem_perks_admin", function(_, ply)
    local data = net.ReadBool()

    if data then
        RunConsoleCommand("sbox_ls_perk_module", "1")
    else
        RunConsoleCommand("sbox_ls_perk_module", "0")
    end
end)

hook.Add("PlayerSpawn", "SboxLS_perksSpawn", function(ply)
    local enabled = ply:GetNWInt("sbox_ls_perks_enabled")
    local health = ply:GetNWInt("sbox_ls_perks_health")
    local armor = ply:GetNWInt("sbox_ls_perks_armor")
    local jump = ply:GetNWInt("sbox_ls_perks_jump")
    local speed = ply:GetNWInt("sbox_ls_perks_speed")

    net.Start("sandbox_levelsystem_perks_data")
        net.WriteTable({
            GetConVar("sbox_ls_perk_module_health_min"):GetInt(),
            GetConVar("sbox_ls_perk_module_armor_min"):GetInt(),
            GetConVar("sbox_ls_perk_module_jump_min"):GetInt(),
            GetConVar("sbox_ls_perk_module_speed_min"):GetInt(),
        })
    net.Send(ply)

    if enabled == 1 and ( GetConVar("sbox_ls_perk_module"):GetInt() == 1 ) then

        timer.Simple(0.01, function()
            if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_perk_module_health_min"):GetInt()) then
                ply:SetHealth(var_default[1] + health)
                ply:SetArmor(var_default[1] + armor)
            end
            
            if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_perk_module_armor_min"):GetInt()) then
                ply:SetMaxHealth(var_default[1] + health)
                ply:SetMaxArmor(var_default[1] + armor)
            end
            
            if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_perk_module_jump_min"):GetInt()) then
                ply:SetJumpPower(var_default[2] + jump)
            end

            if ply:IsPlayerLevelMoreThan(GetConVar("sbox_ls_perk_module_speed_min"):GetInt()) then
                ply:SetRunSpeed(var_default[3] + speed)
                ply:SetMaxSpeed(var_default[3] + speed)
            end
        end)
    end
end)