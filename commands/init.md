---
description: Initialize Erold tracking for the current project
---

# Initialize Erold

Set up Erold project management for this codebase.

## Execution Steps

### Step 1: Check for Existing Config

First, check if `.erold.json` already exists in the project root:

```
if .erold.json exists AND has valid projectId:
  → Show "Already configured for project: {projectName}"
  → Load context using get_context MCP tool
  → DONE
```

### Step 2: Detect Tech Stack

Scan project files to detect technologies:

| File | Technologies |
|------|-------------|
| `package.json` with `next` | nextjs, react, typescript |
| `package.json` with `react` (no next) | react, typescript |
| `package.json` with `tailwindcss` | tailwind |
| `package.json` with `@tauri-apps` | desktop |
| `package.json` with `electron` | desktop |
| `Cargo.toml` | systems (Rust) |
| `pyproject.toml` or `requirements.txt` with `fastapi` | fastapi |
| `pyproject.toml` or `requirements.txt` with `django` | backend |
| `requirements.txt` with `anthropic` or `openai` | ai |
| `pubspec.yaml` | mobile (Flutter) |
| `*.swift` or `Package.swift` | mobile (iOS) |
| `*.bicep` or `*.tf` | cloud, devops |
| `firebase.json` | cloud |
| `serverless.yml` or `lambda/` | cloud |

Always include: `security`, `testing`

### Step 3: Connect to Erold (REQUIRED)

**You MUST use MCP tools to create or link a project:**

```
1. Use list_projects MCP tool to get existing projects
2. Check if any project name matches the directory name
3. If match found:
   → Ask user: "Found existing project '{name}'. Link to it?"
   → If yes, use that projectId
4. If no match OR user wants new:
   → Use create_project MCP tool to create new project
   → Get the new projectId from the response
```

**IMPORTANT:** The projectId must NOT be null. Always create or link to an actual Erold project.

### Step 4: Save Configuration

Write `.erold.json` with the ACTUAL projectId:

```json
{
  "projectId": "ACTUAL_PROJECT_ID_FROM_EROLD",
  "projectName": "project-name",
  "settings": {
    "autoContext": true,
    "workflowEnforcement": true,
    "guidelinesCategories": ["detected", "guidelines", "here"]
  }
}
```

### Step 5: Confirm Setup

After saving, use get_project MCP tool to verify the connection works.

## Example Output

```
🚀 Initialize Erold for this project
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Step 1: Detect Tech Stack
  Found: package.json → Next.js 15, React 19, Tailwind CSS

Step 2: Select Guidelines
  Auto-selected: nextjs, react, typescript, tailwind, security, testing

Step 3: Connect to Erold
  Checking existing projects...
  [MCP: list_projects]

  Found matching project: "my-awesome-app" (id: abc123)
  → Linking to existing project

Step 4: Save Configuration
  ✓ Created .erold.json with projectId: abc123

Step 5: Verify Connection
  [MCP: get_project projectId="abc123"]
  ✓ Connected to Erold project: my-awesome-app

✓ Ready to use Erold!
  Run /erold:status to see your dashboard
```

## If No Matching Project Found

```
Step 3: Connect to Erold
  Checking existing projects...
  [MCP: list_projects]

  No matching project found.
  → Creating new project: "my-awesome-app"
  [MCP: create_project name="my-awesome-app"]

  ✓ Created project with ID: xyz789
```

## Guideline Categories

Available topics (pick based on tech stack):
- **Frontend**: nextjs, react, typescript, tailwind, uiux
- **Backend**: fastapi, api, backend, database
- **Systems**: systems (Go, Rust, C++)
- **Mobile**: mobile (Flutter, Swift, Kotlin)
- **Desktop**: desktop (Tauri, Electron)
- **Cloud**: cloud (AWS, Azure, Firebase), devops
- **AI**: ai (LLM, RAG, Anthropic, OpenAI)
- **Always**: security, testing

## Options

```
/erold:init                    # Auto-detect and create/link
/erold:init --link proj_123    # Link to specific project ID
/erold:init --new "My Project" # Force create new project
```

## After Initialization

Next steps:
1. `/erold:status` - See task dashboard
2. `/erold:context` - Load full workspace context
3. `/erold:guidelines` - Fetch coding standards

## Notes

- `.erold.json` should be committed to version control
- Team members will auto-connect to the same project
- Guidelines can be manually adjusted in `.erold.json`
- Re-run `/erold:init` to update tech stack detection
