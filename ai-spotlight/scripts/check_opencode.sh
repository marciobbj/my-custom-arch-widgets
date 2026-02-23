#!/bin/bash
if ! command -v opencode >/dev/null 2>&1 && [ ! -f "/usr/bin/opencode" ]; then
    notify-send -u critical "OpenCode Missing" "Please install OpenCode CLI to use the AI Spotlight widget."
    exit 1
fi
exit 0
