---
title: "Como solucionar 'Este aplicativo foi bloqueado para sua proteção'"
layout: post
date: 2019-12-29 16:55
headerImage: false
tag:
- erro
- controle de contas de usuário
- windows
- UAC
category: blog
author: arianebrandao
description: Como solucionar 'Este aplicativo foi bloqueado para sua proteção'

---

### Erro ao tentar executar um programa e/ou jogo
O Windows tem uma proteção que impede a execução de programas que ele considera perigosos para o sistema, essa proteção se chama Controle de Contas de Usuário do Windows (UAC, em inglês). Porém, pode acontecer dessa proteção impedir a execução de programas legítimos (ou não tão legítimos, mas que você deseja executar mesmo assim ;P ), nesse caso, a mensagem "Este aplicativo foi bloqueado para sua proteção" será exibida na tela e não será possível executar o programa. Para evitar esse problema, podemos usar um comando para desativar o Controle de Contas de Usuário do Windows.


### Como desativar o Controle de Contas de Usuário do Windows
Execute o Prompt de Comando como administrador, você pode fazer isso digitando na barra de pesquisa do Windows "cmd", então clique em Prompt de Comando com o botão direito e em "Executar como administrador".

No Prompt de Comando, digite (ou copie e cole):
```
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /V EnableLUA /T REG_DWORD /D 0 /F
```

Aperte enter e pronto. **Reinicie o seu computador** e está feito, agora você já deve poder abrir os programas sem eles serem bloqueados pelo Controle de Contas de Usuário do Windows.


Links que me ajudaram:
<https://www.techtudo.com.br/dicas-e-tutoriais/2018/12/como-resolver-o-erro-este-aplicativo-foi-bloqueado-para-sua-protecao.ghtml>


Isso é tudo pessoal o/