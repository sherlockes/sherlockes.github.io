---
title: "Exportar de org a html en emacs"
date: "2022-10-26"
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
No pretendo traducir el manual, simplemente hacer un resumen y recopilación de los conceptos que me han resultado útiles al exportar documentos escritos en org-mode a html usando emacs.
<!--more-->
### Propiedades del archivo (Título

```org
#+TITLE: Exportando org a html en emacs
```

### Insertar contenido desde un archivo externo

#### Desde un archivo html
```org
#+INCLUDE: "pp.html" export html
```

#### Desde un archivo de código

```org
#+INCLUDE: "~/.emacs.d/init.el" src emacs-lisp :lines "1-20"
```

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


![image-01]

### Enlaces de interés
- [Stackoverflow - Include plain text in org-mode](https://stackoverflow.com/questions/9267144/how-to-include-plain-text-file-in-emacs-org-mode)
- [EmacsStackExchange - Include html in org exported](https://emacs.stackexchange.com/questions/10085/org-export-how-to-include-a-pregenerated-html-file-when-exporting-org-to-html)
- [fniessen in GitHub - org-html-themes](https://github.com/fniessen/org-html-themes)


[link]: https://www.google.es

[image-01]: /images/20221026_emacs_org_to_html_01.jpg



