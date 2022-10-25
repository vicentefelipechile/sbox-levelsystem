hook.Add("PrePACConfigApply", "SboxLS_pac3", function(ply)
    local allowed = hook.Run("PrePACConfigApply", ply)

    if allowed then
        SLS.simpleAddXp(ply, "module_pac3_weared")
    end
end)