#!/bin/bash

# Set error handling
set -euo pipefail

# Function to start a program if it's installed
start_if_installed() {
    if command -v "$1" >/dev/null 2>&1; then
        "$@" &
    else
        echo "Warning: $1 is not installed. Skipping."
    fi
}

# Function to set wallpaper
set_wallpaper() {
    local wallpaper="$HOME/wallpapers/flowers.jpeg"
    if [ -f "$wallpaper" ]; then
        feh --no-fehbg --bg-fill "$wallpaper"
    else
        echo "Warning: Wallpaper not found at $wallpaper"
    fi
}

# Load X resources
xrdb -merge "$HOME/.Xresources"

# Set backlight
start_if_installed xbacklight -set 10

# Start policy kit agent
start_if_installed /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1

# Start various background services
start_if_installed unclutter
start_if_installed dunst
start_if_installed picom --experimental-backends
start_if_installed udiskie

# Set wallpaper
set_wallpaper

# Start browsers
start_if_installed brave-browser
start_if_installed google-chrome

# Start status bar
if [ -f "$HOME/dotfiles/scripts/bar.sh" ]; then
    dash "$HOME/dotfiles/scripts/bar.sh" &
else
    echo "Warning: bar.sh not found"
fi

# Start key bindings
if [ -f "$HOME/dotfiles/.config/sxhkd/sxhkdrc" ]; then
    start_if_installed sxhkd -c "$HOME/dotfiles/.config/sxhkd/sxhkdrc"
else
    echo "Warning: sxhkdrc not found"
fi

# Start window manager
while type dwm >/dev/null; do 
    dwm && continue || break
done
