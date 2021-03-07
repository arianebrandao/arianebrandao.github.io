---
title: "Linux - configurando a Steam Play"
layout: post
date: 2018-10-25 15:30
headerImage: false
tag:
- linux
- games
- steam
category: blog
author: arianebrandao
description: Linux - configurando a Steam Play para rodar jogos nativamente

---

### Sobre a Steam Play para Linux

A grande novidade na Steam (ainda em beta) é a inclusão de uma versão modificada do [Wine](http://www.winehq.org), chamada **Proton**, com isso a ferramenta passa a oferecer compatibilidade para os jogos do Windows.
Algumas das melhorias:

* Jogos do Windows que atualmente não têm versão para Linux poderão agora ser completamente instalados e iniciados diretamente dos clientes Steam para Linux com Steamworks nativo e suporte ao OpenVR.
* As implementações do DirectX 11 e 12 agora são baseadas em Vulkan, resultando em um jogo com melhor compatibilidade e menor impacto de desempenho.
* O suporte à tela cheia também foi aperfeiçoado: jogos em tela cheia serão expandidos para a exibição desejada sem interferir com a resolução da tela nativa ou exigindo o uso de uma área de trabalho virtual.
* Suporte a controle de jogos melhorado: os jogos irão reconhecer todos os controles compatíveis com o Steam. Espere uma compatibilidade de controle mais inovadora do que a da versão original do jogo.
* O desempenho de jogos multi-segmentados também foi aprimorado ao compará-lo com a versão básica do Wine.


### Passos para usar a Steam Play

Primeiramente é necessário usar a versão beta da Steam, para fazer isso vá no **menu Steam > Configurações > Steam Play** e ative as opções **"Enable Steam Play for supported titles" e "Enable Steam Play for all titles", em  "Compatibillity tool" selecione a versão beta mais atual** disponível (Proton 3.16-3 Beta até o momento).

<p align="center"><img data-src="{{ site.url }}/assets/images/posts/linux-steam-play/1.png" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/linux-steam-play/1.png" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Configurando Steam Play para Linux</figcaption>
<div class="breaker"></div>

Após isso, tenha certeza que seus **drivers estejam atualizados**. Para quem usa placa de vídeo Nvidia, precisa ter instalado o driver 396.54 ou superior (no meu caso o 396 deu erro, só funcionou com a versão 410.66). [Veja um post anterior onde mostro como atualizar o driver Nvidia sem erros](https://arianebrandao.github.io/linux-atualizar-driver-nvidia/).

Isso é tudo pessoal o/

Links úteis:  
[Steam Play](https://steamcommunity.com/games/221410/announcements/detail/1696055855739350561)  
[Proton](https://github.com/ValveSoftware/Proton/wiki/Requirements)