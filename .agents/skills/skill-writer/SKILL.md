---
name: skill-writer
description: Create, edit, and optimize Agent Skills (SKILL.md directories) following the agentskills.io open standard. Use when asked to create a new skill, fix or update an existing one, audit or optimize skill quality, or whenever a SKILL.md file is written or modified.
---

# Skill Writer

You are creating, editing, or optimizing an Agent Skill: a directory with a `SKILL.md` manifest
that any agent implementing the open standard (https://agentskills.io/specification) can discover
and load on demand — Command Code, Claude Code, Codex, Cursor, Copilot, OpenCode, and others.

Pick a mode from the request and follow it:

- **create** → steps 1–4, then verify (step 6)
- **edit** → read the entire skill directory first; apply the smallest change that fixes the
  problem; never rewrite untouched parts; re-run verify
- **optimize / audit** → score the skill against the DO (step 4) and DON'T (step 5) checklists,
  fix every violation, re-run verify

## 1. Pin down the job

Three answers before writing anything — from context if present, otherwise ask:

- **What does it do?** ONE capability per skill. Two loosely related jobs (e.g. "release notes
  and versioning") = two skills, not one.
- **When should it trigger?** The exact phrases a user would say. This becomes the `description`,
  which is the only thing the model sees before deciding to load the skill.
- **What does it need?** Scripts, templates, reference docs. This decides whether a single
  `SKILL.md` is enough or supporting directories are required.

## 2. Name and location

Name rules are enforced at load time — a violation means the skill is skipped, often silently:

- 1–64 characters; only lowercase letters `a-z`, digits `0-9`, and hyphens
- No leading, trailing, or consecutive hyphens — must match `^[a-z0-9]+(-[a-z0-9]+)*$`
- **Must equal the directory name**: `my-skill/SKILL.md` declares `name: my-skill`
- Prefer verb-or-domain names that survive out of context: `changelog-writer` beats `helper`

Locations:

| Location | Scope |
| --- | --- |
| `.agents/skills/<name>/` (project) | this repo; portable across Claude Code, Codex, Cursor, Copilot, OpenCode |
| `.commandcode/skills/<name>/` (project) | everyone in this repo (Command Code) |
| `.claude/skills/<name>/` (project) | Claude Code sessions in this repo |
| `~/.agents/skills/<name>/` or `~/.commandcode/skills/<name>/` | this user, every project |

Default to the project location for repo-specific workflows; the user location for personal
habits that travel. Discovery is recursive, so grouping subdirectories
(`skills/docs/changelog-writer/`) is allowed — the identity comes from the innermost folder.

## 3. Frontmatter

Standard fields (spec-compliant; safe everywhere):

| Field | Constraint |
| --- | --- |
| `name` | see step 2 |
| `description` | 1–1024 chars, non-empty; what it does + when to use it, third person, with trigger words |
| `license` | short license name or reference to a bundled license file |
| `compatibility` | ≤500 chars; only when the skill has real environment requirements |
| `metadata` | string→string map (author, version, …); use reasonably unique keys |
| `allowed-tools` | space-separated pre-approved tools; experimental, support varies — only with user consent |

Description formula:

```
<what it does>, <how / what it produces>. Use when <trigger phrases>.
```

Good: `Extract text and tables from PDF files, fill forms, merge documents. Use when working
with PDF files or when the user mentions PDFs, forms, or document extraction.`

Tool-specific extensions (`argument-hint`, `disable-model-invocation`, `user-invocable`,
`paths`, `model`) exist but are NOT in the open standard. Other tools ignore them safely, but
some surfaces (claude.ai upload, Skills API) reject unknown fields with a hard error. Add them
only when the workflow genuinely needs them.

## 4. Write the body — and what TO do

The body is an instruction set for an agent, not documentation for a human.

- [ ] Write imperative steps, exact commands, and decision rules for edge cases
- [ ] Include one concrete worked example — it beats paragraphs of prose
- [ ] Respect progressive disclosure: metadata always in context (~100 tokens) → SKILL.md body
      on activation (<5k tokens recommended, <500 lines) → `references/`, `assets/`, `scripts/`
      loaded only when the body points at them
- [ ] Keep file references one level deep from `SKILL.md`, relative paths, forward slashes:
      `references/format.md`
- [ ] Add a table of contents at the top of any reference file longer than 100 lines
- [ ] Make scripts self-contained, with explicit error handling and documented dependencies —
      and state clearly whether the agent should RUN (`scripts/x.sh`) or READ the script
- [ ] Match specificity to fragility: exact script with no variation for risky operations
      (migrations, deploys); heuristics and high freedom for judgment calls (reviews)
- [ ] Use consistent terminology — pick one term ("endpoint") and never mix synonyms ("URL",
      "route", "path")
- [ ] Structure complex workflows as checklists the agent can copy and track progress with

## 5. DON'T — never do

- Don't write vague names (`helper`, `utils`, `tools`, `documents`) or vague descriptions
  (`Helps with PDFs`, `Processes data`)
- Don't use first or second person in the description ("I can help…", "You can use…") — it is
  injected into the system prompt; write third person
- Don't exceed 64 chars in `name` or 1024 in `description`; no XML tags, uppercase, or
  consecutive hyphens in the name — the skill silently fails to load
- Don't namespace the name yourself (`myorg/skillname`, `myorg:skillname`) — plugins add
  prefixes automatically; manual prefixes break loading
- Don't bundle two loosely related jobs in one skill — split it
- Don't paste long reference material into `SKILL.md` — move it to `references/` and link it
- Don't chain references (`SKILL.md` → `a.md` → `b.md`); agents may only preview the deep file
  and end up with incomplete information
- Don't explain what the model already knows (what a PDF is, how pip works). Every token in the
  body competes with conversation history
- Don't include time-sensitive content ("before August 2025 use X, after use Y") — keep a
  "legacy patterns" section instead
- Don't offer five alternative libraries — pick one default and name the single exception
- Don't use Windows-style backslash paths (`scripts\helper.py`) — always forward slashes
- Don't assume packages or tools are installed — state the dependency and install command
- Don't add `allowed-tools` grants without explicit user consent, and don't leave unreviewed
  permission grants in skills checked into shared repos
- Don't use reserved names (`synced`, `anthropic-skills`, `anthropic`, `claude`)
- Don't ship a skill untested — one that never triggers, or over-triggers on unrelated tasks,
  is worse than no skill

## 6. Verify

1. **Frontmatter**: `name` matches the regex and the directory name; description within limits;
   YAML parses cleanly
2. **Discovery**: the skill appears in the agent's skill list with no warning (Command Code:
   `cmd skills list` or `/skills`; most other tools need a session restart)
3. **Trigger test**: in a FRESH session, send a prompt matching the description and confirm the
   skill activates; leftover context from authoring masks gaps
4. **Invocation test**: invoke `/name` directly with a small task and confirm the agent follows
   the body as written
5. **Trim**: remove anything the agent did not need while following the instructions

If the skill will be shared or committed: skills are instructions plus executable code — tell
the consumer to review the content before trusting it.
