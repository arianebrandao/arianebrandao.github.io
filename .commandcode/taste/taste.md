# Taste

## Communication
- User communicates in Brazilian Portuguese (pt-BR); respond in pt-BR. Confidence: 0.7
- Prefers AI/agent-facing docs (e.g., AGENTS.md) written in English, even when the repo's README, posts, and commits are in pt-BR — chose English when asked, overriding the assistant's Portuguese recommendation. Confidence: 0.7

## Authoring Skills & Rules
- Agent instruction documents the user asks for (skills, rules, etc.) must always include an explicit "what NOT to do" section — prohibitions/anti-patterns alongside the positive guidance. User emphasized this as "important and significant". Confidence: 0.9

## Git & Commits
- Never include a "Co-authored-by" trailer in commit messages — user explicitly banned it after the assistant added one. Confidence: 0.95
- Prefers Conventional Commits (`type(scope): description`) over informal ad-hoc commit messages — when asked to choose between keeping the Conventional Commits rule or adapting it to the repo's old lowercase pt-BR style ("atualiza about me"), user chose to keep the rule and update AGENTS.md to match. Confidence: 0.8
