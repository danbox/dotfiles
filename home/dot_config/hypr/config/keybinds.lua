-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                         Keybinds                            ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
-- https://wiki.hypr.land/Configuring/Basics/Binds/
--
-- Old bind flags map to the flags table:
--   bindd  -> { description = "..." }
--   bindel -> { repeating = true, locked = true }   (e = repeat, l = locked)
--   bindm  -> { mouse = true }

local vars = require("config/vars")
local mod = "SUPER"

-- https://wiki.hypr.land/Configuring/Basics/Binds/ (config section)
hl.config({
    binds = {
        allow_workspace_cycles = true, -- was 1
        -- workspace_back_and_forth = true,
        workspace_center_on = 1,
        movefocus_cycles_fullscreen = true,
        window_direction_monitor_fallback = true,
    },
})

-- ======= Core =======
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(vars.terminal), { description = "Opens your preferred terminal emulator" })
-- hl.bind(mod .. " + E", hl.dsp.exec_cmd(vars.filemanager), { description = "Opens your preferred filemanager" })
hl.bind(mod .. " + A", hl.dsp.exec_cmd(vars.capturing), { description = "Screen capture selection" })
hl.bind(mod .. " + CTRL + Q", hl.dsp.window.close(), { description = "Closes (not kill) current window" })
hl.bind(mod .. " + SHIFT + M", hl.dsp.exec_cmd([[loginctl terminate-user ""]]), { description = "Exits Hyprland by terminating the user session" })

hl.bind(mod .. " + C", hl.dsp.window.float({ action = "toggle" }), { description = "Switches current window between floating and tiling mode" })

hl.bind(mod .. " + D", hl.dsp.exec_cmd(vars.applauncher), { description = "Runs your application launcher" })
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }), { description = "Toggles current window fullscreen mode" })
hl.bind(mod .. " + V", hl.dsp.layout("togglesplit"), { description = "Toggle current window split direction" })

-- ======= Grouping Windows =======
hl.bind(mod .. " + K", hl.dsp.group.toggle(), { description = "Toggles current window group mode" })
hl.bind(mod .. " + Tab", hl.dsp.group.next(), { description = "Switches to the next window in the group" })

-- ======= Toggle Gaps =======
-- (was `exec, hyprctl --batch keyword ...`; done directly via hl.config now)
hl.bind(mod .. " + SHIFT + G", function()
    hl.config({ general = { gaps_out = 5, gaps_in = 3 } })
end, { description = "Set CachyOS default gaps" })
hl.bind(mod .. " + G", function()
    hl.config({ general = { gaps_out = 0, gaps_in = 0 } })
end, { description = "Remove gaps between window" })

-- ======= Volume Control =======
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd([==[pactl set-sink-volume @DEFAULT_SINK@ +5% && pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | awk '{if($1>100) system("pactl set-sink-volume @DEFAULT_SINK@ 100%")}' && pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | awk '{print $1}' | head -1 > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob]==]), { repeating = true, locked = true, description = "Raise Volume" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd([==[pactl set-sink-volume @DEFAULT_SINK@ -5% && pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | awk '{print $1}' | head -1 > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob]==]), { repeating = true, locked = true, description = "Lower Volume" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd([==[amixer sset Master toggle | sed -En '/\[on\]/ s/.*\[([0-9]+)%\].*/\1/ p; /\[off\]/ s/.*/0/p' | head -1 > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob]==]), { repeating = true, locked = true, description = "Mutes player audio" })

-- ======= Playback Control =======
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { description = "Toggles play/pause" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { description = "Next track" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { description = "Previous track" })

-- ======= Screen Brightness =======
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s +5%"), { repeating = true, locked = true, description = "Increases brightness 5%" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { repeating = true, locked = true, description = "Decreases brightness 5%" })
hl.bind(mod .. " + SHIFT + P", hl.dsp.exec_cmd("gnome-calculator"), { description = "Runs the calculator application" })
-- hl.bind(mod .. " + L", hl.dsp.exec_cmd("swaylock-fancy -e -K -p 10 -f Hack-Regular"), { description = "Lock the screen" })
hl.bind(mod .. " + O", hl.dsp.exec_cmd("killall -SIGUSR2 waybar"), { description = "Reload/restarts Waybar" })

-- ======= Window Actions =======
-- Move window towards a direction
hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }), { description = "Move active window to the left" })
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }), { description = "Move active window to the right" })
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }), { description = "Move active window upwards" })
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }), { description = "Move active window downwards" })

-- Move focus with mainMod + arrow keys
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "l" }), { description = "Move focus to the left" })
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "r" }), { description = "Move focus to the right" })
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "u" }), { description = "Move focus upwards" })
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "d" }), { description = "Move focus downwards" })

-- Quick resize window with keyboard
hl.bind(mod .. " + CTRL + SHIFT + right", hl.dsp.window.resize({ x = 15, y = 0, relative = true }), { description = "Resize to the right" })
hl.bind(mod .. " + CTRL + SHIFT + left", hl.dsp.window.resize({ x = -15, y = 0, relative = true }), { description = "Resize to the left" })
hl.bind(mod .. " + CTRL + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -15, relative = true }), { description = "Resize upwards" })
hl.bind(mod .. " + CTRL + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 15, relative = true }), { description = "Resize downwards" })
hl.bind(mod .. " + CTRL + SHIFT + l", hl.dsp.window.resize({ x = 15, y = 0, relative = true }), { description = "Resize to the right" })
hl.bind(mod .. " + CTRL + SHIFT + h", hl.dsp.window.resize({ x = -15, y = 0, relative = true }), { description = "Resize to the left" })
hl.bind(mod .. " + CTRL + SHIFT + k", hl.dsp.window.resize({ x = 0, y = -15, relative = true }), { description = "Resize upwards" })
hl.bind(mod .. " + CTRL + SHIFT + j", hl.dsp.window.resize({ x = 0, y = 15, relative = true }), { description = "Resize downwards" })

-- Move / resize window with mouse drag
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize the window towards a direction" })
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag window" })

-- Move active window to a workspace with mainMod + CTRL + [0-9]
hl.bind(mod .. " + CTRL + 1", hl.dsp.window.move({ workspace = 1, follow = true }), { description = "Move window and switch to workspace 1" })
hl.bind(mod .. " + CTRL + 2", hl.dsp.window.move({ workspace = 2, follow = true }), { description = "Move window and switch to workspace 2" })
hl.bind(mod .. " + CTRL + 3", hl.dsp.window.move({ workspace = 3, follow = true }), { description = "Move window and switch to workspace 3" })
hl.bind(mod .. " + CTRL + 4", hl.dsp.window.move({ workspace = 4, follow = true }), { description = "Move window and switch to workspace 4" })
hl.bind(mod .. " + CTRL + 5", hl.dsp.window.move({ workspace = 5, follow = true }), { description = "Move window and switch to workspace 5" })
hl.bind(mod .. " + CTRL + 6", hl.dsp.window.move({ workspace = 6, follow = true }), { description = "Move window and switch to workspace 6" })
hl.bind(mod .. " + CTRL + 7", hl.dsp.window.move({ workspace = 7, follow = true }), { description = "Move window and switch to workspace 7" })
hl.bind(mod .. " + CTRL + 8", hl.dsp.window.move({ workspace = 8, follow = true }), { description = "Move window and switch to workspace 8" })
hl.bind(mod .. " + CTRL + 9", hl.dsp.window.move({ workspace = 9, follow = true }), { description = "Move window and switch to workspace 9" })
hl.bind(mod .. " + CTRL + 0", hl.dsp.window.move({ workspace = 10, follow = true }), { description = "Move window and switch to workspace 10" })
hl.bind(mod .. " + CTRL + left", hl.dsp.window.move({ workspace = "-1", follow = true }), { description = "Move window and switch to the next workspace" })
hl.bind(mod .. " + CTRL + right", hl.dsp.window.move({ workspace = "+1", follow = true }), { description = "Move window and switch to the previous workspace" })

-- Same as above, but doesn't switch to the workspace (silent)
hl.bind(mod .. " + SHIFT + q", hl.dsp.window.move({ workspace = 1, follow = false }), { description = "Move window silently to workspace 1" })
hl.bind(mod .. " + SHIFT + w", hl.dsp.window.move({ workspace = 2, follow = false }), { description = "Move window silently to workspace 2" })
hl.bind(mod .. " + SHIFT + e", hl.dsp.window.move({ workspace = 3, follow = false }), { description = "Move window silently to workspace 3" })
hl.bind(mod .. " + SHIFT + r", hl.dsp.window.move({ workspace = 4, follow = false }), { description = "Move window silently to workspace 4" })
hl.bind(mod .. " + SHIFT + t", hl.dsp.window.move({ workspace = 5, follow = false }), { description = "Move window silently to workspace 5" })
hl.bind(mod .. " + SHIFT + y", hl.dsp.window.move({ workspace = 6, follow = false }), { description = "Move window silently to workspace 6" })
hl.bind(mod .. " + SHIFT + u", hl.dsp.window.move({ workspace = 7, follow = false }), { description = "Move window silently to workspace 7" })
hl.bind(mod .. " + SHIFT + i", hl.dsp.window.move({ workspace = 8, follow = false }), { description = "Move window silently to workspace 8" })
hl.bind(mod .. " + SHIFT + o", hl.dsp.window.move({ workspace = 9, follow = false }), { description = "Move window silently to workspace 9" })
hl.bind(mod .. " + SHIFT + p", hl.dsp.window.move({ workspace = 10, follow = false }), { description = "Move window silently to workspace 10" })

-- ======= Workspace Actions =======
-- Switch workspaces with mainMod + [0-9]
hl.bind(mod .. " + q", hl.dsp.focus({ workspace = 1 }), { description = "Switch to workspace 1" })
hl.bind(mod .. " + w", hl.dsp.focus({ workspace = 2 }), { description = "Switch to workspace 2" })
hl.bind(mod .. " + e", hl.dsp.focus({ workspace = 3 }), { description = "Switch to workspace 3" })
hl.bind(mod .. " + r", hl.dsp.focus({ workspace = 4 }), { description = "Switch to workspace 4" })
hl.bind(mod .. " + t", hl.dsp.focus({ workspace = 5 }), { description = "Switch to workspace 5" })
hl.bind(mod .. " + y", hl.dsp.focus({ workspace = 6 }), { description = "Switch to workspace 6" })
hl.bind(mod .. " + u", hl.dsp.focus({ workspace = 7 }), { description = "Switch to workspace 7" })
hl.bind(mod .. " + i", hl.dsp.focus({ workspace = 8 }), { description = "Switch to workspace 8" })
hl.bind(mod .. " + o", hl.dsp.focus({ workspace = 9 }), { description = "Switch to workspace 9" })
hl.bind(mod .. " + p", hl.dsp.focus({ workspace = 10 }), { description = "Switch to workspace 10" })

-- Scroll through existing workspaces
hl.bind(mod .. " + PERIOD", hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll through workspaces incrementally" })
hl.bind(mod .. " + COMMA", hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll through workspaces decrementally" })
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll through workspaces incrementally" })
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll through workspaces decrementally" })
hl.bind(mod .. " + slash", hl.dsp.focus({ workspace = "previous" }), { description = "Switch to the previous workspace" })

-- Special workspaces (scratchpads)
hl.bind(mod .. " + minus", hl.dsp.window.move({ workspace = "special", follow = true }), { description = "Move active window to Special workspace" })
hl.bind(mod .. " + equal", hl.dsp.workspace.toggle_special("special"), { description = "Toggles the Special workspace" })
hl.bind(mod .. " + F1", hl.dsp.workspace.toggle_special("scratchpad"), { description = "Call special workspace scratchpad" })
hl.bind(mod .. " + ALT + SHIFT + F1", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }), { description = "Move active window to special workspace scratchpad" })
