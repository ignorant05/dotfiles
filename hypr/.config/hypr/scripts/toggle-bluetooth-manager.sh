#!/usr/bin/env bash

bm=$HOME/.config/rofi/waybar/bluetooth/rofi-bluetooth.sh

PID="$(pgrep -f "rofi-bluetooth.sh")" 

if [ -n "$PID" ]; then 
    pkill -9 "$PID"
else
    sh -c "$bm" 
fi

