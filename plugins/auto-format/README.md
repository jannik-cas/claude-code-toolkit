# auto-format

PostToolUse hook that auto-detects and runs your project's formatter on files changed by Claude Code.

## Install

```bash
/plugin install auto-format@claude-code-toolkit
```

## How it works

After every `Edit`, `Write`, or `MultiEdit` tool use, this hook:

1. Extracts the changed file path from the tool result
2. Detects the project formatter based on config files and file extension
3. Runs the formatter on the changed file

## Supported formatters

| Formatter | Detection |
|-----------|-----------|
| Prettier | `.prettierrc`, `prettier.config.js`, or installed in `node_modules` |
| Black | `.py` files when `black` is available |
| gofmt | `.go` files when `gofmt` is available |
| rustfmt | `.rs` files when `rustfmt` is available |

## Requirements

The relevant formatter must be installed in your project or globally available.
