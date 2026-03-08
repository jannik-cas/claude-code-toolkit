---
description: Scan for hardcoded secrets, OWASP Top 10 patterns, and dependency CVEs
argument-hint: "[scope]"
allowed-tools: [Bash, Read, Grep, Glob]
---

## Context

- Git status: !`git status --short | head -20`
- Project type: !`ls package.json Cargo.toml pyproject.toml go.mod requirements.txt Gemfile 2>/dev/null`

## Your task

Perform a security scan of the codebase based on `$ARGUMENTS`.

### Instructions

1. **Scope**: If a scope is provided (e.g., a directory or file), scan only that. Otherwise, scan the entire project (excluding `node_modules`, `vendor`, `.git`, `dist`, `build`).

2. **Hardcoded Secrets** — Search for:
   - API keys: patterns like `AKIA[0-9A-Z]{16}`, `sk-[a-zA-Z0-9]{48}`, `ghp_[a-zA-Z0-9]{36}`
   - Generic secrets: `password\s*=\s*["'][^"']+`, `secret\s*=\s*["'][^"']+`, `token\s*=\s*["'][^"']+`
   - Private keys: `-----BEGIN (RSA |EC |DSA )?PRIVATE KEY-----`
   - Connection strings with credentials embedded

3. **OWASP Top 10 Patterns** — Check for:
   - SQL injection: string concatenation in SQL queries
   - XSS: unescaped user input in HTML templates
   - Command injection: shell commands built from user input
   - Path traversal: file operations with unsanitized paths
   - Insecure deserialization: `eval()`, `pickle.loads()`, `unserialize()`

4. **Dependency Vulnerabilities** — If available, run:
   - `npm audit --json` for Node.js
   - `pip-audit` or `safety check` for Python
   - `cargo audit` for Rust
   - Report any known CVEs

5. **Output**: Present findings grouped by severity (Critical, High, Medium, Low) with file locations, line numbers, and remediation suggestions.

### Example usage

- `/security-scan` — Full project scan
- `/security-scan src/` — Scan only src directory
- `/security-scan --secrets-only` — Only check for hardcoded secrets
