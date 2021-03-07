---
title: "Linux - atualizar driver Nvidia para a versão 396+"
layout: post
date: 2018-10-25 12:53
headerImage: false
tag:
- linux
category: blog
author: arianebrandao
description: Linux - como atualizar o driver Nvidia para a versão 396+

---

### Como atualizar o driver Nvidia para a versão 396+

Testado no Linux Mint 19 Tara.

Abrir o terminal (Ctrl + Alt + t), comandos:

```
sudo apt install libnvidia-cfg1-396
sudo apt install libnvidia-gl-396
sudo apt install nvidia-dkms-396
sudo apt install nvidia-driver-396
sudo apt install nvidia-utils-396
sudo apt install xserver-xorg-video-nvidia-396
```  

**É preciso reiniciar o pc após esse processo.**

Isso é tudo pessoal o/

Referência: [post no reddit](https://www.reddit.com/r/linux_gaming/comments/92it23/nvidia_396_on_ubuntu_1604_and_1804/)
