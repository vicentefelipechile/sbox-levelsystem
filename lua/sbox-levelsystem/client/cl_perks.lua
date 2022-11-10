local SBOXLS_PERKS = {}

CreateClientConVar("sbox_ls_perks_enabled", "0", true, false, "Enable or disable the sbox_ls_perks locally", 0, 1)
CreateClientConVar("sbox_ls_perks_health", "0", true, false, "Amount of extra health to give to the player", 0, 100)
CreateClientConVar("sbox_ls_perks_armor", "0", true, false, "Amount of extra armor to give to the player", 0, 100)
CreateClientConVar("sbox_ls_perks_jump", "0", true, false, "Amount of extra jump power to give to the player", 0, 100)
CreateClientConVar("sbox_ls_perks_speed", "0", true, false, "Amount of extra speed to give to the player", 0, 200)

surface.CreateFont("sbox_ls_perks_Title", {font = "Tahoma",size = 24,weight = 500,antialias = true,shadow = false})
surface.CreateFont("sbox_ls_perks_Desc", {font = "Tahoma",size = 16,weight = 500,antialias = true,shadow = false})


function SBOXLS_PERKS:Open()
    local sW, sH = ScrW(), ScrH()
    if not IsValid(SBOXLS_PERKS.Menu) then
        SBOXLS_PERKS.Menu = vgui.Create("DFrame")
        SBOXLS_PERKS.Menu:SetSize(sW * 0.5, sH * 0.7)
        SBOXLS_PERKS.Menu:Center()
        SBOXLS_PERKS.Menu:SetTitle("Perks")
        SBOXLS_PERKS.Menu:SetDraggable(true)
        SBOXLS_PERKS.Menu:ShowCloseButton(true)
        SBOXLS_PERKS.Menu:MakePopup()
        SBOXLS_PERKS.Menu:SetKeyboardInputEnabled(false)

        local categories = vgui.Create("DCategoryList", SBOXLS_PERKS.Menu)
        categories:SetSize(SBOXLS_PERKS.Menu:GetWide() - 10, SBOXLS_PERKS.Menu:GetTall() - 50)
        categories:SetPos(5, 30)
        categories:SetPadding(5)

        local enabled = vgui.Create("DCheckBoxLabel", SBOXLS_PERKS.Menu)
        enabled:SetText("Enabled")
        enabled:SetPos(64, 5)
        enabled:SetValue(GetConVar("sbox_ls_perks_enabled"):GetInt())

        function enabled:OnChange(val)
            if val then
                RunConsoleCommand("sbox_ls_perks_enabled", "1")
            else
                RunConsoleCommand("sbox_ls_perks_enabled", "0")
            end
        end

        if LocalPlayer():IsSuperAdmin() then
            local config = vgui.Create("DForm", categories)
            config:SetSize(SBOXLS_PERKS.Menu:GetWide() - 20, 40)
            config:SetName("Config")
            config:Help("Enable or disable the perks")
            local button = vgui.Create("DCheckBoxLabel", config)
            button:SetText("Enabled")
            button:SetPos(16, 48)
            button:SetValue(GetConVar("sbox_ls_module_perk"):GetInt())

            function button:OnChange(val)
                if val then
                    net.Start("sandbox_levelsystem_perks_admin")
                        net.WriteBool(true)
                    net.SendToServer()
                else
                    net.Start("sandbox_levelsystem_perks_admin")
                        net.WriteBool(false)
                    net.SendToServer()
                end
            end
        end


        local perk1 = vgui.Create("DForm", categories)
        perk1:SetSize(SBOXLS_PERKS.Menu:GetWide() - 20, 40)
        perk1:SetName(SLS.GetLanguage("perk_health"))
        perk1:Help(SLS.GetLanguage("perk_health_desc"))
        perk1:Help(SLS.GetLanguage("perk_need") .. GetConVar("sbox_ls_module_perk_health_min"):GetInt() .. SLS.GetLanguage("perk_need2") .. SLS.GetLanguage("perk_health"))
        perk1:NumSlider(SLS.GetLanguage("perk_health"), "sbox_ls_perks_health", 0, 100, 0)

        function perk1:OnValueChanged(val)
            RunConsoleCommand("sbox_ls_perks_health", val)
        end

        local perk2 = vgui.Create("DForm", categories)
        perk2:SetSize(SBOXLS_PERKS.Menu:GetWide() - 20, 40)
        perk2:SetName(SLS.GetLanguage("perk_armor"))
        perk2:Help(SLS.GetLanguage("perk_armor_desc"))
        perk2:Help(SLS.GetLanguage("perk_need") .. GetConVar("sbox_ls_module_perk_armor_min"):GetInt() .. SLS.GetLanguage("perk_need2") .. SLS.GetLanguage("perk_armor"))
        perk2:NumSlider(SLS.GetLanguage("perk_armor"), "sbox_ls_perks_armor", 0, 100, 0)

        function perk2:OnValueChanged(val)
            RunConsoleCommand("sbox_ls_perks_armor", val)
        end

        local perk3 = vgui.Create("DForm", categories)
        perk3:SetSize(SBOXLS_PERKS.Menu:GetWide() - 20, 40)
        perk3:SetName(SLS.GetLanguage("perk_jump"))
        perk3:Help(SLS.GetLanguage("perk_jump_desc"))
        perk3:Help(SLS.GetLanguage("perk_need") .. GetConVar("sbox_ls_module_perk_jump_min"):GetInt() .. SLS.GetLanguage("perk_need2") .. SLS.GetLanguage("perk_jump"))
        perk3:NumSlider(SLS.GetLanguage("perk_jump"), "sbox_ls_perks_jump", 0, 100, 0)

        function perk3:OnValueChanged(val)
            RunConsoleCommand("sbox_ls_perks_jump", val)
        end

        local perk4 = vgui.Create("DForm", categories)
        perk4:SetSize(SBOXLS_PERKS.Menu:GetWide() - 20, 40)
        perk4:SetName(SLS.GetLanguage("perk_speed"))
        perk4:Help(SLS.GetLanguage("perk_speed_desc"))
        perk4:Help(SLS.GetLanguage("perk_need") .. GetConVar("sbox_ls_module_perk_speed_min"):GetInt() .. SLS.GetLanguage("perk_need2") .. SLS.GetLanguage("perk_speed"))
        perk4:NumSlider(SLS.GetLanguage("perk_speed"), "sbox_ls_perks_speed", 0, 200, 0)

        function perk4:OnValueChanged(val)
            RunConsoleCommand("sbox_ls_perks_speed", val)
        end


        ------------------------------
        ------ Error Prevention ------
        ------------------------------
        SBOXLS_PERKS.Menu.Think = function(self)
            if input.IsKeyDown(KEY_F8) then
                self:Close()
            end
        end

        SBOXLS_PERKS.Menu.OnClose = function(self)
            RunConsoleCommand("sbox_ls_perks_reload")
        end
    end
end

function SBOXLS_PERKS:Close()
    if IsValid(SBOXLS_PERKS.Menu) then
        SBOXLS_PERKS.Menu:Close()
    end

    RunConsoleCommand("sbox_ls_perks_reload")
end

concommand.Add("sbox_ls_perks_menu", function(ply)
    SBOXLS_PERKS:Open()
end)

concommand.Add("sbox_ls_perks_reload", function(ply)
    ------------------------------
    ----- Player Defined Vars ----
    ------------------------------
    local enabled = GetConVar("sbox_ls_perks_enabled"):GetBool()

    local perk1 = GetConVar("sbox_ls_perks_health"):GetInt()
    local perk2 = GetConVar("sbox_ls_perks_armor"):GetInt()
    local perk3 = GetConVar("sbox_ls_perks_jump"):GetInt()
    local perk4 = GetConVar("sbox_ls_perks_speed"):GetInt()

    net.Start("sandbox_levelsystem_perks") 
        net.WriteBool(enabled)
        net.WriteInt(perk1)
        net.WriteInt(perk2)
        net.WriteInt(perk3)
        net.WriteInt(perk4)
    net.SendToServer()
end)

hook.Add("OnPlayerChat", "SboxLS_perksMenu", function(ply, text)
    if string.lower(text) == "!perks" and ply == LocalPlayer() then
        ply:ConCommand("sbox_ls_perks_menu")
    end
end)
