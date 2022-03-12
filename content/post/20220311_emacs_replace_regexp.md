---
title: "Emacs replace regexp"
date: "2022-03-11"
creation: "2022-03-11"
description: "Emacs replace regexp"
thumbnail: "images/20220311_emacs_replace_regexp_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "emacs"
draft: true
weight: 5
---
A raiz de leer este [artículo de Angel] he vuelto a intentar lo que hace un tiempo dejé por [imposible]. Se trata del reemplazo de cadenas de texto en varios archivos mediante [Emacs].
<!--more-->
Recordemos el problema, sólo hay que cambiar esto

```
# Encabezado 1 #
Lo que sea
## Encabezado 2 ##
Lo que sea
### Encabezado 3 ###
Lo que sea
```

... por esto ...

```
# Encabezado 1
Lo que sea
## Encabezado 2
Lo que sea
### Encabezado 3
Lo que sea
```

... en todos los archivos "*.md" dento de un directorio.

Antes de seguir adelante hay que tener en cuenta unas peculiaridades que tiene [Emacs] en lo que se refiere al manejo de expresiones regulares.
- Para definir un espacio en blanco → `\s-`
- Para definir un grupo → `\(...\)`

### Reemplazando en un archivo
Abriremos en un buffer el archivo en el que queremos realizar el reemplazo e introduciremos el comando

```
M-x replace-regexp
```
- Cadena a buscar → `\(#+\s-\)\(.+\)\(\s-#+\)`
- Cadena a reemplazar → `\1\2`

### Reemplazar en varios archivos
Ahora vamos a usar [Dired] para seleccionar los archivos en los que queremos realizar la modificación. Abriremos [Dired] mediante el comando `C-x d` e indicando la ruta donde están los archivos a editar.

``` bash
  /home/sherlockes/prueba:
  total used in directory 16K available 76305356
  -rw-rw-r-- 1 sherlockes 360 mar 11 10:53 archivo_1.md
  -rw-rw-r-- 1 sherlockes 444 mar 12 11:44 archivo_2.md
  -rw-rw-r-- 1 sherlockes 444 mar 12 11:44 archivo_3.md
  -rw-rw-r-- 1 sherlockes 444 mar 12 11:44 archivo_4.txt
```
Para selecionar de forma automática todos los archivos "*.md" del directorio usaremos el comando `% m` y posteriormente introduciremos `.md$`.

> Tal y como se explica en el [artículo de Angel] es posible marcar los archivos con la letra `m` de uno en uno y desmarcar con la letra `u`. Para seleccionar todos los archivos de un directorio con el atajo `C-u t`.

``` bash
  /home/sherlockes/Descargas/tmp:
  total used in directory 16K available 76305356
* -rw-rw-r-- 1 sherlockes 360 mar 11 10:53 archivo_1.md
* -rw-rw-r-- 1 sherlockes 444 mar 12 11:44 archivo_2.md
* -rw-rw-r-- 1 sherlockes 444 mar 12 11:44 archivo_3.md
  -rw-rw-r-- 1 sherlockes 444 mar 12 11:44 archivo_4.txt
```

Ahora para realizar el reemplazo de las cadenas introduciremos el comando

```
M-x dired-do-query-replace-regexp
```

- Cadena a buscar → `\(#+\s-\)\(.+\)\(\s-#+\)`
- Cadena a reemplazar → `\1\2`

Realizaremos todos los reemplazos pulsando la tecla `Y` y posteriormente guardaremos los cambios mediante el comando `C-x s`.

### Reemplazando en varios archivos de forma recursiva
¿Que pasa si no todos los archivos en los que necesitamos realizar la busqueda y reemplazo están en la misma carpeta sino que se encuentran en distintos dubdirectorios? [Dired] ya no es capaz de realizar esta función por lo que tenemos que dar un paso más alla y utilizar el paquete [Dired+] que en el apartado siguiente explico como instalar en [Emacs].

diredp-mark-files-regexp-recursive 


### Instalando Dired+
Para instalar [Dired+] en [Emacs] sólo hay que descargar la librería "[dired+.el]" y añadir las siguiente líneas a nuestro archivo de configuración ".emacs"

``` lisp
(add-to-list 'load-path "~/dotfiles/emacs/.emacs.d/dired+/")
(load "dired+.el")
(require 'dired+)
```

> En mi caso tengo ubicados los archivos de configuración dentro de la carpeta "dotfiles" y es ahí donde he guardado la librería. En posible guardarlo en otro sitio cambiando también la ruta en el archivo de configuración.

``` lisp
diredp-do-query-replace-regexp-recursive
```
- Cadena a buscar → `\(#+\s-\)\(.+\)\(\s-#+\)`
- Cadena a reemplazar → `\1\2`

![image-01]

### Enlaces de interés
- [StackOverflow - Install *.el package on Emacs](https://stackoverflow.com/questions/6400447/how-to-install-a-emacs-plugin-many-times-its-a-el-file-on-windows-platform)
- [Emacs StackExchange - Query replace](https://emacs.stackexchange.com/questions/26602/query-replace-on-directory)

[artículo de Angel]: https://ugeek.github.io/blog/post/2022-03-08-reemplazar-texto-de-uno-o-varios-archivos-con-dired-en-emacs.html
[Dired]: https://www.emacswiki.org/emacs/DiredMode
[Dired+]: https://www.emacswiki.org/emacs/DiredPlus
[dired+.el]: https://www.emacswiki.org/emacs/download/dired%2b.el
[Emacs]: https://www.gnu.org/software/emacs/
[imposible]: {{< relref "20211230_bash_find_sed_regex.md" >}}


[image-01]: /images/20220311_emacs_replace_regexp_01.jpg
[image-02]: /images/20220311_emacs_replace_regexp_02.jpg
[image-03]: /images/20220311_emacs_replace_regexp_03.jpg
[image-04]: /images/20220311_emacs_replace_regexp_04.jpg
[image-05]: /images/20220311_emacs_replace_regexp_05.jpg
[image-06]: /images/20220311_emacs_replace_regexp_06.jpg
[image-07]: /images/20220311_emacs_replace_regexp_07.jpg
[image-08]: /images/20220311_emacs_replace_regexp_08.jpg
[image-09]: /images/20220311_emacs_replace_regexp_09.jpg
