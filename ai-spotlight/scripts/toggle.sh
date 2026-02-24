#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WIDGET_DIR="$(dirname "$SCRIPT_DIR")"
EWW_DIR="$(dirname "$WIDGET_DIR")"
EWW_CMD="/usr/bin/eww -c $EWW_DIR"

"$SCRIPT_DIR/check_opencode.sh" || exit 1

source "$WIDGET_DIR/config.sh"

state=$($EWW_CMD active-windows | grep opencode_spotlight_closer)

if [[ -z "$state" ]]; then
    json=$("$SCRIPT_DIR/fetch_models.sh")
    $EWW_CMD update filtered_models="$json"
    $EWW_CMD update current_model="$DEFAULT_MODEL"
    $EWW_CMD update ai_response=""
    $EWW_CMD update show_models="false"
    $EWW_CMD open opencode_spotlight_closer
    $EWW_CMD open opencode_spotlight
    /usr/bin/hyprctl dispatch submap spotlight
else
    "$SCRIPT_DIR/close.sh"
fi
