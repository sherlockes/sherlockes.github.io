---
title: "Descargar archivos de Telegram"
date: "2021-02-01"
creation: "2021-02-01"
description: "Una forma de descargar archivos de Telegram a nuestra Raspberry sin límite de tamaño"
thumbnail: "/images/20210201_telegram_download_daemon_00.jpg"
images: ["https://sherblog.pro/images/20200201_telegram_download_daemon_00.jpg"]
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "raspberry"
- "python"
- "bash"
draft: false
weight: 5
---
Hace un tiempo que uso un bot para descargar los archivos grandes de Telegram al NAS tal y como expliqué en este [artículo], ahora le doy una vuelta y pongo a trabajar la Raspberry con un servicio que me hace prescindir del bot y sus limitaciones.
<!--more-->
La utilidad que me presta [@driveuploadbot] es impresionante, pero presenta dos problemas. Por un lado sólo es posible descargar tres archivos al día sin pasar por caja y obliga a hacer un pago mensual para evitar el límite, por otro, hay momentos en los que el servicio no funciona correctamente o está caído.

Recientemente, en [Github] he dado con una joya llamada [telegram-download-daemon] y que con sólo tres frases ha sido capaz de cautivarme..

> A Telegram Daemon (not a bot) for file downloading automation. If you have got an Internet connected computer or NAS and you want to automate file downloading from Telegram channels, this daemon is for you. Telegram bots are limited to 20Mb file size downloads. So I wrote this agent or daemon to allow bigger downloads.

Antes de instalar el servicio necesitamos una identificación y hash de la api de telegram desde la [API development tools]. Pondremos un título y nombre corto a nuestra aplicación y nos guardaremos los siguientes valores:

- api_id
- api_hash

![image_01]

Crearemos un canal privado de telegram del que necesitamos saber su identificación.

> La forma más sencilla es añadir como miembro a @username_to_id_bot (Al ser un bot hay que ponerlo como administrador) y enviar al canal el mensaje "@username_to_id_bot"

- canal_id


Este servicio lo he puesto a funcionar en la Raspberry de una forma realmente sencilla con la versión 3.7.3 de python siguiendo los siguientes pasos:

- Crear una carpeta para el servicio y los archivos descargados
- Clonamos el repo dentro de la carpeta `git clone https://github.com/alfem/telegram-download-daemon.git`
- Instalamos las dependencias `pip install -r requirements.txt`
- Lanzamos el servicio

```
python3 telegram-download-daemon/telegram-download-daemon.py --api-id <api_id> --api-hash <api_hash> --channel <canal_id> --dest ~/teledown/files --temp ~/teledown/files
```

Y ya está¡¡¡

> Puesto que mi Raspberry se reinicia todos los días a las cuatro de la mañana lo he incluido en el crontab para que se ejecute en el arranque.

Desde aquí, montar una unidad de google drive mediante rclone en la carpeta donde se guardan los archivos para que posteriormente el Nas de synology se sincronice es coser y cantar...

Este ti todos mis scripts los puedes encontrar en [mi repositorio de GitHub].




[API development tools]: https://my.telegram.org/apps
[artículo]: https://sherblog.pro/archivos-de-telegram-al-nas/
[@driveuploadbot]: https://t.me/driveuploadbot
[Github]: https://github.com
[mi repositorio de Github]: https://github.com/sherlockes/SherloScripts
[telegram-download-daemon]: https://github.com/alfem/telegram-download-daemon

[image-01]: /images/20200201_telegram_download_daemon_01.jpg
