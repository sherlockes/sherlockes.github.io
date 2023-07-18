---
title: "HA - Temporizador para luz"
date: "2021-10-04"
creation: "2021-10-04"
description: "Un método sencilo para crear un temporizador con el que apagar una luz de forma automática transcurrido un determindado tiempo."
thumbnail: "images/20211004_home_assistant_temporizador_luz_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
draft: false
weight: 5
---
Programar el apagado automático transcurrido un tiempo desde que ha sido encendido de cualquier alumbrado con Home Assistant se convierte en una labor absurdamente sencilla.
<!--more-->

Todas las mañanas aparece encendida la luz del cuarto de los niños cuando estos todavía no se han despertado, si alguno se despierta por la noche enciende la luz y se queda encendida hasta que nos despertamos.

Para evitar esto tengo creada una automatización en Home Assistant cuya única misión es apagar la luz si esta lleva encendida más de quince minutos a partir de las diez de la noche.

```
alias: Chicos - Límite luz noche
description: Apaga la luz después de 15 min encendida a partir de la diez de la noche
trigger:
  - platform: device
    type: turned_on
    device_id: befc0a6691c026949aff7f923ca5cc5e
    entity_id: light.luz_de_los_chicos
    domain: light
    for:
      hours: 0
      minutes: 15
      seconds: 0
      milliseconds: 0
condition:
  - condition: time
    after: '22:30'
    before: '08:00'
action:
  - service: light.turn_off
    target:
      entity_id: light.luz_de_los_chicos
mode: single
```

Si no te apañas con el formato yaml, a continuación puedes ver unos pantallazos de como está mi automatización realizada con el asistente.

![image-01]

[image-01]: /images/20211004_home_assistant_temporizador_luz_01.gif
