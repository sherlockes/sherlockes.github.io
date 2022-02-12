---
title: "Mi uso de alias en bash"
date: "2022-02-12"
creation: "2022-02-12"
description: "Una forma sencilla de ahorrar tiempo a la hora de introducir comandos de alias en Bash"
thumbnail: "images/20220212_alias_bash_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: true
weight: 5
---
Si hay un comando que introducer muchas veces en la terminal y estas cansado de escribirlo todo entero todas las veces el uso de alias para Bash puede ayudarte.
<!--more-->
### Como crear un alias
Para usar los alias en bash sólo hay que seguir estos tres sencillos pasos
- Editar el archivo ~/.bashrc
- Añadir el nuevo alias -> alias nombre="comando"
- Habilitar los cambios ejecutando `source ~/.bashrc`

Para la mayoría de distribuciones existe o podemos crear un archivo ".bash_aliases" en la carpeta raiz de nuestro usuario donde incluir exclusivamente los alias para así no complicar el archivo ".bashrc". Esto se consigue gracias al siguiente código incluido en el archivo ".bashrc"

### Los alias que utilizo
- Realizar un Git Push
``` bash
alias gitup="git add . && git commit -m 'Update' && git push"
```
Asi sólo hay que ejecutar 'gitup' dentro de un repositorio para realizar un "push" sin la necesidad de incluir las tres líneas de código correspondientes.

- Lanzar el servidor de Hugo en la Raspberry
``` bash
alias hugoser="hugo server -D --bind=192.168.10.202 --baseURL=http://192.168.10.20$
```
El comando es largo y tedioso de escribir, gracias a `hugoser` resulta un placer.


### Enlaces de interés
- [Atatus - Bash aliases](https://www.atatus.com/blog/14-useful-bash-aliases-that-make-shell-less-complex-and-more-fun/)

[link]: https://www.google.es


[image-01]: /images/20220212_alias_bash_01.jpg
[image-02]: /images/20220212_alias_bash_02.jpg
[image-03]: /images/20220212_alias_bash_03.jpg
[image-04]: /images/20220212_alias_bash_04.jpg
[image-05]: /images/20220212_alias_bash_05.jpg
[image-06]: /images/20220212_alias_bash_06.jpg
[image-07]: /images/20220212_alias_bash_07.jpg
[image-08]: /images/20220212_alias_bash_08.jpg
[image-09]: /images/20220212_alias_bash_09.jpg
