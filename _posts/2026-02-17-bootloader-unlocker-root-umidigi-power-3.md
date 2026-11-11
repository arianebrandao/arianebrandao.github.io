---
title: "Como fazer root e bootloader unlocker no UMIDIGI Power 3"
layout: post
date: 2026-02-17 11:55
headerImage: false
tag:
  - umidigi
  - umidigi power 3
  - root
  - bootloader unlocker
  - android 10
category: blog
author: arianebrandao
description: Como fazer root e bootloader unlocker no UMIDIGI Power 3
---

## Como fazer root e bootloader unlocker no UMIDIGI Power 3

Meu celular antigo (UMIDIGI Power 3 com Android 10) estava parado e resolvi transformá-lo em um servidor de arquivos aqui para minha casa (tema para um próximo post). Para isso, precisei fazer o root no aparelho e desbloquear o bootloader. Vou registrar aqui os passos que segui para realizar os procedimentos, que podem servir de base para outros procedimentos em outros aparelhos. Também vou deixar os links que me ajudaram, no final do post.

### Pré-requisitos

Antes de começar, você precisará de:

1. Backup: Salve suas fotos, contatos e arquivos (você vai perder tudo).
2. Computador: Com os drivers USB do Google, SDK Plataform Tools (ADB e Fastboot) instalados.
3. Firmware Original: Você precisa baixar o arquivo boot.img e o vbmeta.img exatamente da mesma versão do sistema que está instalada no seu celular hoje (verifique em Configurações > Sobre o telefone > Número da versão).
4. Cabo USB: Preferencialmente o original.

### Faça o download dos arquivos que iremos usar

> Importante: Recomendo fazer o procedimento num computador com Windows, pois tentei com Linux e tive muitos problemas para reconhecer os drivers e o aparelho em si.

**Faça o download dentro de uma pasta de fácil acesso, no meu caso, ela vai se chamar `umidigi`**.

1. Driver USB do Google: <https://developer.android.com/studio/run/win-usb?hl=pt-br> - Faça o download do arquivo ZIP do driver USB do Google.
2. SDK Plataform Tools (o famoso ADB e Fastboot): <https://developer.android.com/tools/releases/platform-tools?hl=pt-br> - Faça o download do SDK Platform-Tools para Windows
3. Donwload do Firmware Original que está instalado no seu celular (verifique em Configurações > Sobre o telefone > Número da versão).
   - Para o UMIDIGI Power 3, eu não encontrei a versão exata do firmware que estava instalado no meu celular. Então eu atualizei a firmware para a versão mais recente disponível no fórum da UMIDIGI (<https://community.umidigi.com/forum.php?mod=viewthread&tid=19231&extra=page%3D1>).

   - Celulares UMIDIGI usam a ferramenta SP Flash Tool para instalação/atualização de firmware. Eu segui os tutoriais abaixo:
     <https://community.umidigi.com/forum.php?mod=viewthread&tid=16931>
     <https://www.youtube.com/watch?v=-QOYdIWJEVw>

4. Baixe o Magisk Manager APK: <https://github.com/topjohnwu/Magisk/releases>

Ao final, temos essa estrutura de pastas e arquivos:

```
📂umidigi
 ┣ 📦 usb_driver_r13-windows.zip          // Driver USB do Google
 ┣ 📦 platform-tools-latest-windows.zip   // SDK Plataform Tools
 ┣ 📦 UMIDIGI_Power_3_V1.2_20200328.rar   // Firmware Original
 ┗ 🤖 Magisk-v30.6.apk                   // Magisk Manager
```

### Organizar os arquivos no computador

Agora que já baixamos tudo que iremos utilizar, vamos organizar os arquivos no computador.

1. Extraia o arquivo `usb_driver_r13-windows.zip` (Driver USB do Google), entre na pasta e procure o arquivo `android_winusb`, clique com o botão direito->instalar. Uma vez instalado, pode deletar essa pasta.
2. Extraia todo o conteúdo do arquivo `UMIDIGI_Power_3_V1.2_20200328.rar` (Firmware Original) para uma pasta chamada `firmware`, dentro da pasta `umidigi`.
3. Extraia todo o conteúdo do arquivo `platform-tools-latest-windows.zip` (SDK Plataform Tools) para dentro da pasta `firmware`, criada anteriormente.

A estrutura de pastas e arquivos final essa, com os arquivos extraídos da firmware e plataforma tools juntos e misturados:

```
📂umidigi
 ┣ 📦 usb_driver_r13-windows.zip          // Driver USB do Google
 ┣ 📦 platform-tools-latest-windows.zip   // SDK Plataform Tools
 ┣ 📦 UMIDIGI_Power_3_V1.2_20200328.rar   // Firmware Original
 ┣ 📂 firmware                            // Pasta de firmware com os arquivos extraídos da firmware e plataforma tools juntos e misturados
 ┃ ┣ 📄 arquivos de firmware [...]
 ┃ ┗ 📄 arquivos de platform-tools [...]
 ┗ 🤖 Magisk-v30.6.apk                   // Magisk Manager
```

### Configurações do celular

1. Vá em Configurações > Sobre o dispositivo e toque 7 vezes em Número da versão até ativar as "Opções do desenvolvedor".
2. Em Sistema > Avançado > Opções do desenvolvedor, ative:
   - Desbloqueio de OEM (Crucial).
   - Depuração USB.
3. Conecte o celular ao computador via cabo USB, vai aparecer uma mensagem perguntando se deseja autorizar o computador a depurar o celular, deixe a caixa "Sempre permitir a partir deste computador" marcada e clique em "Permitir".

### Desbloquear o bootloader

1. Abra o prompt de comando como administrador (cmd).
2. Navegue até a pasta `firmware`. Use o comando `cd [caminho da pasta firmware]`.
3. Conecte o celular ao PC via cabo USB.
4. Digite o comando `adb devices` para verificar se o celular está conectado (deve aparecer em List of devices attached).
5. Digite o comando `adb reboot bootloader`. O celular vai reiniciar em uma tela preta com letras pequenas.
6. Em seguida, digite: `fastboot flashing unlock`. No celular, confirme a operação usando as teclas de volume (geralmente Volume Up para "Yes").

   > Essa etapa é muito importante, se ao digitar esse comando o terminal ficar com a mensagem "< waiting for any device >", o problema é quase certamente de **Driver**. O Windows reconhece o celular ligado normalmente (ADB), mas quando ele entra em modo Fastboot, o computador "esquece" quem ele é e não carrega o driver correto para esse estado. Se isso acontecer, verifique abaixo a solução.

   > **Solução - Forçar a Instalação do Driver:**
   1. No Windows, clique com o botão direito no menu Iniciar e abra o **Gerenciador de Dispositivos**.
   2. Procure por algo chamado "Android", "Umidigi" ou "Other Devices" com um triângulo amarelo de exclamação.
   3. Clique com o botão direito nele e selecione **Atualizar Driver**.
   4. Escolha **Procurar drivers no meu computador**.
   5. Clique em **Permitir que eu escolha em uma lista de drivers disponíveis em meu computador**.
   6. Procure por **Google USB** ou **Android Device** na lista.
   7. **IMPORTANTE:** Selecione o modelo chamado **Android Bootloader Interface**. Clique em "Sim" no aviso que aparecer.

7. Reinicie o celular com o comando `fastboot reboot` e configure-o novamente (pule as etapas básicas, pois você vai resetar de novo).

### Utilizando o Magisk para fazer o patch no boot.img

1. Com o celular ligado, conecte-o ao PC via cabo USB. Transfira o arquivo `umidigi/Magisk-v30.6.apk` e o arquivo `umidigi/firmware/boot.img` para a memória interna do celular.
2. No celular, instale o aplicativo Magisk.
3. Abra o Magisk no celular e toque em "Instalar".
4. Selecione a opção "Selecione e corrija um arquivo" e selecione o arquivo `boot.img` que você transferiu para a memória interna do celular.
5. O Magisk vai fazer o patch no arquivo `boot.img` e vai salvar o arquivo corrigido na memória interna do celular. O nome do arquivo será `magisk_patched_[random_string].img`.
6. Transfira o arquivo corrigido para o computador, dentro da pasta `firmware` e renomeie o arquivo para `magisk_patched.img`.

### Flashear o Root

1. Coloque o celular novamente em modo Fastboot com o comando `adb reboot bootloader`.
2. Para evitar erros de verificação no Android 10 (bootloop), você deve flashear o vbmeta desativando a verificação com o comando:

```
fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
```

> **Atenção:** Se o comando acima der o erro `fastboot: error: failed to find AVB_MAGIC at offset: 0`, tente apenas o comando sem flags: `fastboot flash vbmeta vbmeta.img`

3. Agora, instale o boot modificado:

```
fastboot flash boot magisk_patched.img
```

4. Reinicie o aparelho:

```
fastboot reboot
```

### Verificação Final

O Boot: O celular vai reiniciar normalmente. Não se assuste se ele demorar um pouquinho mais que o comum ou mostrar uma tela de aviso sobre o "bootloader unlocked" – isso é padrão em aparelhos com root.

Abra o Magisk: Assim que o sistema carregar, procure o aplicativo Magisk na sua gaveta de apps.

Configuração Adicional: Ao abrir o Magisk, ele provavelmente dirá: "Requer Instalação Adicional. Deseja prosseguir?".

Clique em OK.

O celular vai reiniciar sozinho em 5 segundos.

Após essa última reinicialização, abra o Magisk de novo. Se você vir a opção "Desinstalar Magisk" no final da tela e um número de versão em "Instalado", parabéns: você é oficialmente o Superusuário do seu Umidigi Power 3!

Links que me ajudaram:

<https://community.umidigi.com/forum.php?mod=viewthread&tid=17376>

<https://community.umidigi.com/forum.php?mod=viewthread&tid=19114&extra=&page=1>

<https://community.umidigi.com/forum.php?mod=viewthread&tid=2962&highlight=root>

<https://gemini.google.com/app?hl=pt-BR>

Isso é tudo pessoal o/
