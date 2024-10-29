---
title: "Backup de WordPress en Google Drive"
date: "2012-12-13"
creation: "2012-12-13"
description: "En algún sitio hay que guardar la copia de seguridad, Google Drive es barato y accesible"
thumbnail: "images/20121212_backup_01.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "WordPress"
tags:
  - "Backup"
  - "Gdrive"
draft: false
weight: 5
---
Estamos de nuevo aquí para buscar la solución a un problema que tarde o temprano todo webmaster debe afrontar como es crear una copia de seguridad para nuestra web en WordPress. Como siempre, intentaré buscar algo sencillo, práctico y sobre todo gratuito.

Antes de nada necesito un sitio para guardar la copia de seguridad "en la nube". No he probado otros, pero por el precio y características [Google Drive][11] es una buena alternativa. Tan sólo tienes que instalar el [complemento][12] (para windows) y seleccionar la carpeta de tu pc que quieres que se sincronice con tu espacio en los cielos de Google.

![Image][06]

El repositorio de [plugins][13] de WordPress está lleno de utilidades para realizar este backup de una forma sencilla y automatizada. Aunque alguno de ellos son también gratuitos, todos (por lo menos los que he probado) presentan un problema debido a las restricciones del uso de php que todos los servidores gratuitos (por lo menos los que he probado) muestran para que te gastes los euros en uno de pago. Por esto, no he sido capaz de realizar la copia de seguridad de mi web mediante plugin, de modo que voy a reorientar el problema.

Navegando un poco por la web encuentro lo que a primera vista parece la solución perfecta.

![Image][02]

[Mybackupbox][14] es un servicio web que te ayuda a "mover tus ficheros de un sitio a cualquier lugar", es decir, el solito se las apaña para coger los archivos de mi servidor y copiarlos en mi cuenta de [Google Drive][11]. Tal es la emoción que me hago una cuenta gratuita, configuro el respaldo, lanzo el backup y funciona correctamente, pero cuando intento programar la tarea para que se ejecute semanalmente...

![Image][03]

... resulta que para poder automatizar las tareas hay que tener una cuenta "pro" que cuesta la nada desdeñable cifra de 20$ al mes. Nada pues, a seguir buscando.

Como parece que el camino directo desde el servidor a la nube no va a ser fácil de conseguir sin soltar la pasta probaremos dando un rodeo.

![Image][04]

La imagen lo deja claro, voy a buscar un programa que instalado en mi ordenador de sobremesa coja los archivos desde el servidor y los suba a la nube. Después de dar un paseo por la red he encontrado una utilidad gratuita que tiene buena pinta.

![Image][05]

[Cobian Backup][16] es un software que, aunque no es capaz de coger los archivos desde un ftp y dejarlos en la nube, los puede dejar en la carpeta local de tu pc que posteriormente se sincronizará con Google Drive. El manejo del programa es bastante sencillo, aquí un breve [tutorial][15] (en guiri).

[02]: /images/20121212_backup_02.jpg
[03]: /images/20121212_backup_03.jpg
[04]: /images/20121212_backup_04.jpg
[05]: /images/20121212_backup_05.jpg
[06]: /images/20121212_backup_06.jpg

[11]: https://drive.google.com
[12]: https://www.google.com/drive/download/
[13]: https://wordpress.org/plugins/tags/backup/
[14]: https://mybackupbox.com
[15]: http://techbystep.blogspot.com.es/2012/06/setup-and-forget-automated-backup-with.html
[16]: http://www.cobiansoft.com