#!/usr/bin/env bash
WALL="/home/abe/lib/images/wallpapers/_sort/ev-U-8pVp66LOQ-unsplash.jpg"
# 1) Set wallpaper
swww img "$WALL" --transition-type fade --transition-step 20
# 2) Generate Hyprland theme
matugen --wall "$WALL" --theme hyprland --format ini \
        --output ~/.config/hypr/colors.conf
# 3) Reload Hyprland (and any bars)
hyprctl reload
killall -SIGUSR1 waybar

