---
title: "Synology broken sudo"
date: "2021-06-03"
creation: "2021-06-03"
description: "Como me he recuperado del pánico al corromper el archivo sudoers de mi synology"
thumbnail: "/images/20210603_synology_broken_sudo_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "synology"
draft: false
weight: 5
---
Una simple modificación del archivo "sudoers" en mi Synology Ds920+ se podía haber convertido en una completa reinstalación del sistema operativo de no encontrar esta simple solución.
<!--more-->

Para apagar el NAS de forma remota desde la terminal mediante un script me he visto en la necesidad de modificar el archivo "/etc/sudoers" mediante nano y un acceso ssh al Ds920+. Pues bien, lo que en pantalla parecía un ajuste de línea ha resultado ser un salto de línea que ha dado al traste con la configuración y funcionamiento de "sudo".

De esta forma al usar el comando "sudo" aparece el siguiente error.

```
>>> /etc/sudoers: syntax error near line 22 <<<
>>> /etc/sudoers: syntax error near line 23 <<<
sudo: parse error in /etc/sudoers near line 22
sudo: no valid sudoers sources found, quitting
sudo: unable to initialize policy plugin
```

A priori la solución parace fácil, te logeas como "root", dejas el archivo "/etc/sudoers" como estaba y arreglado. Pero en Synology DSM6 no es tam fácil y es que no es posible (o yo no he conseguido hacerlo) loguearse directamente como "root" desde una terminal remota mediante ssh y sólo es posible logueandose con un usuario administrador y ejecutando `sudo -i`. Pero claro, resulta que sudo no funciona...

Navegando un rato por la red y probando varias alternativas, al fin he dado con la que a mi me ha funcionado. Reside en los siguientes pasos.

- Acceder al "Panel de control" de DSM
- Entrar el en "Programador de tareas"
- Crear una nueva tarea programada basada en un script de usuario
- Nombrar la tarea (asegurarse que se ejecuta como root)
- En configuración de tarea añadir `chmod 0447 /etc/sudoers`
- Guardar la tarea
- Ejecutar la tarea

Con esto ya estamos en condiciones de loguearnos con nuestro usuario a través de ssh y arreglar el desaguisado en el archivo "/etc/sudoers". Cuando lo tengamos reparado ya se pueden devolver los privilegios originales al archivo mediante:

- Acceder al "Panel de control" de DSM
- Entrar el en "Programador de tareas"
- Crear una nueva tarea programada basada en un script de usuario
- Nombrar la tarea (asegurarse que se ejecuta como root)
- En configuración de tarea añadir `chmod 0440 /etc/sudoers`
- Guardar la tarea
- Ejecutar la tarea
- Eliminar la tarea

Una solución rápida que me ha quitado de encima varias horas de trabajo.

Links:
https://community.synology.com/enu/forum/17/post/93278?reply=316277


![image_01]

[link]: https://www.google.es

[image-01]: /images/20210603_synology_broken_sudo_01.jpg
