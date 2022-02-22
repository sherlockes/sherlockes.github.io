---
title: "Sincronizar Google Photos desde la Raspberry"
date: "2022-02-22"
creation: "2020-12-03"
description: "Como sincronizar las imágenes de Google Photos desde la Raspberry"
thumbnail: "/images/20201203_sincronizar_gphotos_raspberry_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "raspberry"
  - "productividad"
tags:
  - "bash"
  - "google photos"
draft: false
weight: 5
---
Hasta ahora había sincronizado mi galería de Google Fotos con el NAS desde el pc de sobremesa con Linux Mint, voy a intentar hacerlo desde la Raspberry para no tener que encender el pc.
<!--more-->
Para la sincronización de una carpeta local con mi contenido de Google Photos voy a utilizar el paquete pip [gphotos-sync] y estos son los paso que he seguido hasta hacer la sincronización.

* Instalamos el gestor de paquetes pip en python 3
* Actualizamos (Si es necesario)
* Instalamos la funcion de entornos virtuales
* Creamos el directorio "gphotos-sync" y nos ubicamos en el
* Instalamos el paquete pip gphotos-sync

```
- sudo apt-get install python3-pip
- /usr/bin/python3 -m pip install --upgrade pip
- pip3 install gphotos-sync
```

Tras instalar gphotos-sync aparece una advertencia relativa a que el script se ha instalado en un directorio que no está definido como ruta por defecto para detectar nuevos comandos.

```
WARNING: The script gphotos-sync is installed in '/home/pi/.local/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
```

Para corregirlo sólo es necesario añadir la ruta al "PATH" mediante el siguiente comando.

```
export PATH=/home/pi/.local/bin:$PATH
```

Con el paquete instalado, toca generar las credenciales Oauth2 desde [Google Cloud Platform]

* Creamos un nuevo proyecto y le ponemos un nombre ("Create Project")
* Accedemos a [Photos Library API]
* Seleccionamos el proyecto que hemos creado en el desplegable superior
* Habilitamos la API (Botón "Enable")
* Accedemos a [Google Cloud Platform API] con nuestro proyecto seleccionado
* En la pestaña "OAuth consent screen" añadimos el nombre "gphotos-sync" a la aplicación
* En la pestaña "Credentials" añadimos una nueva credencial del tipo "OAuth client ID"
* Elegimos la opción "Desktop app" gphoto_client" y creamos la credencial
* Descargamos la credencial creada y la renombramos como "client_secret.json"
* Copiamos el archivo a la carpeta ".config/gphotos-sync" del usuario que la vaya a ejecutar

Este proceso está descrito en [Gphotos-sync OAuth Creation]

LLegados a esta punto ya sólo resta ejecutar el comando en el entorno virtual para que todas las fotos sean descargadas al directorio de destino

```
gphotos-sync directorio_destino
```

En mi caso, aunque el trabajo lo realiza la raspberry, las fotos quedan almacenadas en una carpeta del NAS que ha sido montada mediante sshfs y llave público/privada gracias a un [script] que se ejecuta diariamente mediante cron.

A la hora de hacerlo funcionar mediante cron me he emcontrado con el problema de que no encuentra el comando `gphotos-sync`, cosa que no ocurre cuando lo intento lanzar con la cuenta de usuario "pi" iniciada. Esto se debe a que el archivo del comando está cuardado dentro de la carpeta del usuario "pi" tal y como podemos ver si ejecutamos `type -a gphotos-sync`

``` bash
gphotos-sync is /home/pi/.local/bin/gphotos-sync
```
para solventar este problema hago una llamada a la ruta completa en lugar de al comando directamente.

> Tras unos días funcionando correctamente me ha aparecido un fallo en el montaje de la unidad de mota del NAS "read: Connection reset by peer" que he conseguido reparar habilitando nuevamente la conexión sftp del NAS

Con esto ya tenemos sincronizada nuestra galería de Google Photos en nuestro NAS. Seguro que esto es capaz de hacerlo el NAS sin ayuda de la Raspberry, pero esto será para otro día...

### Enlaces de interés
- [How to Geek - Add dir to path](https://www.howtogeek.com/658904/how-to-add-a-directory-to-your-path-in-linux/)

[Google Cloud Platform]: https://console.cloud.google.com/cloud-resource-manager
[Google Cloud Platform API]: https://console.cloud.google.com/apis/dashboard
[gphotos-sync]: https://pypi.org/project/gphotos-sync/
[Gphotos-sync OAuth Creation]: https://docs.google.com/document/d/1ck1679H8ifmZ_4eVbDeD_-jezIcZ-j6MlaNaeQiz7y0/edit?usp=sharing 
[Photos Library API]: https://console.cloud.google.com/marketplace/product/google/photoslibrary.googleapis.com
[script]: https://github.com/sherlockes/SherloScripts/blob/master/bash/gphotos-sync.sh


[Image-01]: /images/20201203_sincronizar_gphotos_raspberry_01.jpg
