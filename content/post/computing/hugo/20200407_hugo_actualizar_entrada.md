---
title: "Insertar comentarios en Hugo"
date: "2021-04-28"
creation: "2020-04-07"
description: "Está es la forma que utilizo para actualizar entradas y evitar que se muestren los cambios hasta que esté terminada la actualización."
thumbnail: "images/20200407_hugo_actualizar_entrada_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
  - "hugo"
tags:
  - "shortcodes"
draft: false
weight: 5
---
Cuando no se tiene mucho tiempo libre, la publicación de un post puede demorarse a lo largo de varios días. Para eso Se mantiene la entrada en modo "borrador". Pero... ¿Como lo hago al actualizar una entrada?
<!--more-->
Está claro que no es factible pasar una entrada a modo borrador mientras la estamos actualizando ya que la volvemos invisible y durante todo el tiempo que la estemos editando los potenciales visitantes no podrán acceder al contenido original.

### Usando Shortcodes

Cuando añado contenido a alguna entrada uso un concepto extraído de [andreasbergstrom.com] en el que explica cómo es posible "comentar" parte del contenido del archivo Markdown para que [Hugo] no lo interprete como contenido a mostrar.

Para ello es necesario crear un archivo "borrador.html" dentro de la carpeta "layouts/shortcodes/" de nuestra web. El contenido de este archivo simplemente será

```
{{ if .Inner }}{{ end }}
```

A partir de aquí, mientras estemos añadiendo contenido a una entrada lo haremos dentro de una zona comentada de forma que Hugo no la muestre.

```
{{</* borrador */>}}
Aquí iremos añadiendo el contenido con el que queremos actualizar la entrada...
{{</* / borrador */>}}
```

Y así de sencillo, cuando queramos que el contenido actualizado se muestre tan solo tenemos que eliminar las primera y última linea.


Pues bien, como casi todos los artículos los escribo en Emacs me he creado un pequeño atajo de teclado para la inclusión de estos comentarios gracias a [yasnippet] para lo cual solo es necesario crear un nuevo atajo desde un archivo markdown de una de las entradas del blog (yas-new-snippet) e incluir el siguiente texto.

```
# -*- mode: snippet -*-
# name: comentario
# key: comentario
# --
{{</* borrador */>}}
${1:Comentario...}
{{</* / borrador */>}}
```

Lo guardamos (C-x C-w) con el nombre que nos apetezca y ya está listo para utilizarse. Sólo hay que empezar una línea con la palabra comentario y pulsar el tabulador.

### Usando html
Aunque no resulta tan "cool", un método igual de efectivo que el anterior pero un poco más sencillo es haciendo uso de los comentarios de código en html mediante las etiquetas "<!- - -" y "- ->". Introduciremos el texto a modo de borrador o comentario entre estas equiquetas.

```
<!- - -
Aquí irá todo el texto que queremos ocultar temporalmente
- ->
```

[Hugo]: https://gohugo.io/
[andreasbergstrom.com]: https://andreasbergstrom.com/posts/comments-in-hugo/
[yasnippet]: https://github.com/joaotavora/yasnippet
