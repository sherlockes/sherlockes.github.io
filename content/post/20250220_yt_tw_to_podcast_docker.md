---
title: "Youtube y Twitch a Podcast en Docker"
date: "2026-01-21"
creation: "2025-02-20"
description: "Como he creado un sencillo contenedor a partir del script yt2pcst.sh"
thumbnail: "images/20250220_yt_tw_to_podcast_docker_00.jpg"
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
Hace tiempo que uso unos sencillos scripts en bash para crear un podcast a partir del audio de unos cuantos canales de [Youtube] y [Twitch]. Ahora lo vamos a meter en un contenedor para que sea más fácil de migrar a otra máquina.
<!--more-->
Para [Youtube] uso [yt2pcst] y para [Twitch] hago lo mismo con [tw2pcst]. Básicamente la función de ambos es descargar vídeos del correspondiente servicio de streaming, convertirlos a audios, subirlos a un servidor y generar un feed para tratarlos como si de un podcast se tratase. La diferencia entre ambos es que para el caso de [Youtube] se descargan vídeos de varios canales mientras que para [Twitch] de sólo uno.

> Se que debería dar una vuelta a ambos archivos y unirlos en uno. Para cuando tenga un rato libre...

Pero de esto ya he hablado en otros artículos así que ahora nos vamos a centrar en como unir ambos scripts en un contenedor docker que corra en nuestro servidor.

### Estructura del proyecto
Vamos a meter todos los archivos dentro de la carpeta "Sherlocast" y el árbol quedará como aparece a continuación.

``` bash
├── config
    └── rclone.conf
├── data
    ├── twitch
        ├── jordillatzer
            ├── artwork.jpg
            ├── descargados.txt
            ├── feed.xml
            ├── items.xml
            └── mp3
    └── yt2pcst
        ├── artwork.jpg
        ├── canales.txt
        ├── descargados.txt
        ├── feed.xml
        ├── items.xml
        └── mp3
├── docker-compose.yml
├── Dockerfile
├── .env
├── scripts
    ├── start.sh
    ├── telegram_V2.sh
    ├── tw2pcst.sh
    └── yt2pcst.sh
└── start_sherlocast.sh
```

### Dockerfile
Es la base de nuestro contenedor, selecciona la distribución base a utilizar, instala dependencias, crea directorios necesarios y lanza la aplicación de inicio.

``` bash
# Usar una imagen base de Ubuntu
FROM ubuntu:22.04

# Evitar interacciones durante la instalación
ENV DEBIAN_FRONTEND=noninteractive
# Deshabilitar backups de rclone
ENV RCLONE_BACKUP_DIR=""

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    jq \
    unzip \
    ffmpeg \
    id3v2 \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Instalar yt-dlp
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Instalar pipx y twitch-dl
RUN python3 -m pip install --user pipx && \
    python3 -m pipx ensurepath && \
    /root/.local/bin/pipx install twitch-dl && \
    ln -s /root/.local/bin/twitch-dl /usr/local/bin/twitch-dl

# Verificar la instalación
RUN which twitch-dl && \
    twitch-dl --version

# Instalar rclone
RUN curl https://rclone.org/install.sh | bash

# Crear directorios necesarios
WORKDIR /app
RUN mkdir -p /app/config /app/scripts /app/data /app/logs

# Ejecutar el script directamente
CMD ["/bin/bash", "/app/scripts/start.sh"]
```

### start.sh
Es el archivo al que llama el Dockerfile tras ser montado. Su misión es descargar los scripts de mi repositorio de Github copiarlos al volumen del contenedor y lanzarlos. Con esto realizar modificaciones en los scripts no implica tener que actualizar el contenedor y resulta muy útil en la fase de desarrollo.

``` bash
#!/bin/bash

# Definir la URL del script y la ruta de destino
SCRIPT_YT_URL="https://raw.githubusercontent.com/sherlockes/SherloScripts/refs/heads/master/bash/yt2pcst.sh"
SCRIPT_YT_PATH="/app/scripts/yt2pcst.sh"
SCRIPT_TW_URL="https://raw.githubusercontent.com/sherlockes/SherloScripts/refs/heads/master/bash/tw2pcst.sh"
SCRIPT_TW_PATH="/app/scripts/tw2pcst.sh"

# Crear la carpeta si no existe
mkdir -p "$(dirname "$SCRIPT_YT_PATH")"

# Descargar el script actualizado para youtube
curl -fsSL "$SCRIPT_YT_URL" -o "$SCRIPT_YT_PATH" || { echo "Error al descargar el script."; exit 1; }

# Dar permisos de ejecución
chmod +x "$SCRIPT_YT_PATH"

# Ejecutar el script principal de youtube
"$SCRIPT_YT_PATH"

# Descargar el script actualizado para twitch
curl -fsSL "$SCRIPT_TW_URL" -o "$SCRIPT_TW_PATH" || { echo "Error al descargar el script."; exit 1; }

# Dar permisos de ejecución
chmod +x "$SCRIPT_TW_PATH"

# Ejecutar el script principal de twitch
"$SCRIPT_TW_PATH"
```


![image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[Twitch]: https://www.twitch.tv
[yt2pcst]: https://github.com/sherlockes/SherloScripts/blob/master/bash/yt2pcst.sh
[tw2pcst]: https://github.com/sherlockes/SherloScripts/blob/master/bash/tw2pcst.sh
[Youtube]: https://www.youtube.com


[image-01]: /images/20250220_youtube_to_podcast_docker_01.jpg



