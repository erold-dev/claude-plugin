---
description: Load Erold workspace context including projects, tasks, knowledge, and tech stack
allowed-tools:
  - mcp__erold-pm__get_context
  - mcp__erold-pm__get_dashboard
  - mcp__erold-pm__list_knowledge
  - mcp__erold-pm__get_tech_info
  - mcp__erold-pm__get_project
  - mcp__erold-pm__list_projects
---

# Erold Context Loader

Load the current Erold workspace context to understand what you're working on. This is the **UNDERSTAND** phase of the Erold methodology.

## When to Use
- At the start of a coding session
- When switching between projects
- When you need to understand current state
- Before planning new work

## Steps

1. **Get Workspace Context**
   Call `get_context` to retrieve:
   - Active project details
   - Current tasks (assigned, in-progress, blocked)
   - Recent activity
   - Relevant knowledge base entries

2. **Get Dashboard**
   Call `get_dashboard` for:
   - Your assigned tasks prioritized by due date
   - Upcoming deadlines
   - Recent completions

3. **Load Knowledge**
   Call `list_knowledge` with scope "combined" to get:
   - Global patterns and learnings
   - Project-specific knowledge

4. **Get Tech Stack** (if project active)
   Call `get_tech_info` to understand:
   - Frontend/backend technologies
   - Deployment configuration
   - Useful commands
   - Technical notes

## Output Format

Present a concise summary:

```
📋 Erold Context: {project_name}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 Active Tasks:
  • [TASK-123] Task title (in-progress, high)
  • [TASK-124] Another task (todo, medium)

⚠️ Blockers:
  • [TASK-125] Blocked task - Reason

📚 Relevant Knowledge:
  • Pattern: Caching strategy for API calls
  • Convention: Error handling in services

🛠️ Tech Stack:
  • Frontend: Next.js 15, React 19
  • Backend: FastAPI, PostgreSQL
  • Deployment: Vercel, AWS

📝 Recent Activity:
  • Task completed: Setup auth flow
  • Knowledge added: JWT refresh pattern
```

## Arguments

$ARGUMENTS can specify:
- A project slug to load context for a specific project
- `--full` to include all details
- `--tasks-only` to focus on tasks

Examples:
- `/erold:context` - Current project context
- `/erold:context my-project` - Specific project
- `/erold:context --tasks-only` - Just tasks
