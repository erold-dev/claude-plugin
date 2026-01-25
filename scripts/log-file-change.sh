#!/bin/bash
# log-file-change.sh - Log file changes to Erold task comments
# PostToolUse hook for Edit/Write

set -e

# Read input from stdin
INPUT=$(cat)

# Extract info
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // ""')

# Skip if no file path
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Skip if no credentials
if [ -z "$EROLD_API_KEY" ] || [ -z "$EROLD_TENANT" ]; then
  exit 0
fi

# Check for .erold.json to get project context
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

# Get active task (in-progress for this project)
ACTIVE_TASK=$(curl -s -X GET \
  "${EROLD_API_URL}/tenants/${EROLD_TENANT}/tasks?projectId=${PROJECT_ID}&status=in-progress&limit=1" \
  -H "Authorization: Bearer ${EROLD_API_KEY}" \
  -H "Content-Type: application/json" 2>/dev/null || echo "[]")

TASK_ID=$(echo "$ACTIVE_TASK" | jq -r '.[0].id // empty' 2>/dev/null)

if [ -z "$TASK_ID" ]; then
  exit 0
fi

# Log the file change as a task comment
# Get just the filename for brevity
FILENAME=$(basename "$FILE_PATH")
COMMENT="FILE CHANGED: ${FILENAME}\nPath: ${FILE_PATH}\nOperation: ${TOOL_NAME}"

# Post comment to task
curl -s -X POST \
  "${EROLD_API_URL}/tenants/${EROLD_TENANT}/tasks/${TASK_ID}/comments" \
  -H "Authorization: Bearer ${EROLD_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{\"content\": \"${COMMENT}\"}" > /dev/null 2>&1 || true

exit 0
