# changelog

Generate changelogs from git history in Keep a Changelog or GitHub Releases format.

## Install

```bash
/plugin install changelog@claude-code-toolkit
```

## Usage

```bash
/changelog                          # Since last tag
/changelog v1.0.0                   # Since specific ref
/changelog github-releases v2.0.0   # GitHub Releases format
```

## Features

- Groups commits by conventional commit type
- Supports Keep a Changelog and GitHub Releases formats
- Appends to existing CHANGELOG.md
- Auto-detects tag range
