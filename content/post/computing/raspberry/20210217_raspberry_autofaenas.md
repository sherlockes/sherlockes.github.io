---
title: "Que hace la raspberry sin mi"
date: "2021-12-22"
creation: "2021-02-17"
description: "Este es un pequeño resumen de lo que la Raspberry hace por mi cuando yo no estoy delante de ella"
thumbnail: "/images/20210217_raspberry_autofaenas_00.jpg"
disable_comments: true
authorbox: false
toc: True
mathjax: false
categories:
- "raspberry"
tags:
- "bash"
draft: false
weight: 5
---
La Raspberry me sirve para hacer muchas cosas aunque aquí sólo voy a contar ahora las que hace ella sola cuando yo no estoy delante.
<!--more-->

Como todas las automatizaciones que tengo en la Raspberry son mediante cron, sacarlas a flote es tan simple como ejecutar `crontab -l` para obtener lo siguiente.

{{< texto_externo "/files/crontab.txt" >}}

Si no tienes claro como realizar la programación en cron, es muy recomendable visitar [crontab guru] para realizar unas pruebas con el tema de los números y asteriscos para determinar la frecuencia de realización de la tarea. A continuación puedes encontrar tanto las tareas que se ejecutan actualemtne como las que en su día han sido ejecutadas y que ya no empleo.

### webdav.sh
Gracias a esta línea en el cron, cada vez que arranca la raspberry se ejecuta el archivo [webdav.sh] (Si, sólo tiene dos líneas) para, mediante rclone, crear un servidor webdav con el contenido multimedia que tengo cifrado en mis nubes públicas. Con este servidor en marcha, reproducir este contenido en cualquier dispositivo mediante Kodi es coser y cantar.

```
@reboot /home/pi/SherloScripts/bash/webdav.sh > /home/pi/logs/webdav.log 2>&1
```
El resultado del script se guarda en el archivo "webdav.log".


### pidiario.sh
Este script se ejecuta todos los días y es una pequeña recopilación de tareas que puedes encontrar en el archivo [pidiario.sh] de mi [repositorio] de [GitHub]

```
@daily ~/SherloScripts/bash/pidiario.sh 2>&1 ~/logs/diario.log
```

- Actualiza Hugo
- Sincroniza la carpeta SherloScripts de mi repositorio
- Actualiza los repos de GitHub
- Comprueba el estado de varias nubes públicas
- Sincroniza las nubes de contenido multimedia
- Comprueba la sincronización de las carpetas de las nubes

La salida que gegera este script es guardada en el archivo "diario.log" para que la pueda consultar en caso de que haya algún problema.

### radares.sh
```
@weekly ~/SherloScripts/bash/radares.sh
```
Una vez a la semana, este script descarga la base de radares de tráfico de www.todopoi.es, quita todo lo innecesario y guarda el resto en una carpeta de Google Drive desde donde Tasker para Android hará el resto para tener al día la detección de radares cundo voy en el coche.

### publish.sh
Esta placa de menos de 40€ también es la encargada de, a partir del contenido alojado en una carpeta de mi cuenta en la nube de Google Drive, publicar en GitHub el contenido estático de este Blog.

```
@hourly ~/SherloScripts/bash/publish.sh
```
Cada hora, busca nuevo contenido en Google Drive para publicar en el Blog o maquetas como post. Genera el ontenido estático en Hugo y lo sincroniza con el repositorio de Github. Todas las tareas de publicación se encuentran en el archivo [publish.sh].

### gphotos-sync.sh
```
30 0 * * * ~/SherloScripts/bash/gphotos-sync.sh
```
Hubo un tiempo mejor en el que el Ds216+II de Synology con sus utilidades propias era capaz de sincronizar con una carpeta en el mismo el contenido de Google Photos y esa misma carpeta sincronizarla con Amazón Drive para no tener "todas manzanas en la misma cesta".

Ahora, ambos han complicado las cosas y hasta ahora sólo he sido capaz de que todos los días a las 0:30 se realice una sincronización del contenido de Google Photos mediante Gphotos-Sync. en una carpeta del NAS gracias a este Script.


### Termostato (obsoleto)
Hace ya un tiempo que cambié el comercial Netatmo que tan buen resultado me dio durante más de tres años por un [termostato en la raspberry] con el que estoy igual de contento pero mucho más orgulloso. Para funcionar necesita tres entradas en el cron.

> Ahora, el control de la temperatura de casa está implementado en Home Assistant y este desarrollo en Python y Flask ha caído en desuso.

#### init.sh
```
@reboot ~/SherloScripts/python/termoflask/init.sh
```
Este script se ejecuta cada vez que arranca la raspberry y tiene la única función de arrancar el servidor web que flask lleva integrado para poder visualizar la interface del termostato.

#### mqtt.py
```
@reboot sleep 15 && ~/SherloScripts/python/termoflask/mqtt.py
```
Además de la temperatura en la habitación en la que está ubicada la raspberry, se capturan también los datos de otra habitación mediante mqtt y el broker [mosquitto] (instalado en la raspberry) gracias a una segunda sonda de Tª y un pequeño nodemcu.

El servidor debe arrancarse cada vez que se reinicia la raspberry y tiene la peculiaridad de tener que esperar unos segundos (15) para no dar falo con la conexión de red.

#### termo.py
```
*/5 * * * * ~/SherloScripts/python/termoflask/termo.py
```
Este es el corazón del termostato, cada 5 minutos se ejecuta el script para calcular consignas y estado de la calefacción en función de las temperaturas y de lo establecido en el panel de control.
	
### Teledown (obsoleto)
La raspberry es tambien la encargada de [descargar arcivos de telegram] cuando no estoy delante del ordenador y los envío desde el teléfono gracias a [telegram-download-daemon] para lo que necesito la ejecución de unos scripts.

> Gracias al fantástico script de Dekkar ya no utilizo este método para descargar archivos de telegram al nas.

#### teledown.sh
```
@reboot sleep 15 && ~/SherloScripts/bash/teledown.sh
```
Es el corazon de las descargas y encargado de vigilar el canal para descargar todos los archivos que por ahí pasen. Se ejecuta cada vez que arranca la raspberry con un retraso de 15 sg para evitar evitar los problemas con el establecimiento de las conexiones de red.

#### teledown_move.sh
```
@hourly ~/SherloScripts/bash/teledown_move.sh
```
La raspberry está encendida todo el día, pero el NAS no, este script se ejecuta cada hora para comprobar si el NAS está encendido y mover a este los archivos descargados por la raspberry.


### hugo.sh (obsoleto)
```
@daily ~/SherloScripts/bash/hugo.sh
```
Cada día, comprueba e instala la posible actualización de Hugo para instalar en la propia Raspberry

> Esta labor la he incluido dentro de las tares que realiza el script [pidiario.sh]

### sherloscripts_push.sh (obsoleto)
```
@daily ~/SherloScripts/bash/sherloscripts_push.sh
```
Gracias a [Insync] y la integración de Google Drive con Android, me resulta mucho más sencillo y práctico trabajar sobre una sincronización con la nube que sobre un repositorio. Este Script mueve los cambios todos los días a las 0:00 de la nube de Google al repositorio de GitHub.

Además comprueba también el estado de varias nubes donde tengo alojado parte de mi colección multimedia y realiza una sincronización entre ellas.

> Esta labor ahora está incluida en el archivo [pidiario.sh].

### tiempo.py (obsoleto)
```
0 8,14 * * * ~/SherloScripts/python/tiempo.py
```
Todos los días a las 8:00 y a las 14:00, este script recoge la información del tiempo de la Aemet y me lo envía al teléfono mediante un mensaje de Telegram.

> Ahora esta imformación la recibo directamente gracias a Home Assistant, ya no necesito este script.


[crontab guru]: https://crontab.guru
[descargar archivos de telegram]: https://sherblog.pro/descargar-archivos-de-telegram
[GitHub]: https://github.com
[insync]: https://www.insynchq.com
[mosquitto]: https://mosquitto.org
[pidiario.sh]: https://github.com/sherlockes/SherloScripts/blob/master/bash/pidiario.sh
[publish.sh]: https://github.com/sherlockes/SherloScripts/blob/master/bash/publish.sh
[repositorio]: https://github.com/sherlockes/SherloScripts
[telegram-download-daemon]: https://github.com/alfem/telegram-download-daemon
[termostato en la raspberry]: https://sherblog.pro/termostato-raspberry/
[webdav.sh]: https://github.com/sherlockes/SherloScripts/blob/master/bash/webdav.sh
