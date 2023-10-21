---
title: "Mostrar dispositivos no disponibles en Home Assistant"
date: "2023-10-21"
creation: "2023-10-21"
description: "Una forma sencilla y rápida de mostrar los dispositivos que tenemos que reconfigurar pos que han quedado fuera de servicio."
thumbnail: "images/20231021_zigbee_devices_not_available_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "zigbee"
- "jinja2"
draft: flase
weight: 5
---
De vez en cuando, hay dispositivos [Zigbee] que dejan de estar disponibles para [Home Assistant] y hay que volver a configurarlos, con esta sencilla tarjeta podremos ver cuales son y así no tener duda de que es lo que falla.
<!--more-->
Una vez más hago uso de plantillas en [Jinja2] para llevar a cabo una automatización en [Home Assistant]. Esta vez introducimos la plantilla dentro de una tarjeta del tipo "Markdown" que incluiremos en nuestro "Dashboard".

![image-01]

Para conectar todos los dispositivos [Zigbee] que tengo en casa uso la integración [zha] por lo que el objetivo de este artículo es que buscar los dispositivos de esta integración que no están disponibles.

Después de unas horas de investigación he conseguido crear esta plantilla:

``` jinja
{% set zigbee = namespace(unavailable=[]) %}
{% for entity in integration_entities('zha') %}
  {% if states(entity) == 'unavailable' %}
    {% set nombre = device_attr(device_id(entity), 'name_by_user') %}
    {% if nombre not in zigbee.unavailable %}
      {% set zigbee.unavailable = zigbee.unavailable + [nombre] %}
    {% endif %}
  {% endif %}
{% endfor %}
{{ zigbee.unavailable }}
```

Son apenas diez líneas pero con mucha "miga" detrás y su funcionamiento es el siguiente:
- Genera una matriz "zigbee.unavailable" donde almacenar una lista de deshabilitados
- Recorre mediante un bucle "for" todos los dispositivos de la integración "zha"
- Si el estado del dispositivo es "unavailable" sigue adelante
- Extrae la id del dispositivo mediante "device_id(entity)"
- Extrae el atributo del nombre asignado por el usuario a partir de la id
- Si el nombre no está dentro de la matriz "zigbee.unavailable" sigue adelante
- Añade el nombre como un nuevo elemento de la matriz "zigbee.unavailable"
- Muestra los resultados

El siguiente paso lógico es obvio, Crear un sensor virtual o un ayudante a partir de la plantilla anterior y crear una automatización de forma que cuando se modifique el valor de esta enviar un mensaje como que esto ha ocurrido.

Va a resultar más práctico un ayudante o sensor virtual que, en lugar de una lista con los dispositivos que hay no disponibles, muestre el simplemente el número de ellos. Para esto he creado un ayudante a partir de la plantilla anterior en el que sólo cambia la última línea por la siguiente:

``` jinja
{{ zigbee.unavailable | length }}
```

A partir de este ayudante que he llamado "zigbee_devices_ko" no hay ninguna complicación en crear una automatización que, cuando cambie el valor de este y sea mayor que cero, nos envíe una notificación a la aplicación de [Home Assistant] del teléfono.

``` yaml
alias: Zigbee no disponibles
description: ""
trigger:
  - platform: state
    entity_id:
      - sensor.zigbee_devices_ko
condition:
  - condition: numeric_state
    entity_id: sensor.zigbee_devices_ko
    above: "0"
action:
  - service: notify.notify
    data:
      title: Dispositivos zigbee no disponibles
      message: Algo ha cambiado, revisa la lista de dispositivos no disponibles.
mode: single
```

### Enlaces de interés
- [GitHub - Allow list.append in jinja2](https://github.com/home-assistant/core/issues/33678)
- [Home Assistant - Automation conditions](https://www.home-assistant.io/docs/automation/condition/)
- [Home Assistant - Append item to list in Template](https://community.home-assistant.io/t/solved-how-to-append-items-to-list-using-template/309899)
- [Home Assistant - Enumerate entities](https://community.home-assistant.io/t/how-to-enumerate-entities-belonging-to-an-integration/343748/12)


[Home Assistant]: https://www.home-assistant.io
[Jinja2]: https://codeburst.io/jinja-2-explained-in-5-minutes-88548486834e
[zha]: https://www.home-assistant.io/integrations/zha/
[Zigbee]: https://es.wikipedia.org/wiki/Zigbee

[image-01]: /images/20231021_zigbee_devices_not_available_01.jpg



