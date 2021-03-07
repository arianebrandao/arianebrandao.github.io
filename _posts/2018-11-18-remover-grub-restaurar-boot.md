---
title: "Como remover o GRUB e restaurar o boot do Windows"
layout: post
date: 2018-11-18 11:42
headerImage: false
tag:
- linux
- boot
- windows
- grub
category: blog
author: arianebrandao
description: Como remover o GRUB e restaurar o boot do Windows

---

### O que é GRUB
GRUB é um gerenciador de boot. Ele permite que o usuário escolha um dos sistemas operacionais instalados ao ligar seu computador. Ou seja, o GRUB é capaz de trabalhar com "multiboot".


### Como remover o GRUB e restaurar o boot do Windows
Eu usava o GRUB para multiboot com o Windows 10 e Linux Mint 19, mas ao remover a partição do Linux, me deparei com um problema: o GRUB não é removido junto com o Linux, ficando preso no boot com o modo de recuperação dele, o famoso **grub rescue**. Então vamos à solução para reparar o boot do Windows:  


#### Windows XP
Dar boot com o CD de instalação do Windows, dentro do sistema de instalação, entrar em **console de recuperação** e digitar o comando:  
```
fixmbr
```

#### Windows Vista
Dar boot com o CD de instalação do Windows, dentro do sistema de instalação, seleciona o **sistema de reparação** e digitar o comando:  
```
bootrec /fixmbr
```

#### Windows 7
Dar boot com o CD de instalação do Windows, dentro do sistema de instalação, seleciona **reparar sistema**, depois entre no **prompt de comando** e digite:  
```
bootsect /nt60 ALL /force /mbr
```

#### Windows 10
Dar boot com o CD de instalação do Windows <u>(pode ser com o cd do Windows 7)</u>, dentro do sistema de instalação, seleciona **reparar sistema**, depois entre no **prompt de comando** e digite:  
```
bootrec /fixmbr
```


Link que me ajudou: <http://meupinguim.com/como-remover-grub-restaurar-boot-windows/>

Isso é tudo pessoal o/