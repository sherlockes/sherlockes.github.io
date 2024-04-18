---
title: "De Youtube a Podcat V2"
date: "2024-04-18"
creation: "2024-04-18"
description: "Una modificación para crear un podcast de distintos canales de Youtube."
thumbnail: "images/20240418_youtube_to_podcast_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: true
weight: 5
---
Hace un tiempo cree un [script]({{<relref"20220916_youtube_to_podcast.md">}}) para crear un podcast a partir de un canal de Youtube. Ahora voy un paso más allá creándolo a partir de un conjunto de canales de Youtube.
<!--more-->
La estructura principal del script es la misma aunque he realizado una serie de modificaciones para leer un archivo de texto externo en el que están dispuestos los canales que me interesar seguir y a partir de los cuales crear un podcast. La carpeta en la que se alojan los archivos la he llamado "yt2pcst" y la estructura es la siguiente:

``` bash
yt2pcst
├── artwork.jpg
├── canales.txt
├── descargados.txt
├── feed.xml
├── items.xml
└── mp3
```
 - artwork.jpg es la imagen de portada del podcast
 - canales.txt es donde guardo los canales a seguir
 - descargados.txt es donde se guardarán los archivos ya descargados
 - feed.xml es el archivo rss que alimentará a la aplicación de podcast
 - items.xml contiene cada uno de los capítulos adecuadamente formateados
 - mp3 es la carpeta donde se guardan los archivos de audio
 
![image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[link]: https://www.google.es

[image-01]: /images/20240418_youtube_to_podcast_01.jpg



