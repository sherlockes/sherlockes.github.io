---
title: "Unir varios pdf en linux desde la línea de comandos"
date: "2019-11-27"
creation: “2019-11-27”
description: "Uno de los muchos métodos para unir en uno varios archivos *.pdf, en línea de comandos."
thumbnail: "images/20191127_unir_pdf_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "productividad"
  - "linux"
tags:
  - "poppler-utils"
  - "bash"
draft: false
weight: 5
---
En la web podemos encontrar una infinidad de servicios para unir varios archivos pdf en uno, pero si no quieres perder tiempo en subir y bajar los archivos a los servidores remotos aquí dejo una forma sencilla para realizar el mismo trabajo con una sola línea en la consola de comandos.
<!--more-->

Esta vez utilizo una librería de renderizado para archivos pdf para debian llamada [poppler-utils] y que a su vez se basa en la librería genérica [Poppler]. Cuando yo la he intentado ejecutar en mi Linux Mint resulta que ya la tenía instalada. En caso contrario es tan simple como...

``` sh
sudo apt-get update
sudo apt-get install poppler-utils
```

A continuación ubicaremos todos los archivos pdf que queremos unir en una carpeta vacía y abriendo una sesión de la terminal desde dentro de ella usaremos el siguiente comando.

``` sh
pdfunite *.pdf unidos.pdf
```

Con esto se nos habrá generado un archivo "unidos.pdf" en el que se habrán unido todos los archivos incluidos en la carpeta.


Links:
https://unixblogger.com/how-to-easily-merge-pdf-documents-under-linux/



[poppler-utils]: https://packages.debian.org/es/sid/poppler-utils
[Poppler]: https://poppler.freedesktop.org/
