---
title: "Como reparar o HD isolando BadBlocks usando Linux ou Windows"
layout: post
date: 2019-11-24 16:55
headerImage: false
tag:
- linux
- reparar hd
- windows
- badblocks
- reparar disco rígido
category: blog
author: arianebrandao
description: Como reparar HD isolando BadBlocks usando Linux ou Windows

---

### Reparar o HD (Disco Rígido)
Quando o HD começa a apresentar problemas e erros, como lentidão no carregamento do Sistema Operacional ou acesso aos dados gravados por exemplo, pode ser devido a um setor defeituoso (badblock) presente no HD. Para contornar esse problema, podemos isolar esses badblocks para que não sejam salvos arquivos nesses setores, assim evitando problemas. **É importante entender que o isolamento de blocos do HD impacta na diminuição da capacidade de armazenamento**.


### Procedimentos no Windows
Primeiramente é interessante verificar se o HD contém badblocks, para então executar o comando para reparar.


#### Verificando o disco
Para a verificação, eu uso o **HD Tune**, basta dar um Scan na aba **Error Scan**. Se for encontrado algum bloco defeituoso (damaged), você então já sabe que precisa fazer o isolamento dos badblocks.


#### Isolando os badblocks
O Windows oferece uma ferramenta que verifica e repara os setores danificados do seu HD, conhecida como "chkdsk". **Antes de prosseguir, salve os dados importantes do seu HD em um lugar seguro**. Dentro da janela de prompt de comando, digite para fazer a verificação e reparo (nesse caso, é na Unidade 'C:' do HD - substitua o 'C' pela unidade que você deseja):
```
chkdsk /f /r C:
```

Se for a unidade que está rodando o Sistema Operacional, vai aparecer a mensagem "Deseja agendar a verificação deste volume para a próxima vez em que o sistema for reiniciado?". Aperte a tecla "S" para confirmar. Reinicie o computador que o procedimento será executado.

**Lembrando que podem demorar horas para fazer a verificação por completo**. Caso queira cancelar e fazer a verificação em outro momento, digite o comando "chkntfs /x C:".
 Caso contrário, a verificação será feita e os bad block serão identificados e, no caso dos bad blocks de software, corrigidos no seu HD.


### Procedimentos no Linux
Primeiramente é interessante verificar se o HD contém badblocks, para então executar o comando para reparar. Precisamos saber qual partição do HD vamos testar, para isso, abrimos o terminal e digitamos o comando: 
```
sudo fdisk -l
```
As partições então serão listadas, geralmente algo parecido com "/dev/sda1". Você também pode usar o programa GParted (já vem instalado em algumas distros) para listar as partições do HD.


#### Verificando o disco
Para executar o teste por badblocks apenas por leitura de informações digite o comando no terminal, **onde o X é substituído pelo número da partição**:
```
sudo badblocks -sv -c 1024 /dev/sdaX
```
Este próximo comando testa o HD lendo, escrevendo e também verificando as informações, é um método mais completo e mais lento:
```
sudo badblocks -nsv -c 10240 /dev/sdaX
```

#### Isolando os badblocks
**Antes de prosseguir, salve os dados importantes do seu HD em um lugar seguro**.
O próximo comando usa o método anterior **e também formata a partição selecionada**:
```
sudo badblocks -wsv -c 10240 /dev/sdaX
```

Explicando os parâmtros do comando:
```
-s = Mostra o avanço do procedimento
-v = verbose mode
-c 10240 = Verifica 10 mil blocos de HD por vez
-n = non-destructive read-write
-w = destructive write-mode
```
**Lembrando que podem demorar horas para fazer a verificação por completo**.


Links que me ajudaram:
<https://www.techtudo.com.br/dicas-e-tutoriais/noticia/2015/02/aprenda-como-recuperar-um-hd-com-bad-blocks-e-proteja-seus-dados.html>
<https://www.diolinux.com.br/2014/05/verificando-badblocks-no-ubuntu.html>


Isso é tudo pessoal o/