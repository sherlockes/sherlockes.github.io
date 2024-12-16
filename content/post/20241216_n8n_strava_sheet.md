---
title: "De Strava a Google Sheets gracias a n8n"
date: "2024-12-16"
creation: "2024-12-16"
description: "Como he conseguido enviar el resumen de cada actividad de Strava a una hoja de cálculo de Google Sheets mediante n8n."
thumbnail: "images/20241216_n8n_strava_sheet_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "strava"
draft: true
weight: 5
---
Tras varias pruebas, al fin he conseguido la manera de enviar el resumen de cada actividad de [Strava] a la hoja donde genero mis estadísticas en Google Sheets de forma autoalojada y desatendida gracias a n8n.
<!--more-->
Desde hace varios años vengo recopilando todas mis actividades de [Strava] en una hoja de cálculo de Google Sheets. Las nuevas actividades son añadidas de forma automática gracias a dos servicios, [IFTTT] y [feedmyride]. Utilizo ambos por que uno complementa la información que no me da el otro y viceversa pero quiero encontrar una solución que no me haga depender de servicios de terceros.

Después de un tiempo trasteando con [Stravalib], una librería de python para interactuar con la API de Strava, he llegado a un callejón sin salida en lo referente a la autentificación y gestión de credenciales de forma desatendida por lo que me he puesto a buscar una solución alternativa.

[n8n] es una plataforma de automatización de flujos de trabajo que conecta aplicaciones, servicios y bases de datos sin necesidad de programar. Es altamente personalizable y de código abierto, lo que permite integraciones complejas mediante nodos configurables. Es fácil autoalojarlo mediante [Docker] en un servidor y uniéndolo a un proxy inverso resulta trivial acceder a el de forma remota.

### El workflow
Pues bien, por un lado tengo mi cuenta de Strava y por otro una hoja de cálculo en un archivo de Google Sheets en el que después de cada actividad quiero guardar la fecha, tiempo, distancia, altitud ganada... Para esto me he creado este "Workflow":

![image-01]

Es un flujo de trabajo completamente lineal que no tiene ninguna complicación. Veamos paso por paso lo que va haciendo.

- Schedule Trigger. Lanza el worflow una vez cada hora
- actividades. Lee el hoja de cálculo de Google Sheets donde tengo guardadas las actividades
- ordenar_guardadas. Ordena las actividades por su código de referencia
- ultimas_guardadas. Se queda sólo con las últimas 5 actividades que he guardado
- ultimas_id. Desprecia el resto de campos y se queda sólo con el código de identificación
- Strava. Descarga las 10 últimas actividades de Strava.
- ordenar_strava. Ordena por el id las actividades descargadas
- Remove Duplicates. Elimina registros duplicados
- ultimas_strava. Se queda sólo con las últimas 5 actividades descargadas
- strava_last. Limita la salida a los campos necesarios y los reformatea
- Code. Compara las cinco actividades leídas con las descargadas y devuelve las no guardadas
- ordenar_resultados. Ordena por el id de las actividades
- Google Sheets. Añade los resultados como nuevas filas en la hoja de cálculo

Y ya está, simplemente funciona. Cada hora comprueba si las últimas cinco actividades que tengo guardadas son las mismas que las últimas cinco que hay en Strava y si no es así añade las que falten.

> Este flujo de trabajo se puede simplificar bastante si usamos como disparador el webhook que Strava lanza cuando se añade una nueva actividad pero esto nos obliga a tener el servidor encendido continuamente.

### Formateando campos
Como fecha, strava devuelve un valor completo como este "2024-10-19T16:13:16Z" que quiero simplificar a "19/10/2024". Para esto utilizo esta conversión.
``` javascript
{{ DateTime.fromISO($json.start_date_local).toFormat('d/M/yyyy') }}
```

Para la distancia necesito convertir la distancia devuelta en metros a kilómetros con un sólo decimal. 
``` javascript
{{ Math.round($json.distance / 100) / 10 }}
```

### Enlaces de interés
- [enlace](www.sherblog.pro)

[Docker]: https://www.docker.com
[feedmyride]: https://feedmyride.net
[IFTTT]: https://ifttt.com
[n8n]: https://n8n.io
[Strava]: https://www.strava.com/
[Stravalib]: https://github.com/stravalib/stravalib

[image-01]: /images/20241216_n8n_strava_sheet_01.jpg



