---
title: "Comprobación ortográfica en Emacs"
date: "2023-07-22"
creation: "2023-07-22"
description: "Este el el uso que hago de la comprobación ortográfica en Emacs"
thumbnail: "images/20230722_emacs_spell_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "emacs"
draft: true
weight: 5
---
Por defecto, Emacs no realiza comprobación ortográfica de nuestro documentos. Hay que realizar una configuración previa que el lo que aquí paso a mostrar.
<!--more-->
Estoy probando

```bash
apt install ispell
apt install aspell-es
```

```elisp
(setq ispell-dictionary "espanol")

(add-hook 'markdown-mode-hook 'flyspell-mode)
(add-hook 'flyspell-mode-hook 'flyspell-buffer)

(global-set-key (kbd "<f5>") 'flyspell-mode)
```

Gracias a este post de [Lázaro] 
```elisp
(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
	 (change (if (string= dic "espanol") "english" "espanol")))
    (ispell-change-dictionary change)
    ))
```

![image-01]

### Enlaces de interés
- [Terder is the byte - Spell in Emacs](https://www.tenderisthebyte.com/blog/2019/06/09/spell-checking-emacs/)
- [StackExchange - ispell to spanish](https://tex.stackexchange.com/questions/412611/changing-ispell-to-spanish-castellano-in-xubuntu)

[Lázaro]: https://elblogdelazaro.org/posts/2019-11-25-emacs-funcion-para-cambiar-entre-diccionarios/

[image-01]: /images/20230722_emacs_spell_01.jpg



