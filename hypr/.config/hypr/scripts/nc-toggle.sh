#!/usr/bin/env bash 

if pgrep -x "swaync-client" > /dev/null
then 
    swaync-client -d -sw 
else 
    swaync-client -t -sw 
fi
