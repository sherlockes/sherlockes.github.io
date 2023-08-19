---
title: "Comprobación ortográfica en Emacs"
date: "2023-08-19"
creation: "2023-07-22"
description: "Este es el uso que hago de la comprobación ortográfica en Emacs"
thumbnail: "images/20230722_emacs_spell_00.jpg"
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
Por defecto, [Emacs] no realiza comprobación ortográfica de nuestro documentos. Hay que realizar una configuración previa que el lo que aquí paso a mostrar.
<!--more-->
Antes de nada, teniendo en cuenta que estoy realizando las pruebas en un entrono Debian, debemos tener instalado en nuestro ordenador "ispell" como aplicación que se encarga de la corrección ortográfica y "aspell-es" como diccionario español en base al cual realizar las correcciones. Los instalaremos con estos comandos.

```bash
apt install ispell
apt install aspell-es
```

Sólo necesito que la corrección se realice mientras escribo estos artículos, como siempre los escribo en markdown, añadiremos un "hook" para que la corrección arranque automáticamente cada vez que active un buffer en este formato. Para otras ocasiones en las que me puede resultar necesaria he guardado el uso de la tecla "F5" para activar manualmente la corrección.

En el archivo "[init.el]" incluiremos el siguiente código.

```elisp
(setq ispell-dictionary "espanol")

(add-hook 'markdown-mode-hook 'flyspell-mode)
(add-hook 'flyspell-mode-hook 'flyspell-buffer)

(global-set-key (kbd "<f5>") 'flyspell-mode)
```

Para rematar la funcionalidad y gracias a este post de [Lázaro] utilizo esta función para cambiar del diccionario castellano al inglés y viceversa sin más que pulsar F7 en el teclado.

```elisp
(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
	 (change (if (string= dic "espanol") "english" "espanol")))
    (ispell-change-dictionary change)
    ))
	
(global-set-key (kbd "<f7>") 'fd-switch-dictionary)
```


### Enlaces de interés
- [Terder is the byte - Spell in Emacs](https://www.tenderisthebyte.com/blog/2019/06/09/spell-checking-emacs/)
- [StackExchange - ispell to spanish](https://tex.stackexchange.com/questions/412611/changing-ispell-to-spanish-castellano-in-xubuntu)

[Emacs]: https://www.gnu.org/software/emacs/
[Lázaro]: https://elblogdelazaro.org/posts/2019-11-25-emacs-funcion-para-cambiar-entre-diccionarios/
[init.el]: https://github.com/sherlockes/SherloScripts/blob/master/elisp/init.el

[image-01]: /images/20230722_emacs_spell_01.jpg



