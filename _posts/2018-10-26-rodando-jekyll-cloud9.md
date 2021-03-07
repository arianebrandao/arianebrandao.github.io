---
title: "Rodando Jekyll no Cloud9"
layout: post
date: 2018-10-26 18:16
headerImage: false
tag:
- jekyll
- cloud9
category: blog
author: arianebrandao
description: Rodando uma aplicação Jekyll no Cloud9

---

### Como rodar o Jekyll no Cloud9
O primeiro passo é criar um workspace no Cloud9 com o template **"Blank"**, esse template é uma instalação básica do Ubuntu com algumas dependências pré-instaladas (incluindo o Ruby gem).  

Para instalar o Jekyll:  
```
$ gem install jekyll bundler
```  

Criar a estrutura do Jekyll para o seu site:  
```
$ jekyll new nome-do-site
$ cd nome-do-site
```  

Pronto! Para rodar, basta colocar o servidor e porta corretamente (no Cloud9 se usam as variáveis $IP e $PORT):  
```
$ jekyll serve --host $IP --port $PORT --baseurl ''
```  

Todos os comandos usados:  
```
$ gem install jekyll bundler
$ jekyll new nome-do-site
$ cd nome-do-site
$ jekyll serve --host $IP --port $PORT --baseurl ''
```  

Link para baixar as gems manualmente se for necessário: <https://rubygems.org/gems/>

Isso é tudo pessoal o/