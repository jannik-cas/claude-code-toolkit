# context-primer

Auto-generate an optimized `CLAUDE.md` that primes Claude Code with deep project context.

## Install

```bash
/plugin install context-primer@claude-code-toolkit
```

## Usage

```bash
/context-primer              # Generate CLAUDE.md in project root
/context-primer docs/AI.md   # Write to custom path
```

## What it generates

- Project overview and tech stack
- Architecture and directory responsibilities
- Coding conventions (inferred from actual code)
- Common commands (from package.json, Makefile, CI)
- Important files with descriptions
- Gotchas and non-obvious context

Designed to be concise (<150 lines) and optimized as LLM context, not human documentation.
