# Erold Plugin for Claude Code

> AI-native project management with workflow enforcement

This Claude Code plugin integrates [Erold](https://erold.dev) project management directly into your coding workflow, enforcing the 4-phase methodology:

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ UNDERSTAND  │ → │    PLAN     │ → │   EXECUTE   │ → │    LEARN    │
│             │    │             │    │             │    │             │
│ Load context│    │ Create tasks│    │ Implement   │    │ Capture     │
│ Fetch info  │    │ Break down  │    │ Track work  │    │ patterns    │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

## Installation

### From GitHub (Recommended)

```bash
claude plugin install erold-dev/claude-plugin --scope user
```

### Local Development

```bash
claude --plugin-dir /path/to/claude-plugin
```

## Prerequisites

1. **Get your credentials** from [app.erold.dev](https://app.erold.dev):
   - API Key: Settings → API Keys
   - Tenant ID: Settings → Workspace (or from URL)

2. **Create `~/.claude/mcp.json`** with your credentials:
   ```json
   {
     "mcpServers": {
       "erold-pm": {
         "command": "npx",
         "args": ["-y", "@erold/mcp-server@latest"],
         "env": {
           "EROLD_API_KEY": "erold_YOUR_ACTUAL_KEY_HERE",
           "EROLD_TENANT": "YOUR_ACTUAL_TENANT_ID_HERE",
           "EROLD_API_URL": "https://api.erold.dev/api/v1"
         }
       }
     }
   }
   ```

   > **Note:** Use `~/.claude/mcp.json` (not the plugin directory). This ensures credentials survive plugin updates.

3. **Restart Claude Code** completely.

4. **Verify** with `/mcp` - should show `erold-pm` connected.

**[Full Setup Guide](docs/SETUP.md)** - Detailed instructions and troubleshooting.

## Skills (Slash Commands)

| Skill | Description | Phase |
|-------|-------------|-------|
| `/erold:context` | Load workspace context | UNDERSTAND |
| `/erold:plan` | Create tasks from requirements | PLAN |
| `/erold:execute` | Work on a task with full context | EXECUTE |
| `/erold:learn` | Save learnings to knowledge base | LEARN |
| `/erold:guidelines` | Fetch coding guidelines | Any |
| `/erold:task` | Quick task operations | Any |
| `/erold:search` | Search tasks and knowledge | Any |
| `/erold:status` | Dashboard and progress | Any |

## Commands

| Command | Description |
|---------|-------------|
| `/erold:init` | Initialize Erold in current project |
| `/erold:sync` | Sync local work with Erold PM |
| `/erold:report` | Generate progress report |

## Agents

| Agent | Description |
|-------|-------------|
| `erold-workflow` | Enforces 4-phase methodology |
| `erold-reviewer` | Reviews code against guidelines |
| `erold-learner` | Extracts patterns from completed work |

## Hooks

The plugin includes automatic hooks for workflow enforcement:

| Event | Hook | Description |
|-------|------|-------------|
| `SessionStart` | `session-start.sh` | Auto-loads Erold project context and active tasks |
| `PreToolUse` | `check-active-task.sh` | Reminds to track work with `/erold:execute` |
| `PreToolUse` | `check-git-commit.sh` | Suggests including task ID in commit messages |
| `PostToolUse` | `log-file-change.sh` | Tracks file changes for active tasks |
| `PostToolUse` | `suggest-learning.sh` | Suggests `/erold:learn` after task completion |
| `Stop` | (prompt-based) | Reminds about in-progress tasks before stopping |

Hooks run automatically - no configuration needed. View active hooks with `/hooks`.

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Claude Code                          │
├─────────────────────────────────────────────────────────┤
│                    Erold Plugin                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │  Skills, Agents, Hooks, Commands                │   │
│  └──────────────────────┬──────────────────────────┘   │
│                         │                               │
│  ┌──────────────────────▼──────────────────────────┐   │
│  │              @erold/mcp-server                  │   │
│  │         (38 tools via MCP protocol)             │   │
│  └──────────────────────┬──────────────────────────┘   │
└─────────────────────────┼───────────────────────────────┘
                          │
                          ▼
              ┌───────────────────────┐
              │    Erold Cloud API    │
              │   api.erold.dev       │
              └───────────────────────┘
```

This plugin uses the [@erold/mcp-server](https://github.com/erold-dev/mcp-server) npm package for API communication.

## Example Workflow

```
You: "Add dark mode to the settings page"

Claude: Let me load the project context first...
        [/erold:context]

        I see this is a Next.js project. Let me fetch relevant guidelines...
        [/erold:guidelines nextjs]

        Now let me create tasks for this work...
        [/erold:plan Add dark mode toggle to settings]

        Created 3 tasks:
        - [TASK-123] Create theme context
        - [TASK-124] Add toggle component
        - [TASK-125] Persist preference

        Starting with TASK-123...
        [/erold:execute 123]

        ... implements the feature ...

        Task complete! Any patterns worth saving?
        [/erold:learn Theme context pattern for Next.js apps]
```

## File Structure

```
claude-plugin/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── .mcp.json.example         # MCP config template (copy to ~/.claude/mcp.json)
├── CHANGELOG.md              # Version history
├── skills/
│   ├── context/SKILL.md     # /erold:context
│   ├── plan/SKILL.md        # /erold:plan
│   ├── execute/SKILL.md     # /erold:execute
│   ├── learn/SKILL.md       # /erold:learn
│   ├── guidelines/SKILL.md  # /erold:guidelines
│   ├── task/SKILL.md        # /erold:task
│   ├── search/SKILL.md      # /erold:search
│   └── status/SKILL.md      # /erold:status
├── agents/
│   ├── workflow-enforcer.md # 4-phase enforcement
│   ├── code-reviewer.md     # Review against guidelines
│   └── learning-extractor.md # Extract patterns
├── commands/
│   ├── init.md              # /erold:init
│   ├── sync.md              # /erold:sync
│   └── report.md            # /erold:report
├── hooks/
│   └── hooks.json           # Workflow hooks config
├── styles/
│   └── erold-output.md      # Output formatting
└── scripts/
    ├── session-start.sh     # Load context at session start
    ├── check-active-task.sh # Check for active task before edits
    ├── check-git-commit.sh  # Suggest task ID in commits
    ├── log-file-change.sh   # Track file changes
    └── suggest-learning.sh  # Suggest learnings after completion
```

## Related

- [@erold/mcp-server](https://github.com/erold-dev/mcp-server) - MCP server for other AI clients
- [Erold Web App](https://app.erold.dev) - Full web interface
- [Erold CLI](https://github.com/erold-dev/cli) - Command-line interface
- [Documentation](https://erold.dev/docs) - Complete documentation

## License

MIT © [Erold](https://erold.dev)
