#!/bin/bash

xrdb merge $HOME/.Xresources
xbacklight -set 10 &
#nm-applet &
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
# volumeicon &
unclutter &
dunst &
picom --experimental-backends & 
udiskie &
feh --bg-fill $HOME/wallpapers/flowers.jpeg &
brave-browser &
google-chrome &

dash $HOME/dotfiles/scripts/bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done

#keybindings
sxhkd -c $HOME/dotfiles/.config/sxhkd/sxhkdrc &
