---
title: "Servidor Webdav de contenido remoto con Rclone"
date: "2022-01-26"
creation: "2021-12-17"
description: "Como usar Rclone para servir contenido remoto mediante protocolo WebDav"
thumbnail: "/images/20211217_rclone_serve_webdav_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "computing"
tags:
  - "rclone"
draft: false
weight: 5
---
Utilizo este servidor WebDav para reproducir el contenido multimedia que tengo perfectamente guardado y encriptado en alguna de mis nubes públicas en el FireTV mediante Kodi. Si este uso no te convence quizás encuentres otro que se adapte más a tus necesidades.
<!--more-->

Partimos de tener [Rclone] instalado en nuestro sistema y al menos una unidad remota configurada cuyo nombre es "Unidad_rclone" para ejecutar el siguiente comando donde deberemos modificar la IP por la máquina en la que esté corriendo [Rclone] y aisgnar el puerto que deseemos.

``` Bash
rclone serve webdav Unidad_rclone: --addr 192.168.10.202:5005 --read-only
```

Apartir de aquí, si accedemos mediante el navegador a la IP y puerto del servidor podremos ver algo como lo siguiente sin necesidad de nombre de usuari ni contraseña puesto que sólo va a ser de consumo local (O a través de la vpn)

![image-01]

> En mi caso tengo el servidor corriendo desde que arranca la Raspberry mediante una tarea en el cron.

[Rclone]: https://rclone.org

[image-01]: /images/20211217_rclone_serve_webdav_01.jpg
