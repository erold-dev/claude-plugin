# Erold - Project Management for AI Agents

You have Erold MCP tools. Use them automatically.

## Core Workflow

### Before Work
```
search_knowledge(query="problem or feature")  # Check existing solutions
search_tasks(query="related work")            # Check previous attempts
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

## Knowledge Format

Always include what didn't work:
```
## Problem
{description}

## What Didn't Work
- Approach 1 - Failed because: X
- Approach 2 - Failed because: Y

## Solution
{what worked}
```

## Quick Reference

| Situation | Do |
|-----------|-----|
| Starting work | `search_knowledge` → `create_task` → `start_task` |
| Something fails | `add_task_comment` with TRIED/FAILED |
| Work done | `complete_task` |
| Tricky fix solved | `create_knowledge` (if new) |
| User stuck | `block_task` with reason |

## Don't Ask - Do

- Create tasks automatically when user describes work
- Search knowledge before implementing
- Log failed attempts immediately
- Complete tasks when work is done
