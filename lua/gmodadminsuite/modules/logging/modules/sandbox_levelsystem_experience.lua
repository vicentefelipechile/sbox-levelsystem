local MODULE = GAS.Logging:MODULE()

MODULE.Category = "Sandbox Level System"
MODULE.Name     = "Experience"
MODULE.Colour   = Color(55, 195, 227)

MODULE:Setup(function()

    MODULE:Hook("onPlayerGetXP","onPlayerGetXP", function(ply, xp)
        MODULE:Log("{1} has receive {2} experience", GAS.Logging:FormatPlayer(ply), GAS.Logging:Escape(xp))
    end)

end)

GAS.Logging:AddModule(MODULE)