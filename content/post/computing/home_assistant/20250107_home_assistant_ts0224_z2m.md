---
title: "Activar sirena TS0224 mediante Z2M en Home assistant"
date: "2025-01-16"
creation: "2025-01-07"
description: "Como lanzar una publicación para activar o parar la sirena zigbee que uso en caso de alarma."
thumbnail: "images/20250107_ha_sirena_zigbee_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "zigbee"
- "z2m"
draft: false
weight: 5
---
Muchas veces, activar un elemento zigbee no es tan obvio en Home Assistant. Esta es la muestra de lo que tengo que hacer para hacer sonar la sirena zigbee que tengo instalada a modo de alarma.
<!--more-->
Este es la sirena que tengo instalada en el falso techo de casa para que suene si alguien entra a casa cuando está activada la alarma:

![image-01]

Usando la integración [ZHA] para [Home Asssistant] la he tenido funcionando sin problemas durante mucho tiempo, pero en el cambio a [Z2M] y con la reciente actualización a la versión 2.0 me he encontrado con el problema de que la integración no ofrece directamente la opción de activar la sirena.

![image-02]

Es posible encender la luz que lleva integrada pero no activar la sirena. Para hacerlo hay que recurrir directamente a la publicación de un "topic" mqtt mediante el servicio "mqtt.publish", del mismo modo habrá que hacer para desactivarla.

En mi caso la entidad se llama "pasillo_alarma" y estos son los topic a publicar para activar y desactivar la sirena.

Activar:
``` yaml
action: mqtt.publish
data:
  qos: "1"
  retain: false
  topic: zigbee2mqtt/pasillo_alarma/set
  payload: "{\"warning\": {\"mode\": \"burglar\"}}"
```

Parar:
``` yaml
action: mqtt.publish
data:
  qos: "1"
  retain: false
  topic: zigbee2mqtt/pasillo_alarma/set
  payload: "{\"warning\": {\"mode\": \"stop\"}}"
```

> Según la web de [Z2M], la sirena expone varios tipos de tonos y volúmenes aunque la que yo he comprado en [aliexpress] sólo reacciona a los comandos de activar y parar.

### Enlaces de interés
- [HA - Connect tuya siren](https://community.home-assistant.io/t/how-to-connect-the-zigbee-tuya-siren-ts0224-to-ha/668855/11)

[Home Assistant]: https://www.home-assistant.io
[aliexpress]: https://es.aliexpress.com/item/1005006115347609.html
[TS0224]: https://www.zigbee2mqtt.io/devices/TS0224.html
[ZHA]: https://www.home-assistant.io/integrations/zha/
[Z2M]: https://www.zigbee2mqtt.io

[image-01]: /images/20250107_ha_sirena_zigbee_01.jpg
[image-02]: /images/20250107_ha_sirena_zigbee_02.jpg



