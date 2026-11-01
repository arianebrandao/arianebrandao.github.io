require 'html-proofer'

# rake test (default task)
desc "build and test website"

task :test do
  ENV['JEKYLL_ENV'] ||= 'production'
  sh "bundle exec jekyll build"
  HTMLProofer.check_directory("./_site", {
    checks: %w[Links Scripts],
    only_4xx: true,
    enforce_https: false,
    ignore_status_codes: [403],
    ignore_urls: [%r{/pages/arianebrandao}, %r{drive\.google\.com/open\?id=1UUmS1cI}]
  }).run
end

task default: :test
