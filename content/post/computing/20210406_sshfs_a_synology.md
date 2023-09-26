---
title: "Montar carpeta del NAS mediante sshfs"
date: "2021-04-11"
creation: "2021-04-06"
description: "Descripción"
thumbnail: "/images/20210406_sshfs_a_synology_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
- "synology"
- "linux"
draft: false
weight: 5
---
Hoy toca montar una carpeta del NAS en el pc mediante sshfs para correr sobre ella un script, resulta sencillo pero hay que tener en cuenta unas peculiaridades...
<!--more-->

Montar una carpeta remota en un directorio local trabajando en Linux es una tarea sencilla gracias a sshfs. En primer lugar es necesario instalar las utilidad en el sistema (En Linux Mint se resuelve con una sola línea en la terminal).

```
sudo apt install sshfs
```

Llegados a este punto resulta interesante tener un acceso al NAS mediante llave publico-privada tal y como detallo en este [artículo] para evitar la tediosa introducción de contraseñas.

> Imprescindible para que funcione el comando sobre el NAS que esté habilitado el acceso ssh y el servidor sftp desde "Panel de control - Servicios de archivos - FTP - Habilitar servicio SFTP"

Con esto ya es posible ejecutar en la consola el comando que monte la unidad del nas en la carpeta que deseemos de nuestro sistema.

```
sudo sshfs -o allow_other,default_permissions usuario@ip_del_nas:/carpeta ~/ruta_donde_montar

```

> La ruta a montar comienza en la carpeta "Volume1" del NAS de modo que para la carpeta "/Volume1/fotos/2021/" en el comando de sshfs deberemos poner "/fotos/2021".

En mi [repositorio] de Github tengo un pequeño [script] para automatizar un poco todo este proceso, puedes verlo y editarlo a tu gusto.

[articulo]: https://sherblog.pro/copiar-ssh-key-desde-synology/
[repositorio]: https://github.com/sherlockes/SherloScripts
[script]: https://github.com/sherlockes/SherloScripts/blob/master/bash/host.sh

[image-01]: /images/20210406_sshfs_a_synology_01.jpg
