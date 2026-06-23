-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                         Autostart                           ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
-- https://wiki.hypr.land/Configuring/Basics/Autostart/
--
-- `exec-once` (run a single time, at startup) -> hl.on("hyprland.start", ...)
-- `exec`      (run on every config load/reload) -> top-level hl.exec_cmd(...)
-- hl.exec_cmd() spawns asynchronously, so the trailing `&` / `& disown` from
-- the old commands is not needed.

local vars = require("config/vars")

hl.on("hyprland.start", function()
    hl.exec_cmd([==[swaybg -o * -i /usr/share/wallpapers/cachyos-wallpapers/Skyscraper.png -m fill]==])
    hl.exec_cmd("ashell")
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("mako")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd([==[bash -c "mkfifo /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob && tail -f /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob | wob & disown"]==])
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")

    -- GTK3 theme
    hl.exec_cmd([==[gsettings set org.gnome.desktop.interface gtk-theme "Arc-Dark"]==])

    -- Slow app launch fix
    hl.exec_cmd("systemctl --user import-environment")
    hl.exec_cmd("hash dbus-update-activation-environment 2>/dev/null")
    hl.exec_cmd("dbus-update-activation-environment --systemd")

    -- Idle configuration
    hl.exec_cmd(vars.idlehandler)
end)

-- `exec` (runs on every load/reload): GTK4 color-scheme
hl.exec_cmd([==[gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"]==])
