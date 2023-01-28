---
title: "Home Assistant - Wake on Lan Synology"
date: "2021-06-27"
creation: "2021-06-27"
description: "Como enciendo (y apago) en NAS de Synology mediante un interruptor en Home Assistant"
thumbnail: "/images/20210627_home_assistant_wake_on_lan_synology_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
- "iot"
tags:
- "synology"
draft: false
weight: 5
---
Mi NAS no está siempre encendido, arranca todos los días a una hora programada, si quiero hacerlo antes he implementado un interruptor en [Home Assistant] para encenderlo o apagarlo. Aquí dejo la forma en la que lo he realizado.
<!--more-->
Para llevar a cabo este encendido remoto del NAS mediante [Home Assistant] hay que tener en cuenta las siguientes condiciones previas.

- La máquina sobre la que corre [Home Assistant] y el propio NAS deben estar conectados en la misma red local.
- Tener instalado el complemento [File Editor] en [Home Assistant]
- Tener instalada y configurada para nuestro NAS la integración [Synology DSM] en [Home Assistant]

Con todo lo anterior, ya estamos en condiciones de utilizar la integración [wake on lan] de [Home Assistant]. Para eto sólo hay que abrir el archivo "configuration.yaml" y añadir las siguientes líneas.

``` yaml
# Ds920+ On/Off
switch:
  - platform: wake_on_lan
    name: Ds920+
    mac: 03:41:a2:g5:c5:31
    host: 192.168.10.200
    turn_off:
      service: synology_dsm.shutdown
```

Donde tendremos que modificar la "mac" y "host" (ip) por los de nuestro NAS.

> Si no tienes muy claro como averiguar estos valores, te invito a leer pi post sobre [montaje y ssh de raspberry] donde lo tengo bien explicado.

Ahora sólo resta añadir en la tarjeta que deseemos una nueva entidad que será el propio interruptor

![image-01]

Si le personalizamos el icono queda perfecto.

![image-02]

> Como característica extra, hay que relleñar que la integración es capaz de detectar cuando el NAS está arrancado y muestra el estado en el interruptor aunque no haya sido el propio [Home Assistant] el que haya dado la orden.


[File Editor]: https://github.com/home-assistant/addons/tree/master/configurator
[Home Assistant]: https://www.home-assistant.io
[montaje y ssh de raspberry]: https://sherblog.pro/raspberry-montaje-y-ssh/
[Synology DSM]: https://www.home-assistant.io/integrations/synology_dsm
[wake on lan]: https://www.home-assistant.io/integrations/wake_on_lan/

[image-01]: /images/20210627_home_assistant_wake_on_lan_synology_01.jpg
[image-02]: /images/20210627_home_assistant_wake_on_lan_synology_02.jpg
