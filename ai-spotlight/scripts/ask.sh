#!/bin/bash
PROMPT="$1"
MODEL="$2"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
EWW_DIR="$(dirname "$SCRIPT_DIR")"
EWW_CMD="/usr/bin/eww -c $EWW_DIR"

echo "ask.sh triggered with: '$PROMPT' and '$MODEL'" > /tmp/ask.log

if [ -z "$PROMPT" ]; then
    exit 0
fi


if ! command -v opencode >/dev/null 2>&1 && [ ! -f "/usr/bin/opencode" ]; then
    $EWW_CMD update is_loading=false
    $EWW_CMD update ai_response="Erro: OpenCode CLI não está instalado. Por favor, instale-o para continuar."
    exit 1
fi

$EWW_CMD update is_loading=true
$EWW_CMD update ai_response=""
$EWW_CMD update show_models="false"

IMAGE=$($EWW_CMD get attached_image)
ATTACH_ARGS=""

if [ -n "$IMAGE" ] && [ -f "$IMAGE" ]; then
    ATTACH_ARGS="--file $IMAGE"
    echo "Image attached: $IMAGE" >> /tmp/ask.log
fi

if [ -f "/usr/bin/opencode" ]; then
    RAW_RESPONSE=$(/usr/bin/opencode run "$PROMPT" --model "$MODEL" $ATTACH_ARGS | sed -e 's/\x1b\[[0-9;]*m//g')
else
    RAW_RESPONSE=$(opencode run "$PROMPT" --model "$MODEL" $ATTACH_ARGS | sed -e 's/\x1b\[[0-9;]*m//g')
fi

echo "ask.sh raw response: $RAW_RESPONSE" >> /tmp/ask.log

if [ -z "$RAW_RESPONSE" ]; then
    RESPONSE="Erro: Nenhuma resposta do Open Code."
else
    RESPONSE="$RAW_RESPONSE"
fi

SAFE_RESPONSE=$(echo "$RESPONSE" | sed 's/"/\\"/g' | sed "s/'/\\'/g" | sed ':a;N;$!ba;s/\n/\\n/g')

if [ -n "$IMAGE" ] && [ -f "$IMAGE" ]; then
    rm -f "$IMAGE"
    $EWW_CMD update attached_image=""
fi

$EWW_CMD update is_loading=false
$EWW_CMD update ai_response="$SAFE_RESPONSE"
