---
title: "Unir o separar en varios pdf en linux desde la línea de comandos"
date: "2022-06-16"
creation: “2019-11-27”
description: "Uno de los muchos métodos para unir en uno varios archivos *.pdf y viceversa, en línea de comandos."
thumbnail: "images/20191127_unir_pdf_00.jpg"
disable_comments: true
authorbox: false
toc: true
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
En la web podemos encontrar una infinidad de servicios para unir varios archivos pdf en uno o partir uno en varios según las páginas, pero si no quieres perder tiempo en subir y bajar los archivos a los servidores remotos y tienes dudas de la privacidad que el servicio ofrezca, aquí dejo una forma sencilla para realizar el mismo trabajo con una sola línea en la consola de comandos.
<!--more-->

Esta vez utilizo una librería de renderizado para archivos pdf para debian llamada [poppler-utils] y que a su vez se basa en la librería genérica [Poppler]. Cuando yo la he intentado ejecutar en mi Linux Mint resulta que ya la tenía instalada. En caso contrario es tan simple como...

``` sh
sudo apt-get update
sudo apt-get install poppler-utils
```

### Unir varios archivos
A continuación ubicaremos todos los archivos pdf que queremos unir en una carpeta vacía y abriendo una sesión de la terminal desde dentro de ella usaremos el siguiente comando.

``` sh
pdfunite *.pdf unidos.pdf
```

Con esto se nos habrá generado un archivo "unidos.pdf" en el que se habrán unido todos los archivos incluidos en la carpeta.


### Partir archivo por páginas
También es posible que necesitemos partir un pdf en varios para lo cual emplearemos el siguiente comando

``` sh
pdfseparate <nombre_origen> <nombre_destino>-%d.pdf
```
Con esto se crearán tantos archivos, numerados según la página a la que corresponden, como páginas tenga el documento de origen.

### Enlaces de interés
- [Unixblogger - Merge pdf](https://unixblogger.com/how-to-easily-merge-pdf-documents-under-linux/)
- [Ubuntubuzz - Split pdf](https://www.ubuntubuzz.com/2016/01/how-to-split-pdf-with-pdfseparate.html)



[poppler-utils]: https://packages.debian.org/es/sid/poppler-utils
[Poppler]: https://poppler.freedesktop.org/

[https://www.ubuntubuzz.com/2016/01/how-to-split-pdf-with-pdfseparate.html]: https://www.ubuntubuzz.com/2016/01/how-to-split-pdf-with-pdfseparate.html
