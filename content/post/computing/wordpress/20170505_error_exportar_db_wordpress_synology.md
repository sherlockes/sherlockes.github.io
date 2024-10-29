---
title: "Error al exportar base de datos de WordPress en Synology webStation"
date: "2017-05-05"
creation: "2017-05-05"
description: "Una prueba."
thumbnail: "images/20170505_error_export_database_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Wordpress"
  - "Sherver"
tags:
  - "synology" 
draft: false
weight: 5
---
Hace unos días que publiqué el [modo]({{< relref "20170404_backup_db_wordpress.md" >}}) en el que hacía la copia de seguridad de la base de datos de WordPress desde el propio hosting hasta una unidad de Google Drive. Haciendo pruebas para alojar la web en el Nas de Synology me doy cuenta de que el [plugin][2] para exportar la base de datos y enviarla por correo electrónico periódicamente no funciona.

Pruebo con otros plugins similares y todos me dan el mismo error y tras unas pruebas y un poco de buceo por la red me doy cuenta que el problema reside en la incapacidad del servidor web para tratar los archivos comprimidos.

La solución es simple, sólo hace falta habilitar la extensión "zip" de la configuración de php del Synology WebStation tal y como se puede ver en la siguiente imagen.

![error_db][1]

[1 ]: /images/20170505_error_export_database_01.jpg
[2]: https://es.wordpress.org/plugins/wp-db-backup