---
title: "Realizar acciones mediante plantillas en Home Assistant"
date: "2022-05-05"
creation: "2022-05-05"
description: "La acciones más complejas se pueden realizar en Home Assistant gracias al uso de plantillas."
thumbnail: "images/20220505_homeassistant_acciones_plantillas_00.jpg"
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
El editor visual de acciones en las automatizaciones de [Home Assistant] presenta muchas limitaciones. Encender o apagar una luz cuando lo hace otra o en función del estado de la puerta son dos de las que tengo implementadas.
<!--more-->
La primera alternativa que nos surge al intentar afrontar automatizaciones complejas es realizar varias automatizaciones simples. El método funciona pero resulta mucho más práctico hacer uso de plantillas que permitan acciones complejas. Ya he tratado anteriormente el tema de las [plantillas] en [Home Assistant] al escribir sobre los [sensores virtuales], ahora las voy a utilizar para el uso de acciones en automatizaciones

### Encender o apagar una luz cuando lo haga otra
Quiero que la luz "light.luces_del_salon" se enciendan o apaguen cuando lo haga "light.salon_lado_mesa" para lo cual he creado la siguiente automatización.

``` yaml
alias: Salón - Encender/Apagar Luces
description: ''
trigger:
  - platform: device
    type: changed_states
    device_id: 25748c26d934b4dce0acb58bde24ad75
    entity_id: light.salon_lado_mesa
    domain: light
condition: []
action:
  - service: >-
      light.turn_{{ 'on' if states ('light.salon_lado_mesa') == 'on' else 'off' }}
    target:
      entity_id: light.luces_del_salon
mode: single
```

En la acción podemos ver como se hará una llamada al servicio "light.turn_on" cuando el estado de "light.salón_lado_mesa" sea "on" y al servicio "light.turn_off" en caso contrario.

> Cuando con una línea se resuelve un problema es que este es pequeño o la línea es buena.

### Encender una luz al abrir de noche una puerta
Ahora quiero que la luz de la galería ("light.galeria") se encienda al abrir la puerta ("binary_sensor.galeria_puerta") si es de noche (Elevación del sol menor de 11º sobre el horizonte) y que se apague al cerrar la puerta.

``` yaml
alias: Galería - Luz automática
description: ''
trigger:
  - platform: state
    entity_id: binary_sensor.galeria_puerta
condition: []
action:
  - service: >-
      light.turn_{{ 'on' if state_attr('sun.sun','elevation') < 11 and
      states('binary_sensor.galeria_puerta') == 'on' else 'off' }}
    target:
      entity_id: light.galeria
mode: single
```

Ahora, se encenderá la luz mediante una llamada al servicio "light.turn_on" cuando se abra la puerta y el atributo "elevation" del sol "sun.sun" esté por debajo de 11. En caso contrario se llamará al servicio "light.turn_off" y consecuentemente apagará la luz de "light.galeria".


En mi repositorio de [GitHub] puedes encontrar todas las automatizaciones que actualmente tengo en uso en el archivo [automations.yaml]

[automations.yaml]: https://github.com/sherlockes/homeassistant/blob/master/automations.yaml
[GitHub]: https://github.com/sherlockes
[Home Assistant]: https://www.home-assistant.io
[plantillas]: https://www.home-assistant.io/docs/configuration/templating/
[sensores virtuales]: {{< relref "20210921_home_assistant_virtual_sensors_jinja2.md" >}}

[image-01]: /images/20220505_homeassistant_acciones_plantillas_01.jpg



