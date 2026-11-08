-- Hyprland Nvidia Configuration
-- See https://wiki.hyprland.org/Nvidia/

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- If you want to try hardware cursors,
-- you can enable them by setting `cursor:no_hardware_cursors = false` ,
-- but it will require also enabling `cursor:allow_dumb_copy`
-- which may cause small to major hitches whenever the cursor shape changes.
-- If this is a problem on your system, keep hardware cursors disabled.

hl.env("NVD_BACKEND", "direct")

hl.env("GBM_BACKEND", "nvidia-drm")

hl.config({
	cursor = {
		no_hardware_cursors = true, -- Set to true to avoid hitches
	},
	-- cursor:allow_dumb_copy = true
	-- https://wiki.hyprland.org/Nvidia/#va-api-hardware-video-acceleration
	-- Hardware video acceleration on Nvidia and Wayland is
	-- possible with the nvidia-vaapi-driver.
	-- This may solve specific issues in Electron apps.
	-- https://wiki.hyprland.org/Nvidia/#regarding-environment-variables
	-- If you encounter crashes in Firefox, remove this line
	-- If you have a multi-GPU setup and you are facing lag in external monitor.
	-- See https://wiki.hyprland.org/Configuring/Multi-GPU/
})
