---
title: "Flujo de trabajo con imágenes en WordPress"
date: "2017-03-30"
creation: "2017-03-30"
description: "Mi forma de trabajar con las imágenes en WordPress"
thumbnail: "images/20170330_faststone_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Wordpress"
draft: false
weight: 5
---
Al publicar un post en WordPress una de las cosas que más pereza da es la inclusión de imágenes ya que hay que capturarlas, recortarlas, guardarlas, renombrarlas, subirlas al servidor e incrustarlas en el post. En este proceso pueden intervenir varias utilidades y programas por lo que resulta laborioso.

Para todo esto utilizo [Faststone Capture][7] en su versión portable que puedes descargar desde [aquí][8]. Una pequeña pero potente utilidad que cubre todas las fases arriba mencionadas para la edición de imágenes. Si, la aplicación no es gratis pero puedes probar una versión de 30 días completamente funcional para ver si te interesa desembolsar los 20$. También puedes encontrar una medicina [aquí][9].

El programa consta en principio de una pequeña barra flotante tal y como se puede ver en la siguiente imagen.

![Imagen][1]

No voy a describir todas las opciones que tiene el programa ya que para eso ya está la [web del creador][10]. Simplemente mostrar como yo lo utilizo cuando necesito una captura de pantalla o redimensionar una imagen para incrustar en un artículo.

En caso de tener que redimensionar una imagen es tan simple como arrastrarla desde el explorador de archivos hasta la barra flotante de Faststone y se abrirá un pequeño editor de imágenes donde podemos recortar, redimendionar y guardar la imagen ajustándola a nuestras necesidades.

![Imagen][2]

Si lo que necesitamos es una captura de pantalla, Faststone nos ofrece varias opciones de hacerlo, por ventana, por area... y después varias destinos para la captura realizada. Personalmente utilizo el editor como destino para ajustar el tamaño de la imagen y renombrarla adecuadamente.

![Imagen][3]

A la hora de renombrar las imágenes resulta interesante utilizar un método para que luego la biblioteca no sea un caos. Personalmente yo utilizo el formato fecha\_identificación\_número" de forma que los nombres de las imágenes de este post serán del tipo: 20170330_faststone_01.jpg

Una vez que tenemos listas todas las imágenes ya las podemos importar desde nuestro ordenador hasta la biblioteca de medios de WordPress en nuestro servidor mediante el menú del escritorio de WordPress "Medios - Añadir nuevo"

![Imagen][4]

Finalmente ya sólo resta incrustar las imágenes en el post, si utilizamos el código que automáticamente nos genera WordPress desde la biblioteca, en el post nos aparecerá algo como lo siguiente:

![Imagen][5]

Prefiero utilizar rutas relativas por si hay que realizar alguna migración y puesto que la imagen ya está redimensionada a nuestras necesidades no es necesario especificar ancho y alto. Para la alineación utilizo etiquetas html externas de forma que el código para incrustar una imagen en mis post queda así.

![Imagen][6]

[1]: /images/20170330_faststone_01.jpg
[2]: /images/20170330_faststone_02.jpg
[3]: /images/20170330_faststone_03.jpg
[4]: /images/20170330_faststone_04.jpg
[5]: /images/20170330_faststone_05.jpg
[6]: /images/20170330_faststone_06.jpg
[7]: http://www.faststone.org/FSCaptureDetail.htm
[8]: http://www.faststone.org/FSCapturerDownload.htm
[9]: https://www.crackhex.ch/topic/1630-faststone-capture-84-serial-keygen/
[10]: http://www.faststone.org/FSCaptureDetail.htm