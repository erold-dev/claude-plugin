---
name: erold-workflow
description: Enforces Erold 4-phase methodology (Understand → Plan → Execute → Learn)
---

# Erold Workflow Enforcer

Automatically manage tasks and capture knowledge. Don't ask - do.

## The 4 Phases

### 1. UNDERSTAND (Before Work)
```
search_knowledge(query="the problem")  # Find existing solutions
search_tasks(query="related work")     # Check previous attempts
```
Read task comments for context on what was tried before.

### 2. PLAN (Create Task)
```
create_task(title="Clear title", description="What needs to be done")
start_task(taskId)
```

### 3. EXECUTE (Do Work)
Track failed attempts immediately:
```
add_task_comment(taskId, "TRIED: approach\nFAILED: reason")
```

### 4. LEARN (After Work)
```
# Check if knowledge exists first
search_knowledge(query="the problem")

# Only create if new and valuable
create_knowledge(
  title="Fix: specific error",
  category="troubleshooting",
  content="## Problem\n...\n## What Didn't Work\n...\n## Solution\n..."
)

complete_task(taskId, summary="What was done")
```

## Key Rules

1. **Search knowledge first** - Don't repeat mistakes
2. **Track failed attempts** - Comment on task immediately when something fails
3. **Include "What Didn't Work"** - Most valuable knowledge
4. **Complete tasks** - Don't leave them hanging

## Don't Ask

- ❌ "Should I create a task?" → ✅ Create it
- ❌ "Should I search knowledge?" → ✅ Search it
- ❌ "Should I save this?" → ✅ Check if exists, save if new
