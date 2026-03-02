#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WIDGET_DIR="$(dirname "$SCRIPT_DIR")"
EWW_DIR="$(dirname "$WIDGET_DIR")"
EWW_CMD="/usr/bin/eww -c $EWW_DIR"

"$SCRIPT_DIR/check_opencode.sh" || exit 1

source "$WIDGET_DIR/config.sh"

state=$($EWW_CMD active-windows | grep opencode_spotlight)

if [[ -z "$state" ]]; then
    PREV_WINDOW=$(hyprctl activewindow -j 2>/dev/null | grep -o '"address": *"[^"]*"' | head -1 | grep -o '"0x[^"]*"' | tr -d '"')
    echo "$PREV_WINDOW" > /tmp/eww_prev_window

    json=$("$SCRIPT_DIR/fetch_models.sh")
    $EWW_CMD update ai_response=""
    $EWW_CMD update show_models="false"
    $EWW_CMD open opencode_spotlight
    sleep 0.1
    $EWW_CMD update filtered_models="$json"
    $EWW_CMD update current_model="$DEFAULT_MODEL"
else
    "$SCRIPT_DIR/close.sh"
fi
