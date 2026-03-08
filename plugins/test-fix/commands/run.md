---
description: Run tests, parse failures, and auto-fix in a loop (up to 3 iterations)
argument-hint: "[test-command] [file-pattern]"
allowed-tools: [Bash, Read, Edit, Write, Grep, Glob]
---

## Context

- Package manager files: !`ls package.json Cargo.toml pyproject.toml go.mod Makefile 2>/dev/null`
- Test config files: !`ls jest.config.* vitest.config.* pytest.ini setup.cfg .mocharc.* 2>/dev/null`

## Your task

Run tests, identify failures, and fix them automatically. Repeat up to 3 iterations.

### Instructions

1. **Detect test command**: If a test command is provided in `$ARGUMENTS`, use it. Otherwise, auto-detect:
   - `package.json` with test script → `npm test` / `yarn test` / `pnpm test`
   - `Cargo.toml` → `cargo test`
   - `pyproject.toml` / `setup.cfg` → `pytest`
   - `go.mod` → `go test ./...`
   - `Makefile` with test target → `make test`

2. **Scope**: If a file pattern is provided, pass it to the test command to run only matching tests.

3. **Loop** (max 3 iterations):
   a. Run the test command
   b. If all tests pass → report success and stop
   c. If tests fail:
      - Parse the error output to identify failing tests and error messages
      - Read the relevant source and test files
      - Apply fixes to the code
      - Continue to next iteration

4. **Report**: After the loop, summarize:
   - Total iterations used
   - Tests fixed vs. still failing
   - Changes made (files modified)

### Example usage

- `/test-fix` — Auto-detect and fix all failing tests
- `/test-fix "npm test -- --testPathPattern=auth"` — Fix auth tests
- `/test-fix "pytest tests/unit/"` — Fix unit tests
