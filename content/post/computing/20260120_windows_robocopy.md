---
title: "Salvado por Robocopy"
date: "2026-01-20"
creation: "2026-01-20"
description: "No había oído hablar de el pero esta utilidad me ha quitado un dolor de cabeza."
thumbnail: "images/20260120_windows_robocopy_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "windows"
draft: false
weight: 5
---
Hasta ayer no tenía ni idea de la existencia de [Robocopy] pero hoy me ha salvado de un buen rato de faena.
<!--more-->

Finalmente me he decidido a quitar Windows 7 de mi viejo Asus con i5 de 2ª generación. He dejado todos los datos susceptibles de ser útiles en una carpeta "Datos". En un primer intento de copiarla al nas se ha quedado colgada la copia sin terminar. En un segundo intento de copiarla a una unidad usb ha pasado lo mismo.

En vista de los problemas me decido a buscar utilidades de copia de archivos de forma segura pero las que encuentro en un primer momento son "infumables" hasta que doy con [Robocopy], una utilidad que además es nativa de Windows desde Windows 7.

Teniendo en cuenta que todos los datos a guardar están en "C:/Datos" y que la unidad usb donde los quiero guardar es "E:/", un simple comando desde la consola es capaz de obrar la magia:

```bash
robocopy "C:\Datos" "E:\Copia" /E /Z /R:3 /W:5
```

La utilidad reintenta 3 veces los archivos que le dan problemas y sigue adelante con el resto. Sin más.

![image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[Robocopy]: https://learn.microsoft.com/es-es/windows-server/administration/windows-commands/robocopy

[image-01]: /images/20260120_windows_robocopy_01.jpg



