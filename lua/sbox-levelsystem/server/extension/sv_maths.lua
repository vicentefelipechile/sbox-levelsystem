if mathQuestions.math then

    hook.Add("mathQuestionAnswered", "SboxLS_maths", function(ply)
        if GetConVar("sbox_ls_module_credits"):GetBool() then
            SLS.simpleAddXp(ply, "module_maths_answered")
        end
    end)
    
end