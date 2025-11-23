# #!/usr/bin/env bash
#
# CONFIG="$HOME/.config/hypr/preferences/window-rules.conf"
#
# if grep -q "^windowrulev2 = opacity" "$CONFIG"; then
#     sed -i '/# OPACITY_RULES_START/,/# OPACITY_RULES_END/ s/^windowrulev2/#windowrulev2/' "$CONFIG"
#     notify-send "Hyprland" "Opacity rules disabled"
# else
#     sed -i '/# OPACITY_RULES_START/,/# OPACITY_RULES_END/ s/^#windowrulev2/windowrulev2/' "$CONFIG"
#     notify-send "Hyprland" "Opacity rules enabled"
# fi
#
# hyprctl reload

#!/usr/bin/env bash

CONFIG="$HOME/.config/hypr/preferences/window-rules.conf"

toggle_block() {
    local start="$1"
    local end="$2"
    # If there is at least one uncommented line in the block, comment all lines
    if sed -n "/$start/,/$end/ {/^[^#]/p}" "$CONFIG" | grep -q 'windowrulev2'; then
        # Comment all lines
        sed -i "/$start/,/$end/ s/^\(windowrulev2.*\)/#\1/" "$CONFIG"
    else
        # Uncomment all lines
        sed -i "/$start/,/$end/ s/^#\(windowrulev2.*\)/\1/" "$CONFIG"
    fi
}

toggle_block "# BLUR_RULES_START" "# BLUR_RULES_END"
toggle_block "# OPAQUE_RULES_START" "# OPAQUE_RULES_END"

notify-send "Hyprland" "Opacity rules toggled"
hyprctl reload
