f---
title: "Como configurar emacs para trabajar con python"
date: "2020-10-20"
creation: "2020-10-20"
descrption: "Como configurar emacs para trabajar con python"
thumbnail: "/images/20201020_python_en_emacs_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "uncategorized"
tags:
  - "untagged"
draft: true
weight: 5
---
Aquí voy a ir escribiendo los pasos que doy para convertir Emacs en mi entorno de desarrollo para python.
<!--more-->

``` elisp
(my-install-package-if-not-installed 'elpy)
(elpy-enable)
(setq python-shell-interpreter "python3")
(setq elpy-rpc-python-command "python3")
(setq elpy-rpc-virtualenv-path (quote system))
```

https://linuxhint.com/configuring_emacs_python/
[Image_01]: /images/20201020_python_en_emacs_01.jpg
