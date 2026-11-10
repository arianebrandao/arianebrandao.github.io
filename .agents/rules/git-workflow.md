---
description: Fluxo de branches e autorização de commits neste repositório — trabalhar na branch dev, perguntar antes de criar branch nova e nunca commitar sem pedido explícito.
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

## Branch de trabalho: `dev`

Todo trabalho acontece na branch `dev`. Uma branch própria só existe quando a Ariane pede.

### Ao implementar um plano: pergunte antes

Antes da primeira edição de qualquer plano (aprovado ou não), pergunte qual branch usar:

- **Continuar em `dev`** — padrão para trabalho do dia a dia.
- **Criar branch nova** — quando o plano vira um commit/PR isolado.

Sem resposta, continue em `dev`. **Não crie branch por conta própria** e não troque de branch no
meio da implementação.

```bash
git switch dev                    # continuar na dev
git switch -c <tipo>/<slug>       # branch nova, ex.: fix/postcss-selector-parser-override
```

- O nome da branch nova segue o tipo do commit esperado (`feat`, `fix`, `chore`, `docs`...), conforme
  `.agents/rules/conventional-commits.md`.
- Branch nova sai da `dev` atualizada (`git switch dev && git pull` quando houver upstream).
- Se a implementação começou na branch errada por engano, mova o trabalho sem commitar:
  `git switch -c <tipo>/<slug>` mantém a working tree intacta.
- Ajuste pontual pedido direto (sem plano) fica na `dev`, mas o pedido de commit continua sendo
  necessário.

## O commit em si vai para o commit-writer

Quando o pedido de commit chegar, delegue ao subagente `commit-writer`
(`.commandcode/agents/commit-writer.md`) com a lista de arquivos e o escopo de cada commit — ele
revisa o diff, escreve mensagens em Conventional Commits e **não** faz push.

Ao delegar (e ao revisar o resultado), lembre explicitamente: **mensagem sem trailer
`Co-authored-by` nem atribuição a IA** — a regra está em
`.agents/rules/conventional-commits.md` e vale mesmo que o harness do agente sugira o trailer por
padrão. Se algum commit local (ainda não publicado) já saiu com o trailer, corrija o histórico
antes do push:

```bash
git commit --amend -F - <<'EOF'
<tipo>(<escopo>): <descrição>
EOF
```
