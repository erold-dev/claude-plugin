#!/bin/bash
# Test script for Erold Claude Code Plugin
#
# Usage: ./test.sh
#
# This runs Claude Code with the plugin loaded and debug logging enabled.
# Logs are saved to ./test-logs/

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_DIR="$SCRIPT_DIR/test-logs"
LOG_FILE="$LOG_DIR/test-$(date +%Y%m%d-%H%M%S).log"

# Create log directory
mkdir -p "$LOG_DIR"

# Check credentials
if [ -z "$EROLD_API_KEY" ]; then
  echo "ERROR: EROLD_API_KEY not set"
  exit 1
fi

if [ -z "$EROLD_TENANT_ID" ]; then
  echo "ERROR: EROLD_TENANT_ID not set"
  exit 1
fi

echo "╔════════════════════════════════════════════════════════════╗"
echo "║           Erold Claude Code Plugin Test                    ║"
echo "╠════════════════════════════════════════════════════════════╣"
echo "║  Plugin: $SCRIPT_DIR"
echo "║  Tenant: $EROLD_TENANT_ID"
echo "║  Log:    $LOG_FILE"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "Starting Claude Code with plugin..."
echo "Try these commands:"
echo "  /erold:status     - Check dashboard"
echo "  /erold:context    - Load workspace context"
echo "  /erold:task list  - List your tasks"
echo "  /erold:guidelines nextjs - Fetch guidelines"
echo ""
echo "Logs will be saved to: $LOG_FILE"
echo ""

# Run Claude Code with plugin and debug logging
# Export EROLD_TENANT for the MCP server (it expects EROLD_TENANT, not EROLD_TENANT_ID)
export EROLD_TENANT="$EROLD_TENANT_ID"

claude --plugin-dir "$SCRIPT_DIR" --debug "mcp,hooks,skills" --verbose 2>&1 | tee "$LOG_FILE"
