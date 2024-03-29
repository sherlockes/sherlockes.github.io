---
title: "Automatizando las luces del salón"
date: "2024-03-25"
creation: "2024-03-12"
description: "Como tengo organizado el funcionamiento de las luces del salón mediante el uso de acciones y triggers id."
thumbnail: "images/20240312_home_assistant_living_room_lights_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "jinja2"
- "yaml"
draft: false
weight: 5
---
Esta es la forma en la que tengo dispuesto el funcionamiento de las luces del salón mediante una sola automatización dentro de [Home Assistant].
<!--more-->
En el salón hay tres puntos de luz
- En el centro
- Sobre la mesa de hacer las comidas
- Sobre el sofá de ver la TV

Tanto en la posición del centro del salón como en la de la mesa tengo una lámpara con tres gu10 alimentada cada una mediante un módulo zigbee parecido a este.

![image-01]

En la posición de encima del sofá hay una misma lámpara que está alimentada continuamente y montadas en ella tres bombillas de [Ikea] como esta

![image-02]

El primer paso es crear un grupo con las tres bombillas del sofá que queda declarado dentro del archivo de configuración "configuration.yaml" de la siguiente forma

``` yaml
light:
    - platform: group
      unique_id: hom_salon_sofa
      name: Luz del sofá del salón
      entities:
        - light.sofa_bombilla_1
        - light.sofa_bombilla_2
        - light.sofa_bombilla_3
```
Con esto ya tenemos declarado el grupo "light.salon_sofa" con las tres bombillas.

![image-03]

El siguiente paso es crear un nuevo grupo, también dentro del archivo "configuration.yaml" y el apartado "light" en el que quedarán englobadas todas las luces del salón.

``` yaml
light:
    - platform: group
      unique_id: hom_salon
      name: Luz del salón
      entities:
        - light.salon_mesa
        - light.salon_centro
        - light.salon_sofa
```

En el salón hay un único interruptor que está conectado al módulo de la lámpara del centro por lo que, la activación del mismo sólo y en un primer momento, sólo modifica el estado de dicha lámpara. Por otro lado, hay un control total de todas las luces mediante el "Echo Dot" instalado en el mueble de la TV de forma que:

- "Alexa, enciende la luz del sofá" enciende las tres GU10 de Ikea.
- "Alexa, enciende la luz de la mesa" enciende el módulo de la mesa.
- "Alexa, enciende la luz del centro" activa el módulo central.
- "Alexa, enciende las luces del salón", enciende todas las luces.

A partir de aquí es cuando voy a automatizar algunos comportamientos para hacer el control de las luces más sencillo. Recientemente leí un post de [Aguacatec] sobre las automatizaciones mediante "Trigger id" que resulta muy práctico para aglutinar en una solo automatización varios disparadores y varias acciones. En este caso tengo varios disparadores para los que tengo que crear una plantilla:

#### Que se apague la luz del centro
Cuando se apague la luz del centro quiero que se apaguen todas las luces si la TV está apagada o que sólo deje la del sofá de forma tenue cuando la TV está encendida. No he sido capaz de crear un disparador mediante una plantilla que sea capaz de diferenciar si la TV está encendida o apagada en el momento que se apaga la luz central así que lo he programado en la condición de la acción.

Para definir cuando la luz es suficiente con la siguiente plantilla:

``` yaml
{{ states("light.salon_centro") == "off" ) }}
```

Posteriormente, en las acciones definidas para este disparador, incluiremos la condición de que si la TV está encendida o apagada para efectuar unas u otras acciones.

#### Que se encienda la luz del sofá al mismo tiempo que alguna otra
Para los casos en los que se encienden todas las luces del salón, la del sofá debe hacerlo con el mismo tono frío que el resto y al 100% de potencia para que la iluminación queda más homogénea. He creado un disparador con la siguiente plantilla:

``` yaml
{{ states("light.salon_sofa") == "on" and ( states("light.salon_mesa") ==
      "on" or states("light.salon_centro") == "on" ) }}
```

Ha quedado anidado un "o" con las dos luces que no son del sofá con un "y" a la luz del sofá.

#### Que sólo esté encendida la luz del sofá
Si sólo encendemos la luz del sofá, está lo hará en un tono cálido y al 50% de potencia, esto lo evaluamos con el siguiente disparador

``` yaml
{{ states("light.salon_sofa") == "on" and states("light.salon_mesa") ==
      "off" and states("light.salon_centro") == "off" }}
```


### Automatización completa
Con las plantillas de los disparadores definidas, las incluiremos dentro de cada uno de ellos con su identificación correspondiente y se crearán las acciones para cada una de estas identificaciones.

La automatización completa quedaría así:

``` yaml
alias: Salón - Luces
description: ""
trigger:
  - platform: template
    value_template: >-
      {{ states("light.salon_sofa") == "on" and ( states("light.salon_mesa") ==
      "on" or states("light.salon_centro") == "on" ) }}
    id: sofa_blanca
    alias: Se enciende la luz del sofá con alguna más
  - platform: template
    value_template: >-
      {{ states("light.salon_sofa") == "on" and states("light.salon_mesa") ==
      "off" and states("light.salon_centro") == "off" }}
    id: solo_tv
    alias: Sólo la luz del sofá
    enabled: true
  - platform: state
    entity_id:
      - light.salon_centro
    from: "on"
    to: "off"
    id: apagar_centro
    enabled: true
    alias: Se apaga la luz del centro
condition: []
action:
  - choose:
      - conditions:
          - condition: trigger
            id:
              - apagar_centro
          - condition: state
            entity_id: media_player.living_room_tv
            state: "off"
        sequence:
          - service: light.turn_off
            target:
              area_id: salon
            data: {}
        alias: Se apaga el centro con la TV apagada
      - conditions:
          - condition: trigger
            id:
              - apagar_centro
          - condition: state
            entity_id: media_player.living_room_tv
            state: "on"
        sequence:
          - service: light.turn_off
            metadata: {}
            data: {}
            target:
              entity_id:
                - light.salon_centro
                - light.salon_mesa
          - service: light.turn_on
            target:
              entity_id: light.salon_sofa
            data:
              kelvin: 2000
              transition: 20
              brightness_step_pct: 40
        alias: Se apaga el centro con la TV encendida
      - conditions:
          - condition: trigger
            id:
              - sofa_blanca
        sequence:
          - service: light.turn_on
            target:
              entity_id: light.salon_sofa
            data:
              kelvin: 6500
              brightness_step_pct: 100
        alias: Se enciende alguna luz además de la del sofá
      - conditions:
          - condition: trigger
            id:
              - solo_tv
        sequence:
          - service: light.turn_on
            target:
              entity_id: light.salon_sofa
            data:
              kelvin: 2000
              transition: 20
              brightness_step_pct: 40
        alias: Se enciende sólo la luz del sofá
mode: single
```



### Enlaces de interés
- [Community Home Assistant - Domain trigger automation](https://community.home-assistant.io/t/triggering-automation-if-certain-domain-entities-change-state/243869/5)

[Home Assistant]: https://www.home-assistant.io
[Ikea]: https://www.ikea.com/es/es/p/tradfri-bombilla-led-gu10-345lm-inteligente-regulac-lumin-inalambr-espectro-blanco-50547413/
[Aguacatec]: https://aguacatec.es/mejorar-tus-automatizaciones-con-el-trigger-id/

[image-01]: /images/20240312_home_assistant_living_room_lights_01.jpg
[image-02]: /images/20240312_home_assistant_living_room_lights_02.jpg
