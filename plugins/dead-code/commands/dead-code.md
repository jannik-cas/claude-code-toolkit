---
description: Find unreachable code, unused exports, and dead dependency subtrees
argument-hint: "[scope]"
allowed-tools: [Bash, Read, Grep, Glob]
---

## Context

- Project type: !`ls package.json Cargo.toml pyproject.toml go.mod 2>/dev/null`
- Source directories: !`ls -d src/ lib/ app/ pkg/ internal/ cmd/ 2>/dev/null`
- Entry points: !`ls index.ts index.js main.ts main.py main.go cmd/*/main.go src/main.rs 2>/dev/null`

## Your task

Find dead code in the codebase. Scope to `$ARGUMENTS` if provided, otherwise scan the full project.

### Instructions

1. **Identify entry points** — Find the application's entry points (main files, exported package APIs, route handlers, CLI commands).

2. **Trace the dependency graph** — Starting from entry points, map which modules, functions, classes, and components are actually reachable.

3. **Find dead code categories:**

   **Unused exports** — Functions, classes, constants, or types that are exported but never imported anywhere.

   **Orphan files** — Files that are never imported by any other file and are not entry points.

   **Dead functions** — Non-exported functions/methods that are never called within their own module.

   **Unused dependencies** — Packages in the manifest that are never imported in source code (exclude devDependencies used in config/tests).

   **Dead routes/endpoints** — API routes or pages that exist but are never linked to or called.

4. **Verification** — For each finding, double-check by searching for:
   - Dynamic imports (`import()`, `require()`, `__import__()`)
   - String-based references (reflection, decorators, config files)
   - Test files that import the code (mark as "only used in tests")

5. **Output** — Present findings grouped by category with:
   - File path and line number
   - What's unused and why you believe it's dead
   - Confidence level (high/medium/low)
   - Estimated lines that could be removed

### Example usage

- `/dead-code` — Full project scan
- `/dead-code src/utils/` — Scan specific directory
- `/dead-code --exports-only` — Only check unused exports
