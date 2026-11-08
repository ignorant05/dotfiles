# #!/usr/bin/env bash

CONFIG="$HOME/.config/hypr/preferences/window-rules.lua"

# true if the block has at least one active (uncommented) "opacity(" call
block_active() {
    sed -n "/$1/,/$2/p" "$CONFIG" | grep -qE '^[[:space:]]*opacity\('
}

comment_block() {
    sed -i --follow-symlinks -E "/$1/,/$2/ s/^([[:space:]]*)(opacity\()/\1-- \2/" "$CONFIG"
}

uncomment_block() {
    sed -i --follow-symlinks -E "/$1/,/$2/ s/^([[:space:]]*)--[[:space:]]?(opacity\()/\1\2/" "$CONFIG"
}

if block_active "BLUR_RULES_START" "BLUR_RULES_END"; then
    comment_block   "BLUR_RULES_START"   "BLUR_RULES_END"
    uncomment_block "OPAQUE_RULES_START" "OPAQUE_RULES_END"
    mode="opaque"
else
    uncomment_block "BLUR_RULES_START"   "BLUR_RULES_END"
    comment_block   "OPAQUE_RULES_START" "OPAQUE_RULES_END"
    mode="transparent"
fi

notify-send "Hyprland" "Opacity mode: $mode"
hyprctl reload
