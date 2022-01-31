---
title: "Usb externo controlado desde puerto Gpio"
date: "2022-01-31"
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
draft: true
weight: 5
---
Resumen de introducción
<!--more-->
Antes de empezar, es recomendable realizar una actualización del sistema mediante.

``` bash
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade
sudo apt autoremove
sudo apt clean
```

``` bash
# Exportar el pin 18 antes de utilizarlo
echo "18" > /sys/class/gpio/export

# Define el pin 18 como salida
echo "out" > /sys/class/gpio/gpio18/direction

# Pone un nivel alto en el pin 18
echo "1" > /sys/class/gpio/gpio18/value

# Pone un nivel bajo en el pin 18
echo "0" > /sys/class/gpio/gpio18/value 
```


``` bash
pi@raspberrypi:~ $ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    1 57.3G  0 disk 
├─sda1   8:1    1  256M  0 part /boot
└─sda2   8:2    1 57.1G  0 part /
sdb      8:16   0  5.5T  0 disk 
└─sdb1   8:17   0  5.5T  0 part 
```

``` bash
mkdir ~/usb_ext
sudo mount /dev/sdb1 ~/usb_ext


![image-01]

### Enlaces de interés
- [Linux Config - Mount Usb](https://linuxconfig.org/howto-mount-usb-drive-in-linux)
- [Raspberry-AA - Bash Script Control of GPIO Ports](https://raspberrypi-aa.github.io/session2/bash.html)

[link]: https://www.google.es


[image-01]: /images/20220131_gpio_external_relay_01.jpg
[image-02]: /images/20220131_gpio_external_relay_02.jpg
[image-03]: /images/20220131_gpio_external_relay_03.jpg
[image-04]: /images/20220131_gpio_external_relay_04.jpg
[image-05]: /images/20220131_gpio_external_relay_05.jpg
[image-06]: /images/20220131_gpio_external_relay_06.jpg
[image-07]: /images/20220131_gpio_external_relay_07.jpg
[image-08]: /images/20220131_gpio_external_relay_08.jpg
[image-09]: /images/20220131_gpio_external_relay_09.jpg
