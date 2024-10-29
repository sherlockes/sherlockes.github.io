---
title: "Migrando WordPress a otro servidor"
date: "2015-05-30"
creation: "2015-05-30"
description: "Mi experiencia para migrar la instalación de WordPress de un servidor a otro con cambio de dominio incluido"
thumbnail: "images/20150530_migrando_wordpress.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Wordpress"
draft: false
weight: 5
---
En los últimos días y por causas que desconozco me han desaparecido todos los archivos de mi antigua dirección del blog "www.sherver.site88.net" que tenía alojada en [000webhost][11]. He intentado la reparación del site por todos los medios, pero la única respuesta que he recibido de parte de los administradores del alojamiento es que "esto no hubiera pasado con la modalidad de pago de nuestro alojamiento".

Bueno, el caso es que he tenido que buscar otro alojamiento para mi blog donde volver a montarlo desde cero y restaurarlo a como estaba hace unos días.

### ¿Que necesito?
* Un alojamiento con posibilidad de base de datos para la nueva web
* Acceso a tu servidor web (vía shell o FTP y phpmyAdmin)
* Un Editor de textos (Personalmente utilizo Notepad++)
* Un Cliente FTP (Personalmente utilizo Filezilla)
* Tu navegador web preferido
* La copia de seguridad de la base de datos del blog
* La copia de seguridad de la carpeta "wp-content" del blog

Pues bien, sin que sirva de precedente, he tirado la casa por la ventana (18€ al año) en [Domain.com][12] y he registrado el dominio [www.sherblog.es][13].

### Primer paso¡¡ Creando el nuevo Blog
Crear una nueva instalación de WordPress en el nuevo servidor. Este es un paso del que no voy a dar muchas explicaciones, ya que es un proceso archidocumentado en la web y que pasa básicamente por subir una instalación de wordpress a tu servidor, crear la base de datos, modificar el config.php con la información de la base de datos y finalmente ejecutar el instalador. Si tienes alguna duda, revisa la famosa instalación en 5 minutos de WordPress desde el [codex][14].

### Segundo Paso¡¡ Restaurando los archivos
LLegados a este punto, ya tenemos creado nuestro nuevo blog pero por desgracia todavía sin contenido por lo que a continuación vamos a restaurar todo el contenido anteriormente existente a partir de la copia de seguridad. A través del servidor Ftp, sobrescribe la carpeta wp-content que ha creado la instalación de wordpress por la de tu copia de seguridad. Yo Utilizo el cliente [Filezilla][15] que es una opción fiable, potente, suficiente para la operación que estamos realizando. Además es una solución gratuita, lo que la hace mucho más interesante.

![imagen][1]

### Tercer paso¡¡ Editando la base de datos
Es muy importante tener una copia de seguridad de la base de datos de WordPress de nuestro blog a la que poder recurrir en este tipo de situaciones. Para realizarla periódicamente, utilizo el plugin de WordPress [WP-Db-Backup][16] de forma que una vez a la semana o cuando tu desees llega a tu correo una copia de seguridad de la base de datos.

En el caso de que tengas que restaurar la base de datos en el mismo servidor es tan simple como importarla directamente desde phpmyadmin pero en el caso que ahora nos atañe vamos a realizar un paso intermedio ya que el direccionamiento del blog ha cambiado, donde antes era "http://www.sherver.site88.net" ahora es "http://www.sherblog.es". Realizar este cambio es muy sencillo y sólo requiere una edición de la base de datos con un editor de texto, buscaremos la primera cadena de texto y la sustituiremos por la segunda.

![imagen][2]

### Cuarto paso¡¡ Importando la base de datos
Ahora toca abrir la aplicación de phpMyadmin de nuestro servidor, acceder a la base de datos que gobierna el nuevo blog de WordPress e importar encima de ella la copia de seguridad con el direccionamiento modificado que hemos obtenido en el paso anterior.

![imagen][3]

No se si es un fallo habitual, pero en mi servidor me ha dado problemas la importación del archivo de la base de datos sin comprimir, lo he metido dentro de un archivo basededatos.zip comprimido y la importación se ha efectuado correctamente.

### Quinto paso¡¡ Comentando los cambios a Google
Para que en Google deje de aparecer la dirección antigua y aparezca la nueva hay que transferir los cambios a la consola de busqueda de Google, pero en mi caso como no puedo acceder al alojamiento anterior no he podido realizar este paso así que se seguirá viendo durante un tiempo la dirección http://www.sherver.site88.net. Que le vamos a hacer???

Y ya está¡¡¡

[1]: /images/20150530_migrando_wordpress_01.jpg
[2]: /images/20150530_migrando_wordpress_02.jpg
[3]: /images/20150530_migrando_wordpress_03.jpg

[11]: http://www.000webhost.com
[12]: http://www.domain.com
[13]: http://www.sherblog.es
[14]: https://codex.wordpress.org/es:Instalando_Wordpress
[15]: https://filezilla-project.org
[16]: http://austinmatzko.com/wordpress-plugins/wp-db-backup/