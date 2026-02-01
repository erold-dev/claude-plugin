#!/bin/bash
# erold-checkpoint.sh - Stop hook that reminds Claude to update Erold
# Fires when Claude is about to stop responding.
# If there's an active task, outputs a reminder so Claude continues and updates Erold.
# Uses stop_hook_active to prevent infinite loops.

set -e

INPUT=$(cat)

# Prevent infinite loop: if we already triggered, let Claude stop
STOP_ACTIVE=$(echo "$INPUT" | jq -r '.stop_hook_active // false' 2>/dev/null)
if [ "$STOP_ACTIVE" = "true" ]; then
  exit 0
fi

# Skip if no credentials
if [ -z "$EROLD_API_KEY" ] || [ -z "$EROLD_TENANT" ]; then
  exit 0
fi

# Check for .erold.json
EROLD_CONFIG=""
if [ -n "$CLAUDE_PROJECT_DIR" ] && [ -f "$CLAUDE_PROJECT_DIR/.erold.json" ]; then
  EROLD_CONFIG="$CLAUDE_PROJECT_DIR/.erold.json"
elif [ -f ".erold.json" ]; then
  EROLD_CONFIG=".erold.json"
fi

if [ -z "$EROLD_CONFIG" ]; then
  exit 0
fi

PROJECT_ID=$(jq -r '.projectId // empty' "$EROLD_CONFIG" 2>/dev/null)
if [ -z "$PROJECT_ID" ]; then
  exit 0
fi

EROLD_API_URL="${EROLD_API_URL:-https://api.erold.dev/api/v1}"

# Check if there's an active (in-progress) task
ACTIVE_TASK=$(curl -s -X GET \
  "${EROLD_API_URL}/tenants/${EROLD_TENANT}/tasks?projectId=${PROJECT_ID}&status=in-progress&limit=1" \
  -H "Authorization: Bearer ${EROLD_API_KEY}" \
  -H "Content-Type: application/json" 2>/dev/null || echo "[]")

TASK_ID=$(echo "$ACTIVE_TASK" | jq -r '.[0].id // empty' 2>/dev/null)
TASK_TITLE=$(echo "$ACTIVE_TASK" | jq -r '.[0].title // empty' 2>/dev/null)

# No active task = nothing to update, let Claude stop
if [ -z "$TASK_ID" ]; then
  exit 0
fi

# Output reminder - this prevents Claude from stopping and injects the message
cat << EOF
Before finishing, update Erold for task "${TASK_TITLE}" (${TASK_ID}):
- If task is done: complete_task with summary
- If progress was made: add_task_comment with what was done
- If something failed: add_task_comment with what was tried and why it failed
- If you learned something reusable: create_knowledge
Only update what's relevant. Skip if nothing changed.
EOF
