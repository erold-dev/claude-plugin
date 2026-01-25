---
description: Initialize Erold tracking for the current project
---

# Initialize Erold

Set up Erold project management for this codebase.

## What This Does

1. **Checks for existing Erold project** - Looks for `.erold.json` config
2. **Detects tech stack** - Scans package.json, Cargo.toml, pyproject.toml, etc.
3. **Auto-selects guidelines** - Based on detected technologies
4. **Creates config file** - Saves `.erold.json` with project settings
5. **Loads initial context** - Fetches project state from Erold

## Tech Stack Detection

Scan these files to detect the tech stack:

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
| `pubspec.yaml` | mobile (Flutter) |
| `*.swift` or `Package.swift` | mobile (iOS) |
| `*.bicep` or `*.tf` | cloud, devops |

Always include: `security`, `testing`

## Guideline Categories

Available topics (pick based on tech stack):
- **Frontend**: nextjs, react, typescript, tailwind, uiux
- **Backend**: fastapi, api, backend, database
- **Systems**: systems (Go, Rust, C++)
- **Mobile**: mobile (Flutter, Swift, Kotlin)
- **Desktop**: desktop (Tauri, Electron)
- **Cloud**: cloud (AWS, Azure), devops
- **AI**: ai (LLM, RAG)
- **Always**: security, testing

## Setup Flow

### If Already Configured
```
✓ Erold already configured for this project
  Project: my-awesome-app

Loading context...
```

### If Not Configured
```
🚀 Initialize Erold for this project
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Step 1: Detect Tech Stack
  Found: package.json → Next.js 15, React 19, Tailwind CSS

Step 2: Select Guidelines
  Auto-selected: nextjs, react, typescript, tailwind, security, testing

Step 3: Connect to Erold
  Checking existing projects...
  Found matching: "my-awesome-app"

Step 4: Link Project
  Linked to project ID: proj_abc123

✓ Created .erold.json
✓ Guidelines: nextjs, react, typescript, tailwind, security, testing
✓ Ready to use Erold!
```

## Config File Format

Creates `.erold.json` in project root:

```json
{
  "projectId": "proj_abc123",
  "projectName": "my-awesome-app",
  "settings": {
    "autoContext": true,
    "workflowEnforcement": true,
    "guidelinesCategories": ["nextjs", "react", "typescript", "tailwind", "security", "testing"]
  }
}
```

## Examples by Project Type

### Next.js Project
```json
"guidelinesCategories": ["nextjs", "react", "typescript", "tailwind", "security", "testing"]
```

### Python FastAPI Project
```json
"guidelinesCategories": ["fastapi", "api", "database", "security", "testing"]
```

### Rust Project
```json
"guidelinesCategories": ["systems", "security", "testing"]
```

### Tauri Desktop App
```json
"guidelinesCategories": ["desktop", "typescript", "react", "security", "testing"]
```

### Flutter Mobile App
```json
"guidelinesCategories": ["mobile", "security", "testing"]
```

### Monorepo (mixed)
```json
"guidelinesCategories": ["nextjs", "fastapi", "devops", "security", "testing"]
```

## Options

```
/erold:init                    # Interactive setup with auto-detect
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
- Guidelines can be manually adjusted in `.erold.json`
- Re-run `/erold:init` to update after adding new tech
