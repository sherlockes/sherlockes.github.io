---
title: "Publicar desde iaWriter"
date: "2018-09-04"
creation: "2018-09-04"
description: "El modo que utilizo para publicar en el blog usando sólo el editor de texto."
thumbnail: "images/20180904_hugo_publicar_editor_texto_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "hugo"
tags:
  - "iAWriter"
draft: false
weight: 5
---

### Publicar solo con el editor de texto
Hace un tiempo que estoy intentando escribir en Markdown y para WordPress he estado utilizando el Plugin [Wp-MarkDown][11] que me ha permitido realizar la maquetación del post directamente en Markdown. Una vez que he dejado atrás WordPress en favor de Hugo uno de mis objetivos de los últimos meses ha sido poder publicar en el blog simplemente usando un editor de texto.

Pues bien, no sin algo de esfuerzo, al final lo he conseguido. Gracias a Hugo cómo CMS este post que ahora estoy escribiendo lo puedo publicar en mi blog de una forma rápida y sencilla en Markdown directamente desde la aplicación [iaWritter][12].

Las etapas del proceso son las siguientes.

* Parto de un archivo de texto con extensión *.md que renombro con la estructura "fecha_nombre_archivo.md".
* Escribo el contenido del Post

Hasta aquí todo el proceso que he de realizar de forma manual. El resto se realiza de forma automática según la siguiente secuencia.

* Iawriter guarda el archivo de texto en mi unidad de Google Drive en una carpeta específica para los post de la web.

* Gracias a rclone la Raspberry es capaz de sincronizar tanto la carpeta "content" como la "static" con la nube de Google Drive mediante un proceso en crontab que se ejecuta cada hora

  > Para crear el proceso que se ejecute cada hora  se utiliza el comando `crontab -e` añadiendo al final la línea "0 * * * * /home/pi/sherblog/publicar.sh" donde "publicar.sh" es el script ejecutable que realiza todas las operaciones.

* La misma secuencia de comandos busca en la carpeta "post" algún archivo sin cabecera para incluirle una genérica que luego será fácil de editar.

  > Antes de colocar la cabecera, el script comprueba que el archivo no se ha modificado en la última hora para de esta forma "garantizar" que no se está trabajando en el y no crear problemas de sincronización.

* Con los cambios efectuados en los archivos sin cabecera se realiza la sincronización inversa hacia la nube de Google. 

* Tras sincronizar la carpeta, el script construye toda la web estática a partir de los post y archivos de configuración.

  > Resulta interesante conocer que para hacer referencia al comando "hugo" hay que usar en el script la ruta completa que en mi caso quedará "/usr/local/bin/hugo". 

* Con la web regenerada se suben los cambios a mi cuenta de github donde tengo publicada la web de forma completamente gratuita.

```bash
#!/bin/sh
# -*- ENCODING: UTF-8 -*-

#Sincroniza el contenido de la nube de Google Drive con las carpetas locales
rclone sync -v GoogleDrive:/Sherblog/content/ /home/pi/sherblog/content/
rclone sync -v GoogleDrive:/Sherblog/static/ /home/pi/sherblog/static/

#Cambio al directorio de contenidos
cd ~/sherblog/content/post

#Busca archivos sin cabecera para añadirle una genérica
grep -r -L "\-\-\-" * |
while read fname
do
  #Minutos que han de pasar desde la ultima modificación para encabezado
  minmin=30

  #Calculo de los minutos pasados desde la ultima modificacion
  umodsg=$(date +%s -r "$fname")
  ahorasg=$(date +%s)
  minpasados=$(((ahorasg - umodsg)/60))
  echo Han pasado $minpasados de los $minmin minutos desde la modificación de "$fname"

  #Inserta la cabecera si han pasado más de 65 minutos
  if [ $minpasados -gt $minmin ]; then
    echo Colocando la cabecera a "$fname"
    cat cabecera.md "$fname" > temp && mv temp "$fname"
  fi
done

#Sincroniza los archivos de la nube con los modificados en local
rclone sync -v /home/pi/sherblog/content/ GoogleDrive:/Sherblog/content/

#Genera la web estática en Hugo
cd ~/sherblog
/usr/local/bin/hugo

#Sube los cambios generados en la web a GitHub
cd ~/sherblog/git/sherlockes.github.io
git add --all
git commit -m "Update"
git push -u origin master

exit 0
```

Y ya está. La web actualizada sin usar nada más que iawriter. Ahora resta idear un método sencillo para subir las imágenes, quizás IFTTT sea una buena opción, pero esto para otro día...

> A fecha de hoy (Octubre de 2010) el sistema funciona a las mil maravillas en Android pero IAWriter en IOS da algún problema a la hora de guardar los archivos en Google Drive, espero se solvente con alguna actualización. 

[11]: https://wordpress.org/plugins/wp-markdown/
[12]: https://ia.net/writer
