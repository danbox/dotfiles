-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                  Window / Workspace / Layer rules           ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

local colors = require("config/colors")

-- ======= Float Necessary Windows =======
hl.window_rule({ name = "windowrule-1", match = { class = [[^(org.pulseaudio.pavucontrol)]] }, float = true })
hl.window_rule({ name = "windowrule-2", match = { class = [[^()$]], title = [[^(Picture in picture)$]] }, float = true })
hl.window_rule({ name = "windowrule-3", match = { class = [[^()$]], title = [[^(Save File)$]] }, float = true })
hl.window_rule({ name = "windowrule-4", match = { class = [[^()$]], title = [[^(Open File)$]] }, float = true })
hl.window_rule({ name = "windowrule-5", match = { class = [[^(LibreWolf)$]], title = [[^(Picture-in-Picture)$]] }, float = true })
hl.window_rule({ name = "windowrule-6", match = { class = [[^(blueman-manager)$]] }, float = true })
hl.window_rule({ name = "windowrule-7", match = { class = [[^(xdg-desktop-portal-gtk|xdg-desktop-portal-kde|xdg-desktop-portal-hyprland)(.*)$]] }, float = true })
hl.window_rule({ name = "windowrule-8", match = { class = [[^(polkit-gnome-authentication-agent-1|hyprpolkitagent|org.org.kde.polkit-kde-authentication-agent-1)(.*)$]] }, float = true })
hl.window_rule({ name = "windowrule-9", match = { class = [[^(CachyOSHello)$]] }, float = true })
hl.window_rule({ name = "windowrule-10", match = { class = [[^(zenity)$]] }, float = true })
hl.window_rule({ name = "windowrule-11", match = { class = [[^()$]], title = [[^(Steam - Self Updater)$]] }, float = true })

-- ======= Increase the opacity =======
hl.window_rule({ name = "windowrule-12", match = { class = [[^(thunar|nemo)$]] }, opacity = "0.92" })
hl.window_rule({ name = "windowrule-13", match = { class = [[^(discord|armcord|webcord)$]] }, opacity = "0.96" })
hl.window_rule({ name = "windowrule-14", match = { title = [[^(QQ|Telegram)$]] }, opacity = "0.95" })
hl.window_rule({ name = "windowrule-15", match = { title = [[^(NetEase Cloud Music Gtk4)$]] }, opacity = "0.95" })

-- ======= General window rules =======
hl.window_rule({
    name = "windowrule-16",
    match = { title = [[^(Picture-in-Picture)$]] },
    float = true,
    size = { 960, 540 },
    -- NOTE: original `move = ((monitor_w*0.25)-)` was malformed (missing the Y
    -- value), so it is omitted. Set e.g. move = { "monitor_w*0.25", "0" } if wanted.
})
hl.window_rule({
    name = "windowrule-17",
    match = { title = [[^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp)$]] },
    float = true,
    size = { 960, 540 },
    -- NOTE: original `move = ((monitor_w*0.25)-)` was malformed; omitted (see above).
})
hl.window_rule({ name = "windowrule-18", match = { title = [[^(danmufloat)$]] }, pin = true })
hl.window_rule({ name = "windowrule-19", match = { title = [[^(danmufloat|termfloat)$]] }, rounding = 5 })
hl.window_rule({ name = "windowrule-20", match = { class = [[^(kitty|Alacritty)$]] }, animation = "slide right" })
hl.window_rule({ name = "windowrule-21", match = { class = [[^(org.mozilla.firefox)$]] }, no_blur = true })

-- Decorations for floating windows on workspaces 1 to 10
hl.window_rule({
    name = "windowrule-22",
    match = { float = true, workspace = "w[fv1-10]" },
    border_size = 2,
    border_color = colors.cachylblue,
    rounding = 8,
})

-- Decorations for tiling windows on workspaces 1 to 10
hl.window_rule({
    name = "windowrule-23",
    match = { float = false, workspace = "f[1-10]" },
    border_size = 3,
    rounding = 4,
})

hl.window_rule({
    name = "windowrule-24",
    match = { class = [[(jetbrains-)(.*)]], title = [[^win(.*)]], initial_title = [[win.*]], float = true },
    no_initial_focus = true,
})

hl.window_rule({ name = "windowrule-25", match = { class = [[^(1Password)$]] }, stay_focused = true })

-- ======= Workspace Rules =======
-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- Smart gaps (no gaps when only one tiled window)
hl.workspace_rule({ workspace = "w[tv1-10]", gaps_out = 5, gaps_in = 3 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 5, gaps_in = 3 })

-- ======= Layer Rules =======
hl.layer_rule({ name = "layerrule-1", match = { namespace = "logout_dialog" }, animation = "slide top" })
hl.layer_rule({ name = "layerrule-2", match = { namespace = "waybar" }, animation = "slide down" })
hl.layer_rule({ name = "layerrule-3", match = { namespace = "wallpaper" }, animation = "fade 50%" })
