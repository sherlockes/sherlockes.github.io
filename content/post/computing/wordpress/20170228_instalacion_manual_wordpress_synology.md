---
title: "Instalación manual de WordPress en Synology"
date: "2017-02-28"
description: "Pasando de la instalación automática de WordPress y realizándola a mano en Synology"
thumbnail: "images/20170228_wordpress_manual_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Wordpress"
  - "Sherver"
tags:
  - "Synology"
draft: false
weight: 5
---
Desde el centro de paquetes de DSM en posible acceder a la instalación de WordPress de una forma sencilla tal y como puedes es en este [tutorial][13], pero si lo que tu quieres es realizar una instalación manual con la que consigas un mayor control aquí te dejo los pasos a seguir.

Antes de comenzar con la instalación de WordPress hay que instalar "Web Station" como servidor de archivos, "Maria Db" para el alojamiento de las bases de datos y "PhpMyAdmin" para gestionar las bases de datos. Tras instalar "Web Station" seleccionaremos Apache como servidor y la versión de php. Para "Maria Db" es muy importante generar una contraseña para el usuario root después de instalarlo. Con esto ya podemos iniciar la instalación propia de WordPress.

_¡¡¡Es importante hacer los pasos según indico a continuación y olvídate de acceder o editar el contenido del NAS desde el explorador del pc en lugar de hacerlo desde el entorno de DSM para no tener problemas con los permisos.¡¡¡_

  * Accedemos a la [web en castellano de WordPress][14] y copiamos la dirección del enlace de la descarga de la última versión.

![imagen][1]

  * Abrimos Download Station desde DSM y añadimos una nueva descarga con la dirección que hemos copiado.

![imagen][2]

  * Extraemos el contenido del archivo descargado en la la carpeta compartida "web" que se ha creado en el raiz.

![imagen][3]

  * Renombramos la carpeta, en este caso le he puesto el nombre "tuto"

![imagen][4]

  * Ya podemos acceder a la instalación web de WordPress para lo cual en el navegador introduciremos la ip del Nas seguido de la carpeta de wordpress. En este caso introduciré http://192.168.1.200/tuto

![imagen][5]

  * Abrimos PhpMyAdmin desde otra pestaña del navegador (http://192.168.1.200/phpMyAdmin/ ojo con las mayúsculas) y accedemos con el usuario root y la contraseña que hemos cambiado en Maria Db con anterioridad. Accedemos al menú "Cuentas de Usuarios" y clickamos en "Agregar cuenta de usuario".

![imagen][6]

  * Introducimos en nombre para el usuario y la contraseña (en nuestro caso he utilizado "tuto" como usuario y "tuto123" como pass, pero no tiene por que coincidir con el nombre de la carpeta donde hemos descomprimido la instalación de WordPress, aunque simplifica bastante) y rellenamos el cuadro "Crear base de datos con el mismo nombre y otorgar todos los privilegios". Pinchamos en el botón "Continuar" y si todo ha ido bien nos aparecerá en la parte superior un cuadro como este. 

![imagen][7]

  * Ya podemos cerrar la pestaña del navegador de phpMyAdmin y volver a http://192.168.1.200/tuto para pinchar en el botón "¡Vamos a ello¡". Modificaremos los campos de "Nombre de base de datos", "Nombre de usuario" y "contraseña" con los que hemos creado en el paso anterior en phpMyAdmin. 

![imagen][8]

  * Si todo ha ido bien, al enviar el formulario nos aparecerá lo siguiente.

![imagen][9]

  * El sistema no ha podido modificar el archivo "wp-config.php". Para seguir adelante necesitamos tener instalado el paquete "Editor de texto" en DSM. Desde "File Station" en la carpeta "web/tuto" renombraremos el archivo "wp-config-sample.php" a "wp-config.php", lo editaremos (Botón derecho y "Abrir con editor de texto") de forma que borraremos todo el texto y lo sustituiremos por lo que nos ha sugerido el instalador en el paso anterior.

![imagen][10]

  * Con el archivo editado ya podemos "Ejecutar la instalación" para en la siguiente pantalla introducir en título del sitio y crear un usuario de administración con su correspondiente contraseña. Añadimos nuestra dirección de correo electrónico y rellenamos el cuadro para que Google de momento no indexe nuestro sitio (Ya lo hará después cuando lo tengamos más arregladito)

![imagen][11]

  * Pinchamos en "Instalar WordPress", esperamos unos segundos y.... Voila¡¡¡

![imagen][12]

Ya podemos acceder a nuestro sitio con el usuario y contraseña que hemos creado en el paso anterior. De aquí en adelante... horas y horas para añadir contenido y darle formato.

[1]: /images/20170228_wordpress_manual_01.jpg
[2]: /images/20170228_wordpress_manual_02.jpg
[3]: /images/20170228_wordpress_manual_03.jpg
[4]: /images/20170228_wordpress_manual_04.jpg
[5]: /images/20170228_wordpress_manual_05.jpg
[6]: /images/20170228_wordpress_manual_06.jpg
[7]: /images/20170228_wordpress_manual_07.jpg
[8]: /images/20170228_wordpress_manual_08.jpg
[9]: /images/20170228_wordpress_manual_09.jpg
[10]: /images/20170228_wordpress_manual_10.jpg
[11]: /images/20170228_wordpress_manual_11.jpg
[12]: /images/20170228_wordpress_manual_12.jpg
[13]: https://www.jmramirez.pro/tutorial/web-en-un-synology-con-wordpress/
[14]: https://es.wordpress.org/
