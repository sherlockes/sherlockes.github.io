---
title: "Instalación de Home Assistant en Raspberry"
date: "2021-05-27"
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

Definitivamente, este el mejor método que he podido encontrar hasta ahora, obteniendo todo lo que necesito sin ningún fallo.


[Balena Etcher]: https://www.balena.io/etcher/
[GitHub]: https://github.com
[Home Assistant]: https://www.home-assistant.io
[instalación en raspberry]: https://www.home-assistant.io/installation/raspberrypi
[instalación en contenedor]: https://www.home-assistant.io/installation/raspberrypi#install-home-assistant-container
[Kanga-Who]: https://github.com/Kanga-Who/home-assistant/blob/master/Supervised%20Install%20on%20Raspberry%20Pi%20OS.md
[manelrodero]: https://www.manelrodero.com/blog/instalar-docker-en-raspberry-pi-4
[post]: https://sherblog.pro/raspberry-montaje-y-ssh/
[tecnosanvaras]: https://tecnosanvaras.es/instalacion-de-ha-supervisded-en-raspberry-pi-con-debian-10/
