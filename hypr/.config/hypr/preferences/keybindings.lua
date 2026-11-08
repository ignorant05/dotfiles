-- see https://wiki.hyprland.org/configuring/keywords/ for more
-- example binds, see https://wiki.hyprland.org/configuring/binds/ for more

-- Grouping of binds for easier management
--  $d=[Group Name|Subgroup Name1|Subgroup Name2|...]
-- '$d' is a variable that is used to group binds together (or use another variable)
-- This is only for organization purposes and is not a defined hyprland variable
-- What we did here is to modify the Description of the binds to include the group name
-- The $d will be parsed as a separate key to be use for a GUI or something pretty
-- [Main|Subgroup1|Subgroup2|...]
-- Main - The main groupname
-- Subgroup1.. - The subgroup names can be use to avoid repeating the same description

--*  Variables 
-- $mainMod = Super
-- " .. TERMINAL .. " = kitty
-- " .. BROWSER .. " = Brave
-- $OBSIDIAN = Obsidian
-- " .. NOTION .. " = Notion
-- " .. EXPLORER .. " = dolphin
-- $EDITOR = nvim
-- $PACKETTRACER = packettracer
--
local v = require("variables")

local HOME = v.HOME
local mainMod = v.mainMod
local scrDir = v.scrDir
local TERMINAL = v.TERMINAL
local BROWSER = v.BROWSER
local EXPLORER = v.EXPLORER
local DISCORD = v.DISCORD
local NOTION = v.NOTION

local wm = "Window Management"
local d = "[" .. wm .. "]"
hl.bind(
	mainMod .. " + Q",
	hl.dsp.exec_cmd("" .. scrDir .. "/dontkillsteam.sh"),
	{ description = d .. " close focused window" }
)
hl.bind(
	"ALT + F4",
	hl.dsp.exec_cmd("" .. scrDir .. "/dontkillsteam.sh"),
	{ description = d .. " close focused window" }
)
hl.bind(mainMod .. " + Delete", hl.dsp.exit(), { description = d .. " kill hyprland session" })
hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }), { description = d .. " toggle float" })
-- bindd = $mainMod, G, $d toggle group, togglegroup
hl.bind(
	"SHIFT + F11",
	hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
	{ description = d .. " toggle fullscreen" }
)
-- bindd = $mainMod, B, $d lock screen, exec, lockscreen.sh
hl.bind(
	mainMod .. " + SHIFT + F",
	hl.dsp.exec_cmd("" .. scrDir .. "/windowpin.sh"),
	{ description = d .. " toggle pin on focused window" }
)
hl.bind(
	mainMod .. " + N",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/logoutlaunch.sh 1"),
	{ description = d .. " logout menu" }
)
hl.bind(
	"Alt_R + Control_R",
	hl.dsp.exec_cmd("killall waybar || (env reload_flag=1 " .. scrDir .. "/wbarconfgen.sh)"),
	{ description = d .. " toggle waybar and reload config" }
)
-- bindd = Alt, F, $d freeze screen and draw on it, exec, " .. scrDir .. "/freezeNdraw.sh
hl.bind("ALT + F", hl.dsp.exec_cmd("wayscriber --freeze --no-resume-session"), { description = d .. " freeze" })
hl.bind("ALT + D", hl.dsp.exec_cmd("wayscriber -a"), { description = d .. " overlay" })

-- bindd = ALT_R, Control_R,toggle waybar, exec, killall waybar || waybar # toggle waybar without reloading, this is faster

local d = "[" .. wm .. "|Group Navigation]"
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.group.prev(), { description = d .. " change active group backwards" })
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.group.next(), { description = d .. " change active group forwards" })

local d = "[" .. wm .. "|Change focus]"
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.focus({ direction = "left" }), { description = d .. " focus left" })
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.focus({ direction = "right" }), { description = d .. " focus right" })
hl.bind(mainMod .. " + CONTROL + K", hl.dsp.focus({ direction = "up" }), { description = d .. " focus up" })
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.focus({ direction = "down" }), { description = d .. " focus down" })
-- bindd = Alt, TAB, $d focus , movefocus, d,

local d = "[" .. wm .. "|Resize Active Window]"
-- Resize windows
hl.bind(
	mainMod .. " + SHIFT + L",
	hl.dsp.window.resize({ x = 30, y = 0, relative = true }),
	{ repeating = true, description = d .. " resize window right" }
)
hl.bind(
	mainMod .. " + SHIFT + H",
	hl.dsp.window.resize({ x = -30, y = 0, relative = true }),
	{ repeating = true, description = d .. " resize window left" }
)
hl.bind(
	mainMod .. " + SHIFT + K",
	hl.dsp.window.resize({ x = 0, y = -30, relative = true }),
	{ repeating = true, description = d .. " resize window up" }
)
hl.bind(
	mainMod .. " + SHIFT + J",
	hl.dsp.window.resize({ x = 0, y = 30, relative = true }),
	{ repeating = true, description = d .. " resize  window down" }
)

-- Move active window around current workspace with mainMod + Shift + Control [←→↑↓]
local d = "[" .. wm .. "|Move active window across workspace]"
local moveactivewindow =
	'grep -q "true" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive'
hl.bind(
	mainMod .. " + SHIFT + CONTROL + H",
	hl.dsp.exec_cmd(moveactivewindow .. " -30 0 || hyprctl dispatch movewindow l"),
	{ repeating = true, description = "Move active window to the left" }
)
hl.bind(
	mainMod .. " + SHIFT + CONTROL + L",
	hl.dsp.exec_cmd(moveactivewindow .. " 30 0 || hyprctl dispatch movewindow r"),
	{ repeating = true, description = "Move active window to the right" }
)
hl.bind(
	mainMod .. " + SHIFT + CONTROL + K",
	hl.dsp.exec_cmd(moveactivewindow .. "  0 -30 || hyprctl dispatch movewindow u"),
	{ repeating = true, description = "Move active window up" }
)
hl.bind(
	mainMod .. " + SHIFT + CONTROL + J",
	hl.dsp.exec_cmd(moveactivewindow .. " 0 30 || hyprctl dispatch movewindow d"),
	{ repeating = true, description = "Move active window down" }
)

-- Move/Resize focused window
local d = "[" .. wm .. "|Move & Resize with mouse]"
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { description = d .. " hold to move window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { description = d .. " hold to resize window" })
hl.bind("ALT + Z", hl.dsp.window.drag(), { description = d .. " hold to move window" })
hl.bind(mainMod .. " + X", hl.dsp.window.resize(), { description = d .. " hold to resize window" })

-- Toggle waybar
local wl = "Toggle Waybar"
local waybarLauncher = scrDir .. "/toggle-waybar.sh"
hl.bind("CONTROL + ALT + D", hl.dsp.exec_cmd(waybarLauncher), { description = wl .. " Toggle Waybar" })

local toggler = scrDir .. "/outOfSight.sh"
hl.bind(mainMod .. " + CONTROL + F", hl.dsp.exec_cmd(toggler), { description = "$tape Toggle anti-prying-eyes" })

local d = "[Apps]"
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("" .. DISCORD .. ""), { description = d .. " discord" })

local d = "[Apps]"
-- bindd = $mainMod, F, $d obsidian, exec, $OBSIDIAN
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("" .. NOTION .. ""), { description = d .. " notion" })

local l = "Launcher"
local d = "[" .. l .. "|Apps]"
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("" .. TERMINAL .. ""), { description = d .. " terminal emulator" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("" .. EXPLORER .. ""), { description = d .. " file explorer" })
-- bindd = $mainMod, C, $d text editor , exec, $EDITOR
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("" .. BROWSER .. ""), { description = d .. " web browser" })
hl.bind(
	"CONTROL + SHIFT + Escape",
	hl.dsp.exec_cmd("" .. scrDir .. "/sysmonlaunch.sh"),
	{ description = d .. " system monitor" }
)

local spf = "/home/pebble/rnScripts/rnSPF.sh"
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(spf), { description = "" })

local d = "[" .. l .. "|Rofi menus]"
local rofilaunch = scrDir .. "/rofi-launcher.sh"
hl.bind(
	mainMod .. " + A",
	hl.dsp.exec_cmd("pkill -x rofi || " .. rofilaunch .. " d"),
	{ description = d .. " application finder" }
)
hl.bind(
	mainMod .. " + TAB",
	hl.dsp.exec_cmd("pkill -x rofi || " .. rofilaunch .. " w"),
	{ description = d .. " window switcher" }
)
hl.bind(
	mainMod .. " + SHIFT + E",
	hl.dsp.exec_cmd("pkill -x rofi || " .. rofilaunch .. " f"),
	{ description = d .. " file finder" }
)
hl.bind(
	mainMod .. " + slash",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrDir .. "/keybinds_hint.sh c"),
	{ description = d .. " keybindings hint" }
)
hl.bind(
	mainMod .. " + comma",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrDir .. "/emoji-picker.sh"),
	{ description = d .. " emoji  picker" }
)
hl.bind(
	mainMod .. " + period",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrDir .. "/glyph-picker.sh"),
	{ description = d .. " glyph picker" }
)
-- bindd = $mainMod, V, $d clipboard ,  exec, pkill -x rofi || " .. scrDir .. "/cliphist.sh -c # launch clipboard,
hl.bind(
	mainMod .. " + SHIFT + V",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrDir .. "/cliphist.sh"),
	{ description = d .. " clipboard manager" }
)
hl.bind(
	mainMod .. " + SHIFT + A",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrDir .. "/rofiselect.sh"),
	{ description = d .. " select rofi launcher" }
)

local d = "Notification Center"
local tnc = scrDir .. "/nc-toggle.sh"
local tdnd = scrDir .. "/nc-dnd-toggle.sh"
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(tnc), { description = d .. " toggle Notifications" })
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(tdnd), { description = d .. " toggle DND Mode" })
-- hl.bind(mainMod .. " + ?", hl.dsp.exec_cmd("swaync-client -C -sw"), { description = d .. " clear all" })

local b = "Bluetooth Manager"
hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd("pkill -x blueman-manager || blueman-manager"),
	{ description = b .. " toggle Bluetooth manager" }
)

local wifi = "WiFi Manager"
local wtog = scrDir .. "/toggle-network-manager.sh"
hl.bind(
	mainMod .. " + C",
	hl.dsp.exec_cmd("pkill -x rofi || " .. wtog),
	{ description = wifi .. " toggle wifi manager" }
)

local tpp = "Themepapaer Switcher"
local switcher = HOME .. "/.config/rofi/environment/themepaper.sh"
hl.bind(
	mainMod .. " + O",
	hl.dsp.exec_cmd("pkill -x rofi || " .. switcher),
	{ description = tpp .. " Theme-Wallpeper switcher" }
)

local ts = "Theme switcher"
local switch = HOME .. "/.config/hypr/scripts/themeswitcher.sh"
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(switch), { description = ts .. " Theme switcher" })

local ot = "Opacity Toggle"
local toggle = HOME .. "/.config/hypr/scripts/toggle-opacity.sh"
hl.bind("CONTROL + O", hl.dsp.exec_cmd(toggle), { description = ot .. " Opacity toggle" })

local hc = "Hardware Controls"
local d = "[" .. hc .. "|Audio]"
hl.bind(
	"F10",
	hl.dsp.exec_cmd("" .. scrDir .. "/volumecontrol.sh -o m"),
	{ locked = true, description = d .. " toggle mute output" }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("" .. scrDir .. "/volumecontrol.sh -o m"),
	{ locked = true, description = d .. "  toggle mute output" }
)
hl.bind(
	"F11",
	hl.dsp.exec_cmd("" .. scrDir .. "/volumecontrol.sh -o d"),
	{ locked = true, repeating = true, description = d .. " decrease volume" }
)
hl.bind(
	"F12",
	hl.dsp.exec_cmd("" .. scrDir .. "/volumecontrol.sh -o i"),
	{ locked = true, repeating = true, description = d .. " increase volume" }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("" .. scrDir .. "/volumecontrol.sh -i m"),
	{ locked = true, description = d .. " un/mute microphone" }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("" .. scrDir .. "/volumecontrol.sh -o d"),
	{ locked = true, repeating = true, description = d .. " decrease volume" }
)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("" .. scrDir .. "/volumecontrol.sh -o i"),
	{ locked = true, repeating = true, description = d .. " increase volume" }
)

hl.bind(
	"CONTROL + ampersand",
	hl.dsp.exec_cmd("" .. scrDir .. "/volumecontrol.sh -o m"),
	{ locked = true, description = d .. "  toggle mute output" }
)
hl.bind(
	"CONTROL + eacute",
	hl.dsp.exec_cmd("" .. scrDir .. "/volumecontrol.sh -o d"),
	{ locked = true, repeating = true, description = d .. " decrease volume" }
)
hl.bind(
	"CONTROL + quotedbl",
	hl.dsp.exec_cmd("" .. scrDir .. "/volumecontrol.sh -o i"),
	{ locked = true, repeating = true, description = d .. " increase volume" }
)
hl.bind(
	"CONTROL + apostrophe",
	hl.dsp.exec_cmd("" .. scrDir .. "/volumecontrol.sh -i m"),
	{ locked = true, description = d .. " un/mute microphone" }
)

local d = "[" .. hc .. "|Media]"
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = d .. " play media" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = d .. " pause media" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, description = d .. " next media" })
hl.bind(
	"XF86AudioPrev",
	hl.dsp.exec_cmd("playerctl previous"),
	{ locked = true, description = d .. "  previous media" }
)

local d = "[" .. hc .. "|Brightness]"
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("" .. scrDir .. "/brightnesscontrol.sh i"),
	{ locked = true, repeating = true, description = d .. " increase brightness" }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("" .. scrDir .. "/brightnesscontrol.sh d"),
	{ locked = true, repeating = true, description = d .. " decrease brightness" }
)
hl.bind(
	"CONTROL + parenleft",
	hl.dsp.exec_cmd("" .. scrDir .. "/brightnesscontrol.sh d"),
	{ locked = true, repeating = true, description = d .. " decrease brightness" }
)
hl.bind(
	"CONTROL + minus",
	hl.dsp.exec_cmd("" .. scrDir .. "/brightnesscontrol.sh i"),
	{ locked = true, repeating = true, description = d .. " increase brightness" }
)

local ut = "Utilities"
local d = "[" .. ut .. "]"
hl.bind(
	mainMod .. " + I",
	hl.dsp.exec_cmd("" .. scrDir .. "/keyboardswitch.sh"),
	{ locked = true, description = d .. " toggle keyboard layout" }
)
hl.bind(mainMod .. " + ALT + G", hl.dsp.exec_cmd("" .. scrDir .. "/gamemode.sh"), { description = d .. " game mode" })

local d = "[" .. ut .. "|Screen Capture]"
hl.bind("CONTROL + M", hl.dsp.exec_cmd("hyprpicker -an"), { description = d .. " color picker" })
-- Screenshot a window
hl.bind("CONTROL + p", hl.dsp.exec_cmd("hyprshot -m window"))
-- Screenshot a monitor
hl.bind("CONTROL + y", hl.dsp.exec_cmd("hyprshot -m output"))
-- Screenshot a region
hl.bind("CONTROL + u", hl.dsp.exec_cmd("hyprshot -m region"))

-- bindd  $mainMod, P, $d snip screen , exec, " .. scrDir .. "/screenshot.sh s # partial screenshot capture
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("grimshot"), { description = d .. " snip screen" })
hl.bind(
	mainMod .. " + CONTROL + P",
	hl.dsp.exec_cmd("" .. scrDir .. "/screenshot.sh sf"),
	{ description = d .. " freeze and snip screen" }
)
hl.bind(
	mainMod .. " + ALT + P",
	hl.dsp.exec_cmd("" .. scrDir .. "/screenshot.sh m"),
	{ locked = true, description = d .. " print monitor" }
)
hl.bind(
	"Print",
	hl.dsp.exec_cmd("" .. scrDir .. "/screenshot.sh p"),
	{ locked = true, description = d .. " print all monitors" }
)

local lock = "lock it out"
hl.bind("Control+Alt + F", hl.dsp.exec_cmd("hyprlock"), { description = lock .. " lockscreen" })

local rice = "Theming and Wallpaper"
local d = "[" .. rice .. "]"
hl.bind(
	mainMod .. " + ALT + Right",
	hl.dsp.exec_cmd("" .. scrDir .. "/wallpaper.sh -Gn"),
	{ description = d .. " next global wallpaper" }
)
hl.bind(
	mainMod .. " + ALT + Left",
	hl.dsp.exec_cmd("" .. scrDir .. "/wallpaper.sh -Gp"),
	{ description = d .. " previous global wallpaper" }
)
hl.bind(
	mainMod .. " + SHIFT + W",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrDir .. "/wallpaper.sh -SG"),
	{ description = d .. " select a global wallpaper" }
)
hl.bind(
	mainMod .. " + ALT + Up",
	hl.dsp.exec_cmd("" .. scrDir .. "/wbarconfgen.sh n"),
	{ description = d .. " next waybar layout" }
)
hl.bind(
	mainMod .. " + ALT + Down",
	hl.dsp.exec_cmd("" .. scrDir .. "/wbarconfgen.sh p"),
	{ description = d .. " previous waybar layout" }
)
hl.bind(
	mainMod .. " + SHIFT + R",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrDir .. "/wallbashtoggle.sh -m"),
	{ description = d .. " wallbash mode selector" }
)
hl.bind(
	mainMod .. " + SHIFT + T",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrDir .. "/themeselect.sh"),
	{ description = d .. " select a theme" }
)

-- Switch workspaces
local ws = "Workspaces"
local d = "[" .. ws .. "|Navigation]"
hl.bind(mainMod .. " + ampersand", hl.dsp.focus({ workspace = 1 }), { description = d .. " navigate to workspace 1" })
hl.bind(mainMod .. " + eacute", hl.dsp.focus({ workspace = 2 }), { description = d .. " navigate to workspace 2" })
hl.bind(mainMod .. " + quotedbl", hl.dsp.focus({ workspace = 3 }), { description = d .. " navigate to workspace 3" })
hl.bind(mainMod .. " + apostrophe", hl.dsp.focus({ workspace = 4 }), { description = d .. " navigate to workspace 4" })
hl.bind(mainMod .. " + parenleft", hl.dsp.focus({ workspace = 5 }), { description = d .. " navigate to workspace 5" })
hl.bind(mainMod .. " + minus", hl.dsp.focus({ workspace = 6 }), { description = d .. " navigate to workspace 6" })
hl.bind(mainMod .. " + egrave", hl.dsp.focus({ workspace = 7 }), { description = d .. " navigate to workspace 7" })
hl.bind(mainMod .. " + underscore", hl.dsp.focus({ workspace = 8 }), { description = d .. " navigate to workspace 8" })
hl.bind(mainMod .. " + ccedilla", hl.dsp.focus({ workspace = 9 }), { description = d .. " navigate to workspace 9" })
hl.bind(mainMod .. " + agrave", hl.dsp.focus({ workspace = 10 }), { description = d .. " navigate to workspace 10" })

local d = "[" .. ws .. "|Navigation|Relative workspace]"
hl.bind(
	mainMod .. " + L",
	hl.dsp.focus({ workspace = "r+1" }),
	{ description = d .. " change active workspace forwards" }
)
hl.bind(
	mainMod .. " + H",
	hl.dsp.focus({ workspace = "r-1" }),
	{ description = d .. " change active workspace backwards" }
)

local d = "[" .. ws .. "|Navigation]"
hl.bind(
	mainMod .. " + CONTROL + J",
	hl.dsp.focus({ workspace = "empty" }),
	{ description = d .. " navigate to the nearest empty workspace" }
)

-- Move focused window to a workspace
local d = "[" .. ws .. "|Move window to workspace]"
hl.bind(
	mainMod .. " + SHIFT + ampersand",
	hl.dsp.window.move({ workspace = 1 }),
	{ description = d .. " move to workspace 1" }
)
hl.bind(
	mainMod .. " + SHIFT + eacute",
	hl.dsp.window.move({ workspace = 2 }),
	{ description = d .. " move to workspace 2" }
)
hl.bind(
	mainMod .. " + SHIFT + quotedbl",
	hl.dsp.window.move({ workspace = 3 }),
	{ description = d .. " move to workspace 3" }
)
hl.bind(
	mainMod .. " + SHIFT + apostrophe",
	hl.dsp.window.move({ workspace = 4 }),
	{ description = d .. " move to workspace 4" }
)
hl.bind(
	mainMod .. " + SHIFT + parenleft",
	hl.dsp.window.move({ workspace = 5 }),
	{ description = d .. " move to workspace 5" }
)
hl.bind(
	mainMod .. " + SHIFT + minus",
	hl.dsp.window.move({ workspace = 6 }),
	{ description = d .. " move to workspace 6" }
)
hl.bind(
	mainMod .. " + SHIFT + egrave",
	hl.dsp.window.move({ workspace = 7 }),
	{ description = d .. " move to workspace 7" }
)
hl.bind(
	mainMod .. " + SHIFT + underscore",
	hl.dsp.window.move({ workspace = 8 }),
	{ description = d .. " move to workspace 8" }
)
hl.bind(
	mainMod .. " + SHIFT + ccedilla",
	hl.dsp.window.move({ workspace = 9 }),
	{ description = d .. " move to workspace 9" }
)
hl.bind(
	mainMod .. " + SHIFT + agrave",
	hl.dsp.window.move({ workspace = 10 }),
	{ description = d .. " move to workspace 10" }
)

-- Move focused window to a relative workspace
local d = "[" .. ws .. "]"
hl.bind(
	mainMod .. " + Control+Alt + L",
	hl.dsp.window.move({ workspace = "r+1" }),
	{ description = d .. " move window to next relative workspace" }
)
hl.bind(
	mainMod .. " + Control+Alt + H",
	hl.dsp.window.move({ workspace = "r-1" }),
	{ description = d .. " move window to previous relative workspace" }
)

-- Scroll through existing workspaces
local d = "[" .. ws .. "|Navigation]"
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = d .. " next workspace" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = d .. " previous workspace" })

-- Move/Switch to special workspace (scratchpad)
local d = "[" .. ws .. "|Navigation|Special workspace]"
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("scratchpad"), { description = d .. " move to scratchpad" })
hl.bind("ALT + S", hl.dsp.exec_cmd("scratchpad -g"), { description = d .. " get from scratchpad" })
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("scratchpad -l -g"), { description = d .. " get list scratchpad" })

-- bindd = $mainMod Alt, S, $d move to scratchpad (silent) , movetoworkspacesilent, special
-- bindd = $mainMod, S, $d toggle scratchpad ,  togglespecialworkspace

-- Move focused window to a workspace silently
local d = "[" .. ws .. "|Navigation|Move window silently]"
hl.bind(
	mainMod .. " + CONTROL + ampersand",
	hl.dsp.window.move({ workspace = 1, follow = false }),
	{ description = d .. " move to workspace 1  (silent)" }
)
hl.bind(
	mainMod .. " + CONTROL + eacute",
	hl.dsp.window.move({ workspace = 2, follow = false }),
	{ description = d .. " move to workspace 2  (silent)" }
)
hl.bind(
	mainMod .. " + CONTROL + quotedbl",
	hl.dsp.window.move({ workspace = 3, follow = false }),
	{ description = d .. " move to workspace 3  (silent)" }
)
hl.bind(
	mainMod .. " + CONTROL + apostrophe",
	hl.dsp.window.move({ workspace = 4, follow = false }),
	{ description = d .. " move to workspace 4  (silent)" }
)
hl.bind(
	mainMod .. " + CONTROL + parenleft",
	hl.dsp.window.move({ workspace = 5, follow = false }),
	{ description = d .. " move to workspace 5  (silent)" }
)
hl.bind(
	mainMod .. " + CONTROL + minus",
	hl.dsp.window.move({ workspace = 6, follow = false }),
	{ description = d .. " move to workspace 6  (silent)" }
)
hl.bind(
	mainMod .. " + CONTROL + egrave",
	hl.dsp.window.move({ workspace = 7, follow = false }),
	{ description = d .. " move to workspace 7  (silent)" }
)
hl.bind(
	mainMod .. " + CONTROL + underscore",
	hl.dsp.window.move({ workspace = 8, follow = false }),
	{ description = d .. " move to workspace 8  (silent)" }
)
hl.bind(
	mainMod .. " + CONTROL + ccedilla",
	hl.dsp.window.move({ workspace = 9, follow = false }),
	{ description = d .. " move to workspace 9  (silent)" }
)
hl.bind(
	mainMod .. " + ALT + agrave",
	hl.dsp.window.move({ workspace = 10, follow = false }),
	{ description = d .. " move to workspace 10 (silent)" }
)
