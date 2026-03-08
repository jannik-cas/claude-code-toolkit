# security-scan

Scan for hardcoded secrets, OWASP Top 10 patterns, and dependency CVEs.

## Install

```bash
/plugin install security-scan@claude-code-toolkit
```

## Usage

```bash
/security-scan            # Full project scan
/security-scan src/       # Scan specific directory
```

## Features

- Detects hardcoded API keys, tokens, passwords, and private keys
- Identifies OWASP Top 10 vulnerability patterns
- Runs dependency audit tools (npm audit, pip-audit, cargo audit)
- Groups findings by severity with remediation suggestions
