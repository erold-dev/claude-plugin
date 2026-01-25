# Erold Plugin Setup Guide

Complete guide to set up the Erold plugin for Claude Code.

## Prerequisites

- [Claude Code CLI](https://claude.ai/claude-code) installed
- An Erold account at [app.erold.dev](https://app.erold.dev)
- API key from Settings > API Keys

## Important Note

**Claude Code does NOT expand environment variables** like `${VAR}` or `$VAR` in `.mcp.json` files. You must hardcode your actual credentials.

## Quick Setup

### Step 1: Get Your Credentials

From [app.erold.dev](https://app.erold.dev):
1. **API Key**: Go to Settings > API Keys > Create New Key
2. **Tenant ID**: Found in Settings > Workspace, or in the URL after `/t/`

### Step 2: Create Global MCP Config

Create `~/.claude/mcp.json` with your **actual credentials** (not variables):

```json
{
  "mcpServers": {
    "erold-pm": {
      "command": "npx",
      "args": ["-y", "@erold/mcp-server@latest"],
      "env": {
        "EROLD_API_KEY": "erold_YOUR_ACTUAL_API_KEY_HERE",
        "EROLD_TENANT": "YOUR_ACTUAL_TENANT_ID_HERE",
        "EROLD_API_URL": "https://api.erold.dev/api/v1"
      }
    }
  }
}
```

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

### Step 3: Install Plugin (Optional but Recommended)

```bash
claude plugin install erold-dev/claude-plugin --scope user
```

**Important:** After installing, also update the plugin's `.mcp.json`:
```
~/.claude/plugins/cache/erold-plugins/erold/1.0.0/.mcp.json
```

Replace the `${VAR}` syntax with your actual credentials (same format as Step 2).

### Step 4: Restart Claude Code

**Completely quit** Claude Code (Cmd+Q or close terminal) and start fresh. New sessions will pick up the config.

## Verify Installation

In a new Claude Code session, run:

```
/erold:status
```

You should see your dashboard with projects and tasks.

## Per-Project Setup

For each project you want to track with Erold:

```
/erold:init
```

This creates `.erold.json` in your project root linking it to an Erold project.

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

1. **Check .mcp.json has actual values:**
   ```bash
   cat ~/.claude/mcp.json
   ```
   Should show your real API key, NOT `${EROLD_API_KEY}`

2. **Check plugin's .mcp.json too:**
   ```bash
   cat ~/.claude/plugins/cache/erold-plugins/erold/1.0.0/.mcp.json
   ```

3. **Restart Claude Code completely** - not just a new session

4. **Test MCP server directly:**
   ```bash
   EROLD_API_KEY="your_key" EROLD_TENANT="your_tenant" npx -y @erold/mcp-server@latest
   ```

### "EROLD_TENANT environment variable required"

The `.mcp.json` is using `${VAR}` syntax. Replace with actual values.

### "Executable not found in $PATH" or MCP server failed

Claude Code doesn't always inherit your shell's full PATH. If `npx` or globally installed binaries aren't found:

**Option A: Use absolute path to npx (Recommended)**
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

Find your npx path with: `which npx`

**Option B: Install globally and use absolute path**
```bash
# Install globally
npm install -g @erold/mcp-server

# Find the binary path
which erold-mcp
# Example: /Users/yourname/.nvm/versions/node/v22.21.1/bin/erold-mcp
```

Then use the full path in `.mcp.json`:
```json
{
  "mcpServers": {
    "erold-pm": {
      "command": "/Users/yourname/.nvm/versions/node/v22.21.1/bin/erold-mcp",
      "env": {
        "EROLD_API_KEY": "erold_YOUR_KEY",
        "EROLD_TENANT": "YOUR_TENANT_ID",
        "EROLD_API_URL": "https://api.erold.dev/api/v1"
      }
    }
  }
}
```

### Plugin updates overwrite config

After running `claude plugin update`, you need to re-edit:
```
~/.claude/plugins/cache/erold-plugins/erold/VERSION/.mcp.json
```

## File Locations

| File | Purpose |
|------|---------|
| `~/.claude/mcp.json` | Global MCP server config |
| `~/.claude/settings.json` | Plugin enabled/disabled |
| `~/.claude/plugins/cache/erold-plugins/erold/VERSION/.mcp.json` | Installed plugin's MCP config |
| `.erold.json` (project root) | Per-project Erold link |

## Security Note

The `.mcp.json` files contain your API key. Ensure:
- `~/.claude/` directory has restricted permissions
- Don't commit `.mcp.json` to version control
- Regenerate API key if compromised

## Getting Help

- Documentation: [erold.dev/docs](https://erold.dev/docs)
- Issues: [github.com/erold-dev/claude-plugin/issues](https://github.com/erold-dev/claude-plugin/issues)
