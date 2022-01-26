---
title: "Gestión de usuarios y passwords"
date: "2019-02-06"
creation: "2018-10-09"
description: "Con todos los servicios web que se usan hoy en día, alguna forma que que utilizar para la gestión de los nombres de usuario y contraseñas"
thumbnail: "images/20181009_gestion_passwords_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Varios"
tags:
  - "Keepass"
draft: false
weight: 5
---
Cada día son más los servicios web a los que estamos subscritos y parece evidente que hace falta una gestión adecuada de las contraseñas que utilizamos para acceder a cada uno de estos servicios.  Cada uno maneja este tema a su gusto pero creo que para hacerlo de una forma “segura” hay que cumplir con los siguientes requisitos:

* Contraseñas distintas para cada servicio
* No usar palabras, nombres, fechas...
* No usar sólo letras
* Longitud suficiente (más de diez caracteres)
* Accesibles desde cualquier lugar
* Guardadas en un lugar seguro

No voy a entrar a valorar las alternativas que existen y que cumplen con las características de arriba, simplemente voy a exponer el método que yo utilizo en la actualidad y como hago para garantizar lo que, a mi modo de ver, es una seguridad suficiente.

Desde hace años utilizo [Keepass][11] por ser una utilidad de código abierto que puedo utilizar en Windows, Linux, IOS y Android.

### Contraseñas distintas y adecuadas para cada servicio
Sin duda alguna es una locura utilizar la misma contraseña en varios servicios ya que un fallo de seguridad en uno de ellos que deje tu contraseña a las vista significará dejar al descubierto todos los sitios en los que empleas esa misma contraseña.  Está muy extendido el uso de patrones según los cuales todas las contraseñas son distintas pero comparten una parte común y a partir de un patrón y del nombre del servicio para el que la creamos se genera una nueva contraseña.  Este sistema lo estuve utilizando un tiempo por ofrecer mucha facilidad a la hora de recordar las contraseñas era presenta el gran problema de si el patrón que utilizas queda desvelado también quedan a la vista todas tus contraseñas.

Por todo lo anterior,  en la actualidad cuando tengo que darme de alta en un nuevo servicio, a la hora de introducir la contraseña dejo que sea [KeePass][11] el que me la genere de forma automática.

Nada de usar palabras (fácilmente obtenibles con un ataque por diccionario), nombres ni fechas.  Lo mejor es utilizar una combinación de letras, números y símbolos con una longitud adecuada (yo utilizo 16 dígitos)

### Guárdalas en un lugar seguro y accesible
A pesar de que hay que instalar la aplicación [Keepass][11] en cada uno de los dispositivos en los que quieras acceder a tus contraseñas luego estas no las tengo guardadas en ninguno de ellos sino que acceden todos ellas a una base de datos encriptada común que tengo alojado en [Google Drive][18].

Por supuesto, realizo una copia de seguridad periódica en mi NAS de forma que no dependo de la buena voluntad de Google para servirme el archivo de contraseñas.

### Que guardo además...
En el archivo de base de datos de Keepass no sólo la contraseña está encriptada, toda la información guardada lo está y para cada entrada la información que guardo es la siguiente:

* Nombre de usuario
* Contraseña
* Contraseña anterior
* Dirección de correo electrónico registrada
* URL del servicio registrado
* Favicon de la web del servicio

### Como lo uso en cada entorno
Para cada sistema operativo que utilizo hay unas sensibles diferencias en el modo de acceder a la base de datos.

* En Windows he estado utilizando durente mucho tiempo [Keepass][11] combinado con la utilidad de Google [Backup & Sync][12] para sincronizar la base de datos en Google Drive con un directorio local y así poder leerla o modificarla.  Ahora utilizo [KeeWeb][17] que me resulta más s.encillo al no necesitar utilidad de sincronización y permite acceder directamente a los archivos guardados en la nube

* En Android utilizo [Keepass2Android][13] que directamente es capaz de acceder a la base de datos por lo que no hace falta ninguna sincronización de archivos.

* En IOS utilizo [MiniKeePass][14] la cual no es capaz de acceder directamente a la nube por lo que tengo que acceder manualmente mediante la aplicación nativa de [Google Drive][15] y una vez seleccionado al archivo correspondiente a la base de datos hay que marcar la opción "Abrir en..." y seleccionar "Copiar en MiniKeePass".  Una copia de la base de datos se guardará en local por lo que si es necesario consultar una contraseña que no he modificado recientemente puedo abrir directamente la base de datos desde la aplicación MiniKeePass.

* En Linux durante un tiempo he estado usando una combinación de [KeePass][11] y [Rclone][16] para sincronicar la base de datos con la nube y posteriormente abrir con la aplicación KeePass el archivo local.  En la actualidad utilizo [KeeWeb][17].

Para hacer el proceso más rápido y sencillo con [KeeWeb][17], tanto en windows como en Linux es posible usar el complemento de navegador [Browser AutoFill][19] con el que directamente puedes introducir el nombre de ususario y contraseña de un servicio sin tener que abrir la aplicacion [KeeWeb][17] y buscarlo en ella.  Es válido para Chrome, Safari y Firefox.

[11]: https://keepass.info
[12]: https://www.google.com/drive/download/backup-and-sync/
[13]: https://play.google.com/store/apps/details?id=keepass2android.keepass2android
[14]: https://itunes.apple.com/us/app/minikeepass/id451661808
[15]: https://itunes.apple.com/es/app/google-drive-almacenamiento/id507874739
[16]: https://rclone.org/
[17]: https://keeweb.info/
[18]: https://www.google.es/drive/
[19]: https://github.com/keeweb/keeweb/wiki/Browser-AutoFill