---
title: "Extrayendo la portada de un pdf"
date: "2019-11-29"
creation: “2019-11-13”
description: "Aquí el método que esta vez he utilizado para extraer la portada de varios archivos en pdf desde la consola de comandos gracias a Imagemagick y Poppler."
thumbnail: "images/20181210_redimensionar_linea_comando_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "diseño"
  - "linux"
tags:
  - "bash"
  - "imagemagick"
  - "poppler"
  - "pdf"
draft: false
weight: 5
---
Una vez más me encuentro con un problema de los que puedo optar por la solución sencilla y laboriosa o por la optima y meticulosa. Necesito convertir de varios archivos en pdf la primera página (Portada) a una imagen para lo cual voy a probar dos alternativas, primero con [Imagemagick] y posteriormente con [Poppler] ambas desde la terminal y la línea de comandos de Linux Mint.
<!--more-->

## Usando Imagemagick (Comando "convert")
Ya hace un tiempo, emplee la línea de comandos en Linux Mint para [redimensionar un conjunto de imágenes]({{<relref"20181215_redimensionar_linea_comando.md">}}). Ahora vuelvo a emplear un método parecido para extraer desde varios archivos *.pdf una imagen en formato *.jpg con la portada de cada uno de ellos. 

Si no la tenemos instalada, el primer paso será instalar la utilidad de [Imagemagick] tras actualizar el sistema.

``` sh
sudo apt update
sudo apt upgrade
sudo apt install imagemagick
```

En caso de tener algún problema siempre podemos recurrir a la versión [oficial] de la web del software. El siguiente paso es modificar el archivo de políticas de seguridad para que nos permita la extracción de archivos *.pdf. Puesto que la aplicación no va a estar corriendo en un servidor sino que lo usaré en local, resultará suficiente con cambiar el nombre de este archivo de políticas para eliminar todas las restricciones.

``` sh
sudo mv /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xmlout
```

Con todo ya preparado, ahora será suficiente con ejecutar una línea de comando dentro de una carpeta para extraer la portada en formato *.jpg de todos los *.pdf que allí se encuentren. Los archivos generados tendrán el sufijo "_portada"

``` sh
convert *.pdf[0] -set filename:fname '%t_portada' '%[filename:fname].jpg'
```

## Usando Poppler (comando "pdftoppm") 
Una alternativa al uso de [Imagemagick] es [Poppler] con su comando "pdftoppm" que convierte un archivo pdf a imagen.  En este caso, la utilidad no es capaz de manejar por si misma distintos nombres de archivo por lo que usaremos un for para listar todos los archivos *.pdf sobre los que realizar la conversión. La orden quedará según la siguiente estructura:

pdftoppm -formato -f (pag_a_extraer] -singlefile(solo_una_página) "nombre_origen" "nombre_destino"

Aquí puedes encontrar todas las [opciones de pdftoppm]. De esta forma si incluimos la orden dentro del bucle "for" quedará como lo siguiente.

``` sh
for pdfile in *.pdf
do 
	pdftoppm -jpeg -f 1 -singlefile "${pdfile}" "${pdfile%%.*}"_portada
done
```

Para luchar en igualdad de condiciones y no tener que crear un archivo ejecutable en el que encapsular este código voy a pasar el lazo "for...do...done" a una sola línea que podremos introducir directamente en la terminal.

``` sh
for pdfile in *.pdf ; do pdftoppm -jpeg -f 1 -singlefile "${pdfile}" "${pdfile%%.*}"_portada; done
```

Links:
https://askubuntu.com/questions/1081895/trouble-with-batch-conversion-of-png-to-pdf-using-convert
https://www.imagemagick.org/discourse-server/viewtopic.php?t=14927


[Imagemagick]: https://imagemagick.org
[oficial]: https://imagemagick.org/script/download.php
[Poppler]: https://poppler.freedesktop.org/
[opciones de pdftoppm]: https://linux.die.net/man/1/pdftoppm
