#!/usr/bin/env bash

PIDs="$(pgrep -x waybar)"

if [ -n "$PIDs" ]; then
    echo "$PIDs" | xargs kill
else
    waybar > /dev/null 2>&1 &
fi

