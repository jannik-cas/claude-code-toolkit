# diff-narrator

Generate narrated walkthroughs of diffs and pull requests — not dry change lists, but stories that explain *why*.

## Install

```bash
/plugin install diff-narrator@claude-code-toolkit
```

## Usage

```bash
/diff-narrator                     # Current uncommitted changes
/diff-narrator HEAD~5              # Last 5 commits
/diff-narrator main..feature/auth  # Branch diff
/diff-narrator --pr 42             # Pull request
```

## Features

- Groups changes by intent, not by file
- Explains the *why* behind each change
- Highlights breaking changes and review risks
- Works with local diffs, commit ranges, and GitHub PRs
