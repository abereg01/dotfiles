#!/bin/bash

#nm-applet &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
#picom --config ~/.config/picom/picom.conf &
# volumeicon &
dunst &

feh --bg-center $HOME/wallpapers/mountain-landscape-scenery-4k-wallpaper-uhdpaper.com-574@0@f.jpg &

#keybindings
sxhkd -c ~/.config/suckless/sxhkd/sxhkdrc &
