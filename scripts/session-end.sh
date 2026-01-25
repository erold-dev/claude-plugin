#!/bin/bash
# session-end.sh - Save session end marker to active task
# Stop hook - runs when session ends

set -e

# Skip if no credentials
if [ -z "$EROLD_API_KEY" ] || [ -z "$EROLD_TENANT" ]; then
  echo '{"ok": true}'
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
  echo '{"ok": true}'
  exit 0
fi

PROJECT_ID=$(jq -r '.projectId // empty' "$EROLD_CONFIG" 2>/dev/null)
if [ -z "$PROJECT_ID" ]; then
  echo '{"ok": true}'
  exit 0
fi

EROLD_API_URL="${EROLD_API_URL:-https://api.erold.dev/api/v1}"

# Get active task (in-progress for this project)
ACTIVE_TASK=$(curl -s -X GET \
  "${EROLD_API_URL}/tenants/${EROLD_TENANT}/tasks?projectId=${PROJECT_ID}&status=in-progress&limit=1" \
  -H "Authorization: Bearer ${EROLD_API_KEY}" \
  -H "Content-Type: application/json" 2>/dev/null || echo "[]")

TASK_ID=$(echo "$ACTIVE_TASK" | jq -r '.[0].id // empty' 2>/dev/null)

if [ -z "$TASK_ID" ]; then
  echo '{"ok": true}'
  exit 0
fi

# Add session end comment
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
COMMENT="SESSION ENDED: ${TIMESTAMP}"

curl -s -X POST \
  "${EROLD_API_URL}/tenants/${EROLD_TENANT}/tasks/${TASK_ID}/comments" \
  -H "Authorization: Bearer ${EROLD_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{\"content\": \"${COMMENT}\"}" > /dev/null 2>&1 || true

echo '{"ok": true}'
exit 0
