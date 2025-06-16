#!/bin/bash

# Wait until Hyprland registers monitors
until hyprctl monitors | grep -q "Monitor"; do
  sleep 0.1
done

# Start swww-daemon silently if not running
if ! pgrep -x swww-daemon > /dev/null; then
  swww-daemon > /dev/null 2>&1 &
  sleep 0.3
fi

# Set wallpaper with transition
swww img "$HOME/lib/images/wallpapers/_sort/ev-U-8pVp66LOQ-unsplash.jpg" \
  --transition-type grow \
  --transition-duration 1 \
  --transition-fps 60 &

