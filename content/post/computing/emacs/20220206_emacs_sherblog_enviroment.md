---
title: "Entorno de desarrollo de Sherblog en Emacs"
date: "2022-12-17"
creation: "2022-02-06"
description: "Emacs sherblog enviroment"
thumbnail: "images/20220206_emacs_sherblog_enviroment_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
- "hugo"
tags:
- "bash"
- "emacs"
draft: false
weight: 5
---
Por mucho que podamos pensar "sólo cuesta dos minutos", resulta más productivo invertir una hora en preparar una función para poder acomodar [Emacs] como entorno de desarrollo del blog con una sola tecla que tener que hacerlo a mano cada una de las veces que lo necesitemos.
<!--more-->

Para trabajar en cada uno de los post que escribo desde [Emacs] tengo la pantalla partida en tres ventanas, dos a la izquierda, una con un buffer de Dired y el contenido del blog y otra con una sesión de terminal en la carpeta raíz del blog para lanzar el servidor de [Hugo]. A la derecha pongo una ventana con todo el alto de pantalla para editar el post en el que estoy trabajando tal y como se puede ver en la siguiente imagen.

![image-01]

Antes de seguir adelante hay que tener en cuenta unas consideraciones particulares sobre la configuración de mi sistema.
- El blog está guardado en un repositorio sincronizado con [GitHub] en la Raspberry a la la que accedo a través de ssh a la IP 192.168.10.202
- El servidor de [Hugo] está en la misma Raspberry
- En esta Raspberry tengo configurado el alias "hugoser" para lanzar el servidor de [Hugo] con todos los parámetros necesarios para que publique también los borradores desde la IP de la Raspberry y nos lleve directamente al archivo modificado en lugar de tener que navegar hasta el.

``` bash
alias hugoser="hugo server -D --bind=192.168.10.202 --baseURL=http://192.168.10.202:1313 --navigateToChanged
```

En el archivo de configuración ".emacs" he incluido una función que para conseguir la disposición de este entorno de desarrollo realiza los siguientes comandos:
- Cierra todos los buffers
- Elimina todas las ventanas
- Divide el entorno de [Emacs] en lado izquierdo y derecho
- Parte la ventana izquierda en superior e inferior
- Asigna el directorio por defecto al del repositorio del Blog
- En la ventana superior izquierda abre una sesión de terminal y lanza el comando "hugoser"
- En la ventana inferior abre un [Dired] al contenido del blog
- Abre el navegador del sistema con la dirección del servidor de [Hugo]
- Asigna la tecla "F4" a la función "sherblog_edit" que realiza todo lo anterior

``` lisp
(defun sherblog_edit ()
  (interactive)
  (mapc 'kill-buffer (buffer-list))
  (delete-other-windows nil)
  (split-window-right 80)
  (split-window-below)
  (setq default-directory "/ssh:pi@192.168.10.202:/home/pi/sherblog/")
  (comint-send-string (shell) "hugoser\n")
  (other-window 1)
  (dired "/ssh:pi@192.168.10.202:/home/pi/sherblog/content/post/")
  (enlarge-window 10)
  (browse-url "http://192.168.10.202:1313")
)

(global-set-key (kbd "<f4>") 'sherblog_edit)
```

Y con esto, una vez que tenemos abierto [Emacs] sólo hay que pulsar "F4" para que el entorno se configure automáticamente. No es el entorno de desarrollo más bonito del mundo pero es increíblemente práctico.

### Enlaces de interés
- [StackOverflow - Default folder in Emacs](https://stackoverflow.com/questions/60464/changing-the-default-folder-in-emacs)
- [StackOverflow - Shell in current Emacs window](https://stackoverflow.com/questions/19707018/emacs-open-another-shell-in-current-window)
- [Superuser - Open remote shell in emacs](https://superuser.com/questions/841178/directly-open-remote-shell-with-tramp-in-emacs)
- [Gnu - Windows in Emacs](https://www.gnu.org/software/emacs/manual/html_node/emacs/Windows.html)
- [EmacsWiki - Windows resizing](https://www.emacswiki.org/emacs/WindowResize#h5o-3)

[Dired]: https://www.emacswiki.org/emacs/DiredMode
[Emacs]: https://www.gnu.org/software/emacs/
[GitHub]: https://github.com
[Hugo]: https://gohugo.io


[image-01]: /images/20220206_emacs_sherblog_enviroment_01.jpg
