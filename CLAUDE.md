# Erold - Project Management for AI Agents

You have Erold MCP tools. Use them automatically.

## Search Order (Critical)

**Before exploring code, ALWAYS search Erold first:**

```
1. search_knowledge(query="...")     # Existing solutions, patterns, docs
2. search_tasks(query="...")         # Previous work, failed attempts
3. get_tech_info(projectId)          # Project stack, commands, notes
4. THEN explore codebase             # Only if Erold doesn't have answer
```

This saves time - Erold may already have the answer or document what didn't work.

## Core Workflow

### Before Work
```
search_knowledge(query="problem or feature")
search_tasks(query="related work")
```
Use what you find. Skip approaches marked as "didn't work".

### During Work
```
create_task → start_task → implement
```

When something fails:
```
add_task_comment(taskId, "TRIED: X\nFAILED: reason\nDON'T RETRY: this approach")
```

### After Work
```
complete_task(taskId, summary="what was done")
```

If you fixed a tricky error or discovered a pattern:
```
search_knowledge(query="check if exists")
# Only if new:
create_knowledge(title="Fix: error" or "Pattern: name", category="troubleshooting", content="...")
```

## Quick Reference

| Situation | Do |
|-----------|-----|
| Looking for something | `search_knowledge` → `search_tasks` → then explore code |
| Starting work | `search_knowledge` → `create_task` → `start_task` |
| Something fails | `add_task_comment` with TRIED/FAILED |
| Work done | `complete_task` |
| Tricky fix solved | `create_knowledge` (if new) |
| User stuck | `block_task` with reason |

## Don't Ask - Do

- Search Erold BEFORE exploring codebase
- Create tasks automatically when user describes work
- Log failed attempts immediately
- Complete tasks when work is done
