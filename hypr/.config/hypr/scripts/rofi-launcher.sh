#!/usr/bin/env bash
 
source "$HOME/.config/hypr/scripts/vars.sh"
confDir="${confDir}"

. "$HOME/.config/hypr/scripts/globalcontrol.sh"

rofi_style="$HOME/.config/rofi/styles/style_1.rasi"
rofi_config="$HOME/.config/rofi/styles/style_1.rasi"

rofi_args=(
    -show-icons
)

font_scale="${ROFI_LAUNCH_SCALE}"
[[ "${font_scale}" =~ ^[0-9]+$ ]] || font_scale=${ROFI_SCALE:-10}
# font_override="* {font: \"${font_name:-JetBrainsMono Nerd Font 11}\";}"

hypr_border=30
hypr_width=3
wind_border=30
# wind_border=$((hypr_border * 3))

r_override="window {border: ${hypr_width}px; border-radius: ${wind_border}px;} element {border-radius: ${elem_border:-5}px;}"

# Print debug information to verify everything
echo "rofi_mode: $rofi_mode"
echo "font_override: $font_override"
echo "r_override: $r_override"

case "${1}" in
d | --drun)
    rofi_mode="drun"
    rofi_args+=("--run-command" "sh -c 'uwsm app -- {cmd} || {cmd}'")
    ;;
w | --window)
    rofi_mode="window"
    ;;
f | --filebrowser)
    rofi_mode="filebrowser"
    ;;
r | --run)
    rofi_mode="run"
    rofi_args+=("--run-command" "sh -c 'uwsm app -- {cmd} || {cmd}'")
    ;;
h | --help)
    echo -e "$(basename "${0}") [action]"
    echo "d :  drun mode"
    echo "w :  window mode"
    echo "f :  filebrowser mode"
    echo "r :  run mode"
    exit 0
    ;;
*)
    rofi_mode="drun"
    ;;
esac

# Uncomment the next line if you're debugging the theme
# rofi -show "${rofi_mode}" -show-icons -config "${rofi_config}" -theme-str "${font_override}" -theme-str "${r_override}" -theme "${rofi_config}" -dump-theme

# Use the following if you just want to run rofi with the theme applied
rofi -show "${rofi_mode}" \
    -show-icons \
    -config "${rofi_config}" \
    -theme-str "${font_override}" \
    -theme-str "${r_override}" \
    -theme "${rofi_config}"
