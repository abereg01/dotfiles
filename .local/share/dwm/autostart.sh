#!/bin/bash

#nm-applet &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
# volumeicon &
dunst &
picom --experimental-backends &
feh --bg-fill $HOME/wallpapers/nord/ign_unsplash44.png &

#keybindings
sxhkd -c ~/.config/sxhkd/sxhkdrc &
