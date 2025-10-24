---
title: "Controlando un Tasmota remoto desde Home Assistant"
date: "2025-10-24"
creation: "2025-10-23"
description: "El método que he utilizado para controlar un enchufe inteligente con Tasmota desde Home Assistant gracias a Zerotier y una máquina de salto"
thumbnail: "images/20251023_home_assistant_remote_tasmota_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "zerotier"
- "tasmota"
- "bash"
draft: false
weight: 5
---
Tengo problemas con el [SLZB-06] de mi segunda residencia cuando se va la luz, así es como lo he solucionado gracias a un enchufe inteligente.
<!--more-->
Cada vez que se produce un microcorte del suministro eléctrico en mi segunda residencia se reinician el router que conecta a internet y el [SLZB-06] que controla la red de dispositivos zigbee. Como consecuencia, la instalación de [Home Assistant] que tengo en mi vivienda habitual deja de verlos y ,tras unos intentos fallidos, el complemento de [Z2M] que vigila el coordinador zigbee se queda parado. Al recuperar el suministro eléctrico, los dos dispositivos arrancan de nuevo pero [Z2M] no es capaz de conectar con el [SLZB-06]. Llegados a este punto hay dos posibilidades:
 - Puedo, a través del navegador, acceder al panel de control web del [SLZB-06]. Lo reinicio, espero un poco y reinicio el complemento de [Z2M] que estaba en fallo en [Home Assistant].
 - No es posible acceder al panel de control web del [SLZB-06] y necesito un reinicio forzado quitando la alimentación del dispositivo.
 
La primera opción es molesta pero sólo supone dos minutos corregirla. El problema real lo tengo con la segunda opción ya que no tengo acceso físico al [SLZB-06] por estar en esta segunda residencia.

La solución parece sencilla, alimentar el [SLZB-06] con un enchufe inteligente que pueda apagar y encender para "resetear" el coordinador zigbee cuando lo necesite. Atención, el enchufe no puede ser zigbee, ya que podría apagarlo pero... ¿Quien va a encenderlo si el coordinador que le tiene que transmitir la orden está apagado? Por esto me veo obligado a utilizar un enchufe wifi (Cruzaremos los dedos por que este sea capaz de conectarse al router tras un microcorte) y para poder controlarlo desde Home Assistant sin depender de una nube de terceros he optado por un [modelo] con [Tasmota] preinstalado.

![image-01]

Con el enchufe montado, con IP local 192.168.1.32 que no he sido capaz de poner fija desde el panel de control de Tasmota y sin ningún tipo de seguridad, de momento, podemos controlarlo desde cualquier navegador dentro de la red local. Ahora llega el reto, controlarlo desde el [Home Assistant] de mi residencia habitual.

En [Tasmota] no se permite de forma nativa la conexión VPN mediante [Wireguard] que empleo para la conexión remota del [SLZB-06] por lo que voy a recurrir al uso de una Raspberry como máquina de salto y [Zerotier] como método de conexión a la misma.

Mi objetivo es ahora crear en Home Assistant un interruptor que, a través de esa Raspberry remota, pueda encender, apagar y consultar el estado real del Tasmota, todo a través del túnel [Zerotier].

Empecé probando con combinaciones de switch: y shell_command:, intentando usar comandos SSH definidos externamente, pero Home Assistant no permitía referenciarlos directamente desde command_line. También intenté crear sensores intermedios para el estado, pero no terminaban de registrarse correctamente.
Finalmente, la solución ha llegado con la integración moderna command_line, que desde las versiones recientes de [Home Assistant] permite declarar un bloque único con distintos tipos de entidades (sensor, switch, etc.) sin necesidad de plataformas separadas.

El bloque final que he implementado ha quedado así:

``` yaml
command_line:
  - switch:
      name: Enchufe remoto CO
      unique_id: co_enchufe_tasmota
      command_on: >
        ssh -i /config/ssh/id_rsa -o StrictHostKeyChecking=no \
        pi@192.168.191.205 "curl -s 'http://192.168.1.32/cm?cmnd=Power%20On'"
      command_off: >
        ssh -i /config/ssh/id_rsa -o StrictHostKeyChecking=no \
        pi@192.168.191.205 "curl -s 'http://192.168.1.32/cm?cmnd=Power%20Off'"
      command_state: >
        ssh -i /config/ssh/id_rsa -o StrictHostKeyChecking=no \
        pi@192.168.191.205 "curl -s 'http://192.168.1.32/cm?cmnd=Power'"
      value_template: >
        {{ value_json.POWER == 'ON' }}
      command_timeout: 10
      scan_interval: 600
```
Tras un reinicio de [Home Assistant] ya queda el interruptor listo para funcionar.

Con esta configuración, Home Assistant ejecuta los comandos SSH hacia la Raspberry remota (192.168.191.205), que a su vez lanza las peticiones HTTP al enchufe Tasmota (192.168.1.32).
Gracias al túnel de Zerotier, todo ocurre dentro de una red privada virtual, sin abrir puertos ni depender de IPs públicas.

El interruptor ahora enciende, apaga y refleja el estado real del enchufe con un retardo mínimo. Además, scan_interval permite que el estado se actualice automáticamente cada cierto tiempo por si el dispositivo se cambia manualmente, para evitar demasiadas consultas lo he dejado en "600" segundos.



### Enlaces de interés
- [command_line](https://www.home-assistant.io/integrations/command_line/)

[Home Assistant]: https://www.home-assistant.io
[modelo]: https://es.aliexpress.com/item/1005009316915168.html
[SLZB-06]: https://smlight.tech/product/slzb-06
[Wireguard]: https://www.wireguard.com
[Zerotier]: https://www.zerotier.com
[Z2M]: https://www.zigbee2mqtt.io

[image-01]: /images/20251023_home_assistant_remote_tasmota_01.jpg



