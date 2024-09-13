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
Como he creado mi propio sensor de temperatura zigbee gracias a un pequeño módulo CC2530 y una sonda DS18B20 usando el firmware [Pvto]
<!--more-->



https://ptvo.info/zigbee-switch-configurable-firmware-router-199/

https://domoticaencasa.es/tutorial-ampliamos-cobertura-zigbee2mqtt-cc2530-cc2531/

https://ptvo.info/zigbee-configurable-firmware-features/external-sensors/ds18b20/

Problema, El software de configuración de ptvo sólo corre en windows por lo que para ejecutarlo en Linux Mint he necesitado Wine

``` bash
sudo wine FirmwareConfig.exe
```

Conexión de cc-debugger a CC2530
https://ptvo.info/how-to-select-and-flash-cc2530-144/
![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[Pvto]: https://ptvo.info

[image-01]: /images/20240913_zigbee_custom_temperature_sensor_01.jpg



