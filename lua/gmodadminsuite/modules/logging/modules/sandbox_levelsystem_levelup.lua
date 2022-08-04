local MODULE = GAS.Logging:MODULE()

MODULE.Category = "Sandbox Level System"
MODULE.Name     = "Level UPs"
MODULE.Colour   = Color(55, 195, 227)

MODULE:Setup(function()

    MODULE:Hook("onPlayerLevelUp","onPlayerLevelUp", function(ply, level)
        MODULE:Log("{1} has leveled up to level {2}", GAS.Logging:FormatPlayer(ply), GAS.Logging:Escape(level))
    end)

end)

GAS.Logging:AddModule(MODULE)