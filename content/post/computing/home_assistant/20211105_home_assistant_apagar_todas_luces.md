---
title: "Apagar todas las luces en Home Assistant"
date: "2021-11-05"
creation: "2021-11-05"
description: "Unos métodos para apagar todas las luces en Home assistant"
thumbnail: "images/20211105_home_assistant_apagar_todas_luces_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "iot"
- "home assistant"
tags:
- "hue"
- "zigbee"
draft: false
weight: 5
---
Cuando no todas las luces automatizadas de casa son bombillas inteligentes la labor de apagarlas todas al mismo tiempo requiere alguna solución un poco más trabajada como las que muestro a continuación.
<!--more-->

## Todas a un mismo panel
Sin duda alguna, la forma más sencilla de apagar todas la luces al mismo tiempo es incluirlas en un panel del resumen y que se muestre en el el "interruptor de encabezado". Así tendremos un botón con el que podemos encender o apagar todas las luces al mismo tiempo.

![image-01]

Rápido y sencillo, aunque presenta un gran problema y es que no he sido capaz de hacer una llamada a este botón desde una automatización por lo que, aunque puede resultar útil, no es una solución suficiente.

## Hacer un grupo genérico
Dentro del archivo "groups.yaml" hay que crear un nuevo grupo compuesto por todas las luces de casa, tanto bombillas inteligentes como interruptores o enchufes que quedará algo como lo siguiente:

```
todas_luces:
  name: Todas las luces
  entities:
    - light.una_luz_de_papas
    - light.otra_luz_de_papas
    - light.una_luz_del_salon
    - light.otra_luz_del_salon
    - light.luz_del_ordenador
    - switch.bano_luz
    - switch.cocina_luz
    - switch.galeria_luz
```
> Si no tienes el archivo "groups.yaml" hay que crear uno y asegurarse que en el archivo "configuration.yaml" existe una llamada al mismo mediante la línea "group: !include groups.yaml"

Reiniciamos el servidor de Home Assistant y ya tendremos creado un grupo para todas las luces pero con una peculiaridad y es que no es un grupo de luces sino que es un grupo genérico con luces e interruptores. Por esto último, a la hora de apagar todos los elementos del grupo, en la automatización no deberemos llamar al servicio "lights.turn_off" sino a "homeassistant.turn_off" tal y como se puede ver en la siguiente imagen.

![image-02]

## Declarar como luces y hacer un grupo
Todavía podemos ir un paso más allá para no tener que crear un grupo genérico si declaramos como luces dentro de la configuración de Home Assistant los interruptores y enchufes que estamos utilizando para manejar aparatos de iluminación. Para esto, incluiremos dentro de apartado "light:" (Si no lo tiene lo crearemos) del archivo "configuration.yaml"

```
light:
    - platform: switch
      name: Luz del baño
      entity_id: switch.bano_luz
      
    - platform: switch
      name: Luz de la cocina
      entity_id: switch.cocina_luz
```

Una vez que hayamos incluido todos los enchufes e interruptores en el archivo de configuración es buen momento para reiniciar el servidor. Tras restablecerse comprobaremos el nombre que Home Assistant ha asignado al equivalente como luces de los interruptores.

> Podemos buscar la entidad que se ha creado desde el menú de "Herramientas para desarrolladores" o en "Configuración-Entidades" sin más que comenzar escribiendo "light." y buscar entre los resultados encontrados.

Ahora ya es posible crear un grupo de luces dentro del apartado "light:" del archivo "configuration.yaml" con todas las luces que ya teníamos y las que ahora hemos creado a partir de interruptores.

```
light:
    - platform: group
      name: Todas las luces
      entities:
        - light.una_luz_de_papas
        - light.una_luz_del_salon
        - light.luz_del_ordenador
        - light.luz_bano
        - light.luz_cocina
```

La automatización que creemos para apagar todas las luces ahora si podrá llamar al servicio "lights.turn_off" y controlar todas las luces.

![image-03]

## Enlaces de utilidad
[Cyan-Automation][]
[HA - Light group][]
[HA - Light switch][]

[image-01]: /images/20211105_home_assistant_apagar_todas_luces_01.jpg
[image-02]: /images/20211105_home_assistant_apagar_todas_luces_02.jpg
[image-03]: /images/20211105_home_assistant_apagar_todas_luces_03.jpg

[Cyan-Automation]: https://cyan-automation.medium.com/using-home-assistant-to-turn-off-all-smart-lights-in-your-home-e8341e2ac396
[HA - Light group]: https://www.home-assistant.io/integrations/light.group
[HA - Light switch]: https://www.home-assistant.io/integrations/light.switch
