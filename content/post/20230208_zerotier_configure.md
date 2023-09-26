---
title: "Instalación y configuración de Zerotier"
date: "2023-08-20"
creation: "2023-02-08"
description: "Descripción"
thumbnail: "images/20230208_zerotier_configure_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: true
weight: 5
---
Hace casi cinco años que empecé a usar [Zerotier] tal y como en su día expliqué en este [artículo]({{<relref"20190314_zerotier.md">}}) como consecuencia de un problema con los puertos del router. Ahora lo reedito con todo lo que he aprendido en este tiempo.

<!--more-->
### Creación de la red
Antes de nada, deberemos darnos de alta mediante una cuenta en [my.zerotier.com] y posteriormente crear una red a la que podremos asignar un rango de IP's y que tendrá un identificador que nos servirá para añadir nuevos usuarios.

> Es importante definir como privada la red dentro de las opciones para que cualquiera que conozca el identificador no se pueda añadir a la misma sin nuestro consentimiento.

![image-01]

La asignación de IP's la dejo de forma automática para el rango elegido aunque posteriormente a la primera conexión le asigno manualmente una fija que me permite ponerla también en el archivo de configuración ssh de todos los equipos.

### Instalación en debian y derivados
La instalación de [Zerotier] en Debian y derivados es tan sencilla como la ejecución de una línea de código

```Bash
curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import && \
if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi
```

De esta forma lo instalo tanto en los dispositivos con [Linux Mint] como con [Raspberry Pi OS]

Al terminar la instalación se muestro por consola un identificador del equipo que nos valdrá para, desde la configuración de la red de [my.zerotier.com], añadir un nuevo miembro.

![image-02]

También es posible añadir a la red al nuevo miembro desde la terminal del equipo para el que se ha creado con el siguiente comando

```Bash
sudo zerotier-cli join [identificador de la red]
```

### Instalación en Synology (DSM7)
Desde la versión 7 de DSM, Synology no permite la instalación de paquetes de terceros por lo que la instalación de [Zerotier] hay que realizarla mediante un contenedor. Para mi DS920+ ha sido tan sencillo como seguir al pie de la letra las [instrucciones para Synology].

### Comandos de consola
Desde la terminal es posible comprobar el estado de la conexión mediante [Zerotier] o ejecutar otras acciones gracias a los siguientes comandos.

| Comando                             | Descripción           |
| -----------                         | -----------           |
| zerotier-cli status                 | Estado de la conexión |
| zerotier-cli join ################  | Unir a una red        |
| zerotier-cli leave ################ | Salir de una red      |
| zerotier-cli listnetworks           | Listar redes añadidas |
| zerotier-cli dump                   | Debug de errores      |


### Enlaces de interés
- [Zerotier - Install on Linux](https://www.zerotier.com/download/#downloadLinux)
- [Zerotier - CLI](https://zerotier.atlassian.net/wiki/spaces/SD/pages/29065282/Command+Line+Interface+zerotier-cli)
- [TechOverflow - Join Zerotier Network](https://techoverflow.net/2022/08/19/how-to-join-network-using-zerotier-cli-on-linux)


[StackOverflow - Check Host]: https://stackoverflow.com/questions/18123211/checking-host-availability-by-using-ping-in-bash-scripts
[StackOverflow - Extract IP]: https://stackoverflow.com/questions/21336126/linux-bash-script-to-extract-ip-address
[TechOverflow - Zerotier error port 9993]: https://techoverflow.net/2022/09/27/how-i-fixed-zerotier-one-fatal-error-cannot-bind-to-local-control-interface-port-9993/




[instrucciones para Synology]: https://docs.zerotier.com/devices/synology/
[Linux Mint]: https://linuxmint.com
[my.zerotier.com]: https://my.zerotier.com
[Raspberry Pi OS]: https://www.raspberrypi.com/software/
[Zerotier]: https://www.zerotier.com

[image-01]: /images/20230208_zerotier_configure_01.jpg
[image-02]: /images/20230208_zerotier_configure_02.jpg


