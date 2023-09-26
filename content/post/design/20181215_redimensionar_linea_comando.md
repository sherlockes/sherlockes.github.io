---
title: "Redimensionar imágenes desde la línea de comandos"
date: "2019-01-07"
creation: "2018-12-10"
description: "Redimensionar una imagen solo cuesta un minuto, pero... ¿Tienes 100 minutos para redimensionar 100?"
thumbnail: "images/20181210_redimensionar_linea_comando_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "diseño"
  - "linux"
tags:
  - "bash"
  - "imagemagick"
draft: false
weight: 5
---
Hace unos días me encontré con un problema a la hora de mandar imprimir unas fotografías y es que dentro de las seleccionadas había diversos tamaños por lo que tuve que igualarlas.

Si solo fueran unas pocas fotos no me hubiera planteado "automatizar" la tarea pero al tratarse de casi cien fotografías me da pereza hacerlo una a una manualmente mediante.

Habitualmente uso Gimp para el retoque y ajuste de imágenes. Este potente software libre dispone de un modo de procesamiento de imágenes por lotes del que no cuesta mucho encontrar información pero que tiene una curva de aprendizaje demasiado fuerte para lo que ahora necesito.

Tras "googlear" un poco me encuentro con una herramienta que promete hacer lo que ahora necesito y mucho más de una forma rápida y sencilla. 

https://imagemagick.org

Compacto y gratuito hace que merezca la pena el esfuerzo de aprender a manejarlo desde la línea de comandos.

La instalación tanto en Linux Mint como en Lubuntu a partir de los repositorios oficiales de cada distribución es tan sencillo como...

```
sudo apt-get install imagemagick
```

... aunque es posible de que no se instale la versión más reciente.  En mi caso, para la instalación en Lubuntu se me ha instalado la versión 6.9.7 cuando la versión oficial es la 7.0.8.  En princicio aguantaré este desfase pero si veo algún comportamiento anómalo realizaré na instalación manual de la última versión.

> Antes de seguir adelante hay que tener claros los tres parámetros que afectan al tamaño en el que vamos a imprimir nuestras fotografías.  En primer lugar está el tamaño de imagen, normalmente expresada en píxeles y que hace referencia al tamaño que la imagen va a adoptar en la pantalla. En segundo lugar tenemos la resolución de imagen que hace referencia al número de píxeles por unidad de impresión real, normalmente expresada en píxeles por pulgada o centímetro. Finalmente y como combinación de los dos anteriores nos encontramos con el tamaño de impresión y que nos mostrará el tamaño final en el que va a ser impresa nuestra fotografía.

Pues bien, la principal preocupación a la hora de imprimir unas fotografías es que el tamaño de la impresión sea correcto. Para garantizarlo, tanto Gimp como Photoshop permiten modificar el parámetro "tamaño de impresión" pero esta utilidad de línea de comandos no lo permite por lo que tendremos que ajustar el tamaño en píxeles y la resolución para garantizar el tamaño final.

La resolución o densidad de píxeles por unidad de longitud no es un parámetro con el que debamos "jugar" ya que en fotografía están estandarizados los 300 puntos por pulgada de forma que para calcular el ancho y el alto de una fotografía de 15x10cm usaremos la siguiente fórmula.

anchopx = (anchocm x dpi)/2.54 = (15 x 300) / 2.54 = 1772 px
altopx = (altocm x dpi) / 2.54 = (10 x 300) / 2.54 = 1181 px

Con todo lo anterior ya estamos en condiciones de ejecutar el comando que nos convertirá todas las imágenes de una carpeta de forma que todas tengan una traición de 300 dpi y que su lado más largo encaje en una fotografía de 10x15 cm, formato en el que se van a imprimir.

```
mogrify -path salida -units PixelsPerInch -resample 300 -rotate "90<" -resize 1772x1181 *.*
```

Donde
- mogrify ... es el comando que indica el procesamiento de imágenes en lotes
- path salida ... indica que las imagenes modificadas se guardarán en la carpeta "salida" que deberá existir
- units PixelsPerInch ... indica que la unidad de medida para el muestreo será en píxeles por pulgada
- resample 300 ... indica que se "remuestrearán" las imágenes a 300 píxeles por pulgada
- rotate "90<" ... indica que las imágenes cuyo alto sea mayor que el ancho serán giradas 90º
- resize 1772x1181 ... indica el tamaño al que se va a redimensionar cada imagen

Y con esto ya está, ejecutamos el comando en la carpeta donde tengamos las imágenes y se guardarán las imágenes modificadas en la carpeta "salida".
