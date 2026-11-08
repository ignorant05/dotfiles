-- ~/.config/hypr/variables.lua
local HOME = os.getenv("HOME")
local conDir = HOME .. "/.config"
local keyconfDir = conDir .. "/hypr"

local M = {
	-- paths
	HOME = HOME,
	conDir = conDir,
	keyconfDir = keyconfDir,
	prefs = keyconfDir .. "/preferences",
	core = keyconfDir .. "/core",
	env = keyconfDir .. "/environment",
	animations = keyconfDir .. "/animations",
	decorations = keyconfDir .. "/decorations",
	scrDir = keyconfDir .. "/scripts",
	waybar_dir = conDir .. "/waybar",
	rofi = conDir .. "/rofi",

	-- keybindings
	mainMod = "SUPER",
	TERMINAL = "kitty",
	BROWSER = "export LANGUAGE=eng ; brave",
	EXPLORER = "dolphin",
	EDITOR = "nvim",
	DISCORD = "discord",
	OBSIDIAN = "obsidian",
	NOTION = "notion-app",
}

return M
