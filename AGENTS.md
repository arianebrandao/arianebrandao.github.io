# AGENTS.md

Guidance for AI coding agents working in this repository.

## Project Overview

Personal portfolio and blog of Ariane Brandão (front-end developer / software engineer), published at **https://arianebrandao.github.io** via **GitHub Pages**. It is a static **Jekyll** site based on the [Indigo theme](https://github.com/sergiokopplin/indigo) (see `package.json`), customized through the repo's own `_layouts/` and `_includes/`. All site content (posts, pages, bio) is written in **Brazilian Portuguese (pt-BR)**.

## Commands

| Purpose | Command |
| --- | --- |
| Install Ruby dependencies | `bundle install` |
| Dev server | `bundle exec jekyll serve --config _config.yml,_config-dev.yml` → http://localhost:4000 |
| Build | `bundle exec jekyll build` (output to `_site/`) |
| Validate links/images | `bundle exec htmlproofer ./_site --only-4xx` (aliases: `npm test`, `rake test`) |
| Scaffold a new post | `./initpost.sh -c "Post Title"` |

Npm scripts (`npm run build`, `npm test`) exist in `package.json` but only wrap the Bundler/Jekyll commands above.

## Repository Structure

- `_config.yml` — site-wide config: identity/bio, social links, Google Analytics, Disqus, feature flags (`projects`, `about`, `blog`, `contact`), permalink (`/:title/`), plugin list.
- `_config-dev.yml` — dev override (`url: http://localhost:4000`); used by the serve command above. `_config_dev.yml` is a stale duplicate pointing to port 3000.
- `_posts/` — blog and portfolio posts (Markdown, see conventions below).
- `_layouts/` — page templates (`default`, `home`, `page`, `post`, `tag_index`, `compress`). This is the real "theme".
- `_includes/` — reusable partials (nav, footer, social links, analytics, Disqus, etc.).
- `assets/` — `css/` (Bulma is **vendored** as `bulma.min.css` plus `style.scss`), `js/` (`lazysizes.min.js`, `instafeed.min.js`), `images/` (post images under `assets/images/posts/<name>/`).
- Top-level pages: `index.html`, `about.md`, `contact.html`, `projects.html`, `blog/`, `tags.html`, `404.html`, `notallowed.html`.
- `.travis.yml` + `travis.sh` — CI pipeline (see Deployment).
- `initpost.sh` — post scaffolding script.

## Content Conventions

Posts live in `_posts/` and follow the filename pattern `YYYY-MM-DD-slug.md`. There are two front-matter shapes — copy from an existing post of the same kind:

**Blog post** (tutorial/experience, shown on the blog):
```yaml
---
title: "Post title"
layout: post
date: YYYY-MM-DD HH:MM
headerImage: false
tag:
- tag1
- tag2
category: blog
author: arianebrandao
description: Short description
---
```

**Project/portfolio post** (shown in Projects; not counted in blog pagination):
```yaml
---
title: "[Portfólio] Project Name - Tech"
layout: post
date: YYYY-MM-DD HH:MM
tag:
- projetos
- portfolio
image: https://arianebrandao.github.io/assets/images/posts/<name>/1.png
headerImage: true
projects: true
hidden: true
description: "Portfólio: Project Name"
category: project
author: arianebrandao
externalLink: false
comments: true
---
```

- Always set `author: arianebrandao` (must match the `authors` map in `_config.yml`).
- Write new content in **pt-BR**.
- Reference site URLs/images with `{{ site.url }}` (e.g. `{{ site.url }}/assets/images/posts/<name>/2.png`). For screenshots use the lazyload pattern: `<img data-src="{{ site.url }}/assets/images/posts/<name>/1.png" class="lazyload" alt="..." />` inside `<p align="center">`, plus a `<noscript>` fallback with plain `src`, and a `<figcaption class="caption">`.
- Permalinks are generated as `/:title/` — links between posts use the slugified title (e.g. `https://arianebrandao.github.io/bootloader-unlocker-root-umidigi-power-3/`).

## CI & Deployment

`.travis.yml` (Ruby 2.2.5) runs `./travis.sh` on push to the `gh-pages` or `next` branches: `bundle exec jekyll build` followed by `bundle exec htmlproofer ./_site --only-4xx`. The built site is served by GitHub Pages. Broken links (HTTP 4xx) fail CI — verify any external/edited URLs in posts.

## Gotchas

- **Gulp is legacy/broken**: `gulpfile.js` requires `./tasks/`, which no longer exists. Do not run `gulp` or try to "fix" it — use the Bundler/Jekyll commands above.
- The `minima` gem in the `Gemfile` is unused boilerplate from Jekyll's defaults; the actual theme is this repo's `_layouts/`/`_includes/`.
- Changes to `_config.yml` require restarting the dev server; most other files hot-reload.
- The `github-pages` gem pins the Jekyll/plugin versions — prefer plugins already listed in `_config.yml`.
- Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/) — see `.agents/rules/conventional-commits.md` for the allowed types, scopes, and format (e.g. `docs: update about me`).
