#!/bin/bash

# Install official packages
sudo pacman -S --needed - < $HOME/dotfiles/packages/pacman.txt

# Install AUR packages
yay -S --needed - < $HOME/dotfiles/packages/aur.txt

#Install fonts
yay -S --needed - < $HOME/dotfiles/packages/fonts.txt

# Stow configurations
cd configs || exit 1
for dir in */; do
    stow -v -R -t ~/.config "${dir%/}"
done
