---
title: "Mi archivo de configuración en Emacs"
date: "2023-08-15"
creation: "2022-04-03"
description: "Así es la forma en la que tengo configuraco Emacs"
thumbnail: "images/20220403_emacs_archivo_configuracion_00.jpg"
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
**Actualización:** El archivo "init.el" se me está haciendo grande y ahora me apoyo en un "functions.el" y en una comprobación de paquetes en el arranque.
Hay pocas cosas tan personales en informática como la configuración de [Emacs]. En mi caso uso una combinación de `.emacs` e `init.el` de la que seguro puedes sacar algo que aprender.
<!--more-->

Tal y como dejé reflejado en un [artículo] anterior, tengo mis archivos de configuración en la carpeta "dotfiles". Durante un tiempo me ha funcionado este método sin mayores problemas hasta que la instalación de un paquete ha requerido la compilación del mismo para adaptarlo al hardware de la máquina. En este momento nos encontramos con que los archivos de la carpeta de configuración son distintos para las distintas máquinas y no tiene sentido compartirlos. Por esto, ahora sólo comparto
- "init.el" como archivo principal de configuración
- "functions.el" como archivo auxiliar de funciones
- "snippets" como la carpeta donde ubico la configuración personalizara de Yasnippet

En cada arranque de [Emacs] se comprobará si cada uno de los paquetes que utilizo están instalados en el equipo mediante la función "my-install-package-if-not-installed"

``` lisp
(defun my-install-package-if-not-installed (package)
  "Instala el paquete PACKAGE si no está instalado."
  (unless (featurep package)
    (unless (package-installed-p package)
      (message "Instalando el paquete '%s'..." package)
      (package-refresh-contents)
      (package-install package)
      (message "Paquete '%s' instalado." package))))
```
	  

Para que [Emacs] sea consciente de donde se ubica el archivo principal de configuración al abrir, en la carpeta raíz del usuario tengo alojado el archivo ".emacs" con el siguiente contenido:

``` lisp
(setq user-dir (expand-file-name "~"))
(setq user-init-file (concat user-dir "/dotfiles/emacs/.emacs.d/init.el"))
(load user-init-file)
```

Estas tres líneas simplemente declaran la variable "user-dir" como la ruta a la carpeta del usuario activo y "user-init-file" como la ruta al archivo principal de configuración. Posteriormente carga el archivo de configuración principal "init.el"

{{< texto_remoto "https://raw.githubusercontent.com/sherlockes/SherloScripts/master/elisp/init.el" >}}

Seguro que no están aquí todas tus necesidades ni necesitas todo lo que está aquí, pero el archivo está suficientemente comentado para que puedas extraer de el todo lo que necesites.

> El archivo se actualiza diariamente de mi [repositorio en GitHub] y así se [incrusta en el blog].

### Enlaces de interés
- [enlace](www.sherblog.pro)

[Emacs]: https://www.gnu.org/software/emacs/
[artículo]: {{< relref "20210416_dotfiles.md" >}}
[incrusta en el blog]: {{< relref "20210421_hugo_incrustar_texto.md" >}}
[repositorio en GitHub]: https://github.com/sherlockes/SherloScripts/blob/master/elisp/init.el



