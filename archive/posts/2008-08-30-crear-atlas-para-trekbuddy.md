---
title: Crear Atlas para Trekbuddy
author: Sherlockes
type: post
date: 2008-08-30T10:58:50+00:00
url: /?p=161
categories:
  - Software
  - Trekbuddy
tags:
  - mapas
  - software
  - trekbuddy

---
Ahora que ya sabemos como crear mapas para Trekbuddy desde [YahooMaps, GoogleMaps][1] o [Sigpac][2] vamos a dar un paso más creando un Atlas que cubra una determinada zona con varios niveles de zoom. Existen algunos programas que realizan de forma automática esta función pero de los que he probado, ninguno me ha sorprendido gratamente por lo que me quedo con el método manual.

Para empezar, crearemos una carpeta en la que guardaremos el atlas, dentro de esta con el bloc de notas crearemos un archivo "atlas.tba" cuyo contenido sera únicamente "Atlas 1.0". Dentro de esta carpeta crearemos otras tantas como niveles de zoom queramos guardar. En mi caso para hacer senderismo y BTT con tres niveles de zoom es suficiente aunque si lo quieres para callejear necesitarás algo más. Con esto, creamos un mapa para cada nivel de zoom y lo guardamos cada una de las carpetas anteriormente creadas. Si la zona escogida es muy extensa, es posible que no seamos capaces de crear un mapa tan grande para las resoluciones más altas, en este caso nos dividiremos la zona en varios cuadrantes y crearemos un mapa para cuadrante que ubicaremos dentro de la carpeta de zoom correspondiente con un nombre que sea un poco representativo (p.e. "mapa 0,0") para hacernos la labor más fácil.

<center>
  <img src="sherblog/wp-content/uploads/images/20080830_atlas_trekbuddy_1.jpg" alt="" />
</center>

La estructura del atlas quedará algo parecido a esto y para navegar en el únicamente nos hará falta la tecla "7" del teléfono para cambiar el nivel de zoom una vez que hayamos cargado el atlas y seleccionado la capa y mapa que deseemos. Cuando lleguemos al extremo de un mapa el propio Trekbuddy de forma automática buscará dentro de la misma capa (La carpeta del zoom correspondiente) otro mapa la zona a la que vamos a entrar.

En el caso de que la zona a guardar no se muy extensa tenemos una alternativa de estructura para el atlas en la que como capas pondremos por un lado las imágenes del satélite y por otro el mapa y como mapas los distintos niveles de zoom tal y como se puede ver en el siguiente esquema.

<center>
  <img src="sherblog/wp-content/uploads/images/20080830_atlas_trekbuddy_2.jpg" alt="" />
</center>

Ahora la tecla "7" la utilizaremos para cambiar entre el mapa y las imágenes reales y la tecla "9" para movernos entre los distintos niveles de zoom.

No se si la cosa ha quedado muy clara ya que es algo un poco raro de explicar pero si alguien tiene alguna duda dejad un comentario e intentaré resolverla.

 [1]: http://sherver.homeip.net/blog/?p=45
 [2]: http://sherver.homeip.net/blog/?p=138