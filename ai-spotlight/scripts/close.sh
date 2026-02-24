#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WIDGET_DIR="$(dirname "$SCRIPT_DIR")"
EWW_DIR="$(dirname "$WIDGET_DIR")"
EWW_CMD="/usr/bin/eww -c $EWW_DIR"

$EWW_CMD close opencode_spotlight_closer
$EWW_CMD close opencode_spotlight
$EWW_CMD update ai_response=""
$EWW_CMD update show_models="false"
$EWW_CMD update attached_image=""
rm -f /tmp/opencode_screenshot.png
/usr/bin/hyprctl dispatch submap reset
