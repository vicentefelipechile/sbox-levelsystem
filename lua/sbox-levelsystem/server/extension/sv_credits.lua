hook.Add("onPlayerLevelUp", "SboxLS_creditSystem", function(ply, level)

    if Credits and GetConVar("sbox_ls_module_credits"):GetInt() == 1 then
        UpdatePlayerCredits( ply:GetNWInt("credits", 0) + GetConVar("sbox_ls_module_credits_onlevelup"):GetInt() )
    end
    
end)