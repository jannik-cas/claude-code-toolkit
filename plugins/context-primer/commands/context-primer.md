---
description: Auto-generate an optimized CLAUDE.md from your codebase
argument-hint: "[output-path]"
allowed-tools: [Bash, Read, Write, Grep, Glob]
---

## Context

- Project root files: !`ls -1 package.json Cargo.toml pyproject.toml go.mod Makefile Dockerfile docker-compose.yml tsconfig.json .eslintrc* .prettierrc* 2>/dev/null`
- Directory structure: !`find . -type d -not -path '*/node_modules/*' -not -path '*/.git/*' -not -path '*/vendor/*' -not -path '*/dist/*' -not -path '*/build/*' -not -path '*/__pycache__/*' -maxdepth 3 | head -40`
- Existing CLAUDE.md: !`cat CLAUDE.md 2>/dev/null | head -20 || echo "None found"`
- Git remotes: !`git remote -v 2>/dev/null | head -2`

## Your task

Generate an optimized `CLAUDE.md` file that primes future Claude Code sessions with deep project context. Output to `$ARGUMENTS` if provided, otherwise `CLAUDE.md` in the project root.

### Instructions

1. **Analyze the project** by reading key configuration files, entry points, and directory structure.

2. **Generate these sections:**

   **Project Overview** — One paragraph: what this project is, its purpose, primary language/framework.

   **Tech Stack** — Languages, frameworks, key dependencies, build tools, test frameworks. Be specific with versions where visible.

   **Architecture** — How the codebase is organized. Key directories and their responsibilities. Entry points. Data flow patterns (e.g., MVC, event-driven, microservices).

   **Key Conventions** — Naming patterns (camelCase vs snake_case), file organization rules, import ordering, error handling patterns. Infer these from the actual code, don't guess.

   **Common Commands** — Build, test, lint, format, deploy commands extracted from package.json scripts, Makefile targets, or CI config.

   **Important Files** — List the 10-15 most architecturally significant files with one-line descriptions.

   **Gotchas & Context** — Non-obvious things: environment variables needed, required services, unusual patterns, known workarounds.

3. **Style rules:**
   - Be concise — this is LLM context, not documentation
   - Use bullet points over prose
   - Include only facts observable from the codebase
   - Skip sections that have no useful content
   - Keep total output under 150 lines

### Example usage

- `/context-primer` — Generate CLAUDE.md in project root
- `/context-primer docs/CLAUDE.md` — Write to custom path
