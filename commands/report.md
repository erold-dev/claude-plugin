---
description: Generate progress report from Erold
---

# Erold Report

Generate a progress report for the current project or session.

## Report Types

### Session Report (Default)
```
/erold:report
```

What happened this session:
- Tasks started/completed
- Files changed
- Time logged
- Knowledge captured

### Daily Report
```
/erold:report --daily
```

Summary of today's work across all sessions.

### Weekly Report
```
/erold:report --weekly
```

Week's progress with trends.

### Project Report
```
/erold:report --project
```

Overall project status and metrics.

## Output Formats

### Console (Default)
```
📊 Session Report: frontend-app
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Duration: 2h 15m

✅ Completed (3):
  [123] Add dark mode toggle        1.5h
  [124] Fix login redirect          0.5h
  [125] Update user profile         0.5h

🔵 In Progress (1):
  [126] Implement notifications     0.5h logged

📁 Files Changed (12):
  src/components/DarkMode.tsx
  src/hooks/useTheme.ts
  src/pages/settings.tsx
  ... and 9 more

📚 Knowledge Added (1):
  "Theme Context Pattern" (architecture)

⏱️ Time Summary:
  Estimated: 4h
  Actual:    2.5h
  Efficiency: 160%

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Markdown Export
```
/erold:report --markdown
```

Generates markdown suitable for:
- Stand-up updates
- PR descriptions
- Documentation

```markdown
## Progress Report - 2025-01-24

### Completed
- [x] Add dark mode toggle (#123) - 1.5h
- [x] Fix login redirect (#124) - 0.5h
- [x] Update user profile (#125) - 0.5h

### In Progress
- [ ] Implement notifications (#126) - 0.5h logged

### Blockers
None

### Notes
- Added theme context pattern to knowledge base
- Total time: 2.5h (vs 4h estimated)
```

### JSON Export
```
/erold:report --json
```

Structured data for integrations:
```json
{
  "period": "session",
  "project": "frontend-app",
  "duration": "2h 15m",
  "tasks": {
    "completed": [...],
    "inProgress": [...],
    "blocked": [...]
  },
  "time": {
    "estimated": 240,
    "actual": 150
  },
  "files": [...],
  "knowledge": [...]
}
```

## Options

```
/erold:report                  # Session report
/erold:report --daily          # Today's work
/erold:report --weekly         # This week
/erold:report --project        # Full project status
/erold:report --markdown       # Markdown output
/erold:report --json           # JSON output
/erold:report --save           # Save to file
/erold:report --copy           # Copy to clipboard
```

## Use Cases

### Stand-up Prep
```
/erold:report --daily --markdown
```
Quick summary for daily stand-up.

### PR Description
```
/erold:report --markdown --copy
```
Generate and copy for PR body.

### Time Tracking
```
/erold:report --weekly --json
```
Export for time tracking systems.

### Team Updates
```
/erold:report --project
```
Full project status for stakeholders.
