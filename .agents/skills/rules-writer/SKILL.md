---
name: rules-writer
description: Create, edit, and optimize agent rules and instruction files (AGENTS.md, CLAUDE.md, Cursor .mdc rules, Copilot instructions) across AI coding tools. Use when asked to create or update rules, agent instructions, or memory files, or when existing guidance is not being applied.
---

# Rules Writer

You are creating, editing, or optimizing **rules**: instruction files loaded into the model's
context at the start of every (or every matching) session. Rules shape general behavior
continuously; skills load on demand for specific tasks. Never encode a one-shot multi-step
workflow as a rule — that is a skill.

Pick a mode from the request:

- **create** → steps 1–3, then verify (step 5)
- **edit** → read the target file fully; smallest change that fixes the problem; re-verify
- **optimize / audit** → run the audit in step 4, propose fixes as a diff, re-verify

## 1. Inventory first — follow what exists

Before writing, scan the repo (and home for user-level guidance) for existing instruction files.
Extend what is there; do not fork a second source of truth for the same topic.

| Format | Typical location | Scoping mechanism |
| --- | --- | --- |
| `AGENTS.md` | repo root + nested dirs (cross-tool: Codex, Cursor, Copilot, Claude Code, Command Code) | nested files; closer to the working dir takes precedence; Codex caps the chain at 32 KiB |
| `CLAUDE.md` | repo root; `CLAUDE.local.md` (uncommitted); `~/.claude/CLAUDE.md`; `.claude/rules/*.md` | `.claude/rules` frontmatter `paths` globs |
| Cursor rules | `.cursor/rules/*.mdc` | frontmatter `description`, `globs`, `alwaysApply` |
| Copilot instructions | `.github/copilot-instructions.md`; `.github/instructions/**/*.instructions.md` | `applyTo` glob; `description` for on-demand load |
| `.agents/rules/*.md` | shared convention in this repo | frontmatter `description`, `globs`, `alwaysApply` (Cursor-compatible) |

Choose the narrowest format and scope that works:

- Needed by many tools → `AGENTS.md` (root, or nested next to the code it governs)
- Tool-specific behavior → that tool's native format
- Applies to every session → `alwaysApply: true` (sparingly — it costs context every turn)
- Applies to specific files → `globs` / `applyTo` / `paths`
- Relevant by topic, agent decides → `description` only, no globs, `alwaysApply: false`

Cursor-style frontmatter interactions: `alwaysApply: true` overrides everything; `globs`
auto-attach when a matching file is touched; description-only means the agent pulls the rule in
when it judges it relevant; neither description nor globs means manual @-mention only.

## 2. Write the rule

- One instruction = one simple, self-contained statement
- Explain WHY: "Use `date-fns`, not `moment.js` — moment is deprecated and bloats the bundle."
  Reasons let the model generalize correctly in edge cases
- Show preferred AND avoided patterns as concrete code examples
- Group related guidance under short headings; one focused file per topic
- Reference files by path (`@template.ts`, markdown links) instead of copying their content —
  and tell the agent what to look for inside them
- Match the language of the repo's existing instruction files; keep tone like clear internal docs
- Commit project rules to git so the whole team benefits

## 3. DO — checklist

- [ ] Start simple: add a rule only after observing the same mistake repeated
- [ ] Keep every rule focused, actionable, and scoped to the narrowest mechanism that works
- [ ] State the reasoning behind each convention
- [ ] Include concrete examples of both the preferred and the avoided pattern
- [ ] Scope file-specific guidance with globs/`applyTo`/`paths` instead of always-on
- [ ] Keep user/project/org guidance consistent — single source of truth per topic
- [ ] Verify in a fresh session with a small task where the rule should change the outcome

## 4. DON'T — never do

- Don't copy entire style guides into rules — use a linter; the model already knows common
  conventions
- Don't document obvious commands (`npm`, `git`, `pytest`) or anything derivable from the
  codebase — point to canonical files instead
- Don't add rules for edge cases that rarely apply
- Don't write vague guidance ("write good code", "handle errors properly", "be careful with
  security") — name the exact behavior
- Don't create contradictions across instruction sources: user/project/org rules merge
  additively and precedence is not guaranteed — resolve conflicts at the source, never by
  relying on file order
- Don't let files grow unbounded (Cursor: keep under 500 lines; Codex: 32 KiB across the whole
  chain) — split into nested, composable files instead
- Don't rely on `@file` mentions for content that must ALWAYS be in context — mentions are read
  on demand, not inlined; paste truly mandatory content into the rule body
- Don't shadow files by accident: `AGENTS.override.md` fully replaces `AGENTS.md` in its scope,
  and a plain `.md` in `.cursor/rules/` is ignored (must be `.mdc`)
- Don't commit local-only variants (`CLAUDE.local.md`) and never put secrets or credentials in
  rules
- Don't use a rule where a skill (multi-step workflow), a hook, or a linter (mechanical
  enforcement) is the right tool
- Don't skip the fresh-session test — a rule that never applies is dead context weight

## 5. Optimize existing rules

When asked to optimize or audit, read every instruction file in scope and flag:

1. **Contradictions** between user, project, and targeted files
2. **Duplication** of the same topic in more than one source
3. **Always-on content** that should be scoped by globs instead
4. **Vague statements** without a concrete, checkable behavior
5. **Stale references** (files, commands, or paths that no longer exist) — including scope
   lists copied from another project
6. **Missing WHY** on conventions that look arbitrary
7. **Over-length files** that should be split or scoped

Propose the fixes as a diff, apply after confirmation, then re-verify.

## 6. Verify

1. The file sits in a location the target tool discovers (see the table in step 1)
2. Frontmatter parses and scoping fields are correct for the intended trigger type
3. Fresh session + small representative task; confirm the guidance actually changed the output
4. If the rule is not applied: check the selected harness, the file location, glob/`applyTo`
   matches, and the tool's debug logs before editing the content
