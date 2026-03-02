#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WIDGET_DIR="$(dirname "$SCRIPT_DIR")"
EWW_DIR="$(dirname "$WIDGET_DIR")"
EWW_CMD="/usr/bin/eww -c $EWW_DIR"

$EWW_CMD close opencode_spotlight
$EWW_CMD update ai_response=""
$EWW_CMD update show_models="false"
$EWW_CMD update attached_image=""
rm -f /tmp/opencode_screenshot.png

# Restore focus to the window that was active before the widget opened
if [ -f /tmp/eww_prev_window ]; then
    PREV_WINDOW=$(cat /tmp/eww_prev_window)
    rm -f /tmp/eww_prev_window
    if [ -n "$PREV_WINDOW" ]; then
        hyprctl dispatch focuswindow "address:$PREV_WINDOW" 2>/dev/null
    fi
fi
