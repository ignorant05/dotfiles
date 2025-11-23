#!/usr/bin/env bash

if pgrep -x "swaync-client" > /dev/null
then 
    swaync-client -C -sw 
fi
