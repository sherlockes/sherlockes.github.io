---
title: "Comprobar dispositivos online en Bash"
date: "2023-10-24"
creation: "2023-10-24"
description: "Aquí la explicación de como con un sencillo script compruebo que todos los dispositivos conectados a mis redes entán online."
thumbnail: "images/20231024_test_online_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: true
weight: 5
---
Cuando tienes varios dispositivos en distintas ubicaciones formando una misma red puede llegar a ser un dolor de cabeza que alguno de ellos deje de estar accesible y no darte cuenta. Así compruebo que todos ellos están conectados correctamente.
<!--more-->
Para empezar necesitamos una lista con las ip's de los dispositivos que están online. Hace mucho tiempo que leí este [artículo de atareao] en el que, entre otras cosas trata el tema del archivo de configuración de ssh. El que yo tengo tiene un aspecto como este:

``` txt
# Casa_1
Host router # 0-24
    Hostname 192.168.10.1
Host punto_acceso # 0-24
    Hostname 192.168.10.20
Host camara # 0-24
    Hostname 192.168.10.40
Host rpi # Raspberry Prod # 5-3
    Hostname 192.168.10.202
    User yo
Host rpiz # Raspberry Prod by Zerotier # 5-3
    Hostname 192.168.191.202
    User yo

# Casa_2
Host picostation # punto_aceso # 0-24
    Hostname 192.168.1.20

# Casa_3
Host embou # Router # 0-24
    Hostname 192.168.1.1

# Casa_4
Host nanostation # Antena # 0-24
    Hostname 192.168.1.23
Host nas # DS216+II # 15-1
    Hostname 192.168.1.201
    User yo
Host nasz # DS216+II by Zerotier # 15-1
    Hostname 192.168.191.201
    User yo

# Host gratito en Oracle
Host oracle servidor.ddns.net # Host gratuito Oracle # 0-24
    Hostname servidor.ddns.net
```

Está claro, en cada línea que contiene la palabra Host está declarado el nombre del mismo, la descripción y el horario en el que está encendido. En la línea siguiente la ip correspondiente al host.

Ahora crearemos un script en bash que debe realizar las siguiente funciones:
 - Leer por líneas el archivo de configuración de ssh
 - Buscar las líneas en la que aparece la palabra "Host"
 - Extraer de cada línea el nombre del host y el horario de encendido
 - Comprobar para cada host si debería estar encendido según la hora
 - En caso positivo intentar realizar un "ping" al host
 - Si el "ping" es negativo, hacer un nuevo intento
 - Guardar el resultado
 - Si hay algún fallo enviar un informe con los resultados
 
Y este es el resultado

{{ texto_externo "https://raw.githubusercontent.com/sherlockes/SherloScripts/master/bash/test-online.sh" }}

Ahora sólo falta añadir una línea al crontab de la raspberry para que ejecute el script cada hora

``` bash
@hourly ~/SherloScripts/bash/test-online.sh
```

Puedes ver este y otros de mis scripts en Bash en mi repositorio de [GitHub].

[artículo de atareao]: https://atareao.es/ubuntu/configuracion-de-ssh/
[GitHub]: https://github.com/sherlockes/SherloScripts/tree/master/bash



