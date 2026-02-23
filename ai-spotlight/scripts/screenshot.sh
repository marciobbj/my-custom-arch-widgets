#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
EWW_DIR="$(dirname "$SCRIPT_DIR")"
EWW_CMD="/usr/bin/eww -c $EWW_DIR"
FILE="/tmp/opencode_screenshot.png"
rm -f "$FILE"

$EWW_CMD close opencode_spotlight_closer 2>/dev/null
$EWW_CMD close opencode_spotlight 2>/dev/null
/usr/bin/hyprctl dispatch submap reset 2>/dev/null

grim -g "$(slurp -b 00000088 -c 555555 -s 00000000 2>/dev/null)" "$FILE" 2>/dev/null

if [ -f "$FILE" ]; then
    $EWW_CMD update attached_image="$FILE"
else
    $EWW_CMD update attached_image=""
fi


"$SCRIPT_DIR/toggle.sh"
