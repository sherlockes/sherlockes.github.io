---
title: "Mi casa inteligente desde cero"
date: "2023-11-14"
creation: "2023-11-14"
description: "Paso a paso como construyo mi casa inteligente en la Raspberry con Home Assistant."
thumbnail: "images/20231114_my_smart_home_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "home assistant"
draft: true
weight: 5
---
Resumen de introducción
<!--more-->
### Instalando Debian 12
[link](https://community.home-assistant.io/t/installing-home-assistant-supervised-on-a-raspberry-pi-using-debian-12/247116 "Home assistant supervisado")

En la guía está descrito para la instalación con monitor y teclado. Para hacerlos sin periféricos en modo "headless" antes de poner el usb en la Raspberry hay que:
 - Acceder a la partición "RASPIFIRM"
 - Editar el archivo "sysconf.txt"
 - Descomentar la línea "#root_authorized_key="
 - A continuación incluir nuestra llave pública
 - Guardar el archivo
 - Sacar la memoria usb y ponerla en la Raspberry

![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[link]: https://www.google.es

[image-01]: /images/20231114_my_smart_home_01.jpg



