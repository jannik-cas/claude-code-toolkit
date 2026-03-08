# commit-guard

PostToolUse hook that runs type-checking and linting immediately after every edit — catch errors before they compound.

## Install

```bash
/plugin install commit-guard@claude-code-toolkit
```

## How it works

After every `Edit`, `Write`, or `MultiEdit`, this hook:

1. Detects the file's language
2. Runs the appropriate linter and type-checker
3. Reports issues immediately (non-blocking)

## Supported tools

| Language | Linter | Type Checker |
|----------|--------|-------------|
| Python | ruff | ty |
| TypeScript/JavaScript | ESLint | tsc |
| Go | go vet | — |
| Rust | — | cargo check |

## Configuration

The hook uses ruff and ty as defaults for Python. Other language tools are detected from your project setup.

## Requirements

- **Python**: `ruff` and/or `ty` installed
- **TypeScript**: `tsconfig.json` and ESLint in `node_modules`
- **Go**: `go` toolchain
- **Rust**: `cargo` toolchain
