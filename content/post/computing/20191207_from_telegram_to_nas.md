---
title: "Archivos de Telegram al NAS"
date: "2020-01-02"
creation: "2019-12-07"
description: "El método que empleo para descargar archivos de Telegram al NAS desde Android sin gastar datos."
thumbnail: "images/20191207_telegram_nas.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
  - "sherver"
tags:
  - "telegram"
  - "Google Drive"
  - "Google Scripts"
draft: false
weight: 5
---
Hace mucho tiempo que llevo buscando un método para descargar archivos desde Telegram (en mi teléfono Android) al NAS sin estar en la misma red local ni usar datos de mi tarifa móvil. Ahora creo que he dado con una forma rápida y sencilla...
<!--more-->
A día de hoy, todavía no he dado con la forma de hacerlo de un solo paso por lo que voy a dividir las tareas en dos.

- Enviar los archivos de Telegram a Google Drive
- Descargar los archivos de Google Drive al NAS

## De Telegram a Google Drive (Via Bot)
Para enviar los archivos desde Telegram hasta Google Drive, aunque existen alternativas de pago, utilizo varias alternativas gratuitas en forma de bots. Como no voy a dar acceso a mi cuenta personal de Google a estos bots de terceros, estoy una cuenta secundaria solo para estos menesteres.

### [@GetPublicLinkBot](https://t.me/HK_Driveupload_Bot)

> 20191226 - El Bot no va fino, hay que reintentar muchas veces hasta que consigues que te genera el enlace.

Este conocido bot de Telegram es capaz de generar un link de descarga público para archivos que están dentro de Telegram para lo que simplemente hay que compartir con el el archivo que deseas descargar y posteriormente generar un "Resumable Link".

![imagen_01]

Tras esperar un rato el bot nos responderá con un mensaje en el que se incluirá un link de descarga directa que podremos pasar a la utilidad de descarga del NAS (En mi caso y para Synology se trata de DS Get).

> Puede parecer que descargar directamente este archivo con la utilidad de Synology es el método más rápido pero nada más lejos de la realidad ya que el paso intermedio por Google Drive nos evita una operación manual y tener el NAS encendido las 24 horas del día.

En la misma respuesta y si previamente hemos dotado al Bot de privilegios de acceso a nuestra cuenta de  Google Drive, también dispondremos de un enlace que nos guardará el archivo en nuestra cuenta de la nube pública de Google.

### [Google Drive Uploader 2.0](https://t.me/driveuploadbot)
Ahora (20191225) parece que funciona, tan sencillo como unirse a un canal de difusión del autor, autorizar el acceso a la cuenta de Google Drive al Bot y pegar en el mismo el código de acceso. Si aguanta habrá que hacer una donación...

- Con el comando `/auth` nos da acceso al link de autentificación
- Damos permiso desde nuestra cuenta de Google
- Copiamos el código de acceso que nos muestra el navegador
- Pegamos el código en el bot y se lo enviamos

### [Google Drive Bot](https://t.me/@Gdriveit_bot)
Ahora (20191225) parece que funciona. Es un Bot con el que puedes descargar 1.5Gb al día, para descargar más hay que pagar, de momento lo estoy usando como método de emergencia.

> Este Bot tiene la peculiaridad de que ademas de reenviarle el archivo que deseas descargar hay que responderle desde dentro del mismo con el comando "Upload"

## Acondicionando Google Drive
Cada Bot deja el archivo en una carpeta distinta de la cuenta de google Drive (Lo cual no es posible de cambiar en la configuración del Bot), una vez allí utilizo un pequeño programa de [Google Scripts] para moverlos a la carpeta que posteriormente voy a sincronizar desde el NAS. Este script realiza los siguientes pasos:

- Selecciona la carpeta compartida
- Crea una matriz con las posible ubicaciones de los Bot
- Mueve todos los archivos de las distintas carpetas a la carpeta compartida
- Si ya llevan más de 24 horas allí, elimina los archivos de la carpeta compartida
- Vacía la papelera de Google Drive

```
function move_files() {
  // Carpeta compartida Shd_Sherlockes78
  var shd_id = "1RoVpSOD0wzGZ-1OPweS9DR55wwndKcbO"
  var shd_folder = DriveApp.getFolderById(shd_id)
  
  // Carpetas donde buscar los archivos para mover  
  var folders_id = [];
  // Carpeta compartida "driveuploadbot"
  folders_id.push("1Lf190bC0KFjWcLywjvCXuNehBSRlGFfS");
  // Carpeta compartida "driveuploadbot"
  folders_id.push("1qxy6waDIaCl6r8UdkiEm6XZ_DLKFedGF");
  
  for each (var folder_id in folders_id)
  {
    var to_move_folder = DriveApp.getFolderById(folder_id)
    var to_move_files = to_move_folder.getFiles();
    while (to_move_files.hasNext()) {
      var file = to_move_files.next();
      shd_folder.addFile(file);
      to_move_folder.removeFile(file);
    }
  }
  
  // Mueve los archivos de la carpeta a la papelera cuando han pasado 24 horas
  var shd_files = shd_folder.getFiles();
  while (shd_files.hasNext()) {
    var file = shd_files.next();
    if (new Date() - file.getLastUpdated() > 24 * 60 * 60 * 1000) {
      file.setTrashed(true);
    }
  }
  
  // Vacía la papelera
  Drive.Files.emptyTrash();
}
```

Para que sea posible la eliminación de los archivos de la papelera de reciclaje de la cuenta de Google Drive, previamente hay que seguir los pasos expuestos en el tutorial de Amixa de como [Vaciar la papelera] mediante el API de Google Drive.

## De Google Drive al NAS
Esta parte es fácil gracias a la utilidad de Synology "Cloud Sync" que nos descargará los archivos de una carpeta específica de la nube al NAS.

![imagen_02]

Configuramos la tarea para que sólo descargue los cambios en la nube en lugar de hacerlo de forma manual y listo.

## Que queda por hacer ?
Pues si, llegados a este punto todavía quedan algunas cosas por hacer con los archivos descargados.

- Descomprimirlos si están conformados por varias partes.
- Renombrarlos de una forma homogénea.
- Moverlos a la ubicación adecuada.

Estos tres pasos los realizo de forma manual, casi siempre desde Android con la aplicación de Synology "DS File".


[Google Scripts]: https://script.google.com
[Vaciar la papelera]: https://www.amixa.com/blog/2019/04/05/automatically-empty-google-drive-trash/

[imagen_01]: /images/20191207_telegram_nas_01.jpg
[imagen_02]: /images/20191207_telegram_nas_02.jpg
