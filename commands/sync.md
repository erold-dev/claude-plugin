---
description: Sync local project state with Erold PM
---

# Sync with Erold

Synchronize local project state with Erold project management.

## What This Does

1. **Checks Erold context** - Gets project, tasks, knowledge, tech info
2. **Checks local `.erold.json`** - Verifies project link is valid
3. **Explores codebase** - Scans actual code to assess progress
4. **Compares & syncs** - Updates Erold tasks if code is ahead

## Usage

```
/erold:sync
```

## Sync Process

### 1. Load Erold State

```
get_context()
get_project(projectId)
get_tech_info(projectId)
get_project_tasks(projectId)
list_knowledge(projectId, scope="combined")
```

### 2. Check Local State

- Read `.erold.json` for project link
- Verify projectId exists and matches

### 3. Explore Codebase

**This is critical.** Use the Explore agent to:
- Scan project structure
- Check what's actually implemented
- Identify completed work
- Find work in progress

### 4. Compare & Update

| Code State | Erold Task | Action |
|------------|------------|--------|
| Feature complete | Status: todo | → Update to `done` |
| Work started | Status: todo | → Update to `in-progress` |
| Blocked/broken | Status: in-progress | → Update to `blocked` |
| Not started | Status: done | → Flag as incorrect |

### 5. Report & Apply

Show comparison, then:
- Auto-update task statuses
- Add comments with implementation details
- Create tasks for undocumented work found in code

## Output Format

```
🔄 Erold Sync
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📁 Project: {name}
🔗 Local: .erold.json valid

📊 Erold State:
  • Tasks: X (Y in-progress, Z todo)
  • Knowledge: N articles

🔍 Code Analysis:
  • Explored: {directories scanned}
  • Files: {count}

⚠️ Out of Sync:
  • "Task A" - Erold: todo → Code: complete ✅
  • "Task B" - Erold: in-progress → Code: not started ❌

📝 Actions Taken:
  • Updated "Task A" to done
  • Added comment to "Task B"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Important

**Always explore the code.** Don't just check `.erold.json`. The value of sync is comparing what Erold thinks vs what's actually in the codebase.

## When to Use

- Starting a work session
- After implementing features
- Before standup/reporting
- When tasks seem stale
