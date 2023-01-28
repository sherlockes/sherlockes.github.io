---
title: "ESPHome en Home Assistant"
date: "2021-06-08"
creation: "2021-06-08"
description: "Como utilizar ESPHome en Home Assistant"
thumbnail: "/images/20210608_home_assistant_esphome_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "home assistant"
- "iot"
tags:
- "esp"
draft: false
weight: 5
---
Hace ya un tiempo que tengo un nodemcu midiendo la temperatura del salón y un esp01 como relé para la calefacción pero... ¿Como es posible integrar esto en Home Assistant?. La solución más rápida y sencilla es usando [ESPHome], Un sistema para controlar los ESP32/ESP8266 mediante unos simples archivos de configuación y poder manejarlos remotamente mediante una automatización.
<!--more-->

### Instalando ESPHome en Home Assistant
Para instalar el complemento de [ESPHome] en Home Assistant es imprescindible tener habilitado el modo "Supervisor" en nuestra instalación de Home Assistant y acceder a el a través del botón situado en la parte inferior de la barra de navegación de la izquierda. 

![image-01]

Desde el panel del Supervisor hay que:
- Acceder a la tienda de complementos
- Buscar "ESPHome" en "Home Assistant Community Add-ons"
- Instalarlo e iniciarlo

![image-02]

Con esto ya es posible acceder a ESPHome desde Home Assistant mediante el correspondiente botón en la barra de navegación (Si se ha habilitado en las opciones deslizantes).

### ESP-01 con relé de un canal
Para controlar la puesta en marcha y paro de la calefacción utilizo un módulo de ESP01 con relé que es fáciĺ encontrar en Aliexpress por menos de 3€.

![image-04]

Para integrarlo en Home Assistant mediante ESPHome ha que seguir esto pasos desde el panel de control de ESPHome.

1. Añadir un nuevo dispositivo (El + de abajo a la dcha)
2. Nombrarlo
3. Seleccionar "Generic ESP8266 (for example Sonoff)" para ESP-01
4. Introdudir esid del wifi y pass
5. Enviar la información para crear el nodo

Ahora tendremos el nuevo nodo creado con una línea roja encima

6. Actualizar el firmware del ESP-01
Es necesario un programador con pulsador de booteo (O soldar el botón en un programador normal para instalar el firmware de ESPHome en el ESP01.

![image-05]

- Montamos el ESP en el programador y enchufamos este al dispositivo donde esté corriendo la distribución de Home Assistant (En mi caso a uno de los puertos usb sobrantes de la Raspberry).

> Muy importante pulsar el botón de booteo del programador para introducir el programador al puerto USB y no soltarlo¡¡¡

- En este momento, Home Assistant habrá reconocido un dispositivo conectado en un puerto serie y lo seleccionamos en el desplegable donde pone "OTA (Over-The-Air)"

- Pulsamos la opción (Sin soltar el botón de booteo del programador) "UPLOAD" y esperamos, cruzando los dedos, a que en la ventana llegue a mostrarse algo como lo siguiente indicando que el firmware ha sido correctamente subido al microcontrolador.

![image-03]

> En alguna ocasión me ha ocurrido que la contraseña del wifi con se ha copiado correctamente en el archivo de configuración y no es posible la conexión del dispositivo. Hay que comprobarlo desde el menú "EDIT" del nodo que no podemos conectar.

- En este punto ya podemos quitar el ESP-01 del programador, conectarlo al módulo con el relé y alimentarlo para que se conecte al wifi y lo podamos actualizar via OTA

- Desde el menú "EDIT" del nodo que hemos creado añadiremos ahora el código necesario al final para que el microcontrolador sea capaz de manejar el relé en el correspondiente puerto GPIO

El código que tenemos que introducir para que funcione este relé de un sólo canal es unas pocas líneas que se muestran a continuación.

``` yaml
switch:
  platform: gpio
  name: "rele"
  pin:
    number: GPIO0
    inverted: True
```
- Guardar y subir y ya está nuestro relé listo.


### ESP01 con sensor de temperatura DHT11
Una forma barata y sencilla de medir la temperatura es usando un módulo de ESP01 + DHT11 como el que aparece a continuación y que tengo instalado en una de las habitaciones.

![image-06]

El proceso de configuración para el ESP01 es idéntico que para el caso del relé solo que cambia el archivo de configuración por el siguiente.

``` yaml
# DHT11 config
sensor:
  - platform: dht
    pin: 
      number: GPIO2
    temperature:
      name: "Temperatura Estudio"
      filters:
        - offset: -5.0
    humidity:
      name: "Humedad Estudio"
    update_interval: 10s
    model: "DHT11"
```

> El módulo que he empleado presenta un error en la medidad de temperatura de 5ºC por lo que le he incluido un "offset" en la configuración.

### ESP-WROOM-32 con sensor de temperatura
Seguramente será matar moscas a cañonazos utilizar este microcontrolador como sólo sensor de temperatura. El ESP-WROOM-32 irá colocado en el salón y en un futuro es posible que haga más cosas.

![image-07]

Voy a usar una sonda DHT22 con una resistencia de 4.7 kOhm entre el pin de datos y el de 5V. El pin de datos lo coloco en el pin 13 del ESP y creo un nuevo nodo dentro del módulo ESPHome al que nombraré "salon" y será del tipo "nodeMCU-32S".

Al código que se genera automáticamente con la información de la wifi añado lo siguiente.

``` yaml
# Sensor de Temperatura AM2302
sensor:
  - platform: dht
    pin: 13
    temperature:
      name: "Temperatura Salón"
    humidity:
      name: "Humedad Salón"
    model: AM2302
    update_interval: 60s
```

[ESPHome]: https://esphome.io

[image-01]: /images/20210608_home_assistant_esphome_01.jpg
[image-02]: /images/20210608_home_assistant_esphome_02.jpg
[image-03]: /images/20210608_home_assistant_esphome_03.jpg
[image-04]: /images/20210608_home_assistant_esphome_04.jpg
[image-05]: /images/20210608_home_assistant_esphome_05.jpg
[image-06]: /images/20210608_home_assistant_esphome_06.jpg
[image-07]: /images/20210608_home_assistant_esphome_07.jpg
