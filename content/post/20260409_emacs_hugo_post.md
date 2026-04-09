---
title: "Creación de un post de Hugo desde emacs"
date: "2026-04-09"
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
Para centrarte en escribir, el proceso de publicación no tiene que suponer una barrera. Así he configurado emacs para optimizar la creación de post para el blog con la mínima fricción posible.
<!--more-->

Si gestionas un blog con **Hugo**, sabrás que mantener la consistencia de las etiquetas y categorías es un reto. Hoy vamos a configurar un flujo de trabajo en **Emacs** que hace todo el trabajo por nosotros, utilizando tres pilares: `auto-insert`, `yasnippet` y `Lisp`.

## El Flujo de Trabajo
El sistema funciona como una reacción en cadena:
1. **Creación**: Al crear un nuevo archivo `.md` en la carpeta de tu blog y cuyo nombre empiece por una fecha, Emacs activa `auto-insert`.
2. **Inyección**: `auto-insert` busca una plantilla física (`template.md`) y la inyecta en el buffer vacío.
3. **Expansión**: Inmediatamente, se llama a `yasnippet` para que procese el contenido.
4. **Inteligencia**: El código Lisp dentro de la plantilla ejecuta comandos de terminal para leer los posts antiguos y ofrecer categorías y etiquetas reales en un menú desplegable.

### 1. Configuración en `init.el`

Primero, preparamos a Emacs para que reconozca cuándo debe actuar y definimos el "cerebro" que extraerá la información de tus posts. En el archivo `init.el` tengo definido lo siguiente.

``` elisp
;; =============================================================================
;; CONFIGURACIÓN DE AUTO-INSERT Y YASNIPPET
;; =============================================================================

(auto-insert-mode)                                      ;; Habilitar Auto-insert
(setq auto-insert-directory "~/dotfiles/templates/")    ;; Carpeta de plantillas
(setq auto-insert-query nil)                            ;; No preguntar, insertar siempre

;; Función que conecta Auto-insert con Yasnippet
(defun autoinsert-yas-expand()
    "Reemplaza el texto en una plantilla de yasnippet."
    (yas/expand-snippet (buffer-string) (point-min) (point-max))
    (save-buffer))

;; Regla: Si el nombre del archivo empieza por fecha (20xxxxxx_...), usa template.md
(setq auto-insert-alist '(
    (("20[0-9]\\{6\\}_.+\\.md\\'" . "Markdown") . ["template.md" autoinsert-yas-expand])
    ))

;; =============================================================================
;; EXTRACCIÓN DINÁMICA DE CATEGORÍAS Y TAGS
;; =============================================================================

(defun my-hugo-extract-metadata (type)
  "Busca metadatos en Hugo, silencia errores y unifica en minúsculas."
  (let* ((posts-path (expand-file-name "content/post" blog-dir))
         ;; Comando: busca metadatos, limpia comillas, unifica minúsculas y ordena
         (cmd (format "grep -rPh -A 10 '^%s:' %s 2>/dev/null | grep '^  - \"' | sed -n 's/.*\"\\(.*\\)\".*/\\1/p' | tr '[:upper:]' '[:lower:]' | sort -u" 
                      type posts-path))
         (raw-output (shell-command-to-string cmd))
         (lines (split-string raw-output "\n" t)))
    ;; Filtro para eliminar avisos de Bash (ioctl, etc.) en procesos sin TTY
    (seq-filter (lambda (line) 
                  (not (or (string-match-p "bash:" line)
                           (string-match-p "ioctl" line)
                           (string-match-p "control de trabajos" line))))
                lines)))

(defun my-blog-select-categories-dynamic ()
  "Selector de categoría única."
  (completing-read "Categoría: " (my-hugo-extract-metadata "categories")))

(defun my-blog-select-tags-dynamic ()
  "Selector múltiple de etiquetas."
  (let ((choices (completing-read-multiple "Etiquetas (SEP CON COMA): " (my-hugo-extract-metadata "tags"))))
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

> Gracias al comando tr '[:upper:]' '[:lower:]', todas lass etiquetas se sugieren en minúsculas. Se acabó tener etiquetas duplicadas como "Linux" y "linux".


pepe


![image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[link]: https://www.google.es

[image-01]: /images/20260409_emacs_hugo_post_01.jpg


