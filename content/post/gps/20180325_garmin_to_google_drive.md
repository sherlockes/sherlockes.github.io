---
title: "De Garmin a Google drive"
date: "2018-03-25"
creation: "2018-03-25"
description: "Como me lo monto para pasar las rutas y generar estadísticas del Garmin hasta Google Drive."
#thumbnail: "images/20180606_junta_roca_ampollas_00.jpg"
disable_comments: true # Optional, disable Disqus comments if true
authorbox: false # Optional, enable authorbox for specific post
toc: false # Optional, enable Table of Contents for specific post
mathjax: false # Optional, enable MathJax for specific post
categories:
  - "gps"
tags:
  - "garmin"
  - "google drive"
draft: false
weight: 5
---
### El problema

Desde hace muchos años, en todos mis paseos en bicicleta me acompaña un GPS Garmin (Antes un Edge 605 y ahora un Edge 1000) que tengo ligado al servicio de [Garmin Connect][1] y indirectamente a [Strava][2]. He visto como van evolucionando ambos servicios online a lo largo del tiempo y algo de lo que a mi gusto ambos cojean es en la personalización de las estadísticas. <!--more-->

### La solución

No pido mucho, fijar un objetivo anual, uno mensual y un seguimiento diario de los kilómetros. Hacerlo en [Garmin Connect][1] o [Strava][2] aunque es posible, es muy pesado por lo que para mi gusto pienso que resulta mucho más práctico hacerlo en una hoja de cálculo donde guardaré los datos de todas las salidas.

Pero... ¿Como paso la información de cada salida a una hoja de cálculo? Resulta obvio que la introdución a mano de todos los datos no me lo planteo, debe ser de una forma automática

Pues bien, la solución que he encontrado es muy simple. Como ya he mencionado anteriormente, Garmin Connect y Strava los tengo sincronizados de forma que en el momento que termino la ruta el GPS la envía al primero y consecuentemente al segundo.

A continuación y gracias a [IFTTT][3] tengo creada una receta para que cada vez que aparece una nueva ruta en mi perfil de Strava se añada una nueva línea a una hoja de cálculo en Google Drive. Para terminar ya solo resta formatear la información recibida en una segunda hoja para poderla tratar y generar mis estadísticas, pero esto ya lo contaré otro día...

Simple y efectivo, ahora cada nueva salida con la bicicleta aparecerá reflejada en mi hoja de estadísticas de [Google Drive][4] sin que tenga que mediar para nada.

Y esto es todo por hoy, pero día comentaré en profundidad todas las hojas y fórmulas dentro del archivo de Google Sheets dice va a parar la información de todas mis rutas en bicicleta.

 [1]: https://connect.garmin.com
 [2]: https://www.strava.com
 [3]: https://ifttt.com
 [4]: https://www.google.es/drive/apps.html
