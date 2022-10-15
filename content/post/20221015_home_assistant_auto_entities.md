---
title: "Tarjetas inteligentes en Home Assistant"
date: "2022-10-15"
creation: "2022-10-15"
description: "Como crear y utilizar tarjetas inteligentes en Home assistant mediante auto-entities"
thumbnail: "images/20221015_home_assistant_auto_entities_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "hacs"
draft: true
weight: 5
---
Para que el contenido de una tarjeta del panel de control de [Home Assistant] sea dinámico y potenciar toda su funcionalidad, la forma más sencilla es mediante el uso de [auto-entities]
<!--more-->
El objetivo de hoy es sencillo, conseguir que la tarjeta que me muestra el estado de la batería de todos los equipos que utilizo en la domótica de casa se muestre ordenada según la batería disponible de cada uno de los equipos. Para esto voy a hacer uso de [auto-entities].

### Instalación de auto-entities
Gracias a [HACS] la instalación de [auto-entities] se realiza de forma muy sencilla. Accederemos al panel de control de HACS posteriormente el menú "Interfaz" y usaremos el botón de abajo "Explorar y descargar repositorios"

![image-01]

Buscaremos "auto-entities" en el cuadro de diálogo de la lupa e instalaremos la ultima versión disponible.

> Tras la instalación he tenido algún problema a la hora de incluir nuevas tarjetes, no tengo claro si hay que refrescar el navegador o acceder a [Dashboard Resources] y actualizar el módudo de javascript correspondiente a "auto entities".



### Enlaces de interés
- [Thomas Loven - Lovelace plugins](https://github.com/thomasloven/hass-config/wiki/Lovelace-Plugins)
[Community Home Assistant - Auto-entities not working](https://community.home-assistant.io/t/lovelace-auto-entities-not-working-in-93-2/123807/6)

[auto-entities]: https://github.com/thomasloven/lovelace-auto-entities
[Dashboard Resources]: https://my.home-assistant.io/redirect/lovelace_resources
[HACS]: https://hacs.xyz
[Home Assistant]: https://www.home-assistant.io

[image-01]: /images/20221015_home_assistant_auto_entities_01.jpg



