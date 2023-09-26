---
title: "Sincronizar nubes con rclone"
date: "2023-02-22"
creation: "2020-06-25"
description: "El método que utilizo para sincronizar dos nubes con mi contenido multimedia por si una de las dos desaparece."
thumbnail: "images/20200625_rclone_sync_clouds_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "productividad"
tags:
  - "rclone"
  - "google drive"
draft: false
weight: 5
---
Hace un tiempo y gracias a [Andrés Ramos] di con un enlace a una web para crear unidades compartidas de Google Drive con espacio ilimitado y la voy a utilizar para sincronizar la nube en la guardo el contenido multimedia por si alguna de las dos "falla".
<!--more-->

## Creando una unidad compartida

Gracias a al [enlace] de Andrés (y que ahora no funciona) era posible crear una unidad compartida de tamaño ilimitado de Google Drive sin más que introducir el nombre que le quiero dar, la cuenta de Google en la que la quiero incluir (No he usado mi cuenta principal sino otra que tengo para estas ocasiones) y seleccionar la universidad de San Francisco (No se como irán las demás opciones). Con solo eso ya tenemos creada una unidad compartida (Para nada privada) con espacio ilimitado.

> El rey a muerto... pero quedan príncipes [enlace_01], [enlace_02], [enlace_03], [enlace_04], [enlace_05]

![Imagen_01]

Rápido, barato y sencillo (mientras funcione...)

## Configurando la carpeta en Rclone

Ahora toca configurar la carpeta creada en rclone para que tenga acceso a esta unidad compartida.

Deberemos conocer el identificador de la carpeta compartida para lo cual, entraremos a la msma a través del navegador y copiaremos la última parte de la barra de direcciones.

![Imagen_02]

En mi caso el identificador de la carpeta será -> 0AKXXD2qTbW50Uk9PVA

Ya estamos listos para abrir una terminal y escribir el comando

```
rclone config
```

- Añadimos una nueva unidad (New remote) - name> nombre
- Selecionamos Google Drive - Storage> drive
- Dejamos en blanco "OAuth Client Id" - client_id>
- Dejamos en blanco "OAuth Client Secret" - client_secret>
- Seleccionamos el acceso completo - scope> 1
- Identificador de la carpeta comartida - root_folder_id> 0AKXXD2qTbW50Uk9PVA
- Dejamos en blanco "Service Account Credentials" - service_account_file>
- No editamos la configuración avanzada - Edit advanced config? > n
- Usamos la configuración automática - Use auto config? > y

En este momento se abrirá el navegador y no solicitará el acceso a la carpeta para rclone. Lo permitimos

![Imagen_03]

Si todo ha ido bien, nos aparecerá una nueva ventana del navegador con el mensaje de éxito y ya podemos volver a la terminal.

![Imagen_04]

- Configuramos la carpeta como unidad de equipo - Configure this as a team drive? > y
- Seleccionamos la carpeta compartida entre las que nos salen
- Aceptamos la configuración creada - Yes this is OK

Con esto ya tenemos aceso a la unidad y en la configuración de Rclone nos aparecerá algo como lo siguiente.

```
Current remotes:

Name                 Type
====                 ====
nombre               drive

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q> 

```

## Encriptando la unidad
Puesto que no sabemos quien tiene privilegios para ver o manipular los archivos de esta unidad compartida creada, es imprescindible cifrar el contenido de la misma para lo cual volveremos a la configración de Rclone.

```
rclone config
```

- Añadimos otra unidad remota > New remote
- La nombramos - name> nombre_en
- Seleccionamos la unidad cifrada - Storage> crypt
- Configuramos como unidad a cifrar la creada anteriormente - remote> nombre:
- Seleccionamos el grado de encriptación de los nombres de archivo - filename_encription> standard
- ¿Queremos encriptar los nombres de carpeta? - directory_name_encryption> true
- Generamos un pass aleatorio - Password or pass phrase for encryption> g
- Con 64 bits bastará - Bits> 64
- Aceptamos y guardamos el pass generado - Use this password?> y
- Generamos un segundo pass aleatorio - Password or pass phrase for encryption> g
- Con 64 bits bastará - Bits> 64
- Aceptamos y guardamos el pass generado - Use this password?> y
- No editamos la configuración avanzada - Edit advanced config?> n
- Aceptamos la unidad creada - Yes this is OK

Ya tenemos creada la unidad compartida encriptada llamada "nombre_en"

```
Current remotes:

Name                 Type
====                 ====
nombre               drive
nombre_en            crypt

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q>
```
Pedemos ya salir de la configuración de Rclone

## Script de sincronización
Con la unidad encriptada creada, es el momento de realizar la sincronización con otra unidad que ya tengamos configurada en Rclone (En mi caso usaré mi directorio de películas en blanco y negro sin derechos de autor "Sherloflix"). El comando se reduce a una sólo línea de terminal

```
rclone sync Sherloflix: nombre_en: --transfers 2 --tpslimit 8 --bwlimit 5M
```

Donde...
- "Sherloflix" es el nombre de la unidad que deseo sincronizar
- "nombre_en" es el nombre de la unidad compartida cifrada que he configurado
- "--transfers 2" indica que sólo se transmitirán dos archivos simpultaneamente
- "--tpslimit 8" indica el nº máximo de transacciones HTTP por segundo
- "--bwlimit 5M" limita a 5 megas por segundo la velocidad de transacción.

Sólo resta esperar a que se haya realizado la sincronización...

> Muy importante tener el cuenta la limitación de 750Gb por día que impone google al tráfico hacia sus servidores...

## Automatizando la sincronización
Pero como el ser humano no está hecho para esperar he optado por automatizar la tarea y encomendársela a la Raspberry (Que para eso está encendida todo el día). Para ello hay que...

- Crear el archivo "cloud_sync.sh" donde se incluirá el comando anterior
- Doto al archivo de permisos de ejecución mediante `sudo chmod +x cloud_sync.sh`
- Acceso al CRON de mi usuario de la Raspberry mediante `crontab -e`
- Añado la línea 


[Andrés Ramos]:  http://www.andresramos.pro/google-drive-gratis/
[enlace]: https://td.fastio.me/

[enlace_01]: https://dawn-star-699e.anime123.workers.dev/
[enlace_02]: https://td.msgsuite.workers.dev/
[enlace_03]: https://driveweb.sharedgoogle.workers.dev/
[enlace_04]: https://td.1tb.workers.dev/
[enlace_05]: https://sparkdrive.tiktikimelbo7.workers.dev/

[Imagen_01]: /images/20200625_rclone_sync_clouds_01.jpg
[Imagen_02]: /images/20200625_rclone_sync_clouds_02.jpg
[Imagen_03]: /images/20200625_rclone_sync_clouds_03.jpg
[Imagen_04]: /images/20200625_rclone_sync_clouds_04.jpg
