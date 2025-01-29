---
title: "Actualizar fecha de archivo en emacs"
date: "2025-01-29"
creation: "2025-01-29"
description: "Un método sencillo para actualizar la fecha de actualización dentro de un archivo gracias a elisp y emacs"
thumbnail: "images/20250129_emacs_update_file_date_00.jpg"
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
Tener que modificar la fecha de actualización de la cabecera de un archivo cada vez que se realiza una modificación es una tarea "rutinaria" que debe ser automatizada si no queremos perder el tiempo ni que caiga en el olvido. Así lo he conseguido gracias a elisp en emacs.
<!--more-->
En un principio son tres los tipos de archivos a los que necesito actualizar la fecha de modificación y en cada uno está escrita de una manera:

- Archivos Markdown del blog: date: "2025-01-29"
- Archivos Org-Mode del brain: #+date: <2025-01-29>
- Scripts en Bash: #Creation/Update: 20240411/20250129

![image-01]

``` elisp
(defun update-file-date ()
  "Actualizar la fecha de modificación según la extensión del archivo."
  (let ((ext (file-name-extension (buffer-file-name)))
        (current-date (format-time-string "%Y-%m-%d"))
        (current-date-compact (format-time-string "%Y%m%d")))
    (save-excursion
      (goto-char (point-min))
      (cond
       ;; Para archivos .sh: #Creation/Update: YYYYMMDD/YYYYMMDD
       ((string= ext "sh")
        (when (re-search-forward "^#Creation/Update: \\([0-9]+\\)/\\([0-9]+\\)$" nil t)
          (replace-match (format "#Creation/Update: %s/%s" (match-string 1) current-date-compact))))

       ;; Para archivos .md: date: "YYYY-MM-DD"
       ((string= ext "md")
        (when (re-search-forward "^date: \"\\([0-9-]+\\)\"$" nil t)
          (replace-match (format "date: \"%s\"" current-date))))

       ;; Para archivos .org: #+date: <YYYY-MM-DD>
       ((string= ext "org")
        (when (re-search-forward "^#\\+date: <\\([0-9-]+\\)>$" nil t)
          (replace-match (format "#+date: <%s>" current-date))))))))

(add-hook 'before-save-hook 'update-file-date)
```

### Enlaces de interés
- [enlace](www.sherblog.pro)

[link]: https://www.google.es

[image-01]: /images/20250129_emacs_update_file_date_01.jpg



