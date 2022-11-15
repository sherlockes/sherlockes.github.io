---
title: "Exportar de org a html en emacs"
date: "2022-11-15"
creation: "2022-10-26"
description: "Lo que a mi me ha resultado util en la exportación de org a html usando emacs"
thumbnail: "images/20221026_emacs_org_to_html_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "computing"
tags:
- "emacs"
draft: true
weight: 5
---
No pretendo traducir el manual, simplemente hacer un resumen y recopilación de los conceptos que me han resultado útiles al exportar documentos escritos en org-mode a html usando emacs. Añadiré contenido a medida que lo vaya descubriendo y utilizando.
<!--more-->
### Propiedades del archivo (Título, archivo de exportación, opciones...)
Es posible en una línea definir el título del que va a ser el archivo exportado, en otra la ruta se exportación o incluso definir o añadir información al "head" del archivo html generado.

Además es posible definir en una sola línea varias opciones como la no inclusión del índice `toc:nil`, no numerar la lista de contenidos `num:nil`, no agregar el postámbulo al final del archivo `html-postamble:nil`, no evaluar la exportación de subíndices y superíndices `^:nil`

```org
#+TITLE: Exportando org a html en emacs
#+EXPORT_FILE_NAME: ~/salida/index.html
#+OPTIONS: toc:nil num:nil html-postamble:nil ^:nil
#+HTML_HEAD: <img src="./img/logo.jpg" width="240">
#+HTML_HEAD_EXTRA: <style> .figure p {text-align: left;}</style>
```
-----
### Insertar contenido desde un archivo externo
- Desde un archivo html
```org
#+INCLUDE: "pp.html" export html
```
- Desde un archivo de código
```org
#+INCLUDE: "~/.emacs.d/init.el" src emacs-lisp :lines "1-20"
```
> Mediante el modificador `:lines "1-20"` indicamos al exportador que sólo queremos importar al 20 primeras líneas.

- Desde un archivo de texto (Incluyendo el archivo)
```org
#+INCLUDE: "~/Descargas/pepe.txt" export txt
```

- Desde un archivo de texto (Leyendo el contenido evaluando elisp)
```org
#+name: emacs-lisp-hello-world
#+begin_src elisp :exports results
(with-temp-buffer
    (insert-file-contents "~/Descargas/pepe.txt")
    (buffer-string))
#+end_src
```

- Desde un archivo de texto (Incluyendo a través de un html Object data)
```org
#+HTML: <div><object data="~/Descargas/pepe.txt" height= 500 width=1000></object></font></div>
```

-----
### Insertar código HTML
- Una sola línea
```org
#+HTML: <img src="pepe.jpg" alt="centered image" />
```
- Un bloque de código
```org
#+BEGIN_EXPORT html
<center>
    <img src="pepe.jpg" alt="centered image" />
</center>
#+END_EXPORT
```
-----
### Insertar imágenes
La gran parte de la información de la exportación de imágenes la podemos encontrar en "[Images in HTML export]" y "[Images and XHTML export]".
- Imagen con enlace a otra de alta resolución
```org
[[file:alta_res.jpg][file:baja_res.jpg]]
```
- Centrar la imagen
Podemos bien centrar una imagen en la exportación añadiendo los atributos html previos a la declaración de la imagen
```org
#+ATTR_HTML: :style margin-left: auto; margin-right: auto;
[[file:logo.jpg]]
```
O bien insertar directamente toda la imagen mediante código html
```org
#+html: <p align="center"><img src="logo.jpg" /></p>
```
- Imagen con un enlace
Para que al hacer click sobre una imagen nos lleve a un enlace externo, usaremos este formato.
```org
[[http://www.google.es][file:logo.jpg]]
```
- Modificar tamaño, borde, texto alternativo...
La forma más práctiva es mediante la inclusión de atributos previos a la declaración de la imagen tal y como se muestra a continuación.
```org
#+ATTR_HTML: :alt Zoomed image.
#+ATTR_HTML: :width 300 :style border:2px solid black;
[[file:logo.jpg]]
```
-----
### Insertar un vídeo (Youtube/local)

```org
#+BEGIN_EXPORT html
<iframe width="420" height="315"
src="https://www.youtube.com/embed/tgbNymZ7vqY">
</iframe>
#+END_EXPORT

#+BEGIN_EXPORT html
<video width="320" controls loop autoplay>
  <source src="video2.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>
#+END_EXPORT
```
-----
### No exportar un encabezado
La forma más sencilla de no exportar todo el contenido de un encabezado es añadiendo al mismo un tag y excluir la publicación del mismo.

```org
#+EXCLUDE_TAGS: oculto
```

-----
### Exportar usando un tema
En la red es posible encontrar [temas] desarrollados por creadores independientes como [Fabrice Niessen] que con una sólo línea dentro del archivo org realiza una exportación sencillamente espectacular.

```org
#+SETUPFILE: https://fniessen.github.io/org-html-themes/org/theme-readtheorg.setup
```

![image-01]

### Enlaces de interés
- [Orgmode.org - HTML Export](https://orgmode.org/manual/HTML-Export.html)
- [Stackoverflow - Include plain text in org-mode](https://stackoverflow.com/questions/9267144/how-to-include-plain-text-file-in-emacs-org-mode)
- [EmacsStackExchange - Include html in org exported](https://emacs.stackexchange.com/questions/10085/org-export-how-to-include-a-pregenerated-html-file-when-exporting-org-to-html)
- [fniessen in GitHub - org-html-themes](https://github.com/fniessen/org-html-themes)

[Fabrice Niessen]: https://github.com/fniessen
[temas]: https://github.com/fniessen/org-html-themes
[Images in HTML export]: https://orgmode.org/manual/Images-in-HTML-export.html#Images-in-HTML-export
[Images and XHTML export]: https://orgmode.org/worg/org-tutorials/images-and-xhtml-export.html

[image-01]: /images/20221026_emacs_org_to_html_01.jpg



