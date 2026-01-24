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

Set your Erold credentials as environment variables:

```bash
export EROLD_API_KEY="erold_your_api_key"
export EROLD_TENANT_ID="your-tenant-id"
```

Get your API key from [app.erold.dev](https://app.erold.dev) → Settings → API Keys.

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

- **Session start** - Auto-load context
- **Pre-edit** - Check for active task
- **Post-edit** - Log activity
- **Pre-commit** - Code review
- **Task complete** - Suggest learnings

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
├── .mcp.json                 # MCP server config
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
│   └── hooks.json           # Workflow hooks
├── styles/
│   └── erold-output.md      # Output formatting
└── scripts/
    ├── check-task.sh        # Verify task exists
    └── log-activity.sh      # Log file changes
```

## Related

- [@erold/mcp-server](https://github.com/erold-dev/mcp-server) - MCP server for other AI clients
- [Erold Web App](https://app.erold.dev) - Full web interface
- [Erold CLI](https://github.com/erold-dev/cli) - Command-line interface
- [Documentation](https://erold.dev/docs) - Complete documentation

## License

MIT © [Erold](https://erold.dev)
