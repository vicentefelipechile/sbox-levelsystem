----------------------------------
------------ XP Module -----------
----------------------------------

local MODULE_XP = GAS.Logging:MODULE()

MODULE_XP.Category = "Sandbox Level System"
MODULE_XP.Name     = "Experience"
MODULE_XP.Colour   = Color(55, 195, 227)

MODULE_XP:Setup(function()

    MODULE_XP:Hook("onPlayerGetXP","onPlayerGetXP", function(ply, xp)
        MODULE_XP:Log("{1} has receive {2} experience", GAS.Logging:FormatPlayer(ply), GAS.Logging:Escape(xp))
    end)

end)

GAS.Logging:AddModule(MODULE_XP)

----------------------------------
---------- Level Module ----------
----------------------------------

local MODULE_LVL = GAS.Logging:MODULE()

MODULE_LVL.Category = "Sandbox Level System"
MODULE_LVL.Name     = "Level UPs"
MODULE_LVL.Colour   = Color(55, 195, 227)

MODULE_LVL:Setup(function()

    MODULE_LVL:Hook("onPlayerLevelUp","onPlayerLevelUp", function(ply, level)
        MODULE_LVL:Log("{1} has leveled up to level {2}", GAS.Logging:FormatPlayer(ply), GAS.Logging:Escape(level))
    end)

end)

GAS.Logging:AddModule(MODULE_LVL)

----------------------------------
---------- Perks Module ----------
----------------------------------

local MODULE_PERKS = GAS.Logging:MODULE()

MODULE_PERKS.Category = "Sandbox Level System"
MODULE_PERKS.Name     = "Perks"
MODULE_PERKS.Colour   = Color(55, 195, 227)

MODULE_PERKS:Setup(function()
    
    MODULE_PERKS:Hook("playerSetUpPerks","playerSetUpPerks", function(ply, perk, value)
        MODULE_PERKS:Log("{1} has setup {2} perk with {3} bonus value", GAS.Logging:FormatPlayer(ply), GAS.Logging:Escape(perk), GAS.Logging:Escape(value))
    end)

end)

GAS.Logging:AddModule(MODULE_PERKS)