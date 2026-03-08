# guard-secrets

PreToolUse hook that blocks `git add` and `git commit` if staged files contain potential secrets.

## Install

```bash
/plugin install guard-secrets@claude-code-toolkit
```

## How it works

Before any `Bash` tool use containing `git add` or `git commit`, this hook:

1. Identifies files being staged or already staged
2. Scans them for common secret patterns
3. Blocks the command if secrets are detected

## Detected patterns

| Pattern | Example |
|---------|---------|
| AWS Access Keys | `AKIA...` |
| OpenAI / Stripe Keys | `sk-...` |
| GitHub PATs | `ghp_...`, `gho_...` |
| GitLab PATs | `glpat-...` |
| Private Keys | `-----BEGIN PRIVATE KEY-----` |
| Slack Tokens | `xoxb-...`, `xoxp-...` |

## Requirements

- `jq` must be installed
- `git` must be available
