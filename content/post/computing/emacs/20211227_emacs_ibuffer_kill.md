---
title: "Cerrar buffers abiertos en Emacs con ibuffer"
date: "2021-12-27"
creation: "2021-12-27"
description: "Un método rápido y efectivo para cerrar de un paso todos los buffers que ya no necesite en Emacs"
thumbnail: "images/20211227_emacs_ibuffer_kill_00.jpg"
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
Uno de los problemas con que te puedes encontrar al trabajar con Emacs es la navegación entre buffers cuando tienes muchos abiertos. Aquí dejo la forma que estoy utilizando para cerrar de una vez todos los que ya no necesites.
<!--more-->
Antes de nada, a nuestro archivo de configuración añadiremos la línea

``` lisp
(global-set-key (kbd "C-x C-b") 'ibuffer)
```

Para que cuando usemos esta combinación de teclas (C-x C-b) se active el modo ibuffer para gestionar la lista de buffers abiertos de forma que aparecerá algo como lo siguiente:

``` lisp
 MRL Name                    Size Mode             Filename/Process
 --- ----                    ---- ----             ----------------
[ Default ]
     20210707_donaci...       837 Markdown         ~/Google_Drive/Sherblog/content/post/20210707_donaciones.md
  %  post                    1584 Dired/name 16/20 ~/Google_Drive/Sherblog/content/post/
 *   20211227_emacs_...      1206 Markdown         ~/Google_Drive/Sherblog/content/post/20211227_emacs_ibuffer_kill.md
 *%  *Messages*               820 Messages         
 *%  *Completions*            820 Completion List  

     5 buffers               5267                  3 files, no processes
```
En este modo el manejo es muy parecido al modo Dired que vimos en este [post]({{<relref"20190618_emacs_dired.md">}}) y hay cantidad de opciones pero hoy nos vamos a centrar únicamente en como cerrar varios buffers al mimo tiempo para lo que hay dos métodos.

### Seleccionar y borrar
No colocaremos encima de la línea correspondiente al buffer a cerrar y pulsaremos "m" para seleccionarlo. Repetimos el paso para todos los buffers que queremos cerrar y finalmente pulsamos "D" para cerrarlos.

### Marcar para borrar y borrar
El método es muy parecido al anterior solo que en este caso marcaremos para borrar los buffers que necesitemos mediante la tecla "d" y efectuaremos el borrado mediante la tecla "x"

> En ambos casos hay que confirmar el borrado mediante la tecla "y"

### Ocultando la columna "Filename/Process"
Si no trabajas con un ancho de buffer muy grande es posible que mara mostrar la información de un buffer se tengan que utilizar dos líneas distintas tal y como se puede ver en el ejemplo de arriba. Es posible elimnar la columna "Filename/Process" para que la info quede mucho más clara.

Para esto personalizaremos la variable "ibuffers-formats" (C-h v ibuffers-formats) y eliminaremos de la primera expresión lisp lo siguiente:

```
 " " filename-and-process
```

> Para que no se corte el ancho del nombre lo podemos aumentar también de 18 a 48

Con esto, en el archivo de configuración de emacs, dentro de las variables personalizadas habrá quedado algo como lo siguiente:

``` lisp
 '(ibuffer-formats
   (quote
    ((mark modified read-only locked " "
	   (name 48 48 :left :elide)
	   " "
	   (size 9 -1 :right)
	   " "
	   (mode 16 16 :left :elide))
     (mark " "
	   (name 16 -1)
	   " " filename))))
```

y al refrescar el ibuffer con la tecla "g" veremos como ha quedado mucho más limpio.

``` lisp
 MRL Name                                                  Size Mode            
 --- ----                                                  ---- ----            
[ Default ]
  %  computing                                             3941 Dired/name 50/50
     20211227_emacs_ibuffer_kill.md                        4475 Markdown        
     *scratch*                                              145 Lisp Interaction
 *%  *Messages*                                             785 Messages        
  %  post                                                  1584 Dired/name 19/20

     5 buffers                                            10930            
```


### Enlaces de interés
- [Emack Wiki - Ibuffer Mode](https://www.emacswiki.org/emacs/IbufferMode)
- [Emacs Stackexchange - Ibuffer symbols](https://emacs.stackexchange.com/questions/47836/what-do-d-mean-in-ibuffer-buffer)
- [Emacs Stackexchange - Hide Ibuffer columns](https://emacs.stackexchange.com/questions/37229/ibuffer-hide-columns)
