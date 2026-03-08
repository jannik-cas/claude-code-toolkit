---
description: Generate a changelog from git history
argument-hint: "[format] [since-ref]"
allowed-tools: [Bash, Read, Write, Grep, Glob]
---

## Context

- Recent tags: !`git tag --sort=-v:refname | head -10`
- Current branch: !`git branch --show-current`
- Latest commit: !`git log -1 --oneline`

## Your task

Generate a changelog based on `$ARGUMENTS`.

### Instructions

1. **Determine the range**: If a `since-ref` is provided (e.g. `v1.2.0`), generate the changelog from that ref to HEAD. If no ref is provided, use the most recent tag as the starting point. If no tags exist, use the last 50 commits.

2. **Parse commits**: Group commits by type using conventional commit prefixes:
   - `feat:` → Added
   - `fix:` → Fixed
   - `refactor:` → Changed
   - `docs:` → Documentation
   - `test:` → Tests
   - `chore:` / `build:` / `ci:` → Maintenance
   - Other → Other

3. **Format**: Default to [Keep a Changelog](https://keepachangelog.com/) format. If `github-releases` is specified as format, use GitHub Releases markdown instead.

4. **Output**: Write the changelog to `CHANGELOG.md` (appending to existing content if present) and display a summary of what was generated.

### Example usage

- `/changelog` — Generate changelog since last tag
- `/changelog v1.0.0` — Generate changelog since v1.0.0
- `/changelog github-releases v2.0.0` — GitHub Releases format since v2.0.0
