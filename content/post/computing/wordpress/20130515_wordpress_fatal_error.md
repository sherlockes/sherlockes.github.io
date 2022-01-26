---
title: "WordPress K.O. Fatal error. Allowed memory size"
date: "2013-05-14"
description: "Otra forma más de dejar WordPress fuera de servicio..."
thumbnail: "images/20130515_wordpress_php.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Wordpress"
draft: false
weight: 5
---
Hoy he intentado administrar el blog y me he encontrado con este pantallazo
  
![01]

Parece que hay un problema de memoria en el servidor. Lo primero que he pensado es que mi [host gratuito][11] había puesto limitaciones. Tras una breve incursión por la red he encontrado la solución, rápida y sencilla.

En el archivo en el archivo "wp-config.php" hay que añadir las siguientes líneas

```
/** Ampliación de memoria*/
define('WP_MEMORY_LIMIT', '96M');
```

Y a funcionar de nuevo!!!!!

**Actualización 20/8/2015**

Algo más de dos años después y no tengo muy claro porque, vuelve a aparecer el mismo problema en la web. Esta vez para solucionarlo he optado por una solución alternativa y que también he encontrado por la web. Se trata de modificar el archivo ".htaccess" que el propio wordpress genera. De esta forma he añadido al principio del mismo las siguientes tres líneas.

```
# Do not remove this line, otherwise mod_rewrite rules will stop working
RewriteBase /
php_value memory_limit 96M
```

No todos los servidores aceptan esta modificación así que habrá que consultarlo primero y además hay que tener en cuenta que el archivo a modificar no es el que se encuentra en el directorio raíz de tu alojamiento sino que es el que se encuentra en el directorio donde tienes instalado WordPress.

[01]: /images/20130515_error_php_memoria.jpg

[11]: http://www.000webhost.com/