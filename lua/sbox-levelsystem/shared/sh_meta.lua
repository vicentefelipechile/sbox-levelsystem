local meta = FindMetaTable("Player")
if ( not meta ) then return end

--[[---------------------------------------------------------
    Name: GetPlayerLevel
    Desc: Returns the player's level
-----------------------------------------------------------]]
function meta:GetPlayerLevel()
    if ( not self:IsPlayer() ) then return 1 end

    return tonumber(self:GetNWInt("sbox_ls_level"))
end

--[[---------------------------------------------------------
    Name: GetPlayerXP
    Desc: Returns the player's XP
-----------------------------------------------------------]]
function meta:GetPlayerXP()
    if ( not self:IsPlayer() ) then return 0 end

    return tonumber(self:GetNWInt("sbox_ls_xp"))
end

--[[---------------------------------------------------------
    Name: GetPlayerXPToNextLevel
    Desc: Returns the player's XP to next level
-----------------------------------------------------------]]
function meta:GetPlayerXPToNextLevel()
    if ( not self:IsPlayer() ) then return 0 end

    local xp = self:GetPlayerXP()
    local xp_total = SLS_getLevelExp(self:GetPlayerLevel())

    return xp_total-xp
end

--[[---------------------------------------------------------
    Name: IsPlayerLevelEqualTo
    Desc: Returns if the player's level is equal to the given level
-----------------------------------------------------------]]
function meta:IsPlayerLevelEqualTo(level)
    if ( not self:IsPlayer() ) then return false end
    if ( not level or isnumber(level) ) then return false end

    return tonumber(self:GetPlayerLevel()) == level
end

--[[---------------------------------------------------------
    Name: IsPlayerLevelMoreThan
    Desc: Returns if the player's level is more than the given level
-----------------------------------------------------------]]
function meta:IsPlayerLevelMoreThan(level)
    if ( not self:IsPlayer() ) then return false end
    if ( not level or isnumber(level) ) then return false end

    return self:GetPlayerLevel() >= level
end

--[[---------------------------------------------------------
    Name: IsPlayerLevelLessThan
    Desc: Returns if the player's level is less than the given level
-----------------------------------------------------------]]
function meta:IsPlayerLevelLessThan(level)
    if ( not self:IsPlayer() ) then return false end
    if ( not level or isnumber(level) ) then return false end

    return self:GetPlayerLevel() < level
end

--[[---------------------------------------------------------
    Name: IsPlayerLevelBetween
    Desc: Returns if the player's level is between the given levels
-----------------------------------------------------------]]
function meta:IsPlayerLevelBetween(level1, level2)
    if ( not self:IsPlayer() ) then return false end
    if ( not level1 or isnumber(level1) ) then return false end
    if ( not level2 or isnumber(level2) ) then return false end

    return self:GetPlayerLevel() >= level1 and self:GetPlayerLevel() <= level2
end

--[[---------------------------------------------------------
    Name: AddXP
    Desc: Adds XP to the player
-----------------------------------------------------------]]
function meta:AddXP(xp)
    if ( not self:IsPlayer() ) then return false end
    if ( not xp or isnumber(xp) ) then return false end

    SLS_addXPToPlayer(self, xp)
    return true
end