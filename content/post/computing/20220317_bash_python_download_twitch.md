---
title: "Crear Podcast a partir de un canal de Twitch"
date: "2022-03-23"
creation: "2022-03-17"
description: "Una forma sencilla de crear de forma automática un podcast a partir de un canal de Twitch"
thumbnail: "images/20220317_python_download_twitch_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "computing"
tags:
- "bash"
- "python"
draft: false
weight: 5
---
No tengo tiempo para ver los canales de Twitch que me gustaría seguir en el momento de la emisión y tras unos días probando una aplicación Android para descargar los vídeos me he decidido a crear un podcast privado que se genere de forma automática a partir del contenido de un canal en Twitch.
<!--more-->
### Buscar nuevos vídeos publicados
Una vez más, gracias a [Angel] he descubierto [twitch-dl], una aplicación en python con la que listar y descargar los vídeos de cualquier canal de Twitch. Para listarlos en formato "json" es tan sencillo como ejecutar el siguiente comando desde el directorio donde tengamos descargado "twitch-dl".

``` bash
python3 twitch-dl.pyz videos jordillatzer -j
```
### Descargar los vídeos nuevos
Ya tenemos un precioso "json" del que extraer las "id" de los últimos vídeos publicados. En mi script he utilizado [jq] para extraer la id de los últimos vídeos y compruebo si ya lo he descargado anteriormente con las "id's" que tengo guardadas en el archivo "descargados.txt". Para descargar el audio del vídeo es tan sencillo como lo siguiente.

``` bash
twitch-dl.pyz download -q audio_only 221837124
```
### Convertir los vídeos descargados a mp3
Pero el archivo que se descarga es muy grande para ser un audio y está en formato "mkv" por lo que lo proceso con FFMPEG y elimino los silencios pasándolo al mismo tiempo de mkv a mp3.

``` bash
ffmpeg -loglevel 24 -i "$file" -af silenceremove=1:0:-50dB "${file%.mkv}.mp3"
```

### Subir el audio generado a un servidor WebDav
Ya he escrito en un post como tengo implementado un servidor [webdav] gracias a [Rclone] usando como almacenamiento mis nubes públicas. Uso el mismo [Rclone] en este script para subir el contenido descargado y recodificado en local.

``` bash
rclone copy $canal remoto:twitch/$canal/ --create-empty-src-dirs
```

### Generar el feed con todos los archivos
Como plantilla para la generación del feed he utilizado esta de [Matthew Dickens] eliminando de la misma todo lo relativo a itunes ya que va a ser de uso privado. Guardo por un lado el encabezado del xml y por otro los archivos ya incluidos junto con el pie, así me resulta fácil poner como primer "item" del feed un nuevo audio que descargue. Hago uso de [ffprobe] para extraer los metadatos del mp3 que incrustar en el feed y el comando `awk` para extraer la información del nombre del archivo.

Tras poner el feed en el servidor webdav donde he colocado los archivos de audio ya sólo resta añadirlo y actualizarlo en la aplicación de Podcast.


### Script completo
A continuación dejo el código completo de script, si quieres descargarlo o copiarlo te recomiendo que pases por mi [Repositorio de scripts] y lo [descargues](https://github.com/sherlockes/SherloScripts/blob/master/bash/twitch2podcast.sh)  ya que Hugo no lleva bien la importación de texto externo de momento.

{{< texto_remoto "https://raw.githubusercontent.com/sherlockes/SherloScripts/master/bash/twitch2podcast.sh" >}}

### Enlaces de interés
- [DelftStack - Parse JSON in Bash](https://www.delftstack.com/howto/linux/parse-json-in-bash/)
- [FFMPEG](https://ffmpeg.org/ffmpeg.html)
- [ByteFreaks - Remove last character](https://bytefreaks.net/gnulinux/bash/bash-remove-the-last-character-from-each-line)

[Angel]: https://ugeek.github.io/blog/post/2022-03-15-twitch-dl-aplicacion-cli-para-descargar-videos-de-twitch-tv.html
[awk]: https://ss64.com/bash/awk.html
[ffprobe]: https://ffmpeg.org/ffprobe.html
[jq]: https://stedolan.github.io/jq/
[Matthew Dickens]: http://matthewdickens.me/post/xml-template-for-a-podcast-rss-feed
[Rclone]: https://rclone.org
[Repositorio de scripts]: https://github.com/sherlockes/SherloScripts
[twitch-dl]: https://twitch-dl.bezdomni.net/introduction.html
[webdav]: {{< relref "20211217_rclone_serve_webdav.md" >}}

[image-01]: /images/20220317_python_download_twitch_01.jpg
[image-02]: /images/20220317_python_download_twitch_02.jpg
[image-03]: /images/20220317_python_download_twitch_03.jpg
[image-04]: /images/20220317_python_download_twitch_04.jpg
[image-05]: /images/20220317_python_download_twitch_05.jpg
[image-06]: /images/20220317_python_download_twitch_06.jpg
[image-07]: /images/20220317_python_download_twitch_07.jpg
[image-08]: /images/20220317_python_download_twitch_08.jpg
[image-09]: /images/20220317_python_download_twitch_09.jpg
