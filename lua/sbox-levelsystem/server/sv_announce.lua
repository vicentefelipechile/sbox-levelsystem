hook.Add("SLS_LevelUp", "SboxLS_announce", function(ply, level)
    if sbox_ls.display_level then
        for _, v in ipairs(player.GetAll()) do
            v:ChatPrint(SLS_GetLanguage("prefix") .. ply:Nick() .. " " .. SLS_GetLanguage("levelup") .. " " .. level.. ".")
        end
    end
end)