---
title: "Script para renombrar imágenes en python en función de la fecha en la que se tomaron"
date: "2020-11-26"
creation: "2020-11-26"
descrption: "Script para renombrar imágenes en python en función de la fecha en la que se tomaron"
thumbnail: "/images/20201126_image_renamer_python_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "computing"
  - "productividad"
tags:
  - "python"
  - "exif"
draft: false
weight: 5
---
Un día te vienen de la guardería con un montón de fotos de tu hijo metidas en una carpeta y cada una con un nombre completamente aleatorio en función del dispositivo con el que se tomaron, algo hay que hacer para renombrarlas.
<!--more-->
Existen muchas utilidades para renombrar archivos en masa pero todas ellas tienen el mismo problema y es que, si no estás acostumbrado a utilizarlas te va a costar más hacerlo que renombrar a mano todos los archivos que tengas que modificar. Mi reciente interés por python me ha llevado a crear un pequeño script para renombrar todas las fotografías con extensión jpg que encuentre en la carpeta en la que se ejecute.

El único requerimiento que tiene este script es tener instalado el paquete [exif] y el funcionamiento que sigue es el siguiente:

- Extrae la ruta de la carpeta actual
- Extrae el nombre de la carpeta actual
- Cambia los espacios por guiones bajos en el nombre de la carpeta
- Lista todos los archivos de la carpeta y trata sólo los jpg
- Si el archivo tiene información exif extrae la fecha y pasa a renombrarlo
- Incrementa el número del sufijo del nombre hasta encontrar uno que no exista
- Renombra el archivo

Y este es el código resultante.

```
import os
from exif import Image

dir_act = os.path.dirname(os.path.realpath(__file__))

carpeta = dir_act.split("/")
carpeta.reverse()
carpeta = str(carpeta[0])
carpeta = carpeta.replace(" ", "_")
print(carpeta)

files = os.listdir(dir_act)

for f in files:
    if f.endswith('.jpg'):
        with open(f, 'rb') as image_file:
            foto = Image(image_file)
        
        if foto.has_exif:
            año = foto.datetime_original.split(" ")[0].split(":")[0]
            mes = foto.datetime_original.split(" ")[0].split(":")[1]
            dia = foto.datetime_original.split(" ")[0].split(":")[2]
            
            num = 1
        
            while True:
                numero = '{0:03}'.format(num)
                nombre = año + mes + dia + "_" + carpeta + "_" + numero +".jpg"
                archivo = os.path.join(dir_act, nombre)

                if os.path.isfile(archivo):
                    num += 1
                else:
                    break
            
            numero = '{0:03}'.format(num)
            nombre_nuevo = año + mes + dia + "_" + carpeta + "_" + numero +".jpg"
            archivo_viejo = os.path.join(dir_act, f)
            os.rename(archivo_viejo, nombre_nuevo)
```
Es posible que el archivo haya recibido alguna actualización que aquí no está reflejada por lo que te recomiendo pases por mi [repositorio] en GitHub para descargarlo.

[exif]: https://pypi.org/project/exif/
[repositorio]: https://github.com/sherlockes/SherloScripts/blob/master/python/renamer.py
