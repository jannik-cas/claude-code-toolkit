---
description: Analyze outdated and vulnerable dependencies across package managers
argument-hint: "[action]"
allowed-tools: [Bash, Read, Grep, Glob]
---

## Context

- Dependency files: !`ls package.json package-lock.json yarn.lock pnpm-lock.yaml Cargo.toml Cargo.lock pyproject.toml requirements*.txt go.mod go.sum Gemfile Gemfile.lock 2>/dev/null`

## Your task

Analyze project dependencies based on `$ARGUMENTS`.

### Instructions

1. **Detect package managers** in use by checking for manifest and lock files.

2. **Default action** (no arguments): Show a summary of all dependencies:
   - Total count (direct vs. transitive)
   - Outdated packages (current vs. latest version)
   - Known vulnerabilities

3. **Actions**:
   - `outdated` — List all outdated dependencies with current and latest versions
   - `vulnerabilities` — Run security audit and list CVEs
   - `unused` — Identify potentially unused dependencies by scanning imports
   - `update [package]` — Show what would change if a specific package is updated (breaking changes, peer dependency conflicts)

4. **Package manager commands**:
   - npm/yarn/pnpm: `npm outdated`, `npm audit`
   - pip: `pip list --outdated`, `pip-audit`
   - cargo: `cargo outdated`, `cargo audit`
   - go: `go list -m -u all`
   - bundler: `bundle outdated`

5. **Output**: Present a table with package name, current version, latest version, and severity of any vulnerabilities.

### Example usage

- `/deps` — Full dependency summary
- `/deps outdated` — List outdated packages
- `/deps vulnerabilities` — Security audit
- `/deps unused` — Find unused dependencies
- `/deps update react` — Impact analysis for updating react
