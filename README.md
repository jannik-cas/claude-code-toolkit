# claude-code-toolkit

Community-curated plugins for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — 9 slash commands and 5 hooks for developer workflows.

## Installation

### 1. Clone the marketplace

```bash
git clone https://github.com/jannik-cas/claude-code-toolkit.git \
  ~/.claude/plugins/marketplaces/claude-code-toolkit
```

### 2. Register the marketplace

Add the following entry to `~/.claude/plugins/known_marketplaces.json`:

```json
{
  "claude-code-toolkit": {
    "source": {
      "source": "github",
      "repo": "jannik-cas/claude-code-toolkit"
    },
    "installLocation": "<HOME>/.claude/plugins/marketplaces/claude-code-toolkit",
    "lastUpdated": "2026-03-08T00:00:00.000Z"
  }
}
```

Replace `<HOME>` with your actual home directory path (e.g., `/Users/yourname`).

> If the file already has entries (like `claude-plugins-official`), add `claude-code-toolkit` as a sibling key inside the existing JSON object.

### 3. Enable plugins

Add the plugins you want to `~/.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "changelog@claude-code-toolkit": true,
    "explain@claude-code-toolkit": true,
    "security-scan@claude-code-toolkit": true
  }
}
```

Or enable all 14 at once:

```json
{
  "enabledPlugins": {
    "changelog@claude-code-toolkit": true,
    "explain@claude-code-toolkit": true,
    "test-fix@claude-code-toolkit": true,
    "security-scan@claude-code-toolkit": true,
    "deps@claude-code-toolkit": true,
    "context-primer@claude-code-toolkit": true,
    "diff-narrator@claude-code-toolkit": true,
    "dead-code@claude-code-toolkit": true,
    "perf-check@claude-code-toolkit": true,
    "auto-format@claude-code-toolkit": true,
    "guard-secrets@claude-code-toolkit": true,
    "session-log@claude-code-toolkit": true,
    "commit-guard@claude-code-toolkit": true,
    "auto-todo@claude-code-toolkit": true
  }
}
```

### 4. Restart Claude Code

Start a new session. Your plugins are now available.

### Updating

```bash
cd ~/.claude/plugins/marketplaces/claude-code-toolkit && git pull
```

## Plugins

### Commands

| Plugin | Command | Description |
|--------|---------|-------------|
| [changelog](plugins/changelog/) | `/changelog:run` | Generate changelogs from git history (Keep a Changelog / GitHub Releases format) |
| [explain](plugins/explain/) | `/explain:run` | Deep code explanation with call graph tracing and dependency mapping |
| [test-fix](plugins/test-fix/) | `/test-fix:run` | Run tests, parse failures, and auto-fix in a loop (up to 3 iterations) |
| [security-scan](plugins/security-scan/) | `/security-scan:run` | Scan for hardcoded secrets, OWASP Top 10 patterns, and dependency CVEs |
| [deps](plugins/deps/) | `/deps:run` | Analyze outdated and vulnerable dependencies across package managers |
| [context-primer](plugins/context-primer/) | `/context-primer:run` | Auto-generate an optimized CLAUDE.md from your codebase |
| [diff-narrator](plugins/diff-narrator/) | `/diff-narrator:run` | Generate narrated walkthroughs of diffs and pull requests |
| [dead-code](plugins/dead-code/) | `/dead-code:run` | Find unreachable code, unused exports, and dead dependency subtrees |
| [perf-check](plugins/perf-check/) | `/perf-check:run` | Static analysis for algorithmic complexity and performance issues |

### Hooks

| Plugin | Event | Description |
|--------|-------|-------------|
| [auto-format](plugins/auto-format/) | PostToolUse | Auto-detect and run project formatter (prettier, black, gofmt, rustfmt) on changed files |
| [guard-secrets](plugins/guard-secrets/) | PreToolUse | Block `git add`/`git commit` if staged files contain API keys or tokens |
| [session-log](plugins/session-log/) | SessionStart/Stop | Log session timestamps and working directory to `~/.claude/session-logs/` |
| [commit-guard](plugins/commit-guard/) | PostToolUse | Instant type-checking and linting after every edit (ruff + ty default for Python) |
| [auto-todo](plugins/auto-todo/) | PostToolUse | Auto-collect TODO/FIXME/HACK comments into `.claude/todos.md` |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on adding your own plugins.

## License

[MIT](LICENSE)
