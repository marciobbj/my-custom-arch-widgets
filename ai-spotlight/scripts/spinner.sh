#!/bin/bash
FRAMES=("󰪡" "󰪢" "󰪣" "󰪤" "󰪥" "󰪦" "󰪧" "󰪨")
STATE_FILE="/tmp/eww_spinner_frame"

if [ ! -f "$STATE_FILE" ]; then
    echo "0" > "$STATE_FILE"
fi

current=$(cat "$STATE_FILE")
next=$(( (current + 1) % ${#FRAMES[@]} ))
echo "$next" > "$STATE_FILE"
echo "${FRAMES[$current]}"
