#!/usr/bin/env bash
set -euo pipefail
COLOR_DIR="$HOME/dotfiles/theme/colors"

# Build list of themes
mapfile -t themes < <(find "$COLOR_DIR" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)
[[ ${#themes[@]} -gt 0 ]] || { notify-send "No themes found" "$COLOR_DIR"; exit 0; }

# Show Wofi dmenu
choice="$(printf '%s\n' "${themes[@]}" | wofi --dmenu -i -p 'Theme')"
[[ -z "${choice:-}" ]] && exit 0

# Apply
exec "$HOME/dotfiles/configs/colors/color" "$choice"
