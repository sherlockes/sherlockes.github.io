---
title: "Migrando Hugo a Gitlab"
date: "2022-01-25"
creation: "2022-01-19"
description: "Que proceso he seguido en la migración del blos desde Github a Gitlab"
thumbnail: "images/20220119_migrando_gitlab_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "hugo"
tags:
- "git"
draft: false
weight: 5
---
Me dio pereza la migración de Github de este blog creado con [Hugo] en el momento que la compró Microsoft y ahora afronto el problema que ha sido más laborioso de lo previsto.
<!--more-->
El proceso puede parecer sencillo, pero me ha llevado tres días la migración de este blog desde Github a Gitlab.

> Antes de comenzar, apuntar que realizo el proceso en un pc con Linux Mint en el que tengo instalado Hugo y Git

### Creación de un nuevo proyecto
- Crear un nuevo proyecto desde la pantalla de inicio

![image-01]

- Seleccionar la creación desde una plantilla

![image-02]

- Hacer uso de la plantilla de Hugo para la creación del proyecto

![image-03]

- Ponemos el nombre y la descripción, lo segundo no es necesario, y creamos el proyecto. Aunque la página la queramos exponer al público el proyecto lo dejaremos como privado.

![image-04]

- Tras un proceso de importación nos aparecerá la página principal de nuestro proyecto con algunos archivos ya incluidos.

![image-05]

### Clonación de proyecto en local
- Copiaremos la dirección para clonar el repositorio mediante https

![image-06]

- Abriremos una sesión de terminal en el directorio donde queramos clonar el repositorio e introduciremos el siguiente comando:

``` bash
git clone https://gitlab.com/sherlockes/sherblog.git
```
Puesto que hemos declarado el proyecto como "Privado", [Gitlab] nos va a pedir el nombre de usuario y contraseña, si todo ha ido bien nos aparecerá algo como lo siguiente:

``` bash
sherlockes@imedia:~/temp$ git clone https://gitlab.com/sherlockes/sherblog.git
Clonando en 'sherblog'...
Username for 'https://gitlab.com': sherlockes
Password for 'https://sherlockes@gitlab.com': 
remote: Enumerating objects: 116, done.
remote: Total 116 (delta 0), reused 0 (delta 0), pack-reused 116
Recibiendo objetos: 100% (116/116), 1014.88 KiB | 8.39 MiB/s, listo.
Resolviendo deltas: 100% (6/6), listo.
```

### Configuración del tema
- Ahora es el momento de incluir el tema que deseemos. En mi caso utilizo [Mainroad] y lo instalaremos mediante el siguiente comando ejecutado dentro de la carpeta del repositorio

``` bash
git submodule add https://github.com/vimux/mainroad.git themes/mainroad
```

Ahora es el momento de indicar a [Hugo] el tema que tiene que utilizar cuando se realice la publicación editando el archivo "config.toml". Modificaremos la línea correspondiente al tema para que quede lo siguiente:

``` yaml
theme = "mainroad"
```

Comprobaremos que todo ha funcionado correctamente lanzando el servidor de [Hugo] mediante el siguiente comando de terminal en la raiz de nuestro repositorio

``` bash
hugo server
```

Si la construcción ha sido posible nos indicará una dirección del tipo "http://localhost:1313" que podemos abrir en el navegador para comprobar el resultado.

> Es posible que el cambio de tema nos de errores de publicación que podemos evitar sustituyendo el archivo "config.toml" y la carpeta "content" de la raiz de nuestro proyecto por los que aparecen dentro de la carpeta "exampleSite" que hay dentro de "themes/mainroad"

### Cambio de nombre del repositorio
Para que la dirección resultamente de nuestro proyecto sea del tipo "htps://usuario.gitlab.io" necesitamos cambiar el nombre y ruta al proyecto.

- El nombre lo cambiaremos desde dentro de nuestro proyecto en gitlab.io accediendo a "Settings - General" y cambiándolo por "tu_usuario.gitlab.io"

![image-07]

- Para cambiar la ruta desplegaremos el apartado "Advanced" dentro de "Settings - General" y modificaremos el Path para apuntar a "tu_usuario.gitlab.io"

![image-08]

- Tras los cambios en remoto hay que realizarlos en local para que el repositorio que previamente hemos clonado apunta al nuevo nombre. Para esto lanzaremos el siguiente comando de terminal desde la raiz del repositorio clonado en local.

``` bash
git remote set-url origin https://gitlab.com/tu_usuario/tu_usuario.gitlab.io.git
```

### Modificación de config.toml

Es imprescindible que los parámetros "baseurl" y "publishDir" estén correctamente configurados en el archivo "config.toml", lo editaremos y colocaremos:

``` toml
publishDir = "public"
baseurl = "https://tu_usuario.github.io"
```

Actualizaremos el repositorio lanzando los siguientes comandos en la raiz del mismo

``` bash
git add .
git commit -m "Modificación config.toml"
git push
```


Pasados un par de minutos ya podremos acceder a "https://tu_usuario.gitlab.io"

### Incluyendo un dominio personalizado
Accederemos al apartado "Pages" dentro del menú "Settings" de nuestro proyecto en la página de Gitlab.io y añadiremos un nuevo dominio.

![image-09]

Pondremos el nombre del dominio que tenemos comprado y lo crearemos

![image-10]

Ahora toca editar los registros DNS desde el panel de control del gestor de dominios para el dominio que tengamos en posesión.


| HOSTNAME                        | TYPE  | ADDRESS / VALUE                                                 | DISTANCE/PRIO | TTL   | SERVICE   |
| -----                           | ----- | -----                                                           | -----         | ----- | -----     |
|                                 | A     | 35.185.44.232                                                   | NA            | 3600  | 3rd-party |
| www                             | CNAME | tu_usuario.gitlab.io                                            | NA            | 3600  | 3rd-party |
| _gitlab-pages-verification-code | TXT   | gitlab-pages-verification-code=123456789 | NA            | 7207  | 3rd-party |

Introduciremos estos tres registros
- Uno de tipo "A" para redireccionar el dominio a la IP de Gitlab
- Uno de "CNAME" para redireccionar www al contenido de nuestro proyecto
- Uno de tipo "TXT" para verificar el dominio

Guardaremos los cambios y pasados unos minutos ya podremos verificar el dominio desde la página del proyecto en Gitlab mediante el botón de "Reintentar la verifcación"

![image-11]

A partir de aquí una larga espera para que se propague por todos los servidores de DNS la ip a la que debe apuntar nuestro dominio que puedes ir comprobando desde [DNSChecker] el registro "A" de nuestro dominio hasta confirmar que todos los servidores apuntan a la ip de Gitlab.

![image-12]



### Enlaces de interés
- [Xaeroborg - Hugo Gitlab](https://xaeroborg.gitlab.io/posts/hugo-gitlab/)
- [GitLab - Custom Domains](https://docs.gitlab.com/ee/user/project/pages/custom_domains_ssl_tls_certification/)
- [GitLab - Ssh Keys](https://docs.gitlab.com/ee/ssh/)

[DNSChecker]: https://dnschecker.org
[Github]: https://github.com
[Gitlab]: https://gitlab.com
[Hugo]: https://gohugo.io
[Mainroad]: https://github.com/Vimux/Mainroad

[image-01]: /images/20220119_migrando_gitlab_01.jpg
[image-02]: /images/20220119_migrando_gitlab_02.jpg
[image-03]: /images/20220119_migrando_gitlab_03.jpg
[image-04]: /images/20220119_migrando_gitlab_04.jpg
[image-05]: /images/20220119_migrando_gitlab_05.jpg
[image-06]: /images/20220119_migrando_gitlab_06.jpg
[image-07]: /images/20220119_migrando_gitlab_07.jpg
[image-08]: /images/20220119_migrando_gitlab_08.jpg
[image-09]: /images/20220119_migrando_gitlab_09.jpg
[image-10]: /images/20220119_migrando_gitlab_10.jpg
[image-11]: /images/20220119_migrando_gitlab_11.jpg
[image-12]: /images/20220119_migrando_gitlab_12.jpg
