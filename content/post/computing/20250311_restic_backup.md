---
title: "Backups en la nube con Restic"
date: "2025-03-18"
creation: "2025-03-11"
description: "Gestión de las copias de seguridad de los datos de contenedores dockers con Restic"
thumbnail: "images/20250311_restic_backup_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
- "rclone"
- "restic"
draft: false
weight: 5
---
Después de valorar algunas alternativas para la creación de las copias de seguridad de los datos de mis contenedores he encontrado una buena solución en restic.
<!--more-->
### Que necesito
Todos los datos que necesito para montar los contenedores que uso habitualmente la tengo guardada en la carpeta "~/dockers" con lo que el problema es muy sencillo. Tan solo tengo que hacer una copia de seguridad de esta carpeta en otro dispositivo.

### Alternativas
Comencé copiando esta carpeta comprimida al ordenador de sobremesa de forma regular o incluso subiéndola a un canal de Telegram. Empecé incluso a hacer un script para automatizar la tarea pero el otro día tuve una revelación gracias a [Atareao] y me he decidido a probar [Restic] Como gestor de la copia de seguridad. Una de las razones de peso ha sido la posibilidad que ofrece [Restic] de combinarse con [Rclone] para hacer directamente la copia en la nube.

### Que voy a utilizar
 - Restic como gestor de backups
 - Rclone como herramienta para subir el backup a la nube
 - Bash para crear un script con el que automatizar la tarea
 - Cron para programar el script
 - Claude para ayudarme en el proceso.

### Instalación de Restic y Rclone
Para linux, la instalación de [Restic] y [Rclone] es realmente sencilla

``` bash
sudo apt update
sudo apt install restic
sudo -v ; curl https://rclone.org/install.sh | sudo bash
```
El siguiente paso es configurar un remoto para [Rclone] a partir de una nube mediante el comando `rclone config` tal y como ya he explicado en otros [artículos]. En mi caso particular voy a utilizar la nube de [Mega] que ofrece gratis 50 Gb para configurar el remoto.

``` bash
sherlockes@uber:~$ rclone config
Current remotes:

Name                 Type
====                 ====
Sherlockes78_GD      drive
Sherlockes_Mega      mega
```

### Configuración del repositorio
El sitio donde se van a guardar las copias de seguridad lo llamaremos "repositorio" y es un directorio donde [Restic] va a guardar todos los datos necesarios. Para acceder al repositorio será necesaria una contraseña y el primer paso para configurarlo es inicializarlo.

``` bash
export RESTIC_PASSWORD="tu_contraseña_segura"
restic -r rclone:Sherlockes_Mega:docker_backups init
```

> En este caso estoy usando el remoto de rclone "Sherlockes_Mega" y la carpeta "docker_backups" como ubicación para el repositorio de Restic.

### Realizando la copia de seguridad
Crearemos un archivo "backup.sh" al que daremos permisos de ejecución y en el que incluiremos el siguiente contenido:

``` bash
#!/bin/bash

export RESTIC_PASSWORD="tu_contraseña_segura"
REPO="rclone:Sherlockes_Mega:docker_backups"

restic -r $REPO backup ~/dockers
```

### ¿Que más se le puede pedir?
Aunque la copia de seguridad ya funciona hay una serie de aspectos en los que se podría mejorar:
 - Excluir determinado tipo de archivos de la copia
 - Poner la contraseña en un archivo externo al script
 - Ejecución como root para evitar problemas con permisos de archivos
 - Automatizar la tarea
 
#### Excluir determinado tipo de archivos
En mi caso, dentro de las carpetas de datos hay archivos "*.mp3" que son de uso temporal y de los que no necesito hacer copia de seguridad. para esto usaremos el argumento "exclude" en el comando de Restic.

``` bash
restic -r $REPO backup ~/dockers --exclude="*.mp3"
```

#### Contraseña en archivo externo
Puesto que todos mis scripts los guardo en un repositorio público de [Github] no resulta práctico que la contraseña de mi copia de seguridad esté ahí expuesta. Restic ofrece la posibilidad de guardarla en un archivo externo.

En mi caso voy a crear el archivo ".restic-password" que únicamente contiene la contraseña y modificaré el script con lo siguiente:

``` bash
PASSWORD_FILE="/home/sherlockes/.restic-password"
restic -r $REPO --password-file $PASSWORD_FILE backup ~/dockers --exclude="*.mp3"
```

#### Ejecución como root
A la hora de realizar la copia de seguridad he de dado cuenta de que hay determinados archivos a los que mi usuario no tiene acceso por lo que me veo obligado a ejecutar la copia como "root" mediante "sudo" pero es necesario que:
 - Rclone use la configuración de mi usuario al lanzarlo como "root".
 - No pida la contraseña para poder automatizarlo posteriormente.
 
Al ejecutarlo con "sudo", rclone busca la configuración de "root" y no va a encontrar los remotos que hemos creado con nuestro usuario. Para evitar esto vamos a utilizar una variable de entorno mediante la que le vamos a pasar a Restic la ubicación del archivo de configuración de Rclone. Añadiremos lo siguiente:

``` bash
export RCLONE_CONFIG="/home/sherlockes/.config/rclone/rclone.conf"
```

Para que la ejecución mediante "sudo" haga uso de las variables de entorno debemos usar el argumento "-E" y para que no nos pida la contraseña al ejecutar restic añadiremos la siguiente línea al archivo "/etc/sudoers" usando el comando `sudo visudo"

``` bash
sherlockes ALL=(ALL) NOPASSWD:SETENV: /usr/bin/restic
```

ya con esto sólo nos queda modificar el script para que restic sea lanzado bajo "sudo"

``` bash
sudo -E restic -r $REPO --password-file $PASSWORD_FILE backup ~/dockers --exclude="*.mp3"
```

#### Automatizar la tarea
El último paso es que la tarea se ejecute automáticamente. Yo he escogido el método del "cron" por ser el más sencillo de todos.

 - Ejecutamos `crontab -e`
 - Añadimos al final `@reboot ~/backup.sh > ~/backup.log 2>&1`
 - Guardamos mediante `Ctrl + x`
 
A partir de esto, cada vez que arranca el servidor se realizar una copia de seguridad de los datos de los contenedores docker que hemos seleccionado.
 

### Script completo
Puedes encontrar el [script] en mi repositorio de [Github]

{{ texto_remoto "https://raw.githubusercontent.com/sherlockes/SherloScripts/refs/heads/master/bash/backup_dockers.sh" }}


### Enlaces de interés
- [Atareao](www.atareao.es)

[artículos]: https://sherblog.es/tags/rclone/
[Atareao]: https://www.atareao.es
[Claude]: https://claude.ai
[Github]: https://github.com/sherlockes/SherloScripts/tree/master/bash
[Mega]: https://mega.nz
[Rclone]: https://rclone.org
[Restic]: https://restic.net
[script]: https://github.com/sherlockes/SherloScripts/blob/master/bash/backup_dockers.sh



