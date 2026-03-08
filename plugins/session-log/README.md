# session-log

SessionStart/Stop hook that logs session timestamps and working directory to a persistent log file.

## Install

```bash
/plugin install session-log@claude-code-toolkit
```

## How it works

When a Claude Code session starts or stops, this hook appends a log entry to `~/.claude/session-logs/sessions.log`.

## Log format

```
[2026-03-08T14:30:00Z] SESSION_START | id=abc123 | cwd=/Users/you/project
[2026-03-08T15:45:00Z] SESSION_STOP  | id=abc123 | cwd=/Users/you/project
```

## Log location

Logs are stored at `~/.claude/session-logs/sessions.log`.

## Use cases

- Track time spent per project
- Audit which directories Claude Code was used in
- Build personal productivity dashboards
