local SBOXLS_Menu = {}

function SBOXLS_Menu:Open()

    if not IsValid(SBOXLS_Menu.Frame) then
        local level = LocalPlayer():GetNWInt("sbox_ls_level")
        local xp    = LocalPlayer():GetNWInt("sbox_ls_xp")
        local xp_total = SLS.getLevelXP(tonumber(level))

        ----------------------------------
        ------------- Windows ------------
        ----------------------------------
        SBOXLS_Menu.Frame = vgui.Create("DFrame")
        SBOXLS_Menu.Frame:SetTitle("Sandbox Level System")
        SBOXLS_Menu.Frame:SetSize(300, 200)
        SBOXLS_Menu.Frame:Center()
        SBOXLS_Menu.Frame:MakePopup()

        ----------------------------------
        ------------- Labels -------------
        ----------------------------------
        local s1Label = vgui.Create("DLabel", SBOXLS_Menu.Frame)
        s1Label:SetPos(24, 30)
        s1Label:SetSize(285, 16)
        s1Label:SetText(SLS.GetLanguage("level_current") .. ": " .. level)

        local s1Icon = vgui.Create("DImage", SBOXLS_Menu.Frame)
        s1Icon:SetPos(5, 30)
        s1Icon:SetSize(16, 16)
        s1Icon:SetImage("sbox_levelsystem/level_add.png")

        local s2Label = vgui.Create("DLabel", SBOXLS_Menu.Frame)
        s2Label:SetPos(24, 50)
        s2Label:SetSize(285, 16)
        s2Label:SetText(SLS.GetLanguage("level_next1") ..  xp_total - xp .. " " .. SLS.GetLanguage("xp") .. SLS.GetLanguage("level_next2"))

        local s2Icon = vgui.Create("DImage", SBOXLS_Menu.Frame)
        s2Icon:SetPos(5, 50)
        s2Icon:SetSize(16, 16)
        s2Icon:SetImage("sbox_levelsystem/xp_add.png")

        local s3Label = vgui.Create("DLabel", SBOXLS_Menu.Frame)
        s3Label:SetPos(24, 70)
        s3Label:SetSize(285, 16)
        s3Label:SetText(SLS.GetLanguage("xp_current") .. ": " .. xp .. " / " .. xp_total)

        local s3Icon = vgui.Create("DImage", SBOXLS_Menu.Frame)
        s3Icon:SetPos(5, 70)
        s3Icon:SetSize(16, 16)
        s3Icon:SetImage("sbox_levelsystem/xp.png")

        local s4Label = vgui.Create("DLabel", SBOXLS_Menu.Frame)
        s4Label:SetPos(24, 90)
        s4Label:SetSize(285, 16)
        s4Label:SetText(SLS.GetLanguage("level") .. ": " .. level .. "/" .. #sbox_ls["levels"])

        local s4Icon = vgui.Create("DImage", SBOXLS_Menu.Frame)
        s4Icon:SetPos(5, 90)
        s4Icon:SetSize(16, 16)
        s4Icon:SetImage("sbox_levelsystem/level.png")

        local s1Progress = vgui.Create("DProgress", SBOXLS_Menu.Frame)
        s1Progress:SetPos(5, 178)
        s1Progress:SetSize(290, 16)
        s1Progress:SetFraction(math.Round(xp / xp_total, 2))

        local s5Label = vgui.Create("DLabel", SBOXLS_Menu.Frame)
        s5Label:SetPos(118, 160)
        s5Label:SetSize(285, 16)
        s5Label:SetText(SLS.GetLanguage("progress") .. ": " .. math.Round(xp / xp_total * 100) .. "%")

        ------------------------------
        ------ Error Prevention ------
        ------------------------------
        SBOXLS_Menu.Frame.Think = function(self)
            if input.IsKeyDown(KEY_F8) then
                self:Close()
            end
        end

    end

end

function SBOXLS_Menu:Close()
    if IsValid(SBOXLS_Menu.Frame) then
        SBOXLS_Menu.Frame:Close()
    end
end

concommand.Add("sbox_ls_menu", function(ply)
    SBOXLS_Menu:Open()
end)

hook.Add("OnPlayerChat", "SboxLS_perksMenu", function(ply, text)
    if string.lower(text) == "!level" and ply == LocalPlayer() then
        ply:ConCommand("sbox_ls_menu")
    end
end)