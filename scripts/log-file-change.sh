#!/bin/bash
# log-file-change.sh - Log file changes to Erold task (if active)
# PostToolUse hook for Edit/Write

set -e

# Read input from stdin
INPUT=$(cat)

# Extract file path
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // ""')
SUCCESS=$(echo "$INPUT" | jq -r '.tool_response.success // true')

# Only log successful operations
if [ "$SUCCESS" != "true" ]; then
  exit 0
fi

# Skip if no active task
if [ -z "$EROLD_ACTIVE_TASK" ]; then
  exit 0
fi

# Skip if no credentials
if [ -z "$EROLD_API_KEY" ] || [ -z "$EROLD_TENANT" ]; then
  exit 0
fi

# Could log to Erold here, but for now just silently track
# Future: Add comment to task with files changed

exit 0
