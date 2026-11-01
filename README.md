<p align="center">
  <img alt="Website arianebrandao.github.io" src=".github/app.jpg" width="100%">
</p>

## arianebrandao.github.io
Meu site pessoal onde mostro alguns dos meus trabalhos e uso o blog para falar sobre soluções que encontrei para problemas do meu dia-a-dia com tecnologias que uso ou meus hobbies.

## App online
O site está no ar no link: [arianebrandao.github.io](https://arianebrandao.github.io/), hospedado aqui, no [Github Pages](https://pages.github.com/).

## Tecnologias

Esse projeto foi desenvolvido com as seguintes tecnologias:

- [Jekyll](https://jekyllrb.com) - Jekyll é um gerador de site/blog estático
- [GitHub Actions](https://github.com/features/actions) - CI: valida o build e os links do site a cada push/PR (o deploy é feito pelo GitHub Pages)
- [Git](https://git-scm.com/) - Controle de versionamento de códigos
- [Bulma](https://bulma.io) - Framework de CSS
- Javascript

## Como rodar localmente

Não é necessário ter Ruby instalado: o servidor roda dentro de um container com a mesma versão do Ruby usada no CI (3.2). Com **Podman**, execute na raiz do repositório:

```bash
# 1. Crie o container com o projeto montado e a porta 4000 publicada
podman run -d --name jekyll-dev --security-opt label=disable \
  -p 4000:4000 -v "$PWD":/work -w /work \
  docker.io/library/ruby:3.2 sleep infinity

# 2. Instale as dependências (primeira vez, ou depois de mudar o Gemfile)
podman exec jekyll-dev bundle install

# 3. Suba o servidor de desenvolvimento
podman exec jekyll-dev bundle exec jekyll serve \
  --config _config.yml,_config-dev.yml --host 0.0.0.0
```

Acesse **http://127.0.0.1:4000**. Use `127.0.0.1` em vez de `localhost`: no Podman, a porta publicada escuta apenas em IPv4, e se o seu sistema resolver `localhost` para IPv6 (`::1`) — como acontece no Fedora — a conexão falha.

O `jekyll serve` fica em primeiro plano — `Ctrl+C` encerra o servidor e o container continua disponível para o próximo `serve`. Mudanças em posts e páginas recarregam automaticamente; alterações em `_config.yml` exigem reiniciar o comando.

Para validar o build e os links como o CI faz (build + htmlproofer, flags definidas no `Rakefile`):

```bash
podman exec jekyll-dev bundle exec rake test
```

Ao terminar, remova o container:

```bash
podman rm -f jekyll-dev
```

Com Docker, troque `podman` por `docker` e remova `--security-opt label=disable` (essa opção é necessária no Podman para evitar o relabel do SELinux nos arquivos montados).

## Licença

Esse projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
