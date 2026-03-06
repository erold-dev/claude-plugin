# Contributing to Erold Plugin for Claude Code

Thank you for your interest in contributing to the Erold Plugin for Claude Code! This document provides guidelines for contributing.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/claude-plugin.git`
3. Create a branch: `git checkout -b feature/your-feature-name`

## Project Structure

```
claude-plugin/
├── .claude-plugin/       # Plugin metadata (plugin.json, marketplace.json)
├── agents/               # Agent definitions (workflow, reviewer, learner)
├── commands/             # Command definitions (init, sync, report)
├── hooks/                # Hook scripts and configuration
│   └── hooks.json        # Hook event definitions
├── scripts/              # Shell scripts triggered by hooks
├── skills/               # Skill definitions (context, plan, execute, etc.)
├── styles/               # Output formatting
├── docs/                 # Setup and usage documentation
├── CLAUDE.md             # Instructions injected into Claude sessions
└── test.sh               # Manual test runner
```

## Development

### Testing Locally

```bash
# Set credentials
export EROLD_API_KEY="your_api_key"
export EROLD_TENANT="your_tenant_id"

# Run Claude Code with the plugin loaded
claude --plugin-dir . --verbose

# Or use the test script
./test.sh
```

### What to Test

After making changes, verify in an interactive Claude Code session:

1. **Skills load** - Run `/erold:status` or `/erold:task list`
2. **Hooks fire** - Session start should load context automatically
3. **Agents work** - The workflow enforcer should guide the 4-phase flow

See [TEST_INSTRUCTIONS.md](TEST_INSTRUCTIONS.md) for the full test checklist.

## Git Workflow

### Branching Strategy

```
main                    # Production-ready code
├── feature/*           # New features (feature/add-skill)
├── bugfix/*            # Bug fixes (bugfix/fix-hook)
├── hotfix/*            # Urgent fixes (hotfix/security-patch)
└── docs/*              # Documentation (docs/update-readme)
```

### Branch Naming

| Type | Pattern | Example |
|------|---------|---------|
| Feature | `feature/short-description` | `feature/add-review-skill` |
| Bug fix | `bugfix/short-description` | `bugfix/fix-session-start` |
| Hotfix | `hotfix/short-description` | `hotfix/security-patch` |
| Docs | `docs/short-description` | `docs/update-setup-guide` |

### Commit Messages

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add code review skill
fix: resolve session start hook not firing
docs: update setup guide for new MCP config
chore: bump plugin version
```

## Pull Request Process

1. Create a branch from `main`
2. Make your changes
3. Test locally with `claude --plugin-dir .`
4. Submit PR with clear description
5. Address review feedback
6. Squash merge to main

## Types of Contributions

### Skills

Skills live in `skills/` and are invoked via `/erold:<name>`. Each skill is a directory with a markdown prompt file. Follow the existing structure in `skills/context/` or `skills/task/` as examples.

### Hooks

Hook scripts live in `scripts/` and are registered in `hooks/hooks.json`. Hooks run automatically on events like session start or file edits. Keep them fast and non-blocking.

### Agents

Agent definitions live in `agents/`. These are markdown files that define specialized behaviors (workflow enforcement, code review, learning extraction).

## Reporting Bugs

Use the bug report template when creating issues. Include:
- Steps to reproduce
- Expected vs actual behavior
- Claude Code version
- Plugin version (check `.claude-plugin/plugin.json`)

## Questions?

Feel free to open an issue for questions or reach out at contact@erold.dev.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
