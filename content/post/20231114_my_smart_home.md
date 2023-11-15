---
title: "Mi casa inteligente desde cero"
date: "2023-11-14"
creation: "2023-11-14"
description: "Paso a paso como construyo mi casa inteligente en la Raspberry con Home Assistant."
thumbnail: "images/20231114_my_smart_home_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "home assistant"
draft: true
weight: 5
---
Resumen de introducción
<!--more-->
### Instalando Debian 12
[link](https://community.home-assistant.io/t/installing-home-assistant-supervised-on-a-raspberry-pi-using-debian-12/247116 "Home assistant supervisado")

En la guía está descrito para la instalación con monitor y teclado. Para hacerlos sin periféricos en modo "headless" antes de poner el usb en la Raspberry hay que:
 - Acceder a la partición "RASPIFIRM"
 - Editar el archivo "sysconf.txt"
 - Descomentar la línea "#root_authorized_key="
 - A continuación incluir nuestra llave pública
 - Guardar el archivo
 - Sacar la memoria usb y ponerla en la Raspberry
 - Esperar un par de minutos a que arranque
 
 >La llave ssh la podemos encontrar en el directorio "~/.ssh/id_rsa.pub" y la podemos editar para ver el contenido con cualquier editor de texto. Importante copiar la llave completa, "ssh-rsa xxxxxxxxx". Si la llave no se encuentra, ejecuta el comando `ssh-keygen`
 
 - Antes de seguir deberemos averigura la IP que el router de ha asignado a la Raspberry. Es posible utilizar "nmap", "nast" o simplemente la app "Fing" en nuestro smartphone para conseguirlo.
 - Nos logeamos en la raspberry via ssh mediante `ssh root@ip`
 - Editamos el archivo "/etc/network/interfaces.d/eth0" con lo siguiente
 
``` bash
auto eth0         
iface eth0 inet static
    address 192.168.10.202    
    netmask 255.255.255.0       
    gateway 192.168.10.1     
```
> Con esto definimos la IP local de la raspberry a la "192.168.10.202" para que no sea el servidor DHPC quien se la asigne. Atención que si la IP ha sido utilizada con anterioridad se nos mostrará una advertencia para eliminar la llave ssh.

A partir de aquí seguimos por el punto 1.4 y 1.5 de la guía del enlace anterior para añadir un nuevo usuario.

### Install OS Agent, Docker and Dependencies
Seguimos por el apartado 2 de la guía

Error de resolución de DNS
Después de instalar "systemd-resolved" se corrompe la resolución de nombres de dominio (DNS) por lo que no es posible instalar Docker. Para restablecerlo hay que editar el archivo "/etc/systemd/resolved.conf" y descomentar las siguientes líneas.

``` txt
DNS=192.168.1.1
DNSStubListener=no
```

Guardar el archivo y reiniciar el servicio "systemd-resolved"

``` bash
sudo systemctl restart systemd-resolved
```

[solución](https://community.home-assistant.io/t/installing-home-assistant-supervised-using-debian-12/200253/1075)


Nada. olvidamos el método y probamos la instalación con el sistema operativo de Home assistant

- Añadir la extensión "ssh terminal"
- Cambiar la ip local (Ajustes - Sistema - Red)
- Hacks
  - [Descargar](https://hacs.xyz/)
  - Ejecutar en la terminal `wget -O - https://get.hacs.xyz | bash -`
  - Reiniciar (Herramientas para desarrolladores - YAML - Reiniciar)
  - Añadir HACS (Ajustes - Integraciones - Añadir integración - HACS)
- Wireguard
  - Abrir puerto 51820 UDP en el router para la IP de Home Assistant
  -






![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[link]: https://www.google.es

[image-01]: /images/20231114_my_smart_home_01.jpg



