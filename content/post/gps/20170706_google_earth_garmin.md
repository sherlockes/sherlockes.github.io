---
title: "De Google Earth a mapa para Garmin en 5 minutos"
date: "2017-07-06"
description: "Un método para pasar las sendas, rutas o caminos que tengas dibujadas en Google Earth a un gps Garmin"
thumbnail: "images/20170706_google_to_garmin.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "a pedales"
  - "gps"
tags:
  - "garmin"
  - "google earth"
draft: false
weight: 5
---
Desde hace muchos años, utilizo [Topohispania][1] para la navegación en bicicleta con el Garmin Edge.

Recientemente, me ha vuelto a picar la curiosidad de como crear un mapa con las sendas y barrancos que no salen en Topohispania y que están por los lugares que circulo habitualmente para superponerlo en el gps de la bicicleta. Lo primero que escuentro es [esto][2], un tutorial de 2012 que emplea un sinfín de utilidades ya difíciles de encontrar y que echa para atrás sólo de ver la amplitud del mismo.

Busco un poco más y doy con la web [javawa][3] que ofrece todo lo necesario con sólo seguir unos pocos pasos.

 - Dibujar el/los track en Google Earth (si son varios usar una carpeta)
 - Guardar lugar como&#8230;(la ruta o la carpeta con varias) usando la extensión kml
 - Usar <a href="http://gpsvisualizer" target="_blank">http://www.gpsvisualizer.com</a> para convertir el archivo *.kml a *.gpx
 - Abrir IMGFromGPX (Se puede descargar desde <a href="http://www.javawa.nl/imgfromgpx_en.html" target="_blank">aquí</a>)
 - Arrastrar el archivo *.gpx a la ventana de IMGFromGPX
 - Seleccionar color y formato para la línea y nombre para el mapa
 - Crear mapa (Seleccionar la opción "Include creation of gmapsupp.img file")
 - Copiar el archivo gmapsupp.img al directorio raiz del gps (Atención, no sobreescribir)

Y ya está, que habíamos quedado que esto se hacía en cinco minutos¡¡¡

[1]: http://www.elgps.com/foroGPS/viewtopic.php?f=41&t=8646
[2]: http://www.foromtb.com/threads/paso-a-paso-crear-un-mapa-para-superponerlo-al-topohispania.888466/
[3]: http://www.javawa.nl