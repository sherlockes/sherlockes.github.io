---
title: "Calcular mtemperatura media en Home Assistant"
date: "2022-05-24"
creation: "2022-05-24"
description: "Una forma rápida y sencilla de calcular la temperatura media entre un conjunto de sensores"
thumbnail: "images/20220524_home_assistant_average_temperature_00.jpg"
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
¿Que pasa si en casa tenemos varios sensores y queremos calcular la temperatura media de ellos para controlar la calefacción? Con esta sencilla integración personalizada es posible crear un sensor virtual de una forma rápida y sencilla.
<!--more-->
Antes de seguir adelante, debes tener instalado [HACS] en tu entorno de [Home Assistant]. No voy a entrar aquí en la forma de hacerlo ya que está perfectamente documentado en su web. [HACS] es una tienda de la comunidad para [Home Assistant] en la que podemos encontrar infinidad de integraciones y configuraciones personalizadas.

En mi caso ya uso varias integraciones de [HACS] como pueden ser [Alexa Media Player] para enviar comandos a Alexa, [Gigaset Elements] para integrar la alarma de casa y [Yi-Hack] para la integración de las cámaras. Pero la integración que nos ocupa en este artículo es [Average Sensor] para calcular el valor medio de uno o varios sensores.



![image-01]

### Enlaces de interés
- [HACS](https://hacs.xyz)

[Alexa Media Player]: https://github.com/custom-components/alexa_media_player
[Average Sensor]: https://github.com/Limych/ha-average
[Gigaset Elements]: https://github.com/dynasticorpheus/gigasetelements-ha
[Yi-Hack]: https://github.com/roleoroleo/yi-hack_ha_integration

[HACS]: https://hacs.xyz
[Home Assistant]: https://www.home-assistant.io

[image-01]: /images/20220524_home_assistant_average_temperature_01.jpg



