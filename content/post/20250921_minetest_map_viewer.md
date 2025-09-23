---
title: "Visor de mapa conquistado en Minetest"
date: "2025-09-23"
creation: "2025-09-21"
description: "Descripción"
thumbnail: "images/20250921_minetest_map_viewer_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "luanti"
draft: true
weight: 5
---
Si juegas a Minetest te gustará tener un mapa en el que poder ver toda la zona que has conquistado  de una forma rápida y sencilla.
<!--more-->
Luanti (anteriormente llamado Minetest y llamado originalmente test-c55) es un juego libre basado en vóxeles para Windows, Mac OS, GNU/Linux, FreeBSD, OpenBSD, DragonFly BSD y Android similar a Minecraft. El juego fue desarrollado en 2010 bajo la dirección de Perttu Ahola (también conocido como celeron55) y, desde entonces, con la ayuda de una creciente comunidad de desarrolladores.

No le daré más vueltas, este es el resultado y a continuación dejaré la explicación de como ha sido generado.

<div id="viewer" style="width:100%; height:75vh;"></div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.1.1/openseadragon.min.js"></script>
<script>
  OpenSeadragon({
    id: "viewer",
    prefixUrl: "https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.1.1/images/",
    tileSources: "/mineclone2/tiles/map.dzi",
    showNavigator: true
  });
</script>


### Mi servidor de Luanti
Tengo el servidor del juego instalado mediante Docker en una máquina con Ubuntu Server junto con otros servicios. Para la generación del mapa vamos a necesitar el contenido del mundo en el que estamos jugando que se encuentra, en mi caso, en la carpeta "~/dockers/minetest/data/worlds/world"
y más específicamente en el archivo "map.sqlite"

### Crear imagen a partir del mapa
El primer paso va a ser crear una imagen a partir del contenido "map.sqlite" para lo que vamos a utilizar la aplicación [minetestmapper] siguiendo estos pasos:

- Instalar dependencias
- Descargar la última versión de minetestmapper
- Descomprimir el archivo descargado
- Acceder al directorio creado
- Compilar la aplicación
- Cambiar el archivo "colors.txt"
- Crear la imagen a partir del mapa

``` bash
sudo apt update

sudo apt install cmake libgd-dev libhiredis-dev libleveldb-dev libpq-dev libsqlite3-dev zlib1g-dev libzstd-dev build-essential

wget https://github.com/luanti-org/minetestmapper/archive/refs/heads/master.zip

unzip master.zip

cd minetestmapper-master

cmake . -DENABLE_LEVELDB=1
make -j$(nproc)

wget -O colors.txt https://raw.githubusercontent.com/yrungr/mineclone2mapper/master/colors.txt

./minetestmapper -i ~/dockers/minetest/data/worlds/world/ -o map.png --zoom 4
```

Y con esto ya tenemos generada la imagen de nuestro mundo, pero es un poco grande por lo que vamos a ver como la dividimos en trozos pequeños para poderla ver en el navegador con detalle.

### Servir el mapa como losetas
Primero vamos a crear las losetas a partir de la imagen entera mediante la aplicación [libvips] con un "tileado" de 256x256.

``` bash
sudo apt install -y libvips-tools

vips dzsave map.png tiles/map --suffix .png --tile-size 256 --overlap 0
```
Con esto se crea:

- tiles/map.dzi (descriptor)
- tiles/map_files/ (carpetas por niveles con los tiles)

### Insertarlo en nuestro sitio estático en Hugo
Para visualizar el contenido de las losetas vamos a utilizar [openseadragon] insertándolo en un post de este blog que desde hace unos años está desarrollado en [Hugo]. Para esto simplemente añadimos el siguiente contenido dentro del post:

``` html
<div id="viewer" style="width:100%; height:75vh;"></div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.1.1/openseadragon.min.js"></script>
<script>
  OpenSeadragon({
    id: "viewer",
    prefixUrl: "https://cdnjs.cloudflare.com/ajax/libs/openseadragon/4.1.1/images/",
    tileSources: "/mineclone2/tiles/map.dzi",
    showNavigator: true
  });
</script>
```

Para que [hugo] permita la visualización del html crudo incrustado hay que añadir en el archivo de configuración "hugo.toml" las siguientes líneas:

``` yaml
[markup.goldmark.renderer]
unsafe = true
```

![image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[hugo]: https://gohugo.io
[libvips]: https://www.libvips.org
[minetestmapper]: https://github.com/luanti-org/minetestmapper
[openseadragon]: https://openseadragon.github.io

[image-01]: /images/20250921_minetest_map_viewer_01.jpg



