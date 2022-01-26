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
- Crear un repositorio para el contenido sin construir

- En una carpeta en local poner el contenido de la web

- Añadir la llave ssh a github



``` bash
git init
git remote add origin git@github.com:sherlockes/blog.git
git add --all
git commit -m "Commit MSG"
git push origin master
```

- Añadir el tema
``` bash
git submodule add https://github.com/vimux/mainroad.git themes/mainroad
git submodule update --init --recursive
git push origin master
```

Crear un [Token](https://github.com/settings/tokens/new) con acceso completo a los repositorios

```
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
```

- Crear la acción
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

![image-01]

### Enlaces de interés
- [Ruddra - Static site with Hugo & Github actions](https://ruddra.com/hugo-deploy-static-page-using-github-actions/)

[link]: https://www.google.es

[image-01]: /images/20220126_hugo_github_01.jpg
