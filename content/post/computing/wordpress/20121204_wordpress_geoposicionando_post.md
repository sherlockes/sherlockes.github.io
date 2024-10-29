---
title: "Geoposicionando post en WordPress"
date: "2012-12-04"
creation: "2012-12-04"
description: "Ubicando los post en el mapa dentro de WordPress"
thumbnail: "images/20121204_osm_02.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "WordPress"
tags:
  - "osm"
draft: false
weight: 5
---
Esta es una demostración de que muchas veces la solución a un problema es mucho más sencilla de lo que nos parece, simplemente hay que invertir un poco de tiempo en [buscar][11] información y tener paciencia en la consecución de los objetivos.

Lo que busco con el geoposicionamiento de algunos de los post del blog en tan simple como tener dibujado un mapa en el que, mediante unos iconos, aparezcan representados determinados post según su ubicación real.

La primera solución con la que me encuentro es sin duda alguna la más sencilla y rápida de implementar. Pasa por crear un mapa personalizado en [Google Maps][12] que insertaremos en el blog y en el que cada vez que se publique un post deberemos incluir un marcador de posición según la ubicación real y un enlace con el post del blog. Algo así hice algún tiempo como se puede ver en el siguiente mapa.

<iframe width="600" height="400" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.es/maps/ms?msa=0&msid=216843463982996946965.0004890dc20e5e2563324&ie=UTF8&t=m&ll=41.351814,-0.371819&spn=0.051544,0.102825&z=13&output=embed"></iframe>

Ver [Panorámicas de un meandro][12] en un mapa más grande

Como ya he comentado, es la solución más rápida y sencilla ya que en unos pocos minutos tienes incrustado el mapa, pero tiene dos grandes problemas, uno que es poco práctico (Crear el mapa cuesta poco pero insertar un nuevo punto para cada post puede llegar a dar pereza) y otro que es poco configurable (Discriminar entre post de distintas categorías supondrá la creación de un nuevo mapa). Por estas dos razones he proseguido mi investigación en busca de un método más potente e igual de barato.

Navegando por la web de [plugins][14] de [wordpress][15] he encontrado varias alternativas que me pueden ayudar con el problema. Despues de probar varios (En el servidor local, que es más rápido y limpio) me he decidido por instalar [WordPress OpenStreetMaps Plugin][16].


![Image][01]
  
La instalación es tan simple como copiar la carpeta en la de plugins de la instalación de WordPress del servidor, activar el plugin y posteriormente desde la pestaña "Ajustes/OSM" de la barra lateral de la administración del blog incluir el nombre que desees para el campo personalizado y el máximo nivel de zoom (Ambas opciones están al final de la página de configuración.

![Image][03]

Para incluir la posición de un post que tengamos activado en el menú "opciones de pantalla" (Arriba a la derecha justo debajo de tu nombre de usuario de WordPress) la opción de "Campos personalizados" para que estos estén visibles y añadiremos un campo con el mismo nombre que hemos puesto en la pantalla de configuración y cuyo valor será las coordenadas de la localización del post (Latitud y longitud en grados con valores decimales)


![Image][04]
  
Para insertar el mapa con los post geoposicionados en una página o post debemos volver a la página de configuración de OSM y ajustar el mapa de configuración hasta ver el área que deseamos, después hacemos click sobre el y copiamos el código (Shortcode) que aparece bajo el y que incluiremos donde queramos insertar el mapa.

![Image][05]

A partir de aquí sólo resta jugar un poco con los parámetros del mapa hasta dejarlo a tu gusto. 


[01]: /images/20121204_osm_01.jpg
[03]: /images/20121204_osm_03.jpg
[04]: /images/20121204_osm_04.jpg
[05]: /images/20121204_osm_05.jpg

[11]: http://www.google.es
[12]: https://maps.google.es/
[13]: https://maps.google.es/maps/ms?msa=0&msid=216843463982996946965.0004890dc20e5e2563324&ie=UTF8&t=m&ll=41.351814,-0.371819&spn=0.051544,0.102825&z=13&source=embed" style="color:#0000FF;text-align:left"
[14]: http://wordpress.org/extend/plugins/
[15]: http://wordpress.org/
[16]: http://wordpress.org/extend/plugins/osm/
