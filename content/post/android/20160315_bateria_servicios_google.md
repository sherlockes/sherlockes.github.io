---
title: "Excesivo gasto de batería de los Servicios de Google Play"
date: "2016-03-15"
description: "Las cosas de Android, tiras una moneda al aire, unas veces triunfas y otras te quedas con un bonito pisapapeles.  Hoy he triunfado"
thumbnail: "images/20160315_slimsaber.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Android"
tags:
  - "Bricolaje"
draft: false
weight: 5
---
### El Problema
Desde hace varios años tengo como teléfono un Samsung Galaxy S2, últimamente un i9100 liberado de Orange y anteriormente un shv-e120s libre comprado a los chinos. En los últimos días he tenido serios problemas de batería con el i9100 corriendo la versión de Cyanogen CM11.

Desde los ajuste de la batería veo a los "Servicios de Google Play" con un consumo desorbitado por encima del resto que hace que tenga que cargar el teléfono dos veces al días sin apenas utilizarlo. Hay cientos de articulos por la red haciendo referencia a este problema pero ninguno de ellos consigue darme la solución al problema.

A partir de aquí realizo la siguiente secuencia de comprobaciones y sucesos para dar solución al problema.

1. Comprobar los "Wakelocks" que mantienen el teléfono despierto en todo momento. Las aplicaciones gratuitas que he usado no me han dado ningún resultado.

2. Modificar los ajustes de privacidad de Cyanogen para que los servicios de google no sean capaces de despertar ni mantener despierto el dispositivo. Con esto sólo consigo problemas de estabilidad en el teléfono y ningún resultado en el gasto de batería.

3. Usando la aplicación "Cpu Spy" hago un gran avance y me doy cuenta de que el problema principal reside en que el teléfono no entra nunca en el modo "Deep Sleep" y se mantiene a la frecuencia mínima de 200Mhz provocando así un gasto innecesario de batería cuando no es necesario el procesador.

4. Instalo la aplicación "Deep Sleep Battery Saver Pro" ya que dice servir para poner el teléfono en el modo de sueño profundo de acuerdo a los ajustes que pongas en la aplicación. Tras la instalación y ajustar la aplicación, el teléfono comienza a entrar en el modo de sueño profundo, pero es simplemente es un espejismo, ya que al día siguiente y después de un reinicio deja de hacerlo.

5. Pruebo varias aplicaciones de ahorro de energía que no merece la pena ni nombrar ya que con ninguna de ellas consigo ningún resultado.

6. LLegados a este punto me veo obligado a realizar alguna acción más drástica y realizo una restauración del teléfono a los valores de fábrica. En un primer momento la solución parece ser la buena, pero apenas unas horas después me doy cuenta de que el teléfono vuelve a las andadas por lo que no he conseguido tampoco nada.

7. Buscando un poco por la red doy con una versión de Cyanogen para el Samsung Galaxy S2 i9100 basada en Android Lollipop 5.1.1. Se trata de la CM 12.1 y como durante más de un año he estado encantado con la CM 11 por lo que me parece una buena alternativa y me dispongo a instalarla.

La descargo desde el propio teléfono y la "flasheo" a través del "recovery" de Cyanogen. En apenas unos minutos y de una sencilla manera consigo tener instalada la última versión de android en un smartphone del que casi han pasado casi 5 años desde su lanzamiento. La instalación de Android ha sido un éxito, pero me encuentro con el problema de que no tengo las "google apps". Ni la versión que recomienda Cyanogen ni otras alternativas que he visto por la red han funcionado. Hoy por hoy no soy capaz de llevar un teléfono Android sin "Play Store", "Youtube", "Gmail", "Google Chrome" ni mi agenda de contactos por lo que sigo en la búsqueda por una solución.

8. Bueno, pues si la 5.1.1 no funciona me tendré que conformar con la 4.4.4 que hasta ahora había tenido instalada, es decir, la misma CM 11 que ya llevaba. No dispongo de la imagen de CM 11 para flashear por que, si mal no recuerdo, la instalé desde la app CM Installer. No me cuesta mucho encontrarla, la "flasheo" a través del "recovery" pero me encuentro con el mismo problema de las "Google Apps" que había tenido con CM 12.1.

Quizás en este momento tenía que haber intentado instalar CM 11 de la misma forma que lo hice hace un año pero sin la "Play Store" en el teléfono no es tan fácil instalar la app "CM Installer" por lo que me salto este paso.

9. Llegados a este punto dejo de lado Cyanogen para optar por la última distribución que Samsung liberó como "firmware" oficial. Cual es mi sorpresa cuando veo que desde la web de las descargas Samsung el archivo para descargar está alojado en un servidor externo del que ha sido borrado. Fracaso del camino legal.

10. Busco otra distribución basada en Android 4.4.4. Por suerte, a pesar se ser el Samsung Galaxy S2 modelo i9100 un terminal bastante antiguo todavía hay mucha gente que lo utiliza y no es dificil encontar "firmwares" alternativos al oficial.

No tardo mucho en dar con [SlimSaber][1], una fusión que promete la ligereza y ahorro de bateria de las SlimRoms y la versatilidad y estabilidad de Cyanogen. Siguiendo las instrucciones del creador de la Rom apenas tardo unos minutos en "flashear" los archivos necesarios y tener nuevamente el teléfono operativo.

![imagen][4]

Está claro que si manejas un terminal de casi cinco años no buscas en el un rendimiento espectacular ni unos grandes efectos visuales. Simplemente una buena estabilidad y un gasto de batería decente es lo que pretende conseguir [FusionJack][5] con la creación de [SlimSaber][1], combinando en esta Rom la ligereza de [SlimRom][2] y algunas de las buenas características de [Cyanogen][3].

Todo un éxito, los dos días de continuo trasteo con el teléfono han merecido la pena, mi arcaico S2 funciona como la seda¡¡¡

 [1]: http://forum.xda-developers.com/galaxy-s2/development-derivatives/rom-slimsaber-i9100-t2350201
 [2]: http://slimroms.net
 [3]: http://www.cyanogenmod.org/
 [4]: /images/20160315_slimsaber.jpg
 [5]: https://www.androidfilehost.com/?w=profile&uid=9390169635556425739