---
title: "Sincronizar configuración SSH en linux"
date: "2026-06-09"
creation: "2026-06-09"
description: "He creado Sincronizar configuración SSH en linux para compartir mis opiniones y conocimientos."
thumbnail: "images/20260609_sincronizar_configuracion_ssh_en_linux_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "linux"
- "ssh"
- "github"
- "bash"
draft: false
weight: 5
---

Sincronizando configuración de los host de ssh en linux gracias a un repositorio privado de github y la inestimable ayuda del script [gitsync.sh].

<!--more-->

Tengo un repo privado en [GitHub] en el que tengo guardado al archivo de configuración de ssh de linux "~/.ssh/config" con todos los host de mi red para de esta forma poder sincronizarlo entre todos los equipos.

``` sh
.
└── ssh
    ├── config
    └── leeme.txt
```
> Dentro del archivo leeme.txt tengo descrito como crear un enlace simbólico del archivo config en la carpeta "~/.ssh" mediante el comando `ln -sf "$(pwd)/config" ~/.ssh/config`

El principal problema es como realizar los push al repo una vez que este se haya modificado en alguna máquina

¿Y si el propio sistema se encargara de revisar el estado del repositorio, guardar tus cambios locales de forma automática y decidir si toca descargar o subir información? 

El Desafío: Actualizar el repo local o remoto cuando hay cambios en uno u otro


## La Herramienta: El Script [gitsync.sh]

Este script creado gracias a la IA acepta la ruta del repositorio como argumento (usando el directorio actual por defecto) y maneja toda la lógica de forma segura, incluyendo una comprobación previa de la conexión SSH con GitHub.

{{< texto_remoto "https://raw.githubusercontent.com/sherlockes/SherloScripts/refs/heads/master/bash/gitsync.sh" >}}

## Despliegue global mediante Enlaces Simbólicos

Para poder usar este script desde cualquier lugar del sistema sin duplicar el código, lo ideal es mantener el archivo original centralizado (por ejemplo, en una carpeta de herramientas personales) y crear un enlace simbólico en el `$PATH` del sistema:

``` bash
sudo ln -s "$PWD/gitsync.sh" /usr/local/bin/gitsync
```

A partir de este momento, el comando `gitsync` está disponible globalmente en la terminal.

## El Toque Final: Automatización Invisible con Cron

Tener el comando simplificado está bien, pero el objetivo real es olvidarse de él. Queremos que se ejecute **en cada arranque del sistema**. Para ello recurrimos al `crontab` de Linux (`crontab -e`).

Aquí es donde la mayoría de los intentos de automatización de Git fallan. `cron` ejecuta las tareas en un entorno ultra-restringido; no carga tu entorno gráfico, ni tu terminal habitual, por lo que **no tiene acceso a tus llaves SSH**. Si lanzas el script a secas, la conexión con GitHub fallará por falta de autenticación.

Para solucionarlo, forzamos a `cron` a cargar el entorno del usuario (`.bashrc`) antes de ejecutar el comando, y redirigimos el resultado a un archivo de registro que se sobrescribirá en cada ejecución para controlar el espacio en disco:

```cron
@reboot . $HOME/.bashrc; /usr/local/bin/gitsync $HOME/dotfiles > $HOME/.gitsync.log 2>&1
```
Con esto, cada vez que arranque el sistema se actualizará el repositorio con el archivo de configuración ssh.

> En caso de que actualicemos este archivo tendremos que lanzar el comando `gitsync` desde dentro de la carpeta del repo para que se suban los cambios a [GitHub]

## Resumen:
* Clonar el repo con los dotfiles
* Descargar el script [gitsync.sh] y crear el enlace simbólico
* Crear el cron para la actualización en el arranque


[GitHub]: https://github.com/sherlockes
[gitsync.sh]: https://github.com/sherlockes/SherloScripts/blob/master/bash/gitsync.sh
