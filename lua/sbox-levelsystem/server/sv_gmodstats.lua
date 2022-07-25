local function level.GetGmodStats(ply)

    if not sql.TableExists("stats_mp") then return end

    local stats = sql.Query("SELECT * FROM stats_mp WHERE player = " .. sql.SQLStr(ply:SteamID64()) .. ";")

    local id = ply:SteamID64()
    local xp_connections = tonumber(stats[1]["connection"]) * GetConVar("sbox_ls_connections"):GetInt()
    local xp_physgun = tonumber(stats[1]["physgun"]) * GetConVar("sbox_ls_physgun"):GetInt()
    local xp_noclip = tonumber(stats[1]["noclip"]) * GetConVar("sbox_ls_noclip"):GetInt()
	local xp_deaths = tonumber(stats[1]["death"]) * GetConVar("sbox_ls_deaths"):GetInt()
    local xp_kills = tonumber(stats[1]["kill"]) * GetConVar("sbox_ls_kills"):GetInt()
    local xp_chat = tonumber(stats[1]["chat"]) * GetConVar("sbox_ls_chats"):GetInt()
    local xp_total = 0
    for k, v in ipairs(sbox_ls["levels"]) do
        xp_total = xp_total + v
    end

    local xp = xp_deaths + xp_kills + xp_connections + xp_chat + xp_noclip
    print(xp)

    local level = 1
    local xp_level = 0
    for k, v in ipairs(sbox_ls["levels"]) do
        xp_total = xp_total + v
    end

    for i = 1, #sbox_ls["levels"] do
        if xp >= sbox_ls["levels"][i] then
            xp = xp - sbox_ls["levels"][i]
            level = level + 1
        end
    end

    if level > #sbox_ls["levels"] then
        level = tonumber(#sbox_ls["levels"])
        xp = math.random(1, 120)
    end

    sql.Query("UPDATE " .. sbox_ls.db .. " SET level = " .. SQLStr(level) .. ", xp = " .. SQLStr(xp) .. " WHERE player = " .. id .. ";")

end

hook.Add("PlayerSay", "SboxLS_gmodstats", function(ply, text)
    if text == "!level gmodstats" then
        level.GetGmodStats(ply)
    end
end)