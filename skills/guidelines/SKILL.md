---
description: Fetch coding guidelines for a specific technology
allowed-tools:
  - mcp__erold-pm__get_guidelines
---

# Erold Guidelines

Retrieve coding guidelines for a specified technology or topic.

## Steps

1. Determine the topic from $ARGUMENTS or from the project's tech stack
2. Call `get_guidelines(topic)` to fetch standards
3. Present the key rules and patterns

## Available Topics

| Topic | Description |
|-------|-------------|
| `nextjs` | Next.js 15 App Router patterns, Server Components |
| `fastapi` | Python FastAPI async patterns, Pydantic |
| `security` | OWASP 2025 application security |
| `security-cloud` | Azure/AWS cloud security, IAM |
| `testing` | Integration testing standards |
| `bicep` | Azure infrastructure as code |
| `typescript` | TypeScript strict patterns |
| `python` | Python best practices |
| `rust` | Rust patterns, error handling |

## Arguments

$ARGUMENTS is the technology or topic name.

Examples:
- `/erold:guidelines nextjs` - Next.js guidelines
- `/erold:guidelines security` - Security guidelines
- `/erold:guidelines fastapi` - FastAPI guidelines

## Offline Fallback

If the API is unavailable, check for local guidelines in:
- `~/.claude/rules/` - User's global rules
- `.claude/rules/` - Project-specific rules
