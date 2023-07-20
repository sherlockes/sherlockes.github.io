---
title: "Creando scripts en Bash en Emacs"
date: "2023-03-10"
creation: "2023-01-28"
description: "Este el el flujo de trabajo a la hora de crear y comprobar el funcionamiento de los scripts que genero en Bash mediante Emacs."
thumbnail: "images/20230128_emacs_bash_script_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
- "emacs"
draft: true
weight: 5
---
Esta es la forma en la que utilizo [emacs] como entorno de trabajo para crear y comprobar el funcionamiento de los scripts en Bash que necesito sin utilizar más recursos que la propia aplicación.
<!--more-->
Tras partir la pantalla en dos ventanas verticales (C-x 3), el primer paso es crear el archivo para el script, utilizo Dired para ubicarme en la carpeta y directamente el comando `find-file` (C-x C-f) para crear el nuevo archivo que tendrá la extensión "*.sh".

Llegados a este punto [Yasnippet](https://github.com/joaotavora/yasnippet) y [Autoinsert](https://www.emacswiki.org/emacs/AutoInsertMode) hacen el resto tal y como expliqué en otro [artículo]({{<relref"20220331_emacs_templates.md">}}). Gracias a las líneas que aparecen a continuación en el archivo de configuración de [emacs] se genera un archivo con la plantilla correspondiente y se convierte el mismo en ejecutable.

```elisp
(setq auto-insert-alist '(
    (("\\.sh\\'" . "Shell script") . ["template.sh" autoinsert-yas-expand])
))

(defun autoinsert-yas-expand()
    "Reemplaza el texto en una plantilla de yasnippet."
    
    ;; Caso si es un Script
    (if (string-match "\.sh" (file-name-nondirectory buffer-file-name))
            (shell-command (concat "chmod u+x " buffer-file-name))
    )
    
    (yas/expand-snippet (buffer-string) (point-min) (point-max))
    (save-buffer)
)
```

Tal y como se puede ver en el archivo de la plantilla de abajo, se rellena automáticamente el nombre de script y la fecha de creación en la cabecera para dejarnos escribir la descripción y empezar a escribir el código.

```bash
#!/bin/bash

###################################################################
#Script Name: `(file-name-base)`.sh
#Description: ${1:Descripción}
#Args: N/A
#Creation/Update: `(insert (format-time-string "%Y%m%d"))`/`(insert (format-time-string "%Y%m%d"))`
#Author: www.sherblog.pro
#Email: sherblog@gmail.com
###################################################################

################################
####       Variables        ####
################################


################################
####      Dependencias      ####
################################


################################
####       Funciones        ####
################################


################################
####    Script principal    ####
################################

$0
```
Una vez que tenemos listo el script lo podemos ejecutar directamente desde [emacs] con el comando "executable-interpret" (C-c C-x) apareciendo el resultado en la otra ventana.

Para el caso de que estemos realizando la edición de un archivo en local, al pulsar "C-c C-x" nos aparecerá en la barra de comandos de [emacs] algo como lo siguiente.

```bash
Run script: /home/usuario/prueba.sh
```

Al pulsar "enter" es posible que nos pregunte si queremos guardar previamente el archivo y a continuación aparecerá el resultado del script en otra ventana

En el caso de que estemos realizando la edición de un archivo remoto que queremos ejecutar sobre la terminal remota , al pulsar "C-c C-x" nos aparecerá en la barra de comandos de [emacs] algo como lo siguiente.

```bash
Run script: /ssh:usuario@192.168.10.202:/home/usuario/prueba.sh
```
Al ejecutar el comando nos aparece un error

``` bash
-*- mode: compilation; default-directory: "/ssh:usuario@192.168.10.202:/home/usuario/" -*-
Comint started at Fri Mar 10 12:11:53

/ssh:usuario@192.168.10.202:/home/usuario/prueba.sh
/bin/sh: 2: /ssh:usuario@192.168.10.202:/home/usuario/prueba.sh: not found

Comint exited abnormally with code 127 at Fri Mar 10 12:11:53
```

La solución pasa por eliminar la referencia a la conexión ssh antes de ejecutar el script de forma que el comando se quedará según lo siguiente exactamente igual que en el caso de un archivo local:

```bash
Run script: /home/usuario/prueba.sh
```


![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[emacs]: https://www.gnu.org/software/emacs/

[image-01]: /images/20230128_emacs_bash_script_01.jpg



