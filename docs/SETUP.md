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

### Step 2: Install Plugin

```bash
claude plugin install erold-dev/claude-plugin --scope user
```

### Step 3: Add MCP Server

Use `claude mcp add` to configure the Erold MCP server:

```bash
claude mcp add \
  -e EROLD_API_KEY=erold_YOUR_API_KEY_HERE \
  -e EROLD_TENANT=YOUR_TENANT_ID_HERE \
  -e EROLD_API_URL=https://api.erold.dev/api/v1 \
  -s user erold-pm -- npx -y @erold/mcp-server@latest
```

**One-liner (replace with your values):**
```bash
claude mcp add -e EROLD_API_KEY=erold_YOUR_KEY -e EROLD_TENANT=YOUR_TENANT_ID -e EROLD_API_URL=https://api.erold.dev/api/v1 -s user erold-pm -- npx -y @erold/mcp-server@latest
```

### Step 4: Verify & Restart

```bash
claude mcp list
# Should show: erold-pm: ✓ Connected
```

**Restart Claude Code** (Cmd+Q or close terminal) to load the MCP tools.

## Verify Installation

```bash
# Check MCP server is connected
claude mcp list
# Should show: erold-pm: ✓ Connected
```

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

### "No MCP servers configured" or MCP not connecting

1. **Check MCP server is added:**
   ```bash
   claude mcp list
   ```
   Should show `erold-pm: ✓ Connected`

2. **If not listed, add it:**
   ```bash
   claude mcp add \
     -e EROLD_API_KEY=erold_YOUR_KEY \
     -e EROLD_TENANT=YOUR_TENANT_ID \
     -e EROLD_API_URL=https://api.erold.dev/api/v1 \
     -s user erold-pm -- npx -y @erold/mcp-server@latest
   ```

3. **Restart Claude Code completely** - not just a new session

4. **Test MCP server directly:**
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

```bash
claude mcp add \
  -e EROLD_API_KEY=erold_YOUR_KEY \
  -e EROLD_TENANT=YOUR_TENANT_ID \
  -e EROLD_API_URL=https://api.erold.dev/api/v1 \
  -s user erold-pm -- /usr/local/bin/npx -y @erold/mcp-server@latest
```

**Option B: Install globally and use binary path**
```bash
npm install -g @erold/mcp-server
which erold-mcp
# Example: /Users/yourname/.nvm/versions/node/v22/bin/erold-mcp
```

```bash
claude mcp add \
  -e EROLD_API_KEY=erold_YOUR_KEY \
  -e EROLD_TENANT=YOUR_TENANT_ID \
  -e EROLD_API_URL=https://api.erold.dev/api/v1 \
  -s user erold-pm -- /Users/yourname/.nvm/versions/node/v22/bin/erold-mcp
```

### Hooks not running

1. Check hooks are loaded: `/hooks`
2. Ensure plugin is enabled: Check `~/.claude/settings.json`
3. Restart Claude Code completely

### Migrating from old config

If you previously used `~/.claude/mcp.json`, remove it and use `claude mcp add` instead:

```bash
rm ~/.claude/mcp.json  # Remove old config
claude mcp add ...     # Add using new method (see Step 3 above)
```

## File Locations

| File | Purpose |
|------|---------|
| `~/.claude.json` | MCP servers (managed via `claude mcp add`) |
| `~/.claude/settings.json` | Plugin enabled/disabled |
| `.erold.json` (project root) | Per-project Erold link |

## Security Note

Your API credentials are stored in `~/.claude.json`:
- Ensure the file has restricted permissions (`chmod 600 ~/.claude.json`)
- Regenerate API key if compromised at [app.erold.dev](https://app.erold.dev)

## Getting Help

- Documentation: [erold.dev/docs](https://erold.dev/docs)
- Issues: [github.com/erold-dev/claude-plugin/issues](https://github.com/erold-dev/claude-plugin/issues)
