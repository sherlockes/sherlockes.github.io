---
title: "Mis copias de seguridad"
date: "2024-10-31"
creation: "2019-06-04"
description: "Cada uno guarda su valiosa información donde quiere, este sólo es mi modo de hacerlo"
thumbnail: "images/20190603_mis_backups_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Varios"
draft: true
weight: 5
---
No va a ser este otro sitio en el que te explique la necesidad de las copias de seguridad para nuestros contenidos digitales, solo voy a mostrar la forma como yo las hago y las gestiono en una combinación entre mi NAS y algunas de las nubes públicas.
<!--more-->

# Las fotografías personales
Sin duda alguna, lo más difícil en el archivo de fotografías hay en día es separar al polvo de la paja. Utilizo Google Photos como eje central de la gestión de las fotografías y es necesario invertir un poco de tiempo todos los días en eliminar todas aquellas que no me interesa guardar ya que en una misma cuenta de Google terminan las fotografías de toda la familia.

Un tiempo atrás, resultaba muy sencillo configurar en la cuenta de Google que la galería de fotos se mostrara como una carpeta más dentro del contenido mostrado en Google Drive de la que hacer una copia de seguridad. Ahora, Google lo ha puesto un poco más complicado. Por otro lado Amazon tampoco está por a labor de facilitar las cosas.

En el artículo sobre como [sincronizar Google Photos desde la Raspberry] explico detalladamente el proceso que tengo implementado para llevar la galería de Google Photos al NAS.Además, todos los meses, aunque de forma manual, subo el mes anterior a la galería de fotos de Amazon siguiendo estos pasos:
 - Copio del NAS a una carpeta del PC el contenido del mes anterior
 - Reviso las fotos y elimino los vídeos
 - Ejecuto [exif_create] en la carpeta
 - Abro [Amazon Photos] en el navegador
 - Añado las fotos desde la carpeta del PC
 
> El uso de [exif_create] resulta imprescindible para que se ordenen cronológicamente las fotos ya de, dependiendo de como se hayan compartido, es posible que el archivo no tenga fecha de la imagen y haya que extraerla desde el contenido exif del mismo.

De esta forma tengo una copia en local y dos en nubes distintas.

# Scripts y proyectos de programación


# Archivos personales
Facturas, contratos y otros documentos de carácter personal los guardo en mi unidad de Google Drive que está sincronizada con una carpeta en el NAS y de las que varios días a la semana hago una copia de seguridad cifrada a otra cuenta de Google Drive con espacio ilimitado.

[sincronizar Google Photos desde la Raspberry]: https://sherblog.pro/sincronizar-google-photos-desde-la-raspberry/

[Amazon Photos]: https://www.amazon.es/photos
[exif_create]: https://github.com/sherlockes/SherloScripts/blob/master/bash/exif_create.sh
