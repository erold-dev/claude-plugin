#!/bin/bash
# erold-checkpoint.sh - Log session end to Erold
# Stop hook - logs and exits immediately, never blocks

set -e

INPUT=$(cat)

# Always approve the stop - never block
APPROVE='{"decision": "approve"}'

# Skip if no credentials
if [ -z "$EROLD_API_KEY" ] || [ -z "$EROLD_TENANT" ]; then
  echo "$APPROVE"
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
  echo "$APPROVE"
  exit 0
fi

PROJECT_ID=$(jq -r '.projectId // empty' "$EROLD_CONFIG" 2>/dev/null)
if [ -z "$PROJECT_ID" ]; then
  echo "$APPROVE"
  exit 0
fi

EROLD_API_URL="${EROLD_API_URL:-https://api.erold.dev/api/v1}"

# Log session end (fire and forget)
curl -s -X POST \
  "${EROLD_API_URL}/tenants/${EROLD_TENANT}/log" \
  -H "Authorization: Bearer ${EROLD_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{\"projectId\": \"${PROJECT_ID}\", \"content\": \"Session ended\", \"type\": \"session_end\"}" \
  > /dev/null 2>&1 || true

echo "$APPROVE"
exit 0
