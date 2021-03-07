---
title: "Linux - jogar Warframe direto da Steam Play"
layout: post
date: 2018-10-25 16:06
headerImage: false
tag:
- linux
- games
- steam
- warframe
category: blog
author: arianebrandao
description: Linux - jogar Warframe direto da Steam Play (com Proton)

---

<p align="center"><img data-src="{{ site.url }}/assets/images/posts/linux-jogar-warframe/1.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/linux-jogar-warframe/1.jpg" alt="Screenshot" /></p>
</noscript>

### Sobre o Warframe

Melhor MMO que eu respeito :3  
Veja a [introdução ao jogo](https://www.warframe.com/pt-br/game/quickstart).

---

### Como jogar direto da Steam Play

Tenha sua Steam configurada: [veja um post anterior onde mostro todos os passos](https://arianebrandao.github.io/linux-steam-play/).

1. Procure por Warframe na loja da Steam, clique para instalar.  
2. Para o jogo abrir e rodar normalmente, é preciso colocar um patch na pasta do jogo.
[Clique aqui para baixar o patch](https://drive.google.com/open?id=1UUmS1cI_QKGc2rWGb3UlRS80FYg2dkgZ).  
Copie o conteúdo desse patch para a pasta **Tools**, que está dentro da pasta onde o Warframe esta instalado.
3. Na Steam, em **propriedades do Warframe**, vá em **"Definir opções de inicialização"** e coloque:  
```
--firstrun
```
Use isso só na primeira vez que for rodar o jogo, depois pode remover para abrir o jogo normalmente.
4. Clique para abrir o jogo, se tudo ocorreu bem, irá abrir a janela de console e o jogo será compilado (esse processo vai demorar na primeira vez que você rodar o jogo).
5. Um bug conhecido é que precisa ter um controle conectado para rodar o jogo sem ele fechar, porém aparentemente já existe uma solução para isso, na página do autor do patch (mas eu ainda não testei).

Isso é tudo pessoal o/

Links que me ajudaram:  
[Autor do Patch](https://gitlab.com/GloriousEggroll/warframe-linux/issues/43)  
[Diolinux Tutorial](https://www.youtube.com/watch?v=Ciri6lgd6FA)