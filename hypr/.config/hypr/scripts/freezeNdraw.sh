#!/bin/bash

freeze &
FREEZE_PID=$!
sleep 0.3

grim - | swappy -f -

kill $FREEZE_PID 2>/dev/null
