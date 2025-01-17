#!/bin/bash

# Update package lists
pacman -Qqen > $HOME/dotfiles/packages/pacman.txt
pacman -Qqem > $HOME/dotfiles/packages/aur.txt
pacman -Qe | awk '{print $1 " # " $2}' > $HOMe/dotfiles/packages/packages-with-descriptions.txt

# Commit and push changes
git add .
git commit -m "Update dotfiles $(date +%Y-%m-%d)"
git push origin main
