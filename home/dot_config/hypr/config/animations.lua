-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                        Animations                           ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

-- Bezier curves are now declared with hl.curve(); the two configurable control
-- points map to the old `bezier = name, x0, y0, x1, y1`.
hl.curve("overshot", { type = "bezier", points = { { 0.13, 0.99 }, { 0.29, 1.1 } } })

hl.config({
    animations = {
        enabled = true,
    },
})

-- old: animation = <leaf>, <enabled>, <speed>, <curve>, [<style>]
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 5, bezier = "default",  style = "popin 80%" })
hl.animation({ leaf = "border",        enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 6, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 6, bezier = "overshot", style = "slidefade 80%" })
