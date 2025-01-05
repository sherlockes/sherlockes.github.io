---
title: "Sistema de pulsadores con Esp32 y micropython"
date: "2024-11-11"
creation: "2024-11-11"
description: "Pequeño proyecto para construir un sistema de pulsadores para un juego escolar"
thumbnail: "images/20241111_pulsadores_esp32_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "hardware"
tags:
- "esp"
- "thonny"
draft: true
weight: 5
---
Hoy toca construir un pequeño sistema de pulsadores para un juego escolar que detecte y muestre el primero que ha activado el pulsador para de esta forma poder dar una respuesta.
<!--more-->
El sistema va a ser sencillo. Tenemos cuatro pulsadores y cuatro indicadores luminosos, se mostrará el pulsador que primero se active mediante el correspondiente indicador luminoso e impedirá que la pulsación posterior de cualquier otro desencadene la iluminación de su indicador. Además tendremos un quinto pulsador que reiniciará la secuencia.

Por sencillez, precio, posibilidades y conocimiento, desde un principio he tenido claro que iba a usar un ESP32 y micropython como en algún [proyecto] anterior. Usaré una placa de desarrollo [ESP32-WROOM-32U] y el entorno de desarrollo [Thonny].

Tendremos cuatro pulsadores de activación y uno de reinicio. Cuando el pulsador de reinicio se pulse se encenderán todas las luces correspondientes a los pulsadores de activación y permanecerán encendidas un tiempo aleatorio entre 5 y 10 segundos. Pasado el tiempo se apagarán todas las luces y sólo se encenderá la del pulsador que se active primero a partir de ese momento. La luz del pulsador "ganador" quedará encendida hasta que se reinicie la secuencia.

El código a usar será el siguiente:

``` python
from machine import Pin
import time
import random

# Configuración de los pines de los LEDs
led_rojo = Pin(2, Pin.OUT)      # LED rojo en GPIO 2
led_amarillo = Pin(4, Pin.OUT)  # LED amarillo en GPIO 4
led_verde = Pin(16, Pin.OUT)    # LED verde en GPIO 16

# Configuración de los pines de los pulsadores
pulsador1 = Pin(18, Pin.IN, Pin.PULL_UP)  # Pulsador 1 en GPIO 18
pulsador2 = Pin(19, Pin.IN, Pin.PULL_UP)  # Pulsador 2 en GPIO 19
pulsador3 = Pin(21, Pin.IN, Pin.PULL_UP)  # Pulsador 3 en GPIO 21
pulsador_reset = Pin(22, Pin.IN, Pin.PULL_UP)  # Pulsador de reinicio en GPIO 22

# Inicializar el estado de los LEDs
led_encendido = None  # Variable para almacenar cuál LED está encendido

while True:
    # Comprobar si se presionó el pulsador de reinicio
    if not pulsador_reset.value():  # Si el pulsador de reinicio está presionado
        # Encender todos los LEDs
        led_rojo.on()
        led_amarillo.on()
        led_verde.on()
        
        # Esperar un tiempo aleatorio entre 5 y 10 segundos
        tiempo_espera = random.uniform(5, 10)
        time.sleep(tiempo_espera)
        
        # Apagar todos los LEDs y resetear el estado
        led_rojo.off()
        led_amarillo.off()
        led_verde.off()
        led_encendido = None  # Restablecer el estado de LED encendido
        time.sleep(0.5)  # Breve pausa para evitar rebotes después de reiniciar

    # Comprobar el estado de cada pulsador si no hay ningún LED encendido
    if led_encendido is None:
        if not pulsador1.value():  # Si pulsador 1 está presionado
            led_rojo.on()
            led_encendido = 'rojo'
        elif not pulsador2.value():  # Si pulsador 2 está presionado
            led_amarillo.on()
            led_encendido = 'amarillo'
        elif not pulsador3.value():  # Si pulsador 3 está presionado
            led_verde.on()
            led_encendido = 'verde'

    time.sleep(0.1)  # Espera un corto tiempo para evitar lecturas rápidas
```
El primer prototipo está listo en unos minutos con una placa de pruebas, unos pulsadores, leds y cables conectores.

![image-01]

### Los fracasos de los relés
Puesto que vamos a conectar varios leds al ESP32 he optado por usar unos relés para que la corriente de salida de los pines no sea una limitación. Por el tema del ruido, en un primer momento pensé en usar relés de estado sólido. El módulo adquirido es el [G3MB-202P SSR AVR DSP] de cuatro canales

![image-01]

Las primeras pruebas fueron mal, ya que al trabajar con una carga tan pequeña (Un par de leds alimentados a 5V por relé), la corriente de fuga es suficiente para mantenerlos encendidos aunque cambiemos el estado de la entrada.

Por esto me decido por usar relés mecánicos, más exactamente el módulo.

### Enlaces de interés
- [enlace](www.sherblog.pro)

[G3MB-202P SSR AVR DSP]: https://es.aliexpress.com/item/1005004908428159.html
[proyecto]: /configurando-un-relé-wifi-mediante-esp-01-y-micropython/
[ESP32-WROOM-32U]: https://es.aliexpress.com/item/1005006661654117.html
[Thonny]: https://thonny.org

[image-01]: /images/20241111_pulsadores_esp32_01.jpg
[image-02]: /images/20241111_pulsadores_esp32_02.jpg



