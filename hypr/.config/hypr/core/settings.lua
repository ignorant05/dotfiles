hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

local CURSOR_THEME = "Bibata-Modern-Ice"
local CURSOR_SIZE = 30

local FONT = "Canterell"
local FONT_SIZE = 10
local DOCUMENT_FONT = "Cantarell"
local DOCUMENT_FONT_SIZE = 10
local MONOSPACE_FONT = "CaskaydiaCove Nerd Font Mono"
local MONOSPACE_FONT_SIZE = 9
local FONT_ANTIALIASING = "rgba"
local FONT_HINTING = "full"

hl.config({
	input = {
		kb_layout = "fr",
		kb_options = "caps:shiftlock",
		follow_mouse = 1,
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
		touchpad = {
			natural_scroll = false,
		},
	},
	-- https://wiki.hyprland.org/Configuring/Variables/#gestures
	-- Example per-device config
	-- See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
})
