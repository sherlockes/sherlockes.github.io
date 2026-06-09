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
draft: true
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

A continuación en el archivo `services.yaml` editaremos el enlace correspondiente para que se muestre el estado del contenedor.

¡[image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[homepage]: https://gethomepage.dev
[vps]: http://homepage.vps.sherblog.es

[image-01]: /images/20260121_Homepage, mostrando contenedores remotos_01.jpg
