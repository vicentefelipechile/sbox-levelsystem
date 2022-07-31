hook.Add("SLS_LevelUp", "LevelUpLololololol", function(ply, level)
    if sbox_ls.display_level then
        for _, v in ipairs(player.GetAll()) do
            v:ChatPrint("[SBOX-LS] " .. ply:Nick() .. " " .. SLS_GetLanguage("levelup") .. " " .. level.. ".")
        end
    end
end)