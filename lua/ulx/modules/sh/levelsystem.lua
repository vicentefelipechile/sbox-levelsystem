function ulx.addlevel( calling_ply, target, number )
	local level = target:GetPlayerLevel() or target:GetNWInt("sbox_ls_level", 1)

    target:SetPlayerLevel(number + level)

	ulx.fancyLogAdmin( calling_ply, "#A add #s levels to #T", level, target )
end
local addlevel = ulx.command("Level System", "ulx addlevel", ulx.addlevel, "!addlevel")
addlevel:addParam{ type=ULib.cmds.PlayerArg }
addlevel:addParam{ type=ULib.cmds.NumArg, min=1, max=#sbox_ls["levels"]}
addlevel:defaultAccess( ULib.ACCESS_SUPERADMIN )
addlevel:help( "Add a level to an user" )



function ulx.setlevel( calling_ply, target, number )
    target:SetPlayerLevel(number)

	ulx.fancyLogAdmin( calling_ply, "#A set level #s to #T", level, target )
end
local setlevel = ulx.command("Level System", "ulx setlevel", ulx.setlevel, "!setlevel")
setlevel:addParam{ type=ULib.cmds.PlayerArg }
setlevel:addParam{ type=ULib.cmds.NumArg, min=1, max=#sbox_ls["levels"]}
setlevel:defaultAccess( ULib.ACCESS_SUPERADMIN )
setlevel:help( "Set a level to an user" )