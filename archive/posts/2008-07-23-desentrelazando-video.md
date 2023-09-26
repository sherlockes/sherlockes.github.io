---
title: Desentrelazar video con Virtualdub.
author: Sherlockes
type: post
date: 2008-07-23T15:10:23+00:00
url: /?p=82
categories:
  - Software
  - Virtualdub
tags:
  - edición
  - software
  - virtualdub

---
Hace mucho tiempo que tenía este problema, pero ha sido hace unos días cuando me he metido de lleno con el. La situación es la siguiente, al pasar los vídeos desde la cámara ( Una JVC Everio GZ-MG21E que no es ningún portento de la tecnología pero que es un aparato decente aunque el fabricante ya la ha dejado de vender) al ordenador el resultado es horrible tal y como se puede ver el el siguiente recorte de uno de los fotogramas.
  


<center>
  <img src="sherblog/wp-content/uploads/images/20080723_entrelazado01_original.jpg" />
</center>


  
En un principio pensé que era un problema de codecs o del software utilizado para convertir los mpeg2 creados por la máquina en archivos avi más manejables pero tras una tiempo dando tumbos de un lado a otro y probar muchos programas, no conseguí un resultado satisfactorio por lo que me encomendé a San Google una vez más.
  
La primera conclusión es que el problema reside en el [entrelazado][1] del MPEG2 que no se interpreta correctamente al convertirlo en avi apareciendo este molesto efecto persiana que hace que la imagen pierda claridad. Pues bien, la solución pasa por desentrelazar el vídeo al convertirlo a avi pero el problema ahora es escoger entre los diferentes métodos existentes.
  
**Método 1.** Usando el filtro "deinterlace" con "Blend mode" que trae por defecto virtualdub. Abrimos el archivo de vídeo y aplicamos el filtro de vídeo.

<center>
  <img src="sherblog/wp-content/uploads/images/20080723_entrelazado021_internal_blend.jpg" />
</center>

Si no lo tienes claro puedes leer el artículo sobre [abrir mpeg con Virtualdub][2] que escribí hace unos días. Con este método conseguimos el siguiente resultado.

<center>
  <img src="sherblog/wp-content/uploads/images/20080723_entrelazado02_internal_blend.jpg" />
</center>

Ninguna maravilla, aunque ha desaparecido parcialmente el efecto persiana la imagen no ha ganado apenas claridad ya que se produce un fundido de ambas imágenes apareciendo el efecto Blur. Este resultado creo que todavía no se puede dar por válido, ya que apenas es visible el dorsal del carenado de la moto.

**Método 2.** Aplicando el mismo filtro que anteriormente pero en lugar de escoger "Blend Mode" optamos por duplicar uno de los campos y el resultado queda así.

<center>
  <img src="sherblog/wp-content/uploads/images/20080723_entrelazado03_internal_duplicate.jpg" />
</center>

El resultado es sustancialmente mejor que el anterior e incluso puede darse por bueno teniendo en cuenta que la imagen que muestro no es más que una pequeña zona del fotograma de la película original. El único pero que le podemos poner a este método es que estamos despreciando la mitad de la información que está grabando la cámara perdiendo la consiguiente resolución.

**Método 3.** Sin aplicar ningún filtro en VirtualDub, al seleccionar la compresión de video seleccionamos Divx y en la pantalla de configuración seleccionamos la pestaña de video de forma que veremos algo parecido a lo siguiente en función de la versión que tengamos del compresor.

<center>
  <img src="sherblog/wp-content/uploads/images/20080723_entrelazado041_divx.jpg" />
</center>

En el apartado "Interlace" dentro del procesado de imágenes seleccionamos "De-Interlace source" y directamente guardamos el archivo obteniendo el siguiente resultado.

<center>
  <img src="sherblog/wp-content/uploads/images/20080723_entrelazado04_divx.jpg" />
</center>

Personalmente creo que este método es un poco mejor que los anteriores ya que combina la nitidez del segundo método con el fundido del primero.

Hay muchos más métodos para desentrelazar, en esta [web][3] se explican otros entre los que destacan estos [filtros][4] de Gunnar Thalin.

Lo cierto es que con este intento nos hemos metido en una de las peores situaciones, ya que las imágenes han sido grabadas con zoom, en la arbitrariedad de la naturaleza y persiguiendo un objeto móvil sin trípode ni ningún tipo de estabilizador. Con todo, los resultados son notablemente mejores que los obtenidos en las grabaciones del año pasado del mismo evento sin desentrelazar el vídeo.

En otro artículo intentaré explicar las posibles soluciones que hay para estabilizar la imagen temblorosa con el propio VirtualDub.

 [1]: http://es.wikipedia.org/wiki/Exploraci%C3%B3n_entrelazada
 [2]: http://sherver.homeip.net/blog/?p=80
 [3]: http://www.100fps.com/
 [4]: http://www.guthspot.se/video/