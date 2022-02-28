---
title: "Como desinstalar paquetes en Emacs"
date: "2022-02-27"
creation: "2022-02-27"
description: "Como desinstalar paquetes y dependencias en Emacs"
thumbnail: "images/20220227_emacs_package_delete_00.jpg"
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
En [Emacs] es sencillo repetir las cosas pero muchas de ellas la primera vez son difíciles de llevar a cabo. Aquí dejo el método para desinstalar tanto paquetes como las dependecias de los mismos.
<!--more-->
Tras un tiempo utilizando [Emacs] te puedes encontrar con que has instalado paquetes que ya no utilizas o que han quedado obsoletos. Para evaluar y corregir este problema sólo hay que seguir los siguientes pasos.

- El primer paso es listar todos los paquetes que tenemos disponibles en nuestra configuración de [Emacs] según los repositorios que tengamos añadidos en nuestra lista de archivo de paquetes. para obtener esta lista pulsaremos "Alt + x" e introduciremos el comando "package-list".

```
M-x package-list
```
- Con el buffer de paquetes en la pantalla los ordenaremos según su estado pulsando en la columna "Status" y nos situaremos al principio del mismo mediante la combinación de teclas "Alt + <". De esta forma el estado de los paquetes se habrá ordenado de forma alfabética.

![image-02]

- Ahora vamos a buscar los paquetes que tenemos instalados para lo cual utilizaremos la combinación de teclas "Ctrl + s" e introduciremos la palabra "installed".
```
C-s installed
```
Volveremos a pulsar la combinación de teclas "Ctrl + s" tantas veces como sea necesario hasta que lleguemos a un "installed" que aparezca en la columna "Status" y entonces pulsaremos "intro".

![image-01]

- Nos situamos sobre la línea correspondiente al paquete que vamos a desinstalar y pulsamos la tecla "d". Con esto habremos marcado el paquete para su eliminación.

> Es posible marcar varios paquetes para eliminar sin más que sobre la línea correspondiente volver a pulsar "d".

- Con el paquete para eliminar seleccionado pulsaremos la tecla "x" para ejecutar lo marcado

- Ya tenemos el paquete desinstalado, ahora para eliminar las dependencias usaremos el comando

```
M-x package-autoremove
```

### Resto de comandos del buffer de lista de paquetes

| Tecla       | Comando                    |
| ----------- | -----------                |
| i           | Marcar para instalar       |
| d           | Marcar para eliminar       |
| x           | Ejecutar lo marcado        |
| f           | filtrar                    |
| n           | Pasar al siguiente paquete |
| p           | Volver al paquete anterior |
| h           | Ocultar paquete            |
| (           | Alternar ocultos/visibles  |
| r           | Refrescar cotenido         |
| g           | Actualizar lista           |

### Enlaces de interés
- [Emacs - Packages](https://www.gnu.org/software/emacs/manual/html_node/emacs/Packages.html)

[Emacs]: https://www.gnu.org/software/emacs/


[image-01]: /images/20220227_emacs_package_delete_01.jpg
[image-02]: /images/20220227_emacs_package_delete_02.jpg
