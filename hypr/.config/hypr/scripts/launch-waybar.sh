#!/bin/bash

source "$HOME/.config/hypr/scripts/vars.sh"

conf_file="$HOME/.config/waybar/config.jsonc"

killall waybar
waybar -c "$conf_file" &
