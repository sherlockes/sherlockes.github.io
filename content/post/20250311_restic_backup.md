---
title: "Backups con Restic"
date: "2025-03-11"
creation: "2025-03-11"
description: "Gestión de las copias de seguridad de los datos de contenedores dockers con Restic"
thumbnail: "images/20250311_restic_backup_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
- "rclone"
- "restic"
draft: true
weight: 5
---
Después de valorar algunas alternativas para la creación de las copias de seguridad de los datos de mis contenedores he encontrado una buena solución en restic.
<!--more-->
### Que necesito
Todos los datos que necesito para montar los contenedores que uso habitualmente la tengo guardada en la carpeta "~/dockers" con lo que el problema es muy sencillo. Tan solo tengo que hacer una copia de seguridad de esta carpeta en otro dispositivo.

### Alternativas
Comencé copiando esta carpeta comprimida al ordenador de sobremesa de forma regular o incluso subiéndola a un canal de Telegram. Empecé incluso a hacer un script para automatizar la tarea pero el otro día tuve una revelación gracias a [Atareao] y me he decidido a probar [Restic] Como gestor de la copia de seguridad. Una de las razones de peso ha sido la posibilidad que ofrece [Restic] de combinarse con [Rclone] para hacer directamente la copia en la nube.

### Que voy a utilizar
 - Restic como gestor de backups
 - Rclone como herramienta para subir el backup a la nube
 - Bash para crear un script con el que automatizar la tarea
 - Cron para programar el script
 - Claude para ayudarme en el proceso.

![image-01]

### Enlaces de interés
- [Atareao](www.atareao.es)

[Atareao]: https://www.atareao.es
[Claude]: https://claude.ai
[Rclone]: https://rclone.org
[Restic]: https://restic.net

[image-01]: /images/20250311_restic_backup_01.jpg



