#!/usr/bin/env bash


PID="$(pgrep -f "nwg-look")"
echo "$PID"

if [ -n "$PID" ]; then
    pkill nwg-look
else 
    nwg-look
fi

