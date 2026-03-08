---
description: Deep code explanation with call graph tracing and dependency mapping
argument-hint: "<file-or-symbol>"
allowed-tools: [Bash, Read, Grep, Glob]
---

## Context

- Project structure: !`find . -type f -name "*.json" -o -name "*.yaml" -o -name "*.toml" | head -5`
- Languages detected: !`find . -type f \( -name "*.ts" -o -name "*.py" -o -name "*.go" -o -name "*.rs" -o -name "*.java" -o -name "*.js" \) | head -5`

## Your task

Provide a deep explanation of `$ARGUMENTS`.

### Instructions

1. **Locate the target**: Find the file or symbol specified. If it's a file path, read it. If it's a symbol name (function, class, etc.), search the codebase for its definition.

2. **Explain the code**:
   - Purpose and responsibility
   - Key algorithms or patterns used
   - Input/output contracts

3. **Trace the call graph**:
   - What does this code call? (outgoing dependencies)
   - What calls this code? (incoming references)
   - Trace up to 2 levels deep in each direction

4. **Map dependencies**:
   - Internal module dependencies
   - External package dependencies
   - Configuration or environment dependencies

5. **Output**: Present a structured explanation with sections for Overview, Call Graph, Dependencies, and any notable edge cases or gotchas.

### Example usage

- `/explain src/auth/login.ts` — Explain a specific file
- `/explain handlePayment` — Explain a function by name
- `/explain UserService` — Explain a class
