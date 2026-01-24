---
name: erold-style
description: Consistent output formatting for Erold plugin
---

# Erold Output Style Guide

Use these formatting conventions for consistent Erold output.

## Headers

### Section Headers
```
📊 Section Title
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Subsection Headers
```
🎯 Subsection Title:
```

## Status Indicators

### Task Status
```
✅ Completed
🔵 In Progress
⚪ Todo
🔴 Blocked
⏸️ On Hold
```

### Priority
```
🔴 High priority
🟡 Medium priority
🟢 Low priority
```

### Verdicts
```
✅ APPROVE / SUCCESS / PASS
⚠️ WARNING / COMMENT / REVIEW
❌ REJECT / FAIL / ERROR
```

## Task Display

### Task List Item
```
[TASK-123] Task title                    status    priority
           ↳ Additional info if needed
```

### Task Detail Block
```
📋 Task: [123] Task Title
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Status: in-progress | Priority: high
Project: project-name
Assignee: @username
Due: 2025-01-15
Estimate: 2h | Logged: 1.5h

📝 Description:
Task description here...

✅ Acceptance Criteria:
  • Criterion 1
  • Criterion 2

💬 Comments (2):
  @user (2h ago): Comment text
  @ai (1h ago): Comment text

🏷️ Tags: #tag1 #tag2
```

## Progress Bars

### Percentage Bar
```
━━━━━━━━━━━━━━━━━━━━ 65%
```

### Distribution Bar
```
████████████░░░░░░░░ 60%
```

## Lists

### Simple List
```
  • Item 1
  • Item 2
  • Item 3
```

### Numbered List
```
  1. First item
  2. Second item
  3. Third item
```

### Checkbox List
```
  [x] Completed item
  [ ] Pending item
```

## Code Blocks

### Inline Code
```
Use `code` for inline.
```

### Code Block with Language
```typescript
const example = "code here"
```

## Tables

### Simple Table
```
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Value    | Value    | Value    |
```

## Alerts and Callouts

### Info
```
💡 Tip: Helpful information here
```

### Warning
```
⚠️ Warning: Something to be aware of
```

### Error
```
❌ Error: Something went wrong
```

### Success
```
✅ Success: Operation completed
```

## Separators

### Major Section
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Minor Section
```
───────────────────────────────
```

## Common Icons

### Categories
```
📋 Tasks
📁 Projects
📚 Knowledge
📊 Stats/Dashboard
🔍 Search
⚙️ Settings
🔧 Tech/Tools
🔐 Security/Vault
📝 Notes/Description
💬 Comments
🏷️ Tags
👤 User/Assignee
👥 Team
⏱️ Time
📅 Calendar/Due Date
🎯 Goals/Target
💡 Tips/Ideas
🚀 Launch/Deploy
```

### Actions
```
➕ Add/Create
✏️ Edit/Update
🗑️ Delete
🔄 Sync/Refresh
📤 Export
📥 Import
```

## Example Complete Output

```
📊 Erold Dashboard: my-project
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📈 Progress:
  ━━━━━━━━━━━━━━━━━━━━ 65%
  Completed: 13/20 tasks

🎯 Your Tasks:

  🔵 In Progress:
    [123] Add dark mode toggle       high   2h
    [124] Fix login redirect         high   1h

  ⚪ Todo:
    [125] Update documentation       low    1h

  🔴 Blocked:
    [126] Deploy to staging          high
          ↳ Waiting for AWS access

⚠️ Needs Attention:
  • Task 126 blocked for 2 days
  • Task 123 due tomorrow

📝 Recent Activity:
  • ✅ Completed: Setup auth flow (2h ago)
  • 🔵 Started: Add dark mode (1h ago)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 Tip: Use /erold:task start 125 to begin next task
```
