#!/usr/bin/env bash

# img="/tmp/blurred.png"
# PID="$(pgrep -x swayimg)"
#
# if [ -n "$PID" ]; then
#     echo "$PID" | xargs kill
# else 
#     grim "$img"
#     magick "$img" -blur 0x8 "$img"
#     swayimg "$img" --fullscreen --no-info --no-ui &
# fi

PID="$(pgrep -x yad)"

if [ -n "$PID" ]; then
    echo "$PID" | xargs kill
else
    yad --window-icon=none --no-buttons --undecorated --center \
        --text="" \
        --skip-taskbar \
        --on-top \
        --fullscreen \
        --borders=0 \
        --timeout=9999 \
        --timeout-indicator=none \
        --background="#000000"
fi
