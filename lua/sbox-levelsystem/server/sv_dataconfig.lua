--------------------------
------- HTTP Fetch -------
--------------------------

function SLS.httpData()

    HTTP({
        method      = "GET",
        url         = "https://raw.githubusercontent.com/vicentefelipechile/sbox-levelsystem/main/data/sbox-levelsystem/config.txt",
        headers     = {},

        success     = function(response, body, headers)
            if response == 200 then
                file.Write(sbox_ls.dir .. "/config.txt", body)
                SLS.mSV("Data has been restored")
            else
                SLS.mSV("ERROR: "..response)
                SLS.mSV("FAILED TO FETCH, YOU CAN'T USE CONFIG")
            end
        end,

        failed      = function(failed)
            SLS.mSV("ERROR: " .. failed)
        end
    })

end

--------------------------
------- Data Write -------
--------------------------

local dir = sbox_ls.dir .. "/"

function SLS.checkData()

    if file.Read(dir.."config.txt", "DATA") == "" then
        SLS.httpData()
    end

    if file.IsDir(sbox_ls.dir, "DATA") and file.Exists(dir.."config.txt", "DATA") then
        if not ( file.Read(dir.."config.txt", "DATA") == "" ) then
            SLS.mSV("Data is correct, eureka!")
        else
            SLS.mSV("Something is wrong with the Data")
            SLS.mSV("Maybe it is empty?")
        end
    end

    if not file.Exists(dir.."config.txt", "DATA") then
        file.CreateDir(sbox_ls.dir)
        file.Write(dir.."config.txt", "")

        SLS.httpData()

        file.Write(dir.."readme.txt", SLS.GetLanguage("readme"))
    end
end

function SLS.deleteData()
    file.Delete(dir.."readme.txt")
    file.Delete(dir.."config.txt")
end

function SLS.resetData()
    SLS.deleteData()
    SLS.checkData()
end

--------------------------
-------- Data Read -------
--------------------------

local Trim = string.Trim
local Find = string.find
local Sub = string.sub
local tN = tonumber

local convert = {
    ["bool"] = function(v)
        return tobool(v)
    end,
    ["number"] = function(v)
        return tN(v)
    end,
    ["color"] = function(r,g,b)
        return Color(r,g,b)
    end,
    ["invalid"] = function()
        return nil
    end
}

function SLS.checkVal(val)
    if val == ( "false" or "true" ) then
        return "bool"
    end

    if string.StartWith(val, "Color(") and string.EndsWith(val, ")") then
        local rgb = {}

        local R,G,B = val:match("Color%((%d+) (%d+) (%d+)%)")

        if not B then
            return "invalid"
        end

        rgb["r"] = tN(R)
        rgb["g"] = tN(G)
        rgb["b"] = tN(B)
        

        return "color", rgb
    end

    if tonumber(val) then
        return "number"
    end

    return "string"
end

function SLS.requestData()
    local dataConfig = file.Open(dir.."config.txt", "rb", "DATA")

    if not dataConfig then return {} end

    local tbl = {}
    
    while not dataConfig:EndOfFile() do
        local line = Trim(dataConfig:ReadLine())
    
        if string.StartWith(line, "#") then continue end

        local lineStart, lineEnd = Find(line, "=") 
        if line == "" then continue end
        if not lineStart then continue end
    
        if Find(line, "#") then
            line = Trim( Sub(line, 0, Find(line, "#") - 1) )
        end
    
        local var, value = Trim( Sub(line, 0, lineEnd - 1) ), Trim( Sub(line, lineStart + 1) )

        if sbox_ls.var_blacklist[var] then continue end

        local valType, rgb = SLS.checkVal(value)

        value = rgb and convert["color"](rgb.r, rgb.g, rgb.b) or convert[valType](value)
    
        tbl[var] = value
        sbox_ls.config[var] = value
    end
    
    dataConfig:Close()

    return tbl
    
end

local errorFallback = false

function SLS.asyncData(convar, broadcast, ply)
    local tbl = SLS.requestData()

    if broadcast or ply then
        
        local json = util.TableToJSON(tbl)
        local compress = util.Compress(json)
        local bytes = #compress

        net.Start("sandbox_levelsystem_config")
            net.WriteUInt( bytes, 16 )
            net.WriteData( compress, bytes )
        if ply then net.Send(ply) else net.Broadcast() end

    end

    if not convar then
        for var, value in pairs(tbl) do
            if sbox_ls[var] then
                if errorFallback then
                    sbox_ls[var] = value
                end
            end
        end

        return true, 1
    else
        if not tbl[convar] then return false, nil end

        if ConVarExists(convar) then
            return true, GetConVar(convar)
        end

        return true, tbl[convar]
    end
end

--------------------------
------- Concommands ------
--------------------------

concommand.Add("sbox_ls_config_check", function() SLS.checkData() end, function() end, "Check the integrity of the data inside in "..sbox_ls.dir)
concommand.Add("sbox_ls_config_reset", function() SLS.resetData() end, function() end, "Reset to factory all data inside in "..sbox_ls.dir)
concommand.Add("sbox_ls_config_remove", function() SLS.deleteData() end, function() end, "Remove all data inside in "..sbox_ls.dir)
concommand.Add("sbox_ls_config_reload", function() SLS.requestData() end, function() end, "Flush and reload the config")

timer.Simple(10, function() SLS.checkData() end)

hook.Add("PostGamemodeLoaded", "SboxLS_ConfigPost", function()
    SLS.asyncData(_, true)
end)

hook.Add("PlayerInitialSpawn", "SboxLS_ConfigInit", function(ply)
    SLS.asyncData(_, _, ply)
end)

cvars.AddChangeCallback("sbox_ls_config", function(convar, old, new)
    if new == ( "1" or 1 ) then
        errorFallback = true
        SLS.mSV("You are now allowed to change main core settings of the addon")

        SLS.asyncData(_, true)
    else
        errorFallback = false
    end
end)