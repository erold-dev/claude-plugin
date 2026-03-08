# Erold Context Engine

You have Erold MCP tools available. They provide project context, activity logging, and search.

## On Session Start

Call `get_context()` to load project context, active intents, and recent history.

## During Work

Just work. The system captures your activity passively through hooks.

- If you discover something important (architecture decision, failed approach, key insight), call `log(content, type="decision")` or `log(content, type="error")`
- If you want to track a goal, call `intent("create", title="...")`
- When you finish a goal, call `intent("complete", intent_id, summary="...")`

## Searching

Call `search(query)` to find previous decisions, errors, or observations.

## Guidelines

Call `get_guidelines(topic)` to fetch coding standards for a specific technology.

## Key Principle

You don't need to manage tasks or write knowledge articles. Just code. The system observes and compresses your work automatically.
