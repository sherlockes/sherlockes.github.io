---
title: "Automatización de alumbrado con puerta"
date: "2021-12-02"
creation: "2021-12-02"
description: "Como he conseguido que se encienda la luz de la galería al abrir la puerta si es necesario."
thumbnail: "images/20210212_automatizacion_alumbrado_puerta_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "home assistant"
tags:
- "jinja2"
draft: false
weight: 5
---
Hacer una automatización para que se encienda una luz cuando se cierre una puerta y se apague al cerrarla es sencillo en [Home Assistant], la cosa se complica cuando quieres hacerlo de la forma más simple posible.
<!--more-->
A medida que los conocimientos de [Home Assistant] van aumentando no sólo eres capaz de hacer con el más cosas sino que además muchas veces se consigue hacerlo de forma más sencilla. Aquí dejo los métodos por los que he pasado en la creación de una automatización para que la luz de la galería se encienda al abrir la puerta siempre y cuando no haya luz solar.

> Como, de momento, no dispongo de un sensor de intensidad lumínica, he supuesto que el alumbrado de la galería sólo será necesario cuando el sol se encuentre en una elevación respecto al horizonte por debajo de los 15ª.

Las instancias de sensor y lus que tengo implementados en [Home Assistant] son las siguientes:
- binary_sensor.galeria_puerta
- light.luz_galería

### Método 1 - Las dos actualizaciones
Este método consta de dos automatizaciones, una para cuando se abre la puerta que enciende la luz si la altura del sol está por debajo de 15ª
```
alias: Galería - Luz (Encendido automático)
description: ''
trigger:
  - platform: state
    entity_id: binary_sensor.galeria_puerta
    to: 'on'
condition:
  - condition: numeric_state
    entity_id: sun.sun
    attribute: elevation
    below: '15'
action:
  - service: light.turn_on
    target:
      entity_id: light.luz_galeria
mode: single
```

Y otra para apagarla cuando se cierra la puerta
```
alias: Galería - Luz (Apagado automático)
description: ''
trigger:
  - platform: state
    entity_id: binary_sensor.galeria_puerta
    to: 'off'
action:
  - service: light.turn_off
    target:
      entity_id: light.luz_galeria
mode: single
```
Es un método sencillo que funciona pero no me gusta nada ver dos automatizaciones para hacer una sola cosa por lo que busco un método alternativo.

### Método 2 - Las acciones condicionales
[Home Assistant] permite insertar una condición dentro del flujo de una acción pero tiene una limitación y es que el flujo de una acción se detendrá en el momento que encuentre una condición que no se cumpla. Con esto se puede crear una acción que encienda siempre la luz al cambiar el estado de la puerta (Si la elevación del sol está por debajo de 15ª) pero que la vuelva a apagar si la puerta se ha cerrado.

```
alias: Galería - Luz automática
description: ''
trigger:
  - platform: state
    entity_id: binary_sensor.galeria_puerta
condition:
  - condition: numeric_state
    entity_id: sun.sun
    attribute: elevation
    below: '15'
action:
  - service: light.turn_on
    target:
      entity_id: light.luz_galeria
  - condition: state
    entity_id: binary_sensor.galeria_puerta
    state: 'off'
  - service: light.turn_off
    target:
      entity_id: light.luz_galeria
mode: single
```
Este es un método más simple que el anterior puesto que utilizamos una sóla automatización no deja de ser un tanto confuso al encender la luz para lego apagarla.

### Método 3 - Usando plantilla jinja2
Ya he utilizado las [plantillas de Home Assistant] en otras ocasiones como en el caso de los [sensores virtuales]({{<relref"20210921_home_assistant_virtual_sensors_jinja2.md">}}) de la increible potencia que proporcione el uso de [jinja2] como motor de las mismas.

En este caso utilizaremos la plantilla para definir con una sola acción si el servicio de la misma debe corresponder al encendido o apagado de la luz de la galería.

```
alias: Galería - Luz automática
description: ''
trigger:
  - platform: state
    entity_id: binary_sensor.galeria_puerta
action:
  - service: >-
      light.turn_{{ 'on' if state_attr('sun.sun','elevation') < 14 and
      states('binary_sensor.galeria_puerta') == 'on' else 'off' }}
    target:
      entity_id: light.luz_galeria
mode: single
```

Así nos ha quedado una automatización muy limpia y con la misma capacidad que las anteriores que no se si se podrá simplificar todavvía más.

### Enlaces de interés
[HA-Automation Actions](https://www.home-assistant.io/docs/automation/action/)  
[HA Community - One button, two lights](https://community.home-assistant.io/t/control-two-lights-with-one-button/180979/2)  
[HA Community - If then else](https://community.home-assistant.io/t/simple-if-then-else/216622/11)  


[Home Assistant]: https://www.home-assistant.io
[jinja2]: https://jinja2docs.readthedocs.io/en/stable/
[plantillas de Home assistant]: https://www.home-assistant.io/docs/configuration/templating/
