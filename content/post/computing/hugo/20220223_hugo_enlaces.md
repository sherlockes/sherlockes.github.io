---
title: "Como añado enlaces en Hugo"
date: "2022-02-23"
creation: "2022-02-23"
description: "La forma en la que escribo los enlaces dentro de los post en Hugo"
thumbnail: "images/20220223_hugo_enlaces_00.jpg"
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
Hay diversas formas de incluir los enlaces dentro de los documentos en [Markdown] que [Hugo] usa como fuente para generar la web. Aquí voy a explicar la que yo utilizo.
<!--more-->
### Enlaces a sitios externos

``` Markdown
Enlace a [Google](https://www.google.es) dentro de un post.
```

### Enlace a otro artículo del blog
Para crear un enlace a otro artículo del blog me encuentro con un par de posibilidades, una llamando directamente a la url generada (Siempre de modo relativo para no tener problemas en el entorno de desarrollo o si le cambiamos la url principal) y otra llamando al nombre del archivo markdown a partir del cual se genera el artículo al que queremos enlazar a traves de un "shortcode".

Personalmente prefiero la segunda forma, aunque sea un poco más complicada de escribir, ya que el nombre del archivo es lo primero que pongo al escribir un post y permanece inamovible.

``` Markdown
Enlace a otro [artículo](/arquetipos-en-hugo-archetypes/) del blog usando usando la ruta generada.
Enlace a otro [artículo]({{</* relref "20220129_hugo_archetypes.md" */>}}) del blog usando el nombre del archivo "md"
```
El resultado es el mismo, un enlace a otro [artículo] del blog.

### Enlace a un encabezado de otro artículo del blog
Nuevamente nos encontramos con dos formas de insertar un enlace hacia un encabezado de otro artículo del blog, mediante la ur directa o a través del nombre del archivo markdow que lo genera.

``` Markdown
Enlace a un [encabezado](/mi-gestión-de-los-archivos-de-configuración/#configuración-de-emacs) de otro artículo usando la ruta generada.
Enlace a un [encabezado]({{</* ref "20210416_dotfiles.md#configuración-de-emacs" */>}})
```
De cualquiera de la dos formas, el resultado es el mismo, un enlace a un [encabezado] de otro post dentro del mismo blog.

### Enlaces agrupados

En markdown existe la posibilidad de agrupar todos los enlaces del documento al final del mismo con lo que obtenemos dos ventajas importantes, por un lado el cuerpo del documento permanece más "limpio" al no introducir en el mismo el enlace completo y por otro lado en caso de introducir el mismo enlace varias veces hay una reducción importante de tiempo.

Los tres tipos de enlaces a los que he hecho referencia quedarían así al final del archivo markdown:

``` Markdown
[Google]: https://www.google.es
[artículo]: {{</* relref "20220129_hugo_archetypes.md" */>}}
[encabezado]: {{</* ref "20210416_dotfiles.md#configuración-de-emacs" */>}}
```

Para insertarlos en el cuerpo del post simplemente hay que introducir la primera parte, `[Google]`, `[artículo]` o `[encabezado]` sin necesidad de hacer referencia a la url de destino.


### Enlaces de interés
- [GoHugo - Links & Cross References](https://gohugo.io/content-management/cross-references/)

[artículo]: {{< relref "20220129_hugo_archetypes.md" >}}
[encabezado]: {{< ref "20210416_dotfiles.md#configuración-de-emacs" >}}
[Hugo]: https://gohugo.io
[Markdown]: https://es.wikipedia.org/wiki/Markdown
