---
title: "Rclone en Synology"
date: "2019-09-15"
creation: "2019-09-15"
description: "Instalación manual y automática de Rclone en Synology"
thumbnail: "images/20190915_rclone_synology.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
- "sherver"
tags:
- "rclone"
- "synology"
draft: false
weight: 5
---
Llega el momento en el que tienes que instalar rclone en tu nas de Synology y te encuentras con que no funciona la misma instalación que has hecho en la Raspberry o Debian
<!--more-->
La [instalación de rclone] en un NAS de Synology no es tan fácil como en una instalación linux convencional, continuación muestro la forma de la que lo he llevado a cabo.

### Instalación

Si entramos en la web de Rclone podemos ver que la instalación es tan sencilla como una línea de código

```
curl https://rclone.org/install.sh | sudo bash
```

Pero al hacerlo en el NAS de Synology esta instalación se queda colgada por  problemas con la petición de permisos de sudo. Para evitar este problema es posible instalar rclone como root, para lo cual ejecutaremos

```
sudo -i
curl https://rclone.org/install.sh | sudo bash
```

Con todo tambien es posible realizar una instalación de forma manual con los siguientes comandos tal y como se indica en la web oficial

```
curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
7z x rclone-current-linux-amd64.zip
cd rclone-*-linux-amd64
sudo cp -f rclone /usr/bin/
sudo chown root:root /usr/bin/rclone
sudo chmod 755 /usr/bin/rclone
```
Los comandos anteriores realizan las siguientes acciones.

- Descargar la ultima versión de Rclone
- Descomprimir el archivo descargado
- Entrar en el directorio que hemos descomprimido
- Copiar el binario al directorio “usr/bin” (La opción -f sobreescribe el existente)
- Establecer a “root” como el propietario del archivo
- Otorgar los premisos de lectura/escritura necesarios
- Si la instalación se ha realizado de forma correcta, el comando rclone version nos mostrará la versión de Rclone instalada.

### Mi uso de Rclone

En el Nas, uso Rclone para montar en el arranque una unidad de red en la que tengo gardados algunos vídeos. Para esto utilizo el programador de tareas con una tarea que, en el arranque, ejecute un “Script definido por el usuario”.

```
rclone mount Sherloflix_en: /var/services/video/Sherloflix --allow-other --config=/var/services/homes/sherlockes/.config/rclone/rclone.conf --daemon
rclone - Comando principal
```

- mount - Modificador para montar la nube en local
- Sherloflix_en - Nombre de la nube configurada en Rclone
- /var/services/video/Sherloflix - Carpeta del NAS donde voy a montar el contenido
- --allow-other - Argumento para permitr el acceso de otros usuarios
- --config=/var/services/.../rclone.conf - Ruta al archivo de configuración
- --daemon - Ejecuta el comando como servicio para dejar la nube montada

> Si no tienes claro donde está guardado el archivo de configuración, basta con que ejecutes `rclone config` file desde la terminal del Nas y te mostrará la ruta del archivo de configuración.

Aunque si ejecutas directamente Rclone desde la terminal no es necesario incluir en parámetro –config, cuando lo haces a través del programador de tareas se convierte en imprescindible introducirlo si no quieres obtener un log de errores como el siguiente.

```
ERROR : Couldn't find home directory or read HOME or XDG_CONFIG_HOME environment variables.
ERROR : Defaulting to storing config in current directory.
ERROR : Use --config flag to workaround.
ERROR : Error was: exec: "getent": executable file not found in $PATH
NOTICE: Config file "/usr/syno/synoman/webapi/.rclone.conf" not found - using defaults
Failed to create file system for "Sherloflix_en:": didn't find section in config file
/var/services/homes/sherlockes/temp/sherloflix.sh: line 2: --daemon: command not found
```

Con esto, la nube queda montada en una carpeta del Nas cada vez que este arranca.

### Enlaces de interés
https://rclone.org/install/#linux-installation-from-precompiled-binary<br> https://superuser.com/questions/406915/extract-7z-files-with-standard-linux-tools<br> https://bitnarios.com/guia-definitiva-synology-como-instalar-configurar-rclone-y-sincronizarlo-con-google-drive/<br>

[instalación de rclone]: https://rclone.org/downloads/
