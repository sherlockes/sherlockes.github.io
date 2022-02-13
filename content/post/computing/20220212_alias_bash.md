---
title: "Mi uso de alias en bash"
date: "2022-02-13"
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
draft: false
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

``` bash
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
```
> Si además este archivo de alias lo tenemos guardado dentro de nuestra configuración de "Dotfiles" tal y como expliqué en este [post] tendremos actualizados estos comandos en todos los equipos.

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
- [Atareao - Terminal con alias](https://atareao.es/software/utilidades/mejorando-el-terminal-de-ubuntu-con-alias/)
- [Atatus - Bash aliases](https://www.atatus.com/blog/14-useful-bash-aliases-that-make-shell-less-complex-and-more-fun/)

[link]: https://www.google.es
[post]: {{< relref "20210416_dotfiles.md" >}}
