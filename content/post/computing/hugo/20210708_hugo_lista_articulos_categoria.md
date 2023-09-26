---
title: "Lista de artículos por categoría en Hugo"
date: "2021-07-10"
creation: "2021-07-08"
description: "Aquí dejo la forma que he utilizado para crear una lista de artículos para una categoría determinada"
thumbnail: "/images/20210708_hugo_lista_articulos_categoria_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "hugo"
tags:
- "shortcodes"
draft: false
weight: 5
---
No se si será la forma más sencilla, es la que yo he utilizado para crear una lista de artículos publicados en cierta categoría de mi blog desarrollado en [hugo] a partir del uso de "Shortcodes" personalizados.
<!--more-->
Una vez más me encuentro ante un problema sencillo con el que he perdido unas horas para solucionarlo. Necesito insertar una lista de artículos de cierta categoría en un post del blog y la forma más sencilla que ha pasado por delante mio es haciendo uso de los "Shortcodes" personalizados de [Hugo].

Aunque la documentación para la creación de [Custom Shortcodes] está muy clara, no me ha sido suficiente y he tenido que investigar un poco más por mi cuenta para finalmente crear el archivo "lista_categoria.html" que hay que incluir en la carpeta "layouts/shortcodes".

```html
{{ $categoria := .Get "cat" }}
<h3>Artículos de la categoría "{{ $categoria }}"</h3>
{{ range where .Site.RegularPages ".Params.categories" "intersect" (slice $categoria) }}
<a href="{{.Permalink}}">{{.Params.title}} ({{.Params.creation}})</a></br>
{{ end }}
```

Con esto ya sólo resta incluir el código

```
{{</* lista_categoria cat="categoria" */>}}
```

y obtendremos una lista con todos los post de la categoría y la fecha de creación del mismo.

### Enlaces de interés
- [Gohugo - Range pages specific category](https://discourse.gohugo.io/t/range-with-pages-with-specific-category-solved/32345/5)

[Custom Shortcodes]: https://gohugo.io/templates/shortcode-templates/
[Hugo]: https://gohugo.io
