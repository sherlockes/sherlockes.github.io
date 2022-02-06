---
title: "Entorno de desarrollo de Sherblog en Emacs"
date: "2022-02-06"
creation: "2022-02-06"
description: "Emacs sherblog enviroment"
thumbnail: "images/20220206_emacs_sherblog_enviroment_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: true
weight: 5
---
Por mucho que "sólo cuesta dos minutos", resulta más productivo invertir una hora en preparar una función para poder acomodar [Emacs] como entorno de desarrollo del blog con una sola tecla que tener que hacerlo a mano cada una de las veces.
<!--more-->

Para trabajar en cada uno de los post que escribo desde [Emacs] tengo la pantalla partida en tres ventanas, dos a la izquierda, una con un buffer de Dired y el contenido del blog y otra con una seción de terminalen la carpeta raiz del blog para lanzar el servidor de [Hugo]. A la derecha pongo una ventana con todo el alto de pantalla para editar el post en el que estoy trabajando.

![image-01]

``` lisp
(defun sherblog_edit ()
  (interactive)
  (mapc 'kill-buffer (buffer-list))
  (delete-other-windows nil)
  (split-window-right 80)
  (split-window-below nil)
  (dired "/ssh:pi@192.168.10.202:/home/pi/sherblog/")
  (comint-send-string (get-buffer-process (shell)) "hugoser\n")
  (other-window -1)
  (kill-buffer)
  (dired "/ssh:pi@192.168.10.202:/home/pi/sherblog/content/post/")
  (browse-url "http://192.168.10.202:1313")
)

(global-set-key (kbd "<f4>") 'sherblog_edit)
```



### Enlaces de interés
- [enlace](www.sherblog.pro)

[Emacs]: https://www.gnu.org/software/emacs/
[Hugo]: https://gohugo.io


[image-01]: /images/20220206_emacs_sherblog_enviroment_01.jpg
[image-02]: /images/20220206_emacs_sherblog_enviroment_02.jpg
[image-03]: /images/20220206_emacs_sherblog_enviroment_03.jpg
[image-04]: /images/20220206_emacs_sherblog_enviroment_04.jpg
[image-05]: /images/20220206_emacs_sherblog_enviroment_05.jpg
[image-06]: /images/20220206_emacs_sherblog_enviroment_06.jpg
[image-07]: /images/20220206_emacs_sherblog_enviroment_07.jpg
[image-08]: /images/20220206_emacs_sherblog_enviroment_08.jpg
[image-09]: /images/20220206_emacs_sherblog_enviroment_09.jpg
