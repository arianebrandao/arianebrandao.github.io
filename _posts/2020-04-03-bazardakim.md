---
title: "[Portfólio] Bazar da Kim"
layout: post
date: 2020-04-03 18:00
tag:
- projetos
- portfolio
image: https://arianebrandao.github.io/assets/images/posts/bazardakim/1.png
headerImage: true
projects: true
hidden: true # don't count this post in blog pagination
description: "Portfólio: Bazar da Kim"
category: project
author: arianebrandao
externalLink: false
comments: true
---

Olá!

Esse sistema eu fiz há um tempo. Desenvolvi usando PHP e MySQLi em suas últimas versões no backend e Bootstrap para o frontend, obedecendo os modelos e regras de negócios enviados pelo cliente.

O site é de um projeto bem bacana, o Bazar da Kim. Todo lucro e alimentos arrecadados no bazar foram doados para o Projeto Dorcas que ajuda famílias carentes em Almirante Tamandaré - PR.

O sistema conta com a página inicial dinâmica. Todas as informações nela podem ser gerenciadas pelo painel de gerenciamento.

Conta também com a parte de venda de ingressos, onde as pessoas se cadastram, preenchem os dados dos ingressos e fazem o pagamento - que é integrado com o PagSeguro. Nessa parte nós enfrentamos alguns problemas de compatibilidade da plataforma pagseguro com dispositivos móveis, felizmente algumas das medidas que eu tomei foram suficientes para resolver os contratempos.

No painel de controle é possível gerenciar os dados da página inicial, os ingressos, entre outras funções básicas. Ainda sobre os ingressos, é possível gerar uma lista com todos os ingressos para cada dia do evento, com seus devidos dados de autenticação e validações - para a entrada das pessoas no evento.


### O que eu fiz

* O sistema completo.

<div class="breaker"></div>

<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/1.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/1.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Página inicial</figcaption>
<div class="breaker"></div>


<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/2.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/2.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Página inicial</figcaption>
<div class="breaker"></div>


<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/3.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/3.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Página inicial - área dinâmica</figcaption>
<div class="breaker"></div>


<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/5.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/5.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Página inicial - área dinâmica</figcaption>
<div class="breaker"></div>


<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/6.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/6.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Página inicial - área dinâmica</figcaption>
<div class="breaker"></div>


<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/9.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/9.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Página inicial</figcaption>
<div class="breaker"></div>



A parte de compra de impressos é feita em 4 simples etapas, conforme mostradas nas prints do sistema abaixo.

<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/11.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/11.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Comprar ingressos - Etapa 1</figcaption>
<div class="breaker"></div>



Preenchendo o CPF na etapa 1, o sistema verifica se a pessoa já tem um cadastro no sistema. Se sim, os dados de cadastro são recuperados; caso contrário, a pessoa preenche os dados de cadastro na etapa 2.

<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/12.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/12.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Seus dados - Etapa 2</figcaption>
<div class="breaker"></div>



Preenche informações dos ingressos.

<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/13.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/13.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Dados dos ingressos - Etapa 3</figcaption>
<div class="breaker"></div>



A última etapa, onde são revisados os dados da compra. Ao clicar para fazer pagamento, é aberto o lightbox do PagSeguro para a finalização da compra.

<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/14.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/14.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Revisar dados - Etapa 4</figcaption>
<div class="breaker"></div>



O usuário pode consultar as compras realizadas e imprimir seus ingressos, inserindo o CPF.

<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/15.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/15.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Consultar compras</figcaption>
<div class="breaker"></div>


<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/17.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/17.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Visualizar os ingressos da compra para imprimir</figcaption>
<div class="breaker"></div>


<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/16.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/16.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">O ingresso gerado pelo sistema com todas as informações que o cliente precisa apresentar no dia do evento.</figcaption>
<div class="breaker"></div>



O painel de gerenciamento, inclui as funcionalidades básicas:

<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/19.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/19.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Painel de gerenciamento</figcaption>
<div class="breaker"></div>



É possível filtrar os ingressos, gerar o relatório e imprimir para poder consultar no dia do evento.

<p align="center"><img data-src="{{ site.url }}/assets/images/posts/bazardakim/18.jpg" class="lazyload" alt="Screenshot" /></p>
<noscript>
	<p align="center"><img src="{{ site.url }}/assets/images/posts/bazardakim/18.jpg" alt="Screenshot" /></p>
</noscript>
<figcaption class="caption">Filtrar ingressos</figcaption>
<div class="breaker"></div>


O site estava no ar durante o evento no endereço: <https://www.bazardakim.com>

Isso é tudo pessoal o/