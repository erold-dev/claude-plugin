#!/bin/bash
# session-start.sh - Load Erold context at session start
# This script outputs context that gets added to Claude's conversation

set -e

# Check if we have Erold credentials
if [ -z "$EROLD_API_KEY" ] || [ -z "$EROLD_TENANT" ]; then
  # No credentials, skip silently
  exit 0
fi

EROLD_API_URL="${EROLD_API_URL:-https://api.erold.dev/api/v1}"

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
    "additionalContext": "Erold PM is available. Use /erold:init to connect this project, or /erold:status to see your dashboard."
  }
}
EOF
  exit 0
fi

# Read project info from config
PROJECT_ID=$(jq -r '.projectId // empty' "$EROLD_CONFIG" 2>/dev/null)
PROJECT_NAME=$(jq -r '.projectName // empty' "$EROLD_CONFIG" 2>/dev/null)
GUIDELINES=$(jq -r '.settings.guidelinesCategories // [] | join(", ")' "$EROLD_CONFIG" 2>/dev/null)

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

# Fetch dashboard data from Erold API
DASHBOARD=$(curl -s -X GET \
  "${EROLD_API_URL}/tenants/${EROLD_TENANT}/dashboard" \
  -H "Authorization: Bearer ${EROLD_API_KEY}" \
  -H "Content-Type: application/json" 2>/dev/null || echo "{}")

# Fetch project tasks
TASKS=$(curl -s -X GET \
  "${EROLD_API_URL}/tenants/${EROLD_TENANT}/projects/${PROJECT_ID}/tasks?status=in-progress&limit=5" \
  -H "Authorization: Bearer ${EROLD_API_KEY}" \
  -H "Content-Type: application/json" 2>/dev/null || echo "[]")

# Build context message
ACTIVE_TASKS=$(echo "$TASKS" | jq -r 'if type == "array" then map("- " + .title + " [" + .id + "]") | join("\n") else "" end' 2>/dev/null || echo "")

CONTEXT="Erold Project: ${PROJECT_NAME} (${PROJECT_ID})
Guidelines: ${GUIDELINES}"

if [ -n "$ACTIVE_TASKS" ] && [ "$ACTIVE_TASKS" != "" ]; then
  CONTEXT="${CONTEXT}

Active Tasks:
${ACTIVE_TASKS}

Use /erold:execute <task-id> to work on a task with full context."
else
  CONTEXT="${CONTEXT}

No active tasks. Use /erold:status to see all tasks or /erold:plan to create new ones."
fi

# Output JSON for Claude Code
jq -n --arg ctx "$CONTEXT" '{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": $ctx
  }
}'
