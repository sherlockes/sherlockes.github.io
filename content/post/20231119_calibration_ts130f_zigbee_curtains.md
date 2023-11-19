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

- Información de Dispositivo
- Administrar dispositivo Zigbee (Tres puntos)
- En la pestana "Clústeres" seleccionar "TuyaCoveringCluster"
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


![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[Aliexpress]: https://es.aliexpress.com/item/1005005225077998.html?spm=a2g0o.order_list.order_list_main.24.6d91194dVqAnVc&gatewayAdapt=glo2esp

[image-01]: /images/20231119_calibration_ts130f_zigbee_curtains_01.jpg



