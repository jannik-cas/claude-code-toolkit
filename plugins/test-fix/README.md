# test-fix

Run tests, parse failures, and auto-fix in a loop (up to 3 iterations).

## Install

```bash
/plugin install test-fix@claude-code-toolkit
```

## Usage

```bash
/test-fix                                    # Auto-detect and fix
/test-fix "npm test -- --testPathPattern=auth"  # Fix specific tests
/test-fix "pytest tests/unit/"               # Fix Python unit tests
```

## Features

- Auto-detects test framework (jest, pytest, cargo test, go test, etc.)
- Parses failure output and identifies root cause
- Applies fixes and re-runs (up to 3 iterations)
- Reports summary of changes made
