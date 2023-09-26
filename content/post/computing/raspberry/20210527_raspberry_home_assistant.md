---
title: "Instalación de Home Assistant en Raspberry"
date: "2022-02-11"
creation: "2021-05-27"
description: "Aquí dejo las alternativas que he valorado a la hora de instalar Home Assistant en la Raspberry"
thumbnail: "/images/20210527_raspberry_home_assistant_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "raspberry"
- "home assistant"
tags:
- "docker"
draft: false
weight: 5
---
Las dudas surgen cuando tienes varias posibilidades. Esto es lo que me ha pasado a la hora de empezar las pruebas con Home Assistant en una Raspberry Pi 4 de 4gb de ram sobre un stick usb.
<!--more-->

### Distribución completa
El primer paso es acceder a la web de [Home Assistant] y seguir los pasos de [instalación en raspberry] para novatos. De esta forma se instalará la distribución completa de Home Assistant según lo siguiente.

1. En el artículo de [instalación en raspberry] buscamos el enlace para la versión que necesitamos
1. Grabar la imagen en el stick usk con [Balena Etcher]
1. Montar el stick en la raspberry, conectar cable de red y alimentación y encender
1. Esperamos unos minutos y ya se puede acceder a http://IP_raspberry:8123

> Si no sabes como descubrir la IP con la que la raspberry se ha conectado a la red puedes visitar este [post] para obtener alguna respuesta.

Y ya está, de una forma rápida y sencilla tenemos la distribución de [Home Assistant] corriendo en la Raspberry. La instalación es completamente funcional pero limita mucho el uso de la Raspberry para otros menesteres debido al Alpine Linux sobre el que está funcionando [Home Assistant].

Otro problema con el que me he encontrado es que la única forma de asignar una IP estática a la Raspberry es reservando la dirección desde el DHCP del router. No he sido capaz de hacerlo desde la configuración de la distribución.

Por lo anterior me decido a probar otro método de instalación que me ofrezca mejores resultados.

### Contenedor mediante Docker
Necesitaremos tener instalado Docker en nuestra Raspberry para poder manejar la instalación del contenedor, para ello...

1. Instalación de Raspberry OS en su versión lite (En este [post] está detallado]
1. Instalación de Docker (En el blog de [manelrodero] está descrito)
1. Seguir la [instalación en contenedor]

Aunque es un poco más laboriosa que la anterior, esta instalación tampoco presenta mayor complicación pero tiene un gran inconveniente y es que imposibilita el uso de add-ons a través del modo "Supervisor" de [Home Assistant] lo cual limita mucho las posibilidades. Simplemente por esto descarto también este tipo de instalación.

### HA supervisado sobre Debian 10
Navegando un poco por la red doy con este post de [tecnosanvaras] en el se habilita el modo supervisado de [Home Assistant] en la instalación en Docker siguiendo los siguientes pasos.

1. Descargar la ultima versión de [Debian para Raspberry]
1. Descomprimir la imagen
1. Grabar la imagen en el stick usk con [Balena Etcher]
1. Conectar la Raspberry a un teclado, monitor y red cableada
1. Insertar el stick usb y arrancar la Raspberry
1. Tras el arranque, logearnos como "root"
1. Actualizar las dependencias - `apt update`
1. Instalar sudo - `apt install sudo`
1. Crear un nuevo usuario - `adduser TU_USUARIO`
1. Añadir el usuario creado al grupo sudo - `usermod -aG sudo TU_USUARIO`
1. Averiguar la IP de la Raspberry - `ip addr show eth0`
1. Reiniciar la raspberry

> Importante no realizar un "apt upgrade" de la distribución ya que, a día de hoy (20210517), presenta un bug con el aranque desde usb que hace que se cuelgue el sistema.

Con esto ya sólo resta instalar una utilidades, docker y el supervisor de home assistant mediante las siguientes líneas de código.

```
sudo -i
apt-get install -y software-properties-common apparmor-utils apt-transport-https ca-certificates curl dbus jq network-manager
systemctl disable ModemManager
systemctl stop ModemManager
curl -fsSL get.docker.com | sh
curl -sL "https://raw.githubusercontent.com/Kanga-Who/home-assistant/master/supervised-installer.sh" | bash -s -- -m raspberrypi4-64
```

Con la instalación realizada, ya estamos en condiciones de acceder a la IP que se nos muestra al terminar el script a través del puerto 8123.

```
[info] 
[info] Home Assistant supervised is now installed
[info] First setup will take some time, when it's ready you can reach it here:
[info] http://192.168.1.104:8123
[info] 
```

Aunque el método es un poco más laborioso que los anteriores, el resultado es bueno ya que hemos obtenido una instalación de [Home Assistant] con el modo supervisado activado sobre una distribución completamente funcional que nos permite sacar mucho más partido de la Raspberry.

Con todo presenta el problema de la imposibilidad de actualizar el sistema operativo por lo que, aunque la dejo en producción, sigo buscando una mejor alternativa.

### HA supervisado sobre Raspberry OS
Removiendo un poco por [GitHub] doy con un artículo de [Kanga-Who] donde esplica como instalar el modo supervisado de [Home Assistant] sobre Raspberry OS de una forma al margen de la oficial siguiendo los siguientes pasos.

1. Instalación de Raspberry OS lite y habilitar el acceso ssh (En este [post] está detallado]
1. Conectarse a la Raspberry mediante ssh
1. Ejecutar `sudo raspi-config` y cambiar pass, timezone y en opciones avanzadas "A1–expand file system"
1. Acualizar el sistema mediante `sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y`
1. Reiniciar mediante `sudo reboot`
1. Desde la conexión ssh ejecutar el siguiente código
```
sudo -i
apt-get install -y software-properties-common apparmor-utils apt-transport-https ca-certificates curl dbus jq network-manager
systemctl disable ModemManager
systemctl stop ModemManager
curl -fsSL get.docker.com | sh
curl -sL "https://raw.githubusercontent.com/Kanga-Who/home-assistant/master/supervised-installer.sh" | bash -s -- -m raspberrypi4
```

Un poco de paciencia y al cabo de unos minutos ya podremos acceder a http://ip_raspberry:8123 para terminar con la configuración de [Home Assistant]

Definitivamente, este el mejor método que he podido encontrar hasta ahora, el único problema que presenta es que la instalación no está soportada oficialmente aunque el funcionamiento es correcto por lo que la dejo instalada.

### HA supervisado sobre Debian 11
En mi caso estoy realizando la instalación sobre una Raspberry Pi 3B+ sobre un stick usb que he configurado como método de arranque gracias a este post de [instructables]
- Desde [raspi.debian.net] descargamos la versión 11 para nuestra Raspberry
- Quemamos la imagen en un stick usb
- Conectamos el usb, un monitor y un teclado a la Raspberry
- Tras el arranque nos logueamos como "root"
- Ejecutamos los siguientes comandos para:
 - Actualizar y limpiar el sistema
 - Configurar el teclado y la consola en castellano
 - Establecer contraseña para el usuario "root"
 - Añadir el usuario "pi"
 - Añadir la función "sudo"
 - Añadir el usuario "pi" a la función "sudo"
 - Conocer la ip que se le ha asignado a la Raspberry
 - Reiniciar
 
``` bash
apt update && sudo apt upgrade -y && sudo apt autoremove
apt install keyboard-configuration console-setup
passwd root
adduser pi
apt install sudo
usermod -aG sudo pi
ip addr show eth0 | grep "inet"
reboot
```

- Ahora ya nos podemos conectar de forma remota a la Raspberry mediante `ssh pi@192.168.10.149`

A partir de aquí seguiremos la instalación de Home Assistant Supervisado según el post [Kanga-Who - HA Rpi Debian 11].

- Adquirimos los privilegios de "root"
- Reparamos dependencias no satisfechas
- Instalamos "jp", "curl", "avahi-daemon",...
- Instalamos "Docker"
- Descargamos la última versión del agente para HA
- Instalamos el agente
- reiniciamos el sistema

``` bash
sudo -i
apt --fix-broken install
apt-get install jq curl avahi-daemon apparmor-utils udisks2 libglib2.0-bin network-manager dbus wget -y
curl -fsSL get.docker.com | sh
wget https://github.com/home-assistant/os-agent/releases/download/1.2.2/os-agent_1.2.2_linux_aarch64.deb
dpkg -i os-agent_1.2.2_linux_aarch64.deb
reboot
```

Ya sólo resta instalar Home Assistant Supervisado mediante
- Adquirimos los privilegios de "root"
- Descargamos la ultima versión de HA Supervisado
- Instalamos

``` bash
wget https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb
dpkg -i homeassistant-supervised.deb
```

Se nos preguntará antes de realizar la instalación por el hardware sobre el que lo vamos a realizar. En mi caso he seleccionado "raspberrypi3-64"

Ahora toca esperar un ratillo (En la Raspberry Pi 3 han sido más de 20 minutos) y ya podemos acceder a "http://192.168.10.149:8123 para terminar con la instalación de Home Assistant


[Balena Etcher]: https://www.balena.io/etcher/
[GitHub]: https://github.com
[Home Assistant]: https://www.home-assistant.io
[instalación en raspberry]: https://www.home-assistant.io/installation/raspberrypi
[instalación en contenedor]: https://www.home-assistant.io/installation/raspberrypi#install-home-assistant-container
[instructables]: https://www.instructables.com/Booting-Raspberry-Pi-3-B-With-a-USB-Drive/
[Kanga-Who]: https://github.com/Kanga-Who/home-assistant/blob/master/Supervised%20Install%20on%20Raspberry%20Pi%20OS.md
[Kanga-Who - HA Rpi Debian 11]: https://github.com/Kanga-Who/home-assistant/blob/master/Supervised%20on%20Raspberry%20Pi%20with%20Debian.md
[manelrodero]: https://www.manelrodero.com/blog/instalar-docker-en-raspberry-pi-4
[post]: https://sherblog.pro/raspberry-montaje-y-ssh/
[raspi.debian.net]: https://raspi.debian.net/tested-images/
[tecnosanvaras]: https://tecnosanvaras.es/instalacion-de-ha-supervisded-en-raspberry-pi-con-debian-10/
