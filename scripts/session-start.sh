#!/bin/bash
# session-start.sh - Load Erold context at session start
# Outputs context instruction for the agent to call get_context()

set -e

# Check for .erold.json in project directory
EROLD_CONFIG=""
if [ -n "$CLAUDE_PROJECT_DIR" ] && [ -f "$CLAUDE_PROJECT_DIR/.erold.json" ]; then
  EROLD_CONFIG="$CLAUDE_PROJECT_DIR/.erold.json"
elif [ -f ".erold.json" ]; then
  EROLD_CONFIG=".erold.json"
fi

# If no config, provide minimal context
if [ -z "$EROLD_CONFIG" ]; then
  cat << 'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "Erold Context Engine is available. Use /erold:init to connect this project."
  }
}
EOF
  exit 0
fi

# Read project info from config
PROJECT_ID=$(jq -r '.projectId // empty' "$EROLD_CONFIG" 2>/dev/null)

if [ -z "$PROJECT_ID" ]; then
  cat << 'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "Erold config found but no project linked. Run /erold:init to set up."
  }
}
EOF
  exit 0
fi

# Instruct the agent to call get_context via MCP
CONTEXT="Erold project linked (${PROJECT_ID}). Call get_context() to load project context, active intents, and recent history."

jq -n --arg ctx "$CONTEXT" '{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": $ctx
  }
}'
