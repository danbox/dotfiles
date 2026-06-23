-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                    Environment variables                    ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
--
-- Note: hyprlang had `env` and `envd` (the latter also exports to the
-- systemd/D-Bus activation environment). Lua exposes a single hl.env(); the
-- activation-environment import is handled by Hyprland itself (see the
-- `systemctl --user import-environment` / `dbus-update-activation-environment`
-- calls in autostart.lua).

-- Cursor sizing (was envd)
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_SIZE", "24")
hl.env("QT_CURSOR_SIZE", "24")

-- NVIDIA / Wayland
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("NVD_BACKEND", "direct")

-- Qt theming (was an `env` in autostart.conf)
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.config({
    cursor = {
        -- was `true`; this option is now an int: 0 = use hw cursors,
        -- 1 = don't use hw cursors, 2 = auto
        no_hardware_cursors = 1,
    },
})
