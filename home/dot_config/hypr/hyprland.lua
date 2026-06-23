-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃              CachyOS Hyprland Configuration (Lua)           ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
--
-- Migrated from hyprlang (.conf) to Lua. Since Hyprland 0.55 hyprlang is
-- deprecated; see https://wiki.hypr.land/Configuring/Start/
--
-- Each require() is its own protected scope: an error in one file will not
-- abort the others.

require("config/environment")
require("config/variables")
require("config/decorations")
require("config/input")
require("config/animations")
require("config/monitor")
require("config/windowrules")
require("config/keybinds")
require("config/autostart")
