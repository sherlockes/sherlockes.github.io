---
title: "Sherlocate, una app de seguimiento"
date: "2026-06-28"
creation: "2026-06-28"
description: "He creado Sherlocate, una app de seguimiento para compartir mis opiniones y conocimientos."
thumbnail: "images/20260628_sherlocate_una_app_de_seguimiento_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "Sherver"
- "computing"
tags:
- "Mapas"
- "apps"
- "docker"
- "python"
- "traccar"
draft: true
weight: 5
---

La aplicación de seguimiento y trackeo que he usado durante los últimos diez años para mis rutas en bici se está poniendo pesada con la publicidad y suscripción de pago. Por esto me he creado mi propia aplicación mediante un contenedor docker que corre en el vps. Se trata de [Sherlocate].

<!--more-->

El sistema es muy sencillo, el teléfono manda la ubicación al servidor y este muestra una página web con un mapa en el que, cualquiera que conozca tu código de trackeo puede ver tu ubicación actual y la ruta que has seguido para llegar allí. A las 0:00 se borran los datos de posicionamiento de forma que sólo se muestra el rastro del día actual.

Para enviar los datos desde el teléfono vamos a usar la app [Trackar Client], una sencilla app que permite configurar el servidor al que le vamos a enviar los datos de posicionamiento.

Para recibir y mostrar los datos he creado [Sherlocate], una sencilla webapp que simplemente muestra un mapa con la ubicación y ruta que ha seguido el usuario que está enviando los datos. La app la tengo corriendo en un vps mediante docker detrás de un proxy inverso con npm.

¡[image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[Sherlocate]: https://github.com/sherlockes/sherlocate
[Trackar Client]: https://www.traccar.org/client/
[image-01]: /images/20260121_Sherlocate, una app de seguimiento_01.jpg
