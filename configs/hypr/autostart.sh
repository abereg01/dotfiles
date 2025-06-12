#!/bin/sh

# Cursor
hyprctl setcursor left_ptr 24

# Wallpaper (swww)
swww init &
swww img /home/abe/lib/images/wallpapers/_sort/ev-U-8pVp66LOQ-unsplash.jpg &

# Services
dunst &
fusuma &
udiskie &
nm-applet &
polkit-kde-authentication-agent-1 &
waybar &
hyprsome &
