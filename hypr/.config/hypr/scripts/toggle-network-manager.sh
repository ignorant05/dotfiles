#!/usr/bin/env bash

wm=$HOME/.config/rofi/waybar/network/rofi-network-manager.sh

PID="$(pgrep -f "rofi-network-manager.sh")" 

if [ -n "$PID" ]; then 
    pkill -9 "$PID"
else
    sh -c "$wm" 
fi

