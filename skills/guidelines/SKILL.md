---
description: Fetch Erold coding guidelines for technologies
allowed-tools:
  - mcp__erold-pm__get_guidelines
  - mcp__erold-pm__search_guidelines
  - mcp__erold-pm__list_guidelines
  - mcp__erold-pm__get_tech_info
  - WebFetch
---

# Erold Guidelines

Retrieve coding guidelines from erold.dev for specified technologies.

## When to Use
- Before starting implementation
- When unsure about coding standards
- When reviewing code
- When onboarding to a new tech stack

## Available Categories

| Category | Description |
|----------|-------------|
| `nextjs` | Next.js 15 App Router patterns, Server Components, data fetching |
| `fastapi` | Python FastAPI async patterns, Pydantic, dependency injection |
| `security` | OWASP 2025 application security, input validation, auth |
| `security-cloud` | Azure/AWS cloud security, IAM, secrets management |
| `testing` | Integration testing standards, no mocks, real resources |
| `bicep` | Azure infrastructure as code, modules, naming |
| `typescript` | TypeScript strict patterns, type safety |
| `python` | Python best practices, type hints, async |
| `rust` | Rust patterns, memory safety, error handling |

## Steps

### 1. Determine Relevant Technologies
Either from:
- User request specifying technology
- Project tech stack via `get_tech_info`
- File types being worked on

### 2. Fetch Guidelines
Call `get_guidelines` with category to retrieve:
- Key rules and patterns
- Code examples
- Common mistakes to avoid
- Best practices

### 3. Search Across Guidelines (Optional)
Call `search_guidelines` to find:
- Specific topics across all categories
- Cross-cutting concerns (e.g., "error handling")

### 4. Present Actionable Guidance
Summarize for the current task:
- Most relevant rules (5-10 points)
- Code examples where helpful
- Common mistakes to avoid

## Output Format

```
📋 Guidelines: {category}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 Key Rules:

1. **{Rule Title}**
   {Rule description}
   ```{language}
   {code_example}
   ```

2. **{Rule Title}**
   {Rule description}

⚠️ Common Mistakes:
  • {mistake_1}
  • {mistake_2}

📚 Full guidelines: https://erold.dev/guidelines/{category}
```

## Arguments

$ARGUMENTS is the technology/category:
- `/erold:guidelines nextjs` - Next.js guidelines
- `/erold:guidelines security` - Security guidelines
- `/erold:guidelines fastapi testing` - Multiple categories
- `/erold:guidelines` - Auto-detect from project tech stack

## Combining with Workflow

Guidelines integrate with other Erold phases:

- **PLAN**: Fetch guidelines to inform task breakdown
- **EXECUTE**: Reference guidelines during implementation
- **LEARN**: Compare against guidelines when capturing patterns

## Offline Fallback

If API unavailable, check for local guidelines in:
- `~/.claude/rules/` - User's global rules
- `.claude/rules/` - Project-specific rules
- Cached guidelines from previous fetches
