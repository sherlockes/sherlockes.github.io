---
title: "Reducir puntos de un track gpx"
date: "2009-04-01"
creation: "2009-04-01"
description: "Reducir puntos de un track gpx"
#thumbnail: "images/titulo_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "gps"
tags:
  - "gpsbabel"
  - "tracks"
draft: false
weight: 5
---
Cada día más, la gente comparte las rutas mediante algún servicio online ([Wikiloc][1] es el que yo utilizo) para que cualquiera pueda verlas e incluso descargarlas para meterlas en el navegado gps y de esta forma poder seguirlas de una forma rápida y sencilla. Es cierto que la aventura pierde un poco de encanto pero ayuda a planificar el trayecto evitando así sorpresas que nos podrían arruinar un bonito día en el campo.

No voy a entrar en el modo de descargar el track desde la web o como cargarlo posteriormente en el navegador ya que las posibilidades son infinitas en función del servicio y el modelo que emplee cada uno, sólo recomendar que lo más adecuado parece hacerlo a través del formato "gpx" por ser el más extendido y común.

Una vez cargado el track en el navegador nos podemos encontrar con el problema de que este no es capaz de cargarlo en la memoria y nos muestra un error. Si el archivo está correctamente formateado (La mayoría de servicios detectan este problema cuando cualquiera intenta subirlos a la web) es muy probable que el problema venga a raiz de un número demasiado elevado de los puntos que conforman el trayecto. En mis rutas en bicicleta utilizo un [Garmin Edge 605][2] que, aunque el fabricante no lo dice por ningún sítio (O yo no he sido capaz de verlo), según fuentes oficiosas parece que tiene un límite de 500 puntos en los tracks importados (Esto no es cierto ya que he estado haciendo unas pruebas y he podido cargar archivos gpx de hasta 1850 puntos).

Cuando un track tiene muchos puntos puede ser por dos motivos, el primero de ellos, si el recorrido es muy largo así como el tiempo invertido, la cantidad de información recogida será elevada y necesaria de forma que la única forma de visualizar el track será partirlo en varias etapas (Esto para otro día que ya se me cansan los dedos). El segundo motivo es que se haya guardado más información de la necesaria, es decir, para seguir una ruta de algunos kilómetros no hace falta que la distancia entre dos puntos sea de algunos centímetros. Por si no ha quedado claro y una imagen vale más que mil palabras, en la siguiente podemos ver una ruta de menos de un kilómetro.

![imagen][11]

Esta ruta contiene unos 50 puntos, o lo que es lo mismo, se ha guardado información cada aproximadamente 13 metros. Ahora intentemos quitar algún punto de este track.

![imagen][12]

Esta ruta contiene sólo 6 puntos pero es tan sencilla de seguir como la anterior y además hemos facilitado la labor del navegador haciéndole cargar en la memoria un archivo con muchs menos puntos.

Y ahora viene el problema. ¿Cómo quito los puntos que sobran de un archivo gpx que me he descargado de la red?. Aquí es donde entra una herramienta informática que aunque no es perfecta si es muy útil y gratuita. Se traga de [GPSBabel][3] y es un pequeño programa que no requiere instalación y que se descarga desde [aquí][4]. Ejecutaremos el archivo "GPSBabelGUI.exe" una vez descomprimido y nos aparecerá la suguiente pantalla.

![imagen][13]

Tanto en el formato de entrada como en el de salida seleccionaremos "GPX XML (.gpx)" (En caso de que estemos trabajando con un archivo *.gpx e iniciaremos el cuadro de diálogo para el archivo de origen en primer lugar y posteriormente el de destino para decirle al programe donde queremos guardarlo. Seleccionaremos las rutas y pinchando en la opción "Filtrar" no aparece la siguiente ventana.

![imagen][14]

Aunque hay muchas opciones, para este caso únicamente seleccionaremos la opción de simplificar en el apartado de rutas y trazas e introduciremos el número máximo de puntos que queremos para nuestro archivo. Aceptando este cuadro de diálogo ya sólo resta pulsar en el botón "Iniciar" para que se cree un nuevo archivo con el número máximo de puntos que hemos indicado.

Este programa no hace ningún milagro, así que después de crear el archivo es importante compararla visualmente con la original para saber que podremos seguirla sin ningún problema.

 [1]: http://es.wikiloc.com/wikiloc/user.do?name=Sherlockes
 [2]: https://buy.garmin.com/shop/shop.do?cID=160&pID=10884
 [3]: http://www.gpsbabel.org/
 [4]: http://www.gpsbabel.org/download.html

 [11]: /images/20090401_reducir_gpx_1.jpg
 [12]: /images/20090401_reducir_gpx_2.jpg
 [13]: /images/20090401_reducir_gpx_3.jpg
 [14]: /images/20090401_reducir_gpx_4.jpg
