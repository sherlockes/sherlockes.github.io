---
title: "Convertir una luz en interruptor en Home Assistant"
date: "2023-12-12"
creation: "2023-12-12"
description: "Un sencillo método para converir entidades de tipo luz a interruptor en Home Assistant usando zha"
thumbnail: "images/20231212_home_assistant_light_to_switch_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
tags:
- "zigbee"
draft: true
weight: 5
---
Es posible utilizar un módulo zigbee de luces como si fuera un enchufe cableado, el problema aparece cuando intentas encender o apagar todas las luces de un área en la que lo tienes incluido y se activa al son de las bombillas.
<!--more-->
Recientemente he colocado un relé zigbee controlando la electroválvula que corta el paso se agua caliente para la calefacción de casa que se encuentra situada en el pasillo. [Home Assistant] ha detectado el módulo como una entidad de tipo "light" y me he encontrado con el problema de que cuando enciendo o apago todas las luces del pasillo tambien se activa esta electroválvula dejando paso al agua caliente de la calefacción.

Tengo integrados todos mis elementos zigbee mediante [zha] y gracias al enlace que dejo abajo he conseguido cambiar la entidad de tipo "light" a tipo "switch".

En primer lugar buscamos el dispositivo que queremos modificar y desplegamos la información zigbee

![image-01]

Es necesario el valor de "IEEE" formado por ocho pares de dígitos. Además usaremos el "Endpoint id".

> En la mayoría de ocasiones el "Endpoint id" es 1, tan sólo en módulos con más de un contacto integrado este carácter variará.

Para averiguarlo desplegamos el menú de información del dispositivo y seleccionamos la opción "Administrar dispositivo Zigbee"

![image-02]

En la información de los clústeres vemos que en mi caso en "Endpoint id" corresponde a 1.

Ahora en el archivo "configuration.yaml" añadimos la siguientes líneas y reiniciamos [Home Assistant].

```yaml
zha:
  device_config:
    a4:c1:38:39:10:48:03:71-1:
      type: "switch"
```

Ya tenemos declarado nuestro módulo como entidad de tipo "switch".

![image-03]

### Enlaces de interés
- [Home Assistant - Modifying device](https://community.home-assistant.io/t/zigbee-modifying-the-device-type/349830)

[Home Assistant]: https://www.home-assistant.io
[zha]: https://www.home-assistant.io/integrations/zha/

[image-01]: /images/20231212_home_assistant_light_to_switch_01.jpg
[image-02]: /images/20231212_home_assistant_light_to_switch_02.jpg
[image-03]: /images/20231212_home_assistant_light_to_switch_03.jpg



