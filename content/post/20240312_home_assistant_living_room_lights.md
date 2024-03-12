---
title: "Título"
date: "2024-03-12"
creation: "2024-03-12"
description: "Descripción"
thumbnail: "images/20240312_home_assistant_living_room_lights_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: true
weight: 5
---
Resumen de introducción
<!--more-->

``` yaml
alias: Salón - Luces
description: ""
trigger:
  - platform: template
    value_template: >-
      {{ states("media_player.living_room_tv") == "off" and
      states("light.salon_centro") == "off" }}
    id: apagar_todas
    alias: Se apaga el centro con la TV apagada
  - platform: template
    value_template: >-
      {{ trigger.event.data.entity_id.startswith('light') and
      states("media_player.living_room_tv") == "on" and
      states("light.salon_centro") == "off" }}
    alias: Se apaga el centro con la TV encendida
    id: solo_tv
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
condition: []
action:
  - choose:
      - conditions:
          - condition: trigger
            id:
              - apagar_todas
        sequence:
          - service: light.turn_off
            target:
              area_id: salon
            data: {}
      - conditions:
          - condition: trigger
            id:
              - solo_tv
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
mode: single
```

![image-01]

### Enlaces de interés
- [Community Home Assistant - Domain trigger automation](https://community.home-assistant.io/t/triggering-automation-if-certain-domain-entities-change-state/243869/5)

[link]: https://www.google.es

[image-01]: /images/20240312_home_assistant_living_room_lights_01.jpg



