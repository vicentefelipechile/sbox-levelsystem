if mathQuestions then

    hook.Add("mathQuestionAnswered", "SboxLS_maths", function(ply)
        if SLS.configVar("module_credits") then
            SLS.simpleAddXp(ply, "module_maths_answered")
        end
    end)
    
end