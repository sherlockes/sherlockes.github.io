---
title: "Sensor de temperatura personalizado"
date: "2024-09-13"
creation: "2024-09-13"
description: "Como he creado mi propio sensor de temperatura a partir de un módulo zigbee"
thumbnail: "images/20240913_zigbee_custom_temperature_sensor_00.jpg"
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
En [Aliexpress] puedes encontrar infinidad de sensores zigbee pero no uno al que conectar varias sondas de temperatura a un precio razonable. Por esto me he decidido a crear el mio propio.
<!--more-->

### Materiales
Partiremos de un pequeño y económico [CC2530] que no es difícil encontrar por menos de 5€ con antena incluida
![image-02]

Hay varias alternativas para programar el controlador, personalmente me he decantado por usar el [CC-DEBUGGER] con un coste inferior a 10€
![image-03]

Por poco más de 1€ podemos encontrar la sonda de temperatura [DS18B20] que conectaremos al controlador zigbee.
![image-04]

Para un primer prototipo, lo anterior junto a alguna resistencia y unos cables dupont va a ser todo lo necesario. Posteriormente lo meteremos todo en una caja con una fuente de alimentación.

### Firmware
En ningún momento me he planteado desarrollar mi propio software para controlar este dispositivo. Buscando información he encontrado (Pvto), un firmware para controlar el CC2530 personalizable desde un entorno gráfico



Problema, El software de configuración de ptvo sólo corre en windows por lo que para ejecutarlo en Linux Mint he necesitado Wine

``` bash
sudo apt update
sudo apt install wine
sudo wine FirmwareConfig.exe
```

Conexión de cc-debugger a CC2530
https://ptvo.info/how-to-select-and-flash-cc2530-144/
![image-01]

### Enlaces de interés
- [Domótica en casa - CC2530](https://domoticaencasa.es/tutorial-ampliamos-cobertura-zigbee2mqtt-cc2530-cc2531/)
- [HA - DIY zigbee temperature measurement](https://community.home-assistant.io/t/diy-zigbee-4x-ds18b20-temperature-measurement/246584)
- [pvto - external sensors](https://ptvo.info/zigbee-configurable-firmware-features/external-sensors/ds18b20/)


[Aliexpress]: https://aliexpress.com/
[CC2530]: https://www.ti.com/lit/gpn/cc2530
[CC-DEBUGGER]: https://www.ti.com/tool/CC-DEBUGGER
[DS18B20]: https://www.analog.com/en/products/ds18b20.html#part-details
[Pvto]: https://ptvo.info

[image-01]: /images/20240913_zigbee_custom_temperature_sensor_01.jpg
[image-02]: /images/20240913_zigbee_custom_temperature_sensor_02.jpg
[image-03]: /images/20240913_zigbee_custom_temperature_sensor_03.jpg
[image-04]: /images/20240913_zigbee_custom_temperature_sensor_04.jpg





