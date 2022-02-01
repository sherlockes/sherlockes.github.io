---
title: "Usb externo controlado desde puerto Gpio"
date: "2022-02-01"
creation: "2022-01-31"
description: "Controlando un relé desde la raspberry a través del puerto Gpio para montar un disco usb externo."
thumbnail: "images/20220131_gpio_external_relay_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "raspberry"
tags:
- "bash"
- "gpio"
draft: false
weight: 5
---
Tenemos un disco duro externo conectado a la Raspberry por un puerto Usb y alimentado por un transformador. Veamos como es posible encenderlo gracias a un relé de 5V sólo cuando cuando vayamos a emplearlo.
<!--more-->
El cableado eléctrico resulta bastante sencillo, queremos cortar la alimentación al disco usb externo mediante un relé manejado por una tensión de 5V. Aunque lo más eficiente sería que el relé cortara en la parte de alta tensión de 220V, lo más sencillo y seguro va a ser cortar en la de baja tensión con un diagrama como el siguiente.

![image-02]

- Pin nº4: Alimentación de 5V para el relé
- Pin nº6: Referencia de tensión / Gnd
- Pin nº12: Señal de control del relé

Algo importante a tener en cuenta es que el número del puerto no coincide con el pin físico de la Raspberry tal y como se puede ver en la siguiente imagen. En este caso vamos a trabajar con el GPIO18 que corresponde con el pin nº 12 de la Raspberry. 

![image-01]

Antes de empezar con la parte de programación en Bash, es recomendable realizar una actualización del sistema mediante.

``` bash
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade
sudo apt autoremove
sudo apt clean
```

Esportamos el pin que vamos a utilizar, lo definimos como salida y ya podemos ponerlo a "uno" o "cero" para encender o apagar el relé con consecuentemente el disco duro externo.

``` bash
# Exportar el pin 18 antes de utilizarlo
echo "18" > /sys/class/gpio/export

# Define el pin 18 como salida
echo "out" > /sys/class/gpio/gpio18/direction

# Poner un nivel alto en el pin 18
echo "1" > /sys/class/gpio/gpio18/value

# Poner un nivel bajo en el pin 18
echo "0" > /sys/class/gpio/gpio18/value 
```

> En algunos sitios se hace referencia a que es necesario ejecutar estos comandos como root aunque yo los he podido ejecutar como un usuario corriente con Raspbian 10 (Buster) corriendo sobre la Raspberry

Ahora vamos a ver como se ha nombrado el disco mediante el comando `lsblk`. En nuestro caso vemos como se ha nombrado como la artición "sdb1" dentro del disco "sdb".

``` bash
pi@raspberrypi:~ $ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    1 57.3G  0 disk 
├─sda1   8:1    1  256M  0 part /boot
└─sda2   8:2    1 57.1G  0 part /
sdb      8:16   0  5.5T  0 disk 
└─sdb1   8:17   0  5.5T  0 part 
```

Para montarlo sólo resta crear un directorio donde hacerlo y ejecutar el comando "mount".

``` bash
mkdir ~/usb_ext
sudo mount /dev/sdb1 ~/usb_ext
```

> Antes de apagar el disco poniendo un "cero" en el gpio18 habrá que desmontarlo mediante el comando "umount".

### Enlaces de interés
- [Linux Config - Mount Usb](https://linuxconfig.org/howto-mount-usb-drive-in-linux)
- [Raspberry-AA - Bash Script Control of GPIO Ports](https://raspberrypi-aa.github.io/session2/bash.html)

[link]: https://www.google.es


[image-01]: /images/20220131_gpio_external_relay_01.jpg
[image-02]: /images/20220131_gpio_external_relay_02.jpg
