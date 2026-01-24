---
description: Sync local work with Erold PM
---

# Sync with Erold

Synchronize local changes and git history with Erold project management.

## What This Does

1. **Scans git history** - Reviews recent commits
2. **Matches to tasks** - Links commits to Erold tasks
3. **Updates progress** - Logs time and updates task status
4. **Creates missing tasks** - For untracked work (optional)

## Sync Types

### Default Sync
```
/erold:sync
```

Syncs current session:
- Recent commits since last sync
- Uncommitted changes
- TODO/FIXME comments

### Full Sync
```
/erold:sync --full
```

Syncs entire branch:
- All commits on current branch
- Creates tasks for untracked commits
- Generates session report

### Dry Run
```
/erold:sync --dry-run
```

Preview what would be synced without making changes.

## Output Format

```
🔄 Erold Sync
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 Commits Analyzed: 5

✅ Linked to Tasks:
  • abc1234 "Add auth middleware" → [TASK-123]
  • def5678 "Fix login redirect" → [TASK-124]

⚠️ Untracked Commits:
  • ghi9012 "Update README"
  • jkl3456 "Add dark mode styles"

📋 TODO Comments Found:
  • src/auth.ts:45 - TODO: Add rate limiting
  • src/api.ts:120 - FIXME: Handle edge case

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Actions:
  [1] Create tasks for untracked commits
  [2] Create tasks for TODO comments
  [3] Skip and continue

Select: [1,2]
```

## Commit-Task Matching

Commits are matched to tasks by:
1. **Task ID in message** - `[TASK-123]` or `#123`
2. **Task title similarity** - Fuzzy match on task titles
3. **Branch name** - `feature/TASK-123-description`

## TODO/FIXME Scanning

Finds actionable comments:
- `TODO:` - Creates new tasks
- `FIXME:` - Creates high-priority tasks
- `HACK:` - Creates tech debt tasks
- `@erold:` - Custom Erold markers

## Options

```
/erold:sync                    # Sync current session
/erold:sync --full             # Sync entire branch
/erold:sync --dry-run          # Preview only
/erold:sync --auto-create      # Auto-create tasks (no prompt)
/erold:sync --skip-todos       # Skip TODO scanning
/erold:sync --since "2 days"   # Sync from specific time
```

## Git Integration

For automatic sync on commit, add to `.git/hooks/post-commit`:
```bash
#!/bin/bash
erold sync --auto >/dev/null 2>&1 &
```

## Notes

- Sync is non-destructive (won't delete tasks)
- Duplicate commits are skipped
- Works with any git workflow (trunk, feature branches, etc.)
