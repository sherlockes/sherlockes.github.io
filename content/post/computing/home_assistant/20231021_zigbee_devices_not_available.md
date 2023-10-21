---
title: "Mostrar dispositivos no disponibles en Home Assistant"
date: "2023-10-21"
creation: "2023-10-21"
description: "Una forma sencilla y rápida de mostrar los dispositivos que tenemos que reconfigurar pos que han quedado fuera de servicio."
thumbnail: "images/20231021_zigbee_devices_not_available_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "zigbee"
- "jinja2"
draft: true
weight: 5
---
De vez en cuando, hay dispositivos [Zigbee] que dejan de estar disponibles para [Home Assistant] y hay que volver a configurarlos, con esta sencilla tarjeta podremos ver cuales son y así no tener duda de que es lo que falla.
<!--more-->
Una vez más hago uso de plantillas en [Jinja2] para llevar a cabo una automatización en [Home Assistant]. Esta vez introducimos la plantilla dentro de una tarjeta del tipo "Markdown" que incluiremos en nuestro "Dashboard".

![image-01]




### Enlaces de interés
- [enlace](www.sherblog.pro)

[Home Assistant]: https://www.home-assistant.io
[Jinja2]: https://codeburst.io/jinja-2-explained-in-5-minutes-88548486834e
[Zigbee]: https://es.wikipedia.org/wiki/Zigbee

[image-01]: /images/20231021_zigbee_devices_not_available_01.jpg



