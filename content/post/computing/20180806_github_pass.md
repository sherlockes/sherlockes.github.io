---
title: "Acceder a Github via ssh sin password"
date: "2023-08-07"
creation: "2018-07-27"
description: "Acceder a Github sin tener que poner el nombre de usuario y contraseña todas las veces"
thumbnail: "images/20180806_hugo_github_pass_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "git" 
draft: falstrue
weight: 5
---
__Actualización:__ Solucionando el problema desde el origen con un correcto clonado.

Como corregir los problemas de permisos de usuario al intentar actualizar un repositorio remoto que hemos clonado en nuestra máquina.
<!--more-->
### El problema
Llevo unos días adentrándome en el maravilloso mundo de [Github][1] del que hace un mes no tenía más idea que el de su mera existencia. En fin, pruebas y pruebas en las que estoy hasta el gorro de tener que introducir cada vez el nombre de usuario y contraseña cuando modifico los repositorios a través de ssh.

### La solución
Antes de nada nombrar que me conecto a [Github][1] a través de la Raspberry Pi en la que tengo alojada mi web y otros servicios. Nada de ratón ni interface gráfica, solo comandos de texto a través de la terminal cuando lo hago en Linux o con Putty cuando trabajo desde Windows. 


Ssh-keygen es un comando del protocolo ssh que podemos encontrar en sistemas unix para establecer conexiones de terminal seguras entre sistemas remotos a través de redes inseguras. La utilidad ssh-keygen es usada para generar, gestionar y convertir llaves de autentificación (authentication Keys) usando diferentes algoritmos de firma.


He seguido al pie de la letra las [instrucciones][2] para la conexión ssh y he conseguido [comprobar][3] la conexión que parece funciona con normalidad, pero cuando intento realizar alguna modificación del repositorio necesito introducir el nombre de usuario y contraseña de nuevo.


Después de muchas pruebas y fracasos he dado con el problema a través de un [post][4] de [Stackoverflow][5] en el que explica detalladamente todo el proceso de conexión mediante llaves ssh aunque me voy a ceñir solo a la parte que difiere con el método oficial de [Github][1].


* Comprobaremos la url remota de nuestro repositorio mediante el comando
'''
git remote show origin
'''

* Si exite una dirección del tipo "https://github.com/usuario/repositorio.git" habrá que cambiarla
por "git+ssh://git@github.com/usuario/repositorio.git" mediante el comando


'''
git remote set-url origin git+ssh://git@github.com/usuario/repositorio.git
'''

Y ya está, ahora ya puedo realizar modificaciones en mis repositorios de Github a través de ssh sin tener que estar continuamente introduciendo mi nombre de usuario y contraseña.

>Este problema no aparece si, cuando clonamos el repositorio remoto, usamos el comando `git clone git@github.com:tu_usuario/tu_repo.git` después de haber subido a github la llave ssh de nuestro equipo.


[1]: https://github.com
[2]: https://help.github.com/articles/connecting-to-github-with-ssh/
[3]: https://help.github.com/articles/testing-your-ssh-connection/
[4]: https://stackoverflow.com/questions/8588768/how-do-i-avoid-the-specification-of-the-username-and-password-at-every-git-push/36955408
-password-at-every-git-push/36955408
[5]: https://stackoverflow.com
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTI5ODE4MTgzN119
-->
