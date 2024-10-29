---
title: "Raspberry Reinicios periódicos"
date: "2018-04-10"
creation: "2018-04-10"
description: "Pare que no se cuelgue la Raspberry no está de más reiniciarla periódicamente."
thumbnail: "images/20180501_raspberry_reinicio.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Raspberry"
tags:
  - "desarrollo"
draft: false
weight: 15
---
### Reiniciar la Raspberry a diario
Para que la Raspberry se reinicie al menos una vez al día por si alguno de los servicios se cuelga y no tenemos acceso a ella o no nos damos cuenta del problema he implementado un reinicio diario a las 4:00 AM mediante una tarea programada usando el cron del usuario root

```
sudo crontab -e
```
nos abre un archivo al que le añadiremos la siguiente línea

```
00 04 * * 0 /sbin/reboot
```
