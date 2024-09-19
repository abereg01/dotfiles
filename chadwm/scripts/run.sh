#!/bin/sh

xrdb merge ~/.Xresources 
xbacklight -set 10 &
feh --bg-fill $HOME/lib/images/wallpapers/colorscheme/current_theme &
xset r rate 200 50 &
#picom &
sxhkd & 
unclutter &

dash ~/.config/chadwm/scripts/bar.sh &
while type chadwm >/dev/null; do chadwm && continue || break; done
