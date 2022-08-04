net.Receive("sandbox_levelsystem_levelup", function()
    local data = net.ReadTable()

    local name = data.name
    local level = data.lvl

    chat.AddText(sbox_ls.prefix_color, sbox_ls.prefix, Color(255, 255, 255), " ", name, " ", SLS.GetLanguage("levelup"), " ", level)
end)