---
title: 'Abrir archivos *.mpeg con Virtualdub.'
author: Sherlockes
type: post
date: 2008-07-10T09:15:31+00:00
url: /?p=80
categories:
  - Software
  - Virtualdub
tags:
  - mpeg
  - software
  - virtualdub

---
Es posible que al abrir archivos de vídeo mpg con Virtualdub aparezca en pantalla un error como el siguiente.

<center>
  <img src="sherblog/wp-content/uploads/images/20080710_virtualdub_mpeg2.jpg" />
</center>

Esto es debido a que las versión original de VirtualDub no es capaz de reconocer el formato de estos archivos debido a la licencia del mismo. Pero este no es el fin, ya que gracias a que VirtualDub tiene el código fuente libre hay programadores que hacen modificaciones en el mismo para obtener una versión de VirtualDub modificada (Mod). Gracias a [fccHandler&#8217;s stuff][1] tenemos [VirtualDub-MPEG2][2]. Este Mod abre sin ningún problema los *.mpg que la versión original no podía pero tiene un pequeño problema ya que por lo general pasará un tiempo desde que se actualice la versión original de VirtualDub hasta que se cree esta versión modificada, de forma que nos podemos encontrar con 2 VirtualDub en nuestro ordenador (Como yo he estado durante mucho tiempo). Los mismos [fccHandler&#8217;s stuff][1] nos ofrecen un plugin para VirtualDub que podemos descargar desde [aquí][3], descomprimirlo y copiarlo a la carpeta "plugins" de la versión original de VirtualDub para dotarla de la capacidad de abrir estos archivos.

 [1]: http://home.comcast.net/~fcchandler/index.html
 [2]: http://home.comcast.net/~fcchandler/stable/index.html
 [3]: http://home.comcast.net/~fcchandler/Plugins/MPEG2/index.html