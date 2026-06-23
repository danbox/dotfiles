-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                          Monitors                           ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
-- https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({ output = "eDP-1", mode = "1920x1080", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-8", mode = "preferred", position = "1920x0", scale = 1 })
hl.monitor({ output = "DP-7", mode = "preferred", position = "5360x-720", scale = 1, transform = 3 })

-- If you need to scale things like steam etc, uncomment:
-- hl.config({ xwayland = { force_zero_scaling = true } })
-- hl.env("GDK_SCALE", "1.25")
