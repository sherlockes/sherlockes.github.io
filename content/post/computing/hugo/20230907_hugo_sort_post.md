---
title: "Ordenar post en Hugo"
date: "2023-09-07"
creation: "2023-09-07"
description: "Hay una forma bastante sencilla de ordenar los post en Hugo en función de la fecha de actualización. Aquí la dejo"
thumbnail: "images/20230907_hugo_sort_post_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "hugo"
draft: false
weight: 5
---
Por defecto [Hugo] ordena los post en función de la fecha de creación, para ordenarlos por la fecha de actualización estos son los pasos que hay que seguir.
<!--more-->
Creo que esta es una de las cosas más sencillas que más tiempo me ha hecho perder hasta dar con la solución.

Antes de nada, es necesario que en las propiedades de archivo esté definida la variable "lastmod" y lo más cómodo es que esta se actualice automáticamente para lo cual la forma más sencilla es que coja la información del propio repositorio en el que está guardada la web

``` toml
enableGitInfo = true			
[frontmatter]
  lastmod = ["lastmod", ":git", "date", "publishDate"]
```

> En mi caso, al trabajar con ox-hugo como exportador desde org-mode, me resulta suficiente con añadir la línea `#+hugo_auto_set_lastmod: t` en los parámetros de configuración de la exportación.

Ahora copiaremos el archivo "index.html" del tema que estemos utilizando y lo copiaremos a la carpeta "/layouts" de la raiz de nuestra web para, en el archivo copiado, cambiar la línea

``` html
{{ $paginator := .Paginate (where .Site.RegularPages "Type" "in" .Site.Params.mainSections) }}
```

por la siguiente

``` html
{{ $paginator := .Paginate (where .Site.RegularPages "Type" "in" .Site.Params.mainSections).ByLastmod.Reverse }}
```

[Hugo]: https://gohugo.io

[image-01]: /images/20230907_hugo_sort_post_01.jpg



