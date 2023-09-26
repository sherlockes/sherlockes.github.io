---
title: Usando VirtualDub.
author: Sherlockes
type: post
date: 2008-06-17T18:34:59+00:00
url: /?p=75
categories:
  - Software
  - Virtualdub
tags:
  - software
  - virtualdub

---
De los programas que conozco, quizás [VirtualDub][1] sea el más sorprendente de todos ya que la primera impresión que da es la de un software más bien pobre con el que no se podrá hacer gran cosa, pero todo lo contrario, este programa tiene unas posibilidades asombrosas en el mundo de la edición de vídeo, el único problema que tiene es que es muy poco intuitivo y cuesta un poco empezar a manejarlo lo cual es una razón más que suficiente para que muchas personas lo hayan desechado a los pocos minutos de caer en sus manos.

El único requisito previo necesario que recomiendo es la instalación de un paquete de codecs para audio y video que aunque los puristas lo odian creo que es la solución más rápida y práctica ([K-Lite codec pack][2] está bastante bien). Como ya os habréis imaginado, el software es gratuito puesto que de lo contrario no estaría escribiendo esto. Para empezar con el lo principal es [descargarlo][3](Es recomendable la última versión estable para 32 o 64 bits en función de tu procesador). Lo primero que llama la atención es que no hay que instalar absolutamente nada, simplemente descomprimes el contenido del archivo en una carpeta y a funcionar ejecutando el archivo "VirtualDub.exe". Tras un mensaje informativo sobre la existencia de una ayuda que los españoles despreciaremos en un primer momento nos aparece el siguiente pantallazo.

<center>
  <img src="sherblog/wp-content/uploads/images/20080617_virtualdub_01.jpg" />
</center>

Para empezar con el programa nos pondremos un reto. Tengo un vídeo en formato "avi" con unas dimensiones de 640&#215;480 píxeles del que quiero cortar un breve fragmento del principio y otro del final que son innecesarios para después guardarlo en formato "divx" que me han dicho que ocupa menos espacio y con unas dimensiones de 320&#215;240 píxeles que es como les gusta más a los del [youtube][4]. Además le quitaremos el sonido para no escuchar las tontadas que dice alguno detrás de la cámara y otro día veremos como aprender a colocar música de fondo. Pues bien, los pasos a seguir serán los siguientes.

1.- Abrir el archivo de vídeo (File &#8211; Open video file&#8230;)
  
2.- Despreciar el audio (Audio &#8211; No audio)
  
3.- Añadir el filtro para redimensionar (Video &#8211; Filters &#8211; Add &#8211; Resize)
  
4.- Seleccionar el método absoluto a 320&#215;240 y aplicar
  
5.- Formato de compresión de video (Video &#8211; Compression &#8211; divx &#8211; configure)
  
6.- Configurar el compresor (Seleccionar calidad)
  
7.- Seleccionar el trozo útil que deseamos comprimir
  
8.- Guardar archivo (File &#8211; Save as avi&#8230;)

Pero como una imagen vale más que mil palabras, aquí os dejo el vídeo con la situación real.
  


<center>
  <embed id="VideoPlayback" style="width:400px;height:326px" allowFullScreen="false" flashvars="fs=true" src="http://video.google.com/googleplayer.swf?docid=-7477836183615533451&hl=es" type="application/x-shockwave-flash">
  </embed>
</center>

El vídeo está subtitulado para que sea más fácil de seguir con los pasos que se van dando en cada momento, si no ves los subtítulos deberás pinchar el botón que está junto a la barra de desplazamiento del nivel de audio.

Un consejo muy importante que que antes de intentar guardar el archivo definitivo es que hagas tus pruebas con un fragmento pequeño del vídeo ya que de esta forma perderás mucho menos tiempo esperando a que tu ordenador recomprima la información del archivo.

En otra ocasión veremos como cambiar el sonido que hemos despreciado por una música de fondo y otras muchas habilidades que tiene VirtualDub.

 [1]: http://www.virtualdub.org/
 [2]: http://www.codecguide.com/
 [3]: http://virtualdub.sourceforge.net/
 [4]: http://www.youtube.com