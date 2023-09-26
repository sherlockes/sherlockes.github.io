---
title: "Título"
date: "aaaa-mm-dd"
description: "La batalla por corregir una fuga de agua en una cisterna Roca de doble pulsador."
thumbnail: "images/titulo_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Varios"
tags:
  - "Bricolaje"
draft: true
weight: 5
---
Un pequeño resumen del post a modo de introducción de como...
<!--more-->
El desarrollo...# Instalando Terminalizer

## Instalado Node.js
Parto de linux mint 19 y en la web de [Terminalizer] nos instan a primero instalar [Node.js] para lo cual sólo necesitaremos tres líneas de terminal y una cuarta para comprobar que la instalación se ha realizado correctamente.

``` bash
sudo apt-get install curl python-software-properties
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt-get install nodejs
node -v
```

 - La primera línea instala las utilizades de python necesarias para la instalación
 - La segunda línea añade el repositorio de la versión 10 LTS de Node.js a Linux Mint
 - La tercera realiza la instalación de Node.js mediante el repositorio
 - La cuarta comprueba la versión instalada de Node.js

## Instalando Terminalizer
Una solo línea basta para instalar Terminalizer
`npm install -g terminalizer`

# Grabando la Terminal


sudo terminalizer record prueba
sudo terminalizer render prueba
sudo ffmpeg -i prueba.gif -r 30 prueba.mp4

[Terminalizer]: https://terminalizer.com/install
[Node.js]: https://nodejs.org/en/
