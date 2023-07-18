
---
title: "Primeros pasos con nodemcu y micropython en linux"
date: "2021-02-16"
creation: "2021-02-04"
description: "No es una guía, simplemente mi experiencia como primera toma de contacto con microcontroladores esp8266 y esp32 a través de nodemcu y micropython en linux mint."
thumbnail: "/images/20210304_nodemcu_micropython_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
- "iot"
tags:
- "micropython"
draft: false
weight: 5
---
Aquí dejo lo que ha sido mi salto desde la raspberry pi y python hacia el esp8266 y micropython mediante la placa node mcu y el objetivo de una sonda de temperatura con comunicación wifi.
<!--more-->
Este ha sido mi arranque en el mundo de los microcontroladores dl que sólo toqué hace unos años un poco el arduino y que abandoné por falta de proyectos.

### Lo que necesitamos
Aunque no es la opción más pequeña ni más barata creo que es la forma más sencilla de empezar en el mundo de los microcontroladores ya que la lista de necesidades es realmente pequeña

- Placa [nodemcu]
- Cable microusb de datos
- Un pc
- Tiempo

Si estás leyendo esto que tengas cable, pc y tiempo por lo que solo son necesarios unos poco euros para conseguir la placa.

![image-01]


### Micropython y Thonny
Si hubiera llegado aquí desde el mundo de arduino quizas ahora estaría empleando su entorno de desarrollo para programar el nodemcu en c++. Como vengo de la Raspberry voy a introducirme en el mundo de [micropython] mediante [Thonny].

Para la instalación de [Thonny] nos bastará con
```
sudo apt install python3 python3-pip python3-tk
sudo pip3 install thonny
```
Para arrancar el entorno de programación [Thonny] abriremos una consola de comandos y ejecutaremos `thonny`

![image-02]

### Instalando el firmware
En la web de [micropython] hay una detallada [guía de instalación del firmware] que se resume en:

- Instalar esptool `pip install esptool`
- Descargar el ultimo [firmware] estable
- Borrar la memoria `esptool.py --port /dev/ttyUSB0 erase_flash`
- Cargar el firmware en la placa mediante el siguiente comando

```
esptool.py --port /dev/ttyUSB0 --baud 460800 write_flash --flash_size=detect 0 esp8266-20200911-v1.13.bin
```

Dentro del entorno de [Thonny], en el menú "Herramientas-Opciones" y la pestaña "Intérprete" nos ofrece la opción de instalar o actualizar el firmware. Para hacerlo sólo hay que selecciónar en dispositivo y el puerto, este último en caso de que no sea capaz de detectarlo automáticamente.

![image-03]

> Aunque no lo he probado, supongo que en caso de que no hayas instalado esptool de forma manual, al inatalar [Thonny] comprobará las dependencias y lo instalará si es necesario.

Después de esto, si la instalación ha sido correcta, en la consola de comandos podremos escribir `print("hola mundo") y obtener respuesta como se muestra en la imagen.

![image-04]

### El montaje

Como primer montaje quiero realizar una simple medición de temperatura mediante una AM2302 que tan buenos resultados me está dando en la raspberry. El sensor lleva tres cables, el de alimentación, el de masa y la señal. aunque no lo tengo muy claro si es necesaria o no debido a la configuración interna del nodemcu, se recomienda unir la alimentación y la masa con una resistencia de 10K tal y como se muestra en la imagen.

![image-05]

> Un detalle importante es que, aunque el cable de señal está conectado a la patilla D2 de la placa, esta se corresponde la GPIO4 del ESP8266 interno para la futura programacion del microcontrolador.

![image-06]

### Programación

Con la placa conectada al usb del ordenador es el momento de abrir Thonny y en el menú "ejecutar" seleccionar el intérprete correspondiente a Micropython y el puerto correspondiente al que está conectado la placa tal y como se puede ver en la siguiente imagen.

![image-07]

Pulsaremos Ctrl + F2 para que en la consola inferior aparezca el propmt de micropython

![image-08]

> En algunas ocasiones da un error al detener y reinicializar el Back-end por que la placa está ocupada, en estos casos pulsando varias veces seguidas Ctrl+F2 desaparece el error.

Crearemos un documento main.py que se ejecutará al arrancar el microcontrolador y que tendrá las siguientes funciones.

- Contactarse a la red wifi
- Contactarse al servidor MQTT
- Captar la temperatura de la sonda
- Enviar un mensaje con la temperatura
- Esperar 30 segundos
- Volver a captar, enviar y esperar

Y así de forma indefinida añadiendo una capacidad de reconexión a la red wifi o servidor MQTT cuando alguno de los dos falle.

```
import machine
from machine import Pin
from time import sleep
import dht 
from etc.umqttsimple import MQTTClient
import ubinascii

import network

# Conexión al wifi
ssid = 'nombre_de_la_red'
password = 'contraseña'

station = network.WLAN(network.STA_IF)
station.active(True)
station.connect(ssid, password)

while station.isconnected() == False:
  pass

print('Wifi connection successful')

# Configuración mqtt
mqtt_server = '192.168.1.203'
client_id = ubinascii.hexlify(machine.unique_id())
topic_pub_temp = b'temp_humidity'

def connect_mqtt():
  global client_id, mqtt_server
  client = MQTTClient(client_id, mqtt_server)
  client.connect()
  print('Connected to %s MQTT broker' % (mqtt_server))
  return client

def restart_and_reconnect():
  print('Failed to connect to MQTT broker. Reconnecting...')
  sleep(10)
  machine.reset()
  
try:
  client = connect_mqtt()
except OSError as e:
  restart_and_reconnect()
  
# Captura de datos del AM2302 En el GIO4 (Pin D2)
sensor = dht.DHT22(machine.Pin(4))

def read_sensor():
  try:
    sleep(2)
    sensor.measure()
    temp = sensor.temperature()
    hum = sensor.humidity()
    print('Temperatura: %.1f C' %temp)
    print('Humedad: %.0f %%' %hum)
    msg = (b'{0:.1f},{1:.0f}'.format(temp, hum))
    return msg
  except OSError as e:
    print("error")
    machine.reset()
    msg = (b'{0:3.1f},{1:3.1f}'.format(0, 0))
    return msg


# Bucle principal
while True:
  try:
    client.publish(topic_pub_temp, read_sensor())
  except OSError as e:
    restart_and_reconnect()
    
  sleep(30)
```

El [archivo] lo puedes encontrar en mi repositorio de GitHub con la última versión actualizada. Para la comunicación mqtt hago uso de la clase "[umqttsimple]" que hay se guardar dentor de la carpeta "etc".


### Links de interés

https://randomnerdtutorials.com/esp32-esp8266-dht11-dht22-micropython-temperature-humidity-sensor/
https://devonhubner.org/MicroPython_on_NodeMCU_with_dht11_button_and_led/
https://techtutorialsx.com/2017/06/06/esp32-esp8266-micropython-automatic-connection-to-wifi/
https://www.rototron.info/raspberry-pi-esp32-micropython-mqtt-dht22-tutorial/

[archivo]: https://github.com/sherlockes/SherloScripts/blob/master/upython/nodemcu_esp8266_am2302_wifi_mqtt_main.py
[firmware]: http://micropython.org/download/esp8266/
[guía de instalación del firmware]: http://docs.micropython.org/en/latest/esp8266/tutorial/intro.html#deploying-the-firmware
[micropython]: https://micropython.org
[nodemcu]: https://www.nodemcu.com
[Thonny]: https://thonny.org
[umqttsimple]: https://github.com/RuiSantosdotme/ESP-MicroPython/blob/master/code/MQTT/umqttsimple.py

[image-01]: /images/20210304_nodemcu_micropython_01.jpg
[image-02]: /images/20210304_nodemcu_micropython_02.jpg
[image-03]: /images/20210304_nodemcu_micropython_03.jpg
[image-04]: /images/20210304_nodemcu_micropython_04.jpg
[image-05]: /images/20210304_nodemcu_micropython_05.jpg
[image-06]: /images/20210304_nodemcu_micropython_06.jpg
[image-07]: /images/20210304_nodemcu_micropython_07.jpg
[image-08]: /images/20210304_nodemcu_micropython_08.jpg
