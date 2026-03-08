---
description: Static analysis for algorithmic complexity and performance issues
argument-hint: "<file-or-function>"
allowed-tools: [Bash, Read, Grep, Glob]
---

## Context

- Project type: !`ls package.json Cargo.toml pyproject.toml go.mod 2>/dev/null`
- Target info: !`wc -l $ARGUMENTS 2>/dev/null || echo "Symbol search needed"`

## Your task

Analyze `$ARGUMENTS` for performance issues and algorithmic complexity problems.

### Instructions

1. **Locate the target** — If a file path, read it. If a function/class name, search the codebase for its definition and read the containing file.

2. **Analyze algorithmic complexity:**

   **Nested iterations** — Find nested loops over the same or related collections. Determine if the nesting is necessary or if it can be reduced (e.g., using a hash map for O(1) lookups instead of O(n) inner loop).

   **Redundant computations** — Identify values computed inside loops that could be hoisted out, or repeated calculations that could be memoized.

   **Unbounded growth** — Arrays, maps, or caches that grow without bounds and are never cleaned up.

   **Expensive operations in hot paths** — Regex compilation in loops, repeated JSON serialization, filesystem reads in request handlers.

   **N+1 patterns** — Database queries or API calls inside loops (common in ORMs).

   **String concatenation** — Repeated string building in loops instead of using builders/join.

3. **For each finding, provide:**
   - Location (file:line)
   - Current complexity (e.g., O(n²), O(n·m))
   - Why it's a problem
   - Suggested optimization with complexity improvement
   - Before/after code sketch

4. **Summary** — Overall assessment:
   - Worst-case complexity of the analyzed code
   - Top 3 most impactful optimizations
   - Estimated improvement (e.g., "reduces from O(n²) to O(n)")

### Example usage

- `/perf-check src/utils/parser.ts` — Analyze a file
- `/perf-check processOrders` — Analyze a function
- `/perf-check src/api/` — Analyze a directory
