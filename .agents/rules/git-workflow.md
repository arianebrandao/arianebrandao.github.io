---
description: Fluxo de branches e autorização de commits neste repositório — nunca commitar sem pedido explícito e criar uma branch por plano.
globs: **/*
alwaysApply: true
---

# Fluxo de trabalho Git

## Nunca commitar por conta própria

Crie commit **somente** quando o pedido vier de forma explícita: "commite", "cria o commit",
"salva no git", "sobe as mudanças". Concluir a implementação de um plano, passar nos testes ou
fechar todos os TODOs **não** é autorização para commitar.

Motivo: a revisão do diff é uma etapa do fluxo. A Ariane revisa cada alteração antes de ela entrar
no histórico — um commit automático apaga essa etapa e obriga a desfazer histórico depois.

```
# certo: implementar, validar e parar
<nimplementa> → npx ... / rake test → git status --short + resumo do diff → "quer que eu commite?"

# errado: implementar e commitar no mesmo turno
<implementa> → git commit -m "..." → "commitei as mudanças"
```

Também não crie tag, não faça `git push`, `git merge`, `git rebase` nem abra PR por conta própria —
todos são ações visíveis fora da máquina local e dependem de pedido explícito.

Se um commit tiver sido criado sem pedido, desfaça preservando o trabalho:

```bash
git reset --soft HEAD~1     # mudanças ficam no index, nada é perdido
git restore --staged .      # opcional: volta tudo para "modifications"
```

`reset --soft` é sempre seguro: o commit continua acessível em `git reflog`.

## Uma branch por plano

Ao implementar um plano (aprovado ou não), crie e mude para uma branch **antes** da primeira
edição:

```bash
git switch -c <tipo>/<slug-do-plano>   # ex.: chore/dependabot-rubyzip-node26
```

- O nome segue o tipo do commit esperado (`feat`, `fix`, `chore`, `docs`...), conforme
  `.agents/rules/conventional-commits.md`.
- Comece a partir da `main` limpa (`git switch main && git pull` quando houver remoto).
- Se a implementação começou em `main` por engano, mova o trabalho sem commitar:
  `git switch -c <tipo>/<slug>` mantém a working tree intacta.
- Trabalho que não vem de um plano (ajuste pontual pedido direto) pode ficar em `main`, mas o
  pedido de commit continua sendo necessário.

## O commit em si vai para o commit-writer

Quando o pedido de commit chegar, delegue ao subagente `commit-writer`
(`.commandcode/agents/commit-writer.md`) com a lista de arquivos e o escopo de cada commit — ele
revisa o diff, escreve mensagens em Conventional Commits e **não** faz push.
