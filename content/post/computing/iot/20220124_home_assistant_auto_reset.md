---
title: "Reseteo automático de Home assistant"
date: "2022-01-24"
creation: "2022-01-24"
description: "La forma que estoy empleando para resetear home assistant a diario"
thumbnail: "images/20220124_home_assistant_auto_reset_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "yaml"
draft: false
weight: 5
---
Por muy estable que sea un sistema, resetearlo de vez en cuando se suele venir bien y nos sirve para asegurar un correcto arranque. En mi caso hago que la Raspberry sobre la que corre [Home Assistant] se resetee todos los días a las cuatro de la mañana mediante una automatización que a continuación paso a detallar.
<!--more-->

Durante mucho tiempo he estado reseteando a diario la Raspberry mediante una tarea del cron que funciona bien y que dejé docuemntada en este [artículo] pero creo que la forma más controlada de resetear Home Assistant es desde el mismo mediante una automatización.

Para hacerlo más práctico uso un par de ayudantes, uno para definir si está habilitado o no el reseteo automático y otro para la hora del reseteo. Resulta más sencillo controlar estos parámetros que editar el crontab.

![image-01]

Con esto resulta sencillo crear una automatización que se ejecute a la hora definida por el ayudante de hora siempre y cuando esté activo el ayudante de habilitación. La acción a ejecutar será una llamada al servicio "hassio.host_reboot".

``` yaml
alias: Home Assistant - Reseteo diario
description: ''
trigger:
  - platform: time
    at: input_datetime.automatizacion_reseteo_hora
condition:
  - condition: state
    entity_id: input_boolean.automatizacion_reseteo_diario
    state: 'on'
action:
  - service: hassio.host_reboot
mode: single
```

### Enlaces de interés
- [Sherblog - Reinicios periódicos][artículo]

[artículo]: {{< ref "/post/computing/raspberry/20180501_raspberry_reinicios_periodicos.md" >}}
[Home Assistant]: https://www.home-assistant.io

[image-01]: /images/20220124_home_assistant_auto_reset_01.jpg
