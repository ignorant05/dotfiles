-- float rule helper
local function float(match)
	hl.window_rule({
		match = match,
		float = true,
	})
end

-- 1. class only
local float_classes = {
	"^(vlc)$",
	"^(kvantummanager)$",
	"^(qt5ct)$",
	"^(qt6ct)$",
	"^(nwg-look)$",
	"^(org.kde.ark)$",
	"^(org.pulseaudio.pavucontrol)$",
	"^(blueman-manager)$",
	"^(nm-applet)$",
	"^(nm-connection-editor)$",
	"^(org.kde.polkit-kde-authentication-agent-1)$",
	"^(Signal)$",
	"^(com.github.rafostar.Clapper)$",
	"^(app.drey.Warp)$",
	"^(net.davidotek.pupgui2)$",
	"^(yad)$",
	"^(eog)$",
	"^(io.github.alainm23.planify)$",
	"^(io.gitlab.theevilskeleton.Upscaler)$",
	"^(com.github.unrud.VideoDownloader)$",
	"^(io.gitlab.adhami3310.Impression)$",
	"^(io.missioncenter.MissionCenter)$",
}

for _, class in ipairs(float_classes) do
	float({ class = class })
end

-- 2. title only
local float_titles = {
	"^(About Mozilla Firefox)$",
	"^(About LibreWolf)$",
	"^(About Opera)$",
}

for _, title in ipairs(float_titles) do
	float({ title = title })
end

-- 3. class + title
-- { class, title }
local float_class_title = {
	-- dolphin dialogs
	{ "^(org.kde.dolphin)$", "^(Progress Dialog — Dolphin)$" },
	{ "^(org.kde.dolphin)$", "^(Copying — Dolphin)$" },
}

-- browsers: Picture-in-Picture and Library windows
for _, class in ipairs({ "^(firefox)$", "^(brave)$", "^(librewolf)$", "^(opera)$" }) do
	table.insert(float_class_title, { class, "^(Picture-in-Picture)$" })
	table.insert(float_class_title, { class, "^(Library)$" })
end

-- terminals: system monitors
for _, class in ipairs({ "^(kitty)$", "^(alacritty)$" }) do
	for _, prog in ipairs({ "top", "btop", "htop" }) do
		table.insert(float_class_title, { class, "^(" .. prog .. ")$" })
	end
end

for _, r in ipairs(float_class_title) do
	float({ class = r[1], title = r[2] })
end

-- layerrule = blur,rofi
-- layerrule = ignorezero,rofi
-- layerrule = blur,notifications
-- layerrule = ignorezero,notifications
-- layerrule = blur,swaync-notification-window
-- layerrule = ignorezero,swaync-notification-window
-- layerrule = blur,swaync-control-center
-- layerrule = ignorezero,swaync-control-center
-- layerrule = blur,logout_dialog

local function opacity(match, active, inactive)
	hl.window_rule({
		match = match,
		opacity = active .. " " .. inactive,
	})
end

-- { class, active, inactive }
local by_class = {
	-- browsers
	{ "^(firefox)$", 0.95, 1 },
	{ "^(librewolf)$", 0.95, 1 },
	{ "^(opera)$", 0.95, 1 },
	{ "^(brave-browser)$", 0.95, 1 },

	-- code editors
	{ "^(code-oss)$", 0.80, 1 },
	{ "^([Cc]ode)$", 0.80, 1 },
	{ "^(code-url-handler)$", 0.80, 1 },
	{ "^(code-insiders-url-handler)$", 0.80, 1 },

	-- terminal / system apps
	{ "^(kitty)$", 0.95, 1 },
	{ "^(org.kde.dolphin)$", 0.80, 1 },
	{ "^(org.kde.ark)$", 0.80, 1 },
	{ "^(nwg-look)$", 0.80, 1 },
	{ "^(qt5ct)$", 0.80, 1 },
	{ "^(qt6ct)$", 0.80, 1 },
	{ "^(kvantummanager)$", 0.80, 1 },
	{ "^(org.pulseaudio.pavucontrol)$", 0.80, 1 },
	{ "^(blueman-manager)$", 0.80, 1 },
	{ "^(nm-applet)$", 0.80, 1 },
	{ "^(nm-connection-editor)$", 0.80, 1 },
	{ "^(org.kde.polkit-kde-authentication-agent-1)$", 0.80, 1 },
	{ "^(polkit-gnome-authentication-agent-1)$", 0.80, 1 },
	{ "^(org.freedesktop.impl.portal.desktop.gtk)$", 0.80, 1 },
	{ "^(org.freedesktop.impl.portal.desktop.hyprland)$", 0.80, 1 },

	-- steam / spotify
	{ "^([Ss]team)$", 0.70, 1 },
	{ "^(steamwebhelper)$", 0.70, 1 },
	{ "^([Ss]potify)$", 0.70, 1 },

	-- apps with the same value for active and inactive
	{ "^(com.github.rafostar.Clapper)$", 0.90, 0.90 }, -- Clapper
	{ "^(com.github.tchx84.Flatseal)$", 0.80, 0.80 }, -- Flatseal
	{ "^(hu.kramo.Cartridges)$", 0.80, 0.80 }, -- Cartridges
	{ "^(com.obsproject.Studio)$", 0.80, 0.80 }, -- OBS
	{ "^(gnome-boxes)$", 0.80, 0.80 }, -- Boxes
	{ "^(vesktop)$", 0.80, 0.80 }, -- Vesktop
	{ "^(discord)$", 0.80, 0.80 }, -- Discord
	{ "^(WebCord)$", 0.80, 0.80 }, -- WebCord
	{ "^(ArmCord)$", 0.80, 0.80 }, -- ArmCord
	{ "^(app.drey.Warp)$", 0.80, 0.80 }, -- Warp
	{ "^(net.davidotek.pupgui2)$", 0.80, 0.80 }, -- ProtonUp-Qt
	{ "^(yad)$", 0.80, 0.80 }, -- Protontricks
	{ "^(Signal)$", 0.80, 0.80 }, -- Signal
	{ "^(io.github.alainm23.planify)$", 0.80, 0.80 }, -- Planify
	{ "^(io.gitlab.theevilskeleton.Upscaler)$", 0.80, 0.80 }, -- Upscaler
	{ "^(com.github.unrud.VideoDownloader)$", 0.80, 0.80 }, -- VideoDownloader
	{ "^(io.gitlab.adhami3310.Impression)$", 0.80, 0.80 }, -- Impression
	{ "^(io.missioncenter.MissionCenter)$", 0.80, 0.80 }, -- MissionCenter
	{ "^(io.github.flattool.Warehouse)$", 0.80, 0.80 }, -- Warehouse
}

for _, r in ipairs(by_class) do
	-- BLUR_RULES_START
	-- opacity({ class = r[1] }, r[2], r[3])
	-- BLUR_RULES_END
	--
	-- OPAQUE_RULES_START
	opacity({ class = r[1] }, 1, 1)
	-- OPAQUE_RULES_END
end

-- matched by initial title instead of class
opacity({ initial_title = "^(Spotify Free)$" }, 0.70, 1)
opacity({ initial_title = "^(Spotify Premium)$" }, 0.70, 1)
