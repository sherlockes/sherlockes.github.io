---
title: "Descarga fallida. No working transports found"
date: "2017-03-13"
creation: "2017-03-13"
description: "Fallo al actualizar temas o plugins en WordPress instalado sobre Synology"
thumbnail: "images/20170215_descarga_fallida_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Wordpress"
  - "Sherver"
tags:
  - "Synology"
draft: false
weight: 5
---
Después de la instalación de WordPress en el servidor Synology al intentar actualizar los temas o los plugins me encuentro con el siguiente error.

![imagen][1]

Pues nada, toca "Googlear" un rato y pronto me doy cuenta de que la solución es bastante sencilla y basta con habilitar la extensión "Curl" dentro de la configuración de php de la aplicación Web Station tal y como se puede ver en la siguiente captura de pantalla.

![imagen][2]

Aplicamos los cambios, probamos de nuevo a actualizar el tema, sin reinicio de la aplicación, del servidor ni nada y... ya funciona¡¡¡

![imagen][3]

Que todos los problemas sean como este.

[1]: /images/20170215_descarga_fallida_01.jpg
[2]: /images/20170215_descarga_fallida_02.jpg
[3]: /images/20170215_descarga_fallida_03.jpg