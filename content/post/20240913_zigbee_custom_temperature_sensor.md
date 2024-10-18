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
En ningún momento me he planteado desarrollar mi propio software para controlar este dispositivo. Buscando información he encontrado (Pvto), un firmware para controlar el CC2530 personalizable desde un entorno gráfico. Parece que la última actualización es de hace más de tres años, con todo creo que puede funcionar.

Problema, El software de configuración de ptvo sólo corre en windows por lo que para ejecutarlo en [Linux Mint] he necesitado el uso de [Wine] ejecutando los siguientes comandos en la carpeta donde haya descargado y descomprimido el [instalador de Ptvo].

``` bash
sudo apt update
sudo apt install wine
sudo wine FirmwareConfig.exe
```
> Aunque salen algunos errores a la hora de lanzar el ejecutable de windows mediante Wine, termina arrancando y es completamente funcional.

![image-05]

- Seleccionamos el CC2530 como tipo de placa sobre el que vamos a trabajar
- La seleccionamos como dispositivo final
- La selección o no del "Status led" es irrelevante
- Seleccionamos la salida 1
- Le asignamos un pin de la placa
- Seleccionamos nuestra sonda y que la vamos a colocar con una resistencia externa.

Con esto ya podemos guardar el firmware que hemos creado en una carpeta de nuestro pc. Se generará un archivo *.txt con la información de la configuración y otro archivo *.hex con el contenido del firmware que debemos volcar al CC2530.

### Volcando el firmware al CC2530
Como ya he comentado anteriormente, voy a usar un [CC-DEBUGGER] para programar el CC2530 desde mi ordenador. Para hacerlo desde linux es necesario tener instalado [cc-tool] lo que puede llegar a ser un fuerte dolor de cabeza tal y como puedes ver en esta [nota].

Ahora necesitamos conectar el CC2530 al cc-debugger mediante unos puentes con cables dupont según el siguiente esquema.

![image-01]

| CCdebugger |             | CC2530   |
| Pin        | Utilidad    | Conexión |
|------------|-------------|----------|
| 1          | GND         | GND      |
| 3          | Degug Clock | P2.2     |
| 4          | Debug Data  | P2.1     |
| 7          | Reset       | Reset    |
| 9          | Vcc         | Vcc      |

Así están dispuestos los pines del ccdebugger
+----+
|1  2|
|3  4|
 5  6|
|7  8|
|9 10|
+----+

Con unos cuantos cables conectamos el cc-debugger al cc2530
![image-06]

Conectamos el ccdebugger al pc y volcamos el firmware que hemos generado anteriormente mediante la siguiente instrucción.
``` bash
sudo cc-tool -e -w custom_zigbee.hex
```

Si todo ha ido bien, el resultado será algo parecido a esto.
``` bash
Programmer: CC Debugger
Target: CC2530
Erasing flash...
Completed       
Writing flash (236 KB)...
Completed (16.62 s.)
```

### Montando el prototipo
Finalmente mi prototipo tendrá tres sondas de temperatura para el control de la caldera y el agua caliente sanitaria, dos relés para el termostato y encendido de la propia caldera y finalmente un led que indique el funcionamiento. Según esto el firmware generado tiene estas características:

``` txt
Board type: CC2530
Device type: End device without routing
Status LED: P11, Periodic (every 5 seconds)

Output pins:
P14: Output 1, DS18B20, External pull-up (Sensor ID (optional, hex): AA-BB-CC-DD-EE-FF-01-02, Mode: Multiple on bus, Auto-detect)
P15: Output 2, DS18B20, External pull-up (Sensor ID (optional, hex): AA-BB-CC-DD-EE-FF-01-02, Mode: Multiple on bus, Auto-detect)
P16: Output 3, DS18B20, External pull-up (Sensor ID (optional, hex): AA-BB-CC-DD-EE-FF-01-02, Mode: Multiple on bus, Auto-detect)
P00: Output 4, GPIO, External pull-up (Role: Generic), Remember state
P01: Output 5, GPIO, External pull-up (Role: Generic), Remember state
```
![image-07]

La teoría queda muy despejada pero a la hora de llevar este prototipo a la práctica


### Enlaces de interés
- [Domótica en casa - CC2530](https://domoticaencasa.es/tutorial-ampliamos-cobertura-zigbee2mqtt-cc2530-cc2531/)
- [HA - DIY zigbee temperature measurement](https://community.home-assistant.io/t/diy-zigbee-4x-ds18b20-temperature-measurement/246584)
- [pvto - external sensors](https://ptvo.info/zigbee-configurable-firmware-features/external-sensors/ds18b20/)
- [pvto - flash cc2530](https://ptvo.info/how-to-select-and-flash-cc2530-144/)


[Aliexpress]: https://aliexpress.com/
[CC2530]: https://www.ti.com/lit/gpn/cc2530
[CC-DEBUGGER]: https://www.ti.com/tool/CC-DEBUGGER
[cc-tool]: https://github.com/dashesy/cc-tool
[DS18B20]: https://www.analog.com/en/products/ds18b20.html#part-details
[instalador de Ptvo]: https://ptvo.info/download/ptvo-firmware-latest.zip
[Linux Mint]: https://www.linuxmint.com
[nota]: https://sherblog.es/brain/#0b8d3fe0-0bc7-4845-8028-7a2042137b4b
[Pvto]: https://ptvo.info
[Wine]: https://www.winehq.org

[image-01]: /images/20240913_zigbee_custom_temperature_sensor_01.jpg
[image-02]: /images/20240913_zigbee_custom_temperature_sensor_02.jpg
[image-03]: /images/20240913_zigbee_custom_temperature_sensor_03.jpg
[image-04]: /images/20240913_zigbee_custom_temperature_sensor_04.jpg
[image-05]: /images/20240913_zigbee_custom_temperature_sensor_05.jpg
[image-06]: /images/20240913_zigbee_custom_temperature_sensor_06.jpg
[image-07]: /images/20240913_zigbee_custom_temperature_sensor_07.jpg
