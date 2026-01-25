#!/bin/bash
# suggest-learning.sh - Suggest capturing learnings after task completion
# PostToolUse hook for mcp__plugin_erold_erold-pm__complete_task

set -e

# Read input from stdin
INPUT=$(cat)

# Extract task info from the MCP call
TASK_ID=$(echo "$INPUT" | jq -r '.tool_input.taskId // ""')

# Output suggestion as additional context
cat << EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PostToolUse",
    "additionalContext": "Task completed! Consider using /erold:learn to capture any patterns, solutions, or insights from this work that could help in the future."
  }
}
EOF

exit 0
