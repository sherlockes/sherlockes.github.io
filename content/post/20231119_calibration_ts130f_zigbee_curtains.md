---
title: "Calibración de las persianas con en controlador TS130F"
date: "2023-11-19"
creation: "2023-11-19"
description: "Forma de calibrar la apertura y cierre de las persianas mediante zha y el controlador TS130F de Tuya"
thumbnail: "images/20231119_calibration_ts130f_zigbee_curtains_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "zigbee"
draft: true
weight: 5
---
La parte más importante de la domotización de las persianas es un correcto ajuste de las posiciones de apertura y cierre. Parece sencillo, pero sin un manual de instrucciones del fabricante se convierte en un dolor de cabeza.
<!--more-->

Partimos de un controlador "barato" de [Aliexpress] que no es más que un TS130F de Tuya del que no hay ni rastro en la web del fabricante y del que no he sido capaz de encontrar un manual de usuario completo.

Mi centro de control domótico en [Home Assistant] y mediante la integración [Zha] gestiono todos los elementos zigbee que tengo instalados en casa a través de un controlador [Sonoff] y es para este caso porticular para el que voy ha dar la explicación.

Tras el cableado del controlador, el emparejamiento con la red domótica no presenta ninguna dificultad. Simplemente se pulsa el botón de "reset" durante unos segundos hasta que el led empieza a parpadear y se busca un nuevo dispositivo zigbee.

![image-01]

Tras esto ni mucho menos el dispositivo está listo ya que al darle a subir o bajar la persiana se menea un poco y se para. Necesita una calibración de las posiciones "cerrada" y "abierta". Seguiremos los siguientes pasos:

- Accedemos al menú "Ajustes"
- "Dispositivos y servicios"
- Seleccionamos el dispositivo que acabamos de emparejar.
- Nos fijamos en el menú "Información del dispositivo"

![image-02]

- Pinchamos el en menú de los tres puntos
- Seleccionamos la opción "Administrar dispositivo Zigbee"

![image-03]

### Calibración por movimiento
Este tipo de calibración consiste en activar el modo de calibración y realizar un movimiento de la persiana entre sus extremos siguiendo estos pasos:
- En la pestana "Clústeres" selecciona los clústeres "TuyaCoveringCluster"
- En el atributo "Calibration" poner "0" como valor
- Escribir atributo para entrar en el modo de calibración
- En la pestaña comandos seleccionar "down_close" y emitir el comando
- La persiana empieza a bajar
- Seleccionar el comando "stop" y esperar mientras baja la persiana.
- Emitir el comando justo cuando llegue a la posición de cerrada.
- Seleccionar el comando "up_open" y emitirlo.
- Mientras la persiana sube seleccionar el comando "stop"
- Justo cuando la persiana llega arriba emitir el comando "stop"
- En el atributo "Calibration" poner "1" como valor
- Escribir el atributo para salir del modo de calibración.

### Calibración por tiempo


### Enlaces de interés
- [Calibrar persianas zibee de Vivogar](https://www.youtube.com/watch?v=AYZHKyLMS8w)

[Aliexpress]: https://es.aliexpress.com/item/1005005225077998.html?spm=a2g0o.order_list.order_list_main.24.6d91194dVqAnVc&gatewayAdapt=glo2esp
[Home Assistant]: https://www.home-assistant.io/
[Sonoff]: https://sonoff.tech/product/gateway-and-sensors/sonoff-zigbee-3-0-usb-dongle-plus-e/
[Zha]: https://www.home-assistant.io/integrations/zha/

[image-01]: /images/20231119_calibration_ts130f_zigbee_curtains_01.jpg
[image-02]: /images/20231119_calibration_ts130f_zigbee_curtains_02.jpg
[image-03]: /images/20231119_calibration_ts130f_zigbee_curtains_03.jpg



