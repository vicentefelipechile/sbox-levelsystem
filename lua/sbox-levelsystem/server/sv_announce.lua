hook.Add("onPlayerLevelUp", "onPlayerLevelUp", function(ply, level)

    if sbox_ls.display_level:GetBool() then

        net.Start("sandbox_levelsystem_levelup")
            net.WriteUInt(level, 16)
            net.WriteString(ply:Nick())
        net.Broadcast()

    end
end)