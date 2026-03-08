---
description: Load Erold project context, active intents, and recent history
allowed-tools:
  - mcp__erold-pm__get_context
---

# Erold Context

Load the current project context from Erold.

## Steps

1. Call `get_context()` (optionally with a project_id from `.erold.json`)
2. Present the returned context: project info, active intents, and recent activity

## Arguments

$ARGUMENTS can specify:
- A project ID to load context for a specific project
- Empty to auto-detect from `.erold.json`

Examples:
- `/erold:context` - Current project context
- `/erold:context proj_abc123` - Specific project
