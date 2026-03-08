#!/bin/bash
# log-file-change.sh - Log file changes to Erold
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
FILENAME=$(basename "$FILE_PATH")

# Log the file change via API
curl -s -X POST \
  "${EROLD_API_URL}/tenants/${EROLD_TENANT}/log" \
  -H "Authorization: Bearer ${EROLD_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{\"projectId\": \"${PROJECT_ID}\", \"content\": \"${TOOL_NAME}: ${FILE_PATH}\", \"type\": \"file_change\"}" \
  > /dev/null 2>&1 || true

exit 0
