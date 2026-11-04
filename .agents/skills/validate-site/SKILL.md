---
name: validate-site
description: Validate the Jekyll site locally in an ephemeral podman container running the exact CI pipeline (npm build:css, bundle install, then rake test = jekyll build + htmlproofer with CI-matching flags). Use when asked to validate or test the site locally, check for broken links, run the build or tests, or when bundle/jekyll/rake commands are needed but Ruby is unavailable on the host. Triggers include "validar o site", "rodar os testes", "testar links antes do push", "build local".
---

# Validate Site Locally

This machine has no Ruby (Fedora Silverblue; the `dev-ubuntu` toolbox has none either).
Validation therefore runs in an ephemeral podman container with the same Ruby 3.2 and the
same flags as CI. Dependency: `podman` (present on the host). Run everything from the repo
root.

## Steps

```bash
# 0. Build the CSS on the host (Node/npm). The site serves the committed
#    assets/css/style.min.css; CI fails if it is stale after this build.
npm ci && npm run build:css
git diff --exit-code -- assets/css/style.min.css

# 1. Start the container (first run pulls the image; project mounts at /work;
#    label=disable avoids SELinux relabeling of the project files)
podman run -d --name jekyll-ci --security-opt label=disable \
  -v "$PWD":/work -w /work docker.io/library/ruby:3.2 sleep infinity

# 2. Install gems (slow on first run: native gems like sassc/eventmachine compile)
podman exec jekyll-ci bundle install

# 3. Build exactly like CI and check links in one step
#    (the Rakefile is the single source of truth for the flags; it sets
#    JEKYLL_ENV=production itself — no token needed locally)
podman exec jekyll-ci bundle exec rake test

# 4. Always remove the container, even after failures
podman rm -f jekyll-ci
```

Worked example: after editing `_posts/<some-post>.md` or any layout/class, run step 0, then
the four container commands; if htmlproofer reports a failure, fix it in the source file (never
in `_site/`), then rerun step 3 until it prints "HTML-Proofer finished successfully", then
step 4. To re-check links only (gems already installed), reuse the running container for
steps 3-4 and skip step 2.

Step 2 deliberately uses Bundler's default path inside the container — do NOT set
`BUNDLE_PATH=vendor/bundle` locally. CI installs gems there because the workspace is
throwaway; locally it would put them in the source tree (the reason `_config.yml` excludes
`vendor`).

## Why each htmlproofer flag (defined only in the `Rakefile`; CI calls `rake test`)

- `checks: Links, Images, Scripts` + `swap_attributes: { "img" => ["data-src", "src"] }` —
  lazyload images carry the real path in `data-src`; the swap lets the Images check validate
  them instead of disabling the check.
- `enforce_https: true` — internal and external links must use HTTPS. If a new `http://` link
  fails, upgrade it in the source rather than disabling the flag.
- `ignore_status_codes: [403, 999]` — bot walls (GitLab issues, winehq.org) return 403 and
  LinkedIn returns 999 to crawlers.
- `ignore_urls` (dead client/project domains) — `aliou.com.br`, `avioesavenda.com.br`,
  `bazardakim.com`, `gloucos.com.br`, `kimcrivel.com`, `pedigreelove.com.br`, `redefood.com`,
  `websofthouse.com.br`, `revistabicicleta.com`, `meupinguim.com` no longer resolve or serve.
  Remove the entry when the corresponding link is updated or dropped from the post.
- `ignore_urls drive.google.com/open?id=1UUmS1cI` — known-dead Warframe patch link, pending a
  replacement (see AGENTS.md). Remove this ignore when the link is fixed.

## Troubleshooting

- Stale CSS: `git diff --exit-code -- assets/css/style.min.css` fails after step 0 — run
  `npm run build:css` and commit the regenerated `style.min.css`. The site serves the
  committed file; editing only `assets/css/tailwind.css` or the templates changes nothing
  until the CSS is rebuilt.
- `Your bundle only supports platforms [...]` when bundling from another OS: run
  `bundle lock --add-platform <your-platform>` and commit the updated lock. The lock declares
  `x86_64-linux`, `x86_64-darwin-22` and `arm64-darwin-22`.
- Internal links gain a `/pages/arianebrandao` prefix and fail: `_config.yml` must keep
  `baseurl: ""`, otherwise `jekyll-github-metadata` injects that fallback when building
  without `JEKYLL_GITHUB_TOKEN`.
- `No repo name found` during build: `_config.yml` must keep
  `repository: arianebrandao/arianebrandao.github.io`.
- Build warning `No GitHub API authentication could be found` — expected locally without a
  token; only optional GitHub metadata is missing.
