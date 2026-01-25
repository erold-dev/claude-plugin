# Erold Automatic Workflow

You have access to Erold project management via MCP tools. USE THEM PROACTIVELY.

## Automatic Task Management

### When user describes work → CREATE TASK
```
User: "Add dark mode" or "Fix the login bug" or "Update the API"
YOU: Immediately call create_task, then start_task, then implement
```

### When starting implementation → START TASK
Before your first Edit/Write, ensure a task is in-progress. Create one if needed.

### When work is complete → COMPLETE TASK
When done (user confirms, tests pass, feature works), call complete_task with summary.

## Automatic Knowledge Capture

### When you fix an error → SAVE IT
After solving any error (especially after multiple attempts):
```
call create_knowledge(
  title="Fix: {error}",
  category="troubleshooting",
  content="Problem: ...\nSolution: ..."
)
```

### When you discover a pattern → SAVE IT
When implementing something reusable:
```
call create_knowledge(
  title="{Pattern name}",
  category="patterns",
  content="When to use: ...\nImplementation: ..."
)
```

### When you finally solve something hard → SAVE IT
After struggling and finding the solution:
```
call create_knowledge(
  title="Solution: {problem}",
  category="troubleshooting",
  content="Tried: ...\nWorked: ...\nWhy: ..."
)
```

## Automatic Guidelines

Before implementing significant features, fetch relevant guidelines:
- React/Next.js → `get_guidelines("nextjs")` or `get_guidelines("react")`
- Python/FastAPI → `get_guidelines("fastapi")`
- Security-sensitive → `get_guidelines("security")`
- API work → `get_guidelines("api")`

## Quick Reference

| User says | You do |
|-----------|--------|
| "Add/implement/build X" | `create_task` → `start_task` → implement |
| "Fix bug/error X" | `create_task` → `start_task` → fix → `create_knowledge` |
| "Done/finished/looks good" | `complete_task` with summary |
| "I'm stuck/blocked" | `block_task` with reason |
| Starting new session | Check `get_context` for active tasks |

## Don't Ask - DO

- ❌ "Would you like me to create a task?"
- ✅ Create the task, tell user it's created

- ❌ "Should I save this to the knowledge base?"
- ✅ Save it, tell user it's saved

- ❌ "Remember to mark the task complete"
- ✅ Complete it when the work is done
