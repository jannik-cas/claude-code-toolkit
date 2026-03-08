#!/usr/bin/env bash
# guard_secrets.sh — PreToolUse hook
# Blocks git add/commit if staged files contain potential secrets.

set -euo pipefail

INPUT=$(cat)

# Extract the command from the Bash tool input
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

if [ -z "$COMMAND" ]; then
  echo '{"action":"allow"}'
  exit 0
fi

# Only check git add and git commit commands
if ! echo "$COMMAND" | grep -qE '^\s*git\s+(add|commit)'; then
  echo '{"action":"allow"}'
  exit 0
fi

# Get list of staged files (or files about to be staged)
if echo "$COMMAND" | grep -qE '^\s*git\s+add'; then
  # Extract file paths from the git add command
  FILES=$(echo "$COMMAND" | sed 's/^\s*git\s\+add\s\+//' | tr ' ' '\n' | grep -v '^-')
else
  # For git commit, check already staged files
  FILES=$(git diff --cached --name-only 2>/dev/null || true)
fi

if [ -z "$FILES" ]; then
  echo '{"action":"allow"}'
  exit 0
fi

# Secret patterns to check
PATTERNS=(
  'AKIA[0-9A-Z]{16}'                           # AWS Access Key
  'sk-[a-zA-Z0-9]{20,}'                        # OpenAI / Stripe secret key
  'ghp_[a-zA-Z0-9]{36}'                        # GitHub PAT
  'gho_[a-zA-Z0-9]{36}'                        # GitHub OAuth
  'glpat-[a-zA-Z0-9\-]{20,}'                   # GitLab PAT
  '-----BEGIN (RSA |EC |DSA )?PRIVATE KEY-----' # Private keys
  'xox[bpsa]-[a-zA-Z0-9\-]+'                   # Slack tokens
)

FOUND_SECRETS=""

for file in $FILES; do
  if [ ! -f "$file" ]; then
    continue
  fi

  # Skip binary files and common non-secret files
  if file "$file" | grep -q "binary"; then
    continue
  fi

  for pattern in "${PATTERNS[@]}"; do
    MATCHES=$(grep -nE "$pattern" "$file" 2>/dev/null || true)
    if [ -n "$MATCHES" ]; then
      FOUND_SECRETS="$FOUND_SECRETS\n⚠ $file: matches pattern '$pattern'\n$MATCHES\n"
    fi
  done
done

if [ -n "$FOUND_SECRETS" ]; then
  MESSAGE="Potential secrets detected in staged files:$(echo -e "$FOUND_SECRETS")\n\nRemove the secrets before committing. Use environment variables or a secrets manager instead."
  echo "{\"action\":\"block\",\"reason\":\"$MESSAGE\"}" | jq -c '.'
  exit 2
fi

echo '{"action":"allow"}'
exit 0
