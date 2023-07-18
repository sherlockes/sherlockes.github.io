---
title: "Raspberry Pi desde cero"
#date: "2018-7-11"
update: "2021-04-28"
description: "Un resumen de lo que está siendo mi aprendizaje en el mundo de las Raspberry Pi"
thumbnail: "images/20180626_raspberry_raspberry_desde_cero_00.png"
disable_comments: true
authorbox: true
toc: true
mathjax: false
categories:
  - "Raspberry"
tags:
  - "desarrollo"
menu: main # Optional, add page to a menu. Options: main, side, footer
draft: false
---
Lo mas importante antes de adquirir una Raspberry es tener un proyecto para ella (y si es posible que no sea muy complicado) para de esta forma fijarnos un objetivo y por el camino poder aprender infinidad de cosas.

En mi caso comencé usándola como servidor web para este Blog, aunque en la actualidad su principal función es como servidor de [Home Assistant], hace muchas más cosas como sincronizar mis nubes públicas, actualizar mis repositorios en git, servidor webdav para mi contenido multimedia online, actualización de mi base de datos de radares para el teléfono, entorno de desarrollo en [Hugo]...

La configuración que actualmente tengo funcionando es una [Raspberry Pi 4] de 4Gb montada dentro de una caja [Argon One] y el sistema operativo es [Raspberry Pi OS Lite] de 32 bits corriendo dentro de un stick usb [Sandisk Ultra Fit] de 32Gb.

### Primeros días
- [Montaje y ssh]({{<relref"20180401_raspberry_montaje_ssh.md">}})
- [Configurar red y wifi]({{<relref"20180401_raspberry_configurar_red_wifi.md">}})
- [Copia de seguridad]({{<relref"20180401_raspberry_copia_seguridad.md">}})
- [Acceder desde el exterior]({{<relref"20180401_raspberry_acceso_exterior.md">}})
- [Clonar disco de arranque]({{<relref"20211225_raspberry_clonar_disco.md">}})
- [Script de configuración]({{<relref"20181106_raspberry_config_script.md">}})

### Post en el Blog

[Argon One]: https://www.argon40.com/argon-one-v-2-case-for-raspberry-pi-5.html
[Home Assistant]: https://www.home-assistant.io
[Hugo]: https://gohugo.io
[Raspberry Pi 4]: https://www.raspberrypi.com/products/raspberry-pi-4-model-b/
[Raspberry Pi OS Lite]: https://downloads.raspberrypi.org/raspios_lite_armhf/release_notes.txt
[Sandisk Ultra Fit]: https://www.westerndigital.com/products/usb-flash-drives/sandisk-ultra-fit-usb-3-1#SDCZ430-016G-G46
