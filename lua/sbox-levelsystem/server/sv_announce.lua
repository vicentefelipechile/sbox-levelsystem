hook.Add("onPlayerLevelUp", "onPlayerLevelUp", function(ply, level)

    if sbox_ls.display_level then

        net.Start("sandbox_levelsystem_levelup")
            net.WriteTable({
                lvl = tostring(level),
                name = ply:Nick()
            })
        net.Broadcast()
    end
end)