---
title: "HDR con Photomatix y Photoshop"
date: "2009-07-07"
description: "HDR con Photomatix y Photoshop"
#thumbnail: "images/titulo_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "diseño"
tags:
  - "photoshop"
  - "photomatix"
  - "hdr"
draft: false
weight: 5
---
A estas alturas de partido, es muy probable que sepas Lo que significa HDR en fotografía pero si no es así, la [wikipedia][1] está siempre lista para ayudarte.

Existen muchos métodos para realizar este tipo de tomas pero ahora me voy a centrar en el que mejores resultados me ha dado hasta ahora, una combinación de [Photomatix][2] y [Photoshop][3]. Ninguno de los dos programas son gratuítos pero podemos descargar una versión de evaluación y si los resultados no parecen satisfactorios comprarlos o encargarlos a la burra.

Para realizar este método podemos partir de varias tomas con distinta exposición (Realizadas con un buen trípode y disparador) o bien a partir de un RAW correctamente expuesto. En exteriores, la realización de varias tomas de un mismo objeto implica un cierto grado de calma meteorológica para que los niveles de ruido sean aceptables. Puesto que por aquí tenemos casi siempre a nuestro amigo el cierzo, partiré un archivo RAW para obtener varias exposiciones.

![imagen][11]
 
Esta es la imagen de partida, aunque está bien expuesta, tanto del cielo cono de las zonas oscuras se podría sacar mucha más información. Para empezar con el método abrimos la imagen con Adobe Camera Raw y seleccionaremos la opción "auto" para la configuración. Pulsando la tecla Mayúsculas veremos como el la parte inferior derecha el botón "Abrir Imagen" se convierte en "Abrir Objeto" y haremos click sobre el.

![imagen][12]

Ahora se nos ha creado un nuevo archivo de Photoshop cuyo contenido es un objeto inteligente con nuestra imagen del que obtendremos varias tomas con diferentes exposiciones para lo cual volveremos al Camera Raw haciendo doble click en el icono de la capa correspondiente.

![imagen][13]
  
Ahora seguiremos el siguiente proceso para conseguir las distintas tomas a distintas exposiciones.
     
1.- Modificar el valor de exposición en Camera Raw
     
2.- Aceptamos (Botón "Ok")
     
3.- Archivo-Guardar como (Renombramos acorde a la exposición p.ej "foto-3.jpg")
     
4.- Volver a Camera Raw para obtener la siguiente toma.

De esta forma, haciendo un barrido en exposiciones desde -3 hasta 2 he conseguido las siguientes tomas. No importa que en alguna de las tomas hay zonas quemadas o claramente subexpuestas, ya que Photomatix despreciará esta información para realizar la combinación de todas.

![imagen][15]
  
Ahora ya podemos abrir Photomatix, un programa que en un primer momento no impresiona demasiado, ya que la interfaz es bastante simple.

![imagen][14]

Con el botón "Generate HDR Image" arrancaremos el proceso y a continuación seleccionaremos las seis tomas que hemos creado. En la siguiente pantalla modificaremos los valores de la columna de la derecha para que coincidan con las exposiciones de cada una de las tomas (Si hemos incluido la exposición en el nombre este proceso es muy sencillo).

![imagen][16]

El siguiente paso nos muestra unas opciones para alinear las tomas y eliminar objetos fantasma de laguna de ellas. En nuestro caso como hemos sacado todas las exposiciones de una sola toma no son necesarias estas alternativas.

![imagen][17]

La siguiente pantalla nos muestra el HDR sin procesar y nos indica como la mayoría de monitores no son capaces de mostrarlo correctamente. Pulsaremos el botón "Tone Mapping" para continuar el proceso.

![imagen][18]
  
A continuación llegan una gran cantidad de opciones que no voy a entrar a describir ya que para eso está el creador del software. Simplemente pinchando en "Process" crearemos el archivo HDR.

![imagen][19]
  
Ahora desde el propio Photomatix guardaremos el archivo mediante el menú "File-Save as". Es importante guardar ahora el archivo como un Tiff de 16 bits para no perder nada de información. A continuación abriremos este archivo guardado con Photoshop para ver lo siguiente.

![imagen][20]
  
Aunque la fotografía ha ganado bastante, todavía se le pueden realizar unos ajustes pero lo siento, esto ya paro otro día, aquí queda al fin la fotografía terminada.

![imagen][21]
  
Si tienes alguna duda o crees que algún punto no ha quedado del todo claro, no te lo pienses dos veces y deja un comentario, intentaré aclarar el punto en cuestión.

[1]: http://es.wikipedia.org/wiki/High_Dynamic_Range_Rendering
[2]: http://www.hdrsoft.com/index.html
[3]: http://www.adobe.com/es/products/photoshop/photoshop/

[11]: /images/20090707_hdr_01.jpg
[12]: /images/20090707_hdr_02.jpg
[13]: /images/20090707_hdr_03.jpg
[14]: /images/20090707_hdr_04.jpg
[15]: /images/20090707_hdr_05.jpg
[16]: /images/20090707_hdr_06.jpg
[17]: /images/20090707_hdr_07.jpg
[18]: /images/20090707_hdr_08.jpg
[19]: /images/20090707_hdr_09.jpg
[20]: /images/20090707_hdr_10.jpg
[21]: /images/20090707_hdr_11.jpg