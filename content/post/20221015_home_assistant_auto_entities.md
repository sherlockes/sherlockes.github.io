---
title: "Tarjetas inteligentes en Home Assistant"
date: "2022-10-16"
creation: "2022-10-15"
description: "Como crear y utilizar tarjetas inteligentes en Home assistant mediante auto-entities"
thumbnail: "images/20221015_home_assistant_auto_entities_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "hacs"
draft: true
weight: 5
---
Para que el contenido de una tarjeta del panel de control de [Home Assistant] sea dinámico y potenciar toda su funcionalidad, la forma más sencilla es mediante el uso de [auto-entities]
<!--more-->
El objetivo de hoy es sencillo, conseguir que la tarjeta que me muestra el estado de la batería de todos los equipos que utilizo en la domótica de casa se muestre ordenada según la batería disponible de cada uno de los equipos. Para esto voy a hacer uso de [auto-entities].

### Instalación de auto-entities
Gracias a [HACS] la instalación de [auto-entities] se realiza de forma muy sencilla. Accederemos al panel de control de HACS posteriormente el menú "Interfaz" y usaremos el botón de abajo "Explorar y descargar repositorios"

![image-01]

Buscaremos "auto-entities" en el cuadro de diálogo de la lupa e instalaremos la ultima versión disponible.

> Tras la instalación he tenido algún problema a la hora de incluir nuevas tarjetes, no tengo claro si hay que refrescar el navegador o acceder a [Dashboard Resources] y actualizar el módudo de javascript correspondiente a "auto entities".

### Tarjeta de baterías
Editamos el panel de control que deseemos y añadimos una nueva tarjeta mediante el botón "

![image-02]

Y este es el código que tengo incluido para añadir y ordenar todos los niveles de batería que tengo disponibles en [Home Assistant]

```yaml
type: custom:auto-entities
show_empty: false
card:
  type: entities
  title: Estado de baterías
  show_header_toggle: false
filter:
  include:
    - entity_id: '*battery_level*'
    - entity_id: '*_power*'
    - entity_id: '*_battery'
    - entity_id: '*_bateria'
  exclude:
    - entity_id: '*power_factor*'
    - entity_id: '*power_status*'
    - entity_id: '*_battery_power*'
sort:
  method: state
  reverse: false
  ignore_case: false
  numeric: true
```

He utilizado los filtros "include" y "exclude" para añadir o quitar las distintas entidades disponibles según e nombre de la entidad. Además, también está ordenado en modo numérico según el estado de cada una. El resultado es el siguiente.

![image-03]

### Tarjeta de luces encendidas
Otro uso interesante que he encontrado para [auto-entities] es la creación de una tarjeta de luces encendidas. En esta tarjeta se mostrarán sólo las luces que tenga encendidas en casa gracias a este simple código.

```yaml
type: custom:auto-entities
show_empty: false
card:
  type: entities
  title: Luces encendidas
filter:
  template: |
    {% for light in states.light %}
      {% if light.state == "on" %}
        {{ light.entity_id}},
      {% endif %}
    {% endfor %}
```
Con una simple plantilla se añaden a la tarjeta únicamente las luces (states.light) que están encendidas (light.state == "on"). Además gracias a la línea `show_empty: false` la tarjeta sólo se muestra cuando hay alguna luz encendida. Este el el aspecto de la tarjeta.




### Enlaces de interés
- [Thomas Loven - Lovelace plugins](https://github.com/thomasloven/hass-config/wiki/Lovelace-Plugins)
[Community Home Assistant - Auto-entities not working](https://community.home-assistant.io/t/lovelace-auto-entities-not-working-in-93-2/123807/6)

[auto-entities]: https://github.com/thomasloven/lovelace-auto-entities
[Dashboard Resources]: https://my.home-assistant.io/redirect/lovelace_resources
[HACS]: https://hacs.xyz
[Home Assistant]: https://www.home-assistant.io

[image-01]: /images/20221015_home_assistant_auto_entities_01.jpg
[image-02]: /images/20221015_home_assistant_auto_entities_02.jpg
[image-03]: /images/20221015_home_assistant_auto_entities_03.jpg


