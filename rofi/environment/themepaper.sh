#!/usr/bin/env bash

WALLPAPERS="$HOME/Pictures/Wallpapers"
SETTER="$HOME/.config/hypr/scripts/themepapaer-switcher.sh"

cd "$WALLPAPERS" || exit

IFS=$'\n'

SELECTED=$(for wpp in *.jpg *.png; do echo -en "$wpp\0icon\x1f$wpp\n" ; done | rofi -dmenu -theme "$HOME/.config/rofi/environment/themepaper.rasi" $* -p)

if [ -n "$SELECTED" ]; then 
 "$SETTER" "$WALLPAPERS/$SELECTED"
 # sh -c "$SETTER $WALLPAPERS/$SELECTED"
fi

CWD="$(pwd)"

cd "$CWD" || exit
