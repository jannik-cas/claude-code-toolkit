# deps

Analyze outdated and vulnerable dependencies across package managers.

## Install

```bash
/plugin install deps@claude-code-toolkit
```

## Usage

```bash
/deps                  # Full summary
/deps outdated         # List outdated packages
/deps vulnerabilities  # Security audit
/deps unused           # Find unused dependencies
/deps update react     # Impact analysis
```

## Features

- Supports npm, yarn, pnpm, pip, cargo, go, and bundler
- Shows outdated packages with version comparison
- Runs security audits for known CVEs
- Identifies potentially unused dependencies
