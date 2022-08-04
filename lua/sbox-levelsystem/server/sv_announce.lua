hook.Add("onPlayerLevelUp", "onPlayerLevelUp", function(ply, level)

    if sbox_ls.display_level then

        net.Start("darkrp_levelsystem_levelup")
            net.WriteTable({
                lvl = tostring(level),
                name = ply:Nick()
            })

        for _, v in ipairs(player.GetAll()) do
            net.Send(v)
        end

    end
end)