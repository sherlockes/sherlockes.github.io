---
title: "Título"
date: "aaaa-mm-dd"
creation: "aaaa-mm-dd"
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
Esta es la crónica de mis vivencias en Hugo desde el primer día trabajando sobre una instalación de Linux Mint en un antiguo portatil.

Empezamos con la instalación de Hugo para Linux
```
sudo apt-get install hugo
```
Resulta que la versión es muy vieja tal y como se puede ver en la siguiente captura ya que en el momento de la instalación la última release es la 0.47.1
```
sherlockes@easynote ~ $ hugo version
Hugo Static Site Generator v0.16-DEV BuildDate: 2016-02-06T18:15:56+01:00
```

Toca desinstalar ahora

```
sudo apt purge hugo
```

Opto por la instalación a través de la paquetería snap pero parece que por defecto Linux Mint no viene con la paquetería snap instalada por defecto así que tengo que instalar las dos cosas mediante el comando
```
sudo apt install snapd && snap install hugo
```

En un primer momento parece que no funciona pero después de reiniciar el equipo ya está todo correcto con la última versión disponible de Hugo de Agosto de 2018

```
sherlockes@easynote ~ $ hugo version
Hugo Static Site Generator v0.47.1 linux/386 BuildDate: 2018-08-24T17:33:57Z
```

