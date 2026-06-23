-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                        Decorations                          ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration

hl.config({
    decoration = {
        active_opacity = 1,
        rounding = 4,

        blur = {
            enabled = false,
            size = 15,
            passes = 2, -- more passes = more resource intensive
            xray = true,
        },

        shadow = {
            enabled = false,
        },
    },
})
