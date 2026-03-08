# dead-code

Find truly unreachable code: unused exports, orphan files, dead functions, and unused dependencies.

## Install

```bash
/plugin install dead-code@claude-code-toolkit
```

## Usage

```bash
/dead-code                  # Full project scan
/dead-code src/utils/       # Scan specific directory
```

## What it finds

- **Unused exports** — exported but never imported
- **Orphan files** — never imported, not entry points
- **Dead functions** — internal functions never called
- **Unused dependencies** — installed but never imported
- **Dead routes** — endpoints never referenced

Each finding includes confidence level and estimated removable lines. Accounts for dynamic imports, reflection, and test-only usage.
