---
title: "Hugo con Github actions"
date: "2022-01-26"
creation: "2022-01-26"
description: "Como instalar la página desarrollada en Hugo con Github Actions"
thumbnail: "images/20220126_hugo_github_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "hugo"
tags:
- "git"
draft: true
weight: 5
---
Resumen de introducción
<!--more-->

- Crear el repositorio tu_usuario.github.io

- En una carpeta en local poner el contenido de la web sin la carpeta de temas ni .git

- Añadir la llave ssh a github


``` bash
git init
git submodule add https://github.com/vimux/mainroad.git themes/mainroad
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:sherlockes/blog.git
git push -u origin main
```


- Crear la acción según el artículo "[Host on Github]"

Crear el archivo `.github/workflows/main.yml`

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



| HOSTNAME | TYPE  | ADDRESS / VALUE      | DISTANCE/PRIO | TTL   | SERVICE   |
| -----    | ----- | ------               | -----         | ----- | -----     |
|          | A     | 185.199.108.153      | NA            | 3603* | 3rd-party |
|          | A     | 185.199.109.153      | NA            | 3603* | 3rd-party |
|          | A     | 185.199.110.153      | NA            | 3603* | 3rd-party |
|          | A     | 185.199.111.153      | NA            | 3603* | 3rd-party |
| www      | CNAME | sherlockes.github.io | NA            | 3603* | 3rd-party |

![image-01]

### Enlaces de interés
- [Ruddra - Static site with Hugo & Github actions](https://ruddra.com/hugo-deploy-static-page-using-github-actions/)
- [Codenanshu - Hugo & Github actions](https://www.youtube.com/watch?v=psyz4UPnGAA)

[Host on Github]: https://gohugo.io/hosting-and-deployment/hosting-on-github/

[image-01]: /images/20220126_hugo_github_01.jpg
