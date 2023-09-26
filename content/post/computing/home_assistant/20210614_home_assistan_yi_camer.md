---
title: "Yi Home Camera en Home Assistant"
date: "2021-06-14"
creation: "2021-06-14"
description: "Como he integrado la cámara Yi Home 1080 en home assistant"
thumbnail: "/images/20210614_home_assistan_yi_camer_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "home assistant"
- "iot"
tags:
- "mqtt"
draft: false
weight: 5
---
No todo es "Plug & Play" en [Home Assistant], aquí dejo lo que ha sido el proceso de configuración de la cámara para interior [Yi Home 1080], una cámara sencilla y barata pero que ofrece muchas posibilidades con un firmware alternativo.
<!--more-->
Tras una prueba frustrada con la cámara [Yi Dome Guard] me encuentro probando con la [Yi Home 1080] que he encontrado en Aliexpress por poco más de 15 €.

![image-01]

### Instalación del firmware [Yi-Hack Allwinner-v2]
Para poder integrar la cámara con [Home Assistant] es necesario instalarle un firmware alternativo para lo cual hay que seguir los siguientes pasos:

1. Hacer funcionar la cámara siguiendo las instrucciones del fabricante
2. Insertar una tarjeta MicroSd y formatearla desde la app [Yi Home]
3. Descargar el firmware alternativo [Yi-Hack Allwinner-v2]

> A la hora de escoger la versión de firmware que vamos a instalar hay que tener en cuenta el nº de serie de la cámara. Esta identificación se encuentra en la etiqueta trasera de la caja.

4. Cargar el firmware en la MicroSd y reiniciar la cámara
5. Acceder al panel de control en http://ip_de_la_camara:8080
6. Desde el menú "Configurations" añadir un nuevo usuario y pass de root
7. Guardar la configuración (Configurations) y reiniciar la cámara (Maintenance)

![image-02]

> Aunque en la documentación de [Yi-Hack Allwinner-v2] indica que esta inclusión de la contraseña hay que realizarla a través de una conexión telnet, a mi me ha dado problemas de permisos y la he realizado a través del panel de control web.

### Integración en Home Assistant
En este punto, yo no he sido capaz de, mediante la documentación oficial de [Yi Home cameras], de visualizar la cámara en [Home Assistant]. Como si me ha funcionado es mediante la integración del protocolo [onvif] pero con el modo que he obtenido mayor funcionalidad es mediante la integración personalizada del propio creador de [Yi-Hack Allwinner-v2]

#### Instalación de mosquitto
Para el correcto funcionamiento de la integración debemos disponer en nuestra red de un broker de mqtt que gestione las comunicaciones. Lo más sencillo es instalar mosquitto en la propia Raspberry siguiendo este post de [domology].

En el post de configuración de mosquitto se hace referencia a la necesidad de que [Home Assistant] espere a que mosquitto esté cargado para ejecutarse. En mi caso, la [instalacion de Home Assistant] corre dentro de un contenedor por lo que he editado el archivo "/etc/systemd/system/hassio-supervisor.service" modificando la siguiente línea:

```
After=docker.service dbus.socket network.target mosquitto.service
```

#### Instalación de la integración personalizada
1. Copiar en "Custom components" la carpeta descargada de [Yi-Hack HA integration]
2. Reiniciar [Home Assistant]
3. Añadir la integración "yi_hack"
4. Insertar IP de la cámara y usuario y pass generados al cambiar el firmware
5. Seleccionar la habitación
6. Añadir la cámara al panel de control de [Home Assistant]


[domology]: https://domology.es/instalacion-configuracion-mqtt/
[Home Assistant]: https://www.home-assistant.io
[instalacion de Home Assistant]: https://sherblog.pro/instalación-de-home-assistant-en-raspberry/
[onvif]: https://www.onvif.org
[Yi Dome Guard]: https://www.yitechnology.com.sg/products/yi-dome-guard/
[Yi Home]: https://play.google.com/store/apps/details?id=com.ants360.yicamera.international&hl=es&gl=US
[Yi Home 1080]: https://www2.yitechnology.com/yi-1080p-home-camera
[Yi Home cameras]: https://www.home-assistant.io/integrations/yi/
[Yi-Hack Allwinner-v2]: https://github.com/roleoroleo/yi-hack-Allwinner-v2
[Yi-Hack HA integration]: https://github.com/roleoroleo/yi-hack_ha_integration

[image-01]: /images/20210614_home_assistan_yi_camer_01.jpg
[image-02]: /images/20210614_home_assistan_yi_camer_02.jpg
