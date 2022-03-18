---
title: "Crear Podcast a partir de un canal de Twitch"
date: "2022-03-18"
creation: "2022-03-17"
description: "Una orma sencilla de crear de forma automática un podcast a partir de un canal de Twitch"
thumbnail: "images/20220317_python_download_twitch_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
- "python"
draft: true
weight: 5
---
No tengo tiempo para ver los canales de Twitch que me gustaría seguir y tras unos días probando una aplicación Android para descargar los vídeos me he decidido a crear un podcast privado que se genere de forma automática a partir del contenido de un canal en Twitch.
<!--more-->
### Buscar nuevos vídeos publicados
Una vez más, gracias a [Angel] he descubierto [twitch-dl], una aplicación en python con la que listar y descargar los vídeos de cualquier canal de Twitch.

``` bash
CANAL="jordillatzer"
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
twdl=$script_dir/twitch-dl.pyz

json=$(python3 $twdl videos $CANAL -j)
```
### Descargar los vídeos nuevos
### Convertir los vídeos descargados a mp3
### Subir el audio generado a un servidor WebDav
### Generar el feed con todos los audios
sudo apt install jq

![image-01]

### Enlaces de interés
- [jq](https://stedolan.github.io/jq/download/)
- [ByteFreaks - Remove last character](https://bytefreaks.net/gnulinux/bash/bash-remove-the-last-character-from-each-line)

[Angel]: https://ugeek.github.io/blog/post/2022-03-15-twitch-dl-aplicacion-cli-para-descargar-videos-de-twitch-tv.html
[twitch-dl]: https://twitch-dl.bezdomni.net/introduction.html


[image-01]: /images/20220317_python_download_twitch_01.jpg
[image-02]: /images/20220317_python_download_twitch_02.jpg
[image-03]: /images/20220317_python_download_twitch_03.jpg
[image-04]: /images/20220317_python_download_twitch_04.jpg
[image-05]: /images/20220317_python_download_twitch_05.jpg
[image-06]: /images/20220317_python_download_twitch_06.jpg
[image-07]: /images/20220317_python_download_twitch_07.jpg
[image-08]: /images/20220317_python_download_twitch_08.jpg
[image-09]: /images/20220317_python_download_twitch_09.jpg
