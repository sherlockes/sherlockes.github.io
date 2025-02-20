---
title: "Crear un contenedor de youtube2podcast"
date: "2025-02-20"
creation: "2025-02-20"
description: "Como he creado un sencillo contenedor a partir del script yt2pcst.sh"
thumbnail: "images/20250220_youtube_to_podcast_docker_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
- "docker"
draft: true
weight: 5
---
Hace tiempo que uso un sencillo script en bash para crear un podcast a partir del audio de unos cuantos canales de Youtube. Ahora lo vamos a meter en un contenedor para que sea más fácil de migrar.
<!--more-->
Este es el [script_original] que descarga los vídeos de Youtube, cambia el formato a solo audio, los sube a un servidor mediante rclone y genera un feed para que puedan ser consumidos en formato podcast. Uso una núbe pública para subir los audios y una pequeña Raspberry Pi 3 se encarga de servir el contenido mediante webdav gracias a rclone.



![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[script_original]: https://github.com/sherlockes/SherloScripts/blob/master/bash/yt2pcst.sh

[image-01]: /images/20250220_youtube_to_podcast_docker_01.jpg



