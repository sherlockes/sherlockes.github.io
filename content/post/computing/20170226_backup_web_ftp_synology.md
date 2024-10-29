---
title: "Backup de la web al Nas mediante ftp y ssh en Synology"
date: "2017-02-26"
creation: "2017-02-26"
description: "Backup de la carpeta wp-content al nas mediante ftp"
thumbnail: "images/20170226_backup_ftp_01.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Sherver"
  - "WordPress"
tags:
  - "Synology"
draft: false
weight: 5
---
Esta vez y como casi siempre el objetivo es sencillo, crear una copia de seguridad del contenido de una página web al [Nas][1] que tengo en casa, de una forma automática y periódica.

Después de valorar varias alternativas, la que me ha parecido más apropiada es mediante una conexión [ftp][2]. Puesto que esta web trabaja bajo WordPress resultará suficiente la copia de la carpeta "wp-content" desde el servidor del hosting a nuestro Nas. Otro día veremos como gestionar la copia de seguridad de la base de datos de WordPress.

En primer lugar crearemos un archivo de texto del tipo "backup.sh" en un directorio del nas al que nuestro usuario tenga acceso e introduciremos el siguiente código

```
wget -m ftp://usuario:pass@tusitio.es/public_html/blog/wp-content -P /ruta
tar -zcvf /ruta/$(date +%Y-%m-%d)_bkp_tusitio.tar.gz /ruta/tusitio.es
rm -r /ruta/tusitio.es
```

La primera línea copia mediante una conexión ftp la carpeta "wp-content" desde tusitio.es a la ruta que le especifiques de tu nas. La segunda comprime la carpeta anterior a un archivo "fecha\_bkp\_tusitio.tar.gz" y la tercera elimina la carpeta descargada para solo quedarnos con el archivo comprimido.

Con lo anterior ahora sólo resta crear desde el panel de control de DSM una tarea programada para que el archivo de líneas de comando se ejecute con la periodicidad que deseemos.

{{< youtube IcIhnV0Xif8 >}}
  
Una forma rápida, sencilla y completamente transparente para el usuario de forma que sólo nos tenemos que preocupar de ir borrando las copias de seguridad antiguas para que no ocupen mucho espacio en el NAS.

[1]: https://es.wikipedia.org/wiki/Almacenamiento_conectado_en_red
[2]: https://es.wikipedia.org/wiki/File_Transfer_Protocol