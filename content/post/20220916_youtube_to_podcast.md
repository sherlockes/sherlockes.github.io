---
title: "De Youtube a Podcast"
date: "2022-09-16"
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
draft: true
weight: 5
---
Si no tienes tiempo para ver los vídeos de un canal de [Youtube] pero te interesa el audio de los mismos para escucharlo en tu reproductor de Podcast, gracias a [yt-dlp] puedes hacerlo de una forma sencilla.
<!--more-->

Hace un tiempo escribí un [post] sobre el método que utilizo para pasar los vídeos de [Twitch] en formato audio a un servidor webdav alojado en mi Raspberry y que coje el contenido de una nube pública mediante [Rclone] al mismo tiempo que publica un feed para qeu mi reproductor de podcast sea capaz de coger de este servidor los audios. Ahora hago lo mismo pero a partir de un vídeo de Youtube.

Para descargar los vídeos de [Twitch] uso el servicio [twitch-dl], para hacer lo propio con [Youtube] utilizo [yt-dlp]

{{< texto_remoto "https://raw.githubusercontent.com/sherlockes/SherloScripts/master/bash/youtube2podcast.sh" >}}

![image-01]

### Enlaces de interés
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)

[post]: {{<relref"20220317_bash_python_download_twitch.md">}}
[Rclone]: https://rclone.org
[Twitch]: https://www.twitch.tv
[twitch-dl]: https://twitch-dl.bezdomni.net/introduction.html
[Youtube]: https://www.youtube.com
[yt-dlp]: https://github.com/yt-dlp/yt-dlp

[image-01]: /images/20220916_youtube_to_podcast_01.jpg



