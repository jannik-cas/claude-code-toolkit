# auto-todo

PostToolUse hook that auto-collects `TODO`, `FIXME`, `HACK`, and `XXX` comments into a centralized `.claude/todos.md`.

## Install

```bash
/plugin install auto-todo@claude-code-toolkit
```

## How it works

After every `Edit`, `Write`, or `MultiEdit`, this hook:

1. Scans the changed file for `TODO`, `FIXME`, `HACK`, `XXX` comments
2. Deduplicates against existing entries for the same file
3. Appends new entries to `.claude/todos.md` with file location and timestamp

## Output format

```markdown
- [ ] **TODO** `src/auth.ts:42` — TODO: add refresh token rotation *(2026-03-08 14:30 UTC)*
- [ ] **FIXME** `src/db.ts:17` — FIXME: connection pool exhaustion under load *(2026-03-08 14:31 UTC)*
```

## Features

- Auto-deduplicates when a file is re-edited
- Tracks TODO, FIXME, HACK, and XXX tags
- Includes file path, line number, and timestamp
- Outputs as a markdown checklist you can track
