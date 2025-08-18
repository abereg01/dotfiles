#!/usr/bin/env bash
set -euo pipefail
# Force US (index 0 in your us,se list) on all keyboards, then lock
mapfile -t kbs < <(hyprctl -j devices | jq -r '.keyboards[].name')
for kb in "${kbs[@]}"; do
  hyprctl switchxkblayout "$kb" 0 >/dev/null 2>&1 || true
done
exec hyprlock

