# Puppet Orchestration

Collection of prompts and a canonical skill to design, build, test, secure, and release maintainable Puppet modules without re-injecting a long master prompt in every conversation.

## Philosophy

Same foundation model as the other bases:
- thin entry prompt
- thin resume prompt
- one canonical skill
- focused references loaded only when needed
- practical templates ready to copy into a real repository

## Structure

- Prompt.md: start a new Puppet module project.
- Resume-prompt.md: resume an existing Puppet repository safely.
- skills/puppet-module-architect/SKILL.md: operating contract.
- skills/puppet-module-architect/reference/: topic-based engineering standards.
- skills/puppet-module-architect/templates/: ready-to-copy scaffold for Puppet module repos.

## Canonical multi-agent file

Templates use AGENT.md as the only canonical instruction source. The following pointer files redirect to it without duplicating rules:
- CLAUDE.md
- CODEX.md
- DEEPSEEK.md
- .github/copilot-instructions.md

## Context strategy

The base enforces explicit context lifecycle:
- READY when the base is stable.
- Proactive NEWCHAT recommendation around 60 percent thread load or when efficiency drops.
- Recommend /compact before NEWCHAT when a short compaction can safely preserve momentum.
