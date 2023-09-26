---
title: "Exportar Org-Roam a Hugo en Gitlab"
date: "2023-09-15"
creation: "2023-09-15"
description: "Aquí dejo descrito todo el proceso de exportación de org-roam a Hugo en Gitlab"
thumbnail: "images/20230915_orgroam_to_hugo_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "computing"
tags:
- "emacs"
- "hugo"
- "ox-hugo"
- "markdown"
- "git"
draft: false
weight: 5
---
Creo que todavía no he hablado de [Org-Roam] aunque, antes de se me olviden algunos pasos voy a dejar descrito todo el proceso de exportación a una web estática en [Gitlab] mediante [Hugo].
<!--more-->
### Crear y clonar el repositorio
El primer paso es crear un repositorio/proyecto en blanco en [Gitlab] al que le pondremos de nombre "usuario.gitlab.io". De esta forma posteriormente podremos acceder a la web que creemos mediante "https://usuario.gitlab.io"
 
>Olvídate de las plantillas más específicas a la hora de crear el nuevo proyecto, me han dado más problemas.

![image-01]

A continuación clonaremos mediante el comando `git clone git@gitlab.com:usuario/usuario.gitlab.io.git` el repositorio en nuestro equipo. Importante realizar esta clonación mediante el método "ssh" si no queremos tener problemas en la actualización automática posterior.

![image-02]

### Estructura de carpetas
El siguiente paso, con [Hugo] intalado en nuestro sistema, generaremos una nueva web mediante el comando `hugo new site usuario.gitlab.io` y copiaremos el contenido a la carpeta del repositorio que hemos clonado. Además crearemos la carpeta "content-org" que será donde ubiquemos las notas en formato [Org-Mode] que conforman nuestra base de conocimiento de [Org-Roam].

> No voy aquí a entrar en detalle sobre el funcionamiento de [Org-Roam] será motivo de otro artículo.

``` bash
  /home/sherlockes/sherlockes.gitlab.io:
  total used in directory 52K available 52.4 GiB
  drwxrwxr-x  2 sherlockes 4,0K ago 30 11:14 archetypes
  drwxrwxr-x  4 sherlockes 4,0K ago 30 11:14 archive
  drwxrwxr-x  3 sherlockes 4,0K sep 11 11:44 content
  drwxrwxr-x  3 sherlockes 4,0K sep 15 12:00 content-org  <- Aquí va la base de conocimiento
  drwxrwxr-x  7 sherlockes 4,0K sep  6 23:44 layouts
  drwxrwxr-x 12 sherlockes 4,0K sep 14 19:42 public
  drwxrwxr-x  4 sherlockes 4,0K ago 30 23:17 resources
  drwxrwxr-x  6 sherlockes 4,0K sep 14 19:49 static
  drwxrwxr-x  3 sherlockes 4,0K ago 30 11:14 themes
  -rw-rw-r--  1 sherlockes   72 ago 30 11:14 README.md
  -rw-rw-r--  1 sherlockes 2,2K sep 14 19:42 config.toml
```

### Construyendo la web
Ahora crearemos en la raíz de nuestro repositorio clonado una archivo ".gitlab-ci.yml" con el siguiente contenido y subiremos los cambios.

``` yaml
# The Docker image that will be used to build your app
image: registry.gitlab.com/pages/hugo/hugo:latest
pages:
  script:
    - hugo
  artifacts:
    paths:
      # The folder that contains the files to be exposed at the Page URL
      - public
  rules:
    # This ensures that only pushes to the default branch will trigger
    # a pages deploy
    - if: $CI_COMMIT_REF_NAME == $CI_DEFAULT_BRANCH
```

> Subir el contenido actualizado del repositorio se hace menos tedioso gracias a una línea en el archivo "~/.bashrc" con lo siguiente: `alias gitup="git add . && git commit -m 'Update' && git push"`. Con esto para actualizar el repositorio sólo necesitaremos ejecutar el comando `gitup` dentro de la carpeta del mismo tal y como explico en este [artículo]({{< relref"20220212_alias_bash.md" >}}).

Si todo ha ido bien, en la pestaña "Pipelines" dentro del apartado "Build" de nuestro repositorio podremos ver algo omo lo siguiente.

![image-03]

Si la construcción de la web falla toca investigar...

### Configurando Org-Roam

En mi sistema, las notas que conforman [Org-Roam] están en la carpeta "~/sherlockes.gitlab.io/content-org" para lo cual tendré que definirlo en el archivo "init.el" de [Emacs] de la siguiente forma

``` elisp
(setq user-dir (expand-file-name "~"))
(setq brain-dir (concat user-dir "/sherlockes.gitlab.io/"))
(setq brain-roam-dir (concat brain-dir "content-org")) 
(setq org-roam-directory (file-truename brain-roam-dir))
(org-roam-db-autosync-mode)
```

Ahora necesitamos que al abrir [Emacs] se descarguen los cambios del repositorio remoto antes de realizar ninguna modificación para lo cual comprobamos si existe el directorio "~/sherlockes.gitlab.io", no creamos si no es así y descargamos los cambios.

``` elisp
(if (file-exists-p "~/sherlockes.gitlab.io/")
    (let ((default-directory "~/sherlockes.gitlab.io"))(shell-command "git pull"))
  (let ((default-directory "~/"))(shell-command "git clone git@gitlab.com:sherlockes/sherlockes.gitlab.io.git"))
)
```

No es menos importante que tras realizar cambios estos se suban al repositorio remoto para lo cual utilizo un "hook" que se ejecuta después de modificar cualquier archivo de la carpeta "~/sherlockes.gitlab.io" llamando a la función "funcion-al-guardar". Esta función exporta el archivo en caso de que sea del tipo "*.org" y se encarga de actualizar el repositorio remoto gracias al alias "gitup".

> Para permitir que desde el comando "shell-comand" se llame a un alias declarado en ".bashrc" hay que incluir en el archivo "init.el" una línea con el comando `(setq shell-command-switch "-ic")`

``` elisp
(defun funcion-al-guardar ()
  (interactive)
  (if (string= (file-name-extension buffer-file-name) "org")
    (org-hugo-export-wim-to-md :all-subtrees))

  (let ((default-directory "~/sherlockes.gitlab.io"))
    (shell-command "gitup")
  )
)

(add-hook 'after-save-hook (lambda () (when (and buffer-file-name (string-prefix-p brain-dir buffer-file-name))(funcion-al-guardar))))
```

### Exportando las notas en org
Es ahora cuando [Emacs] empieza a trabajar ya que tenemos todas las notas en formato "*.org" que tenemos que cambiar a "*.md" con el formato de Hugo para lo cual vamos a usar [Ox-Hugo] que instalaremos en [Emacs] como cualquier otro paquete de [Melpa].

A la cabecera de la nota generada en [Org-Roam] le tendremos que añadir unos cuantos campos para que la exportación se realiza correctamente. Estos son los que yo utilizo.

``` markdown
#+date: <2023-08-30>
#+hugo_custom_front_matter: :thumbnail "images/ox-hugo.png"
#+setupfile: ./setup.conf
#+hugo_tags: ox-hugo
#+hugo_categories: emacs
#+hugo_draft: false
```

Además, en el mismo directorio que la nota está el archivo de configuración "setup.conf" con el resto de parámetros, los que son comunes, de la exportación. El contenido del archivo es el siguiente.

``` markdown
# -*- mode: org; -*-

#+author: Sherlockes
#+hugo_section: notas
#+hugo_base_dir: ../
#+hugo_weight: 5
#+hugo_auto_set_lastmod: t
#+hugo_custom_front_matter: :toc true
```

Con todo esto correctamente configurado, al crear o modificar una de las notas de nuestra base de conocimiento en [Org-Roam], tras guardarla se realizarán las siguientes acciones:

 - [Emacs] se encarga de exportar el contenido de la nota a [Markdown] mediante [Ox-Hugo].
 - [Emacs] ejecuta el alias "gitup" de bash para actualizar el repositorio remoto.
 - [Gitlab] construye la web mediante el contenedor de [Hugo]
 - [Gitlab] nos muestra la web actualizada en http://sherlockes/gitlab.io

El sistema, aunque algo complejo de explicar, ha quedado es su funcionamiento extremadamente sencillo. Quedan muchos flecos por tratar pero creo que es una buena aproximación a como tengo montado mi sistema.

[Emacs]: https://www.gnu.org/software/emacs/
[Gitlab]: https://gitlab.com
[Hugo]: https://gohugo.io
[Markdown]: https://www.markdownguide.org
[Melpa]: https://melpa.org/#/ox-hugo
[Org-Mode]: https://orgmode.org
[Org-Roam]: https://www.orgroam.com
[Ox-Hugo]: https://ox-hugo.scripter.co

[image-01]: /images/20230915_orgroam_to_hugo_01.jpg
[image-02]: /images/20230915_orgroam_to_hugo_02.jpg
[image-03]: /images/20230915_orgroam_to_hugo_03.jpg

