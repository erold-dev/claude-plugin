# Changelog

All notable changes to the Erold Plugin for Claude Code will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.4.0] - 2025-01-25

### Changed
- **Simplified CLAUDE.md** - Reduced from 207 to 67 lines, focused on essentials
- **Simplified workflow-enforcer** - Reduced from 313 to 58 lines
- **Simplified hooks** - Removed naggy tips that appeared on every edit/commit
- **Simplified Stop hook** - Shorter, clearer prompt

### Removed
- `check-active-task.sh` - Was showing tips on every edit (annoying)
- `check-git-commit.sh` - Was showing tips on every commit (annoying)
- `suggest-learning.sh` - Was just suggesting instead of doing
- PreToolUse hooks - No longer interrupting workflow with reminders

### Philosophy
- Less is more - clear instructions that Claude will actually follow
- Don't nag - let Claude work, track automatically
- Keep only what adds value: session start, file logging, session end

## [1.3.0] - 2025-01-25

### Added
- **Knowledge-first workflow** - Always search knowledge before implementing
- **Failed attempts tracking** - Log what didn't work to task comments (TRIED/FAILED/REASON)
- **"What Didn't Work" pattern** - All troubleshooting knowledge includes failed approaches
- **Session summaries** - Stop hook saves progress summary to active task
- **File change logging** - PostToolUse hook now actually logs to Erold API
- **Cross-session continuity** - Task comments preserve context between sessions

### Changed
- Rewrote `CLAUDE.md` with comprehensive BEFORE/DURING/AFTER workflow
- Enhanced `workflow-enforcer.md` with 4-phase methodology (Understand → Plan → Execute → Learn)
- Updated Stop hook to auto-save session context before ending
- `log-file-change.sh` now calls Erold API to log changes to active task

### Philosophy
- Search knowledge BEFORE implementing (don't repeat mistakes)
- Track failed attempts (gold for future sessions)
- Include "What Didn't Work" in all troubleshooting knowledge

## [1.2.0] - 2025-01-25

### Added
- **Proactive automation** - Erold now automatically manages tasks and captures knowledge
- `CLAUDE.md` - Injects proactive behaviors into every Claude Code session
- Auto-create tasks when user describes work to do
- Auto-start tasks before editing code
- Auto-complete tasks when work is finished
- Auto-capture knowledge when errors are fixed or patterns discovered
- Auto-fetch guidelines before implementing features

### Changed
- Rewrote `agents/workflow-enforcer.md` to be proactive instead of passive
- Changed philosophy from "suggest and remind" to "do it and tell user"

## [1.1.1] - 2025-01-25

### Changed
- Removed `.mcp.json` from repository to prevent credential overwrites on updates
- Users should now configure credentials in `~/.claude/mcp.json` (survives plugin updates)
- Updated documentation with clearer setup instructions

### Fixed
- Plugin updates no longer overwrite user credentials

## [1.1.0] - 2025-01-25

### Added
- New hooks system using correct Claude Code format
- `session-start.sh` - Auto-loads Erold context at session start
- `check-active-task.sh` - Reminds about task tracking when editing code
- `check-git-commit.sh` - Suggests including task IDs in commit messages
- `log-file-change.sh` - Tracks file changes for active tasks
- `suggest-learning.sh` - Suggests `/erold:learn` after task completion
- Prompt-based Stop hook for task reminders
- `docs/SETUP.md` - Detailed setup guide with troubleshooting
- Tech stack auto-detection in `/erold:init`

### Changed
- Rewrote `hooks/hooks.json` with proper event-based structure
- Updated README with hooks documentation

### Removed
- Old hook scripts (`check-task.sh`, `log-activity.sh`)

## [1.0.0] - 2025-01-24

### Added
- Initial release
- Skills: `/erold:context`, `/erold:plan`, `/erold:execute`, `/erold:learn`, `/erold:guidelines`, `/erold:task`, `/erold:search`, `/erold:status`
- Commands: `/erold:init`, `/erold:sync`, `/erold:report`
- Agents: `erold-workflow`, `erold-reviewer`, `erold-learner`
- MCP integration with `@erold/mcp-server`
