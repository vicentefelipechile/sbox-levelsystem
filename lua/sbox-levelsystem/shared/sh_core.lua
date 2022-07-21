----------------------------------
------------ Functions -----------
----------------------------------
function SLS_getLevelPlayer(ply)
    local data = sql.Query("SELECT level FROM sbox_levelsystem WHERE player = " .. ply:SteamID64() .. ";")
    if #sbox_ls["levels"] > tonumber(data[1].level) then
        return tonumber(data[1].level)
    else
        return tonumber(#sbox_ls["levels"])
    end
end

function SLS_getLevelExp(level)
    local xp = sbox_ls["levels"][level]
    return tonumber(xp)
end