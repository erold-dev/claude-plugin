# Testing Erold Plugin for Claude Code

## Prerequisites

### Option A: Environment Variables (for local dev)
```bash
export EROLD_API_KEY="your_api_key"
export EROLD_TENANT="your_tenant_id"
```

### Option B: Global MCP Config (recommended)
Create `~/.claude/mcp.json`:
```json
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
```

## Test 1: Interactive Mode (Recommended)

Open a **new terminal** and run:

```bash
cd /Users/sid/code/erold/claude-plugin
claude --plugin-dir . --verbose
```

### Commands to Test:

1. **Check MCP tools are loaded:**
   ```
   What erold tools do you have access to?
   ```

2. **Test skills (slash commands):**
   ```
   /erold:status
   /erold:context
   /erold:task list
   /erold:guidelines nextjs
   ```

3. **Test MCP tools directly:**
   ```
   Use get_context to show my workspace
   Use list_tasks to show my tasks
   Use get_guidelines topic="security" to show security guidelines
   ```

## Test 2: Non-Interactive (Limited)

```bash
export EROLD_TENANT="$EROLD_TENANT_ID"
claude --plugin-dir . --allowedTools "mcp__erold-pm__*" -p "use get_context to show my workspace"
```

Note: Skills may not load in `-p` mode.

## Check Logs

```bash
# Claude Code logs
tail -100 ~/Library/Logs/Claude/claude-code.log

# Debug mode
claude --plugin-dir . --debug "mcp,skills,hooks"
```

## Expected Results

### MCP Tools (38 total)
- Tasks: list_tasks, get_task, create_task, update_task, start_task, complete_task, block_task, search_tasks, get_blocked_tasks, add_task_comment, get_task_comments
- Projects: list_projects, get_project, create_project, update_project, get_project_stats, get_project_tasks
- Knowledge: search_knowledge, get_knowledge, list_knowledge, create_knowledge, update_knowledge
- Context: get_context, get_dashboard, get_stats, get_workload, list_members
- Guidelines: get_guidelines, list_guidelines, search_guidelines
- Vault: list_vault, get_vault_secret, create_vault_secret, update_vault_secret, delete_vault_secret
- Tech: get_tech_info, update_tech_stack, set_deployment_info, add_tech_command, remove_tech_command, set_tech_notes

### Skills (8 total)
- /erold:context - Load workspace context
- /erold:plan - Create tasks from requirements
- /erold:execute - Work on a task
- /erold:learn - Save to knowledge base
- /erold:guidelines - Fetch coding guidelines
- /erold:task - Quick task operations
- /erold:search - Search tasks and knowledge
- /erold:status - Dashboard overview

### Hooks (5 total)
Test hooks are loaded:
```
/hooks
```

Expected hooks:
- SessionStart: session-start.sh (auto-load context)
- PreToolUse (Edit|Write): check-active-task.sh
- PreToolUse (Bash): check-git-commit.sh
- PostToolUse (Edit|Write): log-file-change.sh
- PostToolUse (complete_task): suggest-learning.sh
- Stop: prompt-based task reminder

## Troubleshooting

### Skills not loading
- Skills only work in interactive mode (not -p mode)
- Check plugin validation: `claude plugin validate .`

### MCP tools not connecting
- Verify EROLD_API_KEY and EROLD_TENANT are set
- Check MCP server: `node /Users/sid/code/erold/mcp-server/dist/index.js`

### Empty data returned
- Verify tenant ID is correct
- Test API directly: `curl -H "X-API-Key: $EROLD_API_KEY" "https://api.erold.dev/api/v1/tenants/$EROLD_TENANT_ID/context"`
