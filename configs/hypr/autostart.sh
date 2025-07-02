#!/bin/sh

# Cursor
hyprctl setcursor left_ptr 24

# Wallpaper (swww)
exec-once: swww init
exec: swww img /home/abe/lib/images/wallpapers/_sort/ev-U-8pVp66LOQ-unsplash.jpg &

split-monitor-workspaces &

# Services
swww-daemon &
dunst &
fusuma &
udiskie &
nm-applet &
polkit-kde-authentication-agent-1 &
waybar &

