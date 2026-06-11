---
title: "Homepage, mostrando contenedores remotos"
date: "2026-06-09"
creation: "2026-06-09"
description: "He creado Homepage, mostrando contenedores remotos para compartir mis opiniones y conocimientos."
thumbnail: "images/20260609_homepage_mostrando_contenedores_remotos_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
- "sherver"
tags:
- "docker"
- "yaml"
- "homepage"
draft: false
weight: 5
---

Hace mucho tiempo que uso [homepage] como página de inicio para mostrar el contenido de mis servidores y enlaces favoritos. Aquí dejo como mostrar el estado de un contenedor en un servidor remoto.

<!--more-->

Tengo dockers distribuidos por varias máquinas, la forma más sencilla y cómoda de ver el estado de todos ellos es mediante la página de inicio que tengo pública en el [vps] mediante [homepage].

Para mostrar el estado del contenedor en un primer lugar editaremos el archivo `docker.yaml` incluyendo lo siguiente:

``` yaml
vps-local:
socket: /var/run/docker.sock
```

A continuación en el archivo `services.yaml` editaremos el enlace correspondiente para que se muestre el estado del contenedor. De esta forma cada servicio quedará así:

``` yaml
- Ubercon:
    - Host Monitor:
        icon: zerotier
        href: https://monitor.vps.sherblog.es
        description: Monitor de equipos de las redes personales
        container: zerotier-monitor
        server: vps-local
    - Rss Tracker:
        icon: https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/yarr.svg
        href: http://rsstracker.vps.sherblog.es
        description: Fuentes Rss de todos los trackers privados de torrents
        container: rsstracker
        server: vps-local
```
y con esto conseguimos un resultado en nuestra página como este:

![image-01]

Para los contenedores que corren en el mismo host que [homepage] esta solución es perfecta pero para contenedores que corren en host remotos vamos a necesitar un pequeño contenedor que va a ser el intermediario y encargado de enviar la info del socket de docker de un host a otro. lo montaremos con este docker compose:

``` yaml
services:
  docker-socket-proxy:
    image: tecnativa/docker-socket-proxy:latest
    container_name: docker-socket-proxy
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro # Lee el socket local en modo lectura
    ports:
      - "192.168.191.211:2375:2375"
    environment:
      - CONTAINERS=1
      - SERVICES=1
      - NETWORKS=0
      - VOLUMES=0
      - IMAGES=0
      - POST=0
```
> La conexión entre ambos host es posible de una forma muy sencilla ya que ambos están dentro de la misma red de zerotier (IP 192.168.191.xxx)

El siguiente paso es añadir un nuevo host en el archivo `docker.yaml` de la carpeta `data`del contenedor [homepage]. El mío ha quedado así usando la ip de la red de zerotier del host remoto:

``` yaml
vps-local:
  socket: /var/run/docker.sock

uberz:
  host: 192.168.191.211
  port: 2375
```
Ahora ya podemos añadir la parte correspondiente dentro de los servicios en el archivo `services.yaml`para quedar algo así:

``` yaml
- Uber:
    - SherloTracks:
        icon: /icons/sherlotracks.png
        href: http://sherlotracks.zgz.sherblog.es
        description: contenedor personalizado para mostrar mis tracks de strava
        container: sherlotracks-front
        server: uberz
    - Sherlocaster:
        icon: /icons/sherlocaster.png
        href: http://192.168.10.211:8000
        description: Contenedor personalizado para la descarga de vídeos de Youtube y Twitch. Posteriormente se convierten en un podcast.
        container: sherlocaster-web
        server: uberz
```

Así de sencillo, sin más.

### Enlaces de interés
- [docker-socket-proxy](https://github.com/tecnativa/docker-socket-proxy)

[homepage]: https://gethomepage.dev
[vps]: http://homepage.vps.sherblog.es



[image-01]: /images/20260609_homepage_mostrando_contenedores_remotos_01.jpg