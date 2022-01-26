---
title: "Renombrado de lotes de archivos en Emacs"
date: "2021-04-28"
creation: "2021-04-26"
description: "Como renombrar un conjunto de archivos al mismo tiempo gracias a Emacs"
thumbnail: "/images/20210426_emacs_renombrado_lotes_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "emacs"
- "regexp"
draft: false
weight: 5
---
Cuando era usuario de windows, usaba [Renamer] para cambiar el nombre de varios archivos en lote, en linux todavía no he encontrado una aplicación que me guste así que lo hago gracias a Emacs de una forma rápida.
<!--more-->

### Reemplazar o eliminar una cadena

Tenemos que reemplazar o eliminar una cadena de texto dentro del nombre de un conjunto de archivos ubicados en un directorio. Seguimos los siguiente pasos.

1. Abrir en modo "Dired" el directorio -> Alt+x dired (C-c D)
1. Entrar en modo renombrado -> Alt+x dired-toggle-read-only (C-x C-q)
1. Buscar la cadena a reemplazar -> Alt-x query-replace (M-%)
1. Introducir el valor con que reemplazar
1. Reemplazar todos -> !
1. Finalizar el modo de renombrado -> Alt+x wdired-finish-edit (C-c C-c)

Hay que reconocer que no es nada intuitivo pero, na vez conocido el método es rápido y sencillo.

### Numerar los archivos

Para numerar autoincrementalmente los archivos que deseemos la cosa se complica un poco más ya que debemos hacer uso de expresiones regulares.

> Muy recomendable hacer el tutorial de [RegexOne] como introducción a las expresiones regulares aunque toque luchar con el inglés.

Los pasos son similares al caso anterior sólo que usando regex

1. Abrir en modo "Dired" el directorio -> Alt+x dired (C-c D)
1. Entrar en modo renombrado -> Alt+x dired-toggle-read-only (C-x C-q)
1. Acceder al reemplazo mediante Regex -> Alt-x query-replace-regexp (CM-%)
1. Introducir la cadena a buscar -> .+\.jpg
1. Introducir la cadena a reemplazar -> \,(format "%02d" (1+ \#))_info.jpg
1. Reemplazar todos -> !
1. Finalizar el modo de renombrado -> Alt+x wdired-finish-edit (C-c C-c)

El asunto se complica un poco ya que dentro de Emacs el uso de Regexp es un poco peculiar tal y como se puede leer en el artículo [Emacs Regexp]. A continuación dejo unos ejemplos que he utilizado.

- Separar número en temporada y episodio.
De "168 loquesea.avi" a "1x68 loquesea.avi"
\([0-9]\)\([0-9]\{2\}\) Mujer.mkv → \1x\2 Mujer.mkv


[Emacs Regexp]: https://www.emacswiki.org/emacs/RegularExpression
[Renamer]: https://portableapps.com/apps/utilities/renamer-portable
[RegexOne]: https://regexone.com
