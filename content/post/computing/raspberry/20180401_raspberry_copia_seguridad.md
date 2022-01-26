---
title: "Raspberry Copia de seguridad"
date: "2018-04-09"
description: "Sería de mal gusto perder la web por un fallo de la tarjeta sd."
thumbnail: "images/20180409_raspberry_backup.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Raspberry"
tags:
  - "Desarrollo"
draft: false
weight: 15
---
Antes de pensar en como realizar una copia de seguridad para las instalaciones de [WordPress](http://es.wordpress.org) y [Dokuwiki](https://www.dokuwiki.org) que hasta ahora hemos instalado en la Raspberry hay que hacerlo en los datos que son estrictamente necesarios para poder restaurar ambas instalaciones ante una pérdida de los mismos.

En el caso de Wordpress, debemos guardar la base de datos y la carpeta "wp-content".  Para el caso de la Wiki, [aquí](https://www.dokuwiki.org/faq:backup) podemos ver las carpetas necesarias que se recomienda guardar aunque yo he optado por prescindir de las versiones antiguas de páginas y archivos multimedia.

La copia de seguridad la realizaré en tres pasos:
  - Copia desde el directorio de apache hasta un directorio de Backups en la Raspberry mediante rsync y cron
  - Copia desde la Raspberry a un directorio del NAS mediante ftp
  - Copia de seguridad versionada desde el NAS hasta Google Drive mediante HyperBackup

Pues bien, para comenzar creamos una carpeta en el directorio "home" del usuario Pi llamada "scripts" y en ella creamos el archivo "bckps.sh" al que dotaremos de pemisos de ejecución (sudo chmod 700 bckps.sh) con el siguiente código:

```
#!/bin/sh
# -*- ENCODING: UTF-8 -*-

# Borra el directorio backups y lo vuelve a crear
rm -rf /home/pi/backups/
mkdir /home/pi/backups/

# Copia la carpeta wp-content de sherblog.pro a backups
mkdir /home/pi/backups/sherblog/
rsync -rtv /var/www/html/sherblog/wp-content /home/pi/backups/sherblog

# Crea la carpeta wiki y copia en ella configuración y datos de sherlowiki
mkdir /home/pi/backups/sherlowiki
rsync -rtv /var/www/html/wiki/conf /home/pi/backups/sherlowiki/
mkdir /home/pi/backups/sherlowiki/data
rsync -rtv /var/www/html/wiki/data/pages /home/pi/backups/sherlowiki/data/
rsync -rtv /var/www/html/wiki/data/meta /home/pi/backups/sherlowiki/data/
rsync -rtv /var/www/html/wiki/data/media /home/pi/backups/sherlowiki/data/
rsync -rtv /var/www/html/wiki/data/media_meta /home/pi/backups/sherlowiki/data/

# Exporta, comprime y borra el original de la base de datos de sherblog.pro
mkdir /home/pi/backups/sherblog/db/
mysqldump -u<usuario> -p<contraseña> sherblog > /home/pi/backups/sherblog/db/sherblog.sql
cd /home/pi/backups/sherblog/db/
tar -zcvf $(date +%Y%m%d)_sherblog_sql.tgz sherblog.sql
rm sherblog.sql
exit
```

Ahora editamos el crontab

```
crontab -e
```

e introducimos al final una nueva tarea mediante la sentencia


```
@daily /home/pi/scripts/bckps.sh
```


Con esto una vez al día se ejecutará la tarea de copias de seguridad incluidas en el archivo "bckps.sh".  Es posible que hay que reiniciar el cron para que funcione la ejecución correctamente.

```
service cron restart
```

El siguiente paso es copiar la carpeta "backups" de la raspberry al NAS, para lo que, desde este segundo y mediante al programador de tareas, ejecuto una vez al día la siguiente instrucción:

```
wget -m -N ftp://pi:password@192.168.1.202/backups -P /volume1/backups
```

Desde aquí, crear una copia de seguridad en Synology con la aplicación de DSM Hyperbackup sobre google drive ya es coser y cantar.
