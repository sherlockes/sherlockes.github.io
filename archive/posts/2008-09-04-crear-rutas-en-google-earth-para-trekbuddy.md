---
title: Crear rutas en Google Earth para trekbuddy
author: Sherlockes
type: post
date: 2008-09-04T12:04:51+00:00
url: /?p=178
categories:
  - Rutas
  - Software
  - Trekbuddy
tags:
  - earth
  - google
  - software
  - tracks
  - trekbuddy

---
A estas alturas de aprendizaje seguro que ya podemos ver los mapas que hemos creado en nuestro teléfono mediante trekbuddy, ahora aprenderemos a dibujar una ruta y pasarla al teléfono para poderla seguir posteriormente.

Para esta labor necesitaremos un par de programas, por un lado el archiconocido [Google Earth][1] y por otro el antiquísimo pero eficaz [kml2gpx][2]. Instalaremos Google Earth y descomprimiremos kml2gpx de forma que ya estamos listos para dibujar la ruta que deseamos realizar en Google Earth tal y como se muestra en el siguiente vídeo.

<center>
  <embed id="VideoPlayback" src="http://video.google.com/googleplayer.swf?docid=-9124619522121394411&hl=es&fs=true" style="width:400px;height:326px" allowFullScreen="true" allowScriptAccess="always" type="application/x-shockwave-flash">
  </embed>
  
  <br />
</center>

Siguiendo las instrucciones del vídeo, ahora tendrás un archivo "loquesea.kml" que guarda la información de la ruta. Si tienes un archivo con extensión *.kmz no te preocupes, sólo hay que abrirlo con [Winrar][3] u otro descompresor y guardar el archivo *.kml resultante. Pues bien, a continuación ejecutamos "kml2gpx.exe" para ver lo siguiente.

<center>
  <img src="sherblog/wp-content/uploads/images/20080904_kml2gpx.jpg" alt="" />
</center>

Selecionamos la ruta que hemos guardado anteriormente y la carpeta donde queremos que sea convertida de forma que ya tendremos un archivo *.gpx que puede ser interpretado por Trekbuddy.

_Nota: Si al ejecutar "kml2gpx.exe" te sale un error es por que no tienes instalado el "<a href="http://msdn.microsoft.com/en-us/netframework/aa731542.aspx" target="_blank">.NET Framework 2.0</a>"_

En la carpeta que en Trekbuddy hemos definido como localización de archivos crearemos una nueva carpeta llamada "wpts" donde guardaremos el archivo gpx que hemos generado con la ruta. Con esto ejecutamos las siguientes acciones en el teléfono.

1.- Abrir Trekbuddy
  
2.- Cargamos el atlas o mapa de la zona (Menu &#8211; Cargar mapa o cargar atlas)
  
3.- Pulsamos y abrimos el menú de waypoints
  
4.- Selecionamos el archivo gpx guardado
  
5.- Opciones &#8211; Seguir ruta

Ahora nos aparecerá en la brújula una flecha verde que indica la dirección en la que esta el siguiente punto por el que tenemos que pasar para seguir la ruta cargada. Cuando activemos el gps saldrá otra flecha roja que nos indicará la dirección real que estamos siguiendo.

Gracias a [X2FER][4] tenemos una traducción al castellano que en otro post explicaré como instalar. Además, las últimas versiones de Trekbuddy soportan que dentro de la carpeta WPTS haya otras de forma que podemos tener las rutas mucho mejor organizadas

 [1]: http://earth.google.es/download-earth.html
 [2]: http://bbs.keyhole.com/ubb/download.php?Number=101188
 [3]: http://www.winrar.es/
 [4]: http://machacaminos.blogspot.com/