---
title: "Script de configuración para Raspberry"
date: "2020-10-04"
creation: "2018-11-06"
description: "Vover a configurar la Raspberry desde cero puede ser una tediosa labor, con este Script lo realizo de forma automática."
thumbnail: "images/20181106_raspberry_config_script_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "raspberry"
tags:
  - "linux"
  - "bash"
draft: false
weight: 5
---
La parte más tediosa del cacharreo con la Raspberry es el tener que de nuevo comenzar la instalación desde cero y realizar siempre la misma configuración inicial.  Con este Script tengo automatizado el proceso.

**Actualización: El día que he necesitado el script me ha dado varios fallos así que toca darle una vuelta...**
<!--more-->
He intentado en todo momento que el script sea lo más "desatendido" posible y que, tras los ajustes de configuración inicial, el resto del proceso sea automático.

* Actualiza el firmware de la placa y los paquetes de Raspbian
* Cambia la contraseña para el usuario Pi
* Configura la IP y la puerta de enlace al router
* Configura el huso horario y el idioma
* Instala Git, clona e inicializa los repositorios de GitHub
* Genera una llave ssh para acceso sin contraseña
* Instala Pi-Hole
* Instala Hugo
* Instala Rclone y copia el archivo de configuración
* Instala el servidor de openvpn o wireguard mediante pivpn
* Programa un reinicio diario y commits de los repositorios

{{< borrador >}}
Configuración del crontab -e

@reboot ~/SherloScripts/python/termoflask/init.sh > ~/flask.log 2>&1
@daily ~/SherloScripts/bash/sherloscripts_push.sh
@daily ~/SherloScripts/bash/radares.sh
@daily ~/SherloScripts/bash/hugo.sh
@daily ~/SherloScripts/bash/gphotos-sync.sh
@hourly ~/SherloScripts/bash/publish.sh
40 8-15/6 * * * ~/SherloScripts/python/tiempo.py
*/5 * * * * ~/SherloScripts/python/termo.py > /home/pi/termostato.log 2>&1

{{< / borrador >}}

Para comenzar descargamos el archivo de configuración y lo dotamos de permisos de ejecución.

```
wget https://raw.githubusercontent.com/sherlockes/SherloScripts/master/bash/raspi-config.sh
chmod +x raspi-config.sh
```

Con el comando `nano raspi-config.sh` editamos los siguientes parámetros
* Contraseña para el usuario "pi"
* Ip fija de nuestra red local que queremos asignar a la raspberry
* Ip del router o puerta de enlace
* Dirección de correo, nombre y repositorios de GitHub
* Ruta al fichero de configuración de Rclone
* Desactivar las partes del Script que no deseamos que se instalen

Ahora sólo resta ejecutar el script de configuración

```
./raspi-config.sh
```

El Script completo es posible encontrarlo en mi cuenta de [GitHub]

[GitHub]: https://github.com/sherlockes/SherloScripts/blob/master/bash/raspi-config.sh
[11]: https://www.systutorials.com/39549/changing-linux-users-password-in-one-command-line/
[12]: https://pi-hole.net/
[13]: https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8
