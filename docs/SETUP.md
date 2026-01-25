# Erold Plugin Setup Guide

Complete guide to set up the Erold plugin for Claude Code.

## Prerequisites

- [Claude Code CLI](https://claude.ai/claude-code) installed
- An Erold account at [app.erold.dev](https://app.erold.dev)
- API key from Settings > API Keys

## Quick Setup

### Step 1: Get Your Credentials

From [app.erold.dev](https://app.erold.dev):
1. **API Key**: Go to Settings > API Keys > Create New Key
2. **Tenant ID**: Found in Settings > Workspace, or in the URL after `/t/`

### Step 2: Create Global MCP Config

Create `~/.claude/mcp.json` with your credentials:

```json
{
  "mcpServers": {
    "erold-pm": {
      "command": "npx",
      "args": ["-y", "@erold/mcp-server@latest"],
      "env": {
        "EROLD_API_KEY": "erold_YOUR_API_KEY_HERE",
        "EROLD_TENANT": "YOUR_TENANT_ID_HERE",
        "EROLD_API_URL": "https://api.erold.dev/api/v1"
      }
    }
  }
}
```

> **Important:** Always use `~/.claude/mcp.json` for your credentials. This file survives plugin updates. Never edit the plugin cache directory.

**One-liner (replace with your values):**
```bash
mkdir -p ~/.claude && cat > ~/.claude/mcp.json << 'EOF'
{
  "mcpServers": {
    "erold-pm": {
      "command": "npx",
      "args": ["-y", "@erold/mcp-server@latest"],
      "env": {
        "EROLD_API_KEY": "erold_YOUR_KEY",
        "EROLD_TENANT": "YOUR_TENANT_ID",
        "EROLD_API_URL": "https://api.erold.dev/api/v1"
      }
    }
  }
}
EOF
```

### Step 3: Install Plugin

```bash
claude plugin install erold-dev/claude-plugin --scope user
```

### Step 4: Restart Claude Code

**Completely quit** Claude Code (Cmd+Q or close terminal) and start fresh.

## Verify Installation

In a new Claude Code session:

1. Run `/mcp` - should show `erold-pm` as connected
2. Run `/hooks` - should show Erold hooks loaded
3. Run `/erold:status` - should show your dashboard

## Per-Project Setup

For each project you want to track with Erold:

```
/erold:init
```

This creates `.erold.json` in your project root linking it to an Erold project.

## Updating the Plugin

```bash
claude plugin update erold@erold-plugins
```

Your credentials in `~/.claude/mcp.json` are preserved - no action needed after updates.

## Available Commands

| Command | Description |
|---------|-------------|
| `/erold:context` | Load workspace context |
| `/erold:plan` | Create tasks from requirements |
| `/erold:execute` | Work on tasks with full context |
| `/erold:learn` | Save learnings to knowledge base |
| `/erold:guidelines` | Fetch coding guidelines |
| `/erold:task` | Quick task operations |
| `/erold:search` | Search tasks and knowledge |
| `/erold:status` | Dashboard and progress |
| `/erold:init` | Initialize project |
| `/erold:sync` | Sync local work |
| `/erold:report` | Generate progress report |

## Troubleshooting

### "Invalid API key format" or MCP not connecting

1. **Check your config has actual values:**
   ```bash
   cat ~/.claude/mcp.json
   ```
   Should show your real API key, NOT `${EROLD_API_KEY}` or placeholders.

2. **Restart Claude Code completely** - not just a new session

3. **Test MCP server directly:**
   ```bash
   EROLD_API_KEY="your_key" EROLD_TENANT="your_tenant" npx -y @erold/mcp-server@latest
   ```

### "Executable not found in $PATH" or MCP server failed

Claude Code doesn't always inherit your shell's full PATH. Use absolute paths:

**Option A: Find and use absolute path to npx**
```bash
which npx
# Example: /usr/local/bin/npx
```

```json
{
  "mcpServers": {
    "erold-pm": {
      "command": "/usr/local/bin/npx",
      "args": ["-y", "@erold/mcp-server@latest"],
      "env": { ... }
    }
  }
}
```

**Option B: Install globally and use binary path**
```bash
npm install -g @erold/mcp-server
which erold-mcp
# Example: /Users/yourname/.nvm/versions/node/v22/bin/erold-mcp
```

```json
{
  "mcpServers": {
    "erold-pm": {
      "command": "/Users/yourname/.nvm/versions/node/v22/bin/erold-mcp",
      "env": {
        "EROLD_API_KEY": "erold_YOUR_KEY",
        "EROLD_TENANT": "YOUR_TENANT_ID",
        "EROLD_API_URL": "https://api.erold.dev/api/v1"
      }
    }
  }
}
```

### Hooks not running

1. Check hooks are loaded: `/hooks`
2. Ensure plugin is enabled: Check `~/.claude/settings.json`
3. Restart Claude Code completely

## File Locations

| File | Purpose |
|------|---------|
| `~/.claude/mcp.json` | Your MCP credentials (edit this one) |
| `~/.claude/settings.json` | Plugin enabled/disabled |
| `.erold.json` (project root) | Per-project Erold link |

## Security Note

The `~/.claude/mcp.json` file contains your API key:
- Ensure `~/.claude/` directory has restricted permissions (`chmod 700 ~/.claude`)
- Never commit `mcp.json` to version control
- Regenerate API key if compromised at [app.erold.dev](https://app.erold.dev)

## Getting Help

- Documentation: [erold.dev/docs](https://erold.dev/docs)
- Issues: [github.com/erold-dev/claude-plugin/issues](https://github.com/erold-dev/claude-plugin/issues)
