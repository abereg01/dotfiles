#!/usr/bin/env bash
set -euo pipefail

# Ensure order is present and US is first
hyprctl keyword input:kb_layout "us,se" >/dev/null 2>&1 || true

# read current layout from the first keyboard that actually reports a keymap
cur="$(hyprctl -j devices | jq -r '.keyboards[] | select(.active_keymap != null and .active_keymap != "") | .active_keymap' \
      | head -n1 | awk "{print tolower(\$1)}")"
cur="${cur%% *}"    # normalize: "se (Sweden)" -> "se"

# decide target
if [[ "$cur" == "se" ]]; then
  idx=0; note_title="Keyboard Layout"; note_text="Switched to English (us)"
else
  idx=1; note_title="Tangentbordslayout"; note_text="Bytte till Svenska (se)"
fi

# apply to all keyboards by index in the us,se order
mapfile -t kbs < <(hyprctl -j devices | jq -r '.keyboards[].name')
for kb in "${kbs[@]}"; do
  hyprctl switchxkblayout "$kb" "$idx" >/dev/null 2>&1 || true
done

# verify and show the actual result
new="$(hyprctl -j devices | jq -r '.keyboards[] | select(.active_keymap != null and .active_keymap != "") | .active_keymap' \
      | head -n1 | awk "{print tolower(\$1)}")"
new="${new%% *}"
if command -v notify-send >/dev/null 2>&1; then
  if [[ "$new" == "se" ]]; then
    notify-send "Tangentbordslayout" "Bytte till Svenska (se)"
  else
    notify-send "Keyboard Layout" "Switched to English (us)"
  fi
fi

