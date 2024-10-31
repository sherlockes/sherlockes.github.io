---
title: "Mostrando todos mis artículos"
date: "2024-10-29"
creation: "2024-10-29"
description: "Como he creado una plantilla en Hugo para mostrar todos los artículos del Blog"
thumbnail: "images/20201029_all_post_template_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "hugo"
tags:
- "chatgpt"
draft: true
weight: 5
---
Como he conseguido crear una plantilla en la que mostrar todos los artículos del Blog con la inestimable ayuda de [chatgpt].
<!--more-->
Busco crear una página en mi web en la que se listen todos los artículos que hasta la fecha he creado y que cumpla con las siguientes características:
 - Listados sólo los artículos de la carpeta "/content/post"
 - Ordenados en orden cronológico inverso
 - No aparezcan los artículos sin fecha ni título
 - Quede reflejado el número total de artículos
 - Los años que han pasado desde el primer artículo
 - Aparezca la fecha de modificación de cada artículo
 - Aparezcan las categorías y etiquetas de cada artículo
 - Mantenga el formato del resto de páginas del site
 - Mostrar si el artículo se ha editado al menos un año después
 
La idea es sencilla, hay que crear una plantilla que me liste todos los artículos y a continuación crear una página que haga uso de dicha plantilla. Para ello
 - Accedemos a la carpeta "/layouts/_default/"
 - Creamos el archivo "all_post_template.html"
 - Accedemos a la carpeta "/content/"
 - Creamos el archivo "articulos.md" con el siguiente contenido
 ```html
---
title: "Lista de Artículos"
layout: "all_post_list"
---
 ```
Y ya está, ahora sólo queda crear la plantilla que nos liste los artículos. En esta ocasión he decidido tirar por la calle de en medio y tras una larga [conversación] con [chargpt] he conseguido el siguiente resultado para el archivo "all_post_template.html".

{{< texto_remoto "https://raw.githubusercontent.com/sherlockes/sherlockes.github.io/refs/heads/main/layouts/_default/all_post_list.html" >}}

Por el camino me he encontrado con un par de problemas. El primero es que todos los artículos tienen guardado el parámetro "date" que utilizo como fecha de modificación para mostrarlos en el blog, pero no todos tenían el parámetro "creation" como fecha en la que escribí el artículo. Para evitar este problema he usado este sencillo script que busca en todos los ficheros markdown de la carpeta de artículos para, en los archivos que no exista el parámetro "creation" añadirlo a continuación de "date" con la misma fecha que este último.

``` bash
#!/bin/bash

# Directorio donde se encuentran los archivos markdown
POSTS_DIR="./content/post"

# Encuentra todos los archivos .md de manera recursiva
find "$POSTS_DIR" -type f -name "*.md" | while read -r file; do
  # Verifica si el archivo contiene el parámetro "date"
  if grep -q "^date:" "$file"; then
    # Verifica si el archivo ya contiene el parámetro "creation"
    if ! grep -q "^creation:" "$file"; then
      # Extrae la fecha del parámetro "date"
      date_value=$(grep "^date:" "$file" | cut -d '"' -f2)
      
      # Añade el parámetro "creation" justo después de "date"
      sed -i "/^date:/a creation: \"$date_value\"" "$file"
      
      echo "Añadido 'creation' al archivo: $file con fecha: $date_value"
    else
      echo "'creation' ya existe en el archivo: $file"
    fi
  else
    echo "No se encontró el parámetro 'date' en el archivo: $file"
  fi
done
```

Otro problema con el que me he encontrado es que en algunos parámetros "creation" había hecho uso de comillas de apertura y cierre en lugar de comillas dobles. He intentado hacer un script para corregirlo pero me ha dado muchos quebraderos de cabeza por lo que finalmente he optado por ir corrigiendo uno a uno según aparecían los errores.

El resultado lo puedes ver en mi lista de [artículos]

[artículos]: /articulos
[chatgpt]: https://chatgpt.com
[conversación]: https://chatgpt.com/share/672123ac-3e80-800d-91d9-c710ccbbcfbd



