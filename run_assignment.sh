#!/bin/bash

set -o pipefail

OLLAMA_PORT="11434"
SCRIPT_PATH=""
LOG_PATH=""
RESOLVED_OLLAMA_HOST=""

usage() {
    echo "Usage: run_assignment.sh <python_script>"
}

resolve_script_path() {
    if [ $# -ne 1 ]; then
        usage
        exit 1
    fi

    SCRIPT_PATH="$1"
    if [ ! -f "$SCRIPT_PATH" ]; then
        echo "Script not found: $SCRIPT_PATH"
        exit 1
    fi
}

resolve_log_path() {
    LOG_PATH="${SCRIPT_PATH%.py}.log"
    if [ "$LOG_PATH" = "$SCRIPT_PATH" ]; then
        LOG_PATH="${SCRIPT_PATH}.log"
    fi
}

resolve_ollama_host() {
    local ollama_ip
    ollama_ip="$(ip route 2>/dev/null | awk '/default/ {print $3; exit}')"

    if [ -n "${OLLAMA_HOST:-}" ]; then
        RESOLVED_OLLAMA_HOST="$OLLAMA_HOST"
    elif [ -n "$ollama_ip" ]; then
        RESOLVED_OLLAMA_HOST="http://${ollama_ip}:${OLLAMA_PORT}"
    else
        RESOLVED_OLLAMA_HOST="http://127.0.0.1:${OLLAMA_PORT}"
    fi
}

run_assignment() {
    local cmd
    mkdir -p "$(dirname "$LOG_PATH")"
    cmd="ALL_PROXY= all_proxy= HTTP_PROXY= http_proxy= HTTPS_PROXY= https_proxy= OLLAMA_HOST=\"$RESOLVED_OLLAMA_HOST\" python \"$SCRIPT_PATH\""

    {
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] CMD: $cmd"
        ALL_PROXY= all_proxy= HTTP_PROXY= http_proxy= HTTPS_PROXY= https_proxy= \
        OLLAMA_HOST="$RESOLVED_OLLAMA_HOST" \
        python "$SCRIPT_PATH"
        local exit_code=$?
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] EXIT_CODE: $exit_code"
        exit "$exit_code"
    } 2>&1 | tee "$LOG_PATH"

    return "${PIPESTATUS[0]}"
}

main() {
    resolve_script_path "$@"
    resolve_log_path
    resolve_ollama_host
    run_assignment
}

main "$@"
exit $?
