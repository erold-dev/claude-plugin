#!/bin/bash
# check-git-commit.sh - Check for linked tasks before git commit
# PreToolUse hook for Bash commands matching git commit

set -e

# Read input from stdin
INPUT=$(cat)

# Extract command
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

# Only check git commit commands
if [[ ! "$COMMAND" =~ ^git[[:space:]]+commit ]]; then
  exit 0
fi

# Skip if no Erold config
if [ ! -f ".erold.json" ] && [ ! -f "$CLAUDE_PROJECT_DIR/.erold.json" ]; then
  exit 0
fi

# Skip if no credentials
if [ -z "$EROLD_API_KEY" ] || [ -z "$EROLD_TENANT" ]; then
  exit 0
fi

# Add reminder about task linking
cat << 'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "additionalContext": "Remember: Include task ID in commit message (e.g., 'feat: add login [TASK-123]') for Erold traceability."
  }
}
EOF

exit 0
