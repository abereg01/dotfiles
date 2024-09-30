#!/bin/bash

MONITOR="DP-1-2"  # Replace with your monitor name

while true; do
    # Check if the monitor is "disconnected"
    if ! xrandr | grep "^$MONITOR connected"; then
        # Force the output to stay active
        xrandr --output $MONITOR --auto
    fi
    sleep 5
done

