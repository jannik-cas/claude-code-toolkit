# Contributing to claude-code-toolkit

Thanks for your interest in contributing! This marketplace welcomes community plugins.

## Adding a New Plugin

1. Fork this repository
2. Create your plugin directory under `plugins/your-plugin-name/`
3. Include the required files:
   - `.claude-plugin/plugin.json` — plugin manifest
   - For commands: `commands/your-command.md`
   - For hooks: `hooks/hooks.json` + hook scripts
   - `README.md` — usage docs
4. Register your plugin in `.claude-plugin/marketplace.json`
5. Open a pull request

## Plugin Guidelines

- **One concern per plugin** — keep plugins focused
- **Document everything** — include a README with examples
- **Test your plugin** — verify it works in a real Claude Code session
- **No secrets** — never hardcode API keys or tokens
- **Respect timeouts** — hook scripts should complete within their configured timeout

## Command Plugin Structure

```
plugins/my-command/
├── .claude-plugin/plugin.json
├── commands/my-command.md
└── README.md
```

## Hook Plugin Structure

```
plugins/my-hook/
├── .claude-plugin/plugin.json
├── hooks/hooks.json
├── hooks/my_hook.sh
└── README.md
```

## Code of Conduct

Be respectful, constructive, and helpful. We're all here to make Claude Code better.
