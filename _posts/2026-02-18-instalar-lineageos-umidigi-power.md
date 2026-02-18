---
title: "Como instalar o LineageOS no UMIDIGI Power 3"
layout: post
date: 2026-02-18 10:48
headerImage: false
tag:
- umidigi
- umidigi power 3
- lineageos
category: blog
author: arianebrandao
description: Como instalar o LineageOS no UMIDIGI Power 3

---

## Como instalar o LineageOS no UMIDIGI Power 3

Meu celular antigo (UMIDIGI Power 3 com Android 10) estava parado e resolvi transformá-lo em um servidor de arquivos aqui para minha casa (tema para um próximo post). Para isso, precisei fazer o [root no aparelho e desbloquear o bootloader](https://arianebrandao.github.io/bootloader-unlocker-root-umidigi-power-3/). O segundo passo foi instalar o **LineageOS**, pois é muito mais leve e otimizado que a ROM stock do meu celular. Vou registrar aqui os passos que segui para realizar os procedimentos, que podem servir de base para outros procedimentos em outros aparelhos.

Não encontrei uma versão "oficial" do LineageOS feita especificamente para o meu modelo. Mas, como o aparelho saiu com Android 10, ele suporta GSI (Generic System Image). Isso significa que é possível instalar uma versão genérica do LineageOS que funciona em qualquer aparelho com "Project Treble".

### Pré-requisitos

Antes de começar, você precisará de:
1. Backup: Salve suas fotos, contatos e arquivos (você vai perder tudo).
2. Computador: Com os drivers USB do Google, SDK Plataform Tools (ADB e Fastboot) instalados.
3. Imagem do LineageOS compatível com seu dispositivo.
4. Cabo USB: Preferencialmente o original.

### A imagem do LineageOS

Para baixar o LineageOS correto, você precisa saber qual tipo de imagem o seu celular aceita. Para isso:

1. Baixe  e instale o app Treble Check (Informações sobre o Treble, em português) no celular.
2. Abra o aplicativo e verifique se ele mostra a mensagem "Generic System Image found!". Isso quer dizer que ele é compatível com GSI (Generic System Image).
    > Logo abaixo dessa mensagem, vai ter algo parecido com "The type of image required is: **system-arm64-ab.img.xz**".
3. Clique no botão "Pesquisar imagens" e escolha a imagem e versão de android que você deseja instalar. No meu caso, eu escolhi a versão mais recente do **LineageOS 21 (Android 14)**.
4. Na página de download da imagem, geralmente no site **SourceForge**, procure pelo arquivo que corresponde ao tipo de imagem que o seu celular aceita. No meu caso, baixei a imagem **"lineage-21.0-20250621-UNOFFICIAL-arm64_bvN.img.gz"** [desse projeto](https://sourceforge.net/projects/andyyan-gsi/).

### Faça o download do restante dos arquivos que iremos usar

> Importante: Recomendo fazer o procedimento num computador com Windows, pois tentei com Linux e tive muitos problemas para reconhecer os drivers e o aparelho em si.

**Faça o download dentro de uma pasta de fácil acesso, no meu caso, ela vai se chamar `umidigi`**.

1. Driver USB do Google: <https://developer.android.com/studio/run/win-usb?hl=pt-br> - Faça o download do arquivo ZIP do driver USB do Google.
2. SDK Plataform Tools (o famoso ADB e Fastboot): <https://developer.android.com/tools/releases/platform-tools?hl=pt-br> - Faça o download do SDK Platform-Tools para Windows

Ao final, temos essa estrutura de pastas e arquivos:
```
📂umidigi
 ┣ 📦 usb_driver_r13-windows.zip          // Driver USB do Google
 ┣ 📦 platform-tools-latest-windows.zip   // SDK Plataform Tools
 ┗ 📦 lineage-21.0-20250621-UNOFFICIAL-arm64_bvN.img.gz    // Imagem do LineageOS
```

### Organizar os arquivos no computador

Agora que já baixamos tudo que iremos utilizar, vamos organizar os arquivos no computador.

1. Extraia o arquivo `usb_driver_r13-windows.zip` (Driver USB do Google), entre na pasta e procure o arquivo `android_winusb`, clique com o botão direito->instalar. Uma vez instalado, pode deletar essa pasta.
2. Extraia o arquivo `lineage-21.0-20250621-UNOFFICIAL-arm64_bvN.img.gz` (Imagem do LineageOS) para uma pasta chamada `firmware`, dentro da pasta `umidigi`.
3. Extraia todo o conteúdo do arquivo `platform-tools-latest-windows.zip` (SDK Plataform Tools) para dentro da pasta `firmware`, criada anteriormente.

A estrutura de pastas e arquivos final essa, com o arquivo extraído da firmware e plataforma tools juntos e misturados:
```
📂umidigi
 ┣ 📦 usb_driver_r13-windows.zip          // Driver USB do Google
 ┣ 📦 platform-tools-latest-windows.zip   // SDK Plataform Tools
 ┣ 📦 lineage-21.0-20250621-UNOFFICIAL-arm64_bvN.img.gz   // Imagem do LineageOS
 ┗ 📂 firmware                            // Pasta de firmware com os arquivos extraídos do LineageOS e plataforma tools juntos e misturados
   ┣ 📄 lineage-21.0-20250621-UNOFFICIAL-arm64_bvN.img    // Imagem do LineageOS extraída
   ┗ 📄 arquivos de platform-tools [...]
```

### Configurações do celular (se você já tem o root, pode pular essa parte)

1. Vá em Configurações > Sobre o dispositivo e toque 7 vezes em Número da versão até ativar as "Opções do desenvolvedor".
2. Em Sistema > Avançado > Opções do desenvolvedor, ative:
    - Desbloqueio de OEM (Crucial).
    - Depuração USB.
3. Conecte o celular ao computador via cabo USB, vai aparecer uma mensagem perguntando se deseja autorizar o computador a depurar o celular, deixe a caixa "Sempre permitir a partir deste computador" marcada e clique em "Permitir".

### Entrar no modo Fastbootd (Diferente do Fastboot comum)

No Android 10, para mexer na partição de sistema, você precisa entrar no Fastbootd (um modo visual com menus).

1. Abra o prompt de comando como administrador (cmd).
2. Navegue até a pasta `firmware`. Use o comando `cd [caminho da pasta firmware]`.
3. Conecte o celular ao PC via cabo USB.
4. Digite o comando `adb devices` para verificar se o celular está conectado (deve aparecer em List of devices attached).
5. Digite o comando `adb reboot fastboot`. O celular vai reiniciar em uma tela que diz "Fastbootd" no topo (geralmente tem um menu azul/roxo).

### Instalar o LineageOS

Na tela do Fastbootd, digite os seguintes comandos:

1. Limpar o sistema atual:
    ```
    fastboot erase system
    ```
2. Instalar o LineageOS:
    ```
    fastboot flash system lineage-21.0-20250621-UNOFFICIAL-arm64_bvN.img
    ```
    > Se der erro de espaço insuficiente, você pode precisar deletar a partição de "product" (veja abaixo), mas tente o flash direto primeiro.
3. Format Data (Obrigatório):
    ```
    fastboot -w
    ```
4. Reiniciar:
    ```
    fastboot reboot
    ```
    > O primeiro boot do LineageOS pode demorar até 5 ou 10 minutos.

Se der erro **"FAILED (remote: 'Not enough space to resize partition')"**, use os comandos abaixo:
```
fastboot delete-logical-partition product
fastboot delete-logical-partition system
fastboot create-logical-partition system 0
```
E tente instalar o LineageOS novamente a partir do passo 2, se o erro persistir, procure uma imagem do LineageOS mais leve que seja compatível com o modelo do seu celular.

### Verificação Final

O Boot: O primeiro boot do LineageOS pode demorar cerca de 10 minutos. Não se assuste se ele demorar um pouquinho mais que o comum ou mostrar uma tela de aviso sobre o "bootloader unlocked" – isso é padrão em aparelhos com root.

Abra o Magisk: Assim que o sistema carregar, procure o aplicativo Magisk na sua gaveta de apps.

Configuração Adicional: Ao abrir o Magisk, ele provavelmente dirá: "Requer Instalação Adicional. Deseja prosseguir?".

Clique em OK.

O celular vai reiniciar sozinho em 5 segundos.

Após essa última reinicialização, abra o Magisk de novo. Se você vir a opção "Desinstalar Magisk" no final da tela e um número de versão em "Instalado", parabéns: você é oficialmente o Superusuário do seu Umidigi Power 3 com LineageOS instalado!

Isso é tudo pessoal o/