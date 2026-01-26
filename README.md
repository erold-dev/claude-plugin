# Erold Plugin for Claude Code

Project management for AI agents. Track tasks, capture knowledge, preserve context across sessions.

## Install

### 1. Install the plugin
```bash
claude plugin install erold-dev/claude-plugin --scope user
```

### 2. Add MCP server
```bash
claude mcp add \
  -e EROLD_API_KEY=erold_YOUR_KEY \
  -e EROLD_TENANT=YOUR_TENANT_ID \
  -e EROLD_API_URL=https://api.erold.dev/api/v1 \
  -s user erold-pm -- npx -y @erold/mcp-server@latest
```

### 3. Verify
```bash
claude mcp list
# Should show: erold-pm: ✓ Connected
```

Get credentials from [app.erold.dev](https://app.erold.dev) → Settings.

## How It Works

### Three Layers

```
┌─────────────────────────────────────────┐
│  AUTOMATIC (Reliable)                   │
│  Shell scripts that always run          │
├─────────────────────────────────────────┤
│  BEST-EFFORT (Claude follows CLAUDE.md) │
│  Instructions Claude tries to follow    │
├─────────────────────────────────────────┤
│  MANUAL (User invokes when needed)      │
│  Commands always available              │
└─────────────────────────────────────────┘
```

### Automatic (Hooks)

| Event | What Happens |
|-------|--------------|
| Session starts | Loads project context, shows active tasks |
| File edited | Logs file path to active task |
| Session ends | Adds timestamp to active task |

### Best-Effort (CLAUDE.md)

Claude is instructed to:
- Search knowledge before implementing
- Create tasks when user describes work
- Log failed attempts to task comments
- Save valuable learnings to knowledge base

### Manual (Commands)

| Command | Description |
|---------|-------------|
| `/erold:init` | Connect project to Erold |
| `/erold:context` | Load workspace context |
| `/erold:status` | Show dashboard |
| `/erold:task list` | List tasks |
| `/erold:task start <id>` | Start task |
| `/erold:task complete <id>` | Complete task |
| `/erold:learn` | Save to knowledge base |
| `/erold:search <query>` | Search tasks/knowledge |
| `/erold:guidelines <topic>` | Fetch coding standards |
| `/erold:plan` | Create tasks from requirements |
| `/erold:execute <id>` | Work on task with full context |

## Context Management

For multi-session projects, Erold preserves:

- **Task comments** - Progress, failed attempts, decisions
- **Knowledge base** - Solutions with "what didn't work"
- **File changes** - What was modified each session

### The "What Didn't Work" Pattern

When saving troubleshooting knowledge, include failed approaches:

```markdown
## Problem
Description of the issue

## What Didn't Work
- Approach 1 - Failed because: X
- Approach 2 - Failed because: Y

## Solution
What actually worked
```

This prevents repeating the same mistakes across sessions.

## Quick Start

1. Install plugin and configure credentials (see above)
2. Restart Claude Code
3. In your project: `/erold:init`
4. Start working - context loads automatically

## Links

- [Erold](https://erold.dev)
- [MCP Server](https://github.com/erold-dev/mcp-server)
- [Setup Guide](docs/SETUP.md)

## License

MIT © [Erold](https://erold.dev)
