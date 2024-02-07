---
title: "Synology no actualiza por el espacio de la partición del sistema"
date: "2021-11-17"
creation: "2021-11-17"
description: "Como he podido resolver el error de actualización de mi DS920+ por no tener espacio en la partición del sistema."
thumbnail: "images/20211117_error_actualizacion_synology_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "synology"
draft: false
weight: 5
---
Tras un tiempo sin acceder a la interfaz web de mi Synology me encuentro con que no es posible la actualización por una "capacidad insuficiente" de la partición del sistema y esto es lo que he hecho para resolverlo.
<!--more-->

Después de intentar un par de veces la actualización y probar incluso con el reinicio del NAS me encuentro con la persistencia del fallo que por desgracia no he capturado aunque es muy parecida a la que se puede ver en la siguiente imagen, sólo que en cristiano y sin hacer referencia al espacio requerido.

![image-01]

Una primera búsqueda en la red me lleva hasta la [Base de conocimientos de Synology] de la que lo único que saco en claro es que:

> El espacio disponible mostrado en el Administrador de almacenamiento no es el espacio disponible en la partición del sistema.

Navegando un poco más doy con un post de [Bimotech], quien parece que ha pasado por el mismo error y según explica, para reconocer posibles grandes archivos que estén llenando la partición del sistema hay que:

- Abrir una consola
- Acceder al NAS vía ssh `ssh usuario_del_nas@ip_del_nas`
- Ganar privilegios de administrador `sudo -i`
- Acceder al directorio raíz `cd /`
- listar el tamaño de los archivos y directorios `du -hs [a-u]* va*`

Y es resultado es la siguiente salida por la consola

```
root@sherver:/# du -hs [a-u]* va*
0	bin
32K	bot_torrent.session
0	config
128K	dev
3.9M	etc
2.4M	etc.defaults
4.0K	initrd
0	lib
0	lib32
0	lib64
12K	log.txt
404M	logs_info.txt
4.0K	lost+found
4.0K	mnt
16K	opt
du: cannot access 'proc/8372/task/8372/fd/3': No such file or directory
du: cannot access 'proc/8372/task/8372/fdinfo/3': No such file or directory
du: cannot access 'proc/8372/fd/3': No such file or directory
du: cannot access 'proc/8372/fdinfo/3': No such file or directory
0	proc
4.2M	root
15M	run
0	sbin
0	sys
2.5M	tmp
1.2G	usr
234M	var
4.0M	var.defaults
```

Rápidamente me llama la atención en archivo "logs_info.txt" con un peso de 400mb y que contiene única y exclusivamente información de Telethon.

> En caso de no haber encontrado este archivo a la primera se debería haber seguido recursivamente por los directorios que más espacio ocuparan en busca de este tipo de archivos.

```
[DEBUG/2021-11-17 22:01:44,323] asyncio: Using selector: EpollSelector
[ INFO/2021-11-17 22:01:44,612] telethon.network.mtprotosender: Connecting to 149.154.167.91:443/TcpFull...
[DEBUG/2021-11-17 22:01:44,612] telethon.network.mtprotosender: Connection attempt 1...
[DEBUG/2021-11-17 22:01:44,654] telethon.network.mtprotosender: Connection success!
[DEBUG/2021-11-17 22:01:44,654] telethon.network.mtprotosender: Starting send loop
[DEBUG/2021-11-17 22:01:44,654] telethon.network.mtprotosender: Starting receive loop
[ INFO/2021-11-17 22:01:44,654] telethon.network.mtprotosender: Connection to 149.154.167.91:443/TcpFull complete!
[DEBUG/2021-11-17 22:01:45,006] telethon.network.mtprotosender: Waiting for messages to send...
[DEBUG/2021-11-17 22:01:45,007] telethon.extensions.messagepacker: Assigned msg_id = 7031647034573486472 to InvokeWithLayerRequest (7f33de50f9d0)
[DEBUG/2021-11-17 22:01:45,007] telethon.network.mtprotosender: Encrypting 1 message(s) in 84 bytes for sending
[DEBUG/2021-11-17 22:01:45,007] telethon.network.mtprotosender: Encrypted messages put in a queue to be sent
[DEBUG/2021-11-17 22:01:45,007] telethon.network.mtprotosender: Waiting for messages to send...
[DEBUG/2021-11-17 22:01:45,007] telethon.network.mtprotosender: Receiving items from the network...
[DEBUG/2021-11-17 22:01:45,048] telethon.network.mtprotosender: Handling bad salt for message 7031647034573486472
[DEBUG/2021-11-17 22:01:45,048] telethon.network.mtprotosender: 1 message(s) will be resent
...
...
```

Borro el archivo, desaparece el problema y ya es posible actualizar el nas pero con el paso de los días veo como el archivo vuelve a crearse y va ganando tamaño poco a poco así que intento afrontar dos problemas, el tamaño y la ubicación.

Para reducir el tamaño simplemente hay que cambiar el nivel del log de python para el script en el que se está utilizando la librería "Telethon". Gracias a la base de conocimiento de [Telethon] veo que simplemente consiste en cambiar la línea

```
logging.basicConfig(format = '[%(levelname) 5s/%(asctime)s] %(name)s: %(message)s',	level = logging.DEBUG, filename = 'log_info.txt', filemode = 'a')
```
por 
```
logging.basicConfig(format = '[%(levelname) 5s/%(asctime)s] %(name)s: %(message)s',	level = logging.ERROR, filename = 'log_info.txt', filemode = 'a')
```

Para cambiar la ubicación del archivo basta con editar la tarea programada que ejecuta el script y añadirle una línea previa al lanzamiento del script en la que se situe el punto de lanzamiento en la ubización del mismo y allí será donde se cree el archivo del log.

```
cd /volume1/homes/sherlockes/scripts/bot_torrent/
python3 -u bot_torrent.py
```

[Bimotech]: https://bimotech.zendesk.com/hc/en-gb/articles/360025880754-Synology-NAS-Insufficient-capacity-for-update-The-system-partition-requires-at-least-xxx-MB

[Base de conocimientos de Synology]: https://kb.synology.com/es-es/DSM/tutorial/DSM_update_insufficient_system_capacity_for_update

[Telethon]: https://docs.telethon.dev/en/latest/quick-references/faq.html#code-without-errors-doesn-t-work

[image-01]: /images/20211117_error_actualizacion_synology_01.jpg
