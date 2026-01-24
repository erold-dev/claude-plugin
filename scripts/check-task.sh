#!/bin/bash
# check-task.sh - Verify there's an active Erold task before allowing edits
# Returns 0 if OK to proceed, 1 if should warn
#
# Usage: ./check-task.sh
# Requires: EROLD_API_KEY, EROLD_TENANT, EROLD_API_URL (optional)

set -e

API_URL="${EROLD_API_URL:-https://api.erold.dev/api/v1}"

# Check required env vars
if [ -z "$EROLD_API_KEY" ] || [ -z "$EROLD_TENANT" ]; then
  echo "Erold credentials not configured, skipping task check"
  exit 0
fi

# Fetch context
CONTEXT=$(curl -s -f -H "X-API-Key: $EROLD_API_KEY" \
  "$API_URL/tenants/$EROLD_TENANT/context" 2>/dev/null || echo '{}')

# Check for active task
ACTIVE_TASK_ID=$(echo "$CONTEXT" | jq -r '.activeTask.id // empty')
ACTIVE_TASK_TITLE=$(echo "$CONTEXT" | jq -r '.activeTask.title // empty')

if [ -z "$ACTIVE_TASK_ID" ]; then
  echo "⚠️  No active Erold task found"
  echo ""
  echo "Consider:"
  echo "  • /erold:task start <id>  - Start an existing task"
  echo "  • /erold:plan <requirements>  - Create new tasks"
  echo ""
  exit 1
fi

echo "✓ Active task: [$ACTIVE_TASK_ID] $ACTIVE_TASK_TITLE"
exit 0
