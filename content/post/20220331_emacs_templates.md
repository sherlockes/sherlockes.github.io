---
title: "Plantillas de archivos en Emacs"
date: "2022-03-31"
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
draft: true
weight: 5
---
La parte que más pereza me daba al necesitar desarrollar un script para realizar una automatización era la de crear el archivo, poner la cabecera y hacerlo ejecutable. Gracias a [Emacs] todo este proceso se realiza automáticamente sin más que crear el archivo.
<!--more-->



``` lisp
(require 'yasnippet)
(yas-global-mode 1)

(auto-insert-mode)
(setq auto-insert 'other)
(setq auto-insert-directory "~/dotfiles/templates/")
(setq auto-insert-query nil)

(defun autoinsert-yas-expand()
    "Reemplaza el texto en una plantilla de yasnippet."
    
    ;; Caso si es un Post
    (if (string-match "20[0-9]+_.+\.md" (file-name-nondirectory buffer-file-name))
            (progn ; Lets you evaluate more than one sexp for the true case
                (message "Es un post!!!")
                (yas/expand-snippet (buffer-string) (point-min) (point-max))
            )
    )

    ;; Caso si es un Script
    (if (string-match "\.sh" (file-name-nondirectory buffer-file-name))
            (progn ; Lets you evaluate more than one sexp for the true case
                (message "Es un Script!!!")
                (yas/expand-snippet (buffer-string) (point-min) (point-max))
                (shell-command (concat "chmod u+x " buffer-file-name))
            )
    )
    (save-buffer)
)

;; Lanzadores de autoinsert
(setq auto-insert-alist '((("\\.sh\\'" . "Shell script") . ["template.sh" autoinsert-yas-expand])
    (("20[0-9]\\{6\\}_.+\\.md\\'" . "Markdown") . ["template.md" autoinsert-yas-expand])
))
```

reduciendo la función

``` lisp
(defun autoinsert-yas-expand()
    "Reemplaza el texto en una plantilla de yasnippet."
    
    ;; Caso si es un Script
    (if (string-match "\.sh" (file-name-nondirectory buffer-file-name))
            (progn ; Lets you evaluate more than one sexp for the true case
                (message "Es un Script!!!")
                (shell-command (concat "chmod u+x " buffer-file-name))
            )
    )
    
    (yas/expand-snippet (buffer-string) (point-min) (point-max))
    (save-buffer)
)
```

reduciendo más

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

![image-01]

### Enlaces de interés
- [Emacs StackExchange - Template for new file](https://emacs.stackexchange.com/questions/45629/template-for-new-file)
- [EmacsWiki - Auto Insert Mode](https://www.emacswiki.org/emacs/AutoInsertMode)
- [EmacsWiki - Making scripts executable](https://www.emacswiki.org/emacs/MakingScriptsExecutableOnSave)

[Emacs]: https://www.gnu.org/software/emacs/


[image-01]: /images/20220331_emacs_templates_01.jpg
[image-02]: /images/20220331_emacs_templates_02.jpg
[image-03]: /images/20220331_emacs_templates_03.jpg
[image-04]: /images/20220331_emacs_templates_04.jpg
[image-05]: /images/20220331_emacs_templates_05.jpg
[image-06]: /images/20220331_emacs_templates_06.jpg
[image-07]: /images/20220331_emacs_templates_07.jpg
[image-08]: /images/20220331_emacs_templates_08.jpg
[image-09]: /images/20220331_emacs_templates_09.jpg
