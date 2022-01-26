---
title: "Sincronizar WordPress en local y servidor"
date: "2015-10-06"
description: "Está muy bien tener una instalación de WordPress en un servidor local de pruebas que puedas sincronizar con el servidor de producción cuando todo lo tengas listo, aquí te muestro como hacerlo."
thumbnail: "images/20151006_wordpress_db_sync.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Wordpress"
draft: false
weight: 5
---
Si de algo carece WordPress, o al menos yo no he sido capaz de encontrarlo después de mucho navegar por la red, es de un entorno de desarrollo en local. A que me refiero, cada vez que nos ponemos a realizar modificaciones en la web algo más allá que publicar un post nos encontramos con la tediosa labor de descargar, modificar, guardar, subir y comprobar cada modificación hasta que conseguimos dejar la web a nuestro gusto.

Pues bien, lo que yo busco es una forma sencilla de crear una copia de nuestra web en el ordenador de casa para poder trabajar sobre esta en las modificaciones y una vez estén terminadas subirlas al servidor. De esta forma el proceso se simplifica bastante ya que únicamente hay que realizar las modificaciones, guardarlas y comprobar si funcionan. Antes de empezar necesitamos cuatro puntos imprescindibles.

1. Montar un servidor de pruebas
2. Instalar WordPress en el servidor local
3. Copiar los archivos de la web
4. Copiar la base de datos

### Montar un servidor de pruebas
Básicamente necesitamos montar un servidor apache en local y phpmyadmin para la gestión de la base de datos de WordPress. Hay muchos programas para hacerlo, la que yo utilizo desde hace varios años es [Xampp][11].

![imagen][1]

Es sencillo, hay versión para windows, linux y mac, ofrece lo que necesitamos (y algo más para los inquietos) y además tiene una versión portable para los que no quieren otro programa a instalar que deje el pc lleno de basura. No voy a entrar en más detalles sobre la instalación y configuración porque hay cientos de tutoriales en la web, simplemente cuando lo tengas instalado y hayas arrancado apache y phpmyadmin al escribir "http://localhost" en el explorador de internet deberás ver algo como lo siguiente.

![imagen][2]

### Instalar WordPress en el servidor local
Tan sencillo como seguir los pasos de su famosa instalación en cinco minutos que puedes ver en [wordpress.org][2]. Además si has sido capaz de instalar WordPress en un hosting online, hacerlo en un servidor local no tiene que plantearte ningún problema.

### Copiar los archivos de la web
Para este paso necesitamos un cliente ftp para descargar la carpeta "wp-content" de nuestro hosting online y con ella sobreescribir la correspondiente carpeta del blog recientemente creado en el servidor local. Personalmente utilizo [FileZilla][13] por ser sencillo, potente, ligero y sobretodo gratuito.

![imagen][3]

Llegados a este punto tenemos en nuestra web online y el servidor local los mismos archivos con una pequeña salvedad, el archivo de configuración "wp-config.php". Si queremos ser meticulosos y unificar estos archivos de configuración en uno válido para ambos servidores habrá que realizar alguna modificación en el mismo en la sección de conexión a la base de datos. Donde aparece algo como esto.

```
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'db_yourserver');
/** MySQL database username */
define('DB_USER', 'db_yourserver_user');
/** MySQL database password */
define('DB_PASSWORD', 'db_yourserver_user_password');
/** MySQL hostname */
define('DB_HOST', 'yourserver_hostname');
/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');
/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');
```

lo cambiaremos por esto otro

```
// ** MySQL settings - You can get this info from your web host ** //
if ($_SERVER["HTTP_HOST"] === 'yourserver.com') {
  $db_name = 'db_yourserver';
  $user_name = 'db_yourserver_user';
  $password = 'db_yourserver_user_password';
  $hostname =  'yourserver_hostname';
} else if ($_SERVER["HTTP_HOST"] === 'localhost') {
  $db_name = 'db_local';
  $user_name = 'root';
  $password = '';
   $hostname =  'localhost';
}
/** The name of the database for WordPress */
define('DB_NAME', $db_name);
/** MySQL database username */
define('DB_USER', $user_name);
/** MySQL database password */
define('DB_PASSWORD', $password);
/** MySQL hostname */
define('DB_HOST', $hostname);
/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');
/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');
```

Con esto ya podemos tener exactamente los mismos archivos en nuestra web online y la réplica local por lo que a partir de ahora una servirá de copia de seguridad de la otra, siempre y cuando las vayamos sincronizando habitualmente tras realizar modificaciones en el sistema de archivos. Ahora es posible habilitar la navegación sincronizada de Filezilla y la comparación de directorios desde el gestor de sitios del programa en la pestaña "avanzado".

![imagen][4]

De esta forma navegaremos al mismo tiempo en las dos pestañas y, gracias al código de colores, será más rápido y sencillo identificar los archivos modificados y actualizarlos.

![imagen][5]

### Copiar la base de datos
Llegados a este punto nos encontramos con la labor más delicada de todas, la sincronización de la base de datos. Voy a exponer dos métodos, uno completamente manual y otro semiautomático. Sin duda alguna el segundo es mucho más rápido y sencillo aunque no está de más conocer el primero para saber los pasos que sigue el segundo.

En primer lugar accedemos a la base de datos que gobierna nuestro blog online desde phpmyadmin y nos situamos en la pestaña "Exportar" tal y como muestra la siguiente imagen.

![imagen][6]

Exportamos las tablas de nuestra base de datos a un archivo "sql". Ahora hay que modificar la base de datos para que los enlaces en lugar de apuntar a "www.mipagina.com" lo hagan a "localhost/mipagina". El proceso es sencillo, abres el bloc de notas o cualquier editor de código fuente, buscas una cadena y la reemplazas con la otra. Para este tipo de ediciones yo utilizo [Notepad++[14]] por ser rápido, sencillo, gratuito y portable.

![imagen][7]

en mi caso busco la cadena "www.sherblog.es/blog" y la cambio por "localhost/blog" que son las correspondientes carpetas en online y local.

![imagen][8]

A continuación accedemos a la base de datos de nuestro blog local a través de phpMyadmin e importamos dentro de esta el archivo "*.sql" que acabamos de editar de una forma similar a como anteriormente hemos exportado la base de datos online. Seleccionamos el archivo, seleccionamos el formato SQL y "Continuar".

![imagen][9]

Hasta aquí el método manual para la sincronización de las bases de datos. Por suerte hay una alternativa más rápida y sencilla a través de un plugin de WordPress. Se trata de [wp-sync-db][15]. Este plugin no se puede encontrar a través del buscador de WordPress, hay que descargarlo de la web y copiarlo a la carpeta plugins de tu blog. No tengo claro la relación que mantiene con [wp-migrate-db][16] así como tampoco soy capaz de ver las diferencias entre uno y la versión pro del otro. Yo utilizo [wp-sync-db][15].

El primer paso es instalar y activar el plugin tanto en el blog online como en el local. Una vez instalado y desde la versión online acudimos al menú "herramientas" del panel de control de WordPress y abrimos "Migrate Db". En la pestaña "Settings" marcamos la primera opción para permitir que nuestro blog local pueda conectarse, exportar y descargar la base de datos de este blog online tal y como se muestra en la siguiente imagen.

![imagen][10]

Copiamos el enlace que aparece en el cuadro "Connection Info" y ya podemos cerrar el blog online para abrir la imagen en nuestro servidor local. Accedemos a la configuración del plugin y selecionamos la opción "Pull" para reemplazar la base de datos de nuestro blog local por la del remoto. Añadimos las cadenas de texto a reemplazar, unos cuantos ticks de configuración y ya está lista la sincronización.

![imagen][21]

Si prefieres ver el vídeo oficial antes que mi torpe interpretación, aquí está el link de [youtube][17].

Y con esto, si todo ha ido bien ya deberías tener dos copias sincronizadas de tu blog.

[1]: /images/20150929_xampp_logo.jpg
[2]: /images/20150929_xampp_install.jpg
[3]: /images/20150929_filezilla_01.jpg
[4]: /images/20151006_filezilla_compare.jpg
[5]: /images/20151006_filezilla_compare_02.jpg
[6]: /images/20151006_export_phpmyadmin.jpg
[7]: /images/20151005_notepad.jpg
[8]: /images/20151006_buscar_reemplazar.jpg
[9]: /images/20151006_phpmyadmin_importar.jpg
[10]: /images/20150930_wp_sync_db_02.jpg

[11]: https://www.apachefriends.org/es/index.html
[12]: https://es.wordpress.org/
[13]: https://filezilla-project.org
[14]: https://notepad-plus-plus.org
[15]: https://github.com/wp-sync-db/wp-sync-db
[16]: https://wordpress.org/plugins/wp-migrate-db/
[17]: https://www.youtube.com/watch?t=345&v=fHFcH4bCzmU

[21]: /images/20150930_wp_sync_db_01.jpg