---
description: Save learnings and patterns to Erold knowledge base
allowed-tools:
  - mcp__erold-pm__create_knowledge
  - mcp__erold-pm__update_knowledge
  - mcp__erold-pm__search_knowledge
  - mcp__erold-pm__list_knowledge
  - mcp__erold-pm__get_task
  - Read
  - Glob
---

# Erold Learner

Capture learnings from completed work to improve future development. This is the **LEARN** phase of the Erold methodology.

## When to Use
- After completing a task
- When discovering a useful pattern
- When fixing a tricky bug
- When finding a better approach
- At the end of a coding session

## Erold Methodology - LEARN Phase

### 1. Identify the Learning
What emerged from this work?
- A reusable pattern?
- A solution to a common problem?
- A pitfall to avoid?
- A performance optimization?
- A security consideration?

### 2. Categorize Appropriately
Choose the right category:
- **architecture**: System design patterns
- **api**: API design and integration patterns
- **deployment**: Infrastructure and CI/CD
- **testing**: Test strategies and patterns
- **security**: Security patterns and fixes
- **performance**: Optimization techniques
- **workflow**: Process and methodology
- **conventions**: Code style and naming
- **troubleshooting**: Debug techniques and fixes
- **other**: Anything else

### 3. Scope Correctly
- **Global**: Applies to all projects
- **Project-specific**: Only relevant to current project

### 4. Write Clearly
Structure for future AI and humans:
- Problem/Context: What situation does this address?
- Solution/Pattern: What's the approach?
- Example: Code or steps if applicable
- When to use: Conditions for applying this
- When NOT to use: Exceptions or limitations

### 5. Create Entry
Call `create_knowledge` with:
- **title**: Concise, searchable name
- **category**: One of the standard categories
- **content**: Structured learning content
- **projectId**: (optional) For project-specific learnings
- **tags**: Technology tags for discoverability

## Knowledge Entry Format

```markdown
## Problem/Context
{What situation or challenge does this address?}

## Solution/Pattern
{What's the approach or pattern?}

## Example
{Code example or steps}

## When to Use
- {Condition 1}
- {Condition 2}

## When NOT to Use
- {Exception 1}
- {Limitation 1}

## Related
- {Related pattern or learning}
```

## Auto-Learning Triggers

Automatically suggest learning capture when:
- **Bug fix**: Document root cause and prevention
- **New pattern**: Document when and how to use it
- **Performance fix**: Document the optimization technique
- **Security fix**: Document vulnerability and prevention
- **Repeated solution**: Same approach used multiple times

## Output Format

```
📚 Learning Captured
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 Title: {learning_title}
📁 Category: {category}
🌐 Scope: {global|project}
🏷️ Tags: {tags}

📄 Content Preview:
{first_few_lines}

✅ Saved to knowledge base
💡 This will help with future {related_work}
```

## Arguments

$ARGUMENTS can be:
- Description of what to learn
- `auto` - Extract from recent work
- `--from-task 123` - Extract from completed task

Examples:
- `/erold:learn Caching pattern for API responses using React Query`
- `/erold:learn auto` - Analyze recent changes and suggest learnings
- `/erold:learn --from-task 456` - Extract learnings from task 456

## Quality Checklist

Before saving, verify:
- [ ] Would this help future work on similar tasks?
- [ ] Is it specific enough to be actionable?
- [ ] Is it general enough to be reusable?
- [ ] Does it add value beyond existing knowledge?
- [ ] Is it clearly written for future reference?
