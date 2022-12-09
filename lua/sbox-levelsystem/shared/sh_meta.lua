local meta = FindMetaTable("Player")
if ( not meta ) then return end

--[[---------------------------------------------------------
    Name: GetPlayerLevel
    Desc: Returns the player's level
-----------------------------------------------------------]]
function meta:GetPlayerLevel()
    if ( not self:IsPlayer() ) then return 1 end

    return SLS.getPlayerLevel(self)
end



--[[---------------------------------------------------------
    Name: GetPlayerXP
    Desc: Returns the player's XP
-----------------------------------------------------------]]
function meta:GetPlayerXP()
    if ( not self:IsPlayer() ) then return 0 end

    return SLS.getPlayerXP(self)
end



--[[---------------------------------------------------------
    Name: GetPlayerXPToNextLevel
    Desc: Returns the player's XP to next level
-----------------------------------------------------------]]
function meta:GetPlayerXPToNextLevel()
    if ( not self:IsPlayer() ) then return 0 end

    return SLS.getLevelXP( self:GetPlayerLevel() ) - self:GetPlayerXP()
end



--[[---------------------------------------------------------
    Name: SetPlayerLevel
    Desc: Sets the player's level
-----------------------------------------------------------]]
function meta:SetPlayerLevel(level)
    if ( not self:IsPlayer() ) then return end
    if ( not level and isnumber(level) == false) then return end

    SLS.setPlayerLevel(self, level)
end



--[[---------------------------------------------------------
    Name: SetPlayerXP
    Desc: Sets the player's XP
-----------------------------------------------------------]]
function meta:SetPlayerXP(xp)
    if ( not self:IsPlayer() ) then return end
    if ( not xp or not isnumber(xp) ) then return end

    SLS.setPlayerXP(self, xp)
end



--[[---------------------------------------------------------
    Name: IsPlayerLevelEqualTo
    Desc: Returns if the player's level is equal to the given level
-----------------------------------------------------------]]
function meta:IsPlayerLevelEqualTo(level)
    if ( not self:IsPlayer() ) then return false end

    return self:GetPlayerLevel() == level
end



--[[---------------------------------------------------------
    Name: IsPlayerLevelMoreThan
    Desc: Returns if the player's level is more than the given level
-----------------------------------------------------------]]
function meta:IsPlayerLevelMoreThan(level)
    if ( not self:IsPlayer() ) then return false end

    return self:GetPlayerLevel() >= level
end



--[[---------------------------------------------------------
    Name: IsPlayerLevelLessThan
    Desc: Returns if the player's level is less than the given level
-----------------------------------------------------------]]
function meta:IsPlayerLevelLessThan(level)
    if ( not self:IsPlayer() ) then return false end

    return self:GetPlayerLevel() <= level
end



--[[---------------------------------------------------------
    Name: IsPlayerLevelBetween
    Desc: Returns if the player's level is between the given levels
-----------------------------------------------------------]]
function meta:IsPlayerLevelBetween(level1, level2)
    if ( not self:IsPlayer() ) then return false end

    local ply = self:GetPlayerLevel()

    return ply >= level1 and ply <= level2
end



--[[---------------------------------------------------------
    Name: AddXP
    Desc: Adds XP to the player
-----------------------------------------------------------]]
function meta:AddXP(xp)
    if ( not self:IsPlayer() ) then return false end

    SLS.addXPToPlayer(self, xp)
end



--[[---------------------------------------------------------
    Name: AddPercentageXP (Obsolete, use ply:AddXP(XP*Percentage) instead)
    Desc: Adds a porcentage of XP to the player, the XP is the percentage of the total XP
-----------------------------------------------------------]]
function meta:AddPercentageXP(xp)
    if ( not self:IsPlayer() ) then return end

    if xp > 1 then
        xp = xp/100
    end

    local xp_total = math.Round(SLS.getLevelXP(self:GetPlayerLevel()) * xp)
    SLS.addXPToPlayer(self, xp_total)
end