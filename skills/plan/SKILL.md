---
description: Create Erold tasks from requirements with guidelines and knowledge base context
allowed-tools:
  - mcp__erold-pm__create_task
  - mcp__erold-pm__search_knowledge
  - mcp__erold-pm__get_tech_info
  - mcp__erold-pm__list_projects
  - mcp__erold-pm__get_project
  - mcp__erold-pm__get_guidelines
  - mcp__erold-pm__search_guidelines
  - Read
  - Glob
  - Grep
  - WebFetch
---

# Erold Planner

Transform requirements into a structured plan with tracked tasks. This is the **PLAN** phase of the Erold methodology.

## When to Use
- When user describes new work to be done
- When starting a new feature or fix
- When requirements need to be broken down
- Before any significant implementation

## Erold Methodology - PLAN Phase

### 1. Understand the Requirement
Parse what the user wants:
- What is the desired outcome?
- What are the constraints?
- What is the scope?

### 2. Check Knowledge Base
Look for similar past work:
- Call `search_knowledge` with relevant terms
- Find patterns that can be reused
- Identify potential pitfalls from past learnings

### 3. Fetch Guidelines
Get relevant coding standards:
- Call `get_guidelines` for the project's tech stack
- Note security considerations
- Identify testing requirements

### 4. Decompose into Tasks
Break into atomic, trackable units:
- Each task should be completable in 1-4 hours
- Tasks should have clear acceptance criteria
- Identify dependencies between tasks

### 5. Create Tasks in Erold
For each task, call `create_task` with:
- **title**: Clear, action-oriented title
- **description**: Detailed acceptance criteria
- **priority**: high/medium/low based on urgency
- **estimatedHours**: Time estimate
- **tags**: Relevant technology tags

### 6. Set Dependencies
Note which tasks block others:
- Add blocking relationships in task descriptions
- Suggest execution order

## Task Creation Rules

- **Atomic**: Each task is one logical unit of work
- **Measurable**: Clear "done" criteria
- **Estimated**: Include time estimates
- **Tagged**: Add technology/area tags
- **Prioritized**: Set appropriate priority

## Output Format

```
📝 Plan: {requirement_summary}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📚 Knowledge Applied:
  • Pattern: {relevant_pattern}
  • Learning: {relevant_learning}

📋 Guidelines:
  • {key_guideline_1}
  • {key_guideline_2}

✅ Tasks Created:

1. [TASK-123] Setup component structure
   Priority: high | Estimate: 2h
   Tags: #frontend #react

2. [TASK-124] Implement business logic
   Priority: high | Estimate: 3h
   Blocked by: TASK-123
   Tags: #backend #api

3. [TASK-125] Add tests
   Priority: medium | Estimate: 2h
   Blocked by: TASK-124
   Tags: #testing

📊 Summary:
  • Total tasks: 3
  • Total estimate: 7h
  • Suggested order: 123 → 124 → 125

⚠️ Risks/Unknowns:
  • {identified_risk}
```

## Arguments

$ARGUMENTS contains the requirements to plan.

Examples:
- `/erold:plan Add dark mode toggle to settings page`
- `/erold:plan Implement user authentication with OAuth`
- `/erold:plan Fix the memory leak in the data processor`

## Important

NEVER skip the planning phase. All significant work must have tasks created before execution begins. This ensures:
- Work is tracked and visible
- Progress can be measured
- Knowledge is captured
- Team is aligned
