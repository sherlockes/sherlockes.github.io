---
title: "Plantillas de archivos en Emacs"
date: "2022-04-03"
creation: "2022-03-31"
description: "Emacs templates"
thumbnail: "images/20220331_emacs_templates_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "lisp"
draft: false
weight: 5
---
La parte que más pereza me daba al necesitar desarrollar un script para realizar una automatización era la de crear el archivo, poner la cabecera y hacerlo ejecutable. Gracias a [Emacs] todo este proceso se realiza automáticamente sin más que crear el archivo.
<!--more-->

Lo que pretendo es crear un par de plantillas, una para los scripts en Bash que hasta ahora vengo haciendo con el copiar y pegar tradicional y otra para los post del blog que hasta ahora hago mediante el uso de [arquetipos].

Vamos a utilizar en modo [Auto Insert] para detectar cuando se ha creado un nuevo archivo y [Yasnippet] como sistema de plantillas para introducir el nuevo contenido. Activaremos ambos modos, un directorio para almacenar las plantillas y el modo "silencioso" de incluirlas en el archivo. En el archivo de configuración de [Emacs] añadiremos lo siguiente:

``` lisp
(require 'yasnippet)
(yas-global-mode 1)

(auto-insert-mode)
(setq auto-insert 'other)
(setq auto-insert-directory "~/dotfiles/templates/")
(setq auto-insert-query nil)
```

Para el caso de los scripts es bash va a resultar sencillo, ya que cualquier archivo que se cree con la extensión "*.sh" supondremos que es un script. Para el caso de los post del blog es un poco más delicado, ya que no sólo vale con que las extensión sea "*.md" sino que además, el nombre del archivo tendrá que empezar por una fecha del tipo a "20220403_lo_que_sea.md". Esto lo conseguimos gracias al uso de las fantásticas [Expresiones Regulares]. Con esto, la detección de creación de nuevos archivos con [Auto Insert] quedará así.

``` lisp
(setq auto-insert-alist '((("\\.sh\\'" . "Shell script") . ["template.sh" autoinsert-yas-expand])
    (("20[0-9]\\{6\\}_.+\\.md\\'" . "Markdown") . ["template.md" autoinsert-yas-expand])
))
```

> Lo más complicado es dar con el número de "\" que hace falta delante de determinados caracteres especiales cuando hacemos uso de ellas en [Emacs]

De esta forma, cuando se cree uno de los dos tipos de archivo se hará un llamamiento a la función "autoinsert-yas-expand" con la plantilla correspondiente como argumento. Esta función es la encargada a desplegar la plantilla mediante [Yasnippet] y además, en caso de que sea un script, convertirá el archivo en ejecutable.


``` lisp
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

Y con esto todo lo necesario para crear un determinado archivo de determinado tipo a partir de una plantilla, en otro post explicaré los distintos usos que hago de [Yasnippet] dentro de [Emacs]. Sólo hay que usar la combinación de teclas "C-x C-f" y, si el nombre del archivo que creemos coincide con una de las dos plantillas se hará la magia.

### Enlaces de interés
- [Emacs StackExchange - Template for new file](https://emacs.stackexchange.com/questions/45629/template-for-new-file)
- [EmacsWiki - Auto Insert Mode](https://www.emacswiki.org/emacs/AutoInsertMode)
- [EmacsWiki - Making scripts executable](https://www.emacswiki.org/emacs/MakingScriptsExecutableOnSave)
- [GNU - If expressions](https://www.gnu.org/software/emacs/manual/html_node/eintr/else.html)
- [StackOverFlow - Auto mode alist in Emacs](https://stackoverflow.com/questions/3494402/setting-auto-mode-alist-in-emacs)
- [Xahlee - Elisp string functions](http://xahlee.info/emacs/emacs/elisp_string_functions.html)

[Auto Insert]: https://www.emacswiki.org/emacs/AutoInsertMode
[arquetipos]: {{< relref "20220129_hugo_archetypes.md" >}}
[Emacs]: https://www.gnu.org/software/emacs/
[Expresiones Regulares]: https://www.emacswiki.org/emacs/RegularExpression#h5o-1
[Yasnippet]: https://www.emacswiki.org/emacs/Yasnippet


[image-01]: /images/20220331_emacs_templates_01.jpg
[image-02]: /images/20220331_emacs_templates_02.jpg
[image-03]: /images/20220331_emacs_templates_03.jpg
[image-04]: /images/20220331_emacs_templates_04.jpg
[image-05]: /images/20220331_emacs_templates_05.jpg
[image-06]: /images/20220331_emacs_templates_06.jpg
[image-07]: /images/20220331_emacs_templates_07.jpg
[image-08]: /images/20220331_emacs_templates_08.jpg
[image-09]: /images/20220331_emacs_templates_09.jpg
