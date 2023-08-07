---
title: "Sincronizando Org-Roam mediante Github en Emacs"
date: "2023-08-06"
creation: "2023-08-06"
description: "Este es el método que utilizo para poder acceder desde varios equipos a mi base de conocimiento en Org-Roam para Emacs."
thumbnail: "images/20230806_emacs_org_roam_github_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "computing"
tags:
- "github"
- "emacs"
- "org-roam"
draft: true
weight: 5
---
Está muy bien tener una base de conocimiento centralizada en una carpeta y gestionarla mediante [Org-Roam] pero mejor aun está poder acceder y modificar esta carpeta desde varios equipos gracias a un repositorio de [Github].
<!--more-->
Desde hace un tiempo, he intentado varias veces crear con mis notas una base de conocimiento en [Emacs] mediante [Org-Roam] pero la primera rampa de la curva de aprendizaje me había resultado muy dura y lo había dejado de lado todas las veces. Al fin creo que lo he conseguido.

### Crear el repositorio
Una de las principales características que debe tener esta base de conocimiento es que sea accesible por cualquiera y desde cualquier lugar por lo que el primer paso es crear un repositorio público en [Github]. En mi caso lo he llamado "org-roam"

![image-01]

### Copiar la llave ssh
Para poder editar desde nuestro equipo el repositorio que hemos creado en [Github] necesitamos subir al servidor nuestra llave pública. Consiste copiar el contenido del archivo "/home/sherlockes/.ssh/id_rsa.pub" y añadirlo como una "SSH key" dentro del apartado "SSH and GPG keys" de la configuración de nuestra cuenta de [Github]

>En caso de que no exista el archivo "id_rsa.pub" en nuestro archivo generaremos una nueva llave con el comando `ssh-keygen`.

Este paso es imprescindible ya que [Github] no permite la modificación de un repositorio desde la consola de un equipo remoto a través de la identificación mediante usuario y contraseña.

### Clonar en repositorio en nuestro equipo


### Enlaces de interés
- [enlace](www.sherblog.pro)

[Emacs]: https://www.gnu.org/software/emacs/
[Github]: https://github.com
[Org-Roam]: https://www.orgroam.com


[image-01]: /images/20230806_emacs_org_roam_github_01.jpg
[image-02]: /images/20230806_emacs_org_roam_github_02.jpg



