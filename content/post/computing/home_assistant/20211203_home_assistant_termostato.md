---
title: "El termostato de la caldera en Home Assistant"
date: "2021-12-30"
creation: "2021-12-03"
description: "Como he implementado en termostato de la caldera dentro de Home Assistant"
thumbnail: "images/20211203_home_assistant_termostato_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "ESP"
draft: false
weight: 5
---
La temporada pasada implementé desde cero mi propio termostato sobre la raspberry usando python, flask y muchas horas de desarrollo. Ahora he conseguido implementarlo desde cero en [Home Assistant] en menos de una hora gracias a [ESPHome].
<!--more-->

### Termostato
Tomaré como sensor la [DHT22] conectada al ESP32 del salón (En HA la tengo definida como "sensor.temperatura_salon") y como relé el conectado al [ESP01] de la caldera (En HA lo tengo definido como "switch.rele") que ya tengo creados gracias a [ESPHome]. Muy buenos resultados con unas pocas líneas de configuración que añadiremos al archivo "configuration.yaml"

```
climate:
  - platform: generic_thermostat
    name: Caldera
    heater: switch.rele
    target_sensor: sensor.temperatura_salon
    min_temp: 16
    max_temp: 24
    ac_mode: false
    target_temp: 19
    cold_tolerance: 0.2
    hot_tolerance: -0.1
    min_cycle_duration:
      seconds: 300
    keep_alive:
      minutes: 3
    initial_hvac_mode: "heat"
    away_temp: 16
    precision: 0.1
```
La utilidad de cada uno de los parámetros están definidos en la [configuración del termostato genérico] y ya esposible añadir una tarjeta de resumen con una apariencia como la siguiente.

![image-01]

### Ajustes avanzados
Ya tenemos la funcionalida básica, ahora vamos a dotarla de unas nuevas posibilidades.
- Ajuste de temperaturas "Cómoda" y "Eco"
- Disminución de la temperatura cuando no hay nadie en casa
- Establecer unas horas de "Levantarse" e "irse a dormir"
- Establecer un modo "Fuera de casa"

Para esto tengo creados unos ayudantes con los que conseguir estas caracterísicas y que son facilmente accesibles desde el resumen de [Home Assistant]

![image-02]

#### Ayudantes
Para el interruptor que indique a home assistant que estamos fuera de casa usaremos un interrutor booleano del tipo "alternar" que sólo permite encendido o apagado.

![image-03]

Le ponemos el nombre correspondiente, el icono de una casa saliendo y poco más hay que hacer con el.

Para la selección de temperaturas crearemos dos ayudantes de tipo número, uno para la temperatura "eco" y oro para la temperatura "cómoda".

![image-04]

Asignamos el nombre, el icono, los valores maximo y mínimo que se podrán introducir, el tamaño del paso y las unidades.

Para determinar cuales van a ser las horas a las que no levantamos y nos acostamos crearemos dos ayudantes de hora (Sólo hora).

![image-05]

Poner nombre, seleccionar que vamos a introducir una hora y ya está.

#### Cálculo de consigna
Podríamos crear unas cuantas automatizaciones a partir de los ayudantes anteriores para que se modificara la temperatura de la calefacción pero no me pareció que esta fuera una solución "elegante" por lo que he creado un sensor virtual que calcula el valor de temperatura al que tiene que estar la calefacción en función de los ayudantes anteriores y que está explicado en el apartado de [Cálculo de consigna].

#### Automatización
Con todo lo anterior, ya sólo resta crear una automatización bastante sencilla que lo único que haga sea modificar la temperatura de la calefacción cuando la consigna cambie.

``` yaml
alias: Caldera - Establecer consigna
description: ''
trigger:
  - platform: state
    entity_id: sensor.consigna_caldera
condition: []
action:
  - service: climate.set_temperature
    data_template:
      entity_id: climate.caldera
      temperature: '{{ states.sensor.consigna_caldera.state }}'
mode: single
```



[Cálculo de consigna]: /sensores-virtuales-y-jinja2-en-home-assistant/#sensor-de-consigna-de-temperatura
[ESPHome]: https://esphome.io
[Home Assistant]: https://www.home-assistant.io
[ESP01]: /esphome-en-home-assistant/#esp-01-con-rel%C3%A9-de-un-canal
[DHT22]: /esphome-en-home-assistant/#esp-wroom-32-con-sensor-de-temperatura
[termostato genérico]: https://www.home-assistant.io/integrations/generic_thermostat/

[image-01]: /images/20211203_home_assistant_termostato_01.jpg
[image-02]: /images/20211203_home_assistant_termostato_02.jpg
[image-03]: /images/20211203_home_assistant_termostato_03.jpg
[image-04]: /images/20211203_home_assistant_termostato_04.jpg
[image-05]: /images/20211203_home_assistant_termostato_05.jpg
