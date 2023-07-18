---
title: "Incrustar texto externo en Hugo"
date: "2021-04-28"
creation: "2021-04-21"
description: "Como incrustar texto de un archivo externo dentro de un post en Hugo"
thumbnail: "/images/20210421_hugo_incrustar_texto_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "hugo"
tags:
- "bash"
- "shortcodes"
draft: false
weight: 5
---
Hace tiempo que vengo pensando en la capacidad de poder introducir texto desde un archivo externo dentro de los post que publico en [Hugo]. Hoy se me ha encendido la bombilla.
<!--more-->

Una potente herramienta que posee [Hugo] es la posibilidad de uso de [Shortcodes] (Fragmentos simples dentro de los archivos de contenido que llaman a plantillas integradas o personalizadas), pero más potente todavía es el uso de [Shortcodes personalizados] que ya he utilizado en otras ocasiones como en mi proyecto de [Vértices Geodésicos].

Es posible utilizar esta característica para crear un Shortcode que incluya en el post el texto contenido en un archivo de texto externo sin más que escribir una línea de código.

```
<pre><code><embed src="{{.Get 0}}" width="100%"></code></pre>
```

Esta línea la incluiremos en un archivo llamado "texto_externo.html" que guardaremos en la carpeta "layouts/shortcodes"

>Crearemos esta carpeta (Si no lo está) en la raiz del blog (junto a "content", "static"...) en lugar de insertar el archivo dentro de la carpeta del tema para evitar que destruya este shortcode co una actualizació del tema.

Ahora ya sólo resta insertar el siguiente código en la zona del post o la página donde queramos incluir el texto del archivo externo.

```
{{</* texto_externo "/archivo.md" */>}}
```

Para que se cargue correctamente, el archivo deberá alojarse en la carpeta "static" ya que es lo que [Hugo] entiende como la raiz de los documentos en el Blog.


[Hugo]: https://gohugo.io
[Shortcodes]: https://gohugo.io/content-management/shortcodes/
[Shortcodes personalizados]: https://gohugo.io/templates/shortcode-templates/
[Vértices Geodésicos]: https://sherblog.pro/mis-v%C3%A9rtices-geod%C3%A9sicos-en-hugo/

[image-01]: /images/20210421_hugo_incrustar_texto_01.jpg
