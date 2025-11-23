#!/usr/bin/env bash

STATE=$(swaync-client -D)
if [ "$STATE" == "on" ]; then 
    notify-send "Do not disturb mode is OFF"
    swaync-client -d
else 
    swaync-client -d
    notify-send "Do not disturb mode is ON"
fi
