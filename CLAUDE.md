# Erold Automatic Workflow

You have access to Erold project management via MCP tools. USE THEM PROACTIVELY.

## BEFORE Starting Any Work

### 1. SEARCH KNOWLEDGE FIRST
Before implementing or debugging, ALWAYS search for existing knowledge:
```
call search_knowledge(query="{problem or feature}")
```

**Why:** Prevents repeating mistakes, reuses proven solutions, saves time.

If knowledge found:
- Use the documented approach
- Skip things marked as "didn't work"
- Build on existing patterns

### 2. CHECK FOR SIMILAR TASKS
```
call search_tasks(query="{feature or bug}")
```
Look for previous attempts, blockers, or related work.

### 3. FETCH GUIDELINES
Before significant implementation:
- React/Next.js → `get_guidelines("nextjs")`
- Python/FastAPI → `get_guidelines("fastapi")`
- Security-sensitive → `get_guidelines("security")`
- API work → `get_guidelines("api")`

---

## DURING Work

### Auto-Create & Start Tasks
When user describes work:
```
User: "Add dark mode" or "Fix the login bug"
YOU:
1. search_knowledge for related info
2. create_task with clear title
3. start_task immediately
4. Then implement
```

### Track Failed Attempts
When something DOESN'T work, IMMEDIATELY save it:
```
call add_task_comment(
  taskId="current-task",
  content="TRIED: {approach}\nRESULT: Failed\nREASON: {why it failed}\nDON'T TRY: {what to avoid}"
)
```

**Critical:** This prevents wasting time on the same dead ends.

### Log Significant File Changes
After major edits, comment on the task:
```
call add_task_comment(
  taskId="current-task",
  content="Changed: {files}\nWhat: {summary of changes}"
)
```

### Track Errors Encountered
When an error occurs:
```
call add_task_comment(
  taskId="current-task",
  content="ERROR: {error message}\nCONTEXT: {what was happening}\nSTATUS: investigating"
)
```

When error is fixed, update with solution.

---

## AFTER Work Completes

### 1. Quality Review (Before Completing Task)
Before marking task complete, verify:
- [ ] Task requirements met (check original task description)
- [ ] Code follows project conventions
- [ ] No obvious bugs or security issues
- [ ] Tests pass (if applicable)

If issues found, fix them first.

### 2. Extract Learnings (If Valuable)
**Check if learning already exists:**
```
call search_knowledge(query="{the problem or pattern}")
```

**Only create if NEW and VALUABLE:**
```
call create_knowledge(
  title="Fix: {specific error}" or "Pattern: {pattern name}",
  category="troubleshooting" or "architecture" or "performance",
  content="## Problem\n...\n## Solution\n...\n## What Didn't Work\n..."
)
```

**Always include "What Didn't Work" section** - this is gold for future sessions.

### 3. Complete Task with Summary
```
call complete_task(
  taskId="task-id",
  summary="What was done, key decisions, files changed"
)
```

---

## Knowledge Categories

| Category | Use For |
|----------|---------|
| `troubleshooting` | Errors fixed, debugging approaches, what didn't work |
| `architecture` | System design, component structure, decisions |
| `patterns` | Reusable code patterns, implementations |
| `performance` | Optimizations, what made things faster |
| `security` | Vulnerabilities found, security patterns |
| `conventions` | Project-specific standards |
| `api` | API design, integration patterns |

---

## "Didn't Work" Knowledge Pattern

When saving troubleshooting knowledge, ALWAYS include:

```markdown
## Problem
{What was the issue}

## What Didn't Work
- Approach 1: {description} - Failed because: {reason}
- Approach 2: {description} - Failed because: {reason}

## What Worked
{The actual solution}

## Why It Worked
{Explanation}

## Prevention
{How to avoid this in future}
```

---

## Session Start Checklist

When starting a new session:
1. `get_context` - Load workspace state
2. Check for in-progress tasks
3. If resuming work, read task comments for context
4. Search knowledge for relevant patterns

---

## Session End Checklist

Before session ends:
1. Complete or update task status
2. Add final comment summarizing progress
3. Save any learnings discovered
4. Note any blockers for next session

---

## Quick Reference

| Situation | Action |
|-----------|--------|
| User describes work | `search_knowledge` → `create_task` → `start_task` → implement |
| Before implementing | `search_knowledge` → `get_guidelines` |
| Something doesn't work | `add_task_comment` with TRIED/FAILED/REASON |
| Error encountered | `add_task_comment` with error details |
| Error fixed | `create_knowledge` (if not exists) with solution + what didn't work |
| Work complete | Quality check → `create_knowledge` (if new) → `complete_task` |
| User says "stuck/blocked" | `block_task` with reason |
| Pattern discovered | `search_knowledge` (check exists) → `create_knowledge` |

---

## DON'T ASK - DO

- ❌ "Would you like me to create a task?"
- ✅ Create the task, tell user it's created

- ❌ "Should I search the knowledge base?"
- ✅ Search it, use what you find

- ❌ "Should I save this to knowledge?"
- ✅ Check if exists, save if new and valuable

- ❌ "Remember to track that attempt"
- ✅ Add task comment immediately

- ❌ "The task might be complete"
- ✅ Verify requirements met, then complete it
