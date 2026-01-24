---
description: Search Erold tasks and knowledge base
allowed-tools:
  - mcp__erold-pm__search_tasks
  - mcp__erold-pm__search_knowledge
  - mcp__erold-pm__list_tasks
  - mcp__erold-pm__list_knowledge
---

# Erold Search

Search across Erold for tasks, knowledge, and context.

## Search Targets

### Tasks Only
```
/erold:search tasks authentication
/erold:search tasks "dark mode"
/erold:search tasks --status in-progress
/erold:search tasks --priority high
```

### Knowledge Only
```
/erold:search knowledge caching
/erold:search knowledge "error handling"
/erold:search knowledge --category security
```

### Everything (Default)
```
/erold:search authentication           # Search all
/erold:search "payment processing"     # Search all
```

## Search Options

| Option | Description | Example |
|--------|-------------|---------|
| `--status` | Filter tasks by status | `--status todo` |
| `--priority` | Filter tasks by priority | `--priority high` |
| `--category` | Filter knowledge by category | `--category testing` |
| `--project` | Scope to specific project | `--project my-app` |
| `--limit` | Max results | `--limit 5` |

## Output Format

```
🔍 Search Results: "{query}"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Tasks (3 found):

  [123] Implement OAuth authentication    in-progress  high
        Project: backend-api

  [456] Add auth middleware               todo         med
        Project: backend-api

  [789] Fix auth token refresh            completed    high
        Project: frontend-app

📚 Knowledge (2 found):

  JWT Refresh Token Pattern               security     global
  Preview: Implement refresh tokens with...

  OAuth 2.0 Integration Guide             api          project:backend-api
  Preview: Steps to integrate OAuth...

💡 Tip: Use /erold:task 123 or /erold:knowledge 456 for details
```

## Use Cases

### Finding Related Work
```
/erold:search "user registration"
```
→ Find past tasks and knowledge about user registration

### Checking for Existing Patterns
```
/erold:search knowledge "error handling"
```
→ Find established error handling patterns

### Finding Blocked Work
```
/erold:search tasks --status blocked
```
→ List all blocked tasks

### Finding High Priority Items
```
/erold:search tasks --priority high --status todo
```
→ Find urgent work to pick up

## Arguments

$ARGUMENTS format: `[target] <query> [options]`

- `target`: `tasks`, `knowledge`, or omit for all
- `query`: Search terms (quote phrases)
- `options`: Filters like `--status`, `--category`

Examples:
- `/erold:search api endpoints` - Search all for "api endpoints"
- `/erold:search tasks database migration` - Search tasks only
- `/erold:search knowledge --category performance` - Browse performance knowledge
