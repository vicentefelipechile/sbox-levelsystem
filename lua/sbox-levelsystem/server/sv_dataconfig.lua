--------------------------
------- HTTP Fetch -------
--------------------------

function SLS.requestData()
    local config = ""

    http.Fetch("https://raw.githubusercontent.com/SuperCALIENTITO/sbox-levelsystem/main/data/sbox-levelsystem/config.txt",
        function(body, _, _, response)
            if response == 200 then
                config = body
            else
                SLS.mSV("ERROR: "..response)
                SLS.mSV("FAILED TO FETCH, YOU CAN'T USE CONFIG")
            end
        end,

        function(failed)
            SLS.mSV("ERROR: " .. failed)
        end,
        {}
    )

    return config
end

--------------------------
------- Data Write -------
--------------------------

local dir = sbox_ls.dir .. "/"

function SLS.checkData()
    if file.IsDir(sbox_ls.dir, "DATA") and file.Exists(dir.."config.txt", "DATA") then
        SLS.mSV("Data is correct, eureka!")
    end

    if not file.Exists(dir.."config.txt", "DATA") then
        file.CreateDir(sbox_ls.dir)

        local data = SLS.requestData()

        if data then
            file.Write(dir.."config.txt", data)
            file.Write(dir.."readme.txt", SLS.GetLanguage("readme"))
        end
    end
end

SLS.checkData()

function SLS.resetData()
    file.Delete(dir.."readme.txt")
    file.Delete(dir.."config.txt")
end

concommand.Add("sbox_ls_data_check", function() SLS.checkData() end, function() end, "Check the integrity of the data inside of"..dir)
concommand.Add("sbox_ls_data_remove", function() SLS.resetData() end, function() end, "Remove all data inside of "..dir)