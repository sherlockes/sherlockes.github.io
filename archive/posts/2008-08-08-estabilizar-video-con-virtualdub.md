---
title: Estabilizar video con Virtualdub.
author: Sherlockes
type: post
date: 2008-08-08T10:02:56+00:00
url: /?p=106
categories:
  - Software
  - Virtualdub
tags:
  - edición
  - software
  - virtualdub

---
Este es un tema complicado, pero intentaremos afrontarlo de la forma más sencilla posible. Cualquiera que haya grabado con una cámara de vídeo se habrá dado cuente de que, por muy buen pulso que se tenga, si lo que no tenemos es una muy buena cámara al ver la imágenes aparece un temblequeo de la imagen que se acentúa notablemente a medida que aumentamos el zoom.

Este efecto tan desagradable puede ser corregido en mayor o menor medida mediante el uso conjunto de [Virtualdub][1] y [Deshaker][2] (Un plugin de Gunnar Thalin al igual de los de desentrelazar que vimos en este [post][3]). La instalación del plugin es tan simple como descargarlo de la [web][4] y copiarlo en la carpeta plugins de Virtualdub (Hay que descomprimirlo, eh¡). Con el plugin instalado, abriremos Virtualdub y seguiremos los siguientes pasos.

1.- Abrir el archivo de vídeo a estabilizar (File &#8211; Open video file&#8230;)
  
2.- Seleccionar la compresión de video (Video &#8211; Compression&#8230;)
  
3.- Añadir del filtro Deshaker (Video, Filters&#8230;, Add&#8230;, Deshaker, Ok)
  
4.- Seleccionar el aspecto de pixel y tipo de video (Primera columna)
  
5.- Aceptando (Luego veremos el tema de los parámetros)
  
6.- Guardamos el archivo de vídeo con un nombre distinto del original (File, Save as avi)
  
7.- Toca esperar
  
8.- Pasamos al modo 2 de Deshaker (Video, Filters, Doble click en Deshaker, Pass2)
  
9.- Aceptando (Luego veremos el tema de los parámetros)
  
10.- Guardamos el archivo de vídeo con un nombre distinto del original (File, Save as avi)

Ya tenemos el vídeo estabilizado aunque es muy probable que el resultado no os convenza, pero no hay que abandonar (Como me pasó a mi la primera vez), tan sólo perder un poco de tiempo ajustando los parámetros ya que cada grabación se debe tratar de una forma distinta en función de su naturaleza.

Para explicar el tema de los parámetros explicaré mi caso. Yo utilizo Deshaker para estabilizar las grabaciones que realizo con la cámara de la bicicleta que llevo puesta en la barra del manillar. No es difícil imaginar como cada paso por encima de una piedra, un bache u obstáculo en el camino o cada una de las continuas correcciones de la trayectoria en los descensos supone una fuerte sacudida para la cámara que aparece reflejada en la imagen grabada. Después de muchas horas y muchas pruebas (Con algo de lectura) he llegado a los parámetros que me permiten obtener los mejores resultados. Los parámetros que cambio son los siguientes:

  * Pass1 &#8211; Scale: Full
  * Pass1 &#8211; Use Pixels: All
  * Pass1 &#8211; Initial search range: 95%
  
    Con estas tres modificaciones simplemente conseguimos que el análisis de la imagen sea más robusto y fiables, aunque también mucho más lento

  * Pass2 &#8211; Edge Compensation: None

  * Pass2 &#8211; Extrapolate colors into border: Si
  
    Con estas dos modificaciones evitamos en un primer lugar que la imagen se nos deforme para adaptarse al fotograma completo para posteriormente rellenar con los colores de los bordes las zonas negras que han quedado vacías (Me parece mucho más agradable a la vista que el zoom adaptativo)

  * Pass2 &#8211; Motion Smothness &#8211; Horizontal Panning: 150

  * Pass2 &#8211; Motion Smothness &#8211; Horizontal Panning: 150
  * Pass2 &#8211; Motion Smothness &#8211; Rotation: 200
  * Pass2 &#8211; Motion Smothness &#8211; Zoom: 5
  * Pass2 &#8211; Max correction limits &#8211; Horizontal Panning: 15
  * Pass2 &#8211; Max correction limits &#8211; Vertical Panning: 15
  * Pass2 &#8211; Max correction limits &#8211; Rotation: 20
  * Pass2 &#8211; Max correction limits &#8211; Zoom: 1
  
    Con la variación de estos parámetros reducimos drásticamente la corrección del zoom para centrarnos en las variaciones verticales y horizontales ya que la cámara fija sobre el manillar puede hacer movimientos bruscos hacia arriba o abajo, derecha o izquierda pero no hacia delante o atrás, puesto que esto lo marca la velocidad de la bicicleta.

<center>
  <embed id="VideoPlayback" style="width:400px;height:326px" allowFullScreen="false" src="http://video.google.com/googleplayer.swf?docid=2756274915496290606&hl=es&fs=true" type="application/x-shockwave-flash">
  </embed>
</center>

En la parte izquierda del vídeo aparece la imagen sin estabilizar y en la derecha la imagen estabilizada con este método, no hace milagros, pero los resultados son sorprendentes. Las imágenes son de muy poca calidad a causa de la exportación en premiere, no es problema de Virtualdub + Deshaker.

 [1]: http://www.virtualdub.org/
 [2]: http://www.guthspot.se/video/deshaker.htm
 [3]: http://sherver.homeip.net/blog/?p=82
 [4]: http://www.guthspot.se/video/files/Deshaker.zip