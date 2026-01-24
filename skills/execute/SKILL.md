---
description: Start working on an Erold task with full context and guidelines
allowed-tools:
  - mcp__erold-pm__get_task
  - mcp__erold-pm__start_task
  - mcp__erold-pm__complete_task
  - mcp__erold-pm__add_task_comment
  - mcp__erold-pm__get_knowledge
  - mcp__erold-pm__search_knowledge
  - mcp__erold-pm__get_tech_info
  - mcp__erold-pm__get_guidelines
  - Read
  - Edit
  - Write
  - Glob
  - Grep
  - Bash
---

# Erold Executor

Begin execution of a specific task with all necessary context. This is the **EXECUTE** phase of the Erold methodology.

## When to Use
- When ready to implement a planned task
- When picking up assigned work
- After planning is complete

## Erold Methodology - EXECUTE Phase

### 1. Start the Task
Call `start_task` with the task ID to:
- Mark task as in-progress
- Begin time tracking
- Signal to team you're working on it

### 2. Load Task Context
Call `get_task` to retrieve:
- Full task description
- Acceptance criteria
- Related tasks and dependencies
- Previous comments

### 3. Fetch Guidelines
Call `get_guidelines` for:
- Coding standards for this work
- Security requirements
- Testing expectations

### 4. Check Knowledge Base
Call `search_knowledge` to find:
- Relevant patterns to apply
- Past learnings that help
- Pitfalls to avoid

### 5. Implement Incrementally
Work in small, validated steps:
- Make changes that can be tested
- Follow project patterns
- Apply knowledge base learnings
- Adhere to guidelines

### 6. Log Progress
Use `add_task_comment` to:
- Note significant progress
- Document decisions made
- Flag any blockers encountered

### 7. Complete When Done
Call `complete_task` with:
- Summary of what was done
- Any notes for future reference

## Execution Rules

- **Follow Guidelines**: Apply coding standards strictly
- **Use Patterns**: Leverage knowledge base entries
- **Validate Often**: Test changes incrementally
- **Document Decisions**: Comment on non-obvious choices
- **Stay Focused**: Work only on the current task

## Output Format

When starting:
```
🚀 Starting Task: [TASK-123]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Task: {task_title}
📝 Description: {task_description}

✅ Acceptance Criteria:
  • {criterion_1}
  • {criterion_2}

📚 Relevant Knowledge:
  • {pattern_to_apply}

📋 Guidelines to Follow:
  • {relevant_guideline}

🔧 Starting implementation...
```

When completing:
```
✅ Task Completed: [TASK-123]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 Summary: {what_was_done}

📁 Files Changed:
  • src/components/Feature.tsx
  • src/hooks/useFeature.ts

💡 Learnings to Capture:
  • {potential_learning}

➡️ Next Task: [TASK-124] {next_task_title}
```

## Arguments

$ARGUMENTS should be:
- Task ID: `/erold:execute 123`
- Task search: `/erold:execute "authentication"`
- `next`: `/erold:execute next` - Pick up next assigned task

Examples:
- `/erold:execute 456` - Start task 456
- `/erold:execute "dark mode"` - Find and start dark mode task
- `/erold:execute next` - Start next prioritized task

## Important

- NEVER start execution without a task
- If no task exists, use `/erold:plan` first
- Keep task updated with progress
- Complete task when acceptance criteria are met
