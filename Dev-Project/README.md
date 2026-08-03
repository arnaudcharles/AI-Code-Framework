# Dev-Project
Collection of prompt to work better with Claude on projects, avoiding high token cosumption.

Claude will say **READY** when he know enough of the project, the base is build and you need to start a new chat.

When the context window is starting to be too wide, he will say **NEWCHAT** to propose you to reduce token cost. If you think you still have things to do or achieve try to **/compact** and continue the chat but then whne it's ok for you, open the new chat.

## Project Documentation Map

This repository uses a documentation structure designed for clarity, maintainability, and safe context switching.

### CLAUDE.md
Contains stable project rules, working principles, architecture constraints, commands, and durable context that should remain valid across conversations.

### PROJECT.md
Contains the living state of the project: current status, active decisions, tasks, blockers, open questions, and next steps.

### SECURITY.md
Contains security rules, secret-handling requirements, access constraints, safe development practices, and trust-boundary guidance.

### CONTRIBUTING.md
Contains collaboration rules for contributors: branching, commit messages, merge requests, naming conventions, review expectations, and onboarding guidance.

### /docs
Contains structured technical, functional, and product documentation that explains the project in depth.

### /manuals
Contains user-facing manuals, examples, commands, usage guides, troubleshooting notes, and operational instructions.

### How to use this structure
- Read CLAUDE.md first for stable operating rules.
- Read PROJECT.md for the current state of the work.
- Read SECURITY.md before touching sensitive or security-related code.
- Read CONTRIBUTING.md before proposing changes.
- Read /docs for detailed reference material.
- Read /manuals for usage instructions and examples.

# Starting a new chat

Small change, link: CLAUDE.md
Usual work, link: CLAUDE.md + PROJECT.md
Structual work, link: CLAUDE.md + PROJECT.md + /manuals + /docs + SECURITY.md