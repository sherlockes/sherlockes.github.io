---
title: Crear mapas de Sigpac para TrekBuddy.
author: Sherlockes
type: post
date: 2008-08-25T14:36:22+00:00
url: /?p=138
mytory_md_visits_count:
  - 1
categories:
  - Software
  - Trekbuddy
tags:
  - mapas
  - software
  - trekbuddy

---
En un [post anterior][1] vimos como crear mapas para trekbuddy mediante [GoogleAK][2]. Los mapas de google y yahoo están muy bien cuando queremos orientarnos por carreteras, pueblos o ciudades pero pierden bastante efectividad cuando nos salimos de estas vías principales y empezamos a rodar por caminos secundarios sin asfaltar. Ademas, las imágenes del satélite quedan muy bonitas en nuestra lcd de 21 pulgadas pero son muy difíciles de interpretar sobre la minúscula pantalla del movil con el sol de cara y montado en la bicicleta. Para España contamos con una buena alternativa en el [visor del Sigpac][3], una utilidad que fue concebida para la identificación de la parcelación agraria pero que vamos a ver como puede servir para algo más. La representación topográfica de los mapas del Sigpac es realmente excelente como se puede ver en la siguiente imagen.

<center>
  <img src="sherblog/wp-content/uploads/images/20080825_sigpac.jpg" alt="" />
</center>

Ahora ya sólo resta encontrar el método para pasar estos mapas al teléfono. Gracias a JRariasf tenemos la utilidad [JSigpac][4] que aunque en apariencia es un poco tosca hace realmente bien todo lo que necesitamos para la creación de mapas. Ahora seguiremos los siguientes pasos:
  
1.- [Instalar][5] "Java runtime enviroment" (Es probable que ya lo tengamos)
  
2.- [Descargar][6] la última versión de JSigpac.
  
3.- [Descargar][7] "milib_jai.dll" (Un poco más abajo que la descarga del programa)
  
4.- Descomprimir "jsigpac.exe" y "milib_jai.dll" en una misma carpeta
  
5.- Configurar la variable de entorno según [estas][8] instrucciones
  
6.- Reiniciar el pc
  
7.- Ejecutar "jsigpac.exe"

_**Modificación:** Parece que el enlace a las instrucciones ahora no funciona, para añadir la variable "JSigpac" al sistema simplemente hay que hacer lo siguiente.
  
1.- Inicio &#8211; Configuración &#8211; Panel de control
  
2.- Apartado "Sistema"
  
3.- Pestaña "opciones avanzadas" y haz click en "Variables de entorno"
  
4.- En la zona de "variables de sistema" click en "Nueva"
  
5.- Como nombre "JSIGPAC_MEM" y como valor "-Xmx1600m" (Sin las comillas)
  
6.- Aceptar y reiniciar_

_En lugar de 1600 se puede poner otra cifra pero hay que tener en cuenta que si lo ponemos muy pequeño no podremos hacer mapas grandes y si lo ponemos muy grande nos aparecerá un error de ejecución de java. En mi pc de 2Gb de RAM 1600 es el valor más alto que acepta._

Si todo ha ido correctamente podrás ver algo parecido a lo siguiente.

<center>
  <img src="sherblog/wp-content/uploads/images/20080825_jsigpac.jpg" alt="" />
</center>

Antes de seguir, un par de aclaraciones. Si no copias el archivo "milib_jai.dll" la aplicación funcionara igualmente solo que a la hora de fusionar las imágenes la espera se te hará eterna. Respecto al número que hay que poner en la variable de entorno, en mi pc con 2gb de RAM le he puesto 1600 (con valores superiores empieza a dar errores de java) lo que me permite hacer mapas de hasta 55&#215;55 cuadros.

Ya estamos en condiciones de empezar con nuestro primer mapa para lo que necesitamos las coordenadas del centro del mismo que obtendremos del visor de la web del Sigpac.

<center>
  <img src="sherblog/wp-content/uploads/images/20080825_sigpac_2.jpg" alt="" />
</center>

Con todo esto, abriremos nuevamente "Jsigpac.exe" para realizar los siguientes pasos según lo mostrado en este vídeo (Si no ves los subtítulos pincha en el botón negro con los tres guiones que hay junto a la barra de reproducción).

<center>
  <embed id="VideoPlayback" src="http://video.google.com/googleplayer.swf?docid=-6881414424012883394&hl=es&fs=true" style="width:400px;height:326px" allowFullScreen="true" allowScriptAccess="always" type="application/x-shockwave-flash">
  </embed>
  
  <br />
</center>

Hasta aquí tenemos un archivo jpg con varios archivos de calibración (Es posible que JSigpac no haya borrado todos los archivos jpg pequeños que forman el mosaico por lo que también los tendrás) pero esto no es suficiente para que lo interprete Trekbuddy por lo que nos hace falta otro programa. [TB_Cutter][9] es una aplicación muy simple cuya única misión es crear un mapa apto para Trekbuddy a partir de una imagen y de un fichero de calibración. Lo descargamos, lo descomprimimos y lo ejecutamos para ver lo siguiente.

<center>
  <img src="sherblog/wp-content/uploads/images/20080825_tbcutter.jpg" alt="" />
</center>

Su utilización es tan simple como seleccionar la imagen que ha creado JSigpac como "Source Bitmap", el correspondiente archivo de calibración como "Calibration file" y el directorio donde queremos guardar el mapa como "Output path", pinchamos en "Start" y esperar.
  
Copiamos la carpeta que crea la aplicación a la ubicación de la tarjeta de memoria del teléfono donde tenemos guardados el resto de los mapas para el Trekbuddy.
  
De momento tenemos creado un mapa, en otro post veremos como crear un atlas completo para una zona más extensa con varios niveles de zoom.

 [1]: http://sherver.homeip.net/blog/?p=45
 [2]: http://www.linuxtechs.net/kruch/tb/forum/viewtopic.php?t=833
 [3]: http://sigpac.mapa.es/fega/visor/
 [4]: http://www32.websamba.com/jrariasf/jSIGPAC/sigpac.html
 [5]: http://www.java.com/es/
 [6]: http://fundacionjsigpac.blogspot.com/
 [7]: http://www.upshare.eu/?d=2ADC63C711
 [8]: http://www.myjavaserver.com/~jrariasf/sigpac/classpath.html#JSIGPAC_MEM
 [9]: http://linuxtechs.net/kruch/tb/forum/viewtopic.php?t=170