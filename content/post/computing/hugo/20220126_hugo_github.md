---
title: "Hugo con Github actions"
date: "2022-01-27"
creation: "2022-01-26"
description: "Como instalar la página desarrollada en Hugo con Github Actions"
thumbnail: "images/20220126_hugo_github_00.jpg"
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
Durante mucho tiempo he tenido alojado este blog en [GitHub] pero la publicación se realizaba en local mediante la Raspberry. Ahora voy a generar la publicación del blog a partir de un propio repositorio mediante las [acciones de GitHub]
<!--more-->
### Creando el repositorio en GitHub
El primer paso es crear un nuevo repositorio público en [GitHub], para que la direción resultamente sea mucho más sencilla, le pondremos el nombre "usuario.github.io"

![image-01]

### Preparando el contenido en local
Tenemos el contenido a partir del cual generamos la página en una carpeta. Eliminamos la carpeta "themes" y todo el rastro de git en caso de que haya sido un repositorio anterior tal y como aparece seleccionado en la siguiente imagen:

![image-02]

### Añadir la llave ssh a github
Para que el desarrollo sea más sencillo añadiremos una llave ssh del equipo desde el que vamos a publicar a la configuración personal, no a la del repositorio, de nuestra cuenta de [GitHub].

![image-03]

> En linux es tan sencillo como ejecutar el comando `ssh-keygen -t rsa` y copiar el contenido del archivo ".ssh/id_rsa.pub" generado.

### Creando la acción de publicación
Este punto es la clave de todo el proceso ya que nos permitirá que la web se publique automáticamente cada vez que actualizamos el repositorio. Según lo expuesto en el artículo "[Host on Github]" situados en la carpeta local deberemos:

- Crear una carpeta llamada ".github"
- Dentro de la anterior crear una carpeta "workflows"
- Dentro de "workflows" crear un archivo "gh-pages.yml"

El contenido del arhcivo será el siguiente:

``` yml
name: github pages

on:
  push:
    branches:
      - main  # Set a branch to deploy
  pull_request:

jobs:
  deploy:
    runs-on: ubuntu-20.04
    steps:
      - uses: actions/checkout@v2
        with:
          submodules: true  # Fetch Hugo themes (true OR recursive)
          fetch-depth: 0    # Fetch all history for .GitInfo and .Lastmod

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: 'latest'
          # extended: true

      - name: Build
        run: hugo --minify

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        if: github.ref == 'refs/heads/main'
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
```

### Inicializando el repositorio
Desde la carpeta local en la que tenemos el contenido de la web ejecutaremos la siguiente secuencia de comandos:

``` bash
git init
git submodule add https://github.com/vimux/mainroad.git themes/mainroad
git commit -m "Primer Commit"
git branch -M main
git remote add origin git@github.com:sherlockes/sherlockes.github.io.git
git push -u origin main
```

- Inicializar el repositorio
- Añadir el tema a través de un submódulo
- Crear el primer Commit
- Renombrar la rama principal a "main"
- Enlazar la carpeta con el repositorio remoto
- Subir el contenido al repositorio remoto

En este momento podremos ver en la pestaña "Actions" de nuestro proyecto en [GitHub] como se han ejecutado un par de ellas:

![image-04]

Con estas aciones se ha creado una nueva rama llamada "gh-pages" en el repositorio con el contenido tras la publicación en Hugo de la rama "main" del repositorio

### Configuración de GitHub Pages
Desde el menú "Settings" de nuestro repositorio accederemos al menú "Pages" para seleccionar como fuente la rama "gh-pages" y guardar los cambios.

![image-05]

Si todo ha ido bien, ya podemos acceder al contenido de la página desde "usuario.github.io"

### Configuración de un dominio personalizado
Accederemos al panel de control del registrador de dominios al que le hayamos comprado el mismo y editaremos los registros DNS para que queden como lo siguiente:


| HOSTNAME | TYPE  | ADDRESS / VALUE      | DISTANCE/PRIO | TTL   | SERVICE   |
| -----    | ----- | ------               | -----         | ----- | -----     |
|          | A     | 185.199.108.153      | NA            | 3603* | 3rd-party |
|          | A     | 185.199.109.153      | NA            | 3603* | 3rd-party |
|          | A     | 185.199.110.153      | NA            | 3603* | 3rd-party |
|          | A     | 185.199.111.153      | NA            | 3603* | 3rd-party |
| www      | CNAME | sherlockes.github.io | NA            | 3603* | 3rd-party |

Le daremos unas horas para que se propague la información por todos los servidores de DNS y accederemos al menú "Pages" dentro de los ajustes de nuestro repositorio en [GitHub] para introducir y comprobar la información de este dominio.

![image-06]

Y con esto ya tenemos todo listo.

### Enlaces de interés
- [Ruddra - Static site with Hugo & Github actions](https://ruddra.com/hugo-deploy-static-page-using-github-actions/)
- [Codenanshu - Hugo & Github actions](https://www.youtube.com/watch?v=psyz4UPnGAA)
- [Gohugo.io - Host on GitHub](https://gohugo.io/hosting-and-deployment/hosting-on-github/)

[acciones de GitHub]: https://github.com/features/actions
[GitHub]: https://github.com
[Host on Github]: https://gohugo.io/hosting-and-deployment/hosting-on-github/

[image-01]: /images/20220126_hugo_github_01.jpg
[image-02]: /images/20220126_hugo_github_02.jpg
[image-03]: /images/20220126_hugo_github_03.jpg
[image-04]: /images/20220126_hugo_github_04.jpg
[image-05]: /images/20220126_hugo_github_05.jpg
[image-06]: /images/20220126_hugo_github_06.jpg
