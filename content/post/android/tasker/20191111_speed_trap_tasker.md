---
title: "Radares de tráfico en Android"
date: "2020-01-07"
creation: “2019-11-13”
description: "Usando Tasker para avisar de radares de tráfico cuando vas en el coche."
thumbnail: "images/20191113_radares_android_00.jpg"
toc: false
mathjax: false
categories:
  - "tasker"
  - "diseño"
tags:
  - "android"
  - "SpeedTrap"
draft: false
weight: 5
---
En el coche resulta útil un avisador de radares para "levantar el pie" en determinados momentos o simplemente para ser más riguroso con el respeto de la velocidad máxima de la vía. Para esto también uso Tasker y aquí voy a mostrar cómo lo hago.
<!--more-->

## Instalando
Un uso más que le estoy dando a [tasker] dentro de mi teléfono Android es para el aviso de radares cuando voy en el coche. Para ello hago uso de la aplicación [Speed Trap] y del [plugin para Tasker] que, aunque no son muy intuitivos me permiten una integración total con [tasker]. Una vez que tengamos ambos instalados ya podemos crear la tarea que lo ejecute.

En mi caso uso el perfil "En el coche" con una tarea de entrada y otra de salida tal y como se puede ver en la siguiente imagen.

![imagen_01]

Cuando [Tasker] detecta que me he conectado al Bluetooth del coche ejecuta la tarea "Subir al coche" en la cual, entre otras, está la acción para activar el indicador de radares [Speed Trap].

![imagen_02]

La configuración de esta acción es muy simple ya que sólo hay que indicar si comienza el servicio ("ACTIVADO") o se detiene el servicio ("DESACTIVADO")

![imagen_03]

Ahora todo lo que resta es actualizar la base de datos de radares para que el sistema comience a funcionar.

> En la tarea de salida del perfil "En el coche" habrá que incluir la acción para desactivar [Speed Trap] para que se detenga el servicio y no gaste más batería de la necesaria.


## Actualizando...
Sin duda alguna el gran problema de usar [Speed Trap] son las actualizaciones de la base de datos de radares que, lejos de ser automáticas y desatendidas, son un tedioso proceso completamente manual. Para hacerlo un poco más llevadero he creado un script en bash que puedes ver en mi [repositorio en GitHub] y que descarga los radares desde la web [Todo-poi.es], los acondiciona según los tipos de que dispone [Speed Trap], los renombra y los guarda en una carpeta de Google Drive (Usando rclone).

```
#!/bin/bash
# -*- encoding: utf-8 -*-

###################################################################
#Script Name: Radares
#Description: Descarga de radares y copia a Google Drive
#Args: N/A
#Creation/Update: 20191112/20191113
#Author: www.sherblog.pro                                                
#Email: sherlockes@gmail.com                                           
###################################################################

# ----------------------------------
# Definición de variables
# ----------------------------------
carpeta=~/radares

# ----------------------------------
# Crear la carpeta local
# ----------------------------------
mkdir $carpeta

# ----------------------------------
# Descargar archivos
# ----------------------------------
curl 'https://www.todo-poi.es/radar/GARMIN_RADARES/garminvelocidad 3xx-5xx-6xx, Zumo, StreetPilot c550, 2720, 2820, 7200 y 7500.zip' -o $carpeta/radares_1.zip
curl 'https://www.todo-poi.es/radar/GARMIN_RADARES/garmintipo 3xx-5xx-6xx, Zumo, StreetPilot c550, 2720, 2820, 7200 y 7500.zip' -o $carpeta/radares_2.zip

# ---------------------------------------
# Descomprimir archivos y borrar sobrante
# ---------------------------------------
unzip $carpeta/radares_1.zip -d $carpeta/
rm -rf $carpeta/PoiLoader
cp $carpeta/'garminvelocidad 3xx-5xx-6xx, Zumo, StreetPilot c550, 2720, 2820, 7200 y 7500'/*.csv $carpeta
rm -rf $carpeta/'garminvelocidad 3xx-5xx-6xx, Zumo, StreetPilot c550, 2720, 2820, 7200 y 7500'

unzip $carpeta/radares_2.zip -d $carpeta/
rm -rf $carpeta/PoiLoader
cp $carpeta/'garmintipo 3xx-5xx-6xx, Zumo, StreetPilot c550, 2720, 2820, 7200 y 7500'/*.csv $carpeta
rm -rf $carpeta/'garmintipo 3xx-5xx-6xx, Zumo, StreetPilot c550, 2720, 2820, 7200 y 7500'
rm $carpeta/radares_*.zip

# ----------------------------------
# Uniendo archivos
# ----------------------------------
rm $carpeta/*[0-9].csv
rm $carpeta/*variable.csv
cat $carpeta/*_tramo*.csv $carpeta/*_tunel*.csv > $carpeta/R_BBS_tramo.csv
rm $carpeta/*_tramo_*.csv
rm $carpeta/*_tunel*.csv
cat $carpeta/R_BBS_curvas_peligrosas.csv $carpeta/R_BBS_puntos_negros.csv > $carpeta/03_cajas.csv
rm $carpeta/R_BBS_curvas_peligrosas.csv
rm $carpeta/R_BBS_puntos_negros.csv
rm $carpeta/R_BBS_Alcoholemia.csv


# ----------------------------------
# Renombrando archivos
# ----------------------------------
mv $carpeta/R_BBS_fijos_total.csv $carpeta/01_fijos.csv
mv $carpeta/R_BBS_camu_total.csv $carpeta/02_moviles.csv
mv $carpeta/R_BBS_Foto.csv $carpeta/04_camaras.csv
mv $carpeta/R_BBS_tramo.csv $carpeta/05_tramo.csv
mv $carpeta/R_BBS_semaforos.csv $carpeta/06_semaforos.csv
mv $carpeta/R_BBS_APR.csv $carpeta/07_restringido.csv

# ----------------------------------
# Sincronizando con Google Drive
# ----------------------------------
rclone sync $carpeta dd_gdu:Radares

# ----------------------------------
# Borrando los rastros
# ----------------------------------
rm -rf $carpeta
```

A partir de aquí yo tengo configuradoen la Raspberry que está todo el día encendida una tarea mediante cron segń la cual se ejecutará este archivo todos los lunes a las 0:00. Para ello

* Editamos en cron con `crontab -e`
* Añadimos la línea `0 0 * * 1 /home/pi/radares.sh`

Con esto ya tendremos disponible desde la aplicación [Speed Trap] en el teléfono el acceso a las actualizaciones de una forma rápida y sencilla gracias a nuestra cuenta de google drive. Con todo esta actualización se deberá hacer de forma manual para cada grupo de radares siguiendo los siguientes pasos.

- Abrimos SpeedTrap
- Seleccionamos el grupo a actualizar
- Opción "CSV (Garmin)"
- Marcamos la nube
- Descargamos de Google Drive
- Seleccionamos la cuenta de Google
- Entramos en la carpeta "Radares"
- Archivo del grupo y seleccionar
- Cargar los datos al programa

{{< youtube 1lgfjkHoYBc >}}

Es una pena tener que hacer este proceso de forma manual, quizás en futuras actualización de la aplicación...


[Speed Trap]: https://play.google.com/store/apps/details?id=com.balda.speedtrappro&hl=es
[plugin para Tasker]: https://play.google.com/store/apps/details?id=com.balda.autospeedtrap&hl=es_419
[Todo-poi.es]: https://www.todo-poi.es
[repositorio en GitHub]: https://github.com/sherlockes/SherloScripts
[tasker]: https://play.google.com/store/apps/details?id=net.dinglisch.android.taskerm&hl=es

[imagen_01]: /images/20191113_radares_android_01.jpg
[imagen_02]: /images/20191113_radares_android_02.jpg
[imagen_03]: /images/20191113_radares_android_03.jpg
