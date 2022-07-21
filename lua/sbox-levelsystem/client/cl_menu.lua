net.Receive("sbox_levelsystem", function()
    local data = net.ReadTable()

    local level = data.level
    local xp = data.xp
    local xp_total = SLS_getLevelExp(level)

    ----------------------------------
    ------------- Windows ------------
    ----------------------------------
    local sFrame = vgui.Create("DFrame")
    sFrame:SetTitle(SLS_GetLanguage("level"))
    sFrame:SetSize(300, 200)
    sFrame:Center()
    sFrame:MakePopup()

    ----------------------------------
    ------------- Labels -------------
    ----------------------------------
    local s1Label = vgui.Create("DLabel", sFrame)
    s1Label:SetPos(5, 30)
    s1Label:SetSize(100, 16)
    s1Label:SetText(SLS_GetLanguage("level_current") .. ": " .. level)

    local s2Label = vgui.Create("DLabel", sFrame)
    s2Label:SetPos(5, 50)
    s2Label:SetSize(100, 16)
    s2Label:SetText(SLS_GetLanguage("level_next1") ..  xp_total - xp .. SLS_GetLanguage("xp") .. SLS_GetLanguage("level_next2"))

    local s3Label = vgui.Create("DLabel", sFrame)
    s3Label:SetPos(5, 70)
    s3Label:SetSize(100, 16)
    s3Label:SetText(SLS_GetLanguage("xp_current") .. ": " .. xp .. " / " .. xp_total)

    local s4Label = vgui.Create("DLabel", sFrame)
    s5Label:SetPos(5, 110)
    s5Label:SetSize(100, 16)
    s5Label:SetText(SLS_GetLanguage("level") .. ": " .. level)

    local s5Label = vgui.Create("DLabel", sFrame)
    s5Label:SetPos(5, 90)
    s5Label:SetSize(100, 16)
    s5Label:SetText(SLS_GetLanguage("progress") .. ": " .. math.Round(xp / xp_total * 100) .. "%")

    local s1Progress = vgui.Create("DProgress", sFrame)
    s1Progress:SetPos(5, 90)
    s1Progress:SetSize(290, 16)
    s1Progress:SetFraction(math.Round(xp / xp_total, 2))
end)