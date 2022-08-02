concommand.Add("sbox_ls_gmodstats", function(ply)
    if sbox_ls.maths_enable and sql.TableExists(sbox_ls.math_db) then
        SLS_ext_GetGmodStats(ply)
        print(sbox_ls.prefix .. SLS_GetLanguage("updated") .. "\n")
    else
        print(sbox_ls.prefix .. SLS_GetLanguage("disabled_gmodstats") .. "\n")
    end
end)