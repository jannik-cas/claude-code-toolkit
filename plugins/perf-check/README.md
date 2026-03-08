# perf-check

Static analysis for algorithmic complexity and performance issues — without running your code.

## Install

```bash
/plugin install perf-check@claude-code-toolkit
```

## Usage

```bash
/perf-check src/utils/parser.ts   # Analyze a file
/perf-check processOrders          # Analyze a function
/perf-check src/api/               # Analyze a directory
```

## What it finds

- **Nested iterations** — O(n²) patterns reducible with hash maps
- **Redundant computations** — loop-hoistable or memoizable values
- **Unbounded growth** — caches and collections that never shrink
- **Hot path expenses** — regex compilation, JSON serialization in loops
- **N+1 patterns** — database queries inside loops
- **String concatenation** — repeated building instead of join/builder

Each finding includes current complexity, suggested fix, and before/after code.
