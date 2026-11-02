require 'html-proofer'

# Domínios de clientes/projetos antigos que saíram do ar (link rot). Remover a
# entrada correspondente quando o link for atualizado ou retirado do post.
dead_urls = %w[
  aliou.com.br avioesavenda.com.br bazardakim.com gloucos.com.br
  kimcrivel.com pedigreelove.com.br redefood.com websofthouse.com.br
  revistabicicleta.com meupinguim.com
].map { |domain| %r{\Ahttps?://(www\.)?#{Regexp.escape(domain)}(?:/|\z)} }

# rake test (default task)
desc "build and test website"

task :test do
  ENV['JEKYLL_ENV'] ||= 'production'
  sh "bundle exec jekyll build --strict_front_matter --trace"
  HTMLProofer.check_directory("./_site", {
    checks: %w[Links Scripts Images],
    enforce_https: true,
    # 403: bot walls; 999: LinkedIn blocks crawlers
    ignore_status_codes: [403, 999],
    # The Drive ignore is a known-dead link in the Warframe post, pending a replacement.
    ignore_urls: dead_urls + [%r{\Ahttps://drive\.google\.com/open\?id=1UUmS1cI}],
    # Lazyload images carry the real path in data-src
    swap_attributes: { "img" => ["data-src", "src"] }
  }).run
end

task default: :test
