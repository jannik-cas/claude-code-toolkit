#!/usr/bin/env bash
# auto_format.sh — PostToolUse hook
# Reads tool result JSON from stdin, detects the project formatter,
# and runs it on the changed file.

set -euo pipefail

# Read the tool result from stdin
INPUT=$(cat)

# Extract the file path from the tool result
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.file // empty' 2>/dev/null)

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  # No file path found or file doesn't exist, pass through
  echo '{"action":"allow"}'
  exit 0
fi

# Get the file extension
EXT="${FILE_PATH##*.}"

# Find the project root (look for common project markers)
PROJECT_ROOT="$PWD"

format_file() {
  local file="$1"

  # JavaScript/TypeScript — Prettier
  if [ -f "$PROJECT_ROOT/.prettierrc" ] || [ -f "$PROJECT_ROOT/.prettierrc.json" ] || [ -f "$PROJECT_ROOT/.prettierrc.yml" ] || [ -f "$PROJECT_ROOT/prettier.config.js" ] || [ -f "$PROJECT_ROOT/prettier.config.mjs" ]; then
    if command -v npx &>/dev/null; then
      npx prettier --write "$file" 2>/dev/null
      return
    fi
  fi

  # Python — Black
  if [[ "$EXT" == "py" ]]; then
    if command -v black &>/dev/null; then
      black --quiet "$file" 2>/dev/null
      return
    fi
  fi

  # Go — gofmt
  if [[ "$EXT" == "go" ]]; then
    if command -v gofmt &>/dev/null; then
      gofmt -w "$file" 2>/dev/null
      return
    fi
  fi

  # Rust — rustfmt
  if [[ "$EXT" == "rs" ]]; then
    if command -v rustfmt &>/dev/null; then
      rustfmt "$file" 2>/dev/null
      return
    fi
  fi

  # Fallback: check for Prettier with any file type
  if command -v npx &>/dev/null && [ -f "$PROJECT_ROOT/node_modules/.bin/prettier" ]; then
    npx prettier --write "$file" 2>/dev/null
    return
  fi
}

format_file "$FILE_PATH"

echo '{"action":"allow"}'
exit 0
