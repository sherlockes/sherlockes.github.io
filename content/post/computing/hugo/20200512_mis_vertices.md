---
title: "Mis vértices geodésicos en Hugo"
date: "2021-03-01"
creation: "2020-05-12"
description: "Todo lo que he tenido que aprender para poder incrustar de una forma sencilla, ágil y digna mis vértices en Hugo"
thumbnail: "images/20200512_mis_vertices_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
  - "hugo"
  - "vertices"
tags:
  - "shortcodes"
draft: false
weight: 5
---
Hace más de dos años desde que visité mi ultimo vértice geodésico. Durante todo este tiempo el proyecto que empecé en el ya lejano 2008 lo he tenido aparcado por unos cuantos motivos...
<!--more-->
- Cierre de Panoramio (Donde tenía todas las fotos y panorámicas)
- Abandono de Wordpress (En [Hugo] no es todo tan sencillo)
- Necesidad de pago en la API de Google Maps
- Falta de tiempo

Pues bien, al fin me he liado la manta a la cabeza y he conseguido sacar el tiempo suficiente para conseguir una solución digna al problema del archivo y representación de todos los vértices geodésicos a los que, hasta ahora, he conseguido llegar.

### Creación de una plantilla
La documentación de [Hugo] aunque es bastante extensa, en algunas ocasiones resulta complicada de seguir. Pretendo crear una plantilla común para los vértices geodésicos en los que únicamente cambien una serie de parámetros propios de cada vértice y un pequeño artículo del mismo. De esta forma, las imágenes y mapas de cada uno de los post se generarán automáticamente resultando muy sencillo así realizar una modificación común a todos.

En la cabecera de cada archivo *.md con en que se genera el post del vértice he incluido, además de los parámetros propios del tema otros propios del vértice.

```
js: https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.3.1/build/ol.js
css: https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.3.1/css/ol.css

mapa_alto: 400

vertice_nom: "Picones"
vertice_loc: "Velilla de Ebro"
vertice_lon: "-0.3656885"
vertice_lat: "41.3790035"
vertice_alt: "354"
vertice_hoja: "0413"
vertice_id: "42"
vertice_img: "tZbCy46"
vertice_pan: "VY8ieZb"

```
Las dos primeras líneas corresponden a una hoja de estilos y una clase javascript que utilizaré para la creación del mapa, la tercera hace referencia al número de pixeles que de alto va a ocupar el mapa en el post que se genere. El resto hacen referencia a valores del vértice como el nombre, la localización, las coordenadas, la altitud, la clasificación del ign y las imágenes del vértice.

Con esto tengo material suficiente para crear un [shortcode] en forma de archivo "mapa_vertice.html" que será guardado dentro de la carpeta "/layouts/shortcodes" (No la de dentro del tema sin en el directorio raiz y que deberemos crear si no existe)

El archivo [mapa_vertice.html] de momento no voy a explicarlo aquí con todos los detalles ya que puedes verlo en mi [repositorio] de GitHub. La finalidad es que incluyendo en el post del vértice

```
{{ mapa_ vertice }}
```
ya se genere todo el contenido de forma automática atendiendo a los parámetros del post.

### Creación del archivo gpx
Para representar los vértices en el mapa necesito un archivo en el que estén incluidas las coordenadas y el nombre del mismo. El formato libre más extendido para esto es gpx de forma que el archivo deberá quedar algo como lo siguiente:

```
<?xml version="1.0"?>
<gpx creator="GPS Visualizer http://www.gpsvisualizer.com/" version="1.1" xmlns="http://www.topografix.com/GPX/1/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">
<wpt lat="xxxx" lon="xxxx">
<name>nombre</name>
</wpt>
</gpx>
```
Cada nodo "wpt" (waypoint) representará un vértice y sóloes cuestión de incluir tantos como sean necesarios. Anteriormente ya tenía creado un archivo similar a este pero en el formatio propietariode Google kml y la experiencia me dice que, aunque no es complicada la realización si resulta tedioso tener que volver a información del v��rtice en un nuevo archivo.

Por lo anterior he creado un script en bash que extrae la información de todos los archivos en la carpeta "vértices" y genera el archivo gpx.

```
# Cabecera genérica de los archivos gpx
cabecera='<?xml version="1.0"?>
<gpx creator="GPS Visualizer http://www.gpsvisualizer.com/" version="1.1" xmlns="http://www.topografix.com/GPX/1/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">'

# Ruta donde se va a guardar el archivo generado
vertices_gpx='/home/pi/sherblog/static/gpx/mis_vertices.gpx'

# Borra el archivo si ya existe
rm $vertices_gpx

# Incluye la cabecera en el nuevo archivo
echo "$cabecera" >> $vertices_gpx

# Cambia al directorio en el que están los archivos con los vértices
cd /home/pi/sherblog/content/vertices/

# Busca en todos los archivos *.md del directorio
for I in `ls *.md`
do
    # Extraemos el nombre del archivo sin extensión
    nombre=$(echo "$I" | cut -f 1 -d '.')
    # Extraemos el valor de latitud y longitud borrando el espacio inicial
    vertice_lon=$(grep "vertice_lon" $I | cut -f 2 -d ':' | cut -c2-)
    vertice_lat=$(grep "vertice_lat" $I | cut -f 2 -d ':' | cut -c2-)
    # Generamos el nodo para el waypoint
    echo '<wpt lat='$vertice_lat' lon='$vertice_lon'>' >> $vertices_gpx
    echo '<name>'$nombre'</name>' >> $vertices_gpx
    echo '</wpt>' >> $vertices_gpx
done

# Incluye el cierre de la cabecera gpx
echo '</gpx>' >> $vertices_gpx
```

Este código se ejecutará cada vez que se realiza una publicación de la web de forma que si hemos añadido o modificado algún vértice el archivo "[mis_vertices.gpx]" se actualizará automáticamente.

### Creación de una imagen para el vértice
Para este apartado también he intentado ir un paso más alla en cuanto a la imagen que representará al vértice en el mapa. En lugar de una imagen en mapa de bits voy a utilizar un formato vectorial svg reducido a su mínima expresión en sólo unas de líneas de código.

```
<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="25px" height="35px" xml:space="preserve">'+    
'<path fill="white" stroke="black" d="M 10 0 l 0 15 l -10 0 l 0 20 l 25 0 l 0 -20 l -10 0 l 0 -15 z"/>'+'</svg>'
```

La sencilla forma del vértice nos permite realizar esta "virguería" que representada en el mapa quedará tal que esto

![image-01]

Imposible realizar algo más práctico y ligero ya que quedará integrado dentro del "shortcode" "[mapa_vertice.html]" para la representación gráfica de cada uno de los vértices geodésicos.


### Listado de los vértices conquistados
La opción más sencilla es la realización de un post que actualice cada vez que se incluye un nuevo vértice con un enlace al mismo. Pero no me quiero quedar aquí, quiero algo que busque todos los artículos dentro de la carpeta "vertices" de la web y genere un listado con un enlace a cada uno de ellos. En Wordpress no me resultó tan complicado encontrarlo, en hugo he tenido unos días de dolor de cabeza hasta dar con una brillante solución haciendo uso de [shortcodes] en [Hugo]

He creado el archivo "lista_vertices.html" que contiene estas líneas de código.

```
{{ $vertices := (where .Site.RegularPages "Section" "==" "vertices") }}
{{ range $vertices }}
<li><a href="{{.Permalink}}">{{.Params.vertice_nom}} ({{.Params.creation}})</a>

{{ if .Params.vertice_img }}
 - <a href="https://i.imgur.com/{{.Params.vertice_img}}.jpg" target="_blank">Foto</a>
{{ end }}

{{ if .Params.vertice_pan }}
 - <a href="https://i.imgur.com/{{.Params.vertice_pan}}.jpg" target="_blank">Pano</a>
{{ end }}

{{ if .Params.vertice_gps_gar }}
 - <a href="http://connect.garmin.com/modern/activity/{{.Params.vertice_gps_gar}}" target="_blank">Ruta</a>
{{ end }}

{{ if .Params.vertice_gps_wik }}
 - <a href="http://es.wikiloc.com/wikiloc/view.do?id={{.Params.vertice_gps_wik}}" target="_blank">Ruta</a>
{{ end }}
  
<br>
  
</li>
{{ end }}
<br>
```

De esta forma tan simple el script:
- Busca todos archiculos dentro de la carpeta "vértices"
- Genera un enlace con el nombre del vértice y la "fecha de conquista"
- Si el vértice tiene imagen, genera un enlace a la imagen
- Si el vértice tiene foto panorámica, genera un enlace a la misma
- Si tiene un track en garmin connect o wikiloc, genera un enlace

Así tenemos un listado con una línea por cada uno de los vértices que podremos incluir en cualquier artículo de la web con únicamente escribir

```
{{ lista_vertices }}
```

### Representación en un mapa
Para dibujar sobre un mapa todos los vértices alcanzados e incurstarlos en la web he utilizado [openlayers] por ser de código abierto y de ua complejidad de uso asequible para mi escaso nivel de Javascript.

Para poder trabajar con la librería [openlayers] he introducido dos parámetros de configuración en el artículo correspondiente a cada vértice.

```
js: https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.3.1/build/ol.js
css: https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.3.1/css/ol.css
```

Con el fin de incluir de forma dinámica la clase y hora de estilos de la librería sin necesidad de tenerla incrustada en el servidor. Además, he modificado la plantilla "layouts/default/baseof.html" incluyendo el siguiente código en la parte final del "head".

```
{{ if .Params.css }}
	<link rel="stylesheet" href="{{ .Params.css }}">
	<style>
	  .map {
          height: {{ .Page.Params.mapa_alto }}px;
          width: 100%;
	  }
	</style>
	{{ end }}
	{{ if .Params.js }} <script src="{{ .Params.js }}"></script> {{ end }}
```

De esta manera, cuando el motor de [Hugo] vaya a publicar un artículo incrustará tambien la clase y hoja de estilos de openlayers sólo si estos están incluidos dentro de los parámetros "js" y "css" (con el consiguiente ahorro de ancho de banda). Adicionalmente ajustará el mapa a mostrar a todo el ancho de la web y al alto que se incluya como parámetro en cada artículo particular.

Nuevamente haré uso de los [shortcodes] de [Hugo] para crear el archivo [mapa_vertice.html] con lo que la incusión de un mapa con la información del vértice geodésico en un artículo se realizará con la siguiente línea.

```
{{ mapa_vertice }}
```
Puedes encontrar todo el código en mi [repositorio] de GitHub.

### Almacenamiento de las imágenes
Este punto también ha resultado un profundo dolor de cabeza. Hasta su cierre tenía publicadas todas las imágenes y panorámicas en Panoramio. Las sigo teniendo en Google Photos pero no he sido capaz de incrustarlas en el blog desde aquí por lo que me he visto obligado a buscar un nuevo alojamiento para todas estas imágenes.
- *Usar Github como alojamiento* - Aunque factible, presenta una limitación por el tamaño máximo del repositorio a 1 gb por lo que queda descartada la opción.
- *Usar Internet Archive como alojamiento* - Lo intenté, pero el modo de subir las fotografías, gestionarlas y organizarlas es simplemente pésimo por lo que termine desestimando está opción.
- *Usar Imgur como alojamiento* - Después de comprobar en funcionamiento y capacidad de varios servicios web he probado por escoger está opción. El espacio de almacenamiento es ilimitado con el límite de 20mb por fotografía y 50 fotografías por hora lo cual es más que suficiente para mis necesidades.


[Hugo]: https://gohugo.io/
[mapa_vertice.html]: https://github.com/sherlockes/SherloScripts/blob/master/hugo/shortcodes/mapa_vertice.html
[mis_vertices.gpx]: /gpx/mis_vertices.gpx
[openlayers]: https://openlayers.org
[repositorio]: https://github.com/sherlockes/SherloScripts
[shortcodes]: https://gohugo.io/content-management/shortcodes/
[mapa_vertice.html]: https://github.com/sherlockes/SherloScripts/blob/master/hugo/shortcodes/mapa_vertice.html

[image-01]: /images/20200512_mis_vertices_01.jpg
