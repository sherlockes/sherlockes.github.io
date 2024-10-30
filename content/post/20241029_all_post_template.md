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

![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[chatgpt]: https://chatgpt.com
[conversación]: https://chatgpt.com/share/672123ac-3e80-800d-91d9-c710ccbbcfbd

[image-01]: /images/20201029_all_post_template_01.jpg



