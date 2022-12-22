net.Receive("sandbox_levelsystem_config", function()
    local bytes = net.ReadUInt( 16 )
    local message = net.ReadData( bytes )
    local tbl =  util.JSONToTable(util.Decompress( message ))

    for convar, value in pairs(tbl) do
        if string.StartWith(convar, "sbox_ls_") then continue end
        
        sbox_ls[convar] = value
    end
end)

net.Receive("sandbox_levelsystem_levelup", function()
    local level = net.ReadUInt(16)
    local name = net.ReadString()

    chat.AddText(sbox_ls.prefix_color, sbox_ls.prefix:GetString(), Color(255, 255, 255), " ", name, " ", SLS.GetLanguage("levelup"), " ", level)
end)