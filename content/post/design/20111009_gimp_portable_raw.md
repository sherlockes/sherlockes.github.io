---
title: "Abrir archivos RAW con Gimp Portable"
date: "2011-10-09"
description: "Abrir archivos RAW con Gimp Portable"
thumbnail: "images/20111009_gimp.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "diseño"
tags:
  - "Gimp"
draft: false
weight: 5
---
Cada vez son más las cámaras fotográficas capaces de guardar las instantáneas en formato [Raw][1]. No voy a analizar todas las ventajas e inconvenientes de guardar la información de esta manera aunque hay que tener claro que la principal razón para usarla es que no existe pérdida de datos por el procesado interno de la cámara.

[Gimp][2] no es capaz de forma nativa de manejar este formato por lo que será necesaria la ayuda de [Ufraw][3], también gratuito y de libre distribución como Gimp, para abrir este tipo de archivos.

Para Windows y con una instalación convencional, el asunto es bastante simple, descargas e instalas la [última versión][4] de Gimp y posteriormente descargas e instalas la [última versión][5] de Ufraw sobre el mismo directorio que está instalado Gimp. Es fácil si sigues el orden, de todos modos, si tienes algún problema, [aquí][6] están las instrucciones detalladas.

En caso de que (Como yo) trabajes con una distribución de [Gimp Portable][7], debes instalar únicamente Ufraw donde quieras para después entrar en el directorio de instalación y copiar el contenido de las tres carpetas dentro de las correspondientes de la distribución portátil de Gimp sobrescribiendo los archivos ya existentes.

![imagen][8]

Realizada la copia ya puedes desinstalar Ufraw de tu Pc. Si no ha fallado nada, ya estás en condiciones de abrir los archivos Raw desde la distribución portátil de Gimp, cuando lo hagas verás una interface como la siguiente.

![imagen][9]

 [1]: http://es.wikipedia.org/wiki/RAW_(formato)
 [2]: http://www.gimp.org/
 [3]: http://ufraw.sourceforge.net/
 [4]: http://gimp-win.sourceforge.net/stable.html
 [5]: http://sourceforge.net/projects/ufraw/files/ufraw/ufraw-0.18/ufraw-0.18-setup.exe/download
 [6]: http://ufraw.sourceforge.net/Install.html#MS
 [7]: http://portableapps.com/apps/graphics_pictures/gimp_portable
 [8]: /images/20111009_gimp_ufraw.jpg
 [9]: /images/20111009_gimp_ufraw_1.jpg