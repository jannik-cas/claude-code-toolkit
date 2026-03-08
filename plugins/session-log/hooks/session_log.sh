#!/usr/bin/env bash
# session_log.sh — SessionStart/Stop hook
# Logs session timestamps and working directory.

set -euo pipefail

ACTION="${1:-}"
LOG_DIR="${HOME}/.claude/session-logs"
LOG_FILE="${LOG_DIR}/sessions.log"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
WORKING_DIR="$PWD"
SESSION_ID="${CLAUDE_SESSION_ID:-unknown}"

case "$ACTION" in
  start)
    echo "[${TIMESTAMP}] SESSION_START | id=${SESSION_ID} | cwd=${WORKING_DIR}" >> "$LOG_FILE"
    ;;
  stop)
    echo "[${TIMESTAMP}] SESSION_STOP  | id=${SESSION_ID} | cwd=${WORKING_DIR}" >> "$LOG_FILE"
    ;;
  *)
    echo "[${TIMESTAMP}] SESSION_EVENT | id=${SESSION_ID} | cwd=${WORKING_DIR} | action=${ACTION}" >> "$LOG_FILE"
    ;;
esac

echo '{"action":"allow"}'
exit 0
