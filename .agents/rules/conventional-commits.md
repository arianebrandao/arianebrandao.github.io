---
description: Enforce Conventional Commits pattern for all commits in this project.
globs: **/*
alwaysApply: true
---

# Conventional Commits

This project follows the [Conventional Commits](https://www.conventionalcommits.org/) specification.

## Format

```
<tipo>(<escopo>): <descrição>
```

## Allowed Types

| Type       | Description                                          |
| ---------- | ---------------------------------------------------- |
| `feat`     | New feature                                          |
| `fix`      | Bug fix                                              |
| `docs`     | Documentation changes                                |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `chore`    | Maintenance tasks (configs, dependencies, etc.)      |
| `build`    | Changes to the build system                         |
| `test`     | Adding or correcting tests                          |

## Optional Scope

The scope is optional and indicates the affected area:

- `config` — site configuration, CI, and deploy
- `posts` — blog and portfolio posts (`_posts/`)
- `theme` — layouts and includes (`_layouts/`, `_includes/`)
- `assets` — stylesheets, scripts, and images

## Examples

```
feat(posts): add portfolio post for umidigi project
fix(theme): footer social links not rendering
docs: update about me
refactor(theme): extract nav partial into _includes
chore: bump jekyll dependencies
```

## Rules

- Use imperative mood in the infinitive ("add feature", not "added feature")
- Do not capitalize the first letter
- Do not add punctuation at the end
- Maximum 72 characters for the title
- Use the body (separated by a blank line) for explanations when needed
