---
title: "Crear panorámica a partir de un vídeo"
date: "2015-09-15"
creation: "2015-09-15"
description: "Aquí muestro el método que empleo para crear fotografías panorámicas a partir de una toma de vídeo de una forma sencilla y gratuita."
#thumbnail: "images/titulo_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "diseño"
tags:
  - "panoramica"
draft: false
weight: 5
---
Hasta hace un tiempo, en mis salidas con la bicicleta a la caza de vértices geodésicos cargaba con una cámara fotográfica digital compacta. Para hacer una vista panorámica desde el vértice tomaba varias instantáneas que luego fundía con paciencia y photoshop. Ahora cargo con la pequeña Gopro y realizo un barrido panorámico en vídeo. Pues bien, el problema pasa por la forma de convertir el vídeo tomado en una fotografía panorámica.

Navegando por la red podrás encontrar varios métodos, el que aquí describo es el que yo empleo y que hasta ahora más me ha convencido por su sencillez, rapidez y además de utilizar sólo programas gratuitos. El flujo de trabajo está basado en dos pasos, en el primero obtendremos los fotogramas significativos a partir del archivo de vídeo y en el segundo fundiremos estos fotogramas en una solo fotografía panorámica.

### Consiguiendo los fotogramas
Esta es la parte fácil de nuestro problema ya que son muchas las formas de extraer la fotogramas de un video.  Yo utilizo [Free Video To Jpg Converter][11], un pequeño programa que simplemente hace lo que dice si nombre, convertir un vídeo a una secuencia de imágenes estáticas.

![imagen][2]

El software ofrece varias alternativas a la hora de la extracción, yo convierto el vídeo a 20 imágenes para luego quedarme con las 10 más significativas y borrar las restantes.

**2.- Fusionando los fotogramas.**

Aquí viene la parte más curiosa del artículo y es que después de muchos años usando multitud de programas de edición fotografica jamás me hubiera imaginado terminar usando un programa de Microsoft y mucho menos que este fuera gratuito.

Se trata de [Microsoft Image Composite Editor][12] y puedes descargarlo desde la web de Microsoft.  Aunque el programa permite la obtención directa de una imagen panorámica a partir de un video, no soporta el formato nativo de Gopro por lo que usaremos la opción de crear la panorámica a partir de varios imágenes.
  
No pretendo hacer una guía de manejo de ninguno de los dos programas ya que su funcionamiento es muy sencillo e intuitivo.

![imagen][1]

Invito a que cada uno haga sus pruebas y obtenga resultados, ante cualquier duda o aportación que nadie dude en dejar un comentario.

Sin mucha complicación es rápido y sencillo conseguir una panorámica como esta.

![Panorámica](http://static.panoramio.com/photos/large/123088397.jpg)

Suerte¡¡¡


[1]: /images/20150915_ICE.jpg
[2]: /images/20150915_video2jpg.jpg

[11]: https://www.dvdvideosoft.com/es/products/dvd/Free-Video-to-JPG-Converter.htm#.Ve9K0DldaK0
[12]: http://research.microsoft.com/en-us/um/redmond/projects/ice/