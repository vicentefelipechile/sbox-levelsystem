util.AddNetworkString("sbox_levelsystem")
hook.Add("PlayerSay", "SboxLS_commands", function(ply)

    if string.lower(text) == "!level" then

        local level = ply:GetNWInt("level")
        local xp = ply:GetNWInt("xp")
        
        net.Start("sbox_levelsystem")
            net.WriteString("level")
            net.WriteInt(level, 32)
            net.WriteString("xp")
            net.WriteInt(xp, 32)
        net.Send(ply)
        
        return ""
    end
    return text
end)