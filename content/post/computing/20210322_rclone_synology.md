---
title: "Instalar rclone en Synology Ds920+"
date: "2021-09-25"
creation: "2021-03-22"
description: "Como instalar rclone en Synology Ds920+"
thumbnail: "/images/20210322_rclone_synology_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
- "rclone"
- "synology"
draft: false
weight: 5
---
Tanto en la migración de los discos duros desde el Ds216+II al Ds920+ como en la actualización desde DSM6 a DSM7, uno de los problemas con que me he encontrado es que ha desaparecido la instalación de Rclone, toca volver a instalarlo.
<!--more-->

Sinceramente, no me acuerdo del metodo que tuve que seguir para instalar rclone en mi anterior synology DS216+II, sólo dejo aquí las dos líneas de código que hacen falta para instalarlo en el Ds920+ accediendo por ssh a la terminal tanto en DSM6 como en DSM7.

```
sudo -i
curl https://rclone.org/install.sh | bash
```

> Aunque en la migración se ha perdido el programa no ha pasado lo mismo con los datos de configuración que siguen estando en "/var/services/home/.config/rclone/rclone.conf. Importante tener en cuenta que este archivo de configuración es distinto para cada usuario."

[Rclone]: https://rclone.org
