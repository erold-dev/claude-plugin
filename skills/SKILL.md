---
description: Quick Erold task operations - list, start, complete, block, search
allowed-tools:
  - mcp__erold-pm__list_tasks
  - mcp__erold-pm__get_task
  - mcp__erold-pm__start_task
  - mcp__erold-pm__complete_task
  - mcp__erold-pm__block_task
  - mcp__erold-pm__add_task_comment
  - mcp__erold-pm__search_tasks
  - mcp__erold-pm__get_blocked_tasks
  - mcp__erold-pm__update_task
---

# Erold Task Manager

Perform quick task operations without full workflow context.

## Subcommands

### List Tasks
```
/erold:task list              # My assigned tasks
/erold:task list all          # All project tasks
/erold:task list in-progress  # Tasks in progress
/erold:task list blocked      # Blocked tasks
/erold:task list todo         # Tasks to do
```

### Get Task Details
```
/erold:task 123               # Show task 123 details
/erold:task get 123           # Same as above
```

### Start Task
```
/erold:task start 123         # Mark task as in-progress
```

### Complete Task
```
/erold:task complete 123                    # Complete task
/erold:task complete 123 "Added feature X"  # Complete with summary
```

### Block Task
```
/erold:task block 123 "Waiting for API spec"  # Block with reason
```

### Unblock Task
```
/erold:task unblock 123       # Remove blocker, set to todo
```

### Add Comment
```
/erold:task comment 123 "Progress update: 50% done"
```

### Search Tasks
```
/erold:task search authentication    # Find auth-related tasks
/erold:task search "dark mode"       # Search by phrase
```

### Update Task
```
/erold:task update 123 --priority high
/erold:task update 123 --status todo
/erold:task update 123 --title "New title"
```

## Output Formats

### Task List
```
📋 My Tasks (5)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔵 In Progress:
  [123] Add dark mode toggle       high   2h
  [124] Fix login redirect         high   1h

⚪ Todo:
  [125] Update documentation       low    1h
  [126] Add unit tests             med    3h

🔴 Blocked:
  [127] Deploy to staging          high   1h
        ↳ Waiting for AWS access
```

### Task Details
```
📋 Task: [123] Add dark mode toggle
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Status: in-progress
Priority: high
Project: frontend-app
Assignee: @you
Estimate: 2h | Logged: 1.5h

📝 Description:
Add a dark mode toggle to the settings page.
Should persist preference to localStorage.

✅ Acceptance Criteria:
  • Toggle visible in settings
  • Theme changes immediately
  • Preference persists on reload

💬 Comments (2):
  @you (2h ago): Started implementation
  @ai (1h ago): Found existing theme context

🏷️ Tags: #frontend #ui #settings
```

## Arguments

$ARGUMENTS format: `[subcommand] [task_id] [additional_args]`

The subcommand is inferred if not provided:
- Number alone → get task details
- "list" → list tasks
- "start/complete/block" → status change
- Text without number → search

## Quick Actions

For rapid task management without full workflow overhead.
Use `/erold:execute` for full context when doing actual implementation.
