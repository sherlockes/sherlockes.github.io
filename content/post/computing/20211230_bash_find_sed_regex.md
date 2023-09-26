---
title: "Buscar y reemplazar en bash con find y sed"
date: "2022-01-03"
creation: "2021-12-30"
description: "Como reemplazar el contenido de archivos en bash gracias a los comando find y sed usando expresiones regulares"
thumbnail: "images/20211230_bash_find_sed_regex_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: false
weight: 5
---
Después de varios años escribiendo artículos me doy cuenta de que para que [Hugo] funcione correctamente necesitamos escribir los encabezados sólo con almohadillas al principio y resulta que [Modo Markdown] de [Emacs] que utilizo para escribir lo hace con almohadillas al principio y al final. A ver como modifico ahora todos los archivos.
<!--more-->

El problema resulta sencillo, sólo hay que cambiar esto

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

Llevo dos días intentando resolver el problema sin salir de [Emacs] y he sido capaz de realizar el reemplazo de forma automática dentro de un archivo pero al hacerlo de forma recursiva me muestra un error para el que no he conseguido encontrar la solución.

Por esto opto por salir de [Emacs] y acudir a la consola de comandos de linux. En menos de una hora doy con una combinación de comandos (find y sed) con los que, gracias a las expresiones regulares arreglo lo que podían haber sido tediosas horas de modificar archivos a mano con un comando de una sola línea.

``` bash
find -name '*.md' -exec sed -i -E "s/(#+\s)(.+)(\s#+)/\1\2/g" {} +
```

Lo voy a separar en varias partes a ver si así se puede entender.

### Comando find
Esta parte es sencilla.

``` bash
find -name '*.md' -exec ELCOMANDOSED {} +
```

Dentro del directorio que ejecutemos el comando, buscará de forma recursiva archivos que se llamen "loquesea.md" y ejecutará para cada uno de ellos "ELCOMANDOSED". Las dos llaves "{}" le pasan al comando sed el set de resultados para que se ejecute sobre ellos y el delimitador "+" le indica al comando exec donde se terminan los argumentos.

### Comando sed
Antes de entrar en el funcionamiento de las expresiones regulares, veamos las partes de que está compuesto el comando sed
```
sed -i -E "s/RegexEntrada/RegexSalida/g"
```

- El argumento "-i" indica que se va a realizar la edición sobre el propio archivo
- El argumento "-E" indica que vamos a hacer uso de expresiones regulares
- La "s" delante de las Regexp indica que se va a realizar una sustitución
- La "g" detrás de las Regexp indica que la sustitución va a ser global

#### Reggexp de entrada
Estamos buscando una expresión del tipo
```
### Lo que sea ###
```
que está dividido en tres grupos:
- G1. Una o mas almohadillas seguidas de un espacio: (#+\s)
- G2. Un número indeterminado de caracteres: .+
- G3. Un espacio seguido de una o más almohadillas: (\s#+)

En conjunto la expresión regular que estamos buscando será:

```
(#+\s)(.+)(\s#+)
```

### Regexp de salida
Queremos quitar el espacio en blanco y las almohadilas del final de cada apartado o, lo que es lo mismo, nos queremos quedar sólo con los grupos 1 y 2 por lo que la expresión regular quedará según lo siguiente:

```
\1\2
```

Y con esto ya está todo ejecutamos el comando completo en el directorio deseado y listo. Resulta impresionante ver como, para todos los artículos que tengo escritos, la ejecución sólo le ha costado un "parpadeo".

### Enlaces de interés
- [Linuxize - Buscar y reemplazar con sed](https://linuxize.com/post/how-to-use-sed-to-find-and-replace-string-in-files/)
- [DevHints - Regexp Cheatsheet](https://devhints.io/regexp)
- [StackOverflow - Buscar y reemplazar con sed y regexp](https://stackoverflow.com/questions/15287862/find-and-replace-using-regex-in-sed)
- [Exponente Web - Buscar y reemplazar en la shell](https://exponenteweb.wordpress.com/2010/10/15/como-buscar-y-reemplazar-en-la-shell-de-linux/)

[Emacs]: https://www.gnu.org/software/emacs/
[Hugo]: https://gohugo.io
[Modo Markdown]: https://jblevins.org/projects/markdown-mode/

[image-01]: /images/20211230_bash_find_sed_regex_01.jpg
