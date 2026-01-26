---
description: Sync local project state with Erold PM
---

# Sync with Erold

Synchronize local project state with Erold project management.

## What This Does

1. **Checks Erold context** - Gets current project state (tasks, knowledge, tech info)
2. **Compares local state** - Checks `.erold.json` and project configuration
3. **Syncs bidirectionally**:
   - Local has updates → Push to Erold
   - Local missing/corrupted → Restore from Erold

## Usage

```
/erold:sync
```

## Sync Process

### 1. Load Erold Context

```
get_context()
get_project(projectId)
get_tech_info(projectId)
```

### 2. Check Local State

- Read `.erold.json` for project link
- Verify projectId matches
- Check for local configuration

### 3. Compare & Sync

| Local State | Erold State | Action |
|-------------|-------------|--------|
| Valid | Valid | Show status |
| Outdated | Updated | Pull from Erold |
| Updated | Outdated | Push to Erold |
| Missing | Exists | Restore from Erold |
| Exists | Missing | Create in Erold |

## Output Format

```
🔄 Erold Sync
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📁 Project: {name}
🔗 Status: In sync | Out of sync | Not linked

📊 Erold State:
  • Tasks: 12 (3 in-progress, 2 blocked)
  • Knowledge: 5 articles
  • Tech Info: Configured

📋 Local State:
  • .erold.json: Valid
  • Project ID: {id}

✅ Sync complete - no changes needed
   OR
⚠️ Sync needed:
  • [action to take]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## When to Use

- Starting work on a project
- After switching machines
- If local state seems wrong
- To verify project is linked correctly

## Notes

- Non-destructive (asks before overwriting)
- Creates `.erold.json` if missing
- Updates local config from Erold if corrupted
