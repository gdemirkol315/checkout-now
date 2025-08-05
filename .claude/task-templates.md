# Task Templates for Claude Code Sessions

## Quick Task Template
```markdown
#### TASK-XXX: [Task Title]
- **Status**: 📋 Todo | 🟡 In Progress | ✅ Done | ⛔ Blocked | 🧊 Icebox
- **Priority**: 🔥 Critical | 🟠 High | 🟡 Medium | 🔵 Low
- **Assignee**: [Team/Person]
- **Epic**: [Epic Name]
- **Story Points**: [1,2,3,5,8,13,21]

**Description**: [What needs to be done]

**Acceptance Criteria**:
- [ ] [Specific testable criterion 1]
- [ ] [Specific testable criterion 2]
- [ ] [Specific testable criterion 3]

**Technical Tasks**:
- [ ] [Specific implementation task 1]
- [ ] [Specific implementation task 2]

**Blockers**: [List any blockers or "None"]

**DoD Checklist**:
- [ ] ✅ Code reviewed and approved
- [ ] ✅ Tests passing (unit + integration)
- [ ] ✅ Documentation updated
- [ ] ✅ Security review completed
- [ ] ✅ Performance validated
```

## Standard Definition of Done (DoD)
Copy this checklist for each task:

```markdown
**Definition of Done (DoD)**:
- [ ] ✅ Requirements fully implemented
- [ ] ✅ Code reviewed and approved by peer
- [ ] ✅ All automated tests passing
- [ ] ✅ Manual testing completed
- [ ] ✅ Security review completed (if applicable)
- [ ] ✅ Performance requirements met
- [ ] ✅ Documentation updated
- [ ] ✅ Error handling implemented
- [ ] ✅ Logging and monitoring configured
- [ ] ✅ Deployment tested in staging
- [ ] ✅ Acceptance criteria verified
- [ ] ✅ Product owner approval received
```

## Epic Templates

### Infrastructure Epic
```markdown
## Epic: Infrastructure Setup
**Goal**: Establish robust, scalable infrastructure
**Duration**: 2-4 weeks
**Success Metrics**: 
- 99.9% uptime
- <2s response time
- Zero critical security issues
```

### Feature Development Epic
```markdown
## Epic: [Feature Name]
**Goal**: Deliver [specific business value]
**Duration**: [timeframe]
**Success Metrics**: 
- [Quantifiable success measure 1]
- [Quantifiable success measure 2]
- [User satisfaction metric]
```

## Priority Guidelines

### 🔥 Critical
- System down or major functionality broken
- Security vulnerabilities
- Data loss risk
- Blocking other team members

### 🟠 High  
- Important features for upcoming release
- Performance issues affecting users
- Technical debt with high impact

### 🟡 Medium
- Feature enhancements
- Non-critical bugs
- Process improvements

### 🔵 Low
- Nice-to-have features  
- Minor UX improvements
- Cleanup tasks

## Story Point Guidelines

- **1 point**: Trivial change (typo fix, config change)
- **2 points**: Small feature or bug fix (few hours)
- **3 points**: Small feature requiring some design (half day)
- **5 points**: Medium feature, well understood (1-2 days)
- **8 points**: Large feature, some unknowns (3-5 days)
- **13 points**: Complex feature, many unknowns (1-2 weeks)
- **21 points**: Epic-sized, break down into smaller tasks

## Claude Code Integration Tips

1. **Reference tasks in commits**: Use "TASK-XXX" in commit messages
2. **Update status regularly**: Keep TASKS.md current
3. **Link to code**: Reference file paths and line numbers in tasks
4. **Session continuity**: Always check TASKS.md when starting new session
5. **Template usage**: Copy templates for consistency