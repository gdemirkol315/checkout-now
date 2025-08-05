# Claude Code Session Continuity Guide

This guide ensures seamless continuation of work across multiple Claude Code sessions.

## Session Startup Checklist

When starting any Claude Code session for this project:

1. **📋 Check Current Tasks**
   ```bash
   # Always read the main task file first
   cat TASKS.md
   ```

2. **🔍 Review Recent Work** 
   ```bash
   # Check recent commits to understand what was last worked on
   git log --oneline -10
   git status
   ```

3. **📊 Update Task Status**
   - Move completed tasks from 🟡 In Progress → ✅ Done
   - Update any blockers or new findings
   - Add new tasks discovered during previous work

4. **🎯 Identify Next Priority**
   - Focus on 🔥 Critical and 🟠 High priority tasks
   - Check for any ⛔ Blocked tasks that may now be unblocked
   - Review dependencies and prerequisites

## Task Lifecycle Management

### Creating New Tasks
Use the template from `.claude/task-templates.md`:

```markdown
#### TASK-XXX: [Clear, actionable title]
- **Status**: 📋 Todo
- **Priority**: [🔥|🟠|🟡|🔵]
- **Story Points**: [1,2,3,5,8,13]

**Description**: [Clear problem statement]

**Acceptance Criteria**:
- [ ] [Specific, testable criterion]
- [ ] [Measurable outcome]

**Technical Tasks**:
- [ ] [Concrete implementation step]

**DoD Checklist**: [Use standard DoD from templates]
```

### Updating Task Progress

**When starting work:**
```markdown
- **Status**: 📋 Todo → 🟡 In Progress
- **Notes**: Started work on [date], focusing on [specific aspect]
```

**When blocked:**
```markdown
- **Status**: 🟡 In Progress → ⛔ Blocked
**Blockers**: [Specific blocker description and what's needed to unblock]
```

**When completing:**
```markdown
- **Status**: 🟡 In Progress → ✅ Done
- **Completed**: [date]
- **Notes**: [Any important outcomes, lessons learned, or follow-up needed]
```

## Communication Patterns

### Commit Message Format
```
TASK-XXX: [Brief description of change]

- Implemented [specific feature/fix]
- Updated [affected components]
- Relates to acceptance criteria: [which criteria this addresses]

Closes: TASK-XXX [if task is complete]
Progress: TASK-XXX [if partial progress]
```

### Session Handoff Notes
At the end of each session, update TASKS.md with:

```markdown
**Session Notes [Date]**:
- Completed: [what was finished]
- In Progress: [what was started but not finished]
- Next Steps: [what should be tackled next]
- Blockers Found: [any new blockers discovered]
- Questions: [any clarifications needed]
```

## File Organization for Continuity

### Critical Files to Check
1. **`/TASKS.md`** - Primary task tracker
2. **`/CLAUDE.md`** - Project instructions and context
3. **`README.md` files** - In each major directory
4. **Recent git commits** - Understanding recent changes

### Context Files
- **`.claude/task-templates.md`** - Task creation templates
- **`.claude/session-continuity.md`** - This guide
- **Project-specific READMEs** - Technical documentation

### Working Files
- **Build/config files** - `package.json`, `pom.xml`, etc.
- **Environment configs** - `.env` files, k8s manifests
- **Documentation** - Any project-specific docs

## Best Practices for Session Continuity

### 1. Granular Task Breakdown
- Keep tasks to 8 story points or less
- Each task should be completable in one focused session
- Break down complex features into smaller, independent tasks

### 2. Clear State Documentation
- Always update task status before ending session
- Document any temporary changes or work-in-progress
- Note any environment setup or special commands used

### 3. Dependency Management
- Clearly mark task dependencies
- Update dependent tasks when prerequisites are completed
- Identify and resolve blockers promptly

### 4. Knowledge Capture
- Document any discoveries or insights in task notes
- Record any deviations from original plan
- Note any technical decisions made and rationale

## Recovery Strategies

### If Previous Session Context is Lost
1. Read `TASKS.md` thoroughly
2. Check git log for recent activity patterns
3. Look for any work-in-progress branches
4. Review any temporary files or notes
5. Start with the highest priority 📋 Todo task

### If Tasks Are Out of Sync
1. Review actual code state vs. task status
2. Update task status to reflect reality
3. Create new tasks for any discovered work
4. Reconcile any discrepancies in DoD completion

### If Blockers Are Encountered
1. Immediately update task status to ⛔ Blocked
2. Document specific blocker details
3. Identify who/what can resolve the blocker
4. Move to next highest priority unblocked task
5. Set up alerts/reminders to check blocker status

## Session Templates

### Starting a Session
```markdown
## Session Start: [Date/Time]
**Previous Context**: [Brief summary of where things were left]
**Today's Goals**: 
- [ ] [Primary objective]
- [ ] [Secondary objective]
**Current Priority Tasks**: [List from TASKS.md]
```

### Ending a Session
```markdown
## Session End: [Date/Time]
**Completed Today**:
- [List of finished items]
**In Progress**:
- [Items started but not finished]
**Next Session Should Focus On**:
- [Recommended next steps]
**New Blockers/Issues Found**:
- [Any new problems discovered]
```

This system ensures that every Claude Code session can pick up exactly where the previous one left off, maintaining continuity and progress momentum.