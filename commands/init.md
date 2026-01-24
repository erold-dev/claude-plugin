---
description: Initialize Erold tracking for the current project
---

# Initialize Erold

Set up Erold project management for this codebase.

## What This Does

1. **Checks for existing Erold project** - Looks for `.erold.json` config
2. **Prompts for setup** - If not found, guides through configuration
3. **Creates config file** - Saves `.erold.json` with project settings
4. **Loads initial context** - Fetches project state from Erold

## Setup Flow

### If Already Configured
```
✓ Erold already configured for this project
  Project: my-awesome-app
  Tenant: acme-corp

Loading context...
```

### If Not Configured
```
🚀 Initialize Erold for this project
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Step 1: Connect to Erold
  Enter your tenant slug: [acme-corp]

Step 2: Select or Create Project
  Found existing projects:
    1. frontend-app
    2. backend-api
    3. [Create new project]

  Select: [1]

Step 3: Configure Defaults
  Default assignee for AI tasks: [me/@username]
  Auto-load context on session start: [yes]
  Enable workflow enforcement: [yes]

✓ Created .erold.json
✓ Project linked: frontend-app
✓ Ready to use Erold!

Try: /erold:context to load current state
```

## Config File Format

Creates `.erold.json` in project root:

```json
{
  "tenant": "acme-corp",
  "project": "frontend-app",
  "projectId": "proj_abc123",
  "settings": {
    "defaultAssignee": "me",
    "autoContext": true,
    "workflowEnforcement": true,
    "guidelinesCategories": ["nextjs", "security", "testing"]
  }
}
```

## Options

```
/erold:init                    # Interactive setup
/erold:init --tenant acme      # Specify tenant
/erold:init --project my-app   # Specify project
/erold:init --link proj_123    # Link to existing project ID
/erold:init --new "My Project" # Create new project
```

## After Initialization

Recommended next steps:
1. `/erold:context` - Load current project state
2. `/erold:guidelines` - Fetch relevant coding standards
3. `/erold:status` - See task dashboard

## Notes

- `.erold.json` should be committed to version control
- Team members will auto-connect to the same project
- API key is NOT stored in config (use environment variable)
