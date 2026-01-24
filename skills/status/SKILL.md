---
description: Show Erold dashboard - tasks, progress, workload
allowed-tools:
  - mcp__erold-pm__get_dashboard
  - mcp__erold-pm__get_stats
  - mcp__erold-pm__get_workload
  - mcp__erold-pm__get_project_stats
  - mcp__erold-pm__list_tasks
  - mcp__erold-pm__get_context
---

# Erold Status Dashboard

Display workspace status and progress overview.

## Views

### Default Dashboard
```
/erold:status
```

Shows:
- Your assigned tasks by status
- Project progress
- Blockers requiring attention
- Recent activity summary

### Project Stats
```
/erold:status project
/erold:status project my-app
```

Shows:
- Task breakdown by status
- Task breakdown by priority
- Completion percentage
- Time logged vs estimated

### Team Workload
```
/erold:status workload
```

Shows:
- Tasks per team member
- Capacity distribution
- Overloaded members

### Activity Feed
```
/erold:status activity
```

Shows:
- Recent task changes
- Knowledge updates
- Team actions

## Output Formats

### Default Dashboard
```
📊 Erold Dashboard
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

👤 Your Tasks:
  🔵 In Progress: 2
  ⚪ Todo: 5
  🔴 Blocked: 1
  ✅ Completed (this week): 8

📈 Project: frontend-app
  ━━━━━━━━━━━━━━━━━━━━ 65%
  Completed: 13/20 tasks

⚠️ Needs Attention:
  [127] Deploy to staging - BLOCKED
        Waiting for AWS access

⏰ Due Soon:
  [123] Add dark mode (tomorrow)
  [124] Fix login redirect (in 2 days)

📝 Recent:
  • Completed: Setup auth flow (2h ago)
  • Started: Add dark mode (1h ago)
```

### Project Stats
```
📊 Project: frontend-app
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📈 Progress:
  ━━━━━━━━━━━━━━━━━━━━ 65%

📋 By Status:
  ✅ Completed:   13  ████████████░░░░░░░░
  🔵 In Progress:  3  ███░░░░░░░░░░░░░░░░░
  ⚪ Todo:         3  ███░░░░░░░░░░░░░░░░░
  🔴 Blocked:      1  █░░░░░░░░░░░░░░░░░░░

🎯 By Priority:
  🔴 High:    5
  🟡 Medium:  10
  🟢 Low:     5

⏱️ Time:
  Estimated: 45h
  Logged:    32h (71%)
```

### Workload View
```
👥 Team Workload
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

@alice    ████████░░  8 tasks (balanced)
@bob      ████████████ 12 tasks (heavy)
@charlie  ████░░░░░░  4 tasks (light)
@ai       ██████░░░░  6 tasks (balanced)

⚠️ @bob may be overloaded
💡 Consider reassigning some tasks to @charlie
```

## Arguments

$ARGUMENTS can be:
- Empty for default dashboard
- `project [slug]` for project stats
- `workload` for team view
- `activity` for recent events
- `--week` / `--month` for time scope

Examples:
- `/erold:status` - Full dashboard
- `/erold:status project` - Current project stats
- `/erold:status workload` - Team distribution
- `/erold:status activity --week` - This week's activity
