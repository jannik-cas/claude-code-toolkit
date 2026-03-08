# claude-code-toolkit

Community-curated plugins for [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

## Quick Start

```bash
# Register the marketplace
/plugin marketplace add jannik-cas/claude-code-toolkit

# Install a plugin
/plugin install changelog@claude-code-toolkit
```

## Plugins

### Commands

| Plugin | Command | Description |
|--------|---------|-------------|
| [changelog](plugins/changelog/) | `/changelog` | Generate changelogs from git history (Keep a Changelog / GitHub Releases format) |
| [explain](plugins/explain/) | `/explain` | Deep code explanation with call graph tracing and dependency mapping |
| [test-fix](plugins/test-fix/) | `/test-fix` | Run tests, parse failures, and auto-fix in a loop (up to 3 iterations) |
| [security-scan](plugins/security-scan/) | `/security-scan` | Scan for hardcoded secrets, OWASP Top 10 patterns, and dependency CVEs |
| [deps](plugins/deps/) | `/deps` | Analyze outdated and vulnerable dependencies across package managers |
| [context-primer](plugins/context-primer/) | `/context-primer` | Auto-generate an optimized CLAUDE.md from your codebase |
| [diff-narrator](plugins/diff-narrator/) | `/diff-narrator` | Generate narrated walkthroughs of diffs and pull requests |
| [dead-code](plugins/dead-code/) | `/dead-code` | Find unreachable code, unused exports, and dead dependency subtrees |
| [perf-check](plugins/perf-check/) | `/perf-check` | Static analysis for algorithmic complexity and performance issues |

### Hooks

| Plugin | Event | Description |
|--------|-------|-------------|
| [auto-format](plugins/auto-format/) | PostToolUse | Auto-detect and run project formatter on changed files |
| [guard-secrets](plugins/guard-secrets/) | PreToolUse | Block git commits if staged files contain API keys or tokens |
| [session-log](plugins/session-log/) | SessionStart/Stop | Log session timestamps and working directory |
| [commit-guard](plugins/commit-guard/) | PostToolUse | Instant type-checking and linting after every edit (ruff + ty default) |
| [auto-todo](plugins/auto-todo/) | PostToolUse | Auto-collect TODO/FIXME/HACK comments into `.claude/todos.md` |

## Installation

Each plugin can be installed independently:

```bash
# Install a command plugin
/plugin install changelog@claude-code-toolkit

# Install a hook plugin
/plugin install auto-format@claude-code-toolkit
```

To uninstall:

```bash
/plugin uninstall changelog@claude-code-toolkit
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on adding your own plugins.

## License

[MIT](LICENSE)
