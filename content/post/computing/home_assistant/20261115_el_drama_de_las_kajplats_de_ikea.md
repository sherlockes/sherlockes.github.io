---
title: "El drama de las Kajplats de Ikea"
date: "2026-11-15"
creation: "2026-11-15"
description: "He creado El drama de las Kajplats de Ikea para compartir mis opiniones y conocimientos."
thumbnail: "images/20261115_el_drama_de_las_kajplats_de_ikea_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "zigbee"
- "home assistant"
- "z2m"
- "ikea"
draft: false
weight: 5
---

El precio de las bombillas [Kajplats] de Ikea es imbatible pero configurarlas en modo Zigbee puede ser un profundo dolor de cabeza. Esta ha sido mi experiencia.

<!--more-->

Menos de 5€ es lo que cuesta una bombilla de [Kajplats] para poner en los flexos de los escritorios de los chicos.

![image-02]

Pero la configuración no va a ser tan sencilla ya que no dispongo de coordinador [Dirigera] ni de un coordinador matter. Por suerte y tal y como está documentado en [www.zigbee2mqtt.io], estas bombillas tambien tienen implementado el protocolo zigbee pero no viene activado por defecto, para activarlo hay que:

 1. Encender y apagar la bombilla 6 veces para realizar un reseteo de fábrica
 2. Encender y apagar la bombilla 12 (o 15 en algunos modelos) veces para entrar en el modo de emparejamiento zigbee

Con la primera bombilla que lo intento no soy capaz de emparejarla después de muchas pruebas así que termino pensando que la bombilla está averiada.

> Llego a realizar la conexión zigbee de la bombilla y la puedo apagar desde home assistant pero cuando se enciende se queda parpadeando en blanco cálido como realizando el emparejamiento matter.

La segunda bombilla la intento configurar mucho más cerca del coordinador zigbee y queda funcionando correctamente siguiendo el proceso de activación del emparejamiento zigbee expuesto arriba.

Sigo haciendo pruebas con la primera bombilla hasta que llega un momento que la bombilla ni enciende al recibir la alimentación por lo que la doy por rota y la cambio por otra.

Después de un rato en Ikea para cambiar la bombilla, vuelvo a la carga con los intentos de conexión que vuelven a ser fallidos. Ni poniendo la bombilla junto al coordinador zigbee consigo conectarla.

Por suerte no soy el único que ha encontrado estas dificultades, parece que algunas bombillas son muy escrupulosas con los tiempos de encendido y apagado para hacer el reset y alguien ha creado un [Blueprint] para evitar el problema con la ayuda de un enchufe inteligente.

![image-01]

Con los tiempos de la imagen a mi me ha funcionado a la primera. Sólo hay que seleccionar el enchufe al que vas a conectar la bombilla y ejecutar el script.

> Por suerte, la configuración de los pulsadores [Bilresa] es mucho mas sencilla y no da problemas.

[Kajplats]: https://www.ikea.com/es/es/p/kajplats-bombilla-led-e27-470-lumenes-inteligente-espectro-blanco-globo-blanco-opalo-00611307/
[Dirigera]: https://www.ikea.com/es/es/p/dirigera-base-productos-inteligentes-blanco-inteligente-10503406/
[www.zigbee2mqtt.io]: https://www.zigbee2mqtt.io/devices/KAJPLATS_WS.html
[Blueprint]: https://community.home-assistant.io/t/ikea-kajplats-smart-bulb-zigbee-pairing-mode-power-cycle/988507
[Bilresa]: https://www.zigbee2mqtt.io/devices/E2489.html

[image-01]: /images/20261115_el_drama_de_las_kajplats_de_ikea_01.jpg
[image-02]: /images/20261115_el_drama_de_las_kajplats_de_ikea_02.jpg
