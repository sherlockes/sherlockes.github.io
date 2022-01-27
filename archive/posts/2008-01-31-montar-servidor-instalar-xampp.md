---
title: Montar servidor. Instalar XAMPP
author: Sherlockes
type: post
date: 2008-01-31T22:08:23+00:00
url: /?p=28
categories:
  - Servidor

---
En la red hay muchos paquetes que integran los programas necesarios para montar un servidor tanto gratuitos como de pago.

<p align="justify">
  XAMPP en un proyecto de <a href="http://www.apachefriends.org" target="_blank">Apache Friends</a> que integra apache, MySql, Php y unos cuantos paquetes más que en un principio dejaremos de lado para más adelante.
</p>

<p style="text-align: center;">
  <img style="vertical-align: text-bottom;" src="http://sherver.homeip.net/blog/wp-content/uploads/2008/01/windowslivewritermontarservidor.instalarxampp-14562apachefriends-thumb.jpg" alt="" width="406" height="52" />
</p>

<p align="justify">
  Para comenzar descargaremos la última versión de XAMPP for Windows desde <a href="http://www.apachefriends.org/en/xampp-windows.html#641" target="_blank">aquí</a> y la guardaremos en nuestro pc. Para no complicarnos, escogeremos la versión "Installer" con un asistente guiado de instalación. Apenas con la ruta donde queremos ubicar el programa tenemos todo lo necesario para instalarlo, un consejo, si algo no tienes claro que poner, no lo cambies.
</p>

<!--more-->

<p align="justify">
  <p align="justify">
    Terminada la instalación se habrá creado en el escritorio un icono llamado "XAMPP Control Panel" que al hacer doble click mostrará lo siguiente.
  </p>
  
  <p align="center">
    <img style="http://sherver.homeip.net/blog/wp-admin/border-right-color: #000000; border-right-width: 0px; border-right-style: none; border-top-color: #000000; border-top-width: 0px; border-top-style: none; border-left-color: #000000; border-left-width: 0px; border-left-style: none; border-bottom-color: #000000; border-bottom-width: 0px; border-bottom-style: none" src="http://sherver.homeip.net/blog/wp-content/uploads/2008/01/windowslivewritermontarservidor.instalarxampp-14562xampp-thumb.jpg" border="0" alt="xampp" width="304" height="186" />
  </p>
  
  <p align="justify">
    Pulsaremos en el botón "Start" correspondiente a Apache y MySql y saldrá un cartelillo verde con la palabra "Running" si no hay ningún problema. Con las aplicaciones arrancadas ya podemos cerrar esta ventana, abrir el navegador e introducir <a href="http://localhost">http://localhost</a> en la barra de direcciones y veremos la página por defecto de nuestro servidor. Hasta aquí todo lo necesario, ahora sólo faltan un par de detalles para afinar un poco el sistema.
  </p>
  
  <p align="justify">
    Para cambiar la carpeta donde colocar los documentos de tu servidor abriremos el archivo "\xampp\apache\conf\httpd.conf" con cualquier editor de texto y modificaremos las líneas 176 y 203 (Hay que poner lo mismo en las dos) para que apunten a la carpeta que deseemos. Se guardan los cambios y sólo restará parar y arrancar nuevamente el modulo de apache desde "XAMPP Control Panel" para que estos cambios sean aplicados.
  </p>
  
  <p align="justify">
    Respecto a PhpMyAdmin (El sistema para gestionar las bases de datos en MySql) son necesarias un par de acciones para que cualquiera no pueda acceder a las bases de datos. En el archivo "\xampp\phpMyAdmin\config.inc" en la línea 71 hay que cambiar el parámetro "config" por "http" para que la aplicación pida nombre de usuario y contraseña cada vez que que se acceda a la misma. Después arrancamos el navegador y accedemos a <a href="http://localhost/phpmyadmin">http://localhost/phpmyadmin</a>, se mostrará un cuadro como el siguiente donde será suficiente con poner "root" en el nombre de usuario y entraremos al entorno de gestión de MySql.
  </p>
  
  <p align="center">
    <img style="http://sherver.homeip.net/blog/wp-admin/border-right-color: #000000; border-right-width: 0px; border-right-style: none; border-top-color: #000000; border-top-width: 0px; border-top-style: none; border-left-color: #000000; border-left-width: 0px; border-left-style: none; border-bottom-color: #000000; border-bottom-width: 0px; border-bottom-style: none" src="http://sherver.homeip.net/blog/wp-content/uploads/2008/01/windowslivewritermontarservidor.instalarxampp-14562phpmyadmin-thumb.jpg" border="0" alt="phpmyadmin" width="302" height="236" />
  </p>
  
  <p align="justify">
    Accederemos al apartado "Privilegios", seleccionaremos el usuario root que no tiene como servidor "localhost" y lo eliminaremos, después editaremos el usuario "root" restante asignándole una contraseña que utilizaremos en los próximos accesos a PhpMyAdmin.
  </p>
  
  <p align="justify">
    Por último un consejo, si te has acordado de mi familia al contar el número de línea de las modificaciones de los dos archivos anteriores te recomiendo que sustituyas tu obsoleto e ineficiente editor de texto por <a href="http://notepad-plus.sourceforge.net/es/site.htm" target="_blank">Notepad++</a> (No creo que quepa ninguna duda de que es completamente gratuito tanto el consejo como la aplicación).
  </p>
  
  <p align="justify">
    Hasta aquí todo lo relativo a la instalación de XAMPP, si has tenido algún problema escribe un comentario e intentaremos resolverlo. El siguiente paso será instalar <a href="http://wordpress.org/" target="_blank">WordPress</a> para alojar un blog en nuestro servidor, pero esto para otro día&#8230;
  </p>