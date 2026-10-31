---
name: validate-site
description: Validate the Jekyll site locally in an ephemeral podman container running the exact CI pipeline (bundle install, jekyll build, htmlproofer with CI-matching flags). Use when asked to validate or test the site locally, check for broken links, run the build or tests, or when bundle/jekyll/rake/npm test commands are needed but Ruby is unavailable on the host. Triggers include "validar o site", "rodar os testes", "testar links antes do push", "build local".
---

# Validate Site Locally

This machine has no Ruby (Fedora Silverblue; the `dev-ubuntu` toolbox has none either).
Validation therefore runs in an ephemeral podman container with the same Ruby 3.2 and the
same flags as CI. Dependency: `podman` (present on the host). Run everything from the repo
root.

## Steps

```bash
# 1. Start the container (first run pulls the image; project mounts at /work;
#    label=disable avoids SELinux relabeling of the project files)
podman run -d --name jekyll-ci --security-opt label=disable \
  -v "$PWD":/work -w /work docker.io/library/ruby:3.2 sleep infinity

# 2. Install gems (slow on first run: native gems like sassc/eventmachine compile)
podman exec jekyll-ci bundle install

# 3. Build exactly like CI
podman exec -e JEKYLL_ENV=production jekyll-ci bundle exec jekyll build

# 4. Check links — flags MUST match .github/workflows/ci.yml
podman exec jekyll-ci bundle exec htmlproofer ./_site --only-4xx \
  --checks Links,Scripts --no-enforce-https --ignore-status-codes 403 \
  --ignore-urls '/\/pages\/arianebrandao/,/drive\.google\.com\/open\?id=1UUmS1cI/'

# 5. Always remove the container, even after failures
podman rm -f jekyll-ci
```

Worked example: after editing `_posts/<some-post>.md`, run all five commands; if htmlproofer
reports a failure, fix it in the source file (never in `_site/`), then rerun steps 3-4 until
it prints "HTML-Proofer finished successfully", then step 5. To re-check links only (gems
already installed), reuse the running container for steps 3-5 and skip step 2.

Step 2 deliberately uses Bundler's default path inside the container — do NOT set
`BUNDLE_PATH=vendor/bundle` locally. CI installs gems there because the workspace is
throwaway; locally it would put them in the source tree (the reason `_config.yml` excludes
`vendor`).

## Why each htmlproofer flag (keep in sync with CI, Rakefile, and `npm test`)

- `--checks Links,Scripts` — the Images check is off because lazyload images use `data-src`
  and have no `src`, which that check reports as a failure.
- `--no-enforce-https` — old posts and the Disqus include intentionally keep `http://` links.
- `--ignore-status-codes 403` — bot walls (GitLab issues, winehq.org) return 403 to crawlers.
- `--ignore-urls /pages/arianebrandao/` — `jekyll-github-metadata` writes these URLs into
  canonical tags when building WITHOUT `JEKYLL_GITHUB_TOKEN`; CI passes the Actions
  `GITHUB_TOKEN`, so this artifact only appears in local builds.
- `--ignore-urls drive.google.com/open?id=1UUmS1cI` — known-dead Warframe patch link,
  pending a replacement (see AGENTS.md). Remove this ignore when the link is fixed.

## Troubleshooting

- `Your bundle only supports platforms ['x86_64-linux']` when bundling from another OS: run
  `bundle lock --add-platform <your-platform>` and commit the updated lock. The lock
  currently declares only x86_64-linux.
- `No repo name found` during build: `_config.yml` must keep
  `repository: arianebrandao/arianebrandao.github.io`.
- Build warning `No GitHub API authentication could be found` — expected locally without a
  token; only optional GitHub metadata is missing.
