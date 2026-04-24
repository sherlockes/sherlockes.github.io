---
title: "Mi nuevo init.el en 2026"
date: 2026-04-25
creation: "2026-04-25"
description: "He actualizado mi init.el para hacerlo más fluido y moderno"
thumbnail: "images/20260425_new_init_el_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags: 
- "emacs"
- "lisp"
draft: true
weight: 5
---
Resumen de introducción

<!--more-->

## Resumen del nuevo `init.el` (Emacs Sherlo 2026)

Has reconstruido tu configuración sobre **Emacs 30** con una base moderna, limpia y compatible, manteniendo casi todo lo valioso del sistema antiguo.

---

# 1. Arquitectura general

## Base moderna

* GNU Emacs
* gestor de paquetes straight.el
* configuración declarativa con use-package

## Inicio optimizado

* `early-init.el`
* arranque maximizado
* carga rápida
* interfaz limpia desde el inicio

## Sincronización inteligente

En dotfiles sincronizados:

```text
~/dotfiles/emacs/.emacs.d/
```

Contiene solo:

* `init.el`
* `early-init.el`
* snippets
* bookmarks
* archivos importantes

Local en cada equipo:

```text
~/.emacs.d/
```

solo caché, builds y datos temporales.

---

# 2. Interfaz y experiencia de uso

## Arranque

Emacs abre:

* maximizado
* pantalla dividida verticalmente

### Izquierda:

dashboard

### Derecha:

buffer `*Messages*`

## Dashboard muestra

* archivos recientes
* bookmarks sincronizados
* texto informativo con atajos principales

## Atajo rápido

```text
C-<escape>
```

reabre dashboard inteligentemente:

* dashboard izquierda
* buffer actual derecha

---

# 3. Navegación y edición

## Minibuffer moderno

* ivy
* counsel
* swiper

## Atajos

```text
M-x        counsel-M-x
C-x C-f    abrir archivo mejorado
C-s        búsqueda Swiper
C-c s      ripgrep
```

## Dired mejorado

* navegación cómoda
* directorios primero
* ocultar detalles
* papelera al borrar

## Gestión de buffers

```text
C-x C-b
```

abre `ibuffer`

## Shell rápida

```text
C-c t
```

---

# 4. Escritura y texto

## Ortografía

* español por defecto
* cambio ES/EN

Atajos:

```text
F5   flyspell on/off
F7   cambiar diccionario
```

## Activación automática en:

* Org
* Markdown

## Líneas suaves

* `visual-line-mode`

## Números de línea

* relativos

---

# 5. Snippets y plantillas

## yasnippet

Snippets cargados desde:

```text
~/dotfiles/emacs/.emacs.d/snippets/
```

## Auto-insert

### Scripts `.sh`

Al crear nuevo archivo:

* shebang
* nombre archivo
* fecha
* estructura inicial

Y al guardar:

* permisos ejecutables automáticos

### Markdown blog

Archivos nuevos dentro del repo del blog usan snippet:

```text
post
```

---

# 6. Git y multi-PC workflow

## Pull automático al arrancar

Sincroniza repos personales:

* SherloScripts
* Blog
* Brain

## Guardado inteligente

Al guardar archivos dentro de esos repos:

* `git add`
* commit automático
* push automático

Ideal para trabajar desde varios PCs.

---

# 7. Sistema personal de conocimiento

## Org Mode completo

* bloques de código
* Python / Shell en Babel
* edición mejorada

## Org-roam

Repositorio de notas:

```text
~/brain/org-files/
```

## Funciones activas

* buscar nodos
* insertar enlaces
* capturar notas
* graph
* backlinks

## Atajos

```text
C-c n f   buscar nota
C-c n i   insertar nodo
C-c n g   graph
```

## Visualización

org-roam-ui

```text
F2
```

---

# 8. Blog Hugo avanzado

## Integración con Hugo

## Posts nuevos desde Emacs

Plantilla automática con snippet.

## Nube dinámica de categorías y tags

Lee posts existentes y ofrece autocompletado para:

* categorías
* etiquetas

Muy potente para mantener consistencia del blog.

---

# 9. Atajos globales actuales

```text
F1   Reiniciar Emacs
F2   Org-roam UI
F5   Ortografía on/off
F7   Cambiar diccionario
C-ESC Dashboard
C-x C-b Ibuffer
C-c s Ripgrep
C-c t Shell
```

---

# 10. Filosofía del sistema

Tu nuevo `init.el` mantiene lo mejor del antiguo:

* productividad real
* automatizaciones personales
* blogging desde Emacs
* notas conectadas
* multi-PC

pero ahora es:

### más limpio

### más rápido

### más moderno

### más mantenible

### más compatible

### más fácil de ampliar

---

# Veredicto final

Ya no tienes “un init.el”.

Tienes un **entorno personal de trabajo completo en Emacs**.


![image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[link]: https://www.google.es

[image-01]: /images/20260425_new_init_el_01.jpg
