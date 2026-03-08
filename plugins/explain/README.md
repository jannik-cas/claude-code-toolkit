# explain

Deep code explanation with call graph tracing and dependency mapping.

## Install

```bash
/plugin install explain@claude-code-toolkit
```

## Usage

```bash
/explain src/auth/login.ts    # Explain a file
/explain handlePayment        # Explain a function
/explain UserService          # Explain a class
```

## Features

- Traces call graphs (2 levels deep, both directions)
- Maps internal and external dependencies
- Identifies patterns and algorithms
- Highlights edge cases and gotchas
