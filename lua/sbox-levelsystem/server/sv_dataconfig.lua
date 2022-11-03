--------------------------
------- HTTP Fetch -------
--------------------------

local config = ""

http.Fetch("https://raw.githubusercontent.com/SuperCALIENTITO/sbox-levelsystem/main/data/sbox-levelsystem/config.txt",
    function(body)
        config = body
    end,

    function(failed)
        print("[SBOX-LS] ERROR: " .. failed)
        print("[SBOX-LS] FAILED TO FETCH, USING BACKUP...")
        config = [[#
#   XP
#

sbox_ls_connections = 15
sbox_ls_kills = 15
sbox_ls_deaths = 3
sbox_ls_chats = 1
sbox_ls_physgun = 2
sbox_ls_noclip = 2
sbox_ls_npc_killed = 2
sbox_ls_spawned_npc = 2
sbox_ls_spawned_prop = 1
sbox_ls_spawned_sent = 2
sbox_ls_spawned_ragdoll = 2


#
#   GDR - https://github.com/SuperCALIENTITO/gdr_addon
#

gdr_enable = false
gdr_picture = "https://i.imgur.com/EKHWx6Y.png"
gdr_name = "Sandbox Level System"
gdr_message = " has reached level "


#
#   Gmod Stats - https://steamcommunity.com/sharedfiles/filedetails/?id=2829026660
#

gmodstats_enable = true
gmodstats_db = "stats_mp"


#
#   Math problems - https://steamcommunity.com/sharedfiles/filedetails/?id=2805623775
#

maths_enable = true
maths_db = "math_points"]]
    end
)