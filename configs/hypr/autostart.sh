#!/bin/sh
hyprctl setcursor left_ptr 24

# Wallpaper daemon
swww-daemon &

# Services
udiskie &
nm-applet &
polkit-kde-authentication-agent-1 &
swaync &
waybar &
hypridle &

