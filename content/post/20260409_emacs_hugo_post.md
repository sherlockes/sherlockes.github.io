---
title: "Creación de un post de Hugo desde emacs"
date: "2026-04-08"
creation: "2026-04-08"
description: "Automatizando al máximo los post de Hugo desde emacs gracias a esta configuración"
thumbnail: "images/20260409_emacs_hugo_post_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "emacs"
tags: 
- "yasnippet"
- "elisp"
- "autoinsert"
draft: true
weight: 5
---
Para centrarte en escribir, el reto no tiene que suponer una barrera. Así he configurado emacs para optimizar la creación de post para el blog.
<!--more-->


---
title: "Blogging nivel Pro: Emacs, Yasnippet y Metadatos Dinámicos"
date: "2025-01-23"
description: "Guía detallada para automatizar la creación de posts en Hugo extrayendo etiquetas y categorías en tiempo real."
categories:
  - "computing"
  - "linux"
tags:
  - "emacs"
  - "hugo"
  - "lisp"
  - "bash"
draft: false
---

Si gestionas un blog con **Hugo**, sabrás que mantener la consistencia de las etiquetas y categorías es un reto. Hoy vamos a configurar un flujo de trabajo en **Emacs** que hace todo el trabajo por nosotros, utilizando tres pilares: `auto-insert`, `yasnippet` y `Lisp`.

## El Flujo de Trabajo
El sistema funciona como una reacción en cadena:
1. **Creación**: Al crear un nuevo archivo `.md` en la carpeta de tu blog, Emacs activa `auto-insert`.
2. **Inyección**: `auto-insert` busca una plantilla física (`template.md`) y la inyecta en el buffer vacío.
3. **Expansión**: Inmediatamente, se llama a `yasnippet` para que procese el contenido.
4. **Inteligencia**: El código Lisp dentro de la plantilla ejecuta comandos de terminal para leer tus posts antiguos y ofrecerte tus categorías y etiquetas reales en un menú desplegable.

### 1. Configuración en `init.el`

Primero, preparamos a Emacs para que reconozca cuándo debe actuar y definimos el "cerebro" que extraerá la información de tus posts. En el archivo `init.el` tengo definido lo siguiente.

``` elisp
;; --- 1. ACTIVAR AUTO-INSERT ---
(auto-insert-mode 1)
(setq auto-insert-directory "~/dotfiles/templates/") ;; Carpeta de tus plantillas

;; Definimos la regla: si el archivo es .md y está en el blog, usa template.md
(define-auto-insert 
  '("\\.md\\'" . "Post de Hugo") 
  ["template.md" yas-expand-snippet])

;; --- 2. MOTOR DE EXTRACCIÓN DINÁMICA ---
(defun my-hugo-extract-metadata (type)
  "Busca metadatos (categories/tags) en Hugo, silencia errores y unifica en minúsculas."
  (let* ((posts-path (expand-file-name "content/post" blog-dir))
         ;; El comando Grep busca las líneas de metadatos, Sed limpia las comillas,
         ;; tr pasa a minúsculas y sort elimina duplicados.
         (cmd (format "grep -rPh -A 10 '^%s:' %s 2>/dev/null | grep '^  - \"' | sed -n 's/.*\"\\(.*\\)\".*/\\1/p' | tr '[:upper:]' '[:lower:]' | sort -u" 
                      type posts-path))
         (raw-output (shell-command-to-string cmd))
         (lines (split-string raw-output "\n" t)))
    ;; Filtro para limpiar posibles errores de Bash (ioctl, etc.) en entornos sin TTY
    (seq-filter (lambda (line) 
                  (not (or (string-match-p "bash:" line)
                           (string-match-p "ioctl" line)
                           (string-match-p "control de trabajos" line))))
                lines)))

;; --- 3. FUNCIONES DE INTERFAZ ---
(defun my-blog-select-categories-dynamic ()
  (completing-read "Categoría: " (my-hugo-extract-metadata "categories")))

(defun my-blog-select-tags-dynamic ()
  (let ((choices (completing-read-multiple "Etiquetas (SEP CON COMA): " 
                                           (my-hugo-extract-metadata "tags"))))
    (mapconcat (lambda (x) (concat "\n  - \"" x "\"")) choices "")))
```

### 2. La Plantilla: template.md
Este archivo es el corazón de la automatización que está guardado en la carpeta de plantillas configurado como auto-insert-directory. Fíjate que no usamos la función insert de Lisp, sino que dejamos que el código devuelva el valor directamente para evitar el aviso de error de Yasnippet.

``` elisp
---
title: "${1:Título}"
date: "`(format-time-string "%Y-%m-%d")`"
creation: "`(format-time-string "%Y-%m-%d")`"
description: "${2:Descripción}"
thumbnail: "images/`(file-name-base)`_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "`(my-blog-select-categories-dynamic)`"
tags: `(my-blog-select-tags-dynamic)`
draft: true
weight: 5
---
${3:Resumen de introducción}
<!--more-->
$0

![image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[link]: https://www.google.es

[image-01]: /images/`(file-name-base)`_01.jpg
```

### Puntos clave de esta solución
Adiós al Warning de Yasnippet: Al eliminar la función (insert ...) de las expresiones entre comillas invertidas, Yasnippet procesa el buffer de forma segura y limpia.

- Unificación de Caja: Gracias al comando tr '[:upper:]' '[:lower:]', todas tus etiquetas se sugieren en minúsculas. Se acabó tener etiquetas duplicadas como "Linux" y "linux".

- Independencia de Shell: El filtro de Lisp seq-filter elimina los mensajes de error de Bash sobre el control de procesos e ioctl, asegurando que tu lista de categorías sea pura.

- Consistencia de Imágenes: La función (file-name-base) vincula el nombre de la imagen al nombre del archivo .md, manteniendo tu carpeta de medios perfectamente organizada.


![image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[link]: https://www.google.es

[image-01]: /images/20260409_emacs_hugo_post_01.jpg


