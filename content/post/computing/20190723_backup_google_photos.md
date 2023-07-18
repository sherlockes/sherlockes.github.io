---
title: "Backup de Google Photos"
date: "2019-09-20"
creation: "2019-07-23"
description: "Cuando Google lo pone difícil hay que buscar alternativas."
thumbnail: "/images/20190723_backup_google_photos_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "linux"
tags:
  - "gphoto-sync"
  - "bash"
draft: false
weight: 5
---
Desde principios del mes de Julio de 2019, todos los que realizamos una copia de seguridad de de las imágenes subidas a Google Photos una forma automatizada hemos pasado a tener un serio problema que cada vez estoy más cerca de solucionar.
<!--more-->

Hasta ahora, mi Synology realizaba una copia de seguridad de Google Photos gracias a Cloud Sync y la posible sincronización entre las imágenes en Google Photos y una carpeta de Google Drive que se ofrecía. Pero esta capacidad de representar de todas las fotografías en una carpeta de Drive ha sido eliminada por Google y con ello casi todas las posibilidades de una copia de seguridad automática.

Poco a poco me voy acercando a la solución para esta copia de seguridad y según me vaya aproximando a la solución definitiva iré actualizando este artículo.

## Sincronizando en Linux Mint

Pues bien, es necesario tener instalada y corriendo al menos la versión 3.6 de Python `python -V` y continuamos con la instalación del administrador de paquetes y configuramos el path donde los paquetes instalados de Python son almacenados

`sudo apt install python3-pip`
`echo "export PATH=\"\$PATH:\$HOME/.local/bin\"" >> ~/.bashrc"`

En caso de error es posible que sea necesario actualizar el administrador de paquetes de Python (pip), para lo cual usaremos el siguiente comando

`python3 -m pip install --user --upgrade pip`

Con esto ya es posible instalar [Gphotos-Sync] desde el administrador de paquetes para lo cual instalaremos en primer lugar el paquete "pienv", crearemos el directorio "gphotos-sync" en nuestro "home" y desde dentro de este directorio instalaremos "gphotos-sync"

```
python3 -m pip install pipenv
mkdir ~/gphotos-sync
cd ~/gphotos-sync
pipenv install gphotos-sync
```
Ya estamos en condiciones de comenzar la sincronización con la carpeta local "gphotos-sync" mediante el comando:

`pipenv run gphotos-sync ~/gphotos-sync`

La primera vez que ejecutemos el comando se no solicitará el acceso a nuestra cuenta de Google por parte del script de "gphotos-sync" para lo cual pegaremos en el navegador el enlace que aparece en la terminal, concederemos los permisos necesarios y copiaremos el código que Google nos devuelve nuevamente en la terminal.

![imagen_01]

En este punto y si no tiene lugar ningún error dejaremos el script corriendo durante un rato puesto que se van a descargar todas las fotos de nuestra cuente de Google Photos

> En raspberry `pipenv --python /usr/bin/python3`

### Sincronizando los archivos con el Nas
En mi caso particular voy a guardar las fotos en una carpeta del Nas por lo que para no realizar la operación dos veces voy a montar esta carpeta en el ordenador de sobremesa con Linux Mint y correré el programa sobre dicha carpeta.  Para ello utilizo el siguiente script.

```sh
#!/bin/bash

###################################################################
#Script Name: Backup Google Photos
#Description: Monta la carpeta de copia de seguridad de Google Photos
#             en el nas y realiza la sincronización desde Google
#Args:
#Creation/Update: 20190911/20190918
#Author: www.sherblog.pro
#Email: sherlockes@gmail.com
###################################################################

# Monta la carpeta del nas "gphotos-sync" como una unidad en la carpeta local "gphotos-sync"
sshfs sherlockes@192.168.1.200:../../home/gphotos-sync ~/gphotos-sync

# Ejecuta el script en python gphotos-sync
pipenv run gphotos-sync ~/gphotos-sync

# Desmonta la unidad
fusermount -u ~/gphotos-sync
```

Con esto, basta con un simple click para sincronizar la galería de Google Photos con el Nas.

> No he incluido este script en cron puesto que ni el ordenador de sobremesa ni el Nas están encendidos continuamente.

[Gphotos-Sync]: https://github.com/gilesknap/gphotos-sync

[imagen_01]: /images/20190911_gphotos_synnc_01.jpg
