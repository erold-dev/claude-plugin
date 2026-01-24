#!/bin/bash
# log-activity.sh - Log file changes to Erold activity
#
# Usage: ./log-activity.sh <file_path> <tool_name>
# Requires: EROLD_API_KEY, EROLD_TENANT, EROLD_API_URL (optional)

set -e

FILE_PATH="$1"
TOOL_NAME="${2:-Edit}"

API_URL="${EROLD_API_URL:-https://api.erold.dev/api/v1}"

# Check required env vars
if [ -z "$EROLD_API_KEY" ] || [ -z "$EROLD_TENANT" ]; then
  exit 0  # Silent skip if not configured
fi

# Skip non-code files
case "$FILE_PATH" in
  *.md|*.txt|*.json|*.yaml|*.yml|*.lock|*.log)
    exit 0
    ;;
esac

# Skip test/config files unless significant
case "$FILE_PATH" in
  *test*|*spec*|*.config.*|*.rc|.*)
    exit 0
    ;;
esac

# Get active task ID
CONTEXT=$(curl -s -f -H "X-API-Key: $EROLD_API_KEY" \
  "$API_URL/tenants/$EROLD_TENANT/context" 2>/dev/null || echo '{}')

ACTIVE_TASK_ID=$(echo "$CONTEXT" | jq -r '.activeTask.id // empty')

if [ -z "$ACTIVE_TASK_ID" ]; then
  exit 0  # No active task, skip logging
fi

# Extract filename for cleaner logging
FILENAME=$(basename "$FILE_PATH")

# Log activity (fire and forget)
curl -s -X POST \
  -H "X-API-Key: $EROLD_API_KEY" \
  -H "Content-Type: application/json" \
  "$API_URL/tenants/$EROLD_TENANT/tasks/$ACTIVE_TASK_ID/activity" \
  -d "{\"type\": \"file_change\", \"file\": \"$FILENAME\", \"path\": \"$FILE_PATH\", \"tool\": \"$TOOL_NAME\"}" \
  >/dev/null 2>&1 &

exit 0
