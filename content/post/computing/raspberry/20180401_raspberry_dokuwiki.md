---
title: "Raspberry Instalando Dokuwiki"
date: "2018-04-08"
creation: "2018-04-08"
description: "La forma más sencilla de crear unaestra wiki en Raspberry Pi."
thumbnail: "images/20180408_raspberry_dokuwiki.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Raspberry"
tags:
  - "desarrollo"
draft: false
weight: 15
---
### Que es DokuWiki
Según la [Wikipedia], [DokuWiki] es un software para gestión de webs colaborativas de tipo wiki, escrito en lenguaje de programación PHP y distribuido en código abierto bajo la licencia GPL. Está enfocado para ser usado por grupos de desarrolladores, grupos de trabajo en general y pequeñas empresas. Su sintaxis es similar a la de MediaWiki, aunque a diferencia de este software, la información se almacena en archivos de texto planos, por lo que no requiere el uso de una base de datos. DokuWiki fue creado por Andreas Göhr en junio de 2004. Desde su inclusión en distribuciones Linux como Debian y Gentoo en 2005, DokuWiki experimentó un rápido crecimiento en popularidad.

### Instalando DokuWiki
Instalarlo en la Raspberry no tiene mayor dificultad y basta con una línea de código

``` bash
sudo apt-get install dokuwiki
```

Ahora ya sólo resta darle contenido a la wiki.

[Wikipedia]: https://es.wikipedia.org/wiki/DokuWiki
[DokuWiki]: https://www.dokuwiki.org/dokuwiki
