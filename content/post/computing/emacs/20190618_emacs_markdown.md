---
title: "Editando archivos markdown en emacs"
date: "2019-06-27"
creation: "2919-06-18"
description: "En mi lucha por utilizar cada día emacs, aquí dejo el modo en el que trabajo cuando edito archivo markdown"
thumbnail: "images/20190618_emacs_markdown_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "computing"
tags:
  - "markdown"
  - "emacs"
draft: false
weight: 5
---
En mi lucha por utilizar [Emacs] en todo mi usos con editor de texto aquí dejo reflejado como para editar archivos "Markdown" tiene muchas posibilidades.  No pretendo hacer una extensa guía, sólo los comandos que empleo habitualmente.
<!--more-->

## Instalación
La forma más común para trabajar con archivos en formato markdown dentro de [Emacs] la tenemos gracias a [Jason Blevins] por desarrolar el "Markdown-Mode".  La mejor forma de instalar este paquete es a través del repositorio de MELPA mediante la instrucción `M-x package-install RET markdown-mode RET` siempre y cuando tengamos el repositorio añadido en la configuración de emacs.

### Añadiendo capacidad de previsualización
#### Previsualización en el navegador
En mi caso bajo Linux Mint tengo instalado Pandoc en el sistema operativo mediante la instrucción de consola `sudo apt-get install pandoc` y posteriormente se edita la variable "markdown-command" introduciendo el siguiente comando:
```
"pandoc -f markdown -t html -s --mathjax --highlight-style=pygments"
```
> Recordar que la forma más sencilla de editar una variable es mediante el comando `C-h v`

A continuación podremos realizar una previsualización en el navegador mediante el comando <kbd>C-c C-c p</kbd>.

#### Previsualización en tiempo real
También podemos realizar una previsualización en tiempo real de lo que vamos escribiendo mediante el comando <kbd>C-c C-c l</kbd> o lo que sería "markdown-live-preview-mode".

> Antes de ejecutar el modo de previsualización en tiempo real sería interesante definir como queremos partir la pantalla si de forma vertical u horizontal para realizar esta previsualización. Para esta personalización deberemos editar la variable "markdown-split-window-direction"

![imagen_01]

Para cerrar el modo de previsualización en tiempo real volveremos a utilizar el comando <kbd>C-c C-c l</kbd>

Es una pena pero, por defecto, la actualización del buffer de previsualización no se lleva a cabo hasta que se guarda el archivo que estamos editando lo cual supone una pequeña pérdida de tiempo. Para evitar esto hay algunas soluciones que iré probando y cuando de con la que más me guste lo dejaré aquí reflejado.

#### Previsualización en un editor externo
En mi caso tengo instalado en el sistema Typora como editor específico para archivos markdown. Para poder abrirlos en este desde emacs hay que configurar la variable "markdown-open-command" con el comando:

```
"typora"
```
Ahora ya podemos abrir un archivo markdown en Typora mediante el comando <kbd>C-c C-c o</kbd>

Con todo lo anterior hemos modificado el archivo de configuración ".emacs" de forma que el apartado "custom-set-variables" se han incluido las siguientes líneas

```
 '(markdown-command "pandoc -f markdown -t html -s --mathjax --highlight-style pygments")
 '(markdown-open-command "typora")
 '(markdown-split-window-direction (quote right))
```

## Links e imágenes
Para añadir links dentro del texto tenemos el comando <kbd>C-c C-l</kbd> y para introducir imágenes <kbd>C-c C-i</kbd>, tras presionarlo podemos insertar la ruta del enlace o imagen o bien la referencia del mismo en caso de que agrupemos todos los enlaces e imágenes al final del archivo.

## Encabezados
 - <kbd>C-c C-s h</kbd> > Introduce un encabezado del mismo nivel que el anterior
 - <kbd>C-c C-s 3</kbd> > Introduce un encabezado del nivel que pongamos en el número

## Estilos de texto
 - <kbd>C-c C-s i</kbd> > Cursiva
 - <kbd>C-c C-s b</kbd> > Negrita
 - <kbd>C-c C-s c</kbd> > Código
 - <kbd>C-c C-s k</kbd> > Entrada de teclado
 - <kbd>C-c C-s q</kbd> > Inserta un comentario
 - <kbd>C-c C-s Q</kbd> > Convierte en comentario la última línea escrita
 - <kbd>C-c C-s -</kbd> > Inserta una líne horizontal


[Emacs]: https://www.gnu.org/software/emacs/
[Jason Blevins]: https://jblevins.org/projects/markdown-mode/

[imagen_01]: /images/20190618_emacs_markdown_01.jpg

