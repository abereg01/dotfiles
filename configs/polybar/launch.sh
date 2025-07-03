#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

sleep 0.1
if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        export MONITOR=$m 
        polybar -q main -c "$HOME"/.config/polybar/polybar.ini &
    done
else
    polybar -q main -c "$HOME"/.config/polybar/polybar.ini &
fi
