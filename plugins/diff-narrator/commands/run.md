---
description: Generate a narrated walkthrough of a diff or pull request
argument-hint: "[ref-or-range] [--pr N]"
allowed-tools: [Bash, Read, Grep, Glob]
---

## Context

- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`
- Remote: !`git remote -v 2>/dev/null | head -2`

## Your task

Generate a narrated walkthrough of the changes specified by `$ARGUMENTS`.

### Instructions

1. **Determine the diff source:**
   - No arguments → unstaged + staged changes (`git diff` + `git diff --cached`)
   - A commit ref (e.g., `HEAD~3`, `v1.2.0`) → diff from that ref to HEAD
   - A range (e.g., `main..feature`) → diff between the two refs
   - `--pr N` → fetch the PR diff using `gh pr diff N`

2. **Read and understand the diff** — Don't just list changes. Understand the *intent* behind them.

3. **Write the narrative:**
   - Start with a one-sentence summary of the overall change
   - Walk through changes in logical order (not file order) — group related changes together
   - For each logical group, explain:
     - **What** changed
     - **Why** it changed (infer from context, commit messages, code comments)
     - **Impact** — what this affects downstream
   - Call out:
     - Breaking changes
     - Subtle behavioral differences
     - Things a reviewer should pay extra attention to

4. **Output format:**
   ```
   ## Summary
   One-sentence overview.

   ## Walkthrough

   ### 1. [Logical Group Name]
   Narrative explanation...

   ### 2. [Next Group]
   ...

   ## Review Notes
   - Breaking changes, risks, things to watch
   ```

### Example usage

- `/diff-narrator` — Narrate current uncommitted changes
- `/diff-narrator HEAD~5` — Narrate last 5 commits
- `/diff-narrator main..feature/auth` — Narrate branch diff
- `/diff-narrator --pr 42` — Narrate a pull request
