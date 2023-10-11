---
title: "Emacs desde cero"
date: "2022-03-15"
creation: "2018-09-26"
description: "Aquí iré documentando mi experiencia con este impresionante editor de texto.."
thumbnail: "images/titulo_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Varios"
tags:
  - "emacs"
draft: true
weight: 5
---
[Emacs] es una aplicación fea, nada intuitiva y con una curva de aprendizaje muy pronunciada, a cambio te ofrece un completo entorno de trabajo con infinidad de posibilidades. Hace casi cuatro años que empecé a escribir este artículo, ahora me decido a terminarlo cansado de verlo en mi lista de artículos en borrador a pesar de que sigo aprendiendo algo sobre [Emacs] cada día.
<!--more-->
### Emacs, sólo un editor de texto?
Caí en el uso de [Emacs] como editor de texto pero con el tiempo me he dado cuenta de que esta cualidad solo es la "punta del iceberg" ya que lo he terminado usando también para realizar conexiones remotas, navegar entre directorios, entorno de desarrollo y la única aplicación que necesito para gestionar este blog.

Es gratis, es libre y me ofrece un entorno de trabajo sin distracciones con el que estoy encantado.

pepe es

#### Que necesito?
* [Descargar aquí] la aplicación.
* Ver los vídeos del Canal de [Emacx] en Youtube.
* Algo de tiempo, perseverancia y paciencia

### Donde está el problema?
Emacs es una de esas aplicaciones que cuando las abres te parece que no van a ser capaces de hacer nada pero que a medida que vas profundizando en ellas te das cuenta de la increíble potencia que presentan.  Una interface que parece de finales de los ochenta y un tutorial en la ventana de inicio son dos de las cualidades que echan para atrás a casi cualquiera.

Pero lo que sin duda alguna es el gran impedimento para trabajar con Emacs es su curva de aprendizaje increíblemente lenta al principio por culpa de un flujo de trabajo completamente diferente al resto de aplicaciones y la infinidad de atajos de 
teclado que hay que hay que aprender para conseguir una productividad “digna”.

## Lo que he aprendido

### Personalizando Emacs
 * Añadiendo capacidad para sintaxis MarkDown `sudo apt install elpa-markdown-mode`

### Comandos genéricos
F11 ; pantalla completa
C-x C-c ; Cierra Emacs
C-g ; Cancelar un comando

### Ventanas
C-x 0 ; Elimina la ventana actual
C-x 1 ; Elimina todas ventanas menos la actual
C-x 2 ; Crea una ventana horizontal
C-x 3 ; Crea una ventana vertical
C-x o ; Cambiar de ventana

### Buffer
C-x k ; Cierra el buffer actual
M-x ; Activa el minibuffer
C-x -> ; avanza un buffer
C-x <- ; retrocede un buffer
C-x b ; Cambia de buffer
C-x C-f ; Crea un buffer / visita un archivo
C-x C-w ; Renombra un archivo
C-x C-s ; Guarda los cambios
C-h i ; Muestra la zona de manuales
C-x C-q ; Pone el buffer en modo de solo lectura

### Edición de texto
M-w ; Copiar un texto
C-y ; Pegar un texto
C-w ; Cortar un texto
C-spc ; Marcar
M-d ; Borra una palabra
C-s ; Busca un texto hacia adelante
C-r ; Busca un texto hacia atrás
M-% ; Buscar y reemplazar una palabra ("y"si, "n"no,  "!"todas)


#### Comandos del minibuffer
shell ; Lanza una terminal
menu-bar-mode ; oculta la barra de menú
tool-bar-mode ; oculta la barra de herramientas
customize-theme ; configuración del tema
eval-buffer ; evalúa el contenido del buffer activo
ido-mode ; Activa el modo ido
customize ; Entra al modo de configuración de Emacs
package-list-packages ; lista los paquetes instalados

[Emacs]: https://www.gnu.org/software/emacs/
[Emacx]: https://www.youtube.com/playlist?list=PLxGJqI9jxu_iWOJt_GqpWKq5STAZVA4rn
[Descargar aquí]: https://www.gnu.org/software/emacs/download.html
[12]: https://github.com/farliz/emacs-academia/blob/master/contenido.md
[13]: /files/emacs-academia-farliz.xspf
[14]: https://www.videolan.org/vlc/index.es.html
