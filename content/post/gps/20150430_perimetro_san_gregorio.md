---
title: "Perímetro CENAD del BOE a gpx"
date: "2015-04-30"
creation: "2015-04-30"
description: "Que manera de perder la mañana para convertir la información del BOE en algo legible por Google Earth para delimitar el campo de maniobras de San Gregorio"
thumbnail: "images/20150427_cenad_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "GPS"
draft: false
weight: 5
---
Todos los que circulen por la zona de Zaragoza con la bicicleta de montaña serán conocedores de que justo al norte de la capital aragonesa se encuentra situado el [Centro de Adiestramiento "San Gregorio" CENAD][11] también conocido como "Campo de maniobras" donde los militares hacen sus entrenamientos poniéndose más o menos pesados al invadir su intimidad.

Pues bien, antes de planificar una ruta en btt por la zona he intentado buscar en la web el perímetro que delimita este campo de maniobras para invadirlo lo menos posible y cual ha sido mi sorpresa al ver que hay muy poca información al respecto y la que hay es poco concreta o anticuada como [esta][12] o incluso errónea como [esta][13] otra.

Sigo buscando un rato más y al fin encuentro algo veraz y actualizado en el BOE (De casualidad y gracias a San Google) aunque cierto es que a priori un poco complicado de interpretar. El resultado de mi búsqueda es un archivo [pdf][14] del 5 de Julio de 2014 en el que se delimita el perímetro de la propiedad denominada Campo de Tiro y de Maniobras de San Gregorio en Zaragoza.

Para la planificación de mis rutas utiliza habitualmente [Google Earth][15] y por desgracia, sus programadores, no lo han dotado de la capacidad para abrir archivos del BOE por lo que me armo de paciencia para intentar convertir el texto del boletín oficial del estado en un archivo gpx con xml estructurado que pueda leer el programa. Además, para hacerlo un poco más divertido me comprometo ha hacerlo con herramientas gratuitas y libres a la mano de cualquiera.

Y aquí está el punto de partida de mi reto, una tabla con valores de coordenadas UTM Huso30 WGS 84 insertada dentro de un archivo pdf que tendré que convertir en un archivo gpx con coordenadas geodésicas.

![imagen][1]

Por suerte los editores del BOE tienen un poco de dignidad y hacen un documento en el que es posible seleccionar el texto para hacer un archivo *.txt fácilmente editable como el siguiente.

```
cve: BOE-A-2014-7081
BOLETÍN OFICIAL DEL ESTADO
Núm. 163  Sábado 5 de julio de 2014  Sec. III. Pág. 52798
Denominación punto X Y
Z047 675090,569 4627665,073
Z048 675137,937 4627826,621
Z049 675166,609 4627975,314
Z050 675184,113 4628119,577
Z051 675197,651 4628241,553
Z052 675152,768 4628438,348
Z053 675129,485 4628563,702
Z054 675111,51 4628721,206
Z055 675103,764 4628841,755
Z056 675102,69 4628993,574
Z057 675100,048 4629067,546
```

Para la edición de texto utilizo [Notepad++][16]. Quitamos las líneas de texto que no corresponden a valores de coordenadas y cambiamos los espacios por asteriscos para poder importar el archivo a una hoja de cálculo

```
Z047*675090,569*4627665,073
Z048*675137,937*4627826,621
Z049*675166,609*4627975,314
Z050*675184,113*4628119,577
Z051*675197,651*4628241,553
Z052*675152,768*4628438,348
Z053*675129,485*4628563,702
Z054*675111,51*4628721,206
Z055*675103,764*4628841,755
Z056*675102,69*4628993,574
Z057*675100,048*4629067,546
```

Este archivo ya es fácilmente importable por cualquier editor de hojas de cálculo, en mi caso he utilizado [google drive][17] para crear la siguiente hoja, a la que le añado tres columnas. Una con "0" para que no se atragante en conversor, una con un "30" correspondiente al huso horario y otra con un "1" por tratarse del hemisferio norte.

![imagen][2]

Con todo lo anterior, ya podemos exportar nuestra hoja de cálculo a un archivo de texto *.tsv en el que los valores de las distintas coordenadas están separados por tabulaciones.

```
Z049    675166,609  4627975,314 0   30  1
Z050    675184,113  4628119,577 0   30  1
Z051    675197,651  4628241,553 0   30  1
Z052    675152,768  4628438,348 0   30  1
Z053    675129,485  4628563,702 0   30  1
Z054    675111,51   4628721,206 0   30  1
Z055    675103,764  4628841,755 0   30  1
Z056    675102,69   4628993,574 0   30  1
Z057    675100,048  4629067,546 0   30  1
Z058    675077,706  4629263,552 0   30  1
Z059    675058,658  4629322,642 0   30  1
```

Después de todo este acondicionamiento, ya estamos listos para convertir las coordenadas UTM a geodésicas para lo que utilizo una simple [calculadora][18] "Made in Spain" creada por [Eduardo Núnez Maderal][19].

![imagen][3]

Tras un rato luchando con el conversor por que se quedaba colgado a mitad de la conversión, me doy cuenta de que hasta los del BOE se equivocan ya que se han olvidado de colocar las separaciones decimales de varias coordenadas como se puede ver a continuación.

![imagen][4]

Y solventados estos errores que me han hecho perder algún tiempo ya tenemos un archivo de texto con las coordenadas geodésicas.

```
Nº  |   Long(ºsexag.)   |   Lat(ºsexag.)| altitud (h) 
---------------------------------------------------------
 Z047    -0.89307542        +41.78152426        49.8381
 Z048    -0.89245817        +41.78296789        49.8401
 Z049    -0.89206951        +41.78429993        49.8417
 Z050    -0.89181645        +41.78559456        49.8432
 Z051    -0.89161765        +41.78668946        49.8444
 Z052    -0.89209939        +41.78847070        49.8455
 Z053    -0.89234243        +41.78960414        49.8463
 Z054    -0.89251216        +41.79102579        49.8528
 Z055    -0.89256977        +41.79211255        49.8540
 Z056    -0.89253791        +41.79347929        49.8556
 Z057    -0.89254787        +41.79414569        49.8563
```

Limpiamos el texto sobrante para dejar sólo las coordenadas, convertimos el doble espaciado en simple recursivamente y los resultantes los sustituimos por * para una fácil importación por la hoja de cálculo. El resultado queda como el siguiente.

```*Z047*-0.89307542*+41.78152426*49.8381
*Z048*-0.89245817*+41.78296789*49.8401
*Z049*-0.89206951*+41.78429993*49.8417
*Z050*-0.89181645*+41.78559456*49.8432
*Z051*-0.89161765*+41.78668946*49.8444
*Z052*-0.89209939*+41.78847070*49.8455
*Z053*-0.89234243*+41.78960414*49.8463
*Z054*-0.89251216*+41.79102579*49.8528
*Z055*-0.89256977*+41.79211255*49.8540
*Z056*-0.89253791*+41.79347929*49.8556
*Z057*-0.89254787*+41.79414569*49.8563
```

Lo convertimos en hoja de cálculo y añadimos columnas con la estructura propia de los archivos gpx

![imagen][5]

Exportamos a un archivo separado por tabulaciones

```
&lt;trkpt lat="    +41.73072960    " lon=" -0,85392959 "/>
&lt;trkpt lat="    +41.73188476    " lon=" -0,85490983 "/>
&lt;trkpt lat="    +41.73339488    " lon=" -0,85573529 "/>
&lt;trkpt lat="    +41.73475548    " lon=" -0,85634502 "/>
&lt;trkpt lat="    +41.73604644    " lon=" -0,85684217 "/>
&lt;trkpt lat="    +41.73736603    " lon=" -0,85771758 "/>
&lt;trkpt lat="    +41.73857892    " lon=" -0,85869591 "/>
&lt;trkpt lat="    +41.73992066    " lon=" -0,85948338 "/>
&lt;trkpt lat="    +41.74134432    " lon=" -0,85993705 "/>
&lt;trkpt lat="    +41.74289547    " lon=" -0,86025098 "/>
```

Eliminamos las tabulaciones, añadimos el encabezado del archivo gpx y el del track y así queda el resultado.

```
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
&lt;gpx version="1.1" creator="Sherlockes http://www.sherblog.es" 
xmlns="http://www.topografix.com/GPX/1/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">
    &lt;trk>
      &lt;name>Perimetro San Gregorio&lt;/name>
        &lt;trkseg>
            &lt;trkpt lat="+41.73072960" lon="-0.85392959"/>
            &lt;trkpt lat="+41.73188476" lon="-0.85490983"/>
            &lt;trkpt lat="+41.73339488" lon="-0.85573529"/>
            &lt;trkpt lat="+41.73475548" lon="-0.85634502"/>
            &lt;trkpt lat="+41.73604644" lon="-0.85684217"/>
            &lt;trkpt lat="+41.73736603" lon="-0.85771758"/>
            &lt;trkpt lat="+41.73857892" lon="-0.85869591"/>
            &lt;trkpt lat="+41.73992066" lon="-0.85948338"/>
            &lt;trkpt lat="+41.74134432" lon="-0.85993705"/>
            &lt;trkpt lat="+41.74289547" lon="-0.86025098"/>
        &lt;/trkseg>
    &lt;/trk>
&lt;/gpx>
```

Sobre google earth, este es el resultado

![imagen][6]

[Descargar el archivo formato gpx][20]

[Descargar el archivo formato Google Earth][21]

[1]: /images/20150427_cenad_01.jpg
[2]: /images/20150427_cenad_02.jpg
[3]: /images/20150427_cenad_03.jpg
[4]: /images/20150427_cenad_04.jpg
[5]: /images/20150427_cenad_05.jpg
[6]: /images/20150427_cenad_05.jpg

[11]: http://www.ejercito.mde.es/unidades/Zaragoza/cenad_san_gregorio/
[12]: http://www.aragondigital.es/noticia.asp?notid=52971&secid=9
[13]: https://www.google.com/maps/d/viewer?oe=UTF8&t=h&ie=UTF8&msa=0&mid=zqEb_NDewauk.k2Ikn_Gmtsb0
[14]: http://www.boe.es/boe/dias/2014/07/05/pdfs/BOE-A-2014-7081.pdf
[15]: https://www.google.es/intl/es/earth/index.html
[16]: http://notepad-plus-plus.org
[17]: https://www.google.com/intl/es_es/drive/
[18]: http://enmaderal.jimdo.com/descargas/calculadora-utm/
[19]: http://enmaderal.jimdo.com
[20]: /files/perimetro_cenad_san_gregorio.gpx
[21]: /files/perimetro_cenad_san_gregorio.kml