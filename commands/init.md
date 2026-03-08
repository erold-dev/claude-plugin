---
description: Initialize Erold tracking for the current project
---

# Initialize Erold

Set up Erold Context Engine for this codebase.

## Execution Steps

### Step 1: Check for Existing Config

First, check if `.erold.json` already exists in the project root:

```
if .erold.json exists AND has valid projectId:
  -> Show "Already configured for project: {projectName}"
  -> Call get_context() to load context
  -> DONE
```

### Step 2: Detect Tech Stack

Scan project files to detect technologies:

| File | Technologies |
|------|-------------|
| `package.json` with `next` | nextjs, react, typescript |
| `package.json` with `react` (no next) | react, typescript |
| `package.json` with `tailwindcss` | tailwind |
| `package.json` with `@tauri-apps` | desktop |
| `Cargo.toml` | systems (Rust) |
| `pyproject.toml` or `requirements.txt` with `fastapi` | fastapi |
| `*.bicep` or `*.tf` | cloud, devops |
| `firebase.json` | cloud |

### Step 3: Connect to Erold (REQUIRED)

**You MUST use MCP tools to create or link a project:**

```
1. Use list_projects MCP tool to get existing projects
2. Check if any project name matches the directory name
3. If match found:
   -> Ask user: "Found existing project '{name}'. Link to it?"
   -> If yes, use that projectId
4. If no match OR user wants new:
   -> Use create_project MCP tool to create new project
   -> Get the new projectId from the response
```

**IMPORTANT:** The projectId must NOT be null. Always create or link to an actual Erold project.

### Step 4: Save Configuration

Write `.erold.json`:

```json
{
  "projectId": "ACTUAL_PROJECT_ID_FROM_EROLD",
  "projectName": "project-name"
}
```

### Step 5: Confirm Setup

Call `get_context()` to verify the connection works and load initial context.

## Options

```
/erold:init                    # Auto-detect and create/link
/erold:init --link proj_123    # Link to specific project ID
/erold:init --new "My Project" # Force create new project
```

## Notes

- `.erold.json` should be committed to version control
- Team members will auto-connect to the same project
- Re-run `/erold:init` to update tech stack detection
