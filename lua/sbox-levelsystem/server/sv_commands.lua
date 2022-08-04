hook.Add("PlayerSay", "SboxLS_commands", function(ply, text)
    if string.lower(text) == "!level" then

        local stats = sql.Query("SELECT * FROM " .. sbox_ls.db .. " WHERE player = " .. sql.SQLStr(ply:SteamID64()) .. ";")
        
        net.Start("sandbox_levelsystem_menu")
            net.WriteTable({
                level = stats[1]["level"],
                xp = stats[1]["xp"]
            })
        net.Send(ply)

    end
end)