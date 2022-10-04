---
title: "De Youtube a Podcast"
date: "2022-10-04"
creation: "2022-09-16"
description: "Aquí dejo mi método para pasar a formato podcast un anal de youtube"
thumbnail: "images/20220916_youtube_to_podcast_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: false
weight: 5
---
Si no tienes tiempo para ver los vídeos de un canal de [Youtube] pero te interesa el audio de los mismos para escucharlo en tu reproductor de Podcast, gracias a [yt-dlp] puedes hacerlo de una forma sencilla.
<!--more-->

Hace un tiempo escribí un [post] sobre el método que utilizo para pasar los vídeos de [Twitch] en formato audio a un servidor webdav alojado en mi Raspberry y que coge el contenido de una nube pública mediante [Rclone] al mismo tiempo que publica un feed para que mi reproductor de podcast sea capaz de coger de este servidor los audios. Ahora hago lo mismo pero a partir de un vídeo de Youtube.

Para descargar los vídeos de [Twitch] uso el servicio [twitch-dl], para hacer lo propio con [Youtube] utilizo [yt-dlp].

### Comprobar los últimos vídeos del canal
```bash
mapfile -t videos < <( yt-dlp --dateafter now-5day --get-filename -o "%(id)s/%(duration)s" $CANAL_YT )
```
Con esta línea se crea una matriz "vídeos" en la que, gracias a [yt-dlp] se introducen la identificación y duración de los vídeos que se han publicado en un canal de [Youtube] en los últimos cinco días. Utilizo la duración del mismo para no descargar los vídeos de menos de diez minutos.

### Descargar el audio de un vídeo
Conocida la identificación del vídeo que queremos descargar (id), para descargar el audio del mismo ejecutaremos los siguientes comandos.
```bash
url="https://www.youtube.com/watch?v=$id"
yt-dlp -o "%(id)s.%(ext)s" --extract-audio --audio-format mp3 $url
```

### Añadir los tag al audio
Al descargar el audio de [Youtube] no se le asigna automáticamente la información id3v2 correspondiente por lo que hay que hacerlo manualmente para que posteriormente en el reproductor de Podcast tanto el "Artista" como el "Podcast" aparezca correctamente identificado. Para esto obtengo el título del vídeo de [Youtube] gracias a la función de [yt-dlp] "--get-title"
e incrusto esta información en el "track" descargado a través del comando "id3v2". Todo gracias a dos sencillas líneas de código.

```bash
titulo=$(yt-dlp --get-title "https://www.youtube.com/watch?v=$nombre")
id3v2 -t "$titulo" -a "$artista" -A "$album" $track
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
Todo el código del script lo pueden encontrar en mi repositorio de scripts [GitHub]
{{< texto_remoto "https://raw.githubusercontent.com/sherlockes/SherloScripts/master/bash/youtube2podcast.sh" >}}

### Enlaces de interés
- [GitHub Diego Fleitas - yt-dlp commands](https://gist.github.com/DiegoFleitas/c940d4b94d6b92b55a7084afe84bf571)
- [StackOverFlow - Download new videos with youtube-dl](https://stackoverflow.com/questions/21356764/use-youtube-dl-to-download-new-videos-from-channel)
- [Unix Stack-Exchange - id3 tags](https://unix.stackexchange.com/questions/463875/scripting-id3-tags-with-id3v2-and-sed)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [Write - Download youtube channel with yt-dlp ](https://write.corbpie.com/downloading-a-youtube-channel-with-yt-dlp/)
- [Write - Download youtube video & playlist with yt-dlp](https://write.corbpie.com/downloading-youtube-videos-and-playlists-with-yt-dlp/)

[ffprobe]: https://ffmpeg.org/ffprobe.html
[GitHub]: https://github.com/sherlockes/SherloScripts
[Matthew Dickens]: http://matthewdickens.me/post/xml-template-for-a-podcast-rss-feed
[post]: {{<relref"20220317_bash_python_download_twitch.md">}}
[Rclone]: https://rclone.org
[Twitch]: https://www.twitch.tv
[twitch-dl]: https://twitch-dl.bezdomni.net/introduction.html
[webdav]: {{< relref "20211217_rclone_serve_webdav.md" >}}
[Youtube]: https://www.youtube.com
[yt-dlp]: https://github.com/yt-dlp/yt-dlp

[image-01]: /images/20220916_youtube_to_podcast_01.jpg



