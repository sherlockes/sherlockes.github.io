---
title: "Problema con WP-DB-Backup"
date: "2009-02-18"
description: "Problema con WP-DB-Backup"
#thumbnail: "images/titulo_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "wordpress"
draft: false
weight: 5
---

A raíz de las últimas actualizaciones de [WordPress][1], tengo un problema con el plugin [wp-db-backup][2] y es que cuando lo activo e intento acceder a la zona de administración me aparece un hermoso cartel en el que se informa "No estás autorizado para acceder a esta página" aún después de haber mi nombre de usuario y contraseña como administrador.

Para el que no lo sepa, la única misión de este complemento es realizar una copia de seguridad de la base de datos que gestiona wordpress bajo demanda del usuario o programada con una cierta frecuencia. Aunque no es indispensable ya que este respaldo se puede efectuar por otros caminos, el tiempo que ahorra es importante y sin ningún esfuerzo te garantiza que podrás recuperar la información del blog ante cualquier problema del servidor.

Pues bien, el problema tiene dos soluciones. Nos podemos olvidar de este plugin (Así he estado durante los dos últimos meses) o bien editamos el archivo "wp-config.php" y borramos las siguientes líneas.

```
 * Authentication Unique Keys.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/ WordPress.org secret-key service}
 *
 * @since 2.6.0
 */
define('AUTH_KEY', 'put your unique phrase here');
define('SECURE_AUTH_KEY', 'put your unique phrase here');
define('LOGGED_IN_KEY', 'put your unique phrase here');
define('NONCE_KEY', 'put your unique phrase here');
/**#@-*/
```


Todavía no tengo muy claro cual es la finalidad de estas cuatro variables de autentificación que han aparecido en las últimas versiones de WordPress ya que el Blog funciona exactamente igual sin definir estas variables. Cuando sepa algo más aquí lo postearé.

 [1]: http://wordpress.org/
 [2]: http://wordpress.org/extend/plugins/wp-db-backup/