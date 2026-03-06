# Erold Plugin for Claude Code Roadmap

Technical roadmap for the Erold Claude Code plugin.

## Current Features
- 8 skills: context, plan, execute, learn, guidelines, task, search, status
- 3 commands: init, sync, report
- 3 agents: workflow enforcer, code reviewer, learning extractor
- Hook-based automation: session start, file change logging, checkpoint on stop
- CLAUDE.md injection for knowledge-first workflow

## Planned

### v1.7 - Smarter Hooks
| Feature | Status |
|---------|--------|
| Auto-fetch guidelines on file create | TODO |
| Task progress estimation from code changes | TODO |
| Smarter checkpoint — only trigger on meaningful work | TODO |

### v1.8 - Multi-Project
| Feature | Status |
|---------|--------|
| Per-project skill configuration | TODO |
| Project-scoped CLAUDE.md overrides | TODO |
| Cross-project task linking in skills | TODO |

### v1.9 - Review & Quality
| Feature | Status |
|---------|--------|
| Inline code review against guidelines | TODO |
| Auto-suggest learnings from resolved blockers | TODO |
| Test coverage awareness in execute skill | TODO |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to contribute.
