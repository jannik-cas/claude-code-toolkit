#!/usr/bin/env bash
# auto_todo.sh — PostToolUse hook
# Scans changed files for TODO/FIXME/HACK/XXX comments and appends them
# to .claude/todos.md with file location and timestamp.

set -euo pipefail

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.file // empty' 2>/dev/null)

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  echo '{"action":"allow"}'
  exit 0
fi

TODO_DIR=".claude"
TODO_FILE="${TODO_DIR}/todos.md"

# Ensure .claude directory exists
mkdir -p "$TODO_DIR"

# Initialize todos.md if it doesn't exist
if [ ! -f "$TODO_FILE" ]; then
  cat > "$TODO_FILE" << 'HEADER'
# TODOs

Auto-collected from code comments. Updated by the `auto-todo` plugin.

---

HEADER
fi

TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M UTC")

# Find TODO/FIXME/HACK/XXX comments in the file
MATCHES=$(grep -nE '\b(TODO|FIXME|HACK|XXX)\b' "$FILE_PATH" 2>/dev/null || true)

if [ -z "$MATCHES" ]; then
  echo '{"action":"allow"}'
  exit 0
fi

# Remove existing entries for this file to avoid duplicates
if [ -f "$TODO_FILE" ]; then
  # Use a temp file to filter out old entries for this file
  TEMP_FILE=$(mktemp)
  awk -v file="$FILE_PATH" '
    /^- \[/ && index($0, "`" file ":") { next }
    { print }
  ' "$TODO_FILE" > "$TEMP_FILE"
  mv "$TEMP_FILE" "$TODO_FILE"
fi

# Append new entries
while IFS= read -r line; do
  LINE_NUM=$(echo "$line" | cut -d: -f1)
  CONTENT=$(echo "$line" | cut -d: -f2- | sed 's/^[[:space:]]*//')

  # Extract the tag (TODO, FIXME, HACK, XXX)
  TAG=$(echo "$CONTENT" | grep -oE '\b(TODO|FIXME|HACK|XXX)\b' | head -1)

  echo "- [ ] **${TAG}** \`${FILE_PATH}:${LINE_NUM}\` — ${CONTENT} *(${TIMESTAMP})*" >> "$TODO_FILE"
done <<< "$MATCHES"

echo '{"action":"allow"}'
exit 0
