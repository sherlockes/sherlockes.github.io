---
title: "Instalando Home Assistant supervisado en Debian 11"
date: "2023-01-28"
creation: "2023-01-27"
description: "Todos los pasos que he seguido para instalar Homa Assistant supervisado en una Raspberry Pi 3b+ con Debian 11"
thumbnail: "images/20230127_home_assistant_debian_rpi_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "home assistant"
- "raspberry"
tags:
- "linux"
draft: false
weight: 5
---
Si quieres sacar todo el potencial de tu Raspberry al tiempo que la empleas como servidor de [Home Assistant] con el uso de [Addons], aquí dejo el método oficial de la instalación supervisada mediante Debian 11 en una Raspberry 3B+.
<!--more-->
Está claro, si eres un usuario avanzado de [Home Assistant] vas a necesitar el uso de [Addons] lo cual te obliga a utilizar el sistema operativo de [Home Assistant] o una instalación supervisada. La primera alternativa es realmente sencilla, grabas la imagen en una tarjeta o usb, la insertas en la Raspberry y listo para funcionar. La segunda alternativa se complica un poco más y, aunque está descrita en la página [oficial], voy a exponer en este artículo cual ha sido mi experiencia.

![image-01]

---

### Instalando Debian 11
Parto de mi pc de sobremesa en el que tengo instalado [Linux Mint] y desde el que voy a realizar la conexión remota a la Raspberry para llevar a cabo toda la instalación.

- Descargamos la imagen de Debian para nuestra Raspberry de [Raspi.debian.net](https://raspi.debian.net/tested-images/)
- La grabamos en un usb o microSD con [Raspberry Pi imager](https://www.raspberrypi.com/software/)
- Para no tener que conectar un monitor y teclado a la Raspberry, una vez grabada la imagen
  - Editaremos el archivo "/RASPIFIRM/sysconf.txt"
  - Quitaremos el comentario de la línea "root_authorized_key="
  - A continuación insertaremos el contenido del archivo "id_rsa.pub" que está en la carpeta ".ssh" del usuario con el que queremos acceder a la Raspberry

> En caso de que tengamos problemas con la llave ssh podemos conectarnos mediante teclado y monitor y posteriormente crear un usuario al que conectarnos
>  - Logearse como 'root' sin contraseña
>  - Crear un nuevo usuario 'pi' con `add user pi`
>  - Buscar la ip local asignada con `ip address`
>  - Conectarse mediante `ssh pi@xxx.xxx.xxx.xxx`
>  - Cambiar al usuario 'root' mediante `su root`

- Meteremos la tarjeta o pincho en la Raspberry, la conectaremos a la red y la alimentaremos.
- Dejamos pasar unos minutos para que arranque el sistema
- Buscamos la ip que el router le ha asignado mediante `sudo nast -m`, en mi caso consigo una salida como la siguiente
```
Nast V. 0.2.0
Mapping the Lan for 255.255.255.0 subnet ... please wait

MAC address		Ip address (hostname)
===========================================================
...
...
C6:45:ED:33:E4:D8 	192.168.10.149 (rpi3-20230102.home)
...
...
```
- Conectarse a la Raspberry mediante ssh `ssh root@192.168.10.149`, como hemos pasado previamente la llave ssh no es necesaria la contraseña. En caso de hacerlo a través de un usuario intermedio deberemos cambiar a "root" una vez realizada la conexión. Es posible que si ya se había asignado anteriormente la IP local a otra instalación nos aparezca un mensaje como el siguiente
```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:81KFZrPBIHhTioZOrTEwnN9XCad3xoXEk9eVaWPc0TE.
Please contact your system administrator.
Add correct host key in /home/sherlockes/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /home/sherlockes/.ssh/known_hosts:24
  remove with:
  ssh-keygen -f "/home/sherlockes/.ssh/known_hosts" -R "192.168.10.149"
ECDSA host key for 192.168.10.149 has changed and you have requested strict checking.
Host key verification failed.
```

En este caso deberemos ejecutar el comando `ssh-keygen -f "/home/sherlockes/.ssh/known_hosts" -R "192.168.10.149"` para permitir la nueva conexión.

- Actualizar el sistema con `apt update & apt upgrade -y`
> Es posible que al terminar nos diga que hay algún paquete listo para actualizar, realizaremos otro `apt upgrade`

---

### Instalando las dependencias y Docker
Para poder proseguir con la instalación de [Home Assistant] supervisado el sistema debe cumplir una serie de [requerimientos] que pasamos a instalar a continuación.
- Instalar dependencias con `apt install apparmor jq wget curl udisks2 libglib2.0-bin network-manager dbus lsb-release systemd-journal-remote -y`
- Instalar Docker con `curl -fsSL get.docker.com | sh`
> Tras la instalación de Docker podemos comprobar que se ha realizado correctamente comprobando la versión del mismo mediante `docker --version`, para cumplir con los [requerimientos] deberemos tener instalada una versión mayor que la 20.10.17.

---

### Instalación de os-agent
Ahora toca la instalación de os-agent para [Home Assistant]. Es usado tanto en el sistema operativo de [Home Assistant] como en la versión supervisada que estamos instalando para comunicar el supervisor de [Home Assistant] con el sistema operativo sobre el que está corriendo.

- Antes de seguir adelante comprobaremos la arquitectura del hardware sobre el que estamos realizando la instalación mediante el comando `uname -a`, tal y como se puede ver a a continuación, para la Raspberry Pi 3b+ he obtenido una arquitectura "aarch64".

```bash
Linux rpi3-20230102 5.10.0-20-arm64 #1 SMP Debian 5.10.158-2 (2022-12-13) aarch64 GNU/Linux
```

- Buscaremos cual es ultimo paquete "*.deb" disponible para nuestra arquitectura "aarch64" [aquí](https://github.com/home-assistant/os-agent/releases/latest) y copiaremos la dirección del enlace al mismo.
- En este caso descargaremos la versión `os-agent_1.4.1_linux_aarch64.deb` mediante el comando `wget https://github.com/home-assistant/os-agent/releases/download/1.4.1/os-agent_1.4.1_linux_aarch64.deb`
- Instalamos el paquete *.deb descargado mediante `dpkg -i os-agent_1.4.1_linux_aarch64.deb`
- Chequear que se ha instalado correctaemnte `gdbus introspect --system --dest io.hass.os --object-path /io/hass/os`

> Si todo ha ido bien se devolverá una respuesta con el tipo "interface", en caso de no existir el comando hay que instalar la librería libglib2.0-bin para conseguir el comando "gdbus".

---

### Instalado Home Assistant
Ya sólo resta la instalación de [Home Assistant] que realizamos a continuación.
- Descargar la ultima versión de HA supervisado `wget https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb`
- Instalarlo mediante `dpkg -i homeassistant-supervised.deb` y si todo va bien nos saldrá una pantalla como la siguiente para seleccionar la Raspberry Pi3

![image-02]

- Reiniciaremos el sistema mediante `reboot` y esperaremos un rato

> Es posible que después del reinicio se asigne una IP distinta por lo que si la conexión no es posible comprobaremos la IP asignada mediante `sudo nast -m`

- Accedemos desde el navegador a "http://192.168.10.149:8123" donde "8123" es el puerto que por defecto se asigna a [Home Assistant] y si todo ha ido bien veremos algo como lo siguiente.

![image-03]

Ya estamos listos para crear un usuario y comenzar la configuración desde cero o importar una copia de seguridad existente. En mi caso he optado por restaurar una copia de seguridad completa y parece que en un principio parece que no funciona pero un reinicio y unos minutos despues...

![image-04]

Perfecta importación de toda la configuración a la Raspberry 3

---

### Enlaces de interés
- [Bolly inside - Configure ssh on Debian 11](https://www.bollyinside.com/articles/how-to-configure-and-turn-on-ssh-on-debian-11-bullseye-linux)
- [Vitux - Reboot Debian 11](https://vitux.com/shutdown-reboot-debian-11/)
- [Linux Handbook - Find ip address](https://linuxhandbook.com/find-ip-address/)
- [How to Geek - Add user to sudoers](https://www.howtogeek.com/842739/how-to-add-a-user-to-the-sudoers-file-in-linux/)
- [Home Assistant - Supervised installer](https://github.com/home-assistant/supervised-installer)
- [Github - os-agent](https://github.com/home-assistant/os-agent/tree/main#using-home-assistant-supervised-on-debian)
- [Wikihow - Cambiar zona horaria](https://es.wikihow.com/cambiar-la-zona-horaria-en-Linux)
- [Raspi Debian - Settings](https://raspi.debian.net/defaults-and-settings/)

[Addons]: https://www.home-assistant.io/addons/
[Home Assistant]: https://www.home-assistant.io
[Linux Mint]: https://linuxmint.com
[oficial]: https://github.com/home-assistant/supervised-installer
[requerimientos]: https://github.com/home-assistant/architecture/blob/master/adr/0014-home-assistant-supervised.md

[image-01]: /images/20230127_home_assistant_debian_rpi_01.jpg
[image-02]: /images/20230127_home_assistant_debian_rpi_02.jpg
[image-03]: /images/20230127_home_assistant_debian_rpi_03.jpg
[image-04]: /images/20230127_home_assistant_debian_rpi_04.jpg




