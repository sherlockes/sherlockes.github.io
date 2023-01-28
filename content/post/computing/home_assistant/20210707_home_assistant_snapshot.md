---
title: "Guardando y recuperando la configuración de Home Assistant"
date: "2021-07-07"
creation: "2021-07-07"
description: "Como crear una copia de seguridad de Home Assistant y poder recuperarla."
thumbnail: "/images/20210707_home_assistant_snapshot_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "home assistant"
- "iot"
tags:
- "google drive"
draft: false
weight: 5
---
Llegará el día en que la instalación de [Home Assistant] se corrompa por algún fallo de software o de hardware, hay que estar preparados para ese momento creando de forma regular copias de seguridad en forma de "snapshots" que posteriormente sea posible recuperar.
<!--more-->

### Guardando la instantánea
Tan sencillo como crear una instantánea del sistema desde el modo "Supervisor" en la pestaña "Instantáneas" y el botón de la parte inferior derecha "Crear instantánea".

![image-01]

Es posible crearla parcial o total y, dependiendo de donde la vayamos a guardar, es imprescindible hacer uso de una contraseña de encriptación.

Ni que decir tiene que la copia de seguridad no puede quedarse sólo en el propio aparato que esté corriendo [Home Assistant] para lo cual, una vez creada, pulsamos sobre ella y mediante el menú de los tres puntos es posible descargarla para almacenarla en un lugar seguro.

![image-02]

### Importando la instantánea
Si tenemos una instantánea (snapshot) de una instalacion anterior resultará muy sencillo recuperar toda la configuración de [Home Assistant]. Para ello y tras instalar [Home Assistant] seguiremos los siguientes pasos:

1. Instalar "FTP" desde la "Tienda de complementos" del Supervisor
1. Iniciar el add-on desde la pestaña "Información"
1. En "opciones" de la pestaña "Configuración" cambiar el usuario y contraseña
1. Cambiar a "true" el permiso de subida ("allow_upload") y el acceso a la carpeta "backup"
1. Guardar los cambios y reiniciar el add-on
1. Acceder mediante ftp al servidor y copiar la instantánea en la carpeta "backup"
1. En "Supervisor-Instantáneas" seleccionar la subida y restaurarla
1. Espera unos minutos y accese de nuevo a Home Assistant

![image-03]

### Automatizando las instantáneas
Los principios básicos de las copias de seguridad pasan por el 3-2-1
- Crear 3 copias de los datos
- Al menos 2 tipos de formatos de almacenamiento distintos
- Almacena 1 fuera del lugar de producción

A lo que hay que añadir que este proceso debe ser lo mas automatizado posible para dejar fuera el factor "humano" o error de "capa 8".

Para simplificar todo este proceso utilizo el addon [Home Assistant Google Drive Backup] con el que es posible automatizar el proceso de copias de seguridad y ofrece la posibilidad de dejar unas en local y otras en una unidad de [Google Drive]

![image-04]

Si a esto añadimos la copia de seguridad que semanalmente realiza mi synology de toda mi unidad completa de [Google Drive], donde están incluidas estas instantáneas de [Home Assistant], a través de "Hyper Backup" ya puedo decir que cumplo con los principios básicos de las copias de seguridad.


[Google Drive]: https://drive.google.com
[Home Assistant]: https://www.home-assistant.io
[Home Assistant Google Drive Backup]: https://github.com/sabeechen/hassio-google-drive-backup

[image-01]: /images/20210707_home_assistant_snapshot_01.jpg
[image-02]: /images/20210707_home_assistant_snapshot_02.jpg
[image-03]: /images/20210707_home_assistant_snapshot_03.jpg
[image-04]: /images/20210707_home_assistant_snapshot_04.jpg
