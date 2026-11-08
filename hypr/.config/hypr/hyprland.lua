------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Sourcing
------------------------------------------------------------------------------------------------------------------------------------------------------------
local hypr = os.getenv("HOME") .. "/.config/hypr"
package.path = hypr .. "/?.lua;" .. hypr .. "/?/init.lua;" .. package.path
require("variables")
require("environment.env")
require("decorations.decorations")
require("animations")
require("core.layout")
require("core.nvidia")
require("core.autostart")
require("core.settings")
require("preferences.monitors")
require("preferences.keybindings")
require("preferences.window-rules")
-- Startup
------------------------------------------------------------------------------------------------------------------------------------------------------------
require("colors")
------------------------------------------------------------------------------------------------------------------------------------------------------------

hl.on("hyprland.start", function()
	hl.exec_cmd('sh -c "$HOME/.config/hypr/scripts/themepapaer-switcher.sh"')
	hl.exec_cmd("hypridle")
	hl.exec_cmd("$scrDir/launch-waybar.sh")
end)

hl.on("config.reloaded", function()
	hl.exec_cmd("~/.config/matugen/config.toml")
	hl.exec_cmd("swaync")
end)
