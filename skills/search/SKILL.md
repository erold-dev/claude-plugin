---
description: Search Erold for previous decisions, errors, and observations
allowed-tools:
  - mcp__erold-pm__search
---

# Erold Search

Search across Erold fragments for previous decisions, errors, observations, and other captured context.

## Steps

1. Parse the user's query from $ARGUMENTS
2. Call `search(query)` with the query terms
3. Optionally filter by `project_id` or `type` (decision, error, file_change, observation)
4. Present results

## Arguments

$ARGUMENTS is the search query, optionally with filters.

Examples:
- `/erold:search authentication` - Search all for "authentication"
- `/erold:search "database migration"` - Search by phrase
- `/erold:search --type error websocket` - Search only errors
- `/erold:search --project proj_abc123 caching` - Search within a project
