-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                         Variables                           ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
-- https://wiki.hypr.land/Configuring/Basics/Variables/

local colors = require("config/colors")

hl.config({
    -- https://wiki.hypr.land/Configuring/Basics/Variables/#general
    general = {
        gaps_in = 3,
        gaps_out = 5,
        border_size = 3,
        ["col.active_border"] = colors.cachylgreen,
        ["col.inactive_border"] = colors.cachymblue,
        layout = "dwindle", -- master | dwindle
        snap = {
            enabled = true,
        },
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#group
    group = {
        ["col.border_active"] = colors.cachydgreen,
        ["col.border_inactive"] = colors.cachylgreen,
        ["col.border_locked_active"] = colors.cachymgreen,
        ["col.border_locked_inactive"] = colors.cachydblue,
        groupbar = {
            font_family = "Fira Sans",
            text_color = colors.cachydblue,
            ["col.active"] = colors.cachydgreen,
            ["col.inactive"] = colors.cachylgreen,
            ["col.locked_active"] = colors.cachymgreen,
            ["col.locked_inactive"] = colors.cachydblue,
        },
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
    misc = {
        font_family = "Fira Sans",
        splash_font_family = "Fira Sans",
        disable_hyprland_logo = true,
        ["col.splash"] = colors.cachylgreen,
        background_color = colors.cachydblue,
        enable_swallow = true,
        swallow_regex = [[^(cachy-browser|firefox|nautilus|nemo|thunar|btrfs-assistant.)$]],
        focus_on_activate = true,
        vrr = 2,
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#render
    render = {
        -- was `true`; now an int: 0 = off, 1 = on, 2 = auto
        direct_scanout = 1,
    },

    -- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
    dwindle = {
        preserve_split = true,
    },

    -- https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
    master = {
        new_status = "master",
    },
})

-- Workspace-swipe gestures are now configured via hl.gesture(); the old
-- `gestures { workspace_swipe = ... }` block was commented out, so it is left
-- out here too. See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
