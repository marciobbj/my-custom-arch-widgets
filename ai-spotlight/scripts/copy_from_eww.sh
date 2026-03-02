#!/usr/bin/env bash
# Copy current ai_response from eww to the system clipboard
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WIDGET_DIR="$(dirname "$SCRIPT_DIR")"
EWW_DIR="$(dirname "$WIDGET_DIR")"
EWW_CMD="/usr/bin/eww -c $EWW_DIR"

RESPONSE=$($EWW_CMD get ai_response)

if [ -z "$RESPONSE" ]; then
  exit 0
fi

# Decode escape sequences encoded by ask.sh (\n → newline, \" → ")
RESPONSE=$(printf "%s" "$RESPONSE" | sed 's/\\n/\n/g; s/\\"/"/g')

# Try wl-copy, xclip, then xsel
if command -v wl-copy >/dev/null 2>&1; then
  printf "%s" "$RESPONSE" | wl-copy
elif command -v xclip >/dev/null 2>&1; then
  printf "%s" "$RESPONSE" | xclip -selection clipboard
elif command -v xsel >/dev/null 2>&1; then
  printf "%s" "$RESPONSE" | xsel --clipboard --input
else
  # Fallback: write to /tmp and notify user (eww notification if available)
  TMPFILE="/tmp/eww_ai_response.txt"
  printf "%s" "$RESPONSE" > "$TMPFILE"
  # Try notify via eww if available
  if command -v notify-send >/dev/null 2>&1; then
    notify-send "Eww: copied AI response to $TMPFILE"
  fi
fi

exit 0