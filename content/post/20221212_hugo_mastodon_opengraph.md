---
title: "Compartiendo contenido de Hugo en Mastodon"
date: "2022-12-12"
creation: "2022-12-12"
description: "Para que la imagen del post se comparta también al publicarlo en Mastodon hay que seguir unos pasos."
thumbnail: "images/20221212_hugo_mastodon_opengraph_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "hugo"
tags:
- "mastodon"
- "jinja2"
- "html"
draft: true
weight: 5
---
Para que al publicar en Mastodon un artículo de la web se vincule también la imagen del mismo es necesario realizar unas modificaciones en la plantilla de Hugo.
<!--more-->
Hace un tiempo ya que escribí un post para que al publicar un post de [Hugo en Twitter] se generara automáticamente una tarjeta con la información e imagen más relevante del mismo. Gracias a todo ese tiempo invertido, ahora encontrar la solución al mismo problema para Mastodon me ha resultado mucho más sencillo y rápido.

Como Mastodon utiliza el protocolo de [OpenGraph] incluiremos las siguiente líneas en el archivo "/layouts/_default/baseof.html". Si el archivo no existe, copiaremos el de la misma ruta de la plantilla que estemos utilizando y sobre la copia realizaremos las modificaciones necesarias.

``` html
<!-- Open Graph para Mastodon ---->
<meta property="og:type" content="article">
<meta property="og:locale" content="es_ES">
<meta property="og:site_name" content="sherblog.pro">
<meta property="og:locale" content="es_ES">
<meta property="og:title"   content="{{ .Params.title }}">
<meta property="og:url"   content="{{ .Site.BaseURL }}">
<meta property="og:description" content="{{ .Params.description }}"/>

{{ if (.Params.thumbnail) }}<meta property="og:image" content="http://www.sherblog.pro/{{ .Params.thumbnail }}" />{{else}}<meta property="og:image" content="http://www.sherblog.pro/images/logo.png" />{{end}}
```

![image-01]

### Enlaces de interés
- [AmyTabb - Mastodon preview cards](https://amytabb.com/til/2022/12/03/mastodon-preview-cards/)
- [Opengraph - Check meta tags](https://www.opengraph.xyz)

[Hugo en Twitter]: {{<relref"20180727_de_hugo_a_twitter.md">}}
[OpenGraph]: https://opengraph.dev

[image-01]: /images/20221212_hugo_mastodon_opengraph_01.jpg



