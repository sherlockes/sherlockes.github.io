---
title: "Mi archivo de configuración en Emacs"
date: "2022-05-04"
creation: "2022-04-03"
description: "Así es la forma en la que tengo configuraco Emacs"
thumbnail: "images/20220403_emacs_archivo_configuracion_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "emacs"
draft: false
weight: 5
---
Hay pocas cosas tan personales en informática como la configuración de [Emacs]. En mi caso uso una combinación de `.emacs` e `init.el` de la que seguro puedes sacar algo que aprender.
<!--more-->

Tal y como dejé reflejado en un [artículo] anterior, tengo mis archivos de configuración en la carpeta "dotfiles". Para que [Emacs] sea consciente de ello al abrirse en la carpeta raíz del usuario tengo alojado el archivo ".emacs" con el siguiente contenido:

``` lisp
(setq user-init-file "/home/sherlockes/dotfiles/emacs/.emacs.d/init.el")
(setq user-emacs-directory "/home/sherlockes/dotfiles/emacs/.emacs.d/")
(setq default-directory "/home/sherlockes")
(setenv "HOME" "/home/sherlockes")
(load user-init-file)
```

Gracias a esto queda definida la ruta con el resto de archivos de configuración de [Emacs] y el directorio por defecto del usuario. Ahora falta dar contenido al archivo "init.el" para que arranque la aplicación con toda la configuración establecida en el mismo.

{{< texto_remoto "https://raw.githubusercontent.com/sherlockes/SherloScripts/master/elisp/init.el" >}}

Seguro que no están aquí todas tus necesidades ni necesitas todo lo que está aquí, pero el archivo está suficientemente comentado para que puedas extraer de el todo lo que necesites.

> El archivo se actualiza diariamente de mi [repositorio en GitHub] y así se [incrusta en el blog].

### Enlaces de interés
- [enlace](www.sherblog.pro)

[Emacs]: https://www.gnu.org/software/emacs/
[artículo]: {{< relref "20210416_dotfiles.md" >}}
[incrusta en el blog]: {{< relref "20210421_hugo_incrustar_texto.md" >}}
[repositorio en GitHub]: https://github.com/sherlockes/SherloScripts/blob/master/elisp/init.el



