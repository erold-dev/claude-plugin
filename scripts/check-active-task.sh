#!/bin/bash
# check-active-task.sh - Warn if editing code without an active Erold task
# PreToolUse hook for Edit/Write/NotebookEdit

set -e

# Read input from stdin
INPUT=$(cat)

# Extract tool info
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // ""')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')

# Skip check for non-code files
case "$FILE_PATH" in
  *.md|*.txt|*.json|*.yaml|*.yml|*.toml|*.lock|*.gitignore|*.env*)
    exit 0
    ;;
esac

# Skip if no Erold config
if [ ! -f ".erold.json" ] && [ ! -f "$CLAUDE_PROJECT_DIR/.erold.json" ]; then
  exit 0
fi

# Skip if no credentials
if [ -z "$EROLD_API_KEY" ] || [ -z "$EROLD_TENANT" ]; then
  exit 0
fi

# Check environment variable for active task (set by /erold:execute)
if [ -n "$EROLD_ACTIVE_TASK" ]; then
  exit 0
fi

# For now, just allow the edit but add context suggesting task tracking
# We don't want to be annoying, just helpful
cat << 'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "additionalContext": "Tip: Use /erold:execute <task-id> to track this work in Erold."
  }
}
EOF

exit 0
