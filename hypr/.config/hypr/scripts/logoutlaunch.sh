#!/usr/bin/env bash

#// Check if wlogout is already running
if pgrep -x "wlogout" >/dev/null; then
    pkill -x "wlogout"
    exit 0
fi

#// ---- config you can tweak ----
confDir="${confDir:-$HOME/.config}"
wlogoutStyle="${1:-1}"          # pass a number as arg1 to pick a style, defaults to 1
BtnCol="${BtnCol:-white}"       # "white" for dark backgrounds, "black" for light
hypr_border="${hypr_border:-10}"
# --------------------------------

wLayout="${confDir}/wlogout/layout_${wlogoutStyle}"
wlTmplt="${confDir}/wlogout/style_${wlogoutStyle}.css"

echo "wlogoutStyle: ${wlogoutStyle}"
echo "wLayout: ${wLayout}"
echo "wlTmplt: ${wlTmplt}"

if [ ! -f "${wLayout}" ] || [ ! -f "${wlTmplt}" ]; then
    echo "ERROR: Config ${wlogoutStyle} not found, falling back to style 1..."
    wlogoutStyle=1
    wLayout="${confDir}/wlogout/layout_${wlogoutStyle}"
    wlTmplt="${confDir}/wlogout/style_${wlogoutStyle}.css"
fi

if [ ! -f "${wLayout}" ] || [ ! -f "${wlTmplt}" ]; then
    echo "ERROR: No valid wlogout layout/style found in ${confDir}/wlogout/"
    exit 1
fi

#// detect monitor res
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
raw_scale=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .scale')
# normalize to scale*100 as an integer, regardless of whether hyprctl prints
# it as "1", "1.0", or "1.500000"
hypr_scale=$(awk -v s="${raw_scale:-1}" 'BEGIN { printf "%d", (s * 100) }')
hypr_scale="${hypr_scale:-100}"   # safety fallback so we never divide by empty/0
[ "${hypr_scale}" -eq 0 ] && hypr_scale=100   # extra guard against div-by-zero

#// scale config layout and style
case "${wlogoutStyle}" in
1)
    wlColms=6
    export mgn=$((y_mon * 28 / hypr_scale))
    export hvr=$((y_mon * 23 / hypr_scale))
    ;;
2)
    wlColms=2
    export x_mgn=$((x_mon * 35 / hypr_scale))
    export y_mgn=$((y_mon * 25 / hypr_scale))
    export x_hvr=$((x_mon * 32 / hypr_scale))
    export y_hvr=$((y_mon * 20 / hypr_scale))
    ;;
*)
    wlColms=6
    ;;
esac

#// scale font size
export fntSize=$((y_mon * 2 / 100))

export BtnCol

#// eval hypr border radius
export active_rad=$((hypr_border * 5))
export button_rad=$((hypr_border * 8))

#// eval config file (substitute the exported vars into the css template)
wlStyle="$(envsubst <"${wlTmplt}")"

#// launch wlogout
wlogout -b "${wlColms}" -c 0 -r 0 -m 0 --layout "${wLayout}" --css <(echo "${wlStyle}") --protocol layer-shell
