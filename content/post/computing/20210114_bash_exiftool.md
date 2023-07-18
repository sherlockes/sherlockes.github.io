---
title: "Exif info en Bash con Exiftool"
date: "2021-01-14"
creation: "2021-01-14"
description: "Como insertar una fecha de captura para las imágenes que no la tienen en Bash gracias a Exiftool"
thumbnail: "/images/20210114_bash_exiftool_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: false
weight: 5
---
Hace un tiempo, Amazon ha restringido la subida automatizada de imágenes a [Amazon Photos], al hacerlo de forma manual me encuentro con el problema de tener que incrustar una fecha de captura a las fotografías que no la tienen.
<!--more-->
En un [post anterior] expliqué la artimaña que ahora hay que hacer para poder tener una copia de seguridad de todas las imágenes de [Google Photos] en el NAS. Hasta hace poco, estas imágenes se subían desde el NAS a [Amazon Photos] de forma automática, pero con los cambios en las condiciones del servicio ahora hay que hacerlo de forma manual. Lo que voy haciendo es, cuando se acaba el més, subo todas las fotografías del mismo a [Amazon Photos] pero me he encontrado con un problema.

Resulta que en algunas de las imágenes de mi galería no existe la información exif con la fecha de captura por lo que, al subirlas a [Amazon Photos] no se ordenan cronológicamente por lo que supone un completo desastre.

Para resolver este problema, antes de subirlas, ejecuto en la carpeta en la que están guardadas este script.

```
shopt -s nullglob

for ext in jpg jpeg png gif; do 
    files=( *."$ext" )
    if [ ${#files[@]} -gt 0 ]; then
        printf 'Número de imágenes %s : %d\n' "$ext" "${#files[@]}"
        for file in "${files[@]}"; do
            captura=$( exiftool -CreateDate $file )
            if [ -n "$captura" ]; then
                echo $file " tiene fecha de captura"
            else
                echo $file " no tiene fecha de captura."
                exiftool "-CreateDate<FileModifyDate" $file
                exiftool "-FileModifyDate<CreateDate" $file
            fi
        done 
        rm *."$ext"_original
    fi
done
```

Utilizando un poco de Bash y la librería [Exiftool] el código de arriba realiza las siguientes funciones:

- Busqueda de imágenes por extensión de archivo (jpg, jpeg, png o gif)
- Determinación de la existencia de info de la fecha de captura
- Inserción de la fecha de modificación como fecha de captura
- Restauración de la fecha de modificación
- Eliminación de las copias generadas por ExifTool

> Es posible que esta no sea la última versión del script que podrás encontar en mi [Repositorio] de GitHub junto con una descripción del mismo.

Y esto es todo, el script se ejecuta en unos pocos segundos y deja las imágenes listas para que sean correctamente ordenadas al subirlas a [Amazon Photos].

[Amazon Photos]: https://www.amazon.es/photos
[Exiftool]: https://exiftool.org
[Google Photos]: https://photos.google.com
[post anterior]: https://sherblog.pro/backup-de-google-photos/
[Repositorio]: https://github.com/sherlockes
