#!/usr/bin/env bash
# commit_guard.sh — PostToolUse hook
# Runs type-checking and linting on changed files immediately after edits.
# Defaults: ruff (lint) + ty (type-check) for Python.

set -euo pipefail

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.file // empty' 2>/dev/null)

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  echo '{"action":"allow"}'
  exit 0
fi

EXT="${FILE_PATH##*.}"
ISSUES=""

check_python() {
  local file="$1"

  # Lint with ruff
  if command -v ruff &>/dev/null; then
    RUFF_OUT=$(ruff check "$file" 2>&1 || true)
    if [ -n "$RUFF_OUT" ] && ! echo "$RUFF_OUT" | grep -q "All checks passed"; then
      ISSUES="${ISSUES}ruff:\n${RUFF_OUT}\n\n"
    fi
  fi

  # Type-check with ty
  if command -v ty &>/dev/null; then
    TY_OUT=$(ty check "$file" 2>&1 || true)
    if [ -n "$TY_OUT" ] && ! echo "$TY_OUT" | grep -q "^$"; then
      ISSUES="${ISSUES}ty:\n${TY_OUT}\n\n"
    fi
  fi
}

check_typescript() {
  local file="$1"

  # TypeScript type-checking
  if command -v npx &>/dev/null && [ -f "tsconfig.json" ]; then
    TSC_OUT=$(npx tsc --noEmit --pretty false "$file" 2>&1 || true)
    if [ -n "$TSC_OUT" ]; then
      ISSUES="${ISSUES}tsc:\n${TSC_OUT}\n\n"
    fi
  fi

  # ESLint
  if command -v npx &>/dev/null && [ -f "node_modules/.bin/eslint" ]; then
    ESLINT_OUT=$(npx eslint "$file" 2>&1 || true)
    if [ -n "$ESLINT_OUT" ]; then
      ISSUES="${ISSUES}eslint:\n${ESLINT_OUT}\n\n"
    fi
  fi
}

check_go() {
  local file="$1"
  if command -v go &>/dev/null; then
    GO_OUT=$(go vet "$file" 2>&1 || true)
    if [ -n "$GO_OUT" ]; then
      ISSUES="${ISSUES}go vet:\n${GO_OUT}\n\n"
    fi
  fi
}

check_rust() {
  local file="$1"
  if command -v cargo &>/dev/null; then
    CARGO_OUT=$(cargo check --message-format short 2>&1 | grep "^error" || true)
    if [ -n "$CARGO_OUT" ]; then
      ISSUES="${ISSUES}cargo check:\n${CARGO_OUT}\n\n"
    fi
  fi
}

case "$EXT" in
  py)   check_python "$FILE_PATH" ;;
  ts|tsx) check_typescript "$FILE_PATH" ;;
  js|jsx) check_typescript "$FILE_PATH" ;;
  go)   check_go "$FILE_PATH" ;;
  rs)   check_rust "$FILE_PATH" ;;
esac

if [ -n "$ISSUES" ]; then
  # Report issues but don't block — just inform
  REASON=$(echo -e "$ISSUES" | head -20 | jq -Rs '.')
  echo "{\"action\":\"allow\",\"message\":${REASON}}"
  exit 0
fi

echo '{"action":"allow"}'
exit 0
