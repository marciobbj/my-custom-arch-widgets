#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
EWW_DIR="$(dirname "$SCRIPT_DIR")"
source "$EWW_DIR/config.sh"

if ! command -v opencode >/dev/null 2>&1 && [ ! -f "/usr/bin/opencode" ]; then
    echo '["OpenCode CLI missing"]'
    exit 0
fi

if [ -f "/usr/bin/opencode" ]; then
    CMD="/usr/bin/opencode"
else
    CMD="opencode"
fi

if [ -n "$MODEL_PROVIDER" ]; then
    models=$($CMD models | grep "$MODEL_PROVIDER")
else
    models=$($CMD models)
fi

json="["
first=true
while IFS= read -r model; do
    if [ -n "$model" ]; then
        if [ "$first" = true ]; then
            json="$json\"$model\""
            first=false
        else
            json="$json, \"$model\""
        fi
    fi
done <<< "$models"

if [ "$json" = "[" ]; then
    json='["Nenhum modelo encontrado"]'
else
    json="$json]"
fi

json=$(echo "$json" | tr -d '\n')
echo "$json"
