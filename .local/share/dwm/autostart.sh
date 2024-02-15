#!/bin/bash

#nm-applet &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
# volumeicon &
unclutter &
dunst &
picom --experimental-backends & 
udiskie &
feh --bg-fill $HOME/wallpapers/flowers.jpeg &

#keybindings
sxhkd -c $HOME/dotfiles/.config/sxhkd/sxhkdrc &
